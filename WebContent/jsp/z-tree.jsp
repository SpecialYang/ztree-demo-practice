<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${path}/jq/jquery-3.2.0.min.js"></script>
<script type="text/javascript" src="${path }/Z-Tree/jquery.ztree.core.js"></script>
<script type="text/javascript" src="${path }/Z-Tree/jquery.ztree.excheck.js"></script>
<script type="text/javascript" src="${path }/Z-Tree/jquery.ztree.exedit.js"></script>
<link rel="stylesheet" href="${path}/css/zTreeStyle/zTreeStyle.css" type="text/css"/>
<title>Insert title here</title>
<style type="text/css">
.title{
 	 margin: 30px 30px;
  font-size:15px;
}
#tree{
 margin: 30px 30px;
}
.ztree li span.button.add {
margin-left:2px; 
margin-right: -1px; 
background-position:-144px 0;
 vertical-align:top; 
 *vertical-align:middle
 }
</style>
</head>
<script>
	var zTree;
	var selectNode;
	var load = false;
	$(function(){
		zTree = $.fn.zTree.init($("#treeDemo"), setting);
	})
    
    var setting = {
			async : {
				enable : true, 
				dataType : "text",
				type : "post",
				url :  "${path}/CityNodeServlet?timestamp="+ new Date().getTime(), //请求节点生成的servlet
				autoParam : [ "id" ]   //每次异步加载传给服务器的参数
			},
			view : {
				dblClickExpand : true,
				selectedMulti:false,
				addHoverDom: addHoverDom,        //添加按钮
				removeHoverDom: removeHoverDom
			}, 
			edit: {               
				enable: true,                       //编辑节点必须设置该字段，并且编辑状态包括修改和删除，所以如果设置true
				editNameSelectAll : true,           //删除按钮和修改按钮都会出现，添加按钮需要自己额外添加
				showRenameBtn : true,               // 默认值就是true,可以不写的
				showRemoveBtn: showRemoveBtn,       //选做，可以删除这一行
				//高级用法就是为showRemoveBtn 设置函数，函数体内判断节点来为某一些节点禁用删除按钮,比如这里禁止删除跟节点。
			},
			data : {
				key : {
					name : "nodeName"   // 取后台传过来的json数据中 nodeName 字段值作为节点名称
				},
				simpleData : {
					enable : true,
					idKey : "id",       //节点的id,注意此处要对应你后台传过来的节点的属性名id
					pIdKey : "pId",     //节点的pId,注意此处要对应你后台传过来的节点的属性名pId
					rootPId : 0         //根节点的pId = 0
				}
			},
			callback : {
				beforeRemove : beforeRemove,   //删除前的回调函数
				beforeRename : beforeRename,  //修改前的回调函数
				onAsyncSuccess: zTreeOnAsyncSuccess  //异步加载完毕的回调函数
			}
		};

	function showRemoveBtn(treeId,treeNode){
		return !treeNode.level==0;             //跟节点返回false,所以跟节点不显示删除按钮。
	}
	
	function beforeRemove(treeId, treeNode){  
		if(treeNode.pId==0){                //如果删除的是根节点，也提示无法删除
			alert("根节点无法删除！")
			return false;                    //返回false 就会使前端的节点还保持存在，
											//	如果是true,则会在前端界面删除，但数据库中还会有，刷新一下即可再次出现
		}
		if(confirm("是否删除？")){  // 询问是否删除，若删除，则利用Ajax 技术异步删除，同是返回json格式数据，告知前台是否删除成功！
			$.post('${path}/DeleteCityServlet?ids='+treeNode.id,function(data){ // 从数据库中删除
			    if(data.success){                   // data  为 json 格式数据
			    	zTree.removeNode(treeNode);     // z-Tree 的api ，从视角上 删除
				  	alert(data.msg);                // 要在后台删除成功后再进行视角上删除，这样就真正意义实现了删除。
			    }else{
			    	alert(data.msg);
			    	return false;
			    }
			 });
		}
		return ;
	}
	
	function beforeRename(treeId, treeNode, newName, isCancel){
		var oldName = treeNode.nodeName;    //首先取原始的节点值
		if(newName==""){                  // 新名称为空的情况
			var node = treeNode.getParentNode();  //获取父节点
			zTree.reAsyncChildNodes(node, "refresh");  //重新访问数据库更新父节点，即可回到旧名称
			alert("名称不能为空！");
		}
		else if(newName!=treeNode.nodeName){     // 如果新名称与就名称一致，什么也不做
			$.ajax({
				url:"${path}/EditCityServlet",     //更改请求
				data : {id:treeNode.id,name:newName,pId:treeNode.pId},
				cache : false,
				dataType : 'JSON',
				type:'post',
				success: function(data){
					    if(data.success){
						   	alert(data.msg);   //提示更改成功!
						
					    }else{                    //修改失败，即同一父类型下不能名称相同（我自己加的限制条件，你可以根据需要修改）                      
							 
					    	treeNode.nodeName = oldName;
							 zTree.updateNode(treeNode);
// 					    	var node = treeNode.getParentNode();  
// 							 zTree.reAsyncChildNodes(node, "refresh");  //回到旧名称
							 alert(data.msg);
						
					 	}
				}
			});
		}
	}
	
	function addHoverDom(treeId, treeNode) {
		var sObj = $("#" + treeNode.tId + "_span"); //获取删除修改span
		if (treeNode.editNameFlag || $("#addBtn_"+treeNode.tId).length>0) return;
		var addStr = "<span class='button add' id='addBtn_" + treeNode.tId
			+ "' title='add node' onfocus='this.blur();'></span>";  //添加add  span
		sObj.after(addStr);          // 把删除修改 span 放到 add 后面
		var btn = $("#addBtn_"+treeNode.tId);
		if (btn) btn.bind("click", function(){
			var nodes = zTree.addNodes(treeNode, {pId:treeNode.id, nodeName:"新建文件夹" + getNowFormatDate()});//前端添加成功
			$.ajax({    //后端添加！！！！   必须有，要不数据库还是没添加，否则刷新页面后节点就会消失！
				url:"${path}/AddCityServlet",
				data : {parentId:nodes[0].pId,city:nodes[0].nodeName},  //传给后台当前节点的父Id和名称
				cache : false,
				dataType : 'JSON',
				type:'post',
				success: function(data){
					    if(data.success){
						   alert(data.msg);
					    }else{
							zTree.updateNode(nodes[0]);   //如果失败，则返回原始状态！
							alert(data.msg);
					 	}
				}
			});
			return false;
		});
	};

	function removeHoverDom(treeId, treeNode) {   // 去除
		$("#addBtn_"+treeNode.tId).unbind().remove();
	};

	function getNowFormatDate() {   //获取当前时间
	    var date = new Date();
	    var seperator1 = "-";
	    var seperator2 = ":";
	    var month = date.getMonth() + 1;
	    var strDate = date.getDate();
	    if (month >= 1 && month <= 9) {
	        month = "0" + month;
	    }
	    if (strDate >= 0 && strDate <= 9) {
	        strDate = "0" + strDate;
	    }
	    var currentdate = date.getFullYear() + seperator1 + month + seperator1 + strDate
	            + " " + date.getHours() + seperator2 + date.getMinutes()
	            + seperator2 + date.getSeconds();
	    return currentdate;
	}
	
	function zTreeOnAsyncSuccess(event, treeId, treeNode, msg){  // 这个函数仅仅是为了 初始化时展开 1级菜单
		if(!load){            
			var nodes = zTree.getNodesByParam("pId", 0, null);
			$.each( nodes, function(i, n){
				zTree.expandNode(n, true, false, true);
			});
			load = true;
		}
	}
</script>
<style type="text/css">
.title{
 	 margin: 30px 30px;
  font-size:15px;
}
#tree{
 margin: 30px 30px;
}
</style>
<body>
<div class="title">jsp/servelt 目录树的添加、删除和修改（请不要删除根节点）</div>
<div id="tree">
			<ul id="treeDemo" class="ztree"></ul>
		</div>
</body>
</html>
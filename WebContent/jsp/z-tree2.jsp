<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<%@ include file="/global/global.jsp"%>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String roleId= request.getParameter("roleId");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
	var menus=new Object();
	$(function(){
		$.post('${path}/RoleMenuServlet?roleId='+<%= roleId %>,function(data){
			if(data.success){
				menus= data.menus;
				zTree = $.fn.zTree.init($("#treeDemo"), setting);
			}
		})	
	})
    
    var setting = {
			async : {
				enable : true, 
				dataType : "text",
				type : "post",
				url :  "${path}/MenuNodeServlet?timestamp="+ new Date().getTime(), //请求节点生成的servlet
				autoParam : [ "id" ]   //每次异步加载传给服务器的参数
			},
			check : {
				enable: true,
				chkStyle: "checkbox",
				chkboxType: { "Y": "p", "N": "s" }
			},
			view : {
				dblClickExpand : true,
				selectedMulti:false,
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
				onAsyncSuccess: zTreeOnAsyncSuccess  //异步加载完毕的回调函数
			}
		};
	
	function zTreeOnAsyncSuccess(event, treeId, treeNode, msg){  // 这个函数仅仅是为了 初始化时展开 1级菜单
		
		if(!load){            
			var nodes = zTree.getNodesByParam("pId", 0, null);
			$.each( nodes, function(i, n){
				zTree.expandNode(n, true, false, true);
			});
			load = true;
		}
		else{
			var nodes = zTree.getNodesByParam("pId", treeNode.id, null);
			$.each( nodes, function(i, n){
				zTree.expandNode(n, true, false, true);
			});
		}
		if(isExist(treeNode)){
	    	zTree.checkNode(treeNode,true,true);
	    }
		var nodes=treeNode.children;   //判断异步加载的子节点，
                                //  因为zTreeOnAsyncSuccess只有是父节点才可以调用此函数
                         //所以为了防止忘了判断叶子节点，所以此处牺牲性能来获取正确的结果	
		$.each( nodes, function(i, n){
			if(isExist(n)){
		    	zTree.checkNode(n,true,true);
		    }
		});
	}
	
	function isExist(n){
		for(var i=0;i<menus.length;i++){
			if(n.id==menus[i].id){
				return true;
			}
		}
		return false;
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
<div id="tree">
			<ul id="treeDemo" class="ztree"></ul>
		</div>
</body>
</html>
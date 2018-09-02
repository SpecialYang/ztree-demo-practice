<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="${path}/css/bootstrap.min.css">
<link rel="stylesheet" href="${path}/css/bootstrap-table.css">
<link rel="stylesheet" href="${path }/css/font-awesome-4.4.0/css/font-awesome.min.css">
<script type="text/javascript" src="${path}/jq/jquery-3.2.0.min.js"></script>
<script src="${path}/js/bootstrap.min.js"></script>
<script src="${path}/js/bootstrap-table.js"></script>
<script src="${path}/js/bootstrap-table-zh-CN.js"></script>
<title>角色管理</title>
</head>

<script >

	window.onbeforeunload = function() {
// 		window.event.returnValue = "确定离aaaaa开当前页面吗？";
// 		var warning="确认退出？";
// 		return true;
		return "确认退出？";
	};﻿
    window.onunload=function(){
// 		alert("退出！");
    	$.post('${path}/LoginOutServlet',function(data){
			if(data.success){
				
			}
		})	
	}
	window.onunload = function(){
   		alert("确定后的逻辑代码写这里。。");
		}
			//设置查询参数
			function postQueryParams(params) {
				var queryParams= new Object();
				queryParams.limit=params.limit;
				queryParams.offset=params.offset;
				return queryParams;
			}
			
			function queryList(){
		    	$('#SysRoleList').bootstrapTable('refresh');
		    }
			
			function operatorFormatter(value, row, index) {
			    	var operator="";
				    		operator+='<button class="btn btn-warning btn-round btn-xs" onclick="editById(\''+row.id+'\');"><i class="glyphicon"></i> 修改</button>';
			    			
					return operator;
			}
			
			function editById(id){    //跳转到权限管理
				window.location='${path}/jsp/z-tree2.jsp?roleId='+id;  //附带角色id
			}
</script>
<style type="text/css">
.rightinfo{
margin-top:50px; 
}
</style>
<body>
 <div class="rightinfo">
    	<table id="SysRoleList" 
    		data-toggle="table"       
			data-url="${path}/RoleServlet" 
			data-pagination="true"
			data-side-pagination="server" 
			data-cache="false" 
			data-query-params="postQueryParams"
			data-page-list="[  5, 10, 15, 20, 30, 50]" 
			data-method="post"
			data-show-refresh="true" 
			data-show-toggle="true"
			data-show-columns="true"
			data-toolbar="#toolbar"
			data-click-to-select="true" 
			data-single-select="false"
			data-striped="true" 
			data-content-type="application/x-www-form-urlencoded">
			<thead>
				<tr>
					<th data-field="" data-checkbox="true"></th>
					<th data-field="id">角色ID</th>
					<th data-field="name">角色名称</th>
					<th data-field="operator" data-formatter="operatorFormatter">操作</th>
				</tr>
			</thead>
		</table>
    </div>
</body>
</html>
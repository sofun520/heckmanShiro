<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ request.getContextPath();
	request.setAttribute("basePath", basePath);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<link rel="stylesheet"
	href="${basePath}/adminLTE/bootstrap/css/bootstrap.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.5.0/css/font-awesome.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">
<link rel="stylesheet"
	href="${basePath}/adminLTE/dist/css/AdminLTE.min.css">
<link rel="stylesheet"
	href="${basePath}/adminLTE/dist/css/skins/_all-skins.min.css">
<link rel="stylesheet"
	href="${basePath}/adminLTE/dist/css/jquery-confirm.css">

<script src="${basePath}/adminLTE/plugins/jQuery/jquery-2.2.3.min.js"></script>
<script src="${basePath}/adminLTE/bootstrap/js/bootstrap.min.js"></script>
<script
	src="${basePath}/adminLTE/plugins/slimScroll/jquery.slimscroll.min.js"></script>
<script src="${basePath}/adminLTE/plugins/fastclick/fastclick.js"></script>
<script src="${basePath}/adminLTE/dist/js/app.min.js"></script>
<script src="${basePath}/adminLTE/dist/js/demo.js"></script>
<script src="${basePath}/adminLTE/plugins/iCheck/icheck.min.js"></script>

<!-- <script type="application/javascript" src="jslib/jquery/jquery.js" type="text/javascript" charset="utf-8"></script> -->
<script type="application/javascript"
	src="${basePath}/jslib/angular/angular.js"></script>
<script type="application/javascript"
	src="${basePath}/jslib/angular-resource/angular-resource.js"></script>
<script type="application/javascript"
	src="${basePath}/jslib/angular-file-upload/angular-file-upload.min.js"></script>
<script type="application/javascript"
	src="${basePath}/jslib/angular-cookie/angular-cookies.js"></script>
<script type="application/javascript"
	src="${basePath}/jslib/angular-bootstrap/ui-bootstrap.js"></script>
<script type="application/javascript"
	src="${basePath}/jslib/angular-bootstrap/ui-bootstrap-tpls.js"></script>
<script src="${basePath}/adminLTE/dist/js/jquery-confirm.min.js"></script>
<style type="text/css">
body {
	font-size: 12px;
}
</style>
</head>
<body>
<body class="hold-transition skin-blue layout-top-nav" ng-app="myApp"
	ng-controller="permissionCtrl" ng-init="init()">

	<div class="box box-primary" style="min-height: 800px;">
		<form class="form-horizontal ng-pristine ng-valid"
			action="#" method="post" id="myForm">
			<div class="box-body">
				<div class="form-group" style="padding-right: 10px;">
					<label for="search_aName" class="col-sm-1 control-label">权限ID</label>
					<div class="col-sm-3">
						<input type="hidden" name="pId" value="${permission.pId}"
							class="form-control input-sm" placeholder="">
						<input type="text" value="${permission.pId}" readonly="readonly"
							class="form-control input-sm" >
					</div>
					<label for="search_aName" class="col-sm-1 control-label">权限token</label>
					<div class="col-sm-3">
						<input type="text" name="pToken" value="${permission.pToken}"
							class="form-control input-sm" placeholder="">
					</div>
					<label for="search_aName" class="col-sm-1 control-label">描述</label>
					<div class="col-sm-3">
						<input type="text" name="pDescription" value="${permission.pDescription}"
							class="form-control input-sm" placeholder="">
					</div>
				</div>
				<div class="form-group" style="padding-right: 10px;">
					<label for="search_aName" class="col-sm-1 control-label">权限类型</label>
					<div class="col-sm-3">
						<select class="form-control" name="pType">
							<option value="1" <c:if test="${permission.pType==1}">selected="selected"</c:if>>菜单</option>
							<option value="2" <c:if test="${permission.pType==2}">selected="selected"</c:if>>操作</option>
						</select>
					</div>
					<c:if test="${!empty permission.pParent}">
						<label for="search_aName" class="col-sm-1 control-label">父权限</label>
						<div class="col-sm-3">
							<select class="form-control">
								<c:forEach items="${parentPermissions}" var="pp">
									<option value="${pp.pParent}">${pp.pDescription}</option>
								</c:forEach>
							</select>
						</div>
					</c:if>
				</div>
				<div class="form-group" style="padding-right: 10px;">
					<div class="col-sm-7">
						<button type="button" class="btn btn-info btn-sm" ng-click="submit()">保存</button>
						<button type="button" id="digBtn" class="btn btn-info btn-sm" onclick="window.history.back();">返回</button>
					</div>
				</div>
				
			</div>
			<!-- /.box-footer -->
		</form>

	</div>
	<script type="text/javascript">
		angular.module('myApp', []).controller('permissionCtrl',
				["$scope", "$http",function($scope, $http) {

			$scope.init = function() {
			}
			
			$scope.submit = function(){
				var data={};
				$("#myForm").serializeArray().map(function(x){
					data[x.name]=x.value;
				});
				
				$http({
					method : "post", 
					url : "${basePath}/api/permission/save",
					data : JSON.stringify(data),
					headers : {
						'Content-Type' : 'application/json;charset=UTF-8'
					}
				}).success(function(data) {
					console.log(data);
					if(data.code==0){
						$.alert({
						    title: '系统提示',
						    content: data.msg,
						    confirm: function(){
								//window.location.reload();
						    }
						});
					}else{
						$.alert({
						    title: '系统提示',
						    content: data.msg
						});
					}
				})
			}
			
		}]);
	</script>
</body>
</html>
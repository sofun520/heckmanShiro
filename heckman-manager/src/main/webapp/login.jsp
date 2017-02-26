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
	href="${basePath}/adminLTE/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.5.0/css/font-awesome.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">
<link rel="stylesheet"
	href="${basePath}/adminLTE/dist/css/AdminLTE.min.css">
<link rel="stylesheet"
	href="${basePath}/adminLTE/dist/css/skins/_all-skins.min.css">

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
<script type="text/javascript">
	function reloadVerifyCode() {
		$('#verifyCodeImage').attr('src',
				'${basePath}/getVerifyCodeImage?abc=' + Math.random());//链接后添加Math.random，确保每次产生新的验证码，避免缓存问题。
	}
</script>
</head>
<body class="hold-transition login-page">
	<div class="login-box" ng-app="myApp" ng-controller="loginCtrl"
		ng-init="init()">
		<div class="login-logo">
			<a href="../../index2.html"><b>Admin</b>LTE</a>
		</div>
		<!-- /.login-logo -->
		<div class="login-box-body">
			<p class="login-box-msg">${message_login}
				<span style=""
					ng-show="myForm.uUsername.$dirty && myForm.uUsername.$invalid">
					<span ng-show="myForm.uUsername.$error.required">请输入用户名</span>
				</span> <span style=""
					ng-show="myForm.uPassword.$dirty && myForm.uPassword.$invalid">
					<span ng-show="myForm.uPassword.$error.required">请输入密码</span>
				</span> <span style=""
					ng-show="myForm.verifyCode.$dirty && myForm.verifyCode.$invalid">
					<span ng-show="myForm.verifyCode.$error.required">请输入验证码</span>
				</span>
				<span ng-show="verifycode_error">验证码错误</span>
			</p>

			<form <%-- action="${basePath}/login" --%> name="myForm" novalidate
				method="post">
				<div class="form-group has-feedback">
					<input type="text" class="form-control" name="uUsername"
						ng-model="formData.uUsername" placeholder="用户名" required>
					<span class="glyphicon glyphicon-envelope form-control-feedback"></span>
				</div>
				<div class="form-group has-feedback">
					<input type="password" class="form-control" name="uPassword"
						ng-model="formData.uPassword" placeholder="密码" required> <span
						class="glyphicon glyphicon-lock form-control-feedback"></span>
				</div>
				<div class="form-group has-feedback">
					<div class="row">
						<div class="col-xs-7">
							<input type="text" class="form-control" name="verifyCode"
								ng-model="verifyCode" placeholder="验证码" required>
						</div>
						<div class="col-xs-5">
							<img width="70%" id="verifyCodeImage"
								onclick="reloadVerifyCode()"
								src="${basePath}/getVerifyCodeImage" />
						</div>
					</div>

				</div>
				<div class="row">
					<!-- /.col -->
					<div class="col-xs-12">
						<button type="button" ng-click="submit()"
							ng-disabled="allComplate"
							class="btn btn-primary btn-block btn-flat">登录{{submiting?"中":""}}</button>
					</div>
					<!-- /.col -->
				</div>
			</form>

			<!-- /.social-auth-links -->

			<!-- <a href="#">I forgot my password</a><br> <a href="register.html"
				class="text-center">Register a new membership</a> -->

		</div>
		<!-- /.login-box-body -->
	</div>
	<!-- /.login-box -->


	<script>
		var app = angular.module('myApp', []);
		app.controller('loginCtrl', function($scope, $http) {

			$scope.init = function() {
				$scope.verifycode_error = false;
				$scope.formData = {};
				
				if(window != top){  
	                top.location.href=location.href;  
	            }

				///$scope.uUsername = '';
				//$scope.uPassword = '';
				//$scope.verifyCode = '';

			};

			$scope.allComplate = true;

			$scope.$watch('verifyCode', function(newValue, oldValue) {

				$http.get("${basePath}/checkVerifyCode?verifyCode=" + newValue)
						.success(function(data) {
							console.log(JSON.stringify(data));
							console.log(data.code == 0);
							if (data.code == 0) {
								$scope.allComplate = false;
								$scope.verifycode_error = false;
							} else {
								$scope.verifycode_error = true;
								$scope.allComplate = true;
							}
							//alert($scope.allComplate);
						});

			});

			$scope.submit = function() {
				$scope.submiting = true;
				console.log(JSON.stringify($scope.formData));
				$http({
					method : "post",
					url : "${basePath}/checkLogin",
					data : JSON.stringify($scope.formData),
					headers : {
						'Content-Type' : 'application/json;charset=UTF-8'
					}
				}).success(function(data) {
					console.log(data);
					if(data.code==0){
						//alert(data.msg);
						location.href='${basePath}/main';
					}else{
						$scope.submiting = false;
					}
				});
			};

		});
	</script>
</body>
</html>
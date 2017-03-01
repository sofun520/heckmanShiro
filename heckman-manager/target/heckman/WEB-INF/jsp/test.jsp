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
<script type="application/javascript"
	src="${basePath}/jslib/angular-popups/angular-popups.js"></script>
</head>
<body>
<body>  
    <div ng-app="myApp" ng-controller="homeCtrl">  
    	<dialog ng-if="dialog.open" modal close="dialog.open=false">
    <div dialog-title>消息</div>
    <div dialog-content>hello world</div>
    <div dialog-buttons><button autofocus>确定</button><button ng-click="$close()">取消</button></div>
</dialog>

<div >
    <button ng-click="openAlert()">Popup.alert()</button>
    <button ng-click="openConfirm()">Popup.confirm()</button>
    <button ng-click="openNotice()">Popup.notice()</button>
</div>
    </div>  
   <script type="text/javascript">
		var app = angular.module('myApp', ['angular-popups']);
		
		app.config(function (PopupProvider) {
		    PopupProvider.title = '提示';
		    PopupProvider.okValue = '确定';
		    PopupProvider.cancelValue = '取消';
		});
		
		app.controller('homeCtrl', function($scope, $http,Popup) {

			$scope.init = function() {
				$scope.loadMenu();
			}

			$scope.loadMenu = function() {
				$http({
					method : "get",
					url : "${basePath}/main/permission",
				}).success(function(data) {
					console.log(data);
					$scope.menus = data.data;
				});
			};

			$scope.subframe = function(url) {
				$("#iframe").attr('src', url);
			};
			
			
			 $scope.openAlert = function() {
			        Popup.alert('hello world234234234234234234234', function () {
			            console.log('ok');
			        });
			    };

			    $scope.openConfirm = function() {
			        Popup.confirm('hello world2342342342342342342342343', function () {
			            console.log('ok');
			        }, function () {
			            console.log('cancel');
			        });
			    };

			    $scope.openNotice = function() {
			        Popup.notice('hello world23423423423423423423423423', 3000, function () {
			            console.log('ok')
			        });
			    }

		});
	</script>
</body> 
</html>
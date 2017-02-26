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
<style type="text/css">
body{
	font-size: 12px;
}
</style>
<body>
<body class="hold-transition skin-blue layout-top-nav" ng-app="myApp"
	ng-controller="homeCtrl" ng-init="init()">
	<header class="main-header"> <nav
		class="navbar navbar-static-top">
	<div class="container">
		<div class="navbar-header">
			<a href="${basePath}/AdminLTE/index2.html" class="navbar-brand"><b>HECKMAN</b>管理后台</a>
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#navbar-collapse">
				<i class="fa fa-bars"></i>
			</button>
		</div>
		<div class="collapse navbar-collapse pull-left" id="navbar-collapse">
			<ul class="nav navbar-nav" id="parentMenus">
				<li class="active" ng-if="permission['system.admin']"><a href="#" ng-click="loadSubMenu(2)">系统权限管理<span class="sr-only">(current)</span></a></li>
				<li ><a href="#">票据管理{{permisson['system.admin']}}</a></li>
			</ul>
		</div>
		<div class="navbar-custom-menu">
			<ul class="nav navbar-nav">
				<li class="dropdown user user-menu">
					<!-- Menu Toggle Button --> <a href="#" class="dropdown-toggle"
					data-toggle="dropdown"> <!-- The user image in the navbar--> <img
						src="${basePath}/${user.headPic}" class="user-image"
						alt="User Image"> <!-- hidden-xs hides the username on small devices so only the image appears. -->
						<span class="hidden-xs">${user.username}</span>
				</a>
					<ul class="dropdown-menu">
						<!-- The user image in the menu -->
						<li class="user-header"><img
							src="${basePath}/${user.headPic}" class="img-circle"
							alt="User Image">
							<p>
								${user.username} <small>${user.truename}</small>
							</p></li>
						<!-- Menu Body -->
						<!-- <li class="user-body">
                            <div class="row">
                                <div class="col-xs-4 text-center">
                                    <a href="#">Followers</a>
                                </div>
                                <div class="col-xs-4 text-center">
                                    <a href="#">Sales</a>
                                </div>
                                <div class="col-xs-4 text-center">
                                    <a href="#">Friends</a>
                                </div>
                            </div> /.row
                        </li> -->
						<!-- Menu Footer-->
						<li class="user-footer">
							<div class="pull-left">
								<a href="javascript:myFile()" class="btn btn-default btn-flat">我的信息</a>
							</div>
							<div class="pull-right">
								<!--  -->
								<a href="logout" class="btn btn-default btn-flat">退出系统</a>
							</div>
						</li>
					</ul>
				</li>
			</ul>
		</div>
	</div>
	</nav> </header>
	<div class="content-wrapper" style="min-height: 946px;">
		<section class="content">
		<div class="row">
			<div class="col-md-3">
				<div class="box box-solid">
					<div class="box-header with-border">
					<button ng-click="dialog={open: true}">打开对话框</button>
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
						<p class="submenu-title">功能菜单</p>
						<div class="box-tools">
							<button type="button" class="btn btn-box-tool"
								data-widget="collapse">
								<i class="fa fa-minus"></i>
							</button>
						</div>
					</div>
					<div class="box-body no-padding">
						<!-- <li class="active"><a href="#"><i class="fa fa-filter"></i> Junk <span
                                    class="label label-warning pull-right">65</span></a></li> -->
						<ul class="nav nav-pills nav-stacked nav-font" id="subMenus"
							ng-repeat="x in submenus">
							<li><a href="javascript:void(0)" ng-click="subframe(x.pUrl)"><i
									class="fa fa-file-text-o"></i> {{x.pDescription}}</a></li>
						</ul>

					</div>
				</div>
				<!-- <div class="box box-solid">
                    <div class="box-header with-border">
                        <p class="submenu-title">Labels</p>
                        <div class="box-tools">
                            <button type="button" class="btn btn-box-tool"
                                data-widget="collapse">
                                <i class="fa fa-minus"></i>
                            </button>
                        </div>
                    </div>
                    <div class="box-body no-padding">
                        <ul class="nav nav-pills nav-stacked nav-font">
                            <li><a href="#"><i class="fa fa-circle-o text-red"></i>
                                    Important</a></li>
                            <li><a href="#"><i class="fa fa-circle-o text-yellow"></i>
                                    Promotions</a></li>
                            <li><a href="#"><i
                                    class="fa fa-circle-o text-light-blue"></i> Social</a></li>
                        </ul>
                    </div>
                    /.box-body
                </div> -->
			</div>
			<div class="col-md-9">
				<iframe id="iframe" width="100%" height="820" style="border: 0px;"
					src="main/test"></iframe>
			</div>
		</div>
		</section>
	</div>
	<footer class="main-footer">
	<div class="container">
		<div class="pull-right hidden-xs">
			<b>Version</b> 2.3.8
		</div>
		<strong>Copyright &copy; 2016 <a
			href="http://almsaeedstudio.com">heckman Studio</a>.
		</strong> All rights reserved.
	</div>
	</footer>
	<script type="text/javascript">
		var app = angular.module('myApp', ['angular-popups']);
		
		app.config(function (PopupProvider) {
		    PopupProvider.title = '提示';
		    PopupProvider.okValue = '确定';
		    PopupProvider.cancelValue = '取消';
		});
		
		app.controller('homeCtrl',["$scope", "$http","Popup",function($scope, $http,Popup) {

			$scope.init = function() {
				
				$scope.permission();
				$scope.loadSubMenu(2);
				//$scope.loadMenu();
				/* mainService.loadMenu(function(data){
					console.log(data);
				}); */
			}
			
			$scope.permission = function(){
				$scope.permission = {};
				$scope.permission['system.admin']=true;
				return $scope.permission;
			}

			/* $scope.loadMenu = function() {
				$http({
					method : "post",
					url : "${basePath}/main/permission",
					data : JSON.stringify({"pParent":"","pType":"1"}),
					headers : {
						'Content-Type' : 'application/json;charset=UTF-8'
					}
				}).success(function(data) {
					console.log(data);
					$scope.menus = data.data;
					
					$scope.loadSubMenu(data.data[0].pId);
					
				});
			}; */
			
			$scope.loadSubMenu = function(parentId) {
				$http({
					method : "post",
					url : "${basePath}/permission",
					data : JSON.stringify({"pParent":parentId,"pType":"1"}),
					headers : {
						'Content-Type' : 'application/json;charset=UTF-8'
					}
				}).success(function(data) {
					console.log(data);
					$scope.submenus = data.data;
					
					console.log(data.data[0].pUrl);
					$scope.subframe(data.data[0].pUrl);
					
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

		}]);
		
		app.factory("mainService",['$resource',function($resource){
			return $resource("",{},{
				loadMenu:{
					method : "get",
					url : "${basePath}/main/permission",
				}
			});
		}]);
	</script>
</body>
</html>
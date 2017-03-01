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
<link rel="stylesheet" href="${basePath}/adminLTE/dist/css/jquery-confirm.css">

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
<script src="${basePath}/adminLTE/dist/js/jquery-confirm.min.js"></script>
<style type="text/css">
body{
	font-size: 12px;
}
</style>
</head>
<body>
<body class="hold-transition skin-blue layout-top-nav" ng-app="myApp"
	ng-controller="permissionCtrl" ng-init="init()">
	
	<div class="box box-primary" style="min-height: 800px;">
        <!-- <div class="box-header with-border">
            <h3 class="box-title">Bordered Table</h3>
        </div> -->
        <form class="form-horizontal" action="${basePath}/admin/api.do"
            method="post">
            <div class="box-body">
                <label for="search_aName" class="col-sm-2 control-label">接口名称</label>
                <div class="col-sm-3">
                    <input type="text" name="aName" value="${aName}"
                        class="form-control input-sm" id="search_aName" placeholder="">
                </div>
                <div class="col-sm-7">
                    <button type="submit" class="btn btn-info btn-sm">查询</button>
                    <button type="button" id="digBtn" class="btn btn-info btn-sm">新增</button>
                </div>
            </div>
            <!-- /.box-footer -->
        </form>
	
	<!-- /.box-header -->
        <div class="box-body">
            <table class="table table-bordered table-striped">
                <tbody>
                    <tr>
                        <th style="width: 10px">#</th>
                        <th>权限token值</th>
                        <th>权限URL</th>
                        <th>描述</th>
                        <th>权限类型</th>
                        <th>父权限</th>
                        <th>新增时间</th>
                        <th style="width: 140px">操作</th>
                    </tr>
	                  <tr ng-if="noDataShow">
	                      <td colspan="8" align="center">没有数据</td>
	                  </tr>
                    <tr ng-repeat="x in perList track by $index">
                        <td>{{$index+1}}</td>
                        <td>{{x.pToken}}</td>
                        <td>{{x.pUrl}}</td>
                        <td>{{x.pDescription}}</td>
                        <td>{{x.pType==1?'菜单':'操作'}}</td>
                        <td>{{x.pParent}}</td>
                        <td>{{x.pAddTime | date:'yyyy-MM-dd'}}</td>
                        <td align="center"><a href="javascript:void(0)" ng-click="delPermission(x.pId)">删除</a>&nbsp;&nbsp;<a
                            href="javascript:void(0)" ng-click="editPermisson(x.pId)">修改</a></td>
                    </tr>
                </tbody>
            </table>
	
	
	<script type="text/javascript">
		angular.module('myApp', ['angular-popups']).controller('permissionCtrl',
				["$scope", "$http",function($scope, $http) {

			$scope.init = function() {
				$scope.permissionsList();
			}
			
			$scope.permissionsList = function(){
				
				var ht = $scope.httpRequest();
				ht.success(function(data) {
					console.log(data);
					if(data.code==0){
						if(data.data.length>0){
							$scope.perList = data.data;
						}else{
							$scope.noDataShow = true;					
						}
					}else{
						Popup.alert('加载数据异常        ', function () {
				            console.log('ok');
				        });
					}
				});
				
			}
			
			$scope.permission = function(){
				$scope.permission = {};
				$scope.permission['system.admin']=true;
				return $scope.permission;
			}
			
			$scope.delPermission = function(pId){
				$.confirm({
				    title: '系统提示',
				    content: '是否删除?',
				    type: 'blue',
				    typeAnimated: true,
				    buttons: {
				        tryAgain: {
				            text: '确定',
				            btnClass: 'btn-blue',
				            action: function(){
				            	alert('yes');
				            }
				        },
				        cancle: {
				            text: '取消',
				            action: function(){
				            }
				        }
				    }
				});
			}
			
			$scope.editPermisson = function(pId){
				window.location.href="${basePath}/main/editPermission?id="+pId;
			}

			
			$scope.httpRequest = function(){
				return $http({
					method : "post",
					url : "${basePath}/api/permission/query",
					data : JSON.stringify({}),
					headers : {
						'Content-Type' : 'application/json;charset=UTF-8'
					}
				});
			}
			
		}]);
	</script>
</body>
</html>
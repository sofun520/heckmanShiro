<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="../adminLTE/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.5.0/css/font-awesome.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">
<link rel="stylesheet" href="../adminLTE/dist/css/AdminLTE.min.css">
<link rel="stylesheet"
	href="../adminLTE/dist/css/skins/_all-skins.min.css">
<link rel="stylesheet" href="../adminLTE/dist/css/jquery-confirm.css">

<script src="../adminLTE/plugins/jQuery/jquery-2.2.3.min.js"></script>
<script src="../adminLTE/bootstrap/js/bootstrap.min.js"></script>
<script src="../adminLTE/plugins/slimScroll/jquery.slimscroll.min.js"></script>
<script src="../adminLTE/plugins/fastclick/fastclick.js"></script>
<script src="../adminLTE/dist/js/app.min.js"></script>
<script src="../adminLTE/dist/js/demo.js"></script>
<script src="../adminLTE/plugins/iCheck/icheck.min.js"></script>

<!-- <script type="application/javascript" src="jslib/jquery/jquery.js" type="text/javascript" charset="utf-8"></script> -->
<script type="application/javascript" src="../jslib/angular/angular.js"></script>
<script type="application/javascript"
	src="../jslib/angular-resource/angular-resource.js"></script>
<script type="application/javascript"
	src="../jslib/angular-file-upload/angular-file-upload.min.js"></script>
<script type="application/javascript"
	src="../jslib/angular-cookie/angular-cookies.js"></script>
<script type="application/javascript"
	src="../jslib/angular-bootstrap/ui-bootstrap.js"></script>
<script type="application/javascript"
	src="../jslib/angular-bootstrap/ui-bootstrap-tpls.js"></script>
<script src="../adminLTE/dist/js/jquery-confirm.min.js"></script>
<style type="text/css">
body {
	font-size: 12px;
}
</style>
</head>
<body class="hold-transition skin-blue layout-top-nav" ng-app="myApp"
	ng-controller="permissionCtrl" ng-init="init()">

	<div class="box box-primary" style="min-height: 800px;">
		<!-- <div class="box-header with-border">
            <h3 class="box-title">Bordered Table</h3>
        </div> -->
		<form class="form-horizontal"
			method="post">
			<div class="box-body">
				<label for="search_aName" class="col-sm-2 control-label">权限或菜单名称</label>
				<div class="col-sm-2">
					<input type="text" name="aName" ng-model="pDescription"
						class="form-control input-sm" id="search_aName" placeholder="">
				</div>
				<label for="search_aName" class="col-sm-2 control-label">权限token</label>
				<div class="col-sm-2">
					<input type="text" name="aName" ng-model="pToken"
						class="form-control input-sm" id="search_aName" placeholder="">
				</div>
				<div class="col-sm-3">
					<button type="button" ng-click="loadPermissionList()" class="btn btn-info btn-sm">查询</button>
					<button type="button" ng-click="reset()" class="btn btn-info btn-sm">重置</button>
					<button type="button" ng-click="addMainLevel()" class="btn btn-info btn-sm">新增一级</button>
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
						<th>权限名称</th>
						<th>权限token</th>
						<th>权限URL</th>
						<th>权限类型</th>
						<th>父菜单</th>
						<th>新增时间</th>
						<th style="width: 210px">操作</th>
					</tr>
					<tr ng-if="noDataShow">
						<td colspan="8" align="center">没有数据</td>
					</tr>
					<tr ng-if="dataShow" ng-repeat="x in perList track by $index">
						<td>{{$index+1}}</td>
						<td>{{x.pDescription}}</td>
						<td>{{x.pToken}}</td>
						<td>{{x.pUrl}}</td>
						<td>{{x.pType==1?'菜单':'操作'}}</td>
						<td>{{x.pParent}}</td>
						<td>{{x.pAddTime | date:'yyyy-MM-dd'}}</td>
						<td align="center"><a href="javascript:void(0)"
							ng-click="delPermission(x.pId)">删除</a>&nbsp;&nbsp;<a
							href="javascript:void(0)" ng-click="editPermisson(x.pId)">修改</a>&nbsp;&nbsp;
							<a ng-if="x.pType==1 && x.pParent == null" href="javascript:void(0)" ng-click="permissionAdd(x.pId)">新增子菜单</a>
							<a ng-if="x.pType==1 && x.pParent != null" href="javascript:void(0)" ng-click="permissionAdd(x.pId)">新增子权限</a>
							</td>
					</tr>
				</tbody>
			</table>
<script type="text/javascript">
angular.module('myApp', []).factory('myService',function myService($http){
	return{
		loadPermissionList:function loadPermissionList(query,callback){
			$http({
				method : "post",
				url : "../api/permission/query",
				data : query,
				headers : {
					'Content-Type' : 'application/json;charset=UTF-8'
				}
			}).success(function(data) {
				callback(null, data);
			}).error(function (e) {  
	            callback(e);  
	        });
		},
		deletePermission:function deletePermission(query,callback){
			$http({
				method : "post",
				url : "../api/permission/delete",
				data : query,
				headers : {
					'Content-Type' : 'application/json;charset=UTF-8'
				}
			}).success(function(data) {
				callback(null, data);
			}).error(function (e) {  
	            callback(e);  
	        });
		}
	}
}).controller('permissionCtrl',["myService","$scope", "$http",function(myService,$scope, $http){
	$scope.init = function(){
		$scope.pDescription = '';
		$scope.pToken = '';
		$scope.loadPermissionList();
	}
	
	$scope.loadPermissionList = function(){
		var param=JSON.stringify({"pDescription":$scope.pDescription,"pToken":$scope.pToken});
		myService.loadPermissionList(param,function(error,data){
			if(!error){
				console.log(data);
				if(data.code==0){
					if(data.data.length>0){
						$scope.dataShow = true;
						$scope.noDataShow = false;					
						$scope.perList = data.data;
					}else{
						$scope.dataShow = false;
						$scope.noDataShow = true;					
					}
				}else{
					$.alert({title: '系统提示',content: data.msg});
				}
			}
		});
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
		            	var param = JSON.stringify({"pId":pId});
		            	myService.deletePermission(param,function(error,data){
		            		if(!error && data.code==0){
		            			window.location.reload();
		            		}
		            	});
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
		window.location.href="editPermission?id="+pId;
	}
	
	$scope.permissionAdd = function(pId){
		alert(pId);
		window.location.href = "editPermission?pId="+pId;
	}
	
	$scope.reset = function(){
		$scope.pDescription = '';
		$scope.pToken = '';
	}
	
	$scope.addMainLevel = function(){
		window.location.href = "editPermission";
	}
	
}])
</script>
</body>
</html>
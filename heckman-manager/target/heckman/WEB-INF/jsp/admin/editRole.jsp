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
<link rel="stylesheet"
	href="../adminLTE/dist/css/AdminLTE.min.css">
<link rel="stylesheet"
	href="../adminLTE/dist/css/skins/_all-skins.min.css">
<link rel="stylesheet" href="../adminLTE/dist/css/jquery-confirm.css">

<script src="../adminLTE/plugins/jQuery/jquery-2.2.3.min.js"></script>
<script src="../adminLTE/bootstrap/js/bootstrap.min.js"></script>
<script
	src="../adminLTE/plugins/slimScroll/jquery.slimscroll.min.js"></script>
<script src="../adminLTE/plugins/fastclick/fastclick.js"></script>
<script src="../adminLTE/dist/js/app.min.js"></script>
<script src="../adminLTE/dist/js/demo.js"></script>
<script src="../adminLTE/plugins/iCheck/icheck.min.js"></script>

<!-- <script type="application/javascript" src="jslib/jquery/jquery.js" type="text/javascript" charset="utf-8"></script> -->
<script type="application/javascript"
	src="../jslib/angular/angular.js"></script>
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
body{
	font-size: 12px;
}
</style>
</head>
<body class="hold-transition skin-blue layout-top-nav" ng-app="myApp"
	ng-controller="roleCtrl" ng-init="init()">

	<div class="box box-primary" style="min-height: 800px;">
		<!-- <div class="box-header with-border">
            <h3 class="box-title">Bordered Table</h3>
        </div> -->
		<form class="form-horizontal" id="myForm"
			method="post">
			<div class="box-body">
				<div class="form-group" style="padding-right: 0px;">
					<label for="search_aName" class="col-sm-2 control-label">角色ID</label>
					<div class="col-sm-3">
						<input type="hidden" value="${role.rId}" name="rId"
							class="form-control input-sm" placeholder="">
						<input type="text" readonly="readonly" value="${role.rId}" 
							class="form-control input-sm" placeholder="">
					</div>
					<label for="search_aName" class="col-sm-2 control-label">角色名称</label>
					<div class="col-sm-3">
						<input type="text" name="rDescription" value="${role.rDescription}" required
							class="form-control input-sm" id="search_aName" placeholder="">
					</div>
				</div>
				<div class="form-group" style="padding-right: 0px;">
					<label for="search_aName" class="col-sm-2 control-label">角色代码</label>
					<div class="col-sm-3">
						<input type="text" name="rName" value="${role.rName}" required
							class="form-control input-sm" id="search_aName" placeholder="">
					</div>
					<label for="search_aName" class="col-sm-2 control-label"></label>
					<div class="col-sm-5">
						<button type="button" ng-click="submit()" class="btn btn-info btn-sm">保存</button>
						<button type="button" ng-click="reset()" class="btn btn-info btn-sm">重置</button>
					</div>
				</div>
			</div>
			<!-- /.box-footer -->
		</form>

<script type="text/javascript">
angular.module('myApp', []).factory('myService',function myService($http){
	return{
		loadRoleList:function loadRoleList(callback){
			$http({
				method : "post",
				url : "../api/role/query",
				data : JSON.stringify({}),
				headers : {
					'Content-Type' : 'application/json;charset=UTF-8'
				}
			}).success(function(data) {
				callback(null, data);
			}).error(function (e) {  
	            callback(e);  
	        });
		},
		saveRole:function saveRole(query,callback){
			$http({
				method : "post",
				url : "../api/role/save",
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
}).controller('roleCtrl',["myService","$scope", "$http",function(myService,$scope, $http){
	$scope.init = function(){
		
		$scope.openOrCloseStatus = false;
		
		$scope.loadRoleList();
	}
	
	$scope.openOrClose = function(){
		if($scope.openOrCloseStatus){
			$scope.openOrCloseStatus = false;
		}else{
			$scope.openOrCloseStatus = true;
		}
	}
	
	$scope.loadRoleList = function(){
		myService.loadRoleList(function(error,data){
			if(!error){
				console.log(data);
				if(data.code==0){
					if(data.data.length>0){
						$scope.roleList = data.data;
					}else{
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
		alert(pId);
	}
	
	$scope.submit = function(){
		var data={};
		$("#myForm").serializeArray().map(function(x){
			data[x.name]=x.value;
		});
		
		myService.saveRole(data,function(error,data){
			if(!error){
				if(data.code==0){
					window.history.back();
				}
			}
		});
		
	}
	
	$scope.reset = function(){
		$('#myForm')[0].reset();
	}
	
}])
</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>HECKMAN管理后台</title>
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
<link rel="stylesheet" href="../jslib/ztree/css/zTreeStyle/zTreeStyle.css" type="text/css">

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
<script src="../jslib/ztree/js/jquery.ztree.all.js"></script>
<style type="text/css">
body{
	font-size: 12px;
}
</style>
</head>
<body class="hold-transition skin-blue layout-top-nav" ng-app="myApp"
	ng-controller="operateLogCtrl" ng-init="init()">

	<div class="box box-primary" style="min-height: 800px;">
		<!-- <div class="box-header with-border">
            <h3 class="box-title">Bordered Table</h3>
        </div> -->
		<form class="form-horizontal" action="#"
			method="post">
			<div class="box-body">
				<label for="search_aName" class="col-sm-2 control-label">模块code</label>
				<div class="col-sm-2">
					<input type="text" ng-model="oBusCode"
						class="form-control input-sm" id="search_aName" placeholder="">
				</div>
				<label for="search_aName" class="col-sm-2 control-label">操作人</label>
				<div class="col-sm-2">
					<input type="text" ng-model="oUserName"
						class="form-control input-sm" id="search_aName" placeholder="">
				</div>
				<div class="col-sm-4">
					<button type="button" ng-click="loadUserList()" class="btn btn-info btn-sm">查询</button>
					<button type="button" ng-click="reset()" class="btn btn-info btn-sm">清空</button>
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
							<th>模块code</th>
							<th>操作描述</th>
							<th>操作时间</th>
							<th>操作人</th>
						</tr>
						<tr ng-if="noDataShow">
							<td colspan="5" align="center">没有数据</td>
						</tr>
						<tr ng-if="dataShow" ng-repeat="x in olList track by $index">
							<td>{{$index+1}}</td>
							<td>{{x.oBusCode}}</td>
							<td>{{x.oBusDescription}}</td>
							<td>{{x.oAddTime | date:'yyyy-MM-dd'}}</td>
							<td>{{x.oUserName}}</td>
						</tr>
					</tbody>
				</table>
		</div>
		<div class="box-footer clearfix" ng-if="dataShow">
              <ul class="pagination pagination-sm no-margin pull-right">
                <li><a href="#" ng-click="loadUserList(pageCount-1)">«</a></li>
                <li ng-repeat="x in pages track by $index"  class="{{x==page?'active':''}}"><a href="#" ng-click="loadUserList(x)">{{x}}</a></li>
                <li><a href="#" ng-click="loadUserList(page+1)">»</a></li>
              </ul>
        </div>
	</div>
<script type="text/javascript">
</script>
<script type="text/javascript">
angular.module('myApp', []).factory('myService',function myService($http){
	return{
		loadOLList:function loadOLList(query,callback){
			$http({
				method : "post",
				url : "../api/operateLog/query",
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
}).controller('operateLogCtrl',["myService","$scope", "$http",function(myService,$scope, $http){
    
    $scope.init = function(){
		$scope.loadUserList();
		$scope.pages=[];
	}
	
	$scope.loadUserList = function(page){
		page=typeof(page)=="undefined"?1:page;
		page=page>$scope.pageCount?$scope.pageCount:page;
		var param = JSON.stringify({"oBusCode":$scope.oBusCode,"oUserName":$scope.oUserName,"page":page});
		myService.loadOLList(param,function(error,data){
			if(!error){
				console.log(data);
				if(data.code==0){
					if(data.data.length>0){
						$scope.dataShow = true;
						$scope.noDataShow = false;					
						$scope.olList = data.data;
						if(data.page>0 && data.pageCount>0){
							$scope.page = data.page;
							$scope.pageCount = data.pageCount;
							$scope.pageCompoment($scope.pageCount);
						}
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
	
	$scope.pageCompoment = function(pageSize){
		for(var i=0;i<pageSize;i++){
			$scope.pages[i]=(i+1)+'';					
		}
	}
	
	$scope.reset = function(){
		$scope.oBusCode = '';
		$scope.oUserName = '';
	}
	
	
	
}]);
</script>
</body>
</html>
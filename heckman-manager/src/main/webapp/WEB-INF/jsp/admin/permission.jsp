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
	ng-controller="roleCtrl" ng-init="init()">

	<div class="box box-primary" style="min-height: 600px;">
		<div class="box-body">
			<div class="col-sm-6">
				<table class="table table-bordered table-striped">
					<tr><td>权限菜单树</td></tr>
					<tr>
						<td height="500">
							<ul tree class="ztree" ng-model="selectNode"></ul>
						</td>
					</tr>
				</table>
			</div>
			<div class="col-sm-6">
				<table class="table table-bordered table-striped">
					<tr><td>{{addOrEdit?'权限菜单信息新增':'权限菜单信息修改'}}</td></tr>
					<tr>
						<td>
							<form class="form-horizontal ng-pristine ng-valid"
			action="#" method="post" id="myForm">
			<div class="box-body">
				<div class="form-group" style="padding-right: 10px;">
					<label for="search_aName" class="col-sm-3 control-label">权限ID</label>
					<div class="col-sm-9">
						<input type="hidden"  ng-model="per.pId"
							class="form-control input-sm" placeholder="">
						<input type="hidden"  ng-model="per.pParent"
							class="form-control input-sm" placeholder="">
						<input type="text"  readonly="readonly"
							class="form-control input-sm" value="{{per.pId}}" >
					</div>
				</div>
				<div class="form-group" style="padding-right: 10px;">
					<label for="search_aName" class="col-sm-3 control-label">权限token</label>
					<div class="col-sm-9">
						<input type="text"   ng-model="per.pToken"
							class="form-control input-sm" placeholder="">
					</div>
				</div>
				<div class="form-group" style="padding-right: 10px;">
					<label for="search_aName" class="col-sm-3 control-label">描述</label>
					<div class="col-sm-9">
						<input type="text"  ng-model="per.pDescription"
							class="form-control input-sm" placeholder="">
					</div>
				</div>
				<div class="form-group" style="padding-right: 10px;">
					<label for="search_aName" class="col-sm-3 control-label">菜单URL</label>
					<div class="col-sm-9">
						<input type="text" ng-model="per.pUrl"
							class="form-control input-sm" placeholder="">
					</div>
				</div>
				<div class="form-group" style="padding-right: 10px;">
					<label for="search_aName" class="col-sm-3 control-label">权限类型</label>
					<div class="col-sm-9">
						<select class="form-control input-sm" ng-model="per.pType">
							<option value="1" >菜单</option>
							<option value="2" >操作</option>
						</select>
					</div>
				</div>
				<div class="form-group" style="padding-right: 10px;">
					<label for="search_aName" class="col-sm-3 control-label"></label>
					<div class="col-sm-9">
						<button type="button" class="btn btn-info btn-sm" ng-click="addSubLevel()">新增子级</button>
						<button type="button" class="btn btn-info btn-sm" ng-click="deleteLevel()">删除</button>
						<button type="button" class="btn btn-info btn-sm" ng-click="submit()">保存</button>
					</div>
				</div>
				
			</div>
			<!-- /.box-footer -->
		</form>
						
						</td>
					</tr>
				</table>
			<!-- <pre>{{selectNode|json}}</pre> -->
							<pre>{{per|json}}</pre>
			</div>
			
		</div>	
	</div>
<script type="text/javascript">
</script>
<script type="text/javascript">
angular.module('myApp', []).factory('myService',function myService($http){
	return{
		rolePermissionTree:function rolePermissionTree(query,callback){
			$http({
				method : "post",
				url : "../api/permission/rolePermissionTree",
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
		findPermission:function findPermission(query,callback){
			$http({
				method : "post",
				url : "../api/permission/find",
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
		savePermisson:function savePermisson(query,callback){
			$http({
				method : "post", 
				url : "../api/permission/save",
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
}).controller('roleCtrl',["myService","$scope", "$http",function(myService,$scope, $http){
    
    $scope.init = function(){
    	$scope.addOrEdit = true;
	}
	
	$scope.loadRoleList = function(){
		var param = JSON.stringify({"rDescription":$scope.rDescription});
		myService.loadRoleList(param,function(error,data){
			if(!error){
				console.log(data);
				if(data.code==0){
					if(data.data.length>0){
						$scope.dataShow = true;
						$scope.noDataShow = false;					
						$scope.roleList = data.data;
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
	
	$scope.addSubLevel = function(){
		$scope.addOrEdit = true;
		if(typeof($scope.pParent) == "undefined"){
			$.alert('请选择父级');
		}else{
			//alert($scope.pParent);
			
			$scope.per={};
			$scope.per.pParent = $scope.pParent;
		}
	}
	
	$scope.test = function(id,pId){
		$scope.addOrEdit = false;
		$scope.pParent = id;
		var param = JSON.stringify({"pId":id});
		myService.findPermission(param,function(error,data){
			if(!error){
				console.log(data);
				if(data.code==0){
					$scope.per = data.data;
				}else{
					$.alert({title: '系统提示',content: data.msg});
				}
			}
		});
		
	}
	
	
	$scope.submit = function(){
		var param = JSON.stringify($scope.per);
		myService.savePermisson(param,function(error,data){
			if(!error){
				console.log(data);
				if(data.code==0){
					$.alert(data.msg);
					window.location.reload();
				}else{
					$.alert({title: '系统提示',content: data.msg});
				}
			}
		});
	}
	
	$scope.deleteLevel = function(){
		if(typeof($scope.pParent) == "undefined"){
			$.alert('请选择一级');
		}else{
			
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
			            	var param = JSON.stringify({"pId":$scope.pParent});
			    			myService.deletePermission(param,function(error,data){
			    				if(!error){
			    					console.log(data);
			    					if(data.code==0){
			    						$.alert(data.msg);
			    						window.location.reload();
			    					}else{
			    						$.alert({title: '系统提示',content: data.msg});
			    					}
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
	}
	
}]).directive('tree',["$http",function ($http) {  
    return {  
        require: '?ngModel',  
        restrict: 'A',  
        link: function ($scope, element, attrs, ngModel) {  
            //var opts = angular.extend({}, $scope.$eval(attrs.nlUploadify));  
            var setting = {
            	check: {
			        enable: false
			    },
			    view:{
			        showIcon: false
			    },
                data: { 
                    key: {  
                        title: "t"  
                    },  
                    simpleData: {  
                        enable: true  
                    }  
                },  
                callback: {  
                    onClick: function (event, treeId, treeNode, clickFlag) {
                        $scope.$apply(function () {  
	                    	//alert(JSON.stringify(treeNode));
	                    	
	                    	$scope.test(treeNode.id,treeNode.pId);
                            ngModel.$setViewValue(treeNode);  
                        });  
                    }  
                }  
            };  
  
  			var param = JSON.stringify({"rId":1});
  			$http({
				method : "post",
				url : "../api/permission/rolePermissionTree",
				data : param,
				headers : {
					'Content-Type' : 'application/json;charset=UTF-8'
				}
			}).success(function(data) {
				$.fn.zTree.init(element, setting, data.data).expandAll(true);
			});
  
            /* var zNodes = [  
                { id: 1, pId: 0, name: "普通的父节点", t: "我很普通，随便点我吧", open: true },  
                { id: 11, pId: 1, name: "叶子节点 - 1", t: "我很普通，随便点我吧" },  
                { id: 12, pId: 1, name: "叶子节点 - 2", t: "我很普通，随便点我吧" },  
                { id: 13, pId: 1, name: "叶子节点 - 3", t: "我很普通，随便点我吧" },  
                { id: 2, pId: 0, name: "NB的父节点", t: "点我可以，但是不能点我的子节点，有本事点一个你试试看？", open: true },  
                { id: 21, pId: 2, name: "叶子节点2 - 1", t: "你哪个单位的？敢随便点我？小心点儿..", click: false },  
                { id: 22, pId: 2, name: "叶子节点2 - 2", t: "我有老爸罩着呢，点击我的小心点儿..", click: false },  
                { id: 23, pId: 2, name: "叶子节点2 - 3", t: "好歹我也是个领导，别普通群众就来点击我..", click: false },  
                { id: 3, pId: 0, name: "郁闷的父节点", t: "别点我，我好害怕...我的子节点随便点吧...", open: true, click: false },  
                { id: 31, pId: 3, name: "叶子节点3 - 1", t: "唉，随便点我吧" },  
                { id: 32, pId: 3, name: "叶子节点3 - 2", t: "唉，随便点我吧" },  
                { id: 33, pId: 3, name: "叶子节点3 - 3", t: "唉，随便点我吧" }  
            ];  */ 
            //$.fn.zTree.init(element, setting, zNodes);  
        }  
    };  
}]);  
</script>
</body>
</html>
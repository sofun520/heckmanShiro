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

	<div class="box box-primary" style="min-height: 800px;">
		<!-- <div class="box-header with-border">
            <h3 class="box-title">Bordered Table</h3>
        </div> -->
		<form class="form-horizontal" action="#"
			method="post">
			<div class="box-body">
				<label for="search_aName" class="col-sm-2 control-label">用户名</label>
				<div class="col-sm-2">
					<input type="text" ng-model="uUsername"
						class="form-control input-sm" id="search_aName" placeholder="">
				</div>
				<label for="search_aName" class="col-sm-2 control-label">手机号码</label>
				<div class="col-sm-2">
					<input type="text" ng-model="uPhone"
						class="form-control input-sm" id="search_aName" placeholder="">
				</div>
				<div class="col-sm-4">
					<button type="button" ng-click="loadUserList()" class="btn btn-info btn-sm">查询</button>
					<button type="button" ng-click="reset()" class="btn btn-info btn-sm">清空</button>
					<button type="button" ng-click="addUser()" class="btn btn-info btn-sm">新增</button>
				</div>
			</div>
			<!-- /.box-footer -->
		</form>

		<!-- /.box-header -->
		<div class="box-body">
			<div class=" col-sm-7">
				<table class="table table-bordered table-striped">
					<tbody>
						<tr>
							<th style="width: 10px">#</th>
							<th>用户名</th>
							<th>手机号码</th>
							<!-- <th>状态</th> -->
							<th>新增时间</th>
							<th style="width: 200px">操作</th>
						</tr>
						<tr ng-if="noDataShow">
							<td colspan="8" align="center">没有数据</td>
						</tr>
						<tr ng-if="dataShow" ng-repeat="x in userList track by $index">
							<td>{{$index+1}}</td>
							<td>{{x.uUsername}}</td>
							<td>{{x.uPhone}}</td>
							<!-- <td>{{x.rStatus}}</td> -->
							<td>{{x.uAddTime | date:'yyyy-MM-dd'}}</td>
							<td align="center"><a href="javascript:void(0)"
								ng-click="delRole(x.uId)">删除</a>&nbsp;&nbsp;&nbsp;&nbsp;<a
								href="javascript:void(0)" ng-click="editUser(x.uId)">修改</a>
								&nbsp;&nbsp;<a href="javascript:void(0)" ng-click="assignMenu(x.uId)">分配角色</a>
								</td>
								
						</tr>
					</tbody>
				</table>
			</div>
			<div class="col-sm-5">
				<div ng-if="assignMenuShow">
					<table class="table table-bordered table-striped">
						<tr><td>分配角色</td></tr>
						<tr>
							<td height="400">
								<ul id="treeDemo" class="ztree"></ul>
								<br>
								<ul tree class="ztree" ng-model="selectNode"></ul> 
							</td>
						</tr>
					</table>
					<a href="javascript:void(0)" class="btn btn-info btn-sm" ng-click="save()">保存</a>
				</div>
				<div ng-if="editUserShow">
					<table class="table table-bordered table-striped">
						<tr><td>{{addOrEditFlag?'新增用户':'修改用户信息'}}</td></tr>
						<tr>
							<td>
								<form class="form-horizontal" id="myForm"
						method="post">
						<div class="box-body">
							<div class="form-group" style="padding-right: 0px;">
								<label for="search_aName" class="col-sm-3 control-label">用户ID</label>
								<div class="col-sm-9">
									<input type="hidden" ng-model="userInfo.uId"
										class="form-control input-sm" placeholder="">
									<input type="text" readonly="readonly" ng-model="userInfo.uId"
										class="form-control input-sm" placeholder="">
								</div>
							</div>
							<div class="form-group" style="padding-right: 0px;">
								<label for="search_aName" class="col-sm-3 control-label">用户名</label>
								<div class="col-sm-9">
									<input type="text" ng-model="userInfo.uUsername" required ng-readonly="usernameReadOnly"
										class="form-control input-sm" id="search_aName" placeholder="">
								</div>
							</div>
							<div class="form-group" style="padding-right: 0px;">
								<label for="search_aName" class="col-sm-3 control-label">手机号码</label>
								<div class="col-sm-9">
									<input type="text" ng-model="userInfo.uPhone" required
										class="form-control input-sm" id="search_aName" placeholder="">
								</div>
							</div>
							<div class="form-group" style="padding-right: 0px;">
								<label for="search_aName" class="col-sm-3 control-label">邮箱地址</label>
								<div class="col-sm-9">
									<input type="text" ng-model="userInfo.uEmail" required
										class="form-control input-sm" id="search_aName" placeholder="">
								</div>
							</div>
							<div class="form-group" style="padding-right: 0px;">
								<label for="search_aName" class="col-sm-3 control-label"></label>
								<div class="col-sm-9">
									<button type="button" ng-click="submit()" class="btn btn-info btn-sm">保存</button>
									<button type="button" ng-click="reset()" class="btn btn-info btn-sm">重置</button>
								</div>
							</div>
						</div>
						<!-- /.box-footer -->
					</form>
							</td>
						</tr>
					</table>
				</div>
			</div>
<script type="text/javascript">
</script>
<script type="text/javascript">
angular.module('myApp', []).factory('myService',function myService($http){
	return{
		loadUserList:function loadUserList(query,callback){
			$http({
				method : "post",
				url : "../api/user/query",
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
		deleteRole:function deleteRole(query,callback){
			$http({
				method : "post",
				url : "../api/role/delete",
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
		userRoleTree:function userRoleTree(query,callback){
			$http({
				method : "post",
				url : "../api/user/userRoleTree",
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
		saveUserRole:function saveUserRole(query,callback){
			$http({
				method : "post",
				url : "../api/user/saveUserRole",
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
		findUser:function findUser(query,callback){
			$http({
				method : "post",
				url : "../api/user/find",
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
		saveUser:function saveUser(query,callback){
			$http({
				method : "post",
				url : "../api/user/save",
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
	/* var treeObj;
	treeObj=$.fn.zTree.init($("#treeDemo"), setting, data.returnData);
    treeObj.expandAll(true); */
    
    $scope.init = function(){
    	$scope.assignMenuShow = false;
    	$scope.editUserShow = true;
    	$scope.addOrEditFlag = true;
    
		$scope.roleId = 0;
		$scope.loadUserList();
	}
	
	$scope.loadUserList = function(){
		var param = JSON.stringify({"uUsername":$scope.uUsername,"uPhone":$scope.uPhone});
		myService.loadUserList(param,function(error,data){
			if(!error){
				console.log(data);
				if(data.code==0){
					if(data.data.length>0){
						$scope.dataShow = true;
						$scope.noDataShow = false;					
						$scope.userList = data.data;
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
	
	$scope.delRole = function(pId){
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
	
	/* $scope.addRole = function(id){
		//window.location.href='editRole';
	}
	
	$scope.editRole = function(id){
		window.location.href='editRole?id='+id;
	} */
	
	$scope.delRole = function(id){
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
		            	var param = JSON.stringify({"rId":id});
		            	myService.deleteRole(param,function(error,data){
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
	
	
	$scope.reset = function(){
		$scope.uUsername = '';
		$scope.uPhone = '';
	}
	
	var treeObj;
	$scope.assignMenu = function(id){
		$scope.assignMenuShow = true;
    	$scope.editUserShow = false;
	
		$scope.roleId = id;
		
		$scope.setting = {
	         check: {
	             enable: true
	         },
	         data: {
	             simpleData: {
	                 enable: true
	             }
	         },
	         view:{
	             showIcon: false
	         }
	     };
	
		var param = JSON.stringify({"uId":id});
		myService.userRoleTree(param,function(error,data){
			if(!error){
				console.log(data);
				if(data.code==0){
					treeObj=$.fn.zTree.init($("#treeDemo"), $scope.setting, data.data);
                    treeObj.expandAll(true);
				}else{
					$.alert({title: '系统提示',content: data.msg});
				}
			}
		});
	}
	
	
	$scope.save = function(){
		if($scope.roleId!=0){
			var menuId='';
			 var nodes=treeObj.getCheckedNodes(true);
			 for(var i=0;i<nodes.length;i++){
		             if(i==nodes.length-1){
		            	menuId+=nodes[i].id;
		            }else{
		                menuId+=nodes[i].id+',';
		            }
		         }
				
				var param = JSON.stringify({"uUsername":menuId,"uId":$scope.roleId});
				myService.saveUserRole(param,function(error,data){
					if(!error){
						console.log(data);
						if(data.code==0){
							$scope.assignMenu($scope.roleId);
							//window.location.reload();
						}else{
							$.alert({title: '系统提示',content: data.msg});
						}
					}
				});
		}else{
			$.alert('请为用户勾选角色！');
		}
	}
	
	$scope.addUser = function(){
		$scope.assignMenuShow = false;
    	$scope.editUserShow = true;
    	$scope.addOrEditFlag = true;
    	$scope.usernameReadOnly = false;
    	$scope.userInfo = {};
	}
	
	$scope.editUser = function(id){
		$scope.usernameReadOnly = true;
		$scope.assignMenuShow = false;
    	$scope.editUserShow = true;
    	$scope.addOrEditFlag = false;
		$scope.userInfo = {};
		var param = JSON.stringify({"uId":id});
		myService.findUser(param,function(error,data){
			if(!error){
				console.log(data);
				if(data.code==0){
					$scope.userInfo = data.data;
				}else{
					$.alert({title: '系统提示',content: data.msg});
				}
			}
		});
	}
	
	
	$scope.submit = function(){
		var param = JSON.stringify($scope.userInfo);
		myService.saveUser(param,function(error,data){
			if(!error){
				console.log(data);
				if(data.code==0){
					window.location.reload();
				}else{
					$.alert({title: '系统提示',content: data.msg});
				}
			}
		});
	}
	
}]).directive('tree',function(){ 
  return{ 
    require:'?ngModel', 
    restrict:'A', 
    link:function($scope,element,attrs,ngModel){ 
      var setting = { 
        data :{ 
          simpleData:{ 
            enable:true
          } 
        }, 
        callback:{ 
          beforeClick:function(treeId, treeNode) {//点击菜单时进行的处理 
            var zTree = $.fn.zTree.getZTreeObj("tree"); 
            if (treeNode.isParent) { 
              zTree.expandNode(treeNode); 
              return false; 
            } else { 
              window.location.href=treeNode.url; 
              return true; 
            } 
          } 
        } 
      }; 
      //向控制器发送消息，进行菜单数据的获取 
      $scope.$emit("menu",attrs["value"]);//此处attrs["value"]为ul中的value值，此处作为标记使用 
      //接受控制器返回的菜单的消息 
      $scope.$on("menuData",function(event,data){ 
        $.fn.zTree.init(element, setting, data);//进行初始化树形菜单 
        var zTree = $.fn.zTree.getZTreeObj("tree"); 
        var selectName = $("#selectName").val(); 
        if(typeof selectName == "undefined" || selectName == ""){ 
          zTree.selectNode(zTree.getNodeByParam("id","1"));//默认第一个选中 
          $("#selectName").val(zTree.getSelectedNodes()[0].code);//赋值 
        }else{ 
          for(var i =0; i<data.length;i++){ 
            if(data[i]["code"] == selectName ){ 
              zTree.selectNode(zTree.getNodeByParam("code", data[i]["code"])); 
            } 
          } 
        } 
      }); 
  
    } 
  } 
});
</script>
</body>
</html>
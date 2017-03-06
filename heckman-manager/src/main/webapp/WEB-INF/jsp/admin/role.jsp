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
				<label for="search_aName" class="col-sm-2 control-label">角色名称</label>
				<div class="col-sm-2">
					<input type="text" ng-model="rDescription"
						class="form-control input-sm" id="search_aName" placeholder="">
				</div>
				<div class="col-sm-7">
					<button type="button" ng-click="loadRoleList()" class="btn btn-info btn-sm">查询</button>
					<button type="button" ng-click="reset()" class="btn btn-info btn-sm">清空</button>
					<button type="button" ng-click="addRole()" class="btn btn-info btn-sm">新增</button>
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
							<th>角色名称</th>
							<th>角色代码</th>
							<!-- <th>状态</th> -->
							<th>新增时间</th>
							<th style="width: 200px">操作</th>
						</tr>
						<tr ng-if="noDataShow">
							<td colspan="8" align="center">没有数据</td>
						</tr>
						<tr ng-if="dataShow" ng-repeat="x in roleList track by $index">
							<td>{{$index+1}}</td>
							<td>{{x.rDescription}}</td>
							<td>{{x.rName}}</td>
							<!-- <td>{{x.rStatus}}</td> -->
							<td>{{x.rAddTime | date:'yyyy-MM-dd'}}</td>
							<td align="center"><a href="javascript:void(0)"
								ng-click="delRole(x.rId)">删除</a>&nbsp;&nbsp;&nbsp;&nbsp;<a
								href="javascript:void(0)" ng-click="editRole(x.rId)">修改</a>
								&nbsp;&nbsp;<a href="javascript:void(0)" ng-click="assignMenu(x.rId)">分配权限菜单</a>
								</td>
								
						</tr>
					</tbody>
				</table>
			</div>
			<div class="col-sm-5">
				<table class="table table-bordered table-striped">
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
<script type="text/javascript">
</script>
<script type="text/javascript">
angular.module('myApp', []).factory('myService',function myService($http){
	return{
		loadRoleList:function loadRoleList(query,callback){
			$http({
				method : "post",
				url : "../api/role/query",
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
		saveRolePermission:function saveRolePermission(query,callback){
			$http({
				method : "post",
				url : "../api/permission/saveRolePermission",
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
		$scope.roleId = 0;
		$scope.loadRoleList();
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
	
	$scope.addRole = function(id){
		window.location.href='editRole';
	}
	
	$scope.editRole = function(id){
		window.location.href='editRole?id='+id;
	}
	
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
		$scope.rDescription = '';
	}
	
	var treeObj;
	$scope.assignMenu = function(id){
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
	
		var param = JSON.stringify({"rId":id});
		myService.rolePermissionTree(param,function(error,data){
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
				
				var param = JSON.stringify({"pDescription":menuId,"pId":$scope.roleId});
				myService.saveRolePermission(param,function(error,data){
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
			$.alert('请为具体角色勾选权限菜单！');
		}
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
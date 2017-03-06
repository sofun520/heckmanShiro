var app = angular.module('myApp', []);
		app.factory('myService',function myService($http){
			return{
				loadSubMenus:function loadSubMenus(query, callback){
					$http({
						method : "post",
						url : "../heckman/api/permission/getUserMenus",
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
				loadUserPermissions:function loadUserPermissions(query, callback){
					$http({
						method : "post",
						url : "../heckman/api/permission/getUserPermission",
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
				loadUserInfo:function loadUserInfo(query, callback){
					$http({
						method : "post",
						url : "../heckman/api/user/userInfo",
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
				logout:function logout(callback){
					$http({
						method : "post",
						url : "../heckman/logout",
						//data : JSON.stringify({}),
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
		});
		app.controller('homeCtrl',["myService","$scope", "$http",function(myService,$scope, $http) {

			$scope.init = function() {
				//$scope.permission();
				$scope.loadUserPermissions();
				
				$scope.loadParentMenu();
				
				//$scope.loadSubMenu(2);
				$scope.loadUserInfo();
			}
			
			$scope.loadUserPermissions = function(){
				var query = JSON.stringify({});
				myService.loadUserPermissions(query,function(error,data){
					if (!error) {  
						console.log(data);
						$scope.permission = {};
						angular.forEach(data.data, function(data,index,array){
							console.log(data.pToken);
							$scope.permission[data.pToken]=true;
						});
			        }
				});
			}
			
			$scope.permission = function(){
				$scope.permission = {};
				$scope.permission['system.admin']=true;
				return $scope.permission;
			}

			
			$scope.loadParentMenu = function(){
				var query = JSON.stringify({"pType":"1","pParent":"1"});
				myService.loadSubMenus(query,function(error,data){
					if (!error) {  
						console.log(data);
						if(data.data.length>0){
							$scope.menus = data.data;
							$scope.loadSubMenu(data.data[0].pId);
						}
			        }
				});
			}
			
			$scope.loadSubMenu = function(parentId) {
				var query = JSON.stringify({"pParent":parentId});
				myService.loadSubMenus(query,function(error,data){
					if (!error) {  
						console.log(data);
						$scope.submenus = data.data;
						console.log(data.data[0].pUrl);
						$scope.subframe(data.data[0].pUrl);
			        }
				});
			};
			
			$scope.loadUserInfo = function(parentId) {
				var query = JSON.stringify({"pParent":parentId,"pType":"1"});
				myService.loadUserInfo(query,function(error,data){
					if (!error) {  
						data.data.uPic = "../heckman/"+data.data.uPic;
						$scope.userInfo = data.data;
						console.log(data);
			        }
				});
			};

			$scope.subframe = function(url) {
				$("#iframe").attr('src', url);
			};
			
		    $scope.logout = function(){
		    	$.confirm({
				    title: '系统提示',
				    content: '是否退出系统?',
				    type: 'blue',
				    typeAnimated: true,
				    buttons: {
				        tryAgain: {
				            text: '确定',
				            btnClass: 'btn-blue',
				            action: function(){
				            	myService.logout(function(error,data){
				            		if(!error){
				            			if(data.code==0){
				            				window.location.href='../heckman/index.jsp';
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
		}])

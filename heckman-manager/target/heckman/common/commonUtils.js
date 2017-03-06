angular.module('commonUtils', []).constant("appConstant",{
	BASE_URL:""
}).factory("commonUtils",[]);
app.controller('commonUtils',["$scope", "$http",function($scope, $http) {
	$scope.getPermissions = function(){
		$http({
			method : "post",
			url : "../permission",
			data : JSON.stringify({"pParent":parentId,"pType":"1"}),
			headers : {
				'Content-Type' : 'application/json;charset=UTF-8'
			}
		}).success(function(data) {
			console.log("==================="+data);
		});
	}
}]);

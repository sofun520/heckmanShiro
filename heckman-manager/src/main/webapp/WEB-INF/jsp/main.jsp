<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="m" uri="/mytags"%><!--引入我们的标签-->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script
	src="https://cdn.static.runoob.com/libs/jquery/1.10.2/jquery.min.js">
</script>
<style type="text/css">
#st1{
	height: 25px;
	border: 1px solid #333;
	width:100px;
}

#st2{
	background-color: #000;
	height:25px;
}
</style>>
</head>
<body>
	<shiro:user>  
欢迎[<shiro:principal />]登录，<a href="<%=request.getContextPath()%>/logout">退出</a>
	</shiro:user>
	<br>

	<shiro:authenticated>  
    用户[<shiro:principal />]已身份验证通过  
</shiro:authenticated>
	<br> 显示用户身份：
	<shiro:principal type="java.lang.String" />
	<br>


	<shiro:hasRole name="admin">  
    用户[<shiro:principal />]拥有角色admin<br />
	</shiro:hasRole>
	<br>

	<shiro:hasAnyRoles name="admin,sys_admin">  
    用户[<shiro:principal />]拥有角色admin或sys_admin<br />
	</shiro:hasAnyRoles>
	<br>

	<shiro:hasPermission name="system.admin">  
    用户[<shiro:principal />]拥有权限system.admin<br />
	</shiro:hasPermission>

	<br>
	<br>
	<br>
	<br>
	<m:auth privilege="user.user.query">
		【管理员权限才能显示】
	</m:auth>
	<br> login successfully!!!!123

	<br>
	<a href="logout">退出</a>
	
	<br>
	<p id="st"></p>
	<div id="st1">
		<div id="st2"></div>
	</div>
	<button id="importBtn">导入</button>
<br>

	<script type="text/javascript">
		var timerId = null;//定时器ID
		$(document).ready(function() {

			timerId = setInterval(function() {
				getStatus();
			}, 5000);
			
			<%-- timerId = setInterval(function() {
				getStatus();
			}, 2000);

			$("#importBtn").click(function() {
				
				
				$.get('<%=request.getContextPath()%>/task/async',function(data){
					console.log(JSON.stringify(data));
				});
			}); --%>
			
			
		});
		
		function getStatus(){
			$.get('<%=request.getContextPath()%>/task/async/status',function(data){
				console.log('========'+timerId)
				if(data && data.msg==="100%"){
					$("#st").html('已完成：'+data.msg);
					clearInterval(timerId);	
					//window.location.reload();
				}else{
					$("#st").html('已完成：'+data.msg);
					console.log(JSON.stringify(data));
				}
			});
		}
		
		function clearStatus(){
			$.get('<%=request.getContextPath()%>/task/async/clear',function(data){
				
			});
		}
	</script>
</body>
</html>
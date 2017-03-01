<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script
	src="https://cdn.static.runoob.com/libs/jquery/1.10.2/jquery.min.js">
	
</script>
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
	<shiro:principal property="username" />
	<br> login successfully!!!!

	<br>
	<a href="logout">退出</a>
	<br>


	<button id="importBtn">导入</button>


	<script type="text/javascript">
		$(document).ready(function() {

			var timerId = null;//定时器ID

			$("#importBtn").click(function() {
				$.get('<%=request.getContextPath()%>/task/async',function(data){
					console.log(JSON.stringify(data));
				});
			});
			
			timerId = setInterval(function() {
				getStatus();
			}, 1000);

		});
		
		function getStatus(){
			$.get('<%=request.getContextPath()%>/task/async/status',function(data){
					console.log(JSON.stringify(data));
			});
		}
		
		function clearStatus(){
			$.get('<%=request.getContextPath()%>/task/async/clear',function(data){
				
			});
		}
	</script>

</body>
</html>
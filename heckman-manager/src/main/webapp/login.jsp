<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function reloadVerifyCode() {
		alert('sdf');
		document
				.getElementById('verifyCodeImage')
				.setAttribute('src',
						'${pageContext.request.contextPath}/heckman/getVerifyCodeImage');
	}
</script>
</head>
<body>

	<shiro:guest>  
欢迎游客访问，<a href="<%=request.getContextPath()%>/login.jsp">登录</a>
	</shiro:guest>

	<%=request.getAttribute("message_login")%>
	<form action="<%=request.getContextPath()%>/login" method="POST">
		姓名：<input type="text" name="username" value="admin" /><br /> 密码：<input
			type="text" name="password" value="admin" /><br /> 验证：<input
			type="text" name="verifyCode" /> &nbsp;&nbsp; <img
			id="verifyCodeImage" onclick="reloadVerifyCode()"
			src="<%=request.getContextPath()%>/getVerifyCodeImage" /><br /> <input
			type="submit" value="确认" />
	</form>
</body>
</html>
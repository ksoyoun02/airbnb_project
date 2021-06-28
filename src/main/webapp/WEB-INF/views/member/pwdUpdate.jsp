<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file= "/resources/includes/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath == '/' ? '': pageContext.request.contextPath}" scope="application"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.frm_input {
	margin-top: 80px;
    margin-left: 20px;
    width: 250px;
    border: none;
    border-bottom: 1px solid;
}

.go {
	width: 200px;
	height: 50px; 
	border: none; 
	border-radius: 30px; 
	font-family: 'NANUM'; 
	font-size: 20px; 
	font-weight: bold;
	margin: 10px 0 50px 150px;
}
</style>
</head>
<body>
<div style="margin-left: 200px; margin-top: 120px;">
	<h1 style="margin-bottom: 0">비밀번호변경</h1>
	<hr width="480px" style="margin-left:10px;"><br><br>
	<form action="/airbnb/member/pwdUpdate" method="post" style="margin-left: 100px;">
			<input type="hidden" name="id" value="${sessionScope.loginUser.id}">
		<div style="height: 150px;">
			<h2 style="float: left;">기존비밀번호 : </h2>
			<input type="text" id="old_pwd" name="old_pwd" class="frm_input">
		</div>
		<div style="height: 150px;">
			<h2 style="float: left;">새 비밀번호 : </h2>
			<input type="text" id="new_pwd" name="new_pwd" class="frm_input">
		</div>
		
		<input type="submit" value="비밀번호 변경하기" class="go">
	</form>
</div>
</body>
<footer>
<%@ include file="/resources/includes/footer.jsp" %>
</footer>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file= "/resources/includes/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath == '/' ? '': pageContext.request.contextPath}" scope="application"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Find ID Result</title>

</head>
<body>
<div style="margin: 120px 200px 120px 200px;">
	<h1 style="margin-bottom: 0">아이디찾기</h1>
	<hr width="480px" style="margin-left:10px;"><br><br>
	
	<div style="text-align: center; background-color: rgb(0,0,0,0.05); padding-top: 15px; width: 700px; padding-bottom: 15px; margin: auto;">
		<h2 style="margin-top: 20px;">검색결과</h2>
		<div>
			<h3>ID : ${findId.id}</h3>
			<h3>이름 : ${findId.name}님</h3>
			<h3>가입일자 : <fmt:formatDate value="${findId.indate}" pattern="yyyy-MM-dd"/></h3>
		</div>
		<input type="button" onclick="location.href='/member/login'" value="로그인하기" style="margin: 10px; padding: 10px 15px; border:none; border-radius: 50px; background-color: white; font-size: 20px; font-family: 'NANUM'; font-weight: bold;">
	</div>
</div>
</body>
</html>
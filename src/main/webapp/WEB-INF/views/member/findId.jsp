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
input {
	border: none;
    border-bottom: 1px solid;
    margin-left: 20px;
    font-family: "NANUM";
    font-size: 20px
   }
h2 {
	font-size: 60px;
}
h3 {
	font-size: 30px;
}
</style>
</head>
<body>
<div style="margin: 120px 200px 120px 200px;">
	<h1 style="margin-bottom: 0">아이디찾기</h1>
	<hr width="480px" style="margin-left:10px;"><br><br>
	
	<div style="padding: 30px; float: left; margin: 0 200px 0 200px; text-align: center;">
		<h2>전화번호로 찾기</h2>
		<form action="/airbnb/member/findIdPhone" method="post" style="text-align: center;">
			<h3>이름 : <input type="text" name="name" style="width: 300px;"></h3>
			<h3>전화번호 : <input type="text" name="phone" placeholder="숫자만 입력해주세요" style="width: 300px;"></h3>
			<input type="submit" value="검색" style="font-weight: bold; font-family: NANUM; font-size:20px; border: none; border-radius: 40px; width: 300px; height: 40px; margin-top: 15px">
		</form>
	</div>
	
	<div style="padding: 30px; margin: 0 200px 0 200px;  text-align: center;" >	
		<h2>이메일로 찾기</h2>
		<form action="/airbnb/member/findIdEmail" method="post" style="text-align: center;">
			<h3>이름 : <input type="text" name="name" style="width: 300px;"></h3>
			<h3>이메일 : <input type="text" name="email" placeholder="정확한 형식으로 입력해주세요" style="width: 300px;"></h3>
			<input type="submit" value="검색" style="font-weight: bold; font-family: NANUM; font-size:20px; border: none; border-radius: 40px; width: 300px; height:40px; margin-top: 15px"></input>
		</form>
	</div>
</div>
<%@ include file="/resources/includes/footer.jsp" %>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath == '/' ? '': pageContext.request.contextPath}" scope="application"/>
<%@ include file= "/resources/includes/header.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.easylogin img {
	width: 100px;
	height: 100px;
	object-fit: cover;
	
}
input {
	font-family: "NANUM";
	font-size: 20px;
	font-weight: bold;
}
</style>
</head>
<body>
<article class="login" style="height: 950px;">
	<h1>로그인</h1><br>
	<hr width="980px"><br><br>
	<form action="/airbnb/member/login" method="post">
		<fieldset>
			<div class="loginbox">
				<label><h2>아이디 :</h2></label>
				<input name="id" type="text" placeholder="아이디를 입력하세요" style="font-size: 18px;"><br>
				<label><h2>비밀번호 :</h2></label>
				<input name="pwd" type="password" placeholder="비밀번호를 입력하세요" style="font-size: 18px">
			</div>
		</fieldset>
	
		<div class="main_join">
			<input type="button" class="gomain" value="홈으로 가기" onclick="location.href = '/airbnb/main'" style="border-style: none;">
			<input type="submit" class="gojoin" value="로그인하기" style="border-style: none; font-family: 'NANUM';">
		</div>
		<hr width="980px"><br>
		<div id="buttons">
			<input type="button" value="회원가입" class="submit" onclick="location.href = '/airbnb/member/join'">
			<input type ="button" value="아이디찾기" class="submit" onclick="location.href = '/airbnb/member/findId'">
			<input type ="button" value="비밀번호찾기" class="submit" onclick="location.href = '/airbnb/member/findPwd'">
		</div>
		<div class="easylogin" style="width: 60%; height:100px; margin: auto; text-align: center;">
		<br>
			<h2>간편로그인</h2>
				<img src="${ctx }/resources/images/facebook.jpg">
				<img src="${ctx }/resources/images/kakao.jpg" style="margin-left: 20px">
				<img src="${ctx }/resources/images/naver.png" style="width: 130px;">
		</div>
	</form>
</article>

<%@ include file="/resources/includes/footer.jsp" %>
</body>
</html>
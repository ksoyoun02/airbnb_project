<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">

	.menu {
	top: 560px;
	position: absolute;
	}
	
	.menu ul {
    list-style-type: none;
    margin: 0;
    padding: 0;
    width: 200px;
    background-color: #f1f1f1;
	}
	
	.menu li a {
    display: block;
    color: #000;
    padding: 8px 16px;
    text-decoration: none;
    font-family: "NANUM";
    font-weight: bold;
	}
	
	.menu li a.active {
    background-color: #4CAF50;
    color: white;
	}
	
	.menu li a:hover:not(.active) {
    background-color: #555;
    color: white;
	}
</style>
</head>
<body>
<div class="menu">
	<ul>
      <li><a href="/airbnb/member/mypage">회원정보</a></li>
      <li><a href="/airbnb/member/myReserve?userId=${sessionScope.loginUser.id}">예약목록</a></li>
      <li><a href="/airbnb/member/myReview?userId=${sessionScope.loginUser.id}">나의후기</a></li>
    </ul>
</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath == '/' ? '': pageContext.request.contextPath}" scope="application"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>header</title>
<link href="${ctx }/resources/css/projectmain.css" rel="stylesheet">
<!-- <script type="text/javascript" src="js/member.js"></script> -->
<style type="text/css">
@font-face {
	src : url("${ctx }/resources/fonts/Avenir Light.ttf");
	font-family: "Light";
}	
@font-face {
	src : url("${ctx }/resources/fonts/BMHANNAPro.ttf");
	font-family: "HANNA";
}  

@font-face {
	src : url("${ctx }/resources/fonts/NanumBarunpenR.ttf");
	font-family: "NANUM";
}

@font-face {
	src : url("${ctx }/resources/fonts/NanumBarunpenR.ttf");
	font-family: "NANUMb";
}
.headB li a{
	font-family: "NANUMb";
	font-weight: bold;
}
</style>
</head>
<body>
<header class="head-color" style="height: 280px;">
		<div class="logo">
			<a href="/airbnb/main"><img alt="logo" src="${ctx }/resources/images/그림1.webp"></a>
		</div>
		<nav class="headB">
				<div>
				<ul>
					<li><a href="/airbnb/main">HOME</a></li>
					<li><a href="/airbnb/room/roomList?r_sido=1835848&r_accomCheckIn=&r_accomCheckOut=">숙소예약</a></li>
					<c:choose>
						<c:when test="${empty sessionScope.loginUser}">
							<li><a href="/airbnb/member/login">로그인</a></li>
							<li><a href="/airbnb/member/join">회원가입</a></li>
						</c:when>
						<c:otherwise>
							<%-- <li style="color: orange">
								${sessionScope.loginUser.name}(${sessionScope.loginUser.id})
							</li> --%>
							<li><a href="/airbnb/member/logout">로그아웃</a></li>
						</c:otherwise>
					</c:choose>
					<c:choose>
						<c:when test="${empty sessionScope.loginUser }">
							<li><a href="/airbnb/member/login">마이페이지</a>
								<ul>
									<li><a>회원정보</a></li>
									<li><a>예약목록</a></li>
									<li><a>나의후기</a></li>
								</ul>	
							</li>
						</c:when>
						<c:otherwise>
							<li><a href="/airbnb/member/mypage">마이페이지</a>
								<ul>
									<li><a>회원정보</a></li>
									<li><a>예약목록</a></li>
									<li><a>나의후기</a></li>
								</ul>	
							</li>
						</c:otherwise>
					</c:choose>
					<li><a href="/airbnb/board/list">고객센터</a></li>
				</ul>
			</div>
			<div style="text-align: end; margin-right: 250px;">
				<c:if test="${not empty sessionScope.loginUser}">
					<span style="font-family: 'NANUM'; font-weight: bold;">${loginUser.name}(${loginUser.id})님 반갑습니다</span>
				</c:if>
			</div>
			</nav>
			
	</header>
</body>
</html>
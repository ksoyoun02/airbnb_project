<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath == '/' ? '': pageContext.request.contextPath}" scope="application"/>
<%@ include file="/resources/includes/header.jsp"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function delectReview(obj) {
		if(confirm("정말 삭제하시겠습니까?") == true){
			window.location.href = "${ctx}/review/deleteReview?r_no=" + obj;
			
		}else{
			return false;
		}
	}
</script>
<style type="text/css">

.r_img img{
	width: 315px;
    height: 210px;
    object-fit: cover;
    margin: 40px;
}

h3 {
	padding-top: 30px;
	font-family: "HANNA";
	font-size: 40px;
	margin-bottom: 0;
}

.content p {
	font-family:"NANUM";
	font-size: 20px;
}
a { 
	color:lightslategray;
	text-decoration:none; 
} 
</style>
</head>
<body>
<div style="margin-left: 200px; margin-top: 120px;">
	<h1 style="margin-bottom: 0">나의후기</h1>
	<hr width="480px" style="margin-left:10px;"><br><br>
	<%@ include file="/resources/includes/memberMenu.jsp" %>
	<main style="margin-left: 280px;">
	<c:forEach items="${userReviewList}" var="r_list" begin="0" step="1">
		<div style="background-color: aliceblue; width: 1100px;">
			<form name="frm" style="height: 280px; margin-bottom: 40px; padding-top: 5px;">
					<div class="r_img" style="float: left">
						<img src="${r_list.r_img}">
					</div>
					<div class="content">
						<div style="float: left;">
							<h3 style="margin-top: 0;"  ><a href="/airbnb/room/roomDetail?r_code=${r_list.r_r_code}">${r_list.r_name}</a></h3>
							<p style="margin-top: 0; margin-left: 30px; margin-bottom:0; color:#848484;">객실 종류 : ${r_list.r_g_name}</p>
							<p style="font-size: 15px;">나의 별점 : ${r_list.r_score}점</p>
							<input type="text" value="${r_list.r_content}" disabled="disabled" style="height: 70px; width: 400px;">
						</div>
						<div>
							<p>작성일 : ${r_list.r_date}</p>
						</div>
					</div>
					<div>
						<input type="button" value="삭제하기" style="margin: 130px 0 0 160px; padding: 10px 20px 10px 20px;" onclick="delectReview(${r_list.r_no})">
					</div>
			</form>	
		</div>
	</c:forEach>
	</main>
</div>
<br>
<%@ include file="/resources/includes/footer.jsp" %>
</body>
</html>
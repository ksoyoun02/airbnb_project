<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/resources/includes/header.jsp" %>
<c:set var="contextPath" value="${pageContext.request.contextPath == '/' ? '' : pageContext.request.contextPath }" scope="application" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
	function delectReserve(obj) {
		if(confirm("정말 취소/삭제하시겠습니까?") == true){
			window.location.href = "${ctx}/member/deleteReserve?r_no=" + obj;
			
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

input {
	font-family: "NANUM";
	font-weight: bold;
	font-size: 20px;
}
</style>
</head>
<body>
<div style="margin-left: 200px; margin-top: 120px;">
	<h1 style="margin-bottom: 0">예약목록</h1>
	<hr width="480px" style="margin-left:10px;"><br><br>
	<%@ include file="/resources/includes/memberMenu.jsp" %>
	
	<main style="margin-left: 280px;">
	<c:forEach items="${userReserveList}" var="RList" begin="0" step="1" varStatus="i">
		<div style="background-color: aliceblue; width: 1100px;">
			<div>
				<form action="/airbnb/review/reviewForm" method="post" style="height: 280px; margin-bottom: 40px;">
					<div class="r_img" style="float: left">
						<img src="${RList.r_img}">
					</div>
					<div>
						<input type="hidden" value="${RList.r_no}" name="r_no">
						<input type="hidden" value="${RList.id}" name="id">
						<input type="hidden" value="${RList.r_name}" name="r_name">
						<input type="hidden" value="${RList.r_code}" name="r_code">
						<input type="hidden" value="${RList.r_img}" name="r_img">
						<input type="hidden" value="${RList.r_checkIn}" name="r_checkIn">
						<input type="hidden" value="${RList.r_checkOut}" name="r_checkOut">
						<input type="hidden" value="${RList.r_g_code}" name="r_g_code">
						<input type="hidden" value="${RList.r_g_name}" name="r_g_name">
					</div>
					<div class="content">
						<h3 style="margin-top: 0; padding-bottom: 5px; float: left;"><a href="/airbnb/room/roomDetail?r_code=${RList.r_code}">${RList.r_name}</a></h3>
						<div>
							<p id="result${i.index}" style="padding: 20px 50px 0 0; text-align: end; font-size: 30px; margin-bottom: 20px;"></p>
						</div>
						<p style="margin: 0;">${RList.r_g_name}</p>
						<p style="margin-top: 10px;">${RList.r_address}<p>
						<div style="float: left; margin: 0 30px 0 50px; border-right-style: dashed; border-right-width: 1px; padding-right: 50px;">
							<p>체크인</p>
							<p>${RList.r_checkIn}</p>
							<input type="hidden" value="${RList.r_checkIn}" id="checkIn_${i.index }">
						</div>
						<div style="float: left; margin: 0 120px 0 30px;">
							<p>체크아웃</p>
							<p>${RList.r_checkOut}</p>
							<input type="hidden" value="${RList.r_checkOut}" id="checkOut_${i.index }">
						</div>
						<div>
							<p style="margin-left: 890px;">총 금액 : ${RList.r_price}
						</div>
					</div>
					<div style="text-align: end; margin-right: 25px;">
						<input type="submit" value="후기작성" id="review${i.index}" style="padding: 10px 20px 10px 20px; float: left; border: none; border-radius: 20px; width: 120px;">
						<input type="button" value="예약취소" id="cancle${i.index}" onclick="delectReserve(${RList.r_no})" style="padding: 10px 20px 10px 20px; border: none; border-radius: 20px; width: 120px;">
					</div>
				</form>
			</div>
		</div>
	</c:forEach>
	</main>
</div>
<br>
<script type="text/javascript">

	var now = new Date();
	var year = now.getFullYear();
	var month = now.getMonth();
	var date = now.getDate();
	
	var today = year+""+0+(month+1)+""+date;
	console.log("오늘날짜 = " + today);
	
	for(var i = 0 ; i <10 ; i++){
		var checkini = document.getElementById('checkIn_'+i).value;
		var checkouti = document.getElementById('checkOut_'+i).value;
		
		var checkin_i = checkini.replace(/\./g,'');
		var checkout_i = checkouti.replace(/\./g,'');
		
		var text= 0;
		var dday= "";
		
		var review = document.getElementById('review'+i);
		var cancle = document.getElementById('cancle'+i);
		if(today == checkin_i){
			dday = "D-DAY";
			document.getElementById("result"+i).innerHTML = dday;
			
		}else if(today-checkout_i < 0){
			text = 'D'+(today-checkout_i+1);
			document.getElementById("result"+i).innerHTML = text;
			review.setAttribute('type', 'hidden');
			cancle.setAttribute('value', '예약취소');
			
		}else if(today-checkout_i > 0){
			text = 'D+'+(today-checkin_i-1);
			document.getElementById("result"+i).innerHTML = text;
			cancle.setAttribute('value', '삭제하기');
			
		}
		
	}

	
</script>
<%@ include file="/resources/includes/footer.jsp" %>
</body>
</html>
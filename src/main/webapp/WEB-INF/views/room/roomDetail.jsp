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
.room-image img{
	width: 570px;
	height: 330px;
	object-fit: cover;
}

.upper {
	margin: 70px;
}

.mid img {
	width: 430px;
	height: 290px;
	object-fit: cover;
	}
	
body p {
	font-family: "NANUM";
	font-weight: bold;
}

.uploadResult img{
	width: 315px;
    height: 210px;
    object-fit: cover;
    margin: 50px 90px 0 90px;
}

.uploadResult {
	width: 315px;
	height: 210px;
}

h3 {
	padding-top: 30px;
	font-family: "HANNA";
	font-size: 30px;
	margin-bottom: 0;
}

.content p {
	font-family:"NANUM";
	font-weight: bold;
	font-size: 20px;
}
.upper input {
	border: none;
    
    }

.goButton {
	margin-left: 20px;
	font-weight: bold; 
	font-family: NANUM; 
	font-size:20px; 
	border-radius: 40px; 
	width: 140px; 
	height:40px; 
}
.sel {
	width: 200px;
    border-radius: 20px;
    height: 40px;
    padding: 10px;
    -webkit-appearance: none;
    outline: none;
    font-family: "NANUM";
    font-weight: bold;
}

</style>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript">

$( function() {
    $( "#datepicker" ).datepicker();
  } );
  
$.datepicker.setDefaults({
    dateFormat: 'yy-mm-dd',
    prevText: '이전 달',
    nextText: '다음 달',
    monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
    monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
    dayNames: ['일', '월', '화', '수', '목', '금', '토'],
    dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
    dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
    showMonthAfterYear: true,
    yearSuffix: '년'
});

$(function() {
    $("#datepicker1, #datepicker2").datepicker({
    	dateFormat: 'yy.mm.dd'
    });
});

function reserve() {
	if(document.getElementById("datepicker1").value == "" || document.getElementById("datepicker2").value == "" ){
		alert("예약날짜를 선택해주세요")
	}else if(document.getElementById("g_room").value == ""){
		alert("객실종류를 선택해주세요")
	}else if(
		confirm("숙소이름 : ${roomDetail.r_name}\n객실종류: "
				+document.getElementById("g_room").value+"\n숙소주소 : ${roomDetail.r_address}\n체크인 : "
				+document.getElementById("datepicker1").value+"\n체크아웃 : "
				+document.getElementById("datepicker2").value+"\n\n정말 예약하시겠습니까??") == true){ 
		document.frm.action = "/airbnb/room/reserveRoom?userId=${sessionScope.loginUser.id}";
		document.frm.method = "post"
		document.frm.submit();
		 }else{ 
		     return false;
		 }
	}

</script>
</head>
<body>
	
	 <main style="padding: 0 200px 0 300px;">
	 	<div class="upper">
	 		<div class="room-image" style="float: left; margin-right: 40px; padding-left: 50px;">
	 			<img src="${roomDetail.r_img}">
	 		</div>
	 		<form name="frm" method="post" autocomplete="off" style="margin-left: 130px; width: 1000px;">
		 		<div>
			 		<div class="simple" style="height: 300px; padding-top: 30px; width: 1000px;">
			 			<input type="hidden" value="${sessionScope.loginUser.id}" name="id">
			 			<input type="hidden" value="${roomDetail.r_name}" name="r_name" id="r_name">
			 			<input type="hidden" value="${roomDetail.r_code}" name="r_code" id="r_code">
			 			<input type="hidden" value="${roomDetail.r_img}" name="r_img" id="r_img">
			 			<p style="font-family:'HANNA'; font-size: 50px; margin-top: 0; margin-bottom: 20px; width: 1200px;">${roomDetail.r_name}</p>
			 			<p>평점 : ${roomDetail.r_score}</p>
			 			<p>주소 : ${roomDetail.r_address}</p>
			 			<input type="hidden" value="${roomDetail.r_address}" name="r_address">
					<div style="float: left; padding-right : 20px; margin-bottom: 20px;">
					<p>체크인</p>
					<input type="text" id="datepicker1" name="r_checkIn" style="border-bottom: 1px solid;">
					</div>
					<div style="float: left; padding-right : 20px; margin-bottom: 20px;">
		 			   <p>체크아웃</p>
						<input type="text" id="datepicker2" name="r_checkOut" style="border-bottom: 1px solid;">
					</div>
						<div style="margin-top: 10px;">
							<select name="r_g_name" id="g_room" class="sel">
				 			<option value="" >객실선택</option>
				 				<c:forEach items="${g_roomList}" begin="0" step="1" var="g_room">
				 					<option value="${g_room.g_name}" >${g_room.g_name}</option>
				 				</c:forEach>
				 			</select>
				 			<c:choose>
					 			<c:when test="${empty sessionScope.loginUser}">
						 			<input class=goButton type="button" value="예약하기" onclick="location.href='/airbnb/member/login'; alert('로그인이 필요합니다')">
						 		</c:when>
						 		<c:otherwise>
						 			<input class=goButton type="button" value="예약하기" onclick="reserve(frm)">
						 		</c:otherwise>
				 			</c:choose>
						</div>
			 		</div>
		 		</div>
	 			<br>
	 		 <hr width="1000px"><br><br>
			 <div>
			 	<div class="mid">
			 		<c:forEach items="${g_roomList}" begin="0" step="1" var="g_room">
			 			<div style="height: 320px;">
			 				<div style="float: left;">
					 			<img src="${g_room.g_img}" style="margin-right: 40px;">
			 				</div>
			 				<div>
					 			<h2 style="margin-bottom: 30px;">${g_room.g_name}</h2>
					 			<p style="margin-bottom: 0">${g_room.g_content}</p>
					 			<p style="margin-top: 2px; color: #858585;">&nbsp;&nbsp;&nbsp;기준${g_room.g_minGuest}인  / 최대${g_room.g_maxGuest}인</p>
					 			<div style="float: left;margin-left: 40px;margin-right: 80px; border-right: inset; padding-right: 80px;">
					 				<h3 style="margin-top: 0px;">대실</h3>
						 			<p style="color: #858585;">${g_room.g_rentTime}</p>
						 			<p style="color: #616161;">${g_room.g_rentPrice}</p>
					 			</div>
					 			<div style="margin-top: 33px;">
					 			<h3 style="padding-top: 11px;">숙박</h3>
						 			<p style="color: #858585;">${roomDetail.r_accomCheckIn}&nbsp;부터</p>
						 			<p style="color: #616161;">${g_room.g_accomPrice}</p>
					 			</div>
			 				</div>
	 					</div>
	 				</c:forEach>
	 			</div>
	 		</div>
	 	</form>
	 	<div>
	 		<br><br>
	 		<h1 style="text-align: center; margin-bottom: 20px;">후기</h1>
	 		<img src="${ctx }/resources/images/화살표.png" style="height: 60px; width: 60px; margin-left: 600px;">
	 		<c:forEach items="${reviewList}" begin="0" step="1" var="r_List">
	 			<div style="background-color: aliceblue; width: 1100px; margin-bottom: 5px; height: 300px; margin-left: 50px;" >
	 				<div class="uploadResult" style="float: left; width: 500px;" >
	 					<img src='/resources/fileUpload/${r_List.uploadPath}/${r_List.uuid}_${r_List.fileName}'>
	 					<%-- <c:forEach items="${reviewImgList}" var="img_list">
		 					<img src='/resources/fileUpload/${img_list.uploadPath}/${img_list.uuid}_${img_list.fileName}'>
	 					</c:forEach>
	 					<c:if test="${empty reviewImgList }">
	 						<img src="${roomDetail.r_img}">
	 					</c:if> --%>
	 				</div>
		 			<div class="content">
		 				<div>
							<h3 style="font-size: 25px; padding-top: 45px;">객실 종류 :
								<h3 style="margin-top: 0; margin-bottom:0; margin-right: 210px; padding-top: 10px;"> ${r_List.r_g_name}</h3>
							</h3>
							<p style="font-size: 15px;">아이디 : ${r_List.r_id} / 별점 : ${r_List.r_score}점</p>
							<input type="text" value="내용 : ${r_List.r_content}" disabled="disabled" style="height: 70px; width: 400px; font-family: 'NANUM'">
						</div>
		 			</div>
	 			</div>
	 		</c:forEach>
	 	</div>
	</div>
 </main>
<%@ include file="/resources/includes/footer.jsp" %>
</body>
</html>
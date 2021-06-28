<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath == '/' ? '': pageContext.request.contextPath}" scope="application"/>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.roomList {
	background-color: rgb(249,249,249);
}
.roomList img {
	width: 290px;
	height: 210px;
	object-fit: cover;
	margin-right: 40px;
}
.roomList p {
	font-family: "NANUM";
	font-weight: bold;
}
a { 
	color:black;
	text-decoration:none; 
} 

</style>
</head>
<body>
 <%@ include file= "/resources/includes/header.jsp" %>
 <body>
 <div>
  <%@ include file= "/resources/includes/search1.jsp" %>
 <br><br><br><br>
 <div style="margin: 120px 200px 0 200px">
 	<c:if test="${loginUser.id == 'admin' }">
		<div style="margin-right: 200px;">
			<input type="button" value="숙소등록하기" style="width: 200px; height: 50px; border: none; border-radius: 30px; font-family: 'NANUM'; font-size: 20px; font-weight: bold;" onclick="location.href='/airbnb/room/roomInsert'">
		</div>
	</c:if>
	 <h1 style="margin-top : 20px; margin-bottom: 10px;">${sido}의 숙소</h1>
	 <input type="hidden" value="${sido}" id="map_sido">
	 <h3 style="font-family:'NANUM';">${period}</h3>
		<hr width="480px" style="margin-left:10px;"><br><br>
		
	<p style="margin-top:-12px">
	    <em class="link">
	        <a href="javascript:void(0);" onclick="window.open('http://fiy.daum.net/fiy/map/CsGeneral.daum', '_blank', 'width=981, height=650')"></a>
	    </em>
	</p>
	
<div style="position: relative;">
	
	<div id="map" style="width:550px; height:825px; left: 900px;"></div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=	d4f21ea37cb6b96b6c016ec8f605a4c5&libraries=services"></script>

<script>
var map_code1 = "${map_code1}"
var map_code2 = "${map_code2}"

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
mapOption = {
        center: new kakao.maps.LatLng(${map_code1}, ${map_code2}), // 지도의 중심좌표
		level: 7
    };  
 
var map = new kakao.maps.Map(mapContainer, mapOption); 

var geocoder = new kakao.maps.services.Geocoder();

	
	<c:forEach items="${roomList}" var="item" >
	
// 주소로 좌표를 검색합니다
	geocoder.addressSearch('${item.r_address}', function(result, status) {

    // 정상적으로 검색이 완료됐으면 
     if (status === kakao.maps.services.Status.OK) {

        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

        // 결과값으로 받은 위치를 마커로 표시합니다
        var marker = new kakao.maps.Marker({
            map: map,
            position: coords
        });

        // 인포윈도우로 장소에 대한 설명을 표시합니다
        var infowindow = new kakao.maps.InfoWindow({
            content: '<div style="width:150px;text-align:center;padding:6px 0;">${item.r_name}</div>'
        });
        infowindow.open(map, marker);

        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
        map.setCenter(coords);
    } 
});    
	</c:forEach>

</script>
<script type="text/javascript">
 $(function(){
	$(window).scroll(function(){  //스크롤하면 아래 코드 실행
	       var num = $(this).scrollTop();  // 스크롤값
	       if( num > 677){ 
	          $("#map").css({
	        	  "position" : "fixed",
	        	  "left" : "1108px",
	        	  "top" : "10px"
	          });
	       }else{
	           $("#map").css({
	        	   "position" : "absolute",
	        	   "left" : "900px",
	        	   "top" : "0px"
	        	   
	           });
	       }
	  });
	}); 
	$(function() {

		  var $w = $(window),
		    footerHei = $('footer').outerHeight(),
		    $banner = $('#map');

		  $w.on('scroll', function() {

		    var sT = $w.scrollTop();
		    var val = $(document).height() - $w.height() - footerHei;

		    if (sT >= val)
		        $banner.addClass('on')
		    else
		    	$banner.removeClass('on')

		  });

		});
</script>

	<div class="fixed">
		<c:forEach items="${roomList}" var="roomList" step="1" >
			<div class="roomList" style="padding: 30px; margin-bottom: 20px; width:800px;">
				<div style="float: left;">
				<a href="/airbnb/room/roomDetail?r_code=${roomList.r_code}">
					<img class="img-room" src="${roomList.r_img}">
				</a>
				</div>
				<div>
					<p style="font-family:'HANNA'; font-size: 25px; "><a href="/airbnb/room/roomDetail?r_code=${roomList.r_code}">${roomList.r_name}</a></p>
					<p style="margin-bottom: 5px;">평점 : ${roomList.r_score}</p>
					<p style="margin-top: 0; color: #858585; font-size: 15px;">&nbsp;&nbsp;&nbsp;${roomList.r_service}</p>
					<p style="margin: 0;">주소 : ${roomList.r_address}</p>
					<p>숙박 : ${roomList.r_price}원 ~</p>
					<input type="hidden" value="${roomList.r_address}" id="address">
					<p>
				</div>
			</div>
		</c:forEach>
	</div>
</div>
</div>
</div>
<footer>
	<%@ include file="/resources/includes/footer.jsp" %>
</footer>
</body>
</html>

























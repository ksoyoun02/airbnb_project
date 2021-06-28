<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet">
 

<style type="text/css">
	.sr-only {
		position: absolute;
		width: 1px;
		height: 1px;
		padding: 0;
		margin: -1px;
		overflow: hidden;
		clip: rect(0,0,0,0);
		border: 0;
	}

span {
font-family: "NANUMb";
}
.weather_style span{
	font-family: 'NANUM';
	font-size: 25px;
}

</style>
<script src="https://code.jquery.com/jquery-2.2.3.min.js"></script>
<script src="https://use.fontawesome.com/926fe18a63.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$(".headC").click(function() {
			$(".headB").slideToggle();
		});
		
	$.getJSON('http://api.openweathermap.org/data/2.5/weather?id=1835848&appid=07bc835c44e66f391575fd52d7f75d2f&units=metric',
		function(data){

		var $minTemp = data.main.temp_min;
		var $maxTemp = data.main.temp_max;
		var $cTemp = data.main.temp;
		var $now = new Date($.now());
		var $cDate = $now.getFullYear() + '년 ' +  ($now.getMonth() + 1) + '월 ' + $now.getDate() + '일';
		var $cTime = $now.getHours() + '시' + $now.getMinutes() + '분';
		var $wIcon = data.weather[0].icon;
		var $sido = data.name;
	
		$('.ccido').prepend($sido);
		$('.ctemp').append($cTemp);
		$('.clowtemp').append($minTemp);
		$('.chightemp').append($maxTemp);
		$('.cdate').prepend($cDate);
		$('.cTime').prepend($cTime);
		$('.cicon').append('<img src="resources/images/weather/'+$wIcon+'.png" style="width: 100px; margin-left:40px;">');
		
	});
	
	$("select").on('change',function() {
		
		var $sido =  $(this).val();
		//alert($sido);
		
		
		$.getJSON('http://api.openweathermap.org/data/2.5/weather?id='+$sido+'&appid=07bc835c44e66f391575fd52d7f75d2f&units=metric',
				function(data){
			
				var $minTemp = data.main.temp_min;
				var $maxTemp = data.main.temp_max;
				var $cTemp = data.main.temp;
				var $now = new Date($.now());
				var $cDate = $now.getFullYear() + '년 ' +  ($now.getMonth() + 1) + '월 ' + $now.getDate() + '일';
				var $cTime = $now.getHours() + '시' + $now.getMinutes() + '분';	
				var $wIcon = data.weather[0].icon;
				var $sido = data.name;

				$(".ctemp,.clowtemp,.chightemp,.cdate,.cicon,.ccido,.cTime").empty();
				$('.ccido').prepend($sido);
				$('.ctemp').append($cTemp);
				$('.clowtemp').append($minTemp);
				$('.chightemp').append($maxTemp);
				$('.cdate').prepend($cDate);
				$('.cTime').prepend($cTime);
				$('.cicon').append('<img src="resources/images/weather/'+$wIcon+'.png" style="width: 100px; margin-left:40px;">');
				
			});
		
	})
});
</script>

</head>
<%@ include file= "/resources/includes/header.jsp" %>

<div>
	<article id="main">
		<section class="mainphoto">
			<div style="text-align: center; margin-top: 20px;"><img alt="메인이미지" src="resources/images/메인사진.png"></div>
		</section>
	</article>
	<%@ include file= "/resources/includes/search.jsp" %>

	<div class="weather">
		<!-- <h1>weather api</h1> -->
		<h2 style="margin-bottom: 20px;"><span class="ccido"></span><span>의 날씨</span><br></h2>
		<h3 class="cdate" style="font-family: 'NANUMb'; margin-top: 20px; margin-bottom: 10px; font-size: 30px; margin: 10px 0 10px 95px;"></h3>
		<h3 class="cTime" style="font-family: 'NANUMb'; margin: 10px 0 20px 130px;; font-size: 30px;"> </h3>
		<div style="width: 180px; float: left;" class="weather_style">
			<span>현재 온도 : </span><span class="ctemp"></span><br>
			<span>최저 온도 : </span><span class="clowtemp"></span><br>
			<span>최고 온도 : </span><span class="chightemp"></span><br>
		</div>
		<div>
			<div class="cicon"></div>
		</div>
	</div>
</div>	

	<article class="post">
		<section class="conA">
		<div class="container">
			<h1>계절별 여행지 추천</h1>
			<div class="season">
				<div class="contact" >
					<a href="main/season.airbnb#spring">
					<span><img alt="봄" src="resources/images/봄.png"></span>
					</a>
					<h2>봄</h2>
				</div>
				<div class="contact">
					<a href="main/season.airbnb#summer">
					<span><img alt="여름" src="resources/images/여름.png"></span>
					</a>
					<h2>여름</h2>
				</div>
				<div class="contact">
					<a href="main/season.airbnb#fall">
					<span><img alt="가을" src="resources/images/가을.png"></span>
					</a>
					<h2>가을</h2>
				</div>
				<div class="contact">
					<a href="main/season.airbnb#winter">
					<span><img alt="겨울" src="resources/images/겨울.png"></span>
					</a>
					<h2>겨울</h2>
				</div>
			</div>
		</div>
	</section>
	
	<section>
		<div class="conB">
			<div class="container">
				<div><h1>테마별 여행지 추천</h1></div>
				<div class="thema">
					<div class="contact">
						<a href="main/thema.airbnb#culture"><img alt="문화생활" src="resources/images/박물관.png"></a>
						<h2>문화생활</h2>
					</div>
					
					<div class="contact">
						<a href="main/thema.airbnb#activity"><img alt="엑티비티" src="resources/images/카약.png"></a>
						<h2>엑티비티</h2>
					</div>
					
					<div class="contact1">
						<a href="main/thema.airbnb#healing"><img alt="힐링" src="resources/images/산에서 캠핑.png"></a>
						<h2>힐링</h2>
					</div>
					
				</div>
			</div>
		</div>
	</section>
	</article>
<%@ include file="/resources/includes/footer.jsp" %>	
	
</html>
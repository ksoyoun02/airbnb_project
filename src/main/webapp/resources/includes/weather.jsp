<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Weather</title>
<script src="https://code.jquery.com/jquery-2.2.3.min.js"></script>
<script>
	/*
	$.getJSON('파일경로', function(data){
		//data로 할일..
	});
	*/
	$.getJSON('http://api.openweathermap.org/data/2.5/weather?id=1835848&appid=07bc835c44e66f391575fd52d7f75d2f&units=metric',
		function(data){
		//alert(data.list[0].main.temp_min);
		var $minTemp = data.main.temp_min;
		var $maxTemp = data.main.temp_max;
		var $cTemp = data.main.temp;
		var $now = new Date($.now());
		var $cDate = $now.getFullYear() + '/' +  ($now.getMonth() + 1) + '/' + $now.getDate() + '  ' +$now.getHours() + ':' + $now.getMinutes();
		var $wIcon = data.weather[0].icon;
		//A.append(B) A요소의 내용의 뒤에 B를 추가
		//A.appendTo(B) B요소의 내용의 뒤에 A를 추가
		//A.prepend(B) A요소의 내용의 앞에 B를 추가
		//A.prependTo(B) B요소의 내용의 앞에 A를 추가
		$('.ctemp').append($cTemp);
		$('.clowtemp').append($minTemp);
		$('.chightemp').append($maxTemp);
		$('h2').append($cDate);
		$('.cicon').append('<img src="http://openweathermap.org/img/wn/'+$wIcon+'.png">');
		
		//Date.now(); == $.now
		// new Date(Date.now());
		//alert(new Date($.now()));
		
		//.getFullYear() 연도 .getMonth() 월 .getDate() 일
		//.getHours() 시간, .getMinutes() 분
	});
</script>
</head>
<body>
<h1>weather api</h1>
<h2> - 날씨정보</h2>
<div class="ctemp">현재 온도 : </div>
<div class="clowtemp">최저 온도 : </div>
<div class="chightemp">최고 온도 : </div>
<div class="cicon">아이콘 : </div>
</body>
</html>
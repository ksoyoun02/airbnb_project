<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<style type="text/css">
p{
	margin-bottom: 10px;
}

.search h5 {
	font-family: "HANNA";
	font-size: 21px;
	margin-top: 20px;
	margin-bottom: 10px;
}
</style>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</head>
</head>
<body>
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

	function a_count(type)  {
		  const resultElement = document.getElementById('a_result');
		  let number = resultElement.innerText;
		  if(type === 'plus') {
		    number = parseInt(number) + 1;
		  }else if(type === 'minus')  {
		    number = parseInt(number) - 1;
		  }
		  if(number > 0 && number < 11){
			  resultElement.innerText = number;
		  }
		}
		
	function c_count(type)  {
		  const resultElement = document.getElementById('c_result');
		  let number = resultElement.innerText;
		  if(type === 'plus') {
		    number = parseInt(number) + 1;
		  }else if(type === 'minus')  {
		    number = parseInt(number) - 1;
		  }
		  if(number > 0 && number < 11){
			  resultElement.innerText = number;
		  }
		}
		
	function date_check() {
		var checkin = document.getElementById('datepicker1').value;
		var checkout = document.getElementById('datepicker2').value;

		var checkin_ = checkin.replace(/\./g,'');
		var checkout_ = checkout.replace(/\./g,'');
		
		var result = (checkout_ - checkin_);
		
		if(result < 0) {
			event.preventDefault();
			alert("날짜를 다시 선택해주세요");
			
		}
		
	}
	</script>
	<form action="/airbnb/room/roomList" class="search" style="position:absolute; top: 300px; width: 1070px; left: 450px; background-color: rgb(236,242,237,0.4); padding-left: 20px;" method="post">
		<div class="ui-widget" style="float: left; padding-right: 20px; "> 
		  <h5>위치</h5>
		  <select style="width:200px; margin-right: 20px; margin-top: 2px; font-family:'Light'; font-size: 14px;" name="r_sido">
		  	<option value="1835848" selected>어디로 여행가세요?</option>
	        <option value="1835848">서울</option>
	        <option value="1838524">부산</option>
	        <option value="1835327">대구</option>
	        <option value="1843561">인천</option>
	        <option value="1841811">광주</option>
	        <option value="1835224">대전</option>
	        <option value="1833747">울산</option>
	        
	      </select>
		</div>
		<div style="float: left; padding-right : 20px;">
			<h5 style="margin-bottom: 12px">체크인</h5>
			<input type="text" id="datepicker1" name="r_accomCheckIn" autocomplete='off' style="height: 19px;">
		</div>
		<div style="float: left; padding-right : 20px;">
		   <h5 style="margin-bottom: 12px">체크아웃</h5>
			<input type="text" id="datepicker2" name="r_accomCheckOut" autocomplete='off' style="height: 19px;">
		</div>
			<div style="float: left; padding-right : 30px;">
				<h5 style="margin-bottom: 5px; margin-top: 7px;">성인<br>(만 16세 이상)</h5>
				<div style="margin-left: 20px;">
					<input type='button' onclick='a_count("minus")' value='-' style="float: left; margin-top: 2px;">
					<div id='a_result' style="float: left; margin: 0 3px 0 3px;">0</div>
					<input type='button' onclick='a_count("plus")' value='+'/>
				</div>
				
			</div>
			<div style="float: left; padding-right : 20px;" >
				<h5 style="margin-bottom: 5px; margin-top: 7px;">어린이<br>(만 2세 ~ 12세)</h5>
				<div style="margin-left: 20px;">
					<input type='button' onclick='c_count("minus")' value='-' style="float: left; margin-top: 2px;">
					<div id='c_result' style="float: left; margin: 0 3px 0 3px;">0</div>
					<input type='button' onclick='c_count("plus")' value='+'/>
				</div>
			
			</div>
			<button type="submit" style="margin-top: 30px; margin-bottom: 30px; border:none; border-radius:20px; width: 100px; height: 35px;" onclick="date_check();">검색</button>
	</form>
</body>
</html>
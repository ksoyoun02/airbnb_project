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
h3 {
	font-size: 30px;
}

input{
    width: 500px;
    height: 35px;
    border: none;
    border-bottom: 1px solid;
    margin-left: 20px;
    padding-left: 30px;
}

select {
    border: none;
    border-bottom: 1px solid;
    width: 500px;
     margin-left: 20px;
    padding-left: 30px;
}

.submit {
	border: none;
    width: 300px;
    padding: 0;
    margin: 0;
    border-radius: 40px;
    height: 60px;
    font-family: 'NANUMb';
    font-size: 30px;
}
</style>
<script type="text/javascript">
function check() {
	if (document.frm.r_name.value == "") {
		alert("숙소이름을 입력해주세요");
		document.frm.r_name.focus();
	} else if (document.frm.r_address.value == "") {
		alert("숙소주소를 입력해주세요");
		document.frm.r_address.focus();
	} else if (document.frm.r_service.value == "") {
		alert("숙소 서비스를 입력해주세요");
		document.frm.r_service.focus();
	} else if (document.frm.r_score.value == "") {
		alert("숙소 별점을 입력해주세요");
		document.frm.r_score.focus();
	} else if (document.frm.r_price.value == "") {
		alert("숙소 가격을 입력해주세요");
		document.frm.r_price.focus();
	} else if (document.frm.r_accomCheckIn.value == "") {
		alert("체크인 시간을 입력해주세요");
		document.frm.r_accomCheckIn.focus();
	}else if (document.frm.r_accomCheckOut.value == "") {
		alert("체크아웃 시간을 입력해주세요");
		document.frm.r_accomCheckOut.focus();
	} else if (document.frm.r_sido.value == "") {
		alert("'시/도'를 선택해주세요");
	} else if (document.frm.file.value == "") {
		alert("파일을 등록해주세요");
	}else {
		document.frm.action = "/airbnb/room/roomInsert";
		document.frm.submit();
	}
}

function fileCheck(obj) {
	pathpoint = obj.value.lastIndexOf('.');
	filepoint = obj.value.substring(pathpoint+1, obj.length);
	filetype = filepoint.toLowerCase();
	if(filetype=='jpg'||filetype=='gif'||filetype=='jpeg'||filetype=='bmp'||filetype=='png'){
		
	}else{
		alert('이미지 파일만 업로드 할 수 있습니다.');	
		parentObj = obj.parentNode
		node = parentObj.replaceChile(obj.cloneNode(true).obj);
		return false;
	}
	if(filetype=='bmp'){
		upload = confirm('bmp 파일은 웹상에서 사용하기엔 적절한 이미지 포맷이 아닙니다.\n 그래도 계속하시겠습니까?');
		if(!upload) return false;
	}
	
}


</script>
</head>
<body>
<div style="margin: 120px 200px 100px 200px">
	<h1 style="margin-bottom: 0">숙소등록</h1>
	<hr width="480px" style="margin-left:10px;"><br><br>
	<div style="padding: 30px; margin: 0 200px 0 200px; text-align: center;" >
	<form action="/airbnb/room/roomInsert" method="post" enctype = "multipart/form-data" name="frm">
		<h3>숙소이름 : <input type="text" name="r_name" maxlength="15" placeholder="'없이 입력해주세요" data-name="숙소이름"></h3>
		<h3>숙소주소 : <input type="text" name="r_address" data-name="숙소주소"></h3>
		<h3>숙소서비스 : <input type="text" name="r_service" placeholder="예)더블베드, 조식, 주차장.." data-name="숙소서비스"></h3>
		<h3>숙소평점 : <input type="text" name="r_score" maxlength="3" placeholder="1 ~ 5까지 입력(소수점가능)" data-name="숙소별점"></h3>
		<h3>숙소시/도 :  
			<select name="r_sido">
				<option value="">선택해주세요</option>
				<option value="서울">서울</option>
				<option value="부산">부산</option>
				<option value="대구">대구</option>
				<option value="인천">인천</option>
				<option value="광주">광주</option>
				<option value="대전">대전</option>
				<option value="울산">울산</option>
			</select>
		</h3>
		<h3>숙소평균가격 : <input type="text" name="r_price" placeholder="숫자만 적으세요" data-name="숙소평균가격"> </h3>
		<h3>체크인시간 : <input type="text" name="r_accomCheckIn" placeholder="예) 15:00" data-name="체크인시간"></h3>
		<h3>체크아웃시간 : <input type="text" name="r_accomCheckOut" placeholder="예) 11:00" data-name="체크아웃시간"></h3>
		<h3>숙소대표이미지 : <input type="file" name="file" onchange="fileCheck(this)" accept="image/gif, image/jpeg, image/png"></h3>
		<div>
			 <input type="button" class="submit" onclick="check();" value="숙소등록" style="margin-top: 20px;">
		</div>	
	</form>
		
	</div>
</div>
<%@ include file="/resources/includes/footer.jsp" %>
</body>
</html>
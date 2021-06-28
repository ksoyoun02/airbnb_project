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
<script type="text/javascript">
function fileCheck(obj) {
	pathpoint = obj.value.lastIndexOf('.');
	filepoint = obj.value.substring(pathpoint+1, obj.length);
	filetype = filepoint.toLowerCase();
	if(filetype=='xlsx'){
		
	}else{
		alert('xlsx 파일만 업로드 할 수 있습니다.');	
		parentObj = obj.parentNode
		node = parentObj.replaceChile(obj.cloneNode(true).obj);
		return false;
	}
	
}
</script>
<style type="text/css">
h3{
	font-family: "NANUM";
	font-size: 25px;
}

.frm_button {
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
</head>
<body>
<div style="margin: 120px 200px 0 200px">
	<h1 style="margin-bottom: 0">숙소등록결과</h1>
	<hr width="480px" style="margin-left:10px;"><br>
	<div style="margin-left: 50px;">
		<h3>숙소이름 : ${roomInsert.r_name}</h3>
		<h3>숙소주소 : ${roomInsert.r_address}</h3>
		<h3>숙소서비스 : ${roomInsert.r_service}</h3>
		<h3>숙소이미지 파일명 : ${imgName}</h3>
		<h3>숙소별점 : ${roomInsert.r_score }</h3>
		<h3>숙소시도 : ${roomInsert.r_sido}</h3>
		<h3>숙소가격 : ${roomInsert.r_price}</h3>
		<h3>숙소체크인 : ${roomInsert.r_accomCheckIn}</h3>
		<h3>숙소 체크아웃 : ${roomInsert.r_accomCheckOut}</h3><br>
	</div>
	
	<h1 style="margin-bottom: 0">객실파일 업로드</h1>
	<hr width="480px" style="margin-left:10px;">
	<div>
		<div>
			<h3 style="font-size: 40px;">"파일 업로드 방법"</h3>
			<h3>
				1. 파일 양식 다운로드 (지정된 양식으로만 업로드 가능합니다. 1행 수정금지)<br><br>
				2. 파일 작성<br>
					&nbsp;&nbsp;&nbsp;가. 객실 코드는 순서에 따라 g-(번호)로 입력해주세요<br>
					&nbsp;&nbsp;&nbsp;나. 객실 이미지는 html 형식으로 입력해주세요<br>
					&nbsp;&nbsp;&nbsp;다. 기준인원, 최대인원, 숙박금액은 숫자로만 입력해주세요<br>
					&nbsp;&nbsp;&nbsp;(문자열로 입력시 업로드 불가능)<br><br>
				3. 파일 작성 예시<br>
					&nbsp;&nbsp;&nbsp;객실코드 : g-1, g-2, g-3<br>
					&nbsp;&nbsp;&nbsp;객실이름 : 일반실, VIP<br>
					&nbsp;&nbsp;&nbsp;객실이미지 : https:// ...<br>
					&nbsp;&nbsp;&nbsp;객실내용 : 더블베드, 온돌<br>
					&nbsp;&nbsp;&nbsp;기준인원 : 1,2,3<br>
					&nbsp;&nbsp;&nbsp;최대인원 : 1,2,3<br>
					&nbsp;&nbsp;&nbsp;대실시간 : 3시간, 숙박만 가능<br>
					&nbsp;&nbsp;&nbsp;대실금액 : 40000원, 숙박만 가능<br>
					&nbsp;&nbsp;&nbsp;숙박금액 : 80000<br>
			</h3>
		</div>
		 <form action="/room/excel_download" method="get">
			<input type="hidden" value="${r_code}" name="r_code">
	        <button type="submit" class="frm_button">양식다운로드</button>
	     </form>
     </div>
     <div>
     <br><br>
     <hr width="480px" style="margin-left:10px;">
     	<h2>엑셀파일등록</h2>
     </div>
     <form action="/room/excel_upload" method="post" enctype = "multipart/form-data">
     	<input type="hidden" value="${r_code}" name="r_code">
     	<input type="file" id="uploadFile" name="uploadFile" onchange="fileCheck(this)" accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet">
     	<br><br><br>
     	<input type="submit" value="엑셀파일업로드" class="frm_button">
     	<br><br>
     </form>
	
</div>
<footer>
	<%@ include file="/resources/includes/footer.jsp" %>
</footer>
</body>
</html>
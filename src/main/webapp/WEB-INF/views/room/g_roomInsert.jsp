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
<script>
 var count = 1;
 var listcount = 0;
        const addForm = () => {
        	count++;
        	if(count >= 11){
        		alert("객실은 10이상 추가하실 수 없습니다.");
        		return false;
        	}
            const box = document.getElementById("frm");
            const newP = document.createElement('p');
            newP.innerHTML = "<input type='hidden' value='${r_code }' name='grDtoList["+listcount+ "].g_r_code'>"
			+"<div>객실코드<input type='text' value='${r_code}-g" + count + "' name='grDtoList["+listcount+ "].g_code' readonly></div>"
			+"<div>객실이름<input type='text' name='grDtoList["+listcount+ "].g_name'></div><br>"
			+"<div>객실내용<input type='text' name='grDtoList["+listcount+ "].g_content'></div><br>"
			+"<div>기준인원<input type='text' name='grDtoList["+listcount+ "].g_minGuest'></div><br>"
			+"<div>최대인원<input type='text' name='grDtoList["+listcount+ "].g_maxGuest'></div><br>"
			+"<div>대실시간<input type='text' name='grDtoList["+listcount+ "].g_rentTime'></div><br>"
			+"<div>대실금액<input type='text' name='grDtoList["+listcount+ "].g_rentPrice'></div><br>"
			+"<div>숙박금액<input type='text' name='grDtoList["+listcount+ "].g_accomPrice'></div><br>"
			+"<div>객실이미지<input type='file' name='grDtoList["+listcount+ "].g_img'></div>"
			+"<input type='button' value='추가' onclick='addForm()'><input type='button' value='삭제' onclick='remove(this)'>";
            box.appendChild(newP);
        }
        const remove = (obj) => {
            document.getElementById('frm').removeChild(obj.parentNode);
        }
        
       
    </script>
</head>
<body>
<div style="margin: 120px 200px 0 200px">
	<h1 style="margin-bottom: 0">객실등록</h1>
	<hr width="480px" style="margin-left:10px;"><br><br>
	
	<form action="/airbnb/room/g_roomInsert" id="frm" name="frm" method="post">
		<div id="frm">
			<input type="hidden" value="${r_code }" name="grDtoList[0].g_r_code">
			<div>객실코드<input type="text" value="${r_code}-g1" name="grDtoList[0].g_code" readonly></div>
			<div>객실이름<input type="text" name="grDtoList[0].g_name"></div><br>
			<div>객실내용<input type="text" name="grDtoList[0].g_content"></div><br>
			<div>기준인원<input type="text" name="grDtoList[0].g_minGuest"></div><br>
			<div>최대인원<input type="text" name="grDtoList[0].g_maxGuest"></div><br>
			<div>대실시간<input type="text" name="grDtoList[0].g_rentTime"></div><br>
			<div>대실금액<input type="text" name="grDtoList[0].g_rentPrice"></div><br>
			<div>숙박금액<input type="text" name="grDtoList[0].g_accomPrice"></div><br>
			<div>객실이미지<input type="file" name="grDtoList[0].g_img"></div>
			<input type="button" value="추가" onclick="addForm()">
		</div>
	</form>
		<input type="button" value="객실등록하기" onclick="document.getElementById('frm').submit();">
</div>
<%@ include file="/resources/includes/footer.jsp" %>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath == '/' ? '': pageContext.request.contextPath}" scope="application"/>
<%@ include file= "/resources/includes/header.jsp" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<style type="text/css">
	#tr_btn_modify {
		display: none;
	}				
	#addrfind {
		display: none;
	}		
	.table tr td{
		padding-left: 30px;
		font-family: "Light";
		font-size: 16px;
	}
	
	.table input{
		font-family: "Light";
		font-size: 16px;
	}
	.go input{
		width: 200px;
		height: 50px; 
		border: none; 
		border-radius: 30px; 
		font-family: 'NANUM'; 
		font-size: 20px; 
		font-weight: bold;"
	}
	
	
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">

	function backToList(obj) {
		obj.action = "/airbnb/member/mypage";
		obj.submit();
	}
	
	function fn_enable(obj) {
		
		
		document.getElementById("i_name").disabled = false;
		document.getElementById("i_addr").disabled = false;
		document.getElementById("i_email").disabled = false;
		document.getElementById("i_phone").disabled = false;
		
		document.getElementById("tr_btn_modify").style.display = "block";
		document.getElementById("tr_btn").style.display = "none";
		
		document.getElementById("addrfind").style.display = "block";
		document.getElementById("addr").style.display = "none";
		
	}
	
	function fn_modify_article(obj) {
		obj.action = "/airbnb/member/memberModify";
		obj.submit();
	}
	
	function deleteMember() {
		if (confirm("정말 탈퇴하시겠습니까??") == true){ 
			document.frm.action = "/airbnb/member/deleteMember?userId=${sessionScope.loginUser.id}";
			document.frm.method = "post"
			document.frm.submit();
		 }else{ 
		     return false;
		 }

		
	}
</script>
</head>
<body>
<div style="margin-left: 200px; margin-top: 120px;">
	<h1 style="margin-bottom: 0">회원정보</h1>
	<hr width="480px" style="margin-left:10px;"><br><br>
	<%@ include file="/resources/includes/memberMenu.jsp" %>
	<form name="frm" method="post" class="mypage">
		<table align="center" style="background-color: ghostwhite;" class="table">
			<tr style="border-bottom: 1px solid #D1D1D1;">
				<td style="border-right: 1px solid #D1D1D1">사용자ID</td>
				<td>
					<input style="border: none;" type="text" name="userId" value="${sessionScope.loginUser.id}"  disabled="disabled">
					<input type="hidden" name="id" value="${sessionScope.loginUser.id}">
				</td>
				
			</tr>
			<tr style="border-bottom: 1px solid #D1D1D1;">
				<td style="border-right: 1px solid #D1D1D1" >사용자이름</td>
				<td>
					<input style="border: none;" type="text" value="${sessionScope.loginUser.name}" name="name" id="i_name" disabled="disabled"><br>
				</td>
			</tr>
			<tr style="border-bottom: 1px solid #D1D1D1;">
				<td style="border-right: 1px solid #D1D1D1">사용자주소</td>
				<td id="addr">
					<input style="border: none;" type="text" value="${sessionScope.loginUser.zip_num}" name="zip_num" id="i_zip_num" disabled="disabled"><br>
					<input style="border: none;width: 300px;" type="text" value="${sessionScope.loginUser.address}" name="addr" id="i_addr" disabled="disabled"><br>
					
				</td>
				<td id="addrfind" width="50">
					<input type="text" name = "zip_num" id="zip_num" placeholder="우편번호">
					<input type="button" onclick="execDaumPostcode()" value="우편번호 찾기"><br>
					<input type="text" name = "roadAddress" id="roadAddress" placeholder="도로명주소">
					<input type="text" name = "jibunAddress" id="jibunAddress" placeholder="지번주소">
					<span id="guide" style="color:#999;display:none"></span>
					<input type="text" name = "detailAddress" id="detailAddress" placeholder="상세주소">
					<input type="text" name = "extraAddress" id="extraAddress" placeholder="참고항목">
		
		<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
		<script>
		    function execDaumPostcode() {
		        new daum.Postcode({
		            oncomplete: function(data) {
		       
		                var roadAddr = data.roadAddress;
		                var extraRoadAddr = ''; 
		
		                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
		                    extraRoadAddr += data.bname;
		                }
		                
		                if(data.buildingName !== '' && data.apartment === 'Y'){
		                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
		                }
		               
		                if(extraRoadAddr !== ''){
		                    extraRoadAddr = ' (' + extraRoadAddr + ')';
		                }
		
		                // 우편번호와 주소 정보를 해당 필드에 넣는다.
		                document.getElementById('zip_num').value = data.zonecode;
		                document.getElementById("roadAddress").value = roadAddr;
		                document.getElementById("jibunAddress").value = data.jibunAddress;
		                
		                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
		                if(roadAddr !== ''){
		                    document.getElementById("extraAddress").value = extraRoadAddr;
		                } else {
		                    document.getElementById("extraAddress").value = '';
		                }
		
		                var guideTextBox = document.getElementById("guide");
		                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
		                if(data.autoRoadAddress) {
		                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
		                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
		                    guideTextBox.style.display = 'block';
		
		                } else if(data.autoJibunAddress) {
		                    var expJibunAddr = data.autoJibunAddress;
		                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
		                    guideTextBox.style.display = 'block';
		                } else {
		                    guideTextBox.innerHTML = '';
		                    guideTextBox.style.display = 'none';
		                }
		            }
		        }).open();
		    }
		</script>
				</td>
			</tr>
			<tr style="border-bottom: 1px solid #D1D1D1;">
				<td style="border-right: 1px solid #D1D1D1">사용자전화번호</td>
				<td>
					<input style="border: none;" type="text" value="${sessionScope.loginUser.phone}" name="phone" id="i_phone" disabled="disabled"><br>
				</td>
			<tr>
				<td style="border-right: 1px solid #D1D1D1">사용자이메일</td>
				<td>
					<input style="border: none;" type="text" value="${sessionScope.loginUser.email}" name="email" id="i_email" disabled="disabled"><br>
				</td>
			</tr>
		</table>
		<table style="height:100px; margin: auto; text-align: center;">
			<tr id="tr_btn_modify" style="margin-left: 150px; margin-top: 30px;">
				<td colspan="2" align="center" class="go" >
					<input type="button" value="수정반영하기" onclick="fn_modify_article(frm)">
					<input type="button" value="취소" onclick="backToList(frm)">
				</td>
			</tr>
			<tr id="tr_btn">
				<td colspan="2" align="center" class="go" style="height: 130px;">
					<input type="button" value="비밀번호변경" onclick="location.href='/airbnb/member/pwdUpdate'">
					<input type="button" value="수정하기" onclick="fn_enable(this.form)">
					<input type="button" value="회원탈퇴" onclick="deleteMember()">
				</td>
			</tr>
		</table>
	</form>
	</div>
<%@ include file="/resources/includes/footer.jsp" %>
</body>
</html>
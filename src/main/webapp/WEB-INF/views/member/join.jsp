<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file= "/resources/includes/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath == '/' ? '': pageContext.request.contextPath}" scope="application"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/resources/js/member.js"></script>
<script type="text/javascript">

function go_save() {
	if (document.frm.id.value == "") {
		alert("아이디를 입력해주세요");
		document.frm.id.focus();
	} else if (document.frm.id.value == "-1") {
		document.frm.reid.focus();
	} else if (document.frm.pwd.value == "") {
		alert("비밀번호를 입력해주세요");
		document.frm.pwd.focus();
	} else if (document.frm.pwd.value != document.frm.pwdCheck.value) {
		alert("비밀번호가 일치하지 않습니다.");
		document.frm.pwd.focus();
	} else if (document.frm.name.value == "") {
		alert("이름을 입력해주세요");
		document.frm.name.focus();
	} else if (document.frm.email1.value == "") {
		alert("이메일을 입력해주세요");
		document.frm.email1.focus();
	} else if (document.frm.email2.value == "") {
		alert("이메일을 형식을 선택해주세요");
	} else {
		document.frm.action = "/airbnb/member/join";
		document.frm.submit();
	}
}

	$(document).ready(function(){
		$("#idChk").blur(function(){
			var id = $("#idChk").val();
			if (id == "") {
				$("#idChk").val("필수 입력항목 입니다.").css("background-color", "#facdcd");
			}else{
				$("#idChk").css("background-color", "white");
				$.ajax({
					type : "POST",
					url : "/airbnb/member/id_check",
					dataType : "json",
					data : "id=" + id,
					success : function(data) {
						
						if (data.message == "1") {
							$("#message").html("사용 불가능 아이디 입니다.").css("color", "red");
							$("#reid").val("-1");
						
						}else{
							$("#message").html("사용 가능 아이디 입니다.").css("color", "blue");
							$("#reid").val("1");
						}
					},
					fail : function() {
						alert("시스템에러");
					}
				});
			}
		});
	});
	
	  
    // 숫자가 아닌 정규식
    var replaceNotInt = /[^0-9]/gi;
    
    $(document).ready(function(){
        
        $("#zip_num").on("focusout", function() {
            var x = $(this).val();
            if (x.length > 0) {
                if (x.match(replaceNotInt)) {
                   x = x.replace(replaceNotInt, "");
                }
                $(this).val(x);
            }
        }).on("keyup", function() {
            $(this).val($(this).val().replace(replaceNotInt, ""));
        });
 
    });
    
    
</script>

<style>
fieldset input{
    margin-bottom: 20px;
    margin-left: 40px;
    width: 250px;
    height: 40px;
    border-style: none;
    border-bottom: 1px solid;
   
}

fieldset label{
	font-size: 25px;
}

fieldset .addr input{
	width:200px;
	margin-left: 0;
}

input {
	font-family: "NANUM";
	font-weight: bold;
	font-size: 20px;
}
label{
	font-family: "NANUM";
	font-weight: bold;
	font-size: 30px;
}

</style>
<article class="join">
	<h1>회원가입</h1><br>
	<hr width="980px"><br><br>
	<form action="/join" id="join" method="post" name="frm" style="text-align: -webkit-center;">
		<fieldset style="width: 900px; text-align: start;">
			<label style="margin-right: 70px;">아이디</label>
			<input type="text" name="id" id="idChk" size="10"  maxlength="15" placeholder="4-15자리 이내로 입력해주세요" autocomplete='off' onfocus="this.value=''; return true;">&nbsp; <span id ="message" style="font-family: 'NANUM'; font-weight: bold;"></span> 
			<input type="hidden" name="reid" id="reid"><br>
			<label style="margin-right: 50px;">비밀번호</label>
			<input type="password" name="pwd" size="10"  maxlength="15"><br>
			<label>비밀번호 확인</label>
			<input type="password" name="pwdCheck" size="10"  maxlength="15"><br>
			<label style="margin-right: 90px;">이름</label>
			<input type="text" name="name" autocomplete='off' size="10"  maxlength="10"><br>
			<label style="margin-right: 45px;">휴대전화</label>
			<input type="text" name="phone" autocomplete='off' size="11" maxlength="15" placeholder="숫자만 입력해주세요"><br>
			<label style="margin-right: 68px;">이메일</label>
			<input type="text" name="email1" autocomplete='off' style="margin-right: 20px;"><label>@</label>
			<select name="email2" style="width: 200px; height: 45px; border: 1px solid; margin-left: 10px; font-family: 'NANUM';">
				<option value="">선택</option>
				<option value="naver.com">naver.com</option>
				<option value="daum.net">daum.net</option>
				<option value="nate.com">nate.com</option>
				<option value="gmail.com">gmail.com</option>
				<option value="direct">직접입력</option>
			</select>
			<br>
			<div class="addr">
				<label style="margin-right: 90px;">주소</label>
				<input type="text" name = "zip_num" id="zip_num" placeholder="우편번호" style="margin-left: 40px; margin-right: 10px;">
				<input type="button" onclick="execDaumPostcode()" value="우편번호 찾기" style="border-style: none;"><br>
				<input type="text" name = "roadAddress" id="roadAddress" placeholder="도로명주소">
				<input type="text" name = "jibunAddress" id="jibunAddress" placeholder="지번주소">
				<span id="guide" style="color:#999;display:none"></span>
				<input type="text" name = "detailAddress" id="detailAddress" placeholder="상세주소">
				<input type="text" name = "extraAddress" id="extraAddress" placeholder="참고항목">
			</div>

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
			
		</fieldset>
		<div id="buttons" style="margin-bottom: 60px;">
			<input type="button" value="회원가입" class="submit" onclick="go_save();">
			<input type="reset" value="취소" class="cancel">
		</div>
	</form>
	
</article>
<%@ include file="/resources/includes/footer.jsp" %>

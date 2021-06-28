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
.easylogin img {
	width: 100px;
	height: 100px;
	object-fit: cover;
	
}
input {
	font-family: "NANUM";
	font-size: 20px;
	font-weight: bold;
}
</style>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script type="text/javascript">
	// window 객체
	// -> 브라우저의 요소들과 자바스크립트 엔진, 모든 변수를 담고있는 객체
	// document 객체
	// -> 웹사이트만 담당
	window.Kakao.init("d4f21ea37cb6b96b6c016ec8f605a4c5");
		// SDK를 초기화
	console.log(Kakao.isInitialized());
		// SDK 초기화 여부 판단 --> true 나오면 성공
		
	function kakaoLogin() {
		window.Kakao.Auth.login({
			scope:'profile, account_email, gender, birthday, age_range',
			// 추가 동의 받을 동의 항목 id 목록
			success: function(authObj) {
				console.log(authObj);
				window.Kakao.API.request({
					url:'/v2/user/me',
					success: res => {
						const kakao_account = res.kakao_account;
						console.log(kakao_account);
						
						console.log(kakao_account.email);
						console.log(kakao_account.profile['nickname']);
						console.log(kakao_account.gender);
						console.log(kakao_account.birthday);
						console.log(kakao_account.age_range);
						
						
						var email = kakao_account.email;
						var gender = kakao_account.gender;
						var age_range = kakao_account.age_range;
						var birthday = kakao_account.birthday;
						
						location.href="/member/login?email="+email+"&gender="+gender+"&age_range="+age_range+"&birthday="+birthday;
					},
					fail: function(error){
						alert(JSON.stringify(error));
					}
				});
				
			}
		})
	}
			
</script>
</head>
<body>
<article class="login" style="height: 950px;">

	<h1>로그인</h1><br>
	<hr width="980px"><br><br>
	<form action="/airbnb/member/login" method="post">
		<fieldset>
			<div class="loginbox">
				<label><h2>아이디 :</h2></label>
				<input name="id" type="text" placeholder="아이디를 입력하세요" style="font-size: 18px;"><br>
				<label><h2>비밀번호 :</h2></label>
				<input name="pwd" type="password" placeholder="비밀번호를 입력하세요" style="font-size: 18px">
			</div>
		</fieldset>
	
		<div class="main_join">
			<input type="button" class="gomain" value="홈으로 가기" onclick="location.href = '/airbnb/main'" style="border-style: none;">
			<input type="submit" class="gojoin" value="로그인하기" style="border-style: none; font-family: 'NANUM';">
		</div>
		<hr width="980px"><br>
		<div id="buttons">
			<input type="button" value="회원가입" class="submit" onclick="location.href = '/airbnb/member/join'">
			<input type ="button" value="아이디찾기" class="submit" onclick="location.href = '/airbnb/member/findId'">
			<input type ="button" value="비밀번호찾기" class="submit" onclick="location.href = '/airbnb/member/findPwd'">
		</div>
		<div class="easylogin" style="width: 60%; height:100px; margin: auto; text-align: center;">
		<br>
			<h2>간편로그인</h2>
				<img src="${ctx }/resources/images/facebook.jpg">
				<img src="${ctx }/resources/images/kakao.jpg" style="margin-left: 20px">
				<img src="${ctx }/resources/images/naver.png" style="width: 130px;">
		</div>
	</form>
</article>
<a href="javascript:kakaoLogin();"><img src="${ctx }/resources/images/kakao.jpg" style="margin-left: 20px"></a>



 <!-- 네이버아이디로로그인 버튼 노출 영역 -->
  <div id="naver_id_login"></div>
  <!-- //네이버아이디로로그인 버튼 노출 영역 -->
  <script type="text/javascript">
  	var naver_id_login = new naver_id_login("CAdAeq_W_hK2H895SPXh", "http://localhost:9090/member/login");
  	var state = naver_id_login.getUniqState();
  	naver_id_login.setButton("white", 2,40);
  	naver_id_login.setDomain("http://localhost:9090/");
  	naver_id_login.setState(state);
  	naver_id_login.setPopup();
  	naver_id_login.init_naver_id_login();

  </script>
<%@ include file="/resources/includes/footer.jsp" %>
</body>
</html>
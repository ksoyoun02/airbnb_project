<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath == '/' ? '': pageContext.request.contextPath}" scope="application"/>
<%@ include file="/resources/includes/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>후기작성</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script type="text/javascript" src="${ctx }/resources/js/jQuery/jquery.raty.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript">
	$(function() {
	    $('div#star').raty({
	        score: 3
	        ,path : "${ctx}/resources/images/star"
	        ,width : 200
	        ,click: function(score, evt) {
	            $("#starRating").val(score);
	            $("#displayStarRating").html(score);
	        }
	    });
	});

	$(document).ready(function() {
		
	    $('#test').on('keyup', function() {
	        $('#test_cnt').html("("+$(this).val().length+" / 3000)");
	 
	        if($(this).val().length > 3000) {
	            $(this).val($(this).val().substring(0, 3000));
	            $('#test_cnt').html("(3000 / 3000)");
	        }
	    });
	
	});
	
	/* 파일업로드 */
	$(document).ready(function() {
		var formObj = $("form[role='form']");
		
		$("button[type='submit']").on("click", function(e){
			e.preventDefault();
			    
			console.log("submit clicked");
			var str = "";
			    
			$(".uploadResult ul li").each(function(i, obj){
				var jobj = $(obj);
			      
				console.dir(jobj);
				console.log("-------------------------");
				console.log(jobj.data("filename"));
			    
				str += "<input type='hidden' name='reviewAttachList["+i+"].r_no' value='"+${rDto.r_code}+"'>";
				str += "<input type='hidden' name='reviewAttachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
				str += "<input type='hidden' name='reviewAttachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
				str += "<input type='hidden' name='reviewAttachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
				str += "<input type='hidden' name='reviewAttachList["+i+"].filetype' value='"+ jobj.data("type")+"'>";
			});
			    
			console.log(str);
			formObj.append(str).submit();
		});
			  
		var regex = new RegExp("(.*?)\.(png|jpg)$");
		var maxSize = 5242880; //5MB
			  
		function checkExtension(fileName, fileSize) {
			if(fileSize >= maxSize) {
				alert("파일 사이즈 초과");
				return false;
			}
			    
			if(!regex.test(fileName)) {
				alert("해당 종류의 파일은 업로드할 수 없습니다.");
				return false;
			}
			
			return true;
		}
		
		$("input[type='file']").change(function(e){

			var formData = new FormData();
			    
			var inputFile = $("input[name='uploadFile']");
			    
			var files = inputFile[0].files;
			    
			for(var i = 0; i < files.length; i++){

				if(!checkExtension(files[i].name, files[i].size) ){
					return false;
				}
				
				formData.append("uploadFile", files[i]);
			}
			    
			$.ajax({
				url: "${ctx}/uploadReviewAction",
				processData: false, 
				contentType: false,
				data: formData,
				type: "POST",
				dataType:"json",
				success: function(result){
					console.log(result); 
					showUploadResult(result); 
				}
			}); //$.ajax
		});  

		function showUploadResult(uploadResultArr) {
		    
		    if(!uploadResultArr || uploadResultArr.length == 0) { 
		    	return;
		    }
			    
		    var uploadUL = $(".uploadResult ul");
		    var str ="";
			    
		    $(uploadResultArr).each(function(i, obj) {
				if(obj.image){
					var fileCallPath = encodeURIComponent(obj.uploadPath+ "/s_" + obj.uuid + "_" + obj.fileName);
					str += "<li data-path='" + obj.uploadPath + "'";
					str +=" data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "' data-type='" + obj.image + "'"
					str +" ><div>";
					str += "<span> " + obj.fileName + "</span>";
					str += "<button type='button' data-file=\'" + fileCallPath + "\' "
					str += "data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'>x</i></button><br>";
					str += "<img src='${ctx}/display?fileName=" + fileCallPath + "'>";
					str += "</div>";
					str +"</li>";
				} else {
					var fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);			      
				    var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
					      
					str += "<li "
					str += "data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "' data-type='" + obj.image + "' ><div>";
					str += "<span> " + obj.fileName + "</span>";
					str += "<button type='button' data-file=\'" + fileCallPath + "\' data-type='file' " 
					str += "class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
					str += "<img src='${ctx}/resources/img/attach.png'></a>";
					str += "</div>";
					str +"</li>";
				}
			});
			    
			uploadUL.append(str);
		}

		$(".uploadResult").on("click", "button", function(e) {
			    
			console.log("delete file");
			      
			var targetFile = $(this).data("file");
			var type = $(this).data("type");
			var targetLi = $(this).closest("li");
			    
			$.ajax({
				url: "${ctx}/deleteFile",
				data: {fileName: targetFile, type:type},
				dataType:"text",
				type: "POST",
				success: function(result){
					alert(result);
			           
					targetLi.remove();
				}
			}); //$.ajax
		});

	});
</script>
<style type="text/css">

.r_img img{
	width: 315px;
    height: 210px;
    object-fit: cover;
    margin: 40px;
}

h3 {
	padding-top: 30px;
	font-family: "HANNA";
	font-size: 40px;
	margin-bottom: 0;
}

.content p {
	font-family:"O";
	font-size: 20px;
}

.review h1 {
	text-align: center;
    margin-right: 200px;
}
.s_button {
	text-align: center;
	margin-right: 150px;
	margin-top: 40px;
}
.s_button input {
	padding: 30px 60px 30px 60px;
	font-family: "HANNA";
	font-size: 30px;
	margin-right: 20px;
	border: 0;
}

.uploadResult {
		width: 100%;
		background-color: lavenderblush;
	}
	
	.uploadResult ul {
		display: flex;
		flex-flow: row;
		justify-content: center;
		align-items: center;
	}
	
	.uploadResult ul li {
		list-style: none;
		padding: 10px;
	}
	
	.uploadResult ul li img {
		width: 100px;
	}
	.submitButton input{
	border: none;
    border-radius: 30px;
    width: 200px;
    height: 40px;
    font-size: 25px;
    font-family: 'NANUMb';
    font-weight: bold;
}
.submitButton button{
	border: none;
    border-radius: 30px;
    width: 200px;
    height: 40px;
    font-size: 25px;
    font-family: 'NANUMb';
    font-weight: bold;
}
</style>
</head>
<body>
<div style="margin-left: 200px; margin-top: 120px;">
	<h1 style="margin-bottom: 0">후기작성</h1>
	<hr width="600px" style="margin-left:10px;"><br><br>
	<div class="review">
		<div style="background-color: aliceblue; width: 900px; height: 289px; margin-left: 280px;">
			<div class="r_img" style="float: left">
				<img src="${rDto.r_img}">
			</div>
			<div class="content" style="padding-top: 40px;">
				<h3 style="margin-top: 0;">${rDto.r_name}</h3>
				<p style="margin-top: 0">${rDto.r_g_name}</p>
				<p style="margin-bottom: 5px;">체크인 날짜 : ${rDto.r_checkIn}</p>
				<p style="margin-top: 0">체크아웃 날짜  : ${rDto.r_checkOut}</p>
			</div>
		</div>
		<hr width="1000px" style="margin-left: 230px; margin-top: 60px;"><br><br>
		<h1>숙소는 만족하셨나요?</h1>
			<form role="form" action="/airbnb/review/reviewAdd" method="post" name="reviewForm" enctype="multipart/form-data">
				<input type="hidden" name="r_id" value="${sessionScope.loginUser.id}">
				<input type="hidden" name="r_no" value="${rDto.r_no}"> 
				<input type="hidden" name="r_r_code" value="${rDto.r_code}">
				<input type="hidden" name="r_g_code" value="${rDto.r_g_code }">
				<input type="hidden" name="r_name" value="${rDto.r_name}">
				<input type="hidden" name="r_g_name" value="${rDto.r_g_name}">
				<input type="hidden" name="r_img" value="${rDto.r_img}">
				<div style="text-align: center; margin-right: 200px;">
					<div id="star" ></div>
				    <div style="padding-top:20px;">
				        <input type="hidden" id="starRating" disabled="disabled" name="score">
				    </div>
				        <p>별점을 선택해주세요</p>
				    <div>
				</div>
			    <hr width="1000px" style="margin-left: 230px; margin-top: 60px;"><br><br>
			    <h1 style="margin-right: 0px;">어떤점이 좋았나요?</h1>
			    <textarea id="test" name="r_content" cols="150" rows="30" placeholder="여기에 입력해주세요"></textarea>
				<div id="test_cnt">(0 / 3000)</div>
			    </div>
				<h1>사진첨부하기</h1>
			    <div style="margin-right: 130px; margin-top: 60px; text-align: center;">
				    <div class="form-group uploadDiv">
				    	<input type="file" name="uploadFile" multiple>
				    </div>
				      <div class="uploadResult"> 
				          <ul>
				          
				          </ul>
				       </div>
			    </div>
			    <div class="submitButton" style="text-align: center; margin-right: 200px; margin-top: 50px;">
		 			<button type="submit">submit</button>
		 			<input type="button" value="뒤로가기" onclick='history.back()'>
			   </div>
			</form>
	</div>
	</div>
	<br><br>
	<%@ include file="/resources/includes/footer.jsp" %>
</body>
</html>
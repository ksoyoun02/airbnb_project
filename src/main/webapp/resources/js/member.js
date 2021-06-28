/**
 * 
 */
 
 

function idcheck() {
	if (document.frm.id.value == "") {
		alert("아이디를 입력해주세요");
		document.frm.id.focus();
		return;
	}
	
	var url = "/airbnb/member/id_check?id=" + document.frm.id.value;
	
	var w = 400;
	var h = 200;
	
	var LeftPosition = (screen.width-w)/2;
	var TopPosition = (screen.height-h)/2;
	
	window.open(url, "_blank_1", "toolbar=no, menubar=no, scrollbars=yes, resizable=no, width=" + w +", height=" + h + ", top=" + TopPosition + ", left=" + LeftPosition);
	
}

function m_delete() {
	var url = "delete.airbnb";

	if (document.frm.pwd.value == ""){
		alert("비밀번호를 입력해주세요")
		document.frm.pwd.focus();
		return;
	}
}

function go_next(){
	if (document.frm.okon1[0].checked == true) {
		document.frm.action = "join_form.airbnb";
		document.frm.submit();
	}else if (document.frm.okon1[1].checked == true){
		alert("약관에 동의하셔야만 합니다.");
	}
	
}
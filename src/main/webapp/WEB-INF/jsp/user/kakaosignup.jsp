<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<!-- jquery : ajax, bootstrap, datepicker -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>  
	
	<!-- bootstrap -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

	<!-- css -->
	<link rel="stylesheet" href="/static/css/style.css">
</head>
<body class="signup-body">
	
	<div class="signup">
        <!-- 1. 로고 -->
		<h2 class="signup-logo" onclick="move('/user/sign-in')">회원가입</h2>
        <!-- 2. 필드 -->
        
        <div class="signup-pwd">
            <b>비밀번호</b>
            <input class="userpw" type="password" id="user_password">
            <small id="limitText" class="showLimit d-none">4~12자의 영문 소문자, 숫자와 특수기호만 사용 가능합니다.</small>
            
        </div>
        <div class="signup-repwd">
            <b>비밀번호 재확인</b>
            <input class="userpw-confirm" type="password" id="user_repassword">
        </div>
        
        
		<!-- 4. 필드(성별) -->
        <div class="signup-gender">
            <b>성별</b>
            <div>
                <label><input type="radio" name="gender" value="남자">남자</label>
                <label><input type="radio" name="gender" value="여자">여자</label>
                <label><input type="radio" name="gender" value="비공개">비공개</label>
            </div>
        </div>
        
        <!-- 5. 이메일_전화번호 -->
        <div class="signup-email">
            <b>본인 확인 이메일</b>
            <input type="email" placeholder="선택입력" id="user_email">
        </div>
        
       <!-- 6. 휴대폰 번호  -->
        <div class="signup-number">
            <b>휴대전화</b>
            <div>
                <input type="tel" placeholder="전화번호 입력(-없이 숫자만 입력해주세요)" id="user_phonenumber" maxlength="11">
                <input type="button" value="인증번호 받기" id="valid-phone">
            </div>
            
            <div class="d-flex">
            <input type="number" id="pnconfirm" placeholder="인증번호를 입력하세요">
            <button id="cofirm-pn">인증하기 </button>
            </div>
        </div>

        <!-- 6. 가입하기 버튼 -->
        <input type="button"class="btn submit-btn" value="가입하기" id="submit" name="submit">

        <!-- 7. 푸터 -->
        <div class="signup-footer">
            <div>
                <a href="#none">이용약관</a>
                <a href="#none">개인정보처리방침</a>
                <a href="#none">법적고지</a>
                <a href="#none">회원정보 고객센터</a>
            </div>
            <span><a href="#none">xxxxx World Corp.</a></span>
        </div>
    </div>
    
    
    
    
    	
     	
    
<script type="text/javascript">
// 핸드폰 숫자 방지 정규식
var replaceNotInt = /[^0-9]/gi;

//onclick 용
function move(result){
	
	location.href = result;
	
}

$(document).ready( function(){
	
	//아이디 중복확인 유효성 event
	$('#user_id').on('focusout', function(){
		let loginid = $('#user_id').val().trim();
		if (loginid.length < 4){
			$('#idcheckLength').removeClass('d-none');
			$('#duplicateNo').addClass('d-none');
			$('#confirmOk').addClass('d-none');
			return false;
		}
		$.ajax({
			url:"/user/is_duplicated_id"
			,data:{loginid}
			,success:function(data){
				if (data.result == true){
					$('#idcheckLength').addClass('d-none'); 
					$('#duplicateNo').removeClass('d-none'); 
					$('#confirmOk').addClass('d-none'); 
				}else{
					$('#idcheckLength').addClass('d-none'); 
					$('#duplicateNo').addClass('d-none'); 
					$('#confirmOk').removeClass('d-none'); 				
				}
			}
			, error:function(e){
				alert("아이디 중복확인에 실패했습니다.");
			}
		});
	});

	// 휴대폰번호 하이픈 자동 추가 정규식
	/* $(document).on('keyup', '#user_phonenumber', function() {
		$(this).val( $(this).val().replace(/[^0-9]/g, "").replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/,"$1-$2-$3").replace("--", "-") ); 
	}); */
	
	//휴대폰 숫자 방지 정규식 이용하여 특수문자 작성시 자동으로 지워짐 
	$('#user_phonenumber').on("focusout", function() {
		let user_phonenumber = $('#user_phonenumber').val().trim();
		if (user_phonenumber.length > 0){
			if (user_phonenumber.match(replaceNotInt)){
				user_phonenumber = user_phonenumber.replace(replaceNotInt, "");
			}
			$(this).val(user_phonenumber);
		}
	}).on('keyup', function() {
            $(this).val($(this).val().replace(replaceNotInt, ""));
        });
		
	//인증문자 보내는 코드 
	$('#valid-phone').on('click', function(e){
		e.preventDefault();
		let phoneNumber = $('#user_phonenumber').val().trim();

		//let user_phonenumber = '01064934287';
		
		$.ajax({
			type:"POST"
			, url : "/user/sendMessage"
			, data : {phoneNumber}
			, success : function(data) {
				if (data.code == 100) {
					alert("인증번호를 발송했습니다.");
					
				}
			}	
		});
	});
	//인증하기 버튼 눌렀을 때 인증번호 비교 
	$('#cofirm-pn').on('click', function(e){
		let pnconfirm = $('#pnconfirm').val().trim();
		let phoneNumber = $('#user_phonenumber').val().trim();

		$.ajax({
			type:"POST"
			, url : "/user/confirmMessage"
			, data : {pnconfirm, phoneNumber}
			, success : function(data) {
				if (data.code == 100) {
					alert("인증이 완료되었습니다.");
					
				}else{
					alert("인증번호를 다시 입력해주세요.");
					return false;
				}
			}	
		});
	});
	$('#submit').on('click', function(e){
		e.preventDefault();
		let loginid = ${loginid};
 		let password = $('#user_password').val().trim();
		let confirm = $('#user_repassword').val().trim();
		let nickname = '${nickname}';
		let gender = $('input[name="gender"]:checked').val();
		let email = $('#user_email').val().trim();
		let phonenumber = $('#user_phonenumber').val().trim();
		let path = '카카오';
		
		
		
		//패스워드 및 패스워드 확인 검사
		if (password=='' || confirm== ''){
			alert("비밀번호를 입력하세요 ");
			return false;
		}
		
		//패스워드 및 패스워드 확인 일치 검사
		if (password != confirm){
			alert("비밀번호가 일치하지 않습니다");
			return false;
		}
		
		//비밀번호입력시 특수문자조합 검사
		var reg = /^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{8,16}$/;
		if (!reg.test(password)) {
			$('#limitText').removeClass('d-none');
			$('#user_password').focus();
			return false;
		} 
		
		//성별 검사
		if(gender == undefined) {
			alert('성별을 선택해주세요');
			return false;
		} 
		
		//이메일 유효성 검사
		var regEmail = /^([\w\.\_\-])*[a-zA-Z0-9]+([\w\.\_\-])*([a-zA-Z0-9])+([\w\.\_\-])+@([a-zA-Z0-9]+\.)+[a-zA-Z0-9]{2,8}$/;
 	 	if (!regEmail.test(email) || email == '') {
 	 		alert('이메일 주소를 확인하세요');
 	 		$('#user_email').focus();
 	 		return false;
 	 	}
		
		
		//핸드폰 유효성 검사
		if( phonenumber == '') {
			alert('핸드폰 번호를 확인하세요');
			return false;
		}
		
		//닉네임 검사
		if (nickname == ''){
			alert("닉네임을 입력하세요 ");
			$('#user_nickname').focus();
			return false;
		} 
				
		$.ajax({
			type:"POST"
			, url : "/user/user_insert"
			, data : {loginid, password, nickname, gender, email, phonenumber, path }

			, success : function(data) {
				if (data.code == 100) {
					document.location.href="/test"
				} else if(data.code == 400) {
					alert("회원가입에 실패하였습니다");
				}
			}
			, error : function(e) {
				alert("관리자에게 문의 하세요");
			}
		});
				
	});	 //회원가입 버튼 event 닫기

	
	
	
}); // document.ready 닫기
</script>
</html>
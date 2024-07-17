<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>    
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-neo.css" rel="stylesheet">  
<link rel="stylesheet" href="/resources/css/sweetalert2.min.css">  
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<style>

* {

font-family: 'NanumSquareNeo'; 

}

input {

border: 3px solid;

}

h3 {
   color: black;
    margin-bottom: 30px;
    margin-top: 40px;
} 

</style>    

<script type="text/javascript">

$(function(){
	
});

function chk(){
	
	let password = $("#password").val();
	
	console.log("password : " + password);
	
	let data = {
		"password":password
	};
	
	$.ajax({
		url:"/main/pwCheck",
		contentType:"application/json;charset=utf-8",
		data:JSON.stringify(data),
		type:"post",
		dataType:"text",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success:function(result){
			console.log("result : ", result);
			if(result=="success"){
				$("#newPassword").removeAttr("readonly")
				$("#confPassword").removeAttr("readonly")
				Swal.fire({
  				title: '비밀번호 일치 성공.',         // Alert 제목
  				text: '새로운 비밀번호를 입력해주세요!',  // Alert 내용
  				icon: 'success',                         // Alert 타입
				});
				
			}
			
			if(result=="fail"){
				
				$("#newPassword").attr("readonly","true")
				$("#confPassword").attr("readonly","true")
				
				if(password == ''){
				Swal.fire({
	  				title: '비밀번호 공백 입력 불가.',         // Alert 제목
	  				text: '비밀번호를 다시 입력해주세요!',  // Alert 내용
	  				icon: 'error',                         // Alert 타입
					});
				}
				
				else {
				
				Swal.fire({
	  				title: '비밀번호 일치 실패.',         // Alert 제목
	  				text: '비밀번호를 다시 입력해주세요!',  // Alert 내용
	  				icon: 'error',                         // Alert 타입
					}); 
				
				$("#password").val("");
				
				}
			
			}
		}
	});
}

function save(){
	
	
	let newPass = $("#newPassword").val();
	let conPass = $("#confPassword").val();
	
	if(newPass == conPass){
	
	let data = {
			"newPass" : newPass,
			"conPass" : conPass
	}
	
	console.log("data : " , data)
	
	$.ajax({

		url:"/main/passwordChange2",
		contentType:"application/json;charset=utf-8",
		data:JSON.stringify(data),
		type:"post",
		dataType:"text",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success:function(result){
			console.log("result" + result)
			if(result == 1){
			Swal.fire({
  				title: '비밀번호 일치 성공.',         // Alert 제목
  				text: '비밀번호 변경이 완료되었습니다!',  // Alert 내용
  				icon: 'success',                         // Alert 타입
				});
			
				
				$("#newPassword").val("");
				$("#confPassword").val("");
				$("#password").val("");
				$("#newPassword").attr("readonly","true")
				$("#confPassword").attr("readonly","true")
			
			}
			else{
				Swal.fire({
					title: '비밀번호 변경 실패.',         // Alert 제목
					text: '비밀번호를 다시 입력해주세요!',  // Alert 내용
					icon: 'error',                         // Alert 타입
				});
			
				$("#newPassword").val("");
				$("#confPassword").val("");

			}
		}
		
	})
	
	} else {
		
		Swal.fire({
				title: '새 비밀번호 일치 실패.',         // Alert 제목
				text: '바꿀 비밀번호를 다시 입력해주세요!',  // Alert 내용
				icon: 'error',                         // Alert 타입
			});
		
		$("#newPassword").val("");
		$("#confPassword").val("");
		
	}
	
}

</script>

<h3>비밀번호 변경</h3><br>
<div style="background-color: white; height: 500px">
<div style="margin-left: 650px"><br><br>
<h6 style="margin-right: 100px; margin-top: 50px;"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-check-square" viewBox="0 0 16 16">
  <path d="M14 1a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1H2a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1zM2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2z"/>
  <path d="M10.97 4.97a.75.75 0 0 1 1.071 1.05l-3.992 4.99a.75.75 0 0 1-1.08.02L4.324 8.384a.75.75 0 1 1 1.06-1.06l2.094 2.093 3.473-4.425z"/>
</svg> 현재 비밀번호</h6>
<input class="col-3 form-control formdata" id="password" style="display:inline-block; height: 45px; width: 500px;"
type="password" value=""  />
<button type="button" onclick="chk()" class="btn btn-block btn-outline-success" style="height: 45px; width: 100px; margin-left: 10px; display:inline-block">확인</button>
<h6 style="margin-right: 110px; margin-top: 10px">
<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-check-square-fill" viewBox="0 0 16 16">
  <path d="M2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2zm10.03 4.97a.75.75 0 0 1 .011 1.05l-3.992 4.99a.75.75 0 0 1-1.08.02L4.324 8.384a.75.75 0 1 1 1.06-1.06l2.094 2.093 3.473-4.425a.75.75 0 0 1 1.08-.022z"/>
</svg> 새 비밀번호</h6>
<input class="col-3 form-control formdata" id="newPassword"
type="password" value="" style="height: 45px" readonly/>
<h6 style="margin-right: 80px; margin-top: 10px"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-check-square-fill" viewBox="0 0 16 16">
  <path d="M2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2zm10.03 4.97a.75.75 0 0 1 .011 1.05l-3.992 4.99a.75.75 0 0 1-1.08.02L4.324 8.384a.75.75 0 1 1 1.06-1.06l2.094 2.093 3.473-4.425a.75.75 0 0 1 1.08-.022z"/>
</svg> 새 비밀번호 확인</h6>
<input class="col-3 form-control formdata" id="confPassword"
type="password" style="height: 45px" value="" readonly/>
<br /><br /><br /><br /><br />
<div>
<button type="button" onclick="save()" class="btn btn-block btn-outline-success" style="width: 200px; display: inline-block; height: 45px; margin-top: -70px">저장</button>
					<sec:authorize access="hasRole('ROLE_STUDENT')">
<button type="button" onclick="location.href='/main/mypageDetail'" class="btn btn-block btn-outline-success" style="width: 200px; margin-left: 10px; display: inline-block; margin-top: -70px; height: 45px">돌아가기</button>
					</sec:authorize>
					<sec:authorize access="hasRole('ROLE_PROFESSOR')">
<button type="button" onclick="location.href='/main/mypageDetailPro'" class="btn btn-block btn-outline-success" style="width: 200px; margin-left: 10px; display: inline-block; margin-top: -70px; height: 45px">돌아가기</button>
					</sec:authorize></div>
</div>
</div>
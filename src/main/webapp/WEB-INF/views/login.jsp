<%@ page language="java" contentType="text/html;" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>    
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대덕인재대학교 학사관리시스템</title>
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-neo.css" rel="stylesheet">
<link rel="stylesheet" href="/resources/css/sweetalert2.min.css">
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<!-- Custom fonts for this template-->
<link href="/resources/sbadmin/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">

<link
    href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
    rel="stylesheet">
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
   <!-- Custom styles for this template-->
<link href="/resources/sbadmin/css/sb-admin-2.min.css" rel="stylesheet">
<!-- bootstrap js-->
<script type="text/javascript" src="/resources/js/bootstrap.min.js"></script>
<!-- sweetalert2 js -->
<script type="text/javascript" src="/resources/js/sweetalert2.min.js"></script>
<!-- sweetalert2 css -->
<link rel="stylesheet" href="/resources/css/sweetalert2.min.css" />
<style>

* {
	font-family: 'NanumSquareNeo'; 
}
#login-bottom {
    height: 200px;
    width: 100%;
    background: #053828;
    position: relative;
    top: 215px;
    color: white;
    padding: 15px;
    display: flex;
    align-items: center;
}
#h3 {
	font-weight: bold;
    color: black;
    padding-top: 20px;
    text-align: center;
    position: relative;
    top: -100px;
}
.h3 {
	opacity: 0; /* 초기에 숨기기 */
    transition: opacity 0.5s ease; /* fade-in 효과 */
}
#photo {
    opacity: 0; /* 초기에 숨기기 */
    transition: opacity 0.5s ease; /* fade-in 효과 */
}
.login-box {
    opacity: 0; /* 초기에 숨기기 */
    transition: opacity 0.5s ease; /* fade-in 효과 */
}
#login-bottom {
    opacity: 0; /* 초기에 숨기기 */
    transition: opacity 0.5s ease; /* fade-in 효과 */
}
</style>
</head>
<script type="text/javascript">
document.addEventListener("DOMContentLoaded", function() {
    setTimeout(function() {
        document.querySelector('#photo').style.opacity = 1;
    }, 250);

    setTimeout(function() {
        document.querySelector('.login-box').style.opacity = 1;
    }, 500);
    
    setTimeout(function() {
        document.querySelector('.h3').style.opacity = 1;
    }, 500);

    setTimeout(function() {
        document.querySelector('#login-bottom').style.opacity = 1;
    }, 500);
    
	$('#stNoAuto').on('click', function(){
		console.log('학번 찾기')
		$('#inputName').val('김지훈')
		$('#inputTel').val('010-0123-4567')
	})
	
	$('#passAuto').on('click', function(){
		console.log('비번 찾기')
		$('#inputName2').val('2212008')
		$('#inputEmail').val('ly2706@naver.com')
	})
});
</script>
<body>
<!-- <div style="background-image: url(../../resources/images/university-library-4825366_1920.jpg); height: 100vh; width: 100vw; background-size: cover; background-repeat: no-repeat; background-position: center center; display: flex; justify-content: center; align-items: center;"> -->
<div style="width: 100%; display: flex; height: 100vh; overflow: hidden">
	<div id="photo" style="flex: 0.6; box-sizing: border-box; background-image: url(../../resources/images/loginBackground05.jpg); 
	   background-size: cover; background-repeat: no-repeat; background-position: center center; display: flex; justify-content: center; 
	   align-items: center;">
   </div>
   <div style="flex: 1; box-sizing: border-box; display: flex; flex-direction: column; justify-content: center; align-items: center;">
   		<div class="h3">
	       <h3 id="h3" style="font-weight: bold; color: black; padding-top: 20px; text-align: center;">
	           <img src="resources/images/emblem3.png" style="margin-right: 10px; width: 40px; height: 40px;"> 대덕인재대학교 | 학사관리시스템
	       </h3>
       </div>
      <div class="login-box">
          <%
         String errorAlert = request.getParameter("error")==null?"1":"0";
         %>
      <%-- <c:set var="error" value="<%=error%>" /> --%>
         <c:set var="errorAlert" value="<%=errorAlert%>" />
         <div class="card text-center" style="border:0 !important">
             <div class="card-body login-card-body" style="margin:0 auto; position: relative; top:50px;">
                 <div style="float:left;border-right: 3px #a1a9a0 solid;padding-right: 50px;">
                     <p class="login-box-msg"></p>
                     <form action="/login" method="post">
                         <div class="input-group mb-3">
                             <!-- 아이디 -->
                             <input type="text" name="username" id="username" class="form-control" placeholder="아이디">
                             <div class="input-group-append">
                                 <div class="input-group-text">
                                     <span class="fas fa-envelope"></span>
                                 </div>
                             </div>
                         </div>
                         <div class="input-group mb-3">
                             <!-- 비밀번호 -->
                             <input type="password" name="password" id="password" class="form-control" placeholder="비밀번호">
                             <div class="input-group-append">
                                 <div class="input-group-text">
                                     <span class="fas fa-lock"></span>
                                 </div>
                             </div>
                         </div>
                         <div class="row">
                             <button type="submit" class="btn btn-block btn-outline-primary btncli col-4" 
                                style="margin:auto;">로그인</button>
                         </div>
                         <!--  csrf : Cross Site Request Forgery -->
                         <sec:csrfInput/>
                     </form>
                 </div>
                 <div style="float:left;margin:50px;">
                     <p style="cursor: pointer;" data-bs-toggle="modal" data-bs-target="#modalFind">학번/사번찾기
                         <i class="fas fa-search"></i>
                     </p>
                     <p style="cursor: pointer;" data-bs-toggle="modal" data-bs-target="#modalPwFind">비밀번호 찾기
                          <i class="fas fa-lock"></i>
                      </p>
                  </div>
              </div>
          </div>
      </div>
      <div class="" id="login-bottom">

               로그인 정보 > ID : 교직원 번호, 초기비밀번호 : 아이디랑 동일 번호<br>
               <br>
               시스템 문의 : 042-272-2727

       </div>
   </div>
</div>
	
	<!-- Modal(학번찾기) -->
	<div class="modal fade" id="modalFind" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h4 class="modal-title fs-5" id="exampleModalLabel">학번/사번 찾기</h4>
	      	<button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
	      </div>
	      <div class="modal-body">
	        	<div class="card-body row">
	
	<div class="col-7">
	<div class="form-group">
	<label for="inputName">성명</label>
	<input type="text" id="inputName" class="form-control">
	</div>
	<div class="form-group">
	<label for="inputSubject">연락처</label>
	<input type="text" id="inputTel" class="form-control">
	</div>
	
	</div>
	</div>
	      </div>
	      <div class="modal-footer">
	      	<button type="button" class="btn btn-outline-light" id="stNoAuto">자동 완성</button>
	        <button type="button" class="btn btn-block btn-outline-primary btncli" id="idsearch" style="width: 60px;">찾기</button>
<!-- 	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button> -->
	      </div>
	    </div>
	  </div>
	</div>
	
	
	<!-- Modal(비번찾기) -->
	<div class="modal fade" id="modalPwFind" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h4 class="modal-title fs-5" id="exampleModalLabel">비밀번호 찾기</h4>
	     	<button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
	      </div>
	      <div class="modal-body">
	        	<div class="card-body row">
	
	<div class="col-7">
	<div class="form-group">
	<label for="inputName">아이디</label>
	<input type="text" id="inputName2" name="stNo2" class="form-control">
	</div>
	<div class="form-group">
	<label for="inputSubject">이메일</label>
	<input type="text" id="inputEmail" name="stEmail" class="form-control">
	</div>
	
	</div>
	</div>
	      </div>
	      <div class="modal-footer">
	      	<button type="button" class="btn btn-outline-light" id="passAuto">자동 완성</button>
	        <button type="button" class="btn btn-block btn-outline-primary btncli" id="pwsearch" style="width: 60px;">찾기</button>
	<!--         <button id="mytui" type="button" class="btn btn-block btn-outline-primary btncli" -->
	<!-- 							data-toggle="modal" data-target="#modal-info" onclick="myclick()" style="width: 60px; display: inline-block; margin-left: 375px">등록</button> -->

	    </div>
	  </div>
	</div>
</div>

<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/@emailjs/browser@4/dist/email.min.js">
<script type="text/javascript">

(function(){
    emailjs.init({
      publicKey: "bH55yx15B4wJVUDBm",
    });
 })();</script>
 
<script>

let error = "${errorAlert}";//0이면 로그인실패

if(error=="0"){
	const Toast = Swal.mixin({
		  toast: true,
		  position: "center",
		  showConfirmButton: false,
		  timer: 1300,
		  timerProgressBar: true,
		  didOpen: (toast) => {
		    toast.onmouseenter = Swal.stopTimer;
		    toast.onmouseleave = Swal.resumeTimer;
		  }
		});
		Toast.fire({
		  icon: "error",
		  title: "아이디 혹은 비밀번호를 잘못 입력하셨습니다."
		});
}

let name = '';
let tel = '';
let email = '';
let pass = '';


$('#idsearch').on('click',function(){
	
	name = $("#inputName").val();
	tel = $("#inputTel").val();

	let data = {
			"userName" : name,
			"userTel" : tel
	}
	
	console.log("data : ", data);
	
	$.ajax({
	
		url: "/main/findid",
		contentType: "application/json;charset=utf-8",
		data: JSON.stringify(data),
		type: "post",
		dataType: "text",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success:function(userNo){
			console.log("userNo : " , userNo);
// 			alert("찾으시는 학번/사번은" + userNo + "입니다.")
			Swal.fire({
  				title: '회원 정보 일치 성공',         // Alert 제목
  				text: '찾으시는 학번/사번은 ' + userNo + ' 입니다.',  // Alert 내용
  				icon: 'success',                         // Alert 타입
				});
				
				$("#inputName").val("");
				$("#inputTel").val("");
				
		},
		error:function(){
// 			alert("찾으시는 학번/사번이 존재하지 않습니다. 다시 입력해주세요.")
			Swal.fire({
  				title: '회원 정보 일치 실패',         // Alert 제목
  				text: '회원 정보를 다시 입력해주세요!.',  // Alert 내용
  				icon: 'error',                         // Alert 타입
				});
				
				
			$("#inputName").val("");
			$("#inputTel").val("");
			
		}
		
	})
})

$('#pwsearch').on('click',function(){
	
	name = $("input[name='stNo2']").val();
	email = $("input[name='stEmail']").val();
	
	let data = {
			"stNo" : name,
			"stEmail" : email
	}
	
	console.log("data : ", data);
	
	$.ajax({
		
	url:"/main/findpw",
	contentType:"application/json;charset=utf-8",
	data:JSON.stringify(data),
	type:"post",
	dataType:"text",
	beforeSend:function(xhr){
		xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
	},
	success:function(result){
		
		console.log("result : " , result)
		
		if(result != ''){
		console.log("result : " , result)
		pass = result;
		ready();}
		else {
			
			Swal.fire({
  				title: '회원 정보 일치 실패',         // Alert 제목
  				text: '회원 정보를 다시 입력해주세요!.',  // Alert 내용
  				icon: 'error',                         // Alert 타입
				});
			
			
			$("#inputName2").val("");
			$("#inputEmail").val("");
			
		}
	}
	
	})
	
	
})

function ready(){
	emailjs.init("p-3XdeV8JeAsfG-AC");		
    //"user_xxxxx"이 부분은 사용자마다 다르니 반드시 emailJS의 installation 화면을 확인
   // $('input[name=submit]').click(function(){       	 
      
      var templateParams = {	
      //각 요소는 emailJS에서 설정한 템플릿과 동일한 명으로 작성!
            id: $('input[name=userName]').val(),
            email: $('input[name=stEmail]').val(),
            password: pass
       //     phone: $('input[name=phone]').val(), 
       //     message : $('textarea[name=message]').val()
       				};
                
            	
     emailjs.send('service_1a0c0we', 'template_9ph9exh', templateParams)
     //emailjs.send('service ID', 'template ID', 보낼 내용이 담긴 객체)
     	    .then(function(response) {
     	       console.log('SUCCESS!', response.status, response.text);
 //    	       alert("입력하신 이메일로 임시 비밀번호가 전송되었습니다!")
   				Swal.fire({
  				title: '회원 정보 일치 성공',         // Alert 제목
  				text: '입력하신 이메일로 임시 비밀번호가 전송되었습니다! 로그인 해주세요.',  // Alert 내용
  				icon: 'success',                         // Alert 타입
				});
 
   				$("#inputName2").val("");
   				$("#inputEmail").val("");				
 
 
     	    }, function(error) {
     	       console.log('FAILED...', error);
     	    });
     	       

  //  });
    
  }; 



</script>
</body>
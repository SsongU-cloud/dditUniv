<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-neo.css" rel="stylesheet">
<link rel="stylesheet" href="/resources/css/sweetalert2.min.css">  	
<!-- <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet"> -->
<!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script> -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<style>
* {
	font-family: 'NanumSquareNeo';
}

h3 {
	color: black;
	margin-bottom: 30px;
	margin-top: 40px;
	margin-left: 90px;
}

.form-control {
	display: inline-block;

}

#modify, #list, #cancel {
	width: 200px;
	margin-top: 20px;
	margin-left: 10px;
}
/* 
#modify {
	border: 3px solid #BDB76B;
	background-color: white;
	width: 100px;
	margin-top: 20px;
	margin-right: 10px;
}
 */
 /* 
#modifypw {
	border: 3px solid #808000;
	background-color: white;
	width: 150px;
	margin-top: 20px;
	margin-right: 10px;
}
 */
.img-fluid {
	width: 280px;
	height: 343px;
}

.custom-file {
	margin-top: 20px;
	width: 280px;
}

p {
	margin-bottom: 25px;
}

#userInfoShow {
	display: flex;
	margin-right: -.75rem;
	margin-left: -2.5rem;
}

.trBackground>th {
	background-color: #ebf1e9;
	text-align: center;
	vertical-align: middle !important;
	height: 63px;
}

.trBackground>td {
	vertical-align: middle;
	height: 63px;
	width: 220px;
}

input:focus{
    border-color:#e3e6f0;
  outline: none; 
}
/* 
.form-control {
  background-color: #e3e6f0;
  border-radius: 5px;
  width: 100%;
  height: 35px;
}
 */
.form-container {
  width: 60%;
  margin: auto;
}

input:not(#picupload), input:not(#inputpw0), input:not(#inputpw1),  input:not(#inputpw2){

/*   -webkit-appearance: none; */
/*   -webkit-border-radius: 0; */
/*     border: 0; */
/*     outline: none; */
	border: none; 
	background: transparent;
	border-bottom-style: 

}

.btn-primary {
  margin-left: 10px;
  background-color: #20b2aa;
  border: 0;
  height: 35px;
}
label {
  display: inline-block;
  width: 150px;
}


/* 
#save {
	border: 3px solid #BDB76B;
	background-color: white;
	width: 100px;
	margin-top: 20px;
	margin-right: 10px;
}

#cancel {
	border: 3px solid #6C757D;
	background-color: white;
	width: 100px;
	margin-top: 20px;
	margin-left: 10px;
}
 */
.ahrfhr {
  width: 105px;
  justify-content: center;
  display: inline-block;
}
.nav-tabs {
    border-bottom: 1px solid #dee2e6;
}
/* input:disabled { */
/*     background: #FFF; */
/* } */
</style>
<script>


function handleImg(e){
	
	//<p id="pImg"></p> 영역에 이미지 미리보기를 해보자
	//이벤트가 발생 된 타겟 안에 들어있는 이미지 파일들을 가져와보자
	
	// 업로드한 이미지 개별
	let files = e.target.files;
	// 업로드한 이미지 배열
	let fileArr = Array.prototype.slice.call(files);

	fileArr.forEach(function(f){
		//이미지 파일이 아닌 경우 이미지 미리보기 실패 처리(MIME타입)
		if(!f.type.match("image.*")){
			alert("이미지 확장자만 가능합니다.");
			//함수 종료
			return;
		}
		//이미지 객체를 읽을 자바스크립트의 reader 객체 생성
		let reader = new FileReader();
		
//		$("#proimage").css("display","none");
		
		
		//e : reader가 이미지 객체를 읽는 이벤트
		reader.onload = function(e){

		$("#proimage").attr("src", e.target.result);
		}
		//f : 이미지 파일 객체를 읽은 후 다음 이미지 파일(f)을 위해 초기화 함
		reader.readAsDataURL(f);
	});

	
}

$(function() { // 동적 함수 >> 수정버튼 클릭시 일어나는 이벤트

	// 수정 버튼 클릭
	$('#modify').on('click', function(){
	// 일부 버튼 활성화
	$("input[name='picture']").removeAttr('hidden')
	$("#photoup").removeAttr('hidden')
	$("input[name='userInfoVO.userTel']").removeAttr('readonly')
//	$("input[name='userInfoVO.userTel']").css('border-radius', '5px');
//	$("input[name='userInfoVO.userTel']").css('background-color', '#e3e6f0');
//	$("input[name='userInfoVO.userTel']").attr('class', 'col-10 form-control');
	$("input[name='userInfoVO.userTel']").css('border-bottom-style', 'solid');
	$("input[name='userInfoVO.userTel']").css('border-bottom-color', '#e3e6f0');
	$("input[name='stEmail']").removeAttr('readonly')
	$("input[name='stEmail']").css('border-bottom-style', 'solid');
	$("input[name='stEmail']").css('border-bottom-color', '#e3e6f0');
	$("input[name='stAddr']").removeAttr('readonly')
	$("input[name='stAddr']").css('border-bottom-style', 'solid');
	$("input[name='stAddr']").css('border-bottom-color', '#e3e6f0');
	$("input[name='stPostno']").removeAttr('readonly')
	$("input[name='stPostno']").css('border-bottom-style', 'solid');
	$("input[name='stPostno']").css('border-bottom-color', '#e3e6f0');
	$("input[name='stAddrDet']").removeAttr('readonly')
	$("input[name='stAddrDet']").css('border-bottom-style', 'solid');
	$("input[name='stAddrDet']").css('border-bottom-color', '#e3e6f0');
	$("select[name='militaryService']").removeAttr('disabled')
	$("select[name='militaryService']").css('border-bottom-style', 'solid');
	$("select[name='militaryService']").css('border-bottom-color', '#e3e6f0');
	$("input[name='stBank']").removeAttr('readonly')
	$("input[name='stBank']").css('border-bottom-style', 'solid');
	$("input[name='stBank']").css('border-bottom-color', '#e3e6f0');
//	$("input[name='userInfoVO.userName']").removeAttr('readonly')
//	$("input[name='userInfoVO.userName']").css('background-color', '#DCDCDC');
	$("input[name='stAcount']").removeAttr('readonly')
	$("input[name='stAcount']").css('border-bottom-style', 'solid');
	$("input[name='stAcount']").css('border-bottom-color', '#e3e6f0');
	$('#searchno').removeAttr('hidden')
	$('#militaryService').removeAttr('readonly')
//	$("input[name='militaryService']").css('background-color', '#e3e6f0');

	// 수정,삭제
	$('#p1').css('display', 'none');
	$('#p2').css('display', 'block');




	// 우편번호 검색(다음)
	$('#searchno').on("click", function() {

		sample6_execDaumPostcode();

	})

})

})


function sample6_execDaumPostcode() {
	new daum.Postcode({
		oncomplete : function(data) {

			var addr = data.roadAddress;

			document.getElementById("stPostno").value = data.zonecode; // 우편번호
			document.getElementById("stAddr").value = addr; // 주소

			document.getElementById("stAddrDet").focus(); // 상세주소
		}
	}).open();
}

$(function() {

 $("input[name='picture']").on("change",handleImg);
 

})	
		
	



</script>
<h3>마이페이지</h3>
	<div class="card card-primary card-outline card-outline-tabs" style="width:90%; margin:0 auto;">
		<div class="card-header p-0 border-bottom-0">
			<ul class="nav nav-tabs" id="custom-tabs-four-tab" role="tablist">
				<li class="nav-item"><a class="nav-link active"
					id="custom-tabs-four-home-tab" data-toggle="pill"
					href="#custom-tabs-four-home" role="tab"
					aria-controls="custom-tabs-four-home" aria-selected="true">내정보</a>
				</li>
				<li class="nav-item"><a class="nav-link"
					id="custom-tabs-four-profile-tab" data-toggle="pill"
					href="#custom-tabs-four-profile" role="tab"
					aria-controls="custom-tabs-four-profile" aria-selected="false">비밀번호 변경</a>
				</li>
			</ul>
		</div>
		<div class="card-body">
			<div class="tab-content" id="custom-tabs-four-tabContent">
				<div class="tab-pane fade active show" id="custom-tabs-four-home"
					role="tabpanel" aria-labelledby="custom-tabs-four-home-tab">
					<form action="/main/mypageUpdate" method="post"
						enctype="multipart/form-data" id="myform">
						<div class="container-fluid" style="height: 100%">
							<div class="card card-solid">
								<div class="card-body pb-0  col-12">
									<div class="col-12 col-6 d-flex align-items-stretch flex-column">
										<div class="card-body pt-6">
											<div id="userInfoShow">
						
													<div class="col-3 text-center">
														<img id="proimage" src="${stuAttachFileVO.stuFilePath}"
															 alt="user-avatar" class="img-square img-fluid user-avatar">
														<div class="form-group text-center">
															<div class="custom-file text-left">
																<input type="file" name="picture" id="picupload"
																	 id="uploadFile" hidden="true"> <label
																	 id="photoup" for="uploadFile" hidden="true"
																	></label>
															</div>
														</div>
													</div>
													<input id="deptNo" type="hidden" 
														value="${studentDetail.comDetCodeVO.comDetCode}">
													<div class="card-body table-responsive p-0"
														style="border: 1px solid #e3e6f0;">
														<table class="table table-hover text-nowrap"
															style="margin-bottom: 0px;">
															<thead>
																<tr class="trBackground">
																	<th>소속대학</th>
																	<td id="stUniv" style="color: black">대덕인재대학교</td>
																	<th>단과대학</th>
																	<td id="comCodeName"><input 
																	id="stCollege" type="text" 
																	value="${studentVO.comCodeVO.comCodeName}" readonly></td>
																	
																	<th>학과</th>
																	<td id="deptName"><input 
						 											id="stDept" type="text" 
						 											value="${studentVO.comDetCodeVO.comDetCodeName}" readonly></td>
																</tr>
																
																
																<tr class="trBackground">
																	<th>학번</th>
																	<td id="stNo"><input 
						 											 id="stNo" type="text" 
						 											value="${studentVO.stNo}" readonly></td>
																	<th>이름</th>
																	<td><input name="userInfoVO.userName"
																	 id="stName" type="text" 
																	value="${studentVO.userInfoVO.userName}" readonly></td>
																	<th>성별</th>
																	<td><input 
						 											id="stName" type="text" 
																	value="${studentVO.stGender}" readonly></td>
																</tr>
																<tr class="trBackground" id="proChaNo">
																	<th>생년월일</th>
																	<td><input 
						 											 id="stName" type="text" 
																	value="${studentVO.userInfoVO.userBirth.substring(0,10)}" readonly></td>
																	<th>군필 여부</th>
																	<td colspan="3">
																	<select class="form-control" name="militaryService" id="militaryService" style="width: 100px;background-color: white;" disabled> 
						 											<option value="${studentVO.militaryService}">${studentVO.militaryService}</option> 
						 											<c:if test="${studentVO.militaryService eq '군필'}"> 
																		<option value="미필">미필</option> 
						 											</c:if> 
						 											<c:if test="${studentVO.militaryService eq '미필'}"> 
						 												<option value="군필">군필</option>
						 											</c:if></select></td>
																</tr>
																<tr class="trBackground">
																	<th>이메일</th>
																	<td><input name="stEmail" class="updateinput"
						 											 id="stName" type="text" 
																	value="${studentVO.stEmail}" readonly></td>
																	<th>학년</th>
																	<td><input 
						 											 id="stName" type="text" 
																	value="${studentVO.stGrade}학년" readonly></td>
																	<th>학적상태</th>
																	<td class="formdata-stStat"><input 
						 											 id="stName" type="text" 
																	value="${studentVO.studentStatVO.stStat}" readonly></td>
																</tr>
																<tr class="trBackground">
																	<th>연락처</th>
																	<td><input name="userInfoVO.userTel"
						 											 id="stName" type="text" class="updateinput" 
																	value="${studentVO.userInfoVO.userTel}" readonly></td>
																	<th>입학일</th>
																	<td><input 
						 											 id="stName" type="text" 
																	value="${studentVO.admissionDate.substring(0,10)}" readonly></td>
																	<th>졸업일</th>
																	<td colspan='4'><input id="stGradDate" 
						 											type="text" value="${studentVO.stGradDate.substring(0,10)}" 
						 											pattern="yyyy-mm-dd" readonly></td>
																</tr>
																<tr class="trBackground">
																	<th>은행명</th>
																	<td><input name="stBank" class="updateinput"
						 											 id="stBank" type="text" 
						 											name="stBank" value="${studentVO.stBank}" readonly></td>
																	<th>계좌번호</th>
																	<td colspan="3"> <input name="stAcount" class="updateinput"
						 											 id="stAccountNm" type="text" style="width: 100%"
																	name="stAcount" value="${studentVO.stAcount}" pattern="^(\d{1,})(-(\d{1,})){1,}" 
						 											 readonly></td>
																</tr>
																<tr class="trBackground">
																	<th>우편번호</th>
																	<td colspan="5"><input name="stPostno" class="updateinput"
																	 id="stPostno" type="text" 
						 											value="${studentVO.stPostno}" name="stPostno" pattern="[0-9]{5}"  
						 											 readonly>	
						<!--  											 <input class="btn" type="button" value="검색"  -->
						<!-- 											style="margin-left: 10px; height: 35px; background-color: #ebf1e9; border-color: #6e707e; color: black; border: none" -->
						<!--  											id="searchno" hidden="true"> -->
						 											<button type="button" class="form-control btn btn-outline-success col-1" id="searchno" hidden="true" style="margin-left: 7px;">검색</button> </td>
																</tr>
																<tr class="trBackground">
																	<th>주소</th>
																	<td colspan="3"><input id="stAddr" class="updateinput"
						 											type="text" style="width: 100%" value="${studentVO.stAddr}" name="stAddr" 
																	readonly> </td>
																	<th>상세 주소</th>
																	<td><input 
																	id="stAddrDet" type="text" class="updateinput"
																	value="${studentVO.stAddrDet}" name="stAddrDet" readonly></td>
																</tr>
															</thead>
														</table>
													</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="text-center">
							<sec:csrfInput />
							<div class="text-center">
								<p id="p1">
									<button type="button" class="btn btn-block btn-outline-warning ahrfhr" id="modify" onsubmit="valid()">수정</button>
						<!-- 			<button type="button" class="btn" id="modifypw" -->
						<!-- 				onclick="location.href='/main/passwordChange' ">비밀번호 변경</button> -->
									<!-- <button type="button" class="btn btn-block btn-outline-primary ahrfhr" style=" width: 130px; margin-top: 20px;"id="modifypw"
											data-toggle="modal" data-target="#modalPwFind">비밀번호 변경</button> -->
								</p>
								<p id="p2" style="display: none;">
									<button type="submit" class="btn btn-block btn-outline-primary ahrfhr" id="save" style="margin-top: 20px;">저장</button>
									<button type="button" class="btn btn-block btn-outline-danger ahrfhr" id="cancel" style="margin-left: 1px;width: 100px;"
										onClick="location.href='/main/mypageDetail'">취소</button>
								</p>
							</div>
						</div>
						</form>
				</div>
				
				<div class="tab-pane fade" id="custom-tabs-four-profile"
					role="tabpanel" aria-labelledby="custom-tabs-four-profile-tab">
						<div class="modal-body">
				<div class="card-body row" style="margin-left: 440px;">
					<div class="col-11">
			  <table>
					<tr style="margin-bottom: 20px; display: block;">
						<td><label for="inputName" style="margin-top: 10px">현재 비밀번호</label></td>
						<td><input type="password" id="password" name="userName" class="form-control" style="border: 1px solid #c7c1c1;"></td>
						<td>
							<button type="button" onclick="chk()" class="btn btn-block btn-outline-success" style="margin-left:10px;">인증</button>
						</td>
					</tr>
					<tr style="margin-bottom: 20px; display: block;">
						<td><label for="inputSubject">새 비밀번호</label></td>
						<td colspan="2"><input type="password" id="newPassword"
							name="stEmail" class="form-control" style="background-color: #e3e6f0; border: 1px solid #c7c1c1; width:235px;" readonly></td>
						</tr>
					<tr style="margin-bottom: 20px; display: block;">
						<td><label for="inputSubject">새 비밀번호 확인</label></td>
						<td colspan="2"><input type="password" id="confPassword"
							name="stEmail" class="form-control" style="background-color: #e3e6f0; border: 1px solid #c7c1c1; width:235px; "readonly></td>
						</tr>
					</table>
				</div>
			</div>
		</div>
			<div class="modal-footer">
			<!-- 	<button onclick="save()" type="button" class="btn btn-primary"
					style="background-color: #1cc88a; border-style: none" id="pwsearch">저장</button> -->
					<p>
						<button onclick="save()" type="button" class="btn btn-block btn-outline-primary ahrfhr" id="pwsearch" style="margin-right: 605px;">저장</button>
					</p>
					<!-- <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button> -->
			</div>
				</div>

	</div>
</div>




<!-- Modal(비번찾기) -->
<div class="modal fade" id="modalPwFind" tabindex="-1"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title fs-5" id="exampleModalLabel">비밀번호 변경</h4>
			</div>
			<div class="modal-body">
				<div class="card-body row">

					<div class="col-11">
						<div class="form-group">
							<label for="inputName">현재 비밀번호</label><br> <input
								style="background-color: #e3e6f0; border-radius: 5px; width: 60%; height: 35px"
								type="password" id="password" name="userName"
								class="form-control">
							<button type="button" onclick="chk()" class="btn btn-primary"
								style="margin-left: 10px; background-color: #20b2aa; border: 0">인증</button>
						</div>
						<div class="form-group">
							<label for="inputSubject">새 비밀번호</label><br>
							 <input style="background-color: #e3e6f0; border-radius: 5px; width: 60%; height: 35px"
								type="password" id="newPassword" name="newPassword"
								class="form-control">
						</div>
						<div class="form-group">
							<label for="inputSubject">새 비밀번호 확인</label><br> <input
								style="background-color: #e3e6f0; border-radius: 5px; width: 60%; height: 35px"
								type="password" id="confPassword" name="confPassword"
								class="form-control">
						</div>

					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button onclick="save()" type="button" class="btn btn-primary"
					style="background-color: #1cc88a; border-style: none" id="pwsearch">저장</button>
				<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>

<script>
let password = '';
function chk(){
	
	password = $("#password").val();
	
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
				$("#newPassword").css("background-color", "white")
				$("#confPassword").css("background-color", "white")
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
	
	if(password === newPass){
		Swal.fire({
			title: '비밀번호 변경 실패.',         // Alert 제목
			text: '현재 비밀번호와 동일합니다',  // Alert 내용
			icon: 'error',                         // Alert 타입
		});
		return;
	}
	
	if(newPass == conPass && newPass != '' && conPass != ''){
	
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
				$("#newPassword").css("background-color", "#e3e6f0")
				$("#confPassword").css("background-color", "#e3e6f0")
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
				title: '새 비밀번호 저장 실패.',         // Alert 제목
				text: '바꿀 비밀번호를 다시 입력해주세요! 공백은 불가능합니다',  // Alert 내용
				icon: 'error',                         // Alert 타입
			});
		
		$("#newPassword").val("");
		$("#confPassword").val("");
		
	}
	
}



</script>
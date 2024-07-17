
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!-- <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet"> -->
<!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script> -->
<link rel="stylesheet" href="/resources/css/sweetalert2.min.css" />
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-neo.css" rel="stylesheet">
<script type="text/javascript" src="/resources/js/sweetalert2.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js">
</script>
<style>
.row {
  justify-content: center;
}
.ahrfhr {
  width: 105px;
  justify-content: center;
  display: inline-block;
}
h3 {
    color: black;
    margin-bottom: 30px;
    margin-top: 40px;
    margin-left: 113px;
}
.card-body {
    flex: 1 1 auto;
    min-height: 1px;
    padding: 4.25rem;
}
.userImage{
	width: 260px;
	height: 320px;
	margin-top: 32px;
	margin-left: 59px;
}
.btn:not(:disabled):not(.disabled) {
    cursor: pointer;
    margin-top: -6px;
}
.card {
   width: 90%;  /*목록 넓이*/
}
</style>
<script type="text/javascript">
//서버에서 발행된 헤더네임과 토큰갑사 저장
const header = '${_csrf.headerName}';
const token =  '${_csrf.token}';
//e : onchange 이벤트
$(function() {
	//우편번호 검색(다음)
	$('#searchno').on("click", function() {
	    sample6_execDaumPostcode();
	});
	
    $("#uploadFile").on("change", handleImg);

    function handleImg(e) {
        let files = e.target.files;
        let fileArr = Array.prototype.slice.call(files);
        fileArr.forEach(function(f) {
            if (!f.type.match("image.*")) {
                alert("이미지 확장자만 가능합니다.");
                return;
            }
            let reader = new FileReader();
            $(".userImage").html("");
            reader.onload = function(e) {
//                 console.log(e.target.result);
                $(".userImage").attr("src", e.target.result);
            };
            reader.readAsDataURL(f);
        });
    }

    $('#insert').on('click', function(){
    	console.log("등록");
    	
		let dept = $('#deptCode')
//     	console.log(dept.val())
    	
    	let date = new Date();
		let year = date.getFullYear();
		
		let lastTwoDigits = year.toString().slice(-2);
		let deptTemp = '';
		
// 		console.log("이거 머임???",lastTwoDigits)
		
		let firstPart = parseInt(dept.val().substring(1, 4), 10);  // D001 -> 1
	    let secondPart = parseInt(dept.val().substring(4, 7), 10); // 001 -> 1
	    deptTemp = lastTwoDigits+'D'+firstPart+secondPart
	    
	    console.log("얜 또 뭐임???????????",deptTemp)

    	//폼데이터 수집
    	let formData = new FormData();
    	  //let userName = $('#userName');
    	 formData.append("userInfoVO.userName", $('#userName').val());		//교수 이름
    	 formData.append("userInfoVO.userTel", $('#userTel').val());		//교수 폰번호
         formData.append("deptCode", $('#deptCode').val());					//교수 학과 코드
         formData.append("proStudy", $('#proStudy').val());					//연구실
         formData.append("empDate", $('#empDate').val());					//입사일
  //     formData.append("proRetireDate", $('#proRetireDate').val());   	//퇴사일
         formData.append("salary", $('#salary').val());						//연봉
         formData.append("proEmail", $('#proEmail').val());					//교수 이메일
         formData.append("proPostno", $('#proPostno').val());				//우편 번호
         formData.append("proAddr", $('#proAddr').val());					//교수 주소
         formData.append("proAddrDet", $('#proAddrDet').val());				//상세 주소
         formData.append("userInfoVO.userBirth", $('#userBirth').val());	//생년월일
         formData.append("uploadFile", $('#uploadFile')[0].files[0]);		//첨부 파일
         formData.append("deptTemp",deptTemp)								// 교수 아이디 자동생성 시 필요한 앞 5자리
         
         //AJAX요청
          $.ajax({
            url: "/manager/profAddAjax",
            data: formData,
            type: "POST",
            processData: false, // 필수, FormData 사용 시 false로 설정
            contentType: false, // 필수, FormData 사용 시 false로 설정
            dataType:"text",
            beforeSend: function(xhr) {
                xhr.setRequestHeader(header, token);
        	},
            success: function(rslt) {
            	console.log("result : ",rslt);
            	if(rslt === "SUCCESS"){
            	  Swal.fire({
                      position: "center",
                      icon: "success",
                      title: "등록되었습니다.",
                      timer: 1500,
                         showConfirmButton: false // 확인 버튼을 숨깁니다. 
                    }).then(() => {
                      // Swal.fire의 타이머가 끝난 후 호출됩니다.
		                window.location.href = "/manager/profList?menuId=pstProChk"; // 성공 시 이동할 페이지
                    });
            	}
            },
			error: function (xhr, status, error) {
        		console.log("code: " + xhr.status)
        		console.log("message: " + xhr.responseText)
        		console.log("error: " + error);
    		}

          });
    });
    
    $('#auto').on('click', function(){
    	$('#userName').val('김교수')
    	$('#userTel').val('010-4561-3248')
    	$('#proStudy').val('W101')
    	$('#empDate').val('2024-03-06')
    	$('#salary').val('5000')
    	$('#proEmail').val('prof001@gmail.com')
    	$('#userBirth').val('1979-11-18')
    })
});
	
function sample6_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            var addr = data.roadAddress;
            document.getElementById("proPostno").value = data.zonecode; // 우편번호
            document.getElementById("proAddr").value = addr; // 주소
            document.getElementById("proAddrDet").focus(); // 상세주소
        }
    }).open();
}

</script>
<body>
<h3>교수정보 추가</h3>
<form:form modelAttribute="professorVO" action="/manager/profAdd" method="post" enctype="multipart/form-data"
	onsubmit="retrun fn_check()">
<div class="card card-solid" style="margin-left: 100px;">
	<div class="card-body pb-0"
		style="width: 2000px; height: 786px;">
		<div class="row">
			<div
				class="col-md-7 d-flex align-items-stretch flex-column" style="margin-left: -416px;">
				<div class="card bg-light d-flex flex-fill" style="height:617px">
					<div class="card-header text-muted border-bottom-0" style="background-color: #F0F1F2;">
						<br>
					</div>

					<div class="card-body pt-0" style="background-color: #F0F1F2;">
						<div class="row">
							<div class="col-7">
								<h2 class="lead" align="center"
									style="font-weight: bold; font-size: 24px; margin-top: 30px;">
								<input type="text" class="form-control-lg col-7 formdata" id="userName" value="" placeholder="교수명"
									style="text-align: center;">
								</h2>
								<br>
									<p class="text-muted text-sm" style="font-size: 18px; display: flex; flex-direction: row; align-items: baseline;">
										<label for="dept">학과명 :&nbsp;</label>
										<select class="form-control col-4" name="deptCode" id="deptCode">
											<option selected disabled>학과 선택</option>
											<c:forEach var="comCodeVO" items="${deptList}" varStatus="stat">
												<c:forEach var="comDetCodeVO" items="${comCodeVO.comDetCodeVOList}" varStatus="stat">
 	 												<option value="${comDetCodeVO.comDetCode}">${comDetCodeVO.comDetCodeName}</option>
												</c:forEach>
											</c:forEach>
										</select>
										<label for="study">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;연구실 :&nbsp;</label>
										<input type="text" class="form-control col-4 formdata" id="proStudy" value="" >
									</p>

									<p class="text-muted text-sm" style="font-size: 18px; display: flex; flex-direction: row; align-items: baseline;">
										<label for="empDate">연락처 :&nbsp;</label>
										<input type="text" class="form-control col-4 formdata" id="userTel" value="" >
										<label for="empDate">&nbsp;&nbsp;생년월일 :&nbsp;</label>
										<input type="date" class="form-control col-4 formdata" id="userBirth" value="" >	
									</p>
									<p class="text-muted text-sm" style="font-size: 18px; display: flex; flex-direction: row; align-items: baseline;">
										<label for="empDate">입사일 :&nbsp;</label>
										<input type="date" class="form-control col-4 formdata" id="empDate" value="" placeholder="">
									    <label for="salary" style="margin-left: 4px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;연봉 :&nbsp;</label>
										<input type="text" class="form-control col-3 formdata" id="salary" value="" style="text-align: right;">&nbsp;만원
<!-- 									    <label for="retireDate">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;퇴사일 :&nbsp;</label> -->
<!-- 										<input type="date" class="form-control col-4 formdata" id="proRetireDate" value="" > -->
									</p>
									<p class="text-muted text-sm" style="font-size: 18px; display: flex; flex-direction: row; align-items: baseline;">
										<label for="email">이메일 :&nbsp;</label>
										<input type="text" class="form-control col-10 formdata" id="proEmail" value="" >
									</p>
									<p class="text-muted text-sm" style="font-size: 18px; display: flex; flex-direction: row; align-items: baseline;">
										<label for="proPostno" style="margin-left: -16px;">우편번호 :&nbsp;</label>
										<input type="text" class="form-control col-4 formdata" id="proPostno" value="" disabled>
										<input type="button" value="검색" class="btn btn-block btn-outline-success col-2" id="searchno" style="margin-left:10px;" >
									</p>

									<p class="text-muted text-sm" style="font-size: 18px; display: flex; flex-direction: row; align-items: baseline;">
										<label for="addr" style="margin-left: 4px;">&nbsp;&nbsp;&nbsp;주소 :&nbsp;</label>
										<input type="text" class="form-control col-9 formdata" id="proAddr" value="" disabled>
									</p>
									<p class="text-muted text-sm" style="font-size: 18px; display: flex; flex-direction: row; align-items: baseline; margin-left: -20px">
										<label for="addrDet" style="margin-left: 2px;">상세주소 :&nbsp;</label>
										<input type="text" class="form-control col-9 formdata" id="proAddrDet" value="" >
									</p>
							</div>
						<div class="col-5 text-center" >
 							<img src="../../../resources/images/default.jpg" alt="user-avatar" class="img-square img-fluid userImage">
								<input type="file" name="uploadFile" id="uploadFile" class="readonly" style="display: none;" />
								<label for="uploadFile" class="btn btn-outline-secondary" style="margin-left: 68px; margin-top: 27px;">파일 업로드</label>
							</div>
						</div>
					</div>
					<div class="card-footer">
						<div class="text-center" style="font-weight: bold">
							<p style="margin: 0px 0px 0px 0px;">
								대덕인재대학교 <img src="../../../resources/images/emblem3.png"
									alt="user-avatar" class="img-circle img-fluid" width="40"
									height="40">
							</p>
						</div>

					</div>
					</div>
						<div class="text-center mt-4">
							<p style="margin-right: 100px;">
							 	<button type="button" class="btn btn-block btn-outline-primary ahrfhr" id="insert">등록</button>
								<button type="button" onclick="location.href='/manager/profList?menuId=pstProChk'"
								class="btn btn-block btn-outline-secondary ahrfhr" id="delete">취소</button>
								<button type="button" class="btn btn-outline-light" id="auto"
									style="position: relative; left:327px;">자동 완성</button>
							</p>
						</div>
					</div>
				</div>
			</div>
		</div>
 </form:form>
</body>
</html>

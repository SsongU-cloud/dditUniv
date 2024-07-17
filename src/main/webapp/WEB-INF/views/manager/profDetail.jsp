<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/resources/css/sweetalert2.min.css" />
<script type="text/javascript" src="/resources/js/sweetalert2.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>
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
    margin-left: 165px;
} 
.card-body {
    flex: 1 1 auto;
    min-height: 1px;
    padding: 4.25rem;
}
.userImage{
	width: 260px;
	height: 320px;
}
.btn:not(:disabled):not(.disabled) {
    cursor: pointer;
    margin-top: -6px;
}
.card-solid {
    width: 1300px;
    margin: auto;
}
.custom-file {
  margin-top: 20px;
  width: 260px;
}
.proName {
  height: 50px;
  font-size: 27px;
  font-weight: 600;
  margin: auto;
}
</style>
<script>
$(function(){
	 // 우편번호 검색(다음)
    $('#searchPostNo').on("click", function() {
        sample6_execDaumPostcode();
    });
	// 초기 값 저장
	let proName			= '${professorVO.userInfoVO.userName}';	//이름
	let proPosition 	= '${professorVO.proPosition}';			//직급
	let proStudy 		= '${professorVO.proStudy}';			//연구실
	let empDate 		= '${professorVO.empDate}';				//입사일
	let proRetireDate 	= '${professorVO.proRetireDate}';		//퇴사일
	let proEmail 		= '${professorVO.proEmail}';			//이메일
	let salary			= '${professorVO.salary}';				//연봉
	let proPostno 		= '${professorVO.proPostno}'			//우편번호
	let proAddr 		= '${professorVO.proAddr}';				//주소
	let proAddrDet 		= '${professorVO.proAddrDet}';			//상세주소
	let userTel 		= '${professorVO.userInfoVO.userTel}';	//핸드폰번호

	// 수정 버튼 클릭
	$('#modify').on('click', function(){	
		$('.formdata').removeAttr('readonly');		// 읽기 전용 해제
		$('.custom-select').removeAttr('disabled');  // 비활성화 해제
		$('#searchPostNo').prop("type",'button');
		$('.custom-file-input').prop("type",'file');
		$('.custom-file-label').css("display",'inline-block');
		$('.proName').removeAttr('disabled');
		

		$('#p1').hide(); // 수정, 목록 버튼 숨기기
		$('#p2').show(); // 저장, 취소 버튼 보이기
	});
	
	// 취소 버튼 클릭
	$('#cancel').on('click', function(){
		
		// 이전 값으로 되돌리기 
		$('.proName').val(proName);							//교수이름
		$('#proPosition').val(proPosition);					//직급
		$('#proStudy').val(proStudy);						//연구실
		$('#empDate').val(empDate);							//입사일
		$('#proRetireDate').val(proRetireDate);				//퇴사일
		$('#proEmail').val(proEmail);						//이메일
		$('#salary').val(salary);							//연봉
		$('#proPostno').val(proPostno);						//우편본호
		$('#proAddr').val(proAddr);							//주소
		$('#proAddrDet').val(proAddrDet);				    //상세주소		
		$('#userTel').val(userTel);							//핸드폰
		
		
		$('.formdata').attr('readonly', true); // 읽기 전용 설정
		
		$('#searchPostNo').prop("type",'hidden');
		$('.custom-file-input').prop("type",'hidden');
		$('.custom-file-label').css("display",'none');
		$('.proName').attr('disabled',true);
		$('#p1').show(); // 수정 버튼 보이기
		$('#p2').hide(); // 저장, 취소 버튼 숨기기

	});
	
	// 저장 버튼 클릭
	$('#save').on('click', function(){
		let data = {
			proNo:			$('#proNo').val(), 
			proPosition:	$('#proPosition').val(),
			proStudy:		$('#proStudy').val(),
			empDate:		$('#empDate').val(),
			proRetireDate:	$('#proRetireDate').val(),
			proEmail:		$('#proEmail').val(),
			salary:			$('#salary').val(),
			proPostno:		$('#proPostno').val(),
			proAddr:		$('#proAddr').val(),
			proAddrDet:		$('#proAddrDet').val(),
			proTel:			$('#userTel').val(),
			proName:	    $('#userName').val()
			
		};
		
		let formData = new FormData();
		formData.append('proNo',$('#proNo').val())
		formData.append('proPosition',$('#proPosition').val())
		formData.append('proStudy',$('#proStudy').val())
		formData.append('empDate',$('#empDate').val())
		formData.append('proRetireDate',$('#proRetireDate').val())
		formData.append('proEmail',$('#proEmail').val())
		formData.append('salary',$('#salary').val())
		formData.append('proPostno',$('#proPostno').val())
		formData.append('proAddr',$('#proAddr').val())
		formData.append('proAddrDet',$('#proAddrDet').val())
		formData.append('proTel',$('#userTel').val())
		formData.append('proName',$('#userName').val())
		
		let inputFile = $("#uploadFile");
        let file = inputFile[0].files;
        console.log("file.length:" + file.length);
        for (let i = 0; i < file.length; i++) {
            formData.append("uploadFile", file[i]);
        }

		let values = formData.values();
        
        for (const pair of values) {
            console.log(pair); 
        }

		// console.log("data : ", data);
		// 알람창 
		const Toast = Swal.mixin({
            toast: true,
            position: 'center',
            showConfirmButton: false,
            timer: 300000,
        });

        Swal.fire({
            title: "수정하겠습니까?",
            icon: "warning",
            showCancelButton: true,
            confirmButtonColor: "#FFC107",
            cancelButtonColor: "#6C757D",
            confirmButtonText: "확인",
            cancelButtonText: "취소"
        }).then((result) => {
            if (result.isConfirmed) {
            	
            	// ajax 시작 
                $.ajax({
                    url: "/manager/updateProfAjax",
                    type: "POST",
                    processData: false,
                    contentType: false,
                    data: formData,
                    dataType: "text",
                    beforeSend: function(xhr){
                        xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
                    },
                    success: function(result){
                        console.log(result);
                        if(result > 0){
                            $('.formdata').attr('readonly', true);
                            $('#p1').css('display','block');
                            $('#p2').css('display','none');
                            $('.proName').attr('disabled',true);
                        }                        
                    }
                });

                Swal.fire({
                    title: "수정되었습니다!",
                    icon: "info"
                });
            }
        });
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
	document.querySelector('#uploadFile').addEventListener('change', function (e) {
	    var fileName = document.getElementById("uploadFile").files[0].name;
	    var nextSibling = e.target.nextElementSibling;
	    nextSibling.innerText = fileName;
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
	                $(".userImage").attr("src", e.target.result);
	            };
	            reader.readAsDataURL(f);
	        });
	    }
});
</script>

<body>
<h3>교수 상세 정보 조회</h3>
<div class="card card-solid">
	<div class="card-body pb-0">
		<div class="col-12">
			<div
				class="col-md-12 d-flex align-items-stretch flex-column" style="margin-top: -41px">
				<div class="card bg-light d-flex flex-fill" style="height:660px">
					<div class="card-header text-muted border-bottom-0">
						<br>
					</div>
					<div class="card-body pt-0">
						<div class="row">
							<div class="col-7">
								<h2 class="lead" align="center" style="font-weight: bold; font-size: 27px;">
								
									<input type="text" id="userName" name="userName" value="${professorVO.userInfoVO.userName}" class="form-control text-center col-3 proName" disabled>
								</h2>
								<br>
									
									<p class="text-muted text-sm" style="font-size: 18px; display: flex; flex-direction: row; align-items: baseline; ">
										<label for="dept">학과명 :&nbsp;</label>
										<input type="text" class="form-control col-4 formdata" id="comDetCodeName" value="${professorVO.comDetCodeVO.comDetCodeName}" readonly disabled>
										<label for="proPosition">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;직급 :&nbsp;</label>
										<input type="text" class="form-control col-4 formdata" id="proPosition" name="proPosition" value="${professorVO.proPosition}" readonly>
									</p>
									
									<p class="text-muted text-sm" style="font-size: 18px; display: flex; flex-direction: row; align-items: baseline;">
									    <label for="userNo">&nbsp;&nbsp;&nbsp;&nbsp;사번:&nbsp;</label>
									    <input type="hidden" id="proNo" name="proNo" value="${professorVO.userInfoVO.userNo}" />
										<input type="text" class="form-control col-4 formdata" id="userNo" name="userNo"value="${professorVO.userInfoVO.userNo}" readonly disabled>
										<label for="userTel">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;연락처 :&nbsp;</label>
										<input type="text" class="form-control col-4 formdata" id="userTel" name="userTel" value="${professorVO.userInfoVO.userTel}" readonly>
									</p>
								
									<p class="text-muted text-sm" style="font-size: 18px; display: flex; flex-direction: row; align-items: baseline;">
										<label for="proStudy">연구실 :&nbsp;</label>
										<input type="text" class="form-control col-4 formdata" id="proStudy" name="proStudy" value="${professorVO.proStudy}" readonly>
										<label for="userBirth">&nbsp;&nbsp;&nbsp;&nbsp;생년월일 :&nbsp;</label>
										<input type="date" class="form-control col-4 formdata" id="userBirth" name="userBirth" value="${professorVO.userInfoVO.userBirth}" readonly disabled>
									</p>
									<p class="text-muted text-sm" style="font-size: 18px; display: flex; flex-direction: row; align-items: baseline;">
										<label for="empDate">입사일 :&nbsp;</label>
										<input type="date" class="form-control col-4 formdata" id="empDate" name="empDate" value="${professorVO.empDate}" readonly>
									    <label for="proRetireDate">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;퇴사일 :&nbsp;</label>
										<input type="date" class="form-control col-4 formdata" id="proRetireDate" name="proRetireDate" value="${professorVO.proRetireDate}" readonly>
									</p>
									<p class="text-muted text-sm" style="font-size: 18px; display: flex; flex-direction: row; align-items: baseline;">
										<label for="proEmail">이메일 :&nbsp;</label>
										<input type="text" class="form-control col-4 formdata" id="proEmail" name="proEmail" value="${professorVO.proEmail}" readonly>
										<label for="salary">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;연봉 :&nbsp;</label>
										<input type="text" class="form-control col-3 formdata" id="salary"  name ="salary" value="${professorVO.salary}" style="text-align: right;" readonly>&nbsp;만원
									
									</p>
									<p class="text-muted text-sm" style="font-size: 18px; display: flex; flex-direction: row; align-items: baseline;">
										<label for="proPostno" style="margin-left: -21px;">우편번호 :&nbsp;</label>
										<input type="text" class="form-control col-4 formdata" id="proPostno" name="proPostno" value="${professorVO.proPostno}" readonly style="margin-right:15px;">
										<input type="hidden" class="form-control btn btn-outline-success col-3" id="searchPostNo" value="우편번호 검색">
									</p>
									<p class="text-muted text-sm" style="font-size: 18px; display: flex; flex-direction: row; align-items: baseline;">
										<label for="proAddr">&nbsp;&nbsp;&nbsp;&nbsp;주소 :&nbsp;</label>
										<input type="text" class="form-control col-7 formdata" id="proAddr" name="proAddr" value="${professorVO.proAddr}" readonly>
									</p>
									<p class="text-muted text-sm" style="font-size: 18px; display: flex; flex-direction: row; align-items: baseline; margin-left: -20px">
										<label for="proAddrDet">상세주소 :&nbsp;</label>
										<input type="text" class="form-control col-9 formdata" id="proAddrDet" name="proAddrDet" value="${professorVO.proAddrDet}" readonly>
									</p>
							</div>
<!-- 							<div class="col-5 text-center" > -->
<!-- 								<div> -->
<%-- 									<img src="${professorVO.comAttachDetVO.phySaveRoute}" --%>
<!-- 											alt="user-avatar" class="img-square img-fluid userImage"> -->
<!-- 									<label class="custom-file-label" for="uploadFile">Choose file</label> -->
<!-- 	                                <input type="hidden" name="stuAttaFile" class="custom-file-input" id="uploadFile"> -->
<!--                                 </div> -->
<!-- 							</div>  -->
							<div class="col-5 text-center" style="margin-top: 64px;">
		                        <img src="${professorVO.comAttachDetVO.phySaveRoute}"
		                           alt="user-avatar" class="img-square img-fluid userImage">
		                        <div class="form-group text-center">
		                            <div class="custom-file text-left">
		                                <input type="hidden" name="stuAttaFile" class="custom-file-input" id="uploadFile">
		                                <label class="custom-file-label" for="uploadFile" style="display:none;">파일변경</label>
		                            </div>
		                         </div>
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
							<p id="p1">
								<button type="button" class="btn btn-block btn-outline-warning btncli ahrfhr" id="modify" style="margin-right: 10px;">수정</button>
								<button type="button" onclick="location.href='/manager/profList?menuId=pstProChk'" 
								class="btn btn-block btn-outline-secondary btncli ahrfhr" id="delete">목록</button>
							</p>
							<p id="p2" style="display: none;">
								<button type="button" class="btn btn-block btn-outline-primary ahrfhr" id="save" style="margin-right: 10px;">저장</button>
								<button type="button" class="btn btn-block btn-outline-danger ahrfhr" id="cancel">취소</button>
							</p>
						</div>

			</div>

		</div>
	</div>
</div>
	
</body>
</html>
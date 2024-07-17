<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-neo.css" rel="stylesheet">
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
.form-control{
  display:inline-block;
}
#modify, #list, #save, #cancel {
  width: 100px;
  margin-top: 20px;
  margin-left: 10px;
}
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
  height:63px;
}
.trBackground>td {
  vertical-align: middle;
  height:63px;
  width:220px;
}
/* input:disabled { */
/*     background: #FFF; */
/* } */

</style>
<script>
let stNo = '';
$(function(){

	stNo = $('#stNo').text();
	let militaryService = $('select[name="militaryService"]').val();
	let militaryStat;
	let stStat = $('input[name="stStat"]').val();
	let stGrade = $('input[name="stGrade"]').val();
	let admissionDate = $('input[name="admissionDate"]').val();
	let stGradDate = $('input[name="stGradDate"]').val();
	let stBirth = $('input[name="stBirth"]').val()
	let stName = $('#stName').val()
	let stTel = $('input[name="stTel"]').val()
	let profNo = $('#profNo').val()
	let stPostNo = $('#stPostNo').val()
	let stPost = $('#stPost').val()
	let stPostDt = $('#stPostDt').val()
	let stBank = $('#stBank').val()
	let stAcount = $('#stAcount').val()
	let stEmail = $('#stEmail').val()
	let stImage = $('.user-avatar').attr("src")
	
	proChaAdd()
	
// 	console.log(stTel)

	let proCha = '';
	
// 	let dept = $('#comDetCode');
	
	// 수정 버튼 클릭
	$('#modify').on('click', function(){
		let dept = $('#deptNo')
		let data = {
			'dept':dept.val()
		}
		
		$.ajax({
			url:"/manager/getProfList",
			contentType:"application/json;charset='utf-8'",
			data:JSON.stringify(data),
			type:"POST",
			dataType:"json",
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
			success:function(result){
//					console.log(result)
				
				$("#proChaNo").last().children().eq(4).remove();
				$("#proChaNo").last().children().eq(4).remove();
				$("#proChaNo").last().children().eq(4).remove();
				
				let str = "";
				
				str += `
					<th>담당 교수</th>
					<td>
					<select class="custom-select form-control-border border-width-2" name="profNo" id="profNo">
				`;
				$.each(result, function(idx, profVO){
					str += `
						<option value="\${profVO.userInfoVO.userNo}">\${profVO.userInfoVO.userName}</option>
					`;
				})
				str += `</select></td>`;
				
				$('#proChaNo').append(str);
			}
		})
		
		let strs = "";
		
		strs += `<div class="col-3 text-center">
					<img src="${studentDetail.stuAttachFileVO.stuFilePath}"
						alt="user-avatar" class="img-square img-fluid user-avatar">
					<div class="form-group text-center">
					    <div class="custom-file text-left">
					        <input type="file" name="stuAttaFile" class="custom-file-input" id="uploadFile">
					        <label class="custom-file-label" for="uploadFile">Choose file</label>
					    </div>
					 </div>
				</div>
				<input id="deptNo" type="hidden" value="${studentDetail.comDetCodeVO.comDetCode}">
				<div class="card-body table-responsive p-0" style="border: 1px solid #e3e6f0;">
					<table class="table table-hover text-nowrap" style="margin-bottom:0px;">
						<thead>
							<tr class="trBackground">
								<th>소속대학</th>
								<td id="stUniv">대덕인재대학교</td>
								<th>단과대학</th>
								<td id="comCodeName">${studentDetail.comCodeVO.comCodeName}</td>
								<th>학과</th>
								<td id="deptName">${studentDetail.comDetCodeVO.comDetCodeName}</td>
							</tr>
							<tr class="trBackground">
								<th>학번</th>
								<td id="stNo">${studentDetail.stNo}</td>
								<th>이름</th>
								<td class="stName">
									<input id="stName" type="text" class="form-control" 
									value="${studentDetail.userInfoVO.userName}">
								</td>
								<th>성별</th>
								<td>${studentDetail.stGender}</td>
							</tr>
							<tr class="trBackground" id="proChaNo">
								<th>생년월일</th>
								<td class="stBirth">
									<input id="stBirth" type="date" class="form-control" 
									value="${studentDetail.userInfoVO.userBirth}">
								</td>
								<th>군필 여부</th>
								<td class="militaryService">
									<select class="custom-select form-control" name="militaryService" style="margin-right: 20px;">
										<option value="unfulfilled">미필</option>
										<option value="fulfilled">군필</option>
									</select>
								</td>
								
							</tr>
							<tr class="trBackground">
								<th>이메일</th>
								<td class="stEmail">
									<input id="stEmail" type="text" class="form-control" 
									value="${studentDetail.stEmail}">
								</td>
								<th>학년</th>
								<td class="stGrade">
									<input id="stGrade" type="text" class="form-control" 
									value="${studentDetail.stGrade}">
								</td>
								<th>학적상태</th>
								<td class="stStat">
									<input id="stStat" type="text" class="form-control" 
									value="${studentDetail.studentStatVO.stStat}">
								</td>
							</tr>
							<tr class="trBackground">
								<th>연락처</th>
								<td class="stTel">
									<input id="stTel" type="text" class="form-control" 
									value="${studentDetail.userInfoVO.userTel}">
								</td>
								<th>입학일</th>
								<td class="admissionDate">
									<input id="admissionDate" type="date" class="form-control" 
									value="${studentDetail.admissionDate}">
								</td>
								<th>졸업일</th>
								<td class="stGradDate">
									<input id="stGradDate" type="date" class="form-control" 
									value="<c:if test="${studentDetail.stGradDate == null}"> - </c:if>${studentDetail.stGradDate}">
								</td>
							</tr>
							<tr class="trBackground">
								<th>은행명</th>
								<td class="stBank">
									<input id="stBank" type="text" class="form-control" 
									value="${studentDetail.stBank}">
								</td>
								<th>계좌번호</th>
								<td class="stBank" colspan="3">
									<input id="stAcount" type="text" class="form-control" 
									value="${studentDetail.stAcount}">
								</td>
							</tr>
							<tr class="trBackground">
								<th>우편번호</th>
								<td class="stPostno" colspan="5" style="display:flex">
									<input id="stPostno" type="text" class="form-control" 
										value="${studentDetail.stPostno}" style="width:172px;" disabled>
									<input type="button" class="btn btn-block btn-outline-success" style="margin-left:15px;" value="우편번호 찾기" 
										id="postNoSearch" onclick="sample6_execDaumPostcode()" >
								</td>
							</tr>
							<tr class="trBackground">
								<th>주소</th>
								<td class="stAddr" colspan="3">
									<input id="stAddr" type="text" class="form-control" 
									value="${studentDetail.stAddr}" disabled>
								</td>
								<th>상세 주소</th>
								<td class="stAddrDet" colspan="3">
									<input id="stAddrDet" type="text" class="form-control" 
									value="${studentDetail.stAddrDet}">
								</td>
								
							</tr>
						</thead>
					</table>
				</div>`;
		
		$('#userInfoShow').html(strs);
		
		
		$('#p1').css('display','none');
		$('#p2').css('display','block');
		
	})
	
	// 취소 버튼 클릭
	$('#cancel').on('click', function(){
		
		const Toast = Swal.mixin({
            toast: true,
            position: 'center',
            showConfirmButton: false,
            timer: 300000,
        });

        Swal.fire({
        	  title: "수정을 취소하시겠습니까??",
        	  icon: "warning",
        	  showCancelButton: true,
        	  confirmButtonColor: "#3085d6",
        	  cancelButtonColor: "#d33",
        	  confirmButtonText: "예",
        	  cancelButtonText:"아니요"
        	}).then((result) => {
        	  if (result.isConfirmed) {
					let str = "";
					str += `<div class="col-3 text-center">
								<img src="${studentDetail.stuAttachFileVO.stuFilePath}"
									alt="user-avatar" class="img-square img-fluid user-avatar">
								<div class="form-group text-center">
								    <div class="custom-file text-left">
								        <input type="hidden" name="stuAttaFile" class="custom-file-input" id="uploadFile">
								        <label class="custom-file-label" for="uploadFile" style="display:none;">Choose file</label>
								    </div>
							 	</div>
							</div>
							<input id="deptNo" type="hidden" value="${studentDetail.comDetCodeVO.comDetCode}">
							<div class="card-body table-responsive p-0" style="border: 1px solid #e3e6f0;">
								<table class="table table-hover text-nowrap" style="margin-bottom:0px;">
									<thead>
										<tr class="trBackground">	
											<th>소속대학</th>
											<td  id="stUniv">대덕인재대학교</td>
											<th>단과대학</th>
											<td  id="comCodeName">${studentDetail.comCodeVO.comCodeName}</td>
											<th>학과</th>
											<td  id="deptName">${studentDetail.comDetCodeVO.comDetCodeName}</td>
										</tr>
										<tr class="trBackground">
											<th>학번</th>
											<td  id="stNo">${studentDetail.stNo}</td>
											<th>이름</th>
											<td>${studentDetail.userInfoVO.userName}</td>
											<th>성별</th>
											<td >${studentDetail.stGender}</td>
										</tr>
										<tr class="trBackground" id="proChaNo">
											<th>생년월일</th>
											<td >${studentDetail.userInfoVO.userBirth}</td>
											<th>군필 여부</th>
											<td>${studentDetail.militaryService}</td>
										</tr>
										<tr class="trBackground">
											<th>이메일</th>
											<td>${studentDetail.stEmail}</td>
											<th>학년</th>
											<td>${studentDetail.stGrade}학년</td>
											<th>학적상태</th>
											<td class="formdata-stStat">${studentDetail.studentStatVO.stStat}</td>
										</tr>
										<tr class="trBackground">
											<th>연락처</th>
											<td>${studentDetail.userInfoVO.userTel}</td>
											<th>입학일</th>
											<td>${studentDetail.admissionDate}</td>
											<th>졸업일</th>
											<td  colspan='4'> <c:if test="${studentDetail.stGradDate == null}"> - </c:if>${studentDetail.stGradDate}</td>
										</tr>
										<tr class="trBackground">
											<th>은행명</th>
											<td>${studentDetail.stBank}</td>
											<th>계좌번호</th>
											<td colspan="3">${studentDetail.stAcount}</td>
										</tr>
										<tr class="trBackground">
											<th>우편번호</th>
											<td  colspan="5">${studentDetail.stPostno}</td>
										</tr>
										<tr class="trBackground">
											<th>주소</th>
											<td  colspan="3">${studentDetail.stAddr}</td>
											<th>상세 주소</th>
											<td>${studentDetail.stAddrDet}</td>
										</tr>
									</thead>
								</table>
							</div>`;
					$('#userInfoShow').html(str);

        			$('#p1').css('display','block');
        			$('#p2').css('display','none');
        			
        			proChaAdd()
        	  	}
        	  
        	});
	})

	// 저장 버튼 클릭
	$('#save').on('click', function(){
		let formData = new FormData();
		
		militaryService = $('select[name="militaryService"]').val();
		stTel = $('#stTel').val();
		stStat = $('#stStat').val();
		stGrade = $('#stGrade').val();
		admissionDate = $('#admissionDate').val();
		stGradDate = $('#stGradDate').val();
		stBirth = $('#stBirth').val()
		profNo = $('#profNo').val()
		stName = $('#stName').val()
		stBank = $('#stBank').val()
		stAcount = $('#stAcount').val()
		stPostNo = $('#stPostno').val()
		stPost = $('#stAddr').val()
		stPostDt = $('#stAddrDet').val()
		stEmail = $('#stEmail').val()
		
// 		console.log(stPostNo)
// 		console.log(stPost)
// 		console.log(stPostDt)

		if(militaryService === 'unfulfilled'){
			militaryStat = '미필';
		} else {
			militaryStat = '군필';
		}
		
		formData.append("stNo", stNo);
		formData.append("stName", stName);
		formData.append("stTel", stTel);
		formData.append("stPostno", stPostNo);
		formData.append("stAddr", stPost);
		formData.append("stAddrDet", stPostDt);
		formData.append("stAcount", stAcount);
		formData.append("stBank", stBank);
		formData.append("militaryService", militaryStat);
		formData.append("stEmail", stEmail);
		formData.append("stGrade", stGrade);
		formData.append("proChaNo", profNo);
		formData.append("admissionDate", admissionDate);
		formData.append("stGradDate", stGradDate);
		formData.append("stBirth", stBirth);
		formData.append("stStat", stStat);
					
		let inputFile = $("#uploadFile");
        let file = inputFile[0].files;
        console.log("file.length:" + file.length);
        for (let i = 0; i < file.length; i++) {
            formData.append("uploadFile", file[i]);
        }
		
//         let values = formData.values();
        
//         for (const pair of values) {
//             console.log(pair); 
//         }
		
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
            confirmButtonText: "수정",
            cancelButtonText: "취소"
        }).then((result) => {
            if (result.isConfirmed) {
            	$.ajax({
                	url:"/manager/updateAjax",
                	processData: false,
					contentType: false,
					data: formData,
					type: "post",
					dataType: "text",
					beforeSend: function (xhr) {
						xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
					},
        			success:function(result){
        				let str = "";
        				console.log(result)
						if(result > 0){
							Swal.fire({
			                    title: "수정되었습니다!",
			                    icon: "info"
			                });
// 							location.reload(true);
							
						}
        				
        				let data = {
        					stNo
        				}
        				$.ajax({
        					url:"/manager/reDetail",
        					contentType:"application/json;charset='utf-8'",
        					data:JSON.stringify(data),
        					type:"post",
        					dataType:"json",
        					beforeSend: function (xhr) {
        						xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        					},
        					success:function(studentDetail){
        						let str = "";
        						
        						str += `
        							<div class="col-3 text-center">
	    								<img src="\${studentDetail.stuAttachFileVO.stuFilePath}"
	    									alt="user-avatar" class="img-square img-fluid user-avatar">
	    								<div class="form-group text-center">
	    								    <div class="custom-file text-left">
	    								        <input type="hidden" name="stuAttaFile" class="custom-file-input" id="uploadFile">
	    								        <label class="custom-file-label" for="uploadFile" style="display:none;">Choose file</label>
	    								    </div>
	    								 </div>
	    							</div>
	    							<input id="deptNo" type="hidden" value="\${studentDetail.comDetCodeVO.comDetCode}">
	    							<div class="card-body table-responsive p-0" style="border: 1px solid #e3e6f0;">
										<table class="table table-hover text-nowrap" style="margin-bottom:0px;">
	    									<thead>
	    										<tr class="trBackground">
	    											<th>소속대학</th>
	    											<td  id="stUniv">대덕인재대학교</td>
	    											<th>단과대학</th>
	    											<td  id="comCodeName">\${studentDetail.comCodeVO.comCodeName}</td>
	    											<th>학과</th>
	    											<td  id="deptName">\${studentDetail.comDetCodeVO.comDetCodeName}</td>
	    										</tr>
	    										<tr class="trBackground">
	    											<th>학번</th>
	    											<td  id="stNo">\${studentDetail.stNo}</td>
	    											<th>이름</th>
	    											<td>\${studentDetail.userInfoVO.userName}</td>
	    											<th>성별</th>
	    											<td >\${studentDetail.stGender}</td>
	    										</tr>
	    										<tr class="trBackground" id="proChaNo">
	    											<th>생년월일</th>
	    											<td >\${studentDetail.userInfoVO.userBirth}</td>
	    											<th>군필 여부</th>
	    											<td>\${studentDetail.militaryService}</td>
	    										</tr>
	    										<tr class="trBackground">
	    											<th>이메일</th>
	    											<td>\${studentDetail.stEmail}</td>
	    											<th>학년</th>
	    											<td>\${studentDetail.stGrade}학년</td>
	    											<th>학적상태</th>
	    											<td class="formdata-stStat">\${studentDetail.studentStatVO.stStat}</td>
	    										</tr>
	    										<tr class="trBackground">
	    											<th>연락처</th>
	    											<td>\${studentDetail.userInfoVO.userTel}</td>
	    											<th>입학일</th>
	    											<td>\${studentDetail.admissionDate}</td>
	    											<th>졸업일</th>
	    											<td  colspan='4'> <c:if test="\${studentDetail.stGradDate == null}"> - </c:if>\${studentDetail.stGradDate}</td>
	    										</tr>
	    										<tr class="trBackground">
	    											<th>은행명</th>
	    											<td>\${studentDetail.stBank}</td>
	    											<th>계좌번호</th>
	    											<td colspan="3">\${studentDetail.stAcount}</td>
	    										</tr>
	    										<tr class="trBackground">
	    											<th>우편번호</th>
	    											<td  colspan="5">\${studentDetail.stPostno}</td>
	    										</tr>
	    										<tr class="trBackground">
	    											<th>주소</th>
	    											<td  colspan="3">\${studentDetail.stAddr}</td>
	    											<th>상세 주소</th>
	    											<td>\${studentDetail.stAddrDet}</td>
	    										</tr>
	    									</thead>
	    								</table>
	    							</div>
        							`;
	        					$('#userInfoShow').html(str);
	        					$('#p1').css('display','block');
	        					$('#p2').css('display','none');
        					}
        				})
        			}                	
                });
            }
        });
	})
	
	$(document).on("change", "#uploadFile", function() {
	    console.log("fileck");

	    let fileInput = $("#uploadFile")[0];
	    let fileNames = [];
	    let reader = new FileReader();

	    // Assuming you want to display the first file selected
	    if (fileInput.files.length > 0) {
	        let file = fileInput.files[0];
	        fileNames.push(file.name);

	        reader.onload = function(e) {
	            // Setting the src attribute of the img element with the file data URL
	            $(".user-avatar").attr("src", e.target.result);
	        }

	        reader.readAsDataURL(file);
	    }

	    let label = $(this).next(".custom-file-label");
	    if (label.length) {
	        label.text(fileNames.join(", "));
	    } else {
	        console.error('custom-file-label 요소를 찾을 수 없습니다.');
	    }
	});
})

// 카카오 주소 api
function sample6_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('stPostno').value = data.zonecode;
            document.getElementById("stAddr").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("stAddrDet").focus();
        }
    }).open();
}

function proChaAdd(){
	let data = {'stNo':stNo}
	console.log(data)

	$.ajax({
		url:"/manager/getProf",
		contentType:"application/json;charset='utf-8'",
		data:JSON.stringify(data),
		type:"POST",
		dataType:"json",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success:function(result){
			console.log(result)
			
			proCha = `
					<th>담당 교수</th>
					<td>\${result.userInfoVO.userName}</td>
					<input type="hidden" id="proNo">\${result.userInfoVO.userNo}
				`;
			$('#proChaNo').append(proCha);
		}
	})
}
</script>
<h3>학생 상세 정보 조회</h3>
<div class="container-fluid col-11">
	<div class="card card-solid">
		<div class="card-body pb-0  col-12">
				<div class="col-12 col-6 d-flex align-items-stretch flex-column">
					<div class="card-body pt-6">
						<div id="userInfoShow">
							<div class="col-3 text-center">
								<img src="${studentDetail.stuAttachFileVO.stuFilePath}"
									alt="user-avatar" class="img-square img-fluid user-avatar">
								<div class="form-group text-center">
								    <div class="custom-file text-left">
								        <input type="hidden" name="stuAttaFile" class="custom-file-input" id="uploadFile">
								        <label class="custom-file-label" for="uploadFile" style="display:none;">Choose file</label>
								    </div>
								 </div>
							</div>
							<input id="deptNo" type="hidden" value="${studentDetail.comDetCodeVO.comDetCode}">
							<div class="card-body table-responsive p-0" style="border: 1px solid #e3e6f0;">
								<table class="table table-hover text-nowrap" style="margin-bottom:0px;">
									<thead>
										<tr class="trBackground">
											<th>소속대학</th>
											<td  id="stUniv">대덕인재대학교</td>
											<th>단과대학</th>
											<td  id="comCodeName">${studentDetail.comCodeVO.comCodeName}</td>
											<th>학과</th>
											<td  id="deptName">${studentDetail.comDetCodeVO.comDetCodeName}</td>
										</tr>
										<tr class="trBackground">
											<th>학번</th>
											<td  id="stNo">${studentDetail.stNo}</td>
											<th>이름</th>
											<td>${studentDetail.userInfoVO.userName}</td>
											<th>성별</th>
											<td >${studentDetail.stGender}</td>
										</tr>
										<tr class="trBackground" id="proChaNo">
											<th>생년월일</th>
											<td >${studentDetail.userInfoVO.userBirth}</td>
											<th>군필 여부</th>
											<td>${studentDetail.militaryService}</td>
										</tr>
										<tr class="trBackground">
											<th>이메일</th>
											<td>${studentDetail.stEmail}</td>
											<th>학년</th>
											<td>${studentDetail.stGrade}학년</td>
											<th>학적상태</th>
											<td class="formdata-stStat">${studentDetail.studentStatVO.stStat}</td>
										</tr>
										<tr class="trBackground">
											<th>연락처</th>
											<td>${studentDetail.userInfoVO.userTel}</td>
											<th>입학일</th>
											<td>${studentDetail.admissionDate}</td>
											<th>졸업일</th>
											<td colspan='4'> <c:if test="${studentDetail.stGradDate == null}"> - </c:if>${studentDetail.stGradDate}</td>
										</tr>
										<tr class="trBackground">
											<th>은행명</th>
											<td>${studentDetail.stBank}</td>
											<th>계좌번호</th>
											<td colspan="3">${studentDetail.stAcount}</td>
										</tr>
										<tr class="trBackground">
											<th>우편번호</th>
											<td  colspan="5">${studentDetail.stPostno}</td>
										</tr>
										<tr class="trBackground">
											<th>주소</th>
											<td  colspan="3">${studentDetail.stAddr}</td>
											<th>상세 주소</th>
											<td>${studentDetail.stAddrDet}</td>
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
	<p id="p1">
		<button type="button" class="btn btn-outline-warning" id="modify">수정</button>
		<button type="button" class="btn btn-outline-secondary" id="list" onclick="location.href='/manager/stuList?menuId=stuEmpLis'">목록</button>
	</p>
	<p id="p2" style="display: none;">
		<button type="button" class="btn btn-outline-primary" id="save">저장</button>
		<button type="button" class="btn btn-outline-secondary" id="cancel">취소</button>
	</p>
</div>
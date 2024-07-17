<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-neo.css" rel="stylesheet">
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
#save, #list{
  width: 100px;
  margin-top: 20px;
  margin-left: auto;
  margin-right: auto;
}
#auto {
  width: 100px;
  margin-top: 20px;
  position: absolute;
  right: 115px;
} 
.address {
	display: flex;
    flex-direction: row;
    align-items: baseline;
}
.img-fluid {
  width: 280px;
  height: 343px;
}
.custom-file {
	margin-top: 20px;
	width: 280px;
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
.stuAdd {
  display: flex;
}
</style>
<script>
$(function(){
	// 단과대학 코드를 통한 학과 select 불러오기
	let college = $('select[name="comCode"]');
	let dept;
	
	$('#stCollege').on('change', function(){
		let data = {
			"data":college.val()
		}
		
		$.ajax({
			url:"/manager/getDept",
			contentType:"application/json;charser='utf-8'",
			data:JSON.stringify(data),
			type:'post',
			dataType:"json",
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
			success:function(result){
				console.log(result)
				
				let str = "";
				
				str += `<option class="dept" disabled selected>==== 선택  ====</option>`;
				$.each(result, function(idx, dept){
					str += "<option value="+dept.comDetCode+">"+dept.comDetCodeName+"</option>"
				});
				
				$("#stDept").html(str);

				dept = $('select[id="stDept"]')
			}
		})
	})
	
	$('#stDept').on('change', function(){
		
		let dept2 = {
			'dept':dept.val()
		}
		
		console.log(dept2)
		
		$.ajax({
			url:"/manager/getProfList",
			contentType:"application/json;charser='utf-8'",
			data:JSON.stringify(dept2),
			type:"POST",
			dataType:"json",
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
			success:function(result){
				console.log('result >>> ',result)
				
				let str = '';
				
				str += `<option disabled selected>==== 선택 ====</option>`;
				$.each(result, function(idx, profVO){
					str += `
						<option value="\${profVO.userInfoVO.userNo}">\${profVO.userInfoVO.userName}</option>
					`;
				})
				
				$('#proCha').html(str);
			}
		})
		
		let date = new Date();
		let year = date.getFullYear();
		
		let lastTwoDigits = year.toString().slice(-2);
		let deptTemp = '';
		
		console.log(lastTwoDigits)
		
		let firstPart = parseInt(dept.val().substring(1, 4), 10);  // D001 -> 1
	    let secondPart = parseInt(dept.val().substring(4, 7), 10); // 001 -> 1
	    deptTemp = lastTwoDigits+firstPart+secondPart
		
		let data = {
			'dept':deptTemp
		}
		
		console.log(data)
		
		$.ajax({
			url:"/manager/getStNo",
			contentType:"application/json;charser='utf-8'",
			data:JSON.stringify(data),
			type:"POST",
			dataType:"text",
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
			success:function(result){
				console.log('result >>> ',result)
				
				$('#stNo').val(result);
			}
		})
	})
	
	// 저장 버튼 클릭
	$('#save').on('click', function(){
		
		let formData = new FormData();
		
		let userName = $('#stName');
		let stDept = $('#stDept');
		let stNo = $('#stNo');
		let stGender = $('#stGender');
		let proChaNo = $('#proCha');
		let stTel = $('#stTel');
		let stEmail = $('#stEmail');
		let stPostNo = $('#stPostno');
		let stPost = $('#stAddr');
		let stPostDt = $('#stAddrDet');
		let stBank = $('#stBank');
		let stAcount = $('#stAcount');
		let stBirth = $('#stBirth');

		
		formData.append("stName", userName.val());
		formData.append("deptCode", stDept.val());
		formData.append("stNo", stNo.val());
		formData.append("stGender", stGender.val());
		formData.append("proChaNo", proChaNo.val());
		formData.append("stTel", stTel.val());
		formData.append("stEmail", stEmail.val());
		formData.append("stPostno", stPostNo.val());
		formData.append("stAddr", stPost.val());
		formData.append("stAddrDet", stPostDt.val());
		formData.append("stBank", stBank.val());
		formData.append("stAcount", stAcount.val());
		formData.append("stBirth", stBirth.val());
					
		let inputFile = $("#uploadFile");
        let file = inputFile[0].files;
        console.log("file.length:" + file.length);
        for (let i = 0; i < file.length; i++) {
            formData.append("uploadFile", file[i]);
        }
        
        let values = formData.values();
        
        for (const pair of values) {
            console.log(pair); 
            if(pair === null || pair === ''){
       		 Swal.fire({
					  position: "center",
					  icon: "error",
					  title: "모든 정보를 입력해주세요",
					  showConfirmButton: false,
					  timer: 1500
					});
       		 
       	 	return;
       	 	}
        }
        

		$.ajax({
			url:"/manager/stuAdd",
			processData: false,
            contentType: false,
            data: formData,
            type: "post",
            dataType: "text",
            beforeSend: function (xhr) {
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
            success:function(result){
				if(result > 0){
					
					let str = '';
					
	            	Swal.fire({
	                    position: "center",
	                    icon: "success",
	                    title: "등록완료 되었습니다.",
	                    timer: 1500,
	                    showConfirmButton: false // 확인 버튼을 숨깁니다.
	                }).then(() => {
	                    // Swal.fire의 타이머가 끝난 후 호출됩니다.
	                    location.href = "/manager/stuAdd?menuId=stuEmpLis";
	                });
				}	
            }
			
		})
	})
	
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
            $(".user-avatar").html("");
            reader.onload = function(e) {
//                 console.log(e.target.result);
                $(".user-avatar").attr("src", e.target.result);
            };
            reader.readAsDataURL(f);
        });
    } 
    
    $('#auto').on('click', function(){
    	$('#stName').val("아무개");
		$('#stGender').val("male");
		$('#stGender').val("male");
		$('#militaryService').val('unfulfilled');
		$('#stTel').val('010-2443-4685');
		$('#stEmail').val('amuga11@naver.com');
		$('#stBank').val('대덕은행');
		$('#admissionDate').val('2024-07-16');
		$('#stAcount').val('352-3535-2706-43');
		$('#stBirth').val('1997-03-27');
    })
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
</script>
<div style="display:flex; justify-content: space-between;">
	<h3>신입생 추가</h3>
</div>
<div class="container-fluid col-11">
	<div class="card card-solid">
		<div class="card-body pb-0 col-12">
			<h6 style="position: relative; left: 1000px;">
				<i class="fas fa-check bg-green" 
				   style="
						color: #fff !important;
						background-color: #28a745 !important;
						background-color: #adb5bd;
						border-radius: 50%;
						font-size: 10px;
						height: 20px;
						line-height: 20px;
						text-align: center;
						top: 0;
						width: 20px;
					  	"></i>
				단과대학과 학과 선택 시 학번과 담당교수가 출력됩니다.
			</h6>	
			<div class="row">
				<div class="col-12 col-6 d-flex align-items-stretch flex-column">
					<div class="card-body pt-6" style="padding-top: 8px;">
						<div class="stuAdd">
							<div class="col-3 text-center">
								<img src="../../../resources/images/basic-profilePhoto.jpg"
									alt="user-avatar" class="img-square img-fluid user-avatar">
								<div class="form-group text-center">
								    <div class="custom-file text-left">
								        <input type="file" name="stuAttaFile" class="custom-file-input" id="uploadFile">
								        <label class="custom-file-label" for="uploadFile">Choose file</label>
								    </div>
								 </div>
							</div>
							<input id="deptNo" type="hidden">
							<div class="card-body table-responsive p-0" style="border: 1px solid #e3e6f0; overflow-x: hidden;">
								<table class="table table-hover text-nowrap" style="margin-bottom:0px;">
									<colgroup>
										<col width="14%">
										<col width="24%">
										<col width="15%">
										<col width="20%">
										<col width="15%">
										<col width="">
									</colgroup>
									<thead>
										<tr class="trBackground">
											<th>소속대학</th>
											<td id="stUniv">대덕인재대학교</td>
											<th>단과대학</th>
											<td id="comCodeName">
												<select class="custom-select" name="comCode" id="stCollege"
													style="margin-right: 20px;">
													<option disabled selected>==== 선택 ====</option>
													<c:forEach var="comCodeVO" items="${comCodeVOList}" varStatus="stat"> 
														<option value="${comCodeVO.comCode}">${comCodeVO.comCodeName}</option> 
													</c:forEach>
												</select>
											</td>
											<th>학과</th>
											<td>
												<select class="custom-select" name="comdDetCode" id="stDept"
													style="margin-right: 20px;">
													<option disabled selected>==== 선택 ====</option>
												</select>
											</td>
										</tr>
										<tr class="trBackground">
											<th>학번</th>
											<td>
												<input id="stNo" type="text" class="form-control" disabled>
											</td>
											<th>이름</th>
											<td class="stName">
												<input id="stName" type="text" class="form-control" 
												value="">
											</td>
											<th>성별</th>
											<td>
												<select id="stGender" name="stGender" class="custom-select">
													<option disabled selected>-</option>
													<option value="male">남성</option>
													<option value="female">여성</option>
												</select>
											</td>
										</tr>
										<tr class="trBackground" id="proChaNo">
											<th>생년월일</th>
											<td class="stBirth">
												<input id="stBirth" type="date" class="form-control">
											</td>
											<th>군필 여부</th>
											<td class="militaryService">
												<select class="custom-select form-control" id="militaryService" name="militaryService" 
													style="margin-right: 20px;">
													<option disabled selected>==== 선택  ====</option>
													<option value="unfulfilled">미필</option>
													<option value="fulfilled">군필</option>
												</select>
											</td>
											<th>담당 교수</th>
											<td>
												<select class="custom-select" name="proCha" id="proCha"
													style="margin-right: 20px;">
													<option disabled selected>==== 선택 ====</option>
												</select>
											</td>								
										</tr>
										<tr class="trBackground">
											<th>이메일</th>
											<td class="stEmail">
												<input id="stEmail" type="text" class="form-control">
											</td>
											<th>연락처</th>
											<td class="stTel">
												<input id="stTel" type="text" class="form-control">
											</td>
											<th>입학일</th>
											<td class="admissionDate">
												<input id="admissionDate" type="date" class="form-control">
											</td>
			
										</tr>
										<tr class="trBackground">
											<th>은행명</th>
											<td class="stBank">
												<input id="stBank" type="text" class="form-control" placeholder="ex)대덕은행">
											</td>
											<th>계좌번호</th>
											<td class="stBank" colspan="3">
												<input id="stAcount" type="text" class="form-control">
											</td>
										</tr>
										<tr class="trBackground">
											<th>우편번호</th>
											<td class="stPostno" colspan="7" style="display:flex">
												<input id="stPostno" type="text" class="form-control" style="width:172px;" disabled>
												<input type="button" class="btn btn-block btn-outline-success" style="margin-left:15px;" value="우편번호 찾기" 
													id="postNoSearch" onclick="sample6_execDaumPostcode()" >
											</td>
										</tr>
										<tr class="trBackground">
											<th>주소</th>
											<td class="stAddr" colspan="3">
												<input id="stAddr" type="text" class="form-control" disabled>
											</td>
											<th>상세 주소</th>
											<td class="stAddrDet" colspan="3">
												<input id="stAddrDet" type="text" class="form-control"">
											</td>
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
</div>
<div class="text-center">
	<button type="button" class="btn btn-outline-primary" id="save">저장</button>
	<button type="button" class="btn btn-outline-secondary" id="list" onclick="location.href='/manager/stuList?menuId=stuEmpLis'">목록</button>
	<button type="button" class="btn btn-outline-light" id="auto">자동 완성</button>
</div>
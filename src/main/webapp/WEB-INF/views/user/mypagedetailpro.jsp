<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<link
	href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-neo.css"
	rel="stylesheet">
<link rel="stylesheet" href="/resources/css/sweetalert2.min.css">
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script type="text/javascript" src="/resources/js/sweetalert2.min.js"></script>

<style>

h3 {
   color: black;
    margin-bottom: 30px;
    margin-top: 40px;
} 

* {
	font-family: 'NanumSquareNeo';
}

.form-control {
	display: inline-block;
}

#modify {
	border: 3px solid #FFC107;
	background-color: white;
	width: 100px;
	margin-top: 20px;
	margin-right: 10px;
}

#modifypw {
	border: 3px solid #F4A0A0;
	background-color: white;
	width: 150px;
	margin-top: 20px;
	margin-right: 10px;
}

#list {
	border: 3px solid #6C757D;
	background-color: white;
	width: 100px;
	margin-top: 20px;
	margin-left: 10px;
}

#save {
	border: 3px solid #28A745;
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

input {
	border-style: solid;
}
</style>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	const myForm = document.querySelector("form")

	/**Event Listener는 콜백함수의 첫 인자로 
	 * event 오브젝트를 보내준다. */
	const handleSubmit = function(event) {

		/* Form에 "submit" 이벤트를 감지할때,
		 * 보통 코드의첫줄은 해당 이벤트의 기본동작을
		 * 막는것이다.
		 */
		event.preventDefault();

	}

	myForm.addEventListener("submit", handleSubmit)

	function handleImg(e) {

		//<p id="pImg"></p> 영역에 이미지 미리보기를 해보자
		//이벤트가 발생 된 타겟 안에 들어있는 이미지 파일들을 가져와보자

		// 업로드한 이미지 개별
		let files = e.target.files;
		// 업로드한 이미지 배열
		let fileArr = Array.prototype.slice.call(files);

		fileArr.forEach(function(f) {
			//이미지 파일이 아닌 경우 이미지 미리보기 실패 처리(MIME타입)
			if (!f.type.match("image.*")) {
				alert("이미지 확장자만 가능합니다.");
				//함수 종료
				return;
			}
			//이미지 객체를 읽을 자바스크립트의 reader 객체 생성
			let reader = new FileReader();

			//		$("#proimage").css("display","none");

			//e : reader가 이미지 객체를 읽는 이벤트
			reader.onload = function(e) {

				$("#proimage").attr("src", e.target.result);
			}
			//f : 이미지 파일 객체를 읽은 후 다음 이미지 파일(f)을 위해 초기화 함
			reader.readAsDataURL(f);
		});

	}

	$(function() { // 동적 함수 >> 수정버튼 클릭시 일어나는 이벤트
		// 수정 버튼 클릭
		$('#modify').on('click', function() {

			// 일부 버튼 활성화
			$("input[name='userInfoVO.userTel']").removeAttr('readonly')
			$("input[name='professorVO.proEmail']").removeAttr('readonly')
			$("input[name='proAddr']").removeAttr('readonly')
			$("input[name='proPostno']").removeAttr('readonly')
			$("input[name='proAddrDet']").removeAttr('readonly')
			$("input[name='salary']").removeAttr('readonly')
			$('#searchno').removeAttr('hidden')
			$("input[name='picture']").removeAttr('hidden')

			// 수정,삭제
			$('#p1').css('display', 'none');
			$('#p2').css('display', 'block');

			// 수정 폼 유효성 검사
			// 			function valid() {

			// 			}

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

				document.getElementById("proPostno").value = data.zonecode; // 우편번호
				document.getElementById("proAddr").value = addr; // 주소

				document.getElementById("proAddrDet").focus(); // 상세주소
			}
		}).open();
	}

	$(function() {

		$("input[name='picture']").on("change", handleImg);

	})
</script>
<h3>교수 정보 조회</h3>
<br>
<div class="container-fluid">
	<div class="card card-solid">
		<div class="card-body pb-0"
			style="overflow: auto; width: 1639px; height: 700px;">
			<div class="row">
				<div class="col-12 col-6 d-flex align-items-stretch flex-column">

					<div class="card-body pt-6">
						<div class="row">
							<form action="/main/mypageUpdatePro" method="post"
								enctype="multipart/form-data" id="myform">
								<div class="col-3 text-center" id="imgdiv"
									style="display: inline-block;">
									<!-- 								현재 이미지 정보 (조회)-->
									<img
										<%-- 									src="/com/file/filedownload?fileId=${stuAttachFileVO.stuName}.${stuAttachFileVO.stuAttType}" --%>
<%-- 									src="/upload/prof/${comAttachFileVO.pFileName}" --%>
									src="${professorVO2.comAttachDetVO.phySaveRoute}"
										alt="User Image"
										style="width: 200px; height: 200px; margin-right: 70px; display: inline-block;"
										id="proimage"><br>
									<br>
									<!-- 									파일 선택 -->
									<!-- 								<img id="preview" style="width: 200px; height: 200px; display: inline-block" hidden="true"> -->
									<input type="file" name="picture"
										style="display: inline-block; border-style: none; height: 30px; margin-left: 22px"
										value="업로드" hidden="true" />
								</div>
								<br>
								<br>

								<div class="col-12">
									<p class="text-muted text-sm">
										<label for="stNo">교수번호 :&nbsp;</label> <input
											class="col-1 form-control" id="proNo" type="text"
											value="${professorVO.proNo}" readonly> <label
											for="stName">&nbsp;성명 :&nbsp;</label> <input
											class="col-1 form-control" name="userInfoVO.userName" type="text"
											value="${professorVO.userInfoVO.userName}" readonly> <label
											for="stTel">&nbsp;연락처 :&nbsp;</label> <input
											class="col-2 form-control" id="userInfoVO.userTel" type="text"
											pattern="(010|016|011)-[0-9]{3,4}-[0-9]{4}"
											name="userInfoVO.userTel"
											value="${professorVO.userInfoVO.userTel}" readonly> 
											<label
											for="stTel">&nbsp;직급 :&nbsp;</label> <input
											class="col-1 form-control" id="proPosition" type="text"
											name="proPosition"
											value="${professorVO.proPosition}" readonly>
											<label
											for="custon-select">&nbsp;이메일 :&nbsp;</label> <input
											class="col-2 form-control" type="text" name="proEmail"
											value="${professorVO.proEmail}"
											pattern="[a-z0-9]+@[a-z]+\.[a-z]{2,3}" readonly>
									</p>
									<p class="text-muted text-sm">
										<label for="stPostNo">&nbsp;우편번호 :&nbsp;</label> <input
											class="col-1 form-control" id="proPostno" type="text"
											value="${professorVO.proPostno}" name="proPostno"
											pattern="[0-9]{5}" readonly> <input type="button"
											value="검색"
											style="height: 30px; background-color: #6e707e; border-color: #6e707e; font-size: 14px; color: white; border: none"
											id="searchno" hidden="true"> <label for="stTel">&nbsp;주소
											:&nbsp;</label> <input class="col-5 form-control" id="proAddr"
											type="text" value="${professorVO.proAddr}" name="proAddr"
											readonly>
									</p>
									<p class="text-muted text-sm">
										<label for="stPostDt">&nbsp;상세 주소 :&nbsp;</label> <input
											class="col-5 form-control" id="proAddrDet" type="text"
											value="${professorVO.proAddrDet}" name="proAddrDet" readonly>
									</p>
									<p class="text-muted text-sm">
										<label for="stUniv">&nbsp;소속 대학 :&nbsp;</label> <input
											class="col-2 form-control" id="stUniv" type="text"
											value="대덕인재대학교" readonly> <label for="stCollege">&nbsp;단과대학
											:&nbsp;</label> <input class="col-2 form-control formdata"
											id="comCodeVO.comCodeName" type="text"
											value="${professorVO.comCodeVO.comCodeName}" readonly>
										<label for="stDept">&nbsp;학과 :&nbsp;</label> <input
											class="col-2 form-control formdata" id="comDetCodeVO.comDetCodeName" type="text"
											value="${professorVO.comDetCodeVO.comDetCodeName}" readonly>
									</p>
									<p class="text-muted text-sm">


										<%--                               <fmt:formatDate var="addm" value="${studentVO.admissionDate}" pattern="yyyy-mm-dd"/> --%>
										<label for="stGradDate">&nbsp;입사일 :&nbsp;</label> <input
											class="col-2 form-control formdata" id="proAddmDate"
											type="text"
											value="${professorVO.empDate.substring(0,10)}"
											pattern="yyyy-mm-dd" readonly> <label
											for="stGradDate">&nbsp;퇴직일 :&nbsp;</label> <input
											class="col-2 form-control formdata" id="proAddmDate"
											type="text"
											value="${professorVO.proRetireDate.substring(0,10)}"
											pattern="yyyy-mm-dd" readonly>

										<%--                               <fmt:formatDate var="grad" value="${studentVO.stGradDate}" pattern="yyyy-mm-dd" /> --%>

									<fmt:formatNumber value="${professorVO.salary}" pattern="#,###" />
										<label for="stBank">&nbsp;연봉 :&nbsp;</label> <input
											class="col-2 form-control" id="prosalary" type="text"
											name="salary" value="${professorVO.salary}" readonly>
									</p>
								</div>

								<div class="text-center">
									<p id="p1">
										<!-- 										<button type="button" class="btn" id="modify" onsubmit="valid()">수정</button> -->
										<button type="button" class="btn" id="modify"> 수정</button>
										<button type="button" class="btn" id="modifypw" onclick="location.href='/main/passwordChange' ">비밀번호 변경</button>
									</p>
									<p id="p2" style="display: none;">
										<!-- 유효성 검사 필요 -->
										<button type="submit" class="btn" id="save">저장</button>
										<button type="button" class="btn" id="cancel"
											onClick="location.href='/main/mypageDetailPro'">취소</button>
									</p>
								</div>
								<sec:csrfInput />
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>


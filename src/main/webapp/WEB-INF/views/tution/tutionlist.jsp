<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<% 
    // DecimalFormat 객체 생성
    DecimalFormat df = new DecimalFormat("#,###");
%>
<!DOCTYPE html>
<html>
<head>
<link
	href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-neo.css"
	rel="stylesheet">
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script type="text/javascript" src="/resources/js/printThis.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">

* {
	font-family: 'NanumSquareNeo';
}

h3 {
	color: black;
    margin-bottom: 30px;
    margin-top: 40px;
    margin-left: 170px;
} 

thead {

background-color: #ebf1e9;
color: black;

}

td {

text-align: center;
}

tr {

cursor:pointer

}
</style>
</head>

<body>
<h3>등록금 납부 내역</h3>
<div class="container-fluid col-10">
	<h5 style="margin-left: 1220px;">[총 ${result}건]</h5>
	<div class="col-12">
		<div class="card">
			<div class="card-body table-responsive p-0" style="height: 100%;">
				<table class="table table-head-fixed text-nowrap"
					style="border: 3px; color:black">
					<thead>
						<tr>
							<th style="text-align: center">번호</th>
							<th style="text-align: center">대상년도</th>
							<th style="text-align: center">학기</th>
							<th style="text-align: center">차수</th>
							<th style="text-align: center">등록금(단위 :원)</th>
							<th style="text-align: center">장학금(단위 :원)</th>
							<th style="text-align: center">실납부액(단위 :원)</th>
							<th style="text-align: center">잔액(단위 :원)</th>
							<th style="text-align: center">납부일자</th>
							<th style="text-align: center">납부여부</th>

						</tr>
					</thead>
					<tbody>
						<c:forEach var="tutionListVO" items="${TuitionList}" varStatus="status">						<!-- index,year,semester,seq -->
							<tr name="mytr" data-toggle="modal" data-target="#modal-lg" id="myModal" onclick="ModalEvent('${status.index}','${tutionListVO.tuitionPayVO.year}','${tutionListVO.tuitionPayVO.semester}','${tutionListVO.tuitionDivPayVO.divPaySq}')">
								<td>${status.index+1}</td>
								<td name="resyear" id="resyear${status.index}">${tutionListVO.tuitionPayVO.year}년도</td>
								<td name="semester" id="ressemester${status.index}">${tutionListVO.tuitionPayVO.semester}학기</td>
		<!-- 						차수 -->
								<c:if test="${tutionListVO.tuitionDivPayVO.divPaySq eq 0}">
									<td name="ressq" id="ressq${status.index}">전체</td>
								</c:if>
								<c:if test="${tutionListVO.tuitionDivPayVO.divPaySq ne 0}">
									<td name="ressq" id="ressq${status.index}">분할 ${tutionListVO.tuitionDivPayVO.divPaySq}차</td>
								</c:if>
		<!-- 						등록금 -->
								<td name="rescost" style="text-align: right;" id="rescost${status.index}">
									<fmt:formatNumber value="${tutionListVO.tuitionVO.tuiCost}" pattern="#,###" />원 
								</td>
		<!-- 						장학금 -->
								<td name="resscol" style="text-align: right;" id="resscol${status.index}">
									<fmt:formatNumber value="${tutionListVO.tuitionDivPayVO.scolAmount}" pattern="#,###" />원  
								</td>
		<!-- 						실납부액 -->
								<td name="resreal" style="text-align: right;" id="resreal${status.index}">
									<fmt:formatNumber value="${tutionListVO.tuitionDivPayVO.divPayAmount}" pattern="#,###" />원 
								</td>
			
		<!-- 						잔액 -->
								<td name="resch" style="text-align: right;">
									<fmt:formatNumber value="${tutionListVO.tuitionDivPayVO.divChanges}" pattern="#,###" />원 </td>
								
								<td>${tutionListVO.tuitionDivPayVO.divPayDate}</td>
		  
								<!-- 납부여부 -->
								<c:if test="${tutionListVO.tuitionDivPayVO.divPaySq eq 0
									&& tutionListVO.tuitionPayVO.tuiPayInstallYn != null}">
									<td class="textCenter" name="resyn" id="resyn${status.index}" style="color: blue; text-align: center;">완납</td>
								</c:if>
								<c:if test="${tutionListVO.tuitionDivPayVO.divPaySq eq 0
									&& tutionListVO.tuitionPayVO.tuiPayInstallYn == null}">
									<td class="textCenter" name="resyn" id="resyn${status.index}" style="color: red; text-align: center">미납</td>
								</c:if>
								<c:if test="${tutionListVO.tuitionDivPayVO.divPaySq eq 1}">
									<td class="textCenter" name="resyn" id="resyn${status.index}" style="color: red; text-align: center">1차 부분납부</td>
								</c:if>
								<c:if test="${tutionListVO.tuitionDivPayVO.divPaySq eq 2}">
									<td class="textCenter" name="resyn" id="resyn${status.index}" style="color: red; text-align: center">2차 부분납부</td>
								</c:if>
								<c:if test="${tutionListVO.tuitionDivPayVO.divPaySq eq 3}">
									<td class="textCenter" name="resyn" id="resyn${status.index}" style="color: red; text-align: center">3차 부분납부</td>
								</c:if>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>
	<br>
	<div class="modal fade" id="modal-lg">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
									<button type="button" class="close" data-dismiss="modal" aria-label="Close" style="margin-left: 760px; margin-top: 6px">
							<span aria-hidden="true">&times;</span>
						</button>
				<div id="myPdf">
					<div class="modal-header">
						<h4 class="modal-title" align="center" style="color: black">등록금 납부 확인서</h4>

					</div>
					<div class="modal-body">
						<table border="1" style="width: 100%; text-align: center">
							<thead>
								<tr>
									<th colspan='2' id="myyear">${listdetail.tuitionPayVO.year}년&nbsp;${listdetail.tuitionPayVO.semester}학기 등록금</th>
									<th>구분</th>
									<th>등록금</th>
									<th>장학금액</th>
									<th>납입금액</th>
									<th>잔액</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>대학</td>
									<td>대덕인재대학교</td>
									<td rowspan="4" id="mysq">${listdetail.tuitionDivPayVO.divPaySq}</td>
									<td rowspan="4" id="mytuipay">${listdetail.tuitionPayVO.tuiPayAmount}원</td>
									<td rowspan="4" id="myscol">${listdetail.tuitionDivPayVO.scolAmount}원</td>
									<td rowspan="4" id="mydivpay">${listdetail.tuitionDivPayVO.divPayAmount}원</td>
									<td rowspan="4" id="mych">${listdetail.tuitionDivPayVO.divPayAmount}원</td>
								</tr>
								<tr>
									<td>학과(전공)</td>
									<td>${stuinfo.comDetCodeVO.comDetCodeName}</td>

								</tr>
								<tr>
									<td>학번</td>
									<td>${stuinfo.stNo}</td>

								</tr>
								<tr>
									<td>성명</td>
									<td>${stuinfo.userInfoVO.userName}</td>

								</tr>
								<tr>
									<td>납부일자</td>
									<td colspan='6' id="mydate">${listdetail.tuitionDivPayVO.divPayDate}</td>
								</tr>
							</tbody>
						</table><br>
							<div style="display: inline-block"><h5 style="text-align: center; color: black; display: inline-block;
							margin-left: 292px; margin-top: -51px;">대덕인재대학교 총장</h5>
							</div>
							<div>
								<img id="profileMyImg" src="/upload/admin/대덕인재대직인.jpg" alt="프로필사진" style="display: inline-block; margin-left: 492px; margin-top: -43px">
							</div>
					</div>
				</div>
				<div class="modal-footer justify-content-between">
					<button id="myPdf2" type="button" class="btn btn-info" style="background-color: white; border-color: #A6A6A6; color: #A6A6A6; text-align: center; margin-left: 690px"
						data-toggle="modal" data-target="#modal-info">출력 <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-printer" viewBox="0 0 16 16">
						  <path d="M2.5 8a.5.5 0 1 0 0-1 .5.5 0 0 0 0 1"/>
						  <path d="M5 1a2 2 0 0 0-2 2v2H2a2 2 0 0 0-2 2v3a2 2 0 0 0 2 2h1v1a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2v-1h1a2 2 0 0 0 2-2V7a2 2 0 0 0-2-2h-1V3a2 2 0 0 0-2-2zM4 3a1 1 0 0 1 1-1h6a1 1 0 0 1 1 1v2H4zm1 5a2 2 0 0 0-2 2v1H2a1 1 0 0 1-1-1V7a1 1 0 0 1 1-1h12a1 1 0 0 1 1 1v3a1 1 0 0 1-1 1h-1v-1a2 2 0 0 0-2-2zm7 2v3a1 1 0 0 1-1 1H5a1 1 0 0 1-1-1v-3a1 1 0 0 1 1-1h6a1 1 0 0 1 1 1"/>
						</svg>
					</button>
				</div>
			</div>
		</div>
	</div>
	
	



<script type="text/javascript">

function ModalEvent(index,year,semester,seq){
	
	console.log("해당 index : " + index)
	console.log("modal 에 왔다")
	// 1. ajax로 데이터 가져오기(파라미터)
	
	
	console.log("semester : " , semester);
	console.log("year : " , year);
	console.log("seq : " , seq);
	
	let data = {
		"semester" : semester,
		"year" : year,
		"seq" : seq
	}

	
	console.log("data : " , data);
	
		// ajax 결과를 납부 확인서에 대입
	$.ajax({
		url:"/tution/tutiondetail",
		contentType:"application/json;charset=utf-8",
		type:"post",
		data:JSON.stringify(data),
		dataType:"json",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success:function(result){
			console.log("상세 result" , result)
			$("#myyear").html(result.tuitionPayVO.year+"년도 &nbsp;&nbsp;"+result.tuitionPayVO.semester+"학기");
			// 구분
			if(result.tuitionDivPayVO.divPaySq == 0){
			$("#mysq").html("완납");
			} else if(result.tuitionDivPayVO.divPaySq == 1){
				$("#mysq").html("분할납부 1차");
			} else if(result.tuitionDivPayVO.divPaySq == 2){
				$("#mysq").html("분할납부 2차");
			} else {
				$("#mysq").html("분할납부 3차");
			}
			$("#mytuipay").html(result.tuitionPayVO.tuiPayAmount.toLocaleString('ko-KR')+"원");
			$("#myscol").html(result.tuitionDivPayVO.scolAmount.toLocaleString('ko-KR')+"원");
			$("#mydivpay").html(result.tuitionDivPayVO.divPayAmount.toLocaleString('ko-KR')+"원");
			$("#mych").html(result.tuitionDivPayVO.divChanges.toLocaleString('ko-KR')+"원");
			$("#mydate").html(result.tuitionDivPayVO.divPayDateStr);
		}
	});
	
	
	
	// 2.pdf 실제 저장
	$("#myPdf2").on("click",function(){

		
		$("#myPdf").printThis({
	
			debug:false,
			importCSS:true,
			printContainer:true,
		// 	loadCSS:"path/to/my.css",
			pageTitle:"",
			removeInLine:true

			})

	$("#myPdf").printThis();
		


})

}






</script>

</body>
</html>
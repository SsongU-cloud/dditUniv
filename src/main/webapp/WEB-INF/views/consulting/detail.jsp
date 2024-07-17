<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>  

<!-- <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet"> -->
<!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script> -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.js"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css"/>

<style>

.card {
   width: 80%;  /*목록 넓이*/
}

h3 {
   	color: black;
    margin-bottom: 30px;
    margin-top: 40px;
    margin-left: 165px;
} 

.card-header {
    background-color: white;
}

.btn-block+.btn-block {
    margin-top: 0;
}

.btnbtn {
    text-align: center;
    padding-top: 12px;
}

.btncli {
    width: 105px;
    margin: auto;
    display: inline-block;
}

.barrier{
	margin: 40px 40px 0px 40px;
}

.regreg{
	padding: 0px 0px;
}

.pickers{
	width: 200px;
	display: inline-block;
}

.selectSearch{
    width: 130px;
    height: 40px;
    margin: 0px 5px 0px 0px;
    font-size: 1rem;
}

.consultbody {
	border-bottom: 2px solid #EBF1E9; 
    border-top: 2px solid #EBF1E9; 
    border-right: 2px solid #EBF1E9;
}

#green {
	background-color: #EBF1E9;
 	text-align: center;
	vertical-align : bottom;
}

#settings{
	padding: 20px 20px 20px 20px;
}

#content{
	resize: none;
}

.expBox {
    background-color: white;
    border: 1px solid #ced4da;
    width: 79%;
    margin-left: 170px;
    margin-bottom: 30px;
    padding: 40px 40px 30px 40px;
    color: black;
}

i{
	font-size: small;
}

.concondition{
	margin-left: 13px;
	margin-top: 5px;
}


</style>


<body class="sidebar-mini sidebar-closed sidebar-collapse"
	style="height: auto;">

	<h3>상담내역 상세페이지</h3>
	<br>

	<div class="expBox">
		<strong>
			<p>
				※신청한 상담의 상세내역과 상담현황을 조회 할 수 있습니다.
			</p>
			<br>
			<p>
				[상담현황]
			</p>
			<p>상담신청 완료 직후 '대기' 로 표기되며 담당 교수님께서 '승인' 또는 '반려' 를 선택하여 상담이 진행 또는 취소 됩니다.</p>
			<i>*무조건적으로 '승인' 되는 것이 아닌 담당 교수님의 스케줄에 따라 '반려' 될 수 있음을 인지하여주시고 양해 바랍니다.</i>
			</p>
		</strong>
	</div>



	<div class="card" style="margin: auto;">
		<div class="tab-pane active" id="settings">
			<form id="frm" name="frm" action="/consulting/request" method="post">
    			<input type="hidden" name="consulReqNo" value="${consultingRequestVO.consulReqNo}">


				<div class="barrier">
					<table class="table table-borderless">
						<tbody class="consultbody">
							<tr class="consultbody">
								<td scope="row" class="col-sm-2" id="green" style="padding-bottom: 20px">담당 교수님</td>
								<td class="col-sm-4">
									<input type="text" class="form-control" id="prof" name="prof" style="background-color: transparent; border: 0px;" readonly="readonly" value="${consultingRequestVO.userInfoVOMap.userName} 교수님">
								</td>
								<td scope="row" class="col-sm-2" id="green" style="padding-bottom: 20px">구분</td>
								<td class="col-sm-4">
									<input type="text" class="form-control" id="consulCateg" name="consulCateg" style="background-color: transparent; border: 0px;" readonly="readonly" value="${consultingRequestVO.consulCateg}">
								</td>
							</tr>
                            <tr class="consultbody">
								<td scope="row" class="col-sm-2" id="green" style="padding-bottom: 20px">상담예약일시</td>
								<td class="col-sm-4">
									<input type="text" class="form-control" name="consulReqDate" style="background-color: transparent; border: 0px;" readonly="readonly" value="${consultingRequestVO.consulReqTime}">
								</td>
								<td scope="row" class="col-sm-2" id="green" style="padding-bottom: 20px">상담현황</td>
<!-- 								<td class="col-sm-4"> -->
<%-- 									<input type="text" class="form-control" name="conCont" style="background-color: transparent; border: 0px;" readonly="readonly" value="${consultingRequestVO.consulReqCondition}"> --%>
									<c:choose>
										<c:when
											test="${consultingRequestVO.consulReqCondition == '1'}">
											<td class="form-control concondition" style="color: green;">대기</td>
										</c:when>
										<c:when
											test="${consultingRequestVO.consulReqCondition == '2'}">
											<td class="form-control concondition" style="color: blue;">승인</td>
										</c:when>
										<c:when
											test="${consultingRequestVO.consulReqCondition == '3'}">
											<td class="form-control concondition" style="color: red;">반려</td>
										</c:when>
									</c:choose>
<!-- 								</td> -->
							</tr>

							<tr class="consultbody">
								<td scope="row" class="col-sm-2" id="green" style="padding-bottom: 20px">제목</td>
								<td class="col-sm-10" colspan="3">
									<input type="text" class="form-control" id="subject" name="consulTitle" style="background-color: transparent; border: 0px;" readonly="readonly" value="${consultingRequestVO.consulTitle}">
								</td>
							</tr>
							
							<tr class="consultbody">
								<td scope="row" class="col-sm-2" id="green" style="padding-bottom: 100px">상담내용</td>
								<td class="col-sm-10" colspan="3">
									<textarea class="form-control" id="content" name="content" style="background-color: transparent; border: 0px; height: 200px; " readonly="readonly">${consultingRequestVO.consulCon}</textarea>
								</td>
							</tr>
						</tbody>
					</table>

					<div class="card-body btnbtn">
<!-- 						<button type="button" class="btn btn-block btn-outline-primary btncli" id="btnregi">저장</button> -->
						<button type="button" class="btn btn-block btn-outline-secondary btncli" id="btnlist">목록</button>
					</div>
					<sec:csrfInput />
				</div>
			</form>
		</div>
	</div>
<br>

</body>

<script>


$(function() {

$('#btnlist').on('click', function() {
	location.href = "/consulting/list?menuId=cybConSul";
});

});

</script>
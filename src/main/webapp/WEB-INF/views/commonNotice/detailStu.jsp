<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet"> -->
<!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script> -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.js"></script>
<html>
<head>
<style type="text/css">
h3 {
	color: black;
	margin-bottom: 30px;
	margin-top: 40px;
	margin-left: 165px;
}

td {
	padding: 0px;
}

.table {
	padding: 0px;
	margin: 0;
}

.btnbtn {
	text-align: center;
}

.btncli {
	width: 105px;
	display: inline-block;
	margin-right: 10px;
}

.btn-block+.btn-block {
	margin-top: 0;
}

.mainbd {
	padding-top: 40px;
	margin: auto;
	width: 80%;
}

.mainbdol {
	border-radius: .25em;
}

.mailbox-read-time {
	margin: 10px 0px 0px 0px;
}

h4 {
	margin-bottom: 20px;
}

.cardFooterDiv {
	border-top: 0px solid #e3e6f0;
	background-color: transparent;
}

.clearfix {
	margin-top: 16px;
}

.attname {
	font-size: 13px;
}

input:focus {
	outline: none;
}
.marginLeft{
	margin-left:10px;
}
</style>
<script type="text/javascript">
	let comNotName = "${commonNoticeVO.comNotName}";
	let comAttFile = "${commonNoticeVO.comAttFile}";
	let comNotCon = `${commonNoticeVO.comNotCon}`;

	$(function() {
		$('#list').on('click', function() {
			location.href = "/commonNotice/listStu?menuId=denAnnIce";
		});

	});
</script>
</head>

<body>
	<div>
		<h3 class="card-title">공지사항</h3>

		<form id="frm" name="frm" action="/commonNotice/detailStu"
			method="post">

			<div class="mainbd">
				<div class="card card-primary card-outline mainbdol">
					<div class="card-header"
						style="background-color: #fff; margin-top: 12px;">
						<input type="hidden" id="comNotNo" value="${commonNoticeVO.comNotNo}">
						<h4 class="marginLeft">[ ${commonNoticeVO.comGubun} ] ${commonNoticeVO.comNotName}</h4>
						<div class="card-body p-0">
							<div class="mailbox-read-time attname" id="formdata">
								<table class="table">
									<tr>
										<td>작성일 &nbsp; ${commonNoticeVO.comFirstDate}
											&nbsp;|&nbsp; 수정일 &nbsp; ${commonNoticeVO.comEndDate}
											&nbsp;|&nbsp; 작성자 &nbsp;
											${commonNoticeVO.userInfoVOList.userName} &nbsp;|&nbsp; 조회수
											&nbsp; ${commonNoticeVO.comNotViews}</td>
									</tr>
								</table>
							</div>
						</div>
					</div>



					<div class="card-header bg-white">
						<div class="mailbox-attachment-info">
							<span class="marginLeft">첨부파일</span>
							<div class="form-group marginLeft">
								<input type="hidden" id="COM_ATT_M_ID" name="comAttMId" value="">
								<c:forEach var="file" items="${fileList}">
									<a href="${file.comAttachDetVOList.phySaveRoute}"
										download="${file.comAttachDetVOList.logiFileName}"> <i
										class="fas fa-paperclip"></i>${file.comAttachDetVOList.logiFileName}</a>
									<br> <!-- 첨부파일 두개 이상일시 아래로 내리기 위해 -->
								</c:forEach>
							</div>
						</div>
					</div>


					<div class="mailbox-read-message"
						style="min-height: 460px; margin: 18px 28px 18px 30px;">
						<p>${commonNoticeVO.comNotCon}</p>
					</div>


				</div>




				<div class="card-footer cardFooterDiv">
					<div class="btnbtn">
						<p id="p1">
							<button type="button"
								class="btn btn-block btn-outline-secondary btncli" id="list">목록</button>
						</p>
					</div>
				</div>


			</div>
			<sec:csrfInput />
		</form>
	</div>
</body>
</html>

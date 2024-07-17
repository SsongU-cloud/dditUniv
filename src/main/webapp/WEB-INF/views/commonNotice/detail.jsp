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
//     alert("확인!!" + location.href);
	let comNotName = "${commonNoticeVO.comNotName}";
	let comAttFile = "${commonNoticeVO.comAttFile}";
	let comNotCon = `${commonNoticeVO.comNotCon}`;
	

	$(function() {
		let stNo = "${stNo}";
		let userNo = "${commonNoticeVO.userNo}";
	    console.log("stNo >> ", stNo);
	    console.log("userNo >> ", userNo);

	        if (stNo !== userNo) {
	            document.getElementById("btnUpdate").style.display = 'none';
	            document.getElementById("delete").style.display = 'none';
	        }
		
		$('#list').on('click', function() {
			location.href = "/commonNotice/list?menuId=annNotIce";
		});

		$("#btnUpdate")
				.on(
						"click",
						function() {
							console.log("ck")
							location.href = "/commonNotice/update?menuId=annNotIce&comNotNo="
									+ "${commonNoticeVO.getComNotNo()}";
						});

		 $("#delete").on("click", function() {
	            let comNotNo = $("#comNotNo").val();
	            console.log(comNotNo);
	            let data = {
	                "comNotNo": comNotNo
	            };

	            Swal.fire({
	                title: '삭제하시겠습니까?',
	                text: "삭제하면 목록으로 이동합니다.",
	                icon: 'warning',
	                showCancelButton: true,
	                confirmButtonColor: '#3085d6',
	                cancelButtonColor: '#d33',
	                confirmButtonText: '삭제',
	                cancelButtonText: '취소'
	            }).then((result) => {
	                if (result.isConfirmed) {
	                    $.ajax({
	                        url : "/commonNotice/deleteAjax",
	                        contentType : "application/json;charset=utf-8",
	                        data : JSON.stringify(data),
	                        type : "post",
	                        dataType : "json",
	                        beforeSend: function(xhr){
	                            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	                        },
	                        success: function(result) {
	                            console.log("삭제 결과:", result);
	                            if (result != null) {
	                                Swal.fire(
	                                    '삭제 완료!',
	                                    '해당 공지가 삭제되었습니다.',
	                                    'success'
	                                ).then(() => {
	                                    location.href = "/commonNotice/list?menuId=annNotIce";
	                                });
	                            } else {
	                                Swal.fire(
	                                    '삭제 취소!',
	                                    '삭제 취소하였습니다.',
	                                    'error'
	                                );
	                            }
	                        },
	                    });
	                }
	            });
	        });

		$('#cancel').on(
				'click',
				function() {
					$("#p1").css("display", "block");
					$("#p2").css("display", "none");

					$('#comNotName').val(comNotName);
					$('#comAttFile').val(comAttFile);
					$('#comNotCon').val(comNotCon);

					console.log("comNotName : " + comNotName
							+ ", comAttFile : " + comAttFile + ", comNotCon : "
							+ comNotCon)
				});

	});
</script>
</head>

<body>
	<div>
		<h3 class="card-title">공지사항</h3>

		<form id="frm" name="frm" action="/commonNotice/updatePost"
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
<%-- 								<p>${file} </p> --%>
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
								class="btn btn-block btn-outline-warning btncli" id="btnUpdate">수정</button>
							<button type="button"
								class="btn btn-block btn-outline-secondary btncli" id="list">목록</button>
							<button type="button"
								class="btn btn-block btn-outline-danger btncli" id="delete">삭제</button>
						</p>
					</div>
				</div>


			</div>
			<sec:csrfInput />
		</form>
	</div>
	<!-- 
	<script type="text/javascript">
		function fBtnUpdate() {
			console.log("ck");
		}
	</script>
	 -->
</body>
</html>

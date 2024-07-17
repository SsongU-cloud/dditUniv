<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>  
<!-- 
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script> -->
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
.mainbdFoot {
	margin: 50px 170px 40px 170px;
    width: 80%;
    background-color: white;
    padding: 30px 30px 30px 30px;
}
.queH4 {
    display: inline-block;
}
.btnregi {
    margin-top: 15px;
    margin-left: 1153px;
    display: none;
}
.dateDay {
	display: inline; 
	margin-left: 1040px; 
	font-size: 13px;
}
.ansContent {
	height: 200px;
	background-color: #e9ecef;
}
</style>
<script type="text/javascript">
let queTitle = "${questionVO.queTitle}";
let queAttFile = "${questionVO.queAttFile}";
let queContent = `${questionVO.queContent}`;

        
$(function() {
	let stNo = "${stNo}";
	let queUserId = "${questionVO.queUserId}";
    console.log("stNo >> ", stNo);
    console.log("queUserId >> ", queUserId);

	if (stNo !== queUserId) {
	    document.getElementById("btnUpdate").style.display = 'none';
	    document.getElementById("delete").style.display = 'none';
	}
	
	let queYn = "${questionVO.queYn}";
	if(queYn == 'Y') {
		document.getElementById("btnUpdate").style.display = 'none';
		document.getElementById("delete").style.display = 'none';
	}
	
	let ansContent = "${answer.answerVOList.ansContent}";
	console.log("ansContent >> ", ansContent)
	if(ansContent == null || ansContent =='') {
		document.getElementById("dateDay").style.display = 'none';
	}
	
	
	$('#list').on('click', function() {
		location.href = "/notice/list?menuId=cybInqUir";
	});

	$("#btnUpdate").on("click", function() {
		location.href = "/notice/update?menuId=cybInqUir&queNo="+ "${questionVO.getQueNo()}";
	});

	$("#delete").on("click", function() {
		let queNo = $("#queNo").val();
		console.log(queNo);
		
		let data = {
		    "queNo": queNo
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
		            url : "/notice/deleteAjax",
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
		                        location.href = "/notice/list?menuId=cybInqUir";
		                    });
		                } else {
		                    Swal.fire(
		                        '삭제 취소!',
		                        '삭제 취소하였습니다.',
		                        'error'
		                    );
		                }
		            }
		        });
		    }
		});
	});

	$('#cancel').on('click',function() {
		$("#p1").css("display", "block");
		$("#p2").css("display", "none");

		$('#queTitle').val(queTitle);
		$('#queAttFile').val(queAttFile);
		$('#queContent').val(queContent);

		console.log("queTitle : " + queTitle + ", queAttFile : " + queAttFile + ", queContent : " + queContent)
	});

});
</script>
</head>
<body>
	<input type="hidden" name="stNo" value="${stNo}">
	<input type="hidden" name="queUserId" value="${questionVO.queUserId}">
	<input type="hidden" id="queNo" value="${questionVO.queNo}">

	<div>
		<h3 class="card-title">문의사항</h3>
		<form id="frm" name="frm" action="/notice/updatePost" method="post">
			<div class="mainbd">
				<div class="card card-primary card-outline mainbdol">
					<div class="card-header"
						style="background-color: #fff; margin-top: 12px;">
						<h4 class="marginLeft">[ ${questionVO.queGubun} ] ${questionVO.queTitle}</h4>
						<div class="card-body p-0">
							<div class="mailbox-read-time attname" id="formdata">
								<table class="table">
									<tr>
										<td>작성일 &nbsp; ${questionVO.queDate} &nbsp;|&nbsp; 수정일
											&nbsp; ${questionVO.queFDate} &nbsp;|&nbsp; 작성자 &nbsp;
											${questionVO.userInfoVOList.userName} &nbsp;|&nbsp; 답변상태 &nbsp;
											<c:choose>
					                            <c:when test="${questionVO.queYn == 'N'}">
					                                <span class="textCenter" style="color: red;">미완료</span>
					                            </c:when>
					                            <c:when test="${questionVO.queYn == 'Y'}">
					                                <span class="textCenter" style="color: blue;">완료</span>
					                            </c:when>
					                        </c:choose> 
										</td>
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
									<br>
									<!-- 첨부파일 두개 이상일시 아래로 내리기 위해 -->
								</c:forEach>
							</div>
						</div>
					</div>

					<div class="mailbox-read-message" style="min-height: 460px; margin: 18px 28px 18px 30px;">
						<p>${questionVO.queContent}</p>
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

		<div class="mainbdFoot card card-primary card-outline">
			<div>
				<h4 class="queH4">답글</h4>
				<div class="dateDay" id="dateDay">작성일 ${answer.answerVOList.ansFDate} </div>
			</div>
			<div>
				<div class="form-control ansContent">${answer.answerVOList.ansContent}</div>
<%-- 				<textarea name="replyCont" id="replyCont" rows="5" class="form-control" disabled>${answer.answerVOList.ansContent}s</textarea> --%>
			</div>
			<div>
				<button type="button" class="btn btn-block btn-outline-primary btncli btnregi" id="btnregi">등록</button>
			</div>
		</div>
	</div>

</body>
</html>

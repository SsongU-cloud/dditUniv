<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>  

<!-- <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet"> -->
<!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script> -->
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
    margin-left: 1140px;
}
.dateDay {
	display: inline; 
	margin-left: 1140px; 
	font-size: 13px;
}
.btncliDecl {
	width: 50px;
	display: inline-block;
	margin-bottom: 10px;
	padding: .125rem .25rem;
}
.commentBor {
	border: 1px solid #ced4da;
}
.tdPadding{
	padding: 10px 0px 10px 26px;
}
.tdPaddingNic{
	padding: 10px 10px 10px 20px;
}
.tdPaddingBut{
	padding: 10px 10px 0px 10px;
}
.tableMarginTop {
	margin-top: 20px;
}
.textAreaMar {
	margin-top: 50px;
}
.tdPaddingClo {
	padding: 10px 10px 10px 10px;
	display: flex;
	justify-content: center;
}
.rkddmlrjfoBut {
	display: inline-block;
	width: 105px;
}
</style>
<script type="text/javascript">

        
$(function() {
	let stNo = "${stNo}";
	let queUserId = "${tecbList.userInfoVOList.userNo}";
    console.log("stNo >> ", stNo);
    console.log("queUserId >> ", queUserId);

	if (stNo != queUserId) {
	    document.getElementById("btnUpdate").style.display = 'none';
	    document.getElementById("delete").style.display = 'none';
	}
	
	let queYn = "${questionVO.queYn}";
	if(queYn == 'Y') {
		document.getElementById("btnUpdate").style.display = 'none';
		document.getElementById("delete").style.display = 'none';
	}
	
	$('#list').on('click', function() {
		location.href = "/timePost/exchaBoard?menuId=injLecDea";
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

});

function lectureTransfer() {
	let today = new Date();   

	let year = today.getFullYear(); // 년도
	let month = today.getMonth() + 1;  // 월
	let date = today.getDate();  // 날짜
	let day = today.getDay();  // 요일

	let todayDate = year + '/' + month + '/' + date;
	console.log("todayDate : ", todayDate);
	
	if((date <= 31) && (month <= 7)) { // 7월 19일까지 수강신청 거래 가능
		location.href="/stuLecture/exchange?menuId=couRegChk";
	}
}
</script>
</head>
<body>
	<input type="hidden" name="stNo" value="${stNo}">
	<input type="hidden" name="queUserId" value="${questionVO.queUserId}">
	<input type="hidden" id="queNo" value="${questionVO.queNo}">

	<div>
		<h3 class="card-title">강의 양도</h3>
		<form id="frm" name="frm" action="/notice/updatePost" method="post">
			<div class="mainbd">
				<div class="card card-primary card-outline mainbdol">
					<div class="card-header" style="background-color: #fff; margin-top: 12px;">
						<h4 class="marginLeft">[ ${tecbList.timeExDiv} ] ${tecbList.timeExName}</h4>
						<div class="card-body p-0">
							<div class="mailbox-read-time attname" id="formdata">
								<table class="table">
									<tr>
										<td>작성일 &nbsp; ${tecbList.timeExDate} &nbsp;|&nbsp; 수정일 &nbsp; 
											${tecbList.timeExUpdDate} &nbsp;|&nbsp; 작성자 &nbsp;
											${tecbList.userInfoVOList.userName} &nbsp;|&nbsp; 강의상태 &nbsp;
											<c:choose>
					                            <c:when test="${tecbList.timeExStat == '대기'}">
					                                <span class="textCenter" style="color: red;">대기</span>
					                            </c:when>
					                            <c:when test="${tecbList.timeExStat == '완료'}">
					                                <span class="textCenter" style="color: blue;">완료</span>
					                            </c:when>
					                        </c:choose> 
											&nbsp;
										</td>
									</tr>
								</table>
							</div>
						</div>
					</div>

					<div class="mailbox-read-message" style="min-height: 460px; margin: 18px 28px 18px 30px;">
						<p>${tecbList.timeExCon}</p>
					</div>
				</div>

				<div class="card-footer cardFooterDiv">
					<div class="btnbtn">
						<p id="p1">
							<button type="button" class="btn btn-block btn-outline-warning btncli" id="btnUpdate">수정</button>
							<button type="button" class="btn btn-block btn-outline-secondary btncli" id="list">목록</button>
							<button type="button" class="btn btn-block btn-outline-danger btncli" id="delete">삭제</button>
							<button type="button" class="btn btn-block btn-outline-success rkddmlrjfoBut" onclick="lectureTransfer()">강의 전송</button>
<!-- 							<button type="button" class="btn btn-block btn-outline-danger btncli" id="decl">신고</button> -->
						</p>
					</div>
				</div>
			</div>
			<sec:csrfInput />
		</form>

		<div class="mainbdFoot card card-primary card-outline">
			<div>
				<h5 class="queH4 far fa-comments">댓글 2</h5>
			</div>
			<table class="commentBor tableMarginTop">
				<tr class="commentBor" style="background-color: #ebf1e9">
					<td class="tdPaddingNic" style="width: 80%;">유진</td>
					<td class="tdPadding">2024-07-15 11:53</td>
					<td class="tdPaddingBut">
						<button type="button" class="btn btn-block btn-outline-danger btn-xs btncliDecl" id="decl">신고</button>
					</td>
<!-- 					<td class="tdPaddingClo"> -->
<!-- 						<button type="button" class="close" data-dismiss="modal" aria-label="Close"> -->
<!-- 			             <span aria-hidden="true">&times;</span> -->
<!-- 			           </button> -->
<!-- 					</td> -->
				</tr>
				<tr class="commentBor">
					<td class="tdPaddingNic" colspan="2">
						<div>강의 받길 희망합니다!!</div>
					</td>
				</tr>
				
				<tr class="commentBor" style="background-color: #ebf1e9">
					<td class="tdPaddingNic" style="width: 80%;">나현</td>
					<td class="tdPadding">2024-07-15 11:53</td>
<!-- 					<td class="tdPaddingBut"> -->
<!-- 						<button type="button" class="btn btn-block btn-outline-danger btn-xs btncliDecl" id="decl">신고</button> -->
<!-- 					</td> -->
					<td class="tdPaddingClo">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
			             <span aria-hidden="true">&times;</span>
			           </button>
					</td>
				</tr>
				<tr class="commentBor">
					<td class="tdPaddingNic" colspan="3">
						<div>희망합니다!</div>
					</td>
				</tr>
			</table>
			<div>
				<textarea name="replyCont" id="replyCont" rows="5" class="form-control textAreaMar">${answer.answerVOList.ansContent}</textarea>
			</div>
			<div>
				<button type="button" class="btn btn-block btn-outline-primary btncli btnregi" id="btnregi">등록</button>
			</div>
		</div>
	</div>

</body>
</html>

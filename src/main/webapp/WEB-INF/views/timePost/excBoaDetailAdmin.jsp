<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>  

<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
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
	width: 75px;
	display: inline-block;
	margin-bottom: 10px;
	padding: .125rem .25rem;
}
.commentBor {
	border: 1px solid #ced4da;
}
.tdPadding{
	padding: 10px 0px 10px 10px;
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
</style>
<script type="text/javascript">
let queTitle = "${questionVO.queTitle}";
let queAttFile = "${questionVO.queAttFile}";
let queContent = `${questionVO.queContent}`;

        
$(function() {
	$('#list').on('click', function() {
		location.href = "/timePost/exchaBoardAdmin?menuId=jaeLecDea";
	});


	$("#delete").on("click", function() {
		let timeExBNo = $("#timeExBNo").val();
		console.log(timeExBNo);
		
		let data = {
		    "timeExBNo": timeExBNo
		};
		
		Swal.fire({
		    title: '블라인드 처리하시겠습니까?',
		    text: "블라인드 후 목록으로 이동합니다.",
		    icon: 'warning',
		    showCancelButton: true,
		    confirmButtonColor: '#007bff',
		    cancelButtonColor: '#d33',
		    confirmButtonText: '확인',
		    cancelButtonText: '취소'
		}).then((result) => {
		    if (result.isConfirmed) {
		        $.ajax({
		            url : "/timePost/deleteAdminAjax",
		            contentType : "application/json;charset=utf-8",
		            data : JSON.stringify(data),
		            type : "post",
		            dataType : "json",
		            beforeSend: function(xhr){
		                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		            },
		            success: function(result) {
		                console.log("블라인드 결과:", result);
		                
		                if (result != null) {
		                    Swal.fire(
		                        '블라인드 완료!',
		                        '해당 게시글이 블라인드되었습니다.',
		                        'success'
		                    ).then(() => {
		                        location.href = "/timePost/exchaBoardAdmin?menuId=jaeLecDea";
		                    });
		                } else {
		                    Swal.fire(
		                        '블라인드 취소!', 
		                        '블라인드가 취소되었습니다.',
		                        'error'
		                    );
		                }
		            }
		        });
		    }
		});
	});

});
</script>
</head>
<body>
	<input type="hidden" name="stNo" value="${stNo}">
	<input type="hidden" name="queUserId" value="${questionVO.queUserId}">
	<input type="hidden" id="timeExBNo" value="${tecbList.timeExBNo}">

	<div>
		<h3 class="card-title">강의 거래</h3>
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
							<button type="button" class="btn btn-block btn-outline-secondary btncli" id="list">목록</button>
							<button type="button" class="btn btn-block btn-outline-danger btncli" id="delete">블라인드</button>
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
					<td class="tdPaddingNic" style="width: 70%;">유진</td>
					<td class="tdPadding">2024-07-15 11:53</td>
					<td class="tdPaddingBut">
						<button type="button" class="btn btn-block btn-outline-danger btn-xs btncliDecl" id="decl">블라인드</button>
					</td>
				</tr>
				<tr class="commentBor">
					<td class="tdPaddingNic" colspan="3">
						<div>강의 받길 희망합니다!!</div>
					</td>
				</tr>
				
				<tr class="commentBor" style="background-color: #ebf1e9">
					<td class="tdPaddingNic" style="width: 80%;">나현</td>
					<td class="tdPadding">2024-07-15 11:53</td>
					<td class="tdPaddingBut">
						<button type="button" class="btn btn-block btn-outline-danger btn-xs btncliDecl" id="decl">블라인드</button>
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

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<!-- <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"rel="stylesheet">
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

.marginLeft {
	margin-left: 10px;
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

.tdPadding {
	padding: 10px 0px 10px 26px;
}

.tdPaddingNic {
	padding: 10px 10px 10px 20px;
}

.tdPaddingBut {
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
   
   $('#list').on('click', function() {
      location.href = "/timePost/freeBoard?menuId=injFreArd";
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
		<h3 class="card-title">자유 게시판</h3>
		<form id="frm" name="frm" action="/notice/updatePost" method="post">
			<div class="mainbd">
				<div class="card card-primary card-outline mainbdol">
					<div class="card-header"
						style="background-color: #fff; margin-top: 12px;">
						<h4 class="marginLeft">STS에 렉이 너무 많이 걸려요..도움!</h4>
						<div class="card-body p-0">
							<div class="mailbox-read-time attname" id="formdata">
								<table class="table">
									<tr>
										<td>작성일.&nbsp; 2024-07-14 &nbsp;|&nbsp; 수정일.
											&nbsp; 2024-07-14 &nbsp;|&nbsp; &nbsp; 조회수  &nbsp; 97
						
										</td>
									</tr>
								</table>
							</div>
						</div>
					</div>

					<div class="mailbox-read-message"
						style="min-height: 460px; margin: 18px 28px 18px 30px;">
						<p>이번에 이클립스을 사용하다 요즘은 STS가 좋다고 하여 바꿔서 사용을 해보니 저장을 하면은 5분동안 렉이 걸리고 잔렉이 너무 심해서<br> 
						    개발을 진행을 못할거같아. 혼자 고쳐볼려했는데 아무리 해도 렉이 너무심해서 이렇게 물어봅니다 먼저 체험하신 선배님들 도움! 
						   
						   ㅇ
						</p>
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
							<!--                      <button type="button" class="btn btn-block btn-outline-danger btncli" id="decl">신고</button> -->
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
					<td class="tdPaddingNic" style="width: 80%;">익명1</td>
					<td class="tdPadding">2024-07-14 11:51</td>
					<td class="tdPaddingBut">
						<button type="button"
							class="btn btn-block btn-outline-danger btn-xs btncliDecl"
							id="decl">신고</button>
					</td>
					<!--                <td class="tdPaddingClo"> -->
					<!--                   <button type="button" class="close" data-dismiss="modal" aria-label="Close"> -->
					<!--                       <span aria-hidden="true">&times;</span> -->
					<!--                     </button> -->
					<!--                </td> -->
				</tr>
				<tr class="commentBor">
					<td class="tdPaddingNic" colspan="3">
						<div>일단은 다시 시작을해봐 재시작은 공짜야~ </div>
					</td>
				</tr>

				<tr class="commentBor" style="background-color: #ebf1e9">
					<td class="tdPaddingNic" style="width: 80%;">익명(작성자)</td>
					<td class="tdPadding">2024-07-14 11:53</td>
					<!--                <td class="tdPaddingBut"> -->
					<!--                   <button type="button" class="btn btn-block btn-outline-danger btn-xs btncliDecl" id="decl">신고</button> -->
					<!--                </td> -->
					<td class="tdPaddingClo">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</td>
				</tr>
				<tr class="commentBor">
					<td class="tdPaddingNic" colspan="3">
						<div>한번 재접해도 똑같에..살려줘</div>
					</td>
				</tr>
				
				<tr class="commentBor" style="background-color: #ebf1e9">
					<td class="tdPaddingNic" style="width: 80%;">익명3</td>
					<td class="tdPadding">2024-07-14 11:54</td>
					<!--                <td class="tdPaddingBut"> -->
					<!--                   <button type="button" class="btn btn-block btn-outline-danger btn-xs btncliDecl" id="decl">신고</button> -->
					<!--                </td> -->
					<td class="tdPaddingBut">
						<button type="button"
							class="btn btn-block btn-outline-danger btn-xs btncliDecl"
							id="decl">신고</button>
					</td>
				</tr>
				<tr class="commentBor">
					<td class="tdPaddingNic" colspan="3">
						<div>희망이없다면은 포멧이라는 좋은 버튼이있단다</div>
					</td>
				</tr>
				
				<tr class="commentBor" style="background-color: #ebf1e9">
					<td class="tdPaddingNic" style="width: 80%;">익명4</td>
					<td class="tdPadding">2024-07-14 12:05</td>
					<!--                <td class="tdPaddingBut"> -->
					<!--                   <button type="button" class="btn btn-block btn-outline-danger btn-xs btncliDecl" id="decl">신고</button> -->
					<!--                </td> -->
					<td class="tdPaddingBut">
						<button type="button"
							class="btn btn-block btn-outline-danger btn-xs btncliDecl"
							id="decl">신고</button>
					</td>
				</tr>
				<tr class="commentBor">
					<td class="tdPaddingNic" colspan="3">
						<div>자 눈을 감아보렴 그게 지금 너의 STS야 하하하</div>
					</td>
				</tr>
				
					<tr class="commentBor" style="background-color: #ebf1e9">
					<td class="tdPaddingNic" style="width: 80%;">익명5</td>
					<td class="tdPadding">2024-07-14 12:10</td>
					<!--                <td class="tdPaddingBut"> -->
					<!--                   <button type="button" class="btn btn-block btn-outline-danger btn-xs btncliDecl" id="decl">신고</button> -->
					<!--                </td> -->
					<td class="tdPaddingBut">
						<button type="button"
							class="btn btn-block btn-outline-danger btn-xs btncliDecl"
							id="decl">신고</button>
					</td>
				</tr>
				<tr class="commentBor">
					<td class="tdPaddingNic" colspan="3">
						<div>STS이 설치된 폴더에 SpringToolSuite4.ini 파일에 용량을 늘려봐</div>
					</td>
				</tr>
			</table>
			<div>
			
			
			
			
				<textarea name="replyCont" id="replyCont" rows="5"
					class="form-control textAreaMar">${answer.answerVOList.ansContent}</textarea>
			</div>
			<div>
				<button type="button"
					class="btn btn-block btn-outline-primary btncli btnregi"
					id="btnregi">등록</button>
			</div>
		</div>
	</div>

</body>
</html>

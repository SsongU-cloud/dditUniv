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
.trBackground {
	background-color: #ebf1e9;
}
.commentBor {
	border: 1px solid #ced4da;
}
.card-outline {
  margin:auto;
  width: 1320px;
  padding:20px;
}
.title {
	display: flex;
    align-items: baseline;
}
.table>th, .table>td {
    vertical-align: middle;
    padding: 8px;
}
.editable-container {
    border: 1px solid #ced4da;
    padding: 8px;
    min-height: 400px;
}
.editable-container img {
    max-width: 300px;
    height: auto;
    display: block;
    margin-top: 10px;
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
.btnregi {
    margin-top: 15px;
    margin-left: 1153px;
}
.btncliDecl {
   width: 50px;
   display: inline-block;
   margin-bottom: 10px;
   padding: .125rem .25rem;
}
.cardFooterDiv {
   border-top: 0px solid #e3e6f0;
   background-color: transparent;
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
.mainbdFoot {
	margin: 50px 170px 40px 170px;
	width: 80%;
	background-color: white;
	padding: 30px 30px 30px 30px;
}
.textAreaMar {
	margin-top: 50px;
}

</style>
<script type="text/javascript">
        
$(function() {

});
</script>
</head>
<body>
   <div>
      <h3>분실물 상세 게시판</h3>
      <div class="card card-outline card-info">
		<div class="title">
			<h4 class="col-9">공과대학 앞에서 습득했습니다.</h4> 
			<h4 class="col-9" style="font-size:16px; margin-left:180px;" >작성자&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;이종진</h4> 
		</div>
		<hr>
		<div class="card-body table-responsive p-0">
			<table class="table table-hover text-nowrap">
				<thead>
					<tr>
						<th class="trBackground text-center" style="width:200px; vertical-align: middle; padding: 8px;">습득일</th>
						<td style="width:400px; vertical-align: middle; padding: 8px;">
							2024-07-15
						</td>
						<th class="trBackground text-center" style="width:200px; vertical-align: middle; padding: 8px;">습득장소</th>
						<td style="width:400px; vertical-align: middle; padding: 8px;">
							공과대학 입구
						</td>
					</tr>
				</thead>
				<thead>
					<tr>
						<th class="trBackground text-center" style="width:200px; vertical-align: middle; padding: 8px;">분실물 상태</th>
						<td style="width:400px; vertical-align: middle; padding: 8px;">
							보관중
						</td>
						<th class="trBackground text-center" style="width:200px; vertical-align: middle; padding: 8px;">연락처</th>
						<td style="width:400px; vertical-align: middle; padding: 8px;">
							010-1111-5599
						</td>
					</tr>
				</thead>
				<thead>
					<tr>
						<th class="trBackground text-center" style="width:200px; vertical-align: middle; padding: 8px;">분실물명</th>
						<td style="vertical-align: middle; padding: 8px;" colspan='3'>
							지갑
						</td>
					</tr>
				</thead>
				<thead>
					<tr>
						<th class="trBackground text-center" style="width:200px; vertical-align: middle; padding: 8px;">내용</th>
						<th style=" vertical-align: middle; padding: 8px;" colspan='3'>
							<div class="textarea-container">
		                        <div class="editable-container" contenteditable="false">
                 	                <img src="../../../resources/images/lostWallet.png" alt="lostWallet">
                  					공대 정문에서 주웠습니다 주인분 계시면 카카오톡 ddit404 친구추가 후 연락주세요
		                        </div>
	                    	</div>
						</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
	<br>
<!--          <div class="mainbd"> -->
<!--             <div class="card card-primary card-outline mainbdol"> -->
<!--                <div class="card-header" -->
<!--                   style="background-color: #fff; margin-top: 12px;"> -->
<!--                   <h4 class="marginLeft">공과대학 앞에서 습득했습니다.</h4> -->
<!--                   <div class="card-body p-0"> -->
<!--                      <div class="mailbox-read-time attname" id="formdata"> -->
<!--                         <table class="table"> -->
<!--                            <tr> -->
<!--                               <td>작성일 &nbsp; 2024-07-15 &nbsp;|&nbsp; -->
<!--                               	 수정일 &nbsp; 2024-07-15 &nbsp;|&nbsp;  -->
<!--                               	 작성자 &nbsp; 이종진 &nbsp;|&nbsp;  -->
<!--                               	 구분 &nbsp;&nbsp;지갑 |&nbsp;  -->
<!--                               	 회수 여부 &nbsp;  -->
<%--                                  <c:choose> --%>
<%--                                            <c:when test="${questionVO.queYn == 'N'}"> --%>
<!--                                                <span class="textCenter" style="color: red;">미완료</span> -->
<%--                                            </c:when> --%>
<%--                                            <c:when test="${questionVO.queYn == 'Y'}"> --%>
<!--                                                <span class="textCenter" style="color: red;">보관중</span> -->
<%--                                            </c:when> --%>
<%--                                        </c:choose>  --%>
<!--                                  &nbsp;|&nbsp; 조회수 6 &nbsp; -->
<!--                               </td> -->
<!--                            </tr> -->
<!--                         </table> -->
<!--                      </div> -->
<!--                   </div> -->
<!--                </div> -->

<!--                <div class="mailbox-read-message" style="min-height: 460px; margin: 18px 28px 18px 30px;"> -->
<!--                   <p> -->
<!--                      <img src="../../../resources/images/lostWallet.png" alt="lostWallet"> -->
<!--                   		공대 정문에서 주웠습니다 주인분 계시면 카카오톡 ddit404 친구추가 후 연락주세요 -->
<!--                   </p> -->
<!--                </div> -->
<!--             </div> -->

            <div class="card-footer cardFooterDiv">
               <div class="btnbtn">
                  <p id="p1">
<!--                      <button type="button" class="btn btn-block btn-outline-warning btncli" id="btnUpdate">수정</button> -->
                     <button type="button" class="btn btn-block btn-outline-secondary btncli" id="list"
                     	onclick="location.href='/timePost/lostItem?menuId=injlosIte'">목록</button>
<!--                      <button type="button" class="btn btn-block btn-outline-danger btncli" id="delete">삭제</button> -->
                     <button type="button" class="btn btn-block btn-outline-danger btncli" id="decl">신고</button>
                  </p>
               </div>
            </div>
<!--          </div> -->
         
      <div class="mainbdFoot card card-primary card-outline">
         <div>
            <h5 class="queH4 far fa-comments">댓글 1</h5>
         </div>
         <table class="commentBor tableMarginTop">
            <tr class="commentBor" style="background-color: #ebf1e9">
               <td class="tdPaddingNic" style="width: 80%;">유진</td>
               <td class="tdPadding">2024-07-16 11:53</td>
               <td class="tdPaddingBut">
                  <button type="button" class="btn btn-block btn-outline-danger btn-xs btncliDecl" id="decl">신고</button>
               </td>
            </tr>
            <tr class="commentBor">
               <td class="tdPaddingNic" colspan="3">
                  <div>저거 내껀데!!</div>
               </td>
            </tr>
         </table>
         <div>
            <textarea name="replyCont" id="replyCont" rows="5" class="form-control textAreaMar"></textarea>
         </div>
         <div>
            <button type="button" class="btn btn-block btn-outline-primary col-1 btncli btnregi" id="btnregi">등록</button>
         </div>
      </div>
   </div>

</body>
</html>

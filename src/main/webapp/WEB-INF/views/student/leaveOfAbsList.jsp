<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<!-- <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet"> -->
<!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script> -->
<html>
<head>
<script type="text/javascript">
let locationHref = window.location.href;
$(function () {
	$('#modelBtnUpdate').on('click', function(){
// 		$("#datepickerssDetail1").removeAttr("disabled");
// 		$("#datepickerssDetail2").removeAttr("disabled");
// 		$("#stuLecNoDetail").removeAttr("disabled");
// 		$("#textareaDetail").removeAttr("disabled");
// 		$("#customFileDetail").removeAttr("disabled");
		
// 		document.getElementById('modelBtnUpdate').style.display = 'none';
		
// 		document.getElementById('modelBtnSave').style.display = 'block';
// 		document.getElementById('modelBtnNo').style.display = 'block';
		
		Swal.fire({
            title: '저장하시겠습니까?',
            text: "기존 데이터로 되돌릴 수 없습니다",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: '저장',
            cancelButtonText: '취소'
        }).then((result) => {
        	$("#modalCondition").attr("disabled",true);
        	document.getElementById('modelBtnUpdate').style.display = 'none';
        });
		
	});
	
});

//목록
function getList(keyword, currentPage, queGubun) {
	let queGubunTemp = "";
	if(queGubun != null) {
		queGubunTemp = queGubun;
	}
	
	// JSON 오브젝트
	let data = {
		"keyword":keyword,
		"currentPage":currentPage,
		"queGubun":queGubunTemp //구분 추가
	};
	
	console.log("data : " , data);
	
	//아작나써유..(피)씨다타써...
	$.ajax({
		url: "", //ajax용 url 변경
		contentType:"application/json;charset=utf-8",
		data:JSON.stringify(data),
		type:"post",
		dataType:"json",
		beforeSend:function(xhr){
            xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
        },
		success:function(result){
			console.log("result.content : ", result.content);
			
			let str = "";
			
			if(result.content.length == 0) {
				str += `<tr>`;
				str += `<td colspan="6" style="text-align:center;">검색 결과가 없습니다.</td>`;
				str += `</tr>`;
			}
			
			$.each(result.content, function(idx, CommonNoticeVO){
// 				str += `<tr name="trHref" onclick="location.href='/commonNotice/detail?menuId=annNotIce&comNotNo=\${CommonNoticeVO.comNotNo}'" style="cursor:pointer">
// 				<td class="textCenter">\${CommonNoticeVO.rn}</td>
// 				<td class="textCenter">\${CommonNoticeVO.comGubun}</td>
// 				<td>\${CommonNoticeVO.comNotName}</td>
// 				<td class="textCenter">\${CommonNoticeVO.userInfoVOList.userName}</td>
// 				<td class="textCenter">\${CommonNoticeVO.comFirstDate}</td>
// 				<td class="textCenter">\${CommonNoticeVO.comNotViews}</td>`;
			});
			
			$(".clsPagingArea").html(result.pagingArea);
			
			$("#trShow").html(str);
		}
	});
}	
	
		
</script>
<style type="text/css">
h3 {
	color: black;
    margin-bottom: 30px;
    margin-top: 40px;
    margin-left: 165px;
} 

.wkrtjdBut {
    width: 105px;
    float: right;
}
   
.trBackground {
    background-color: #ebf1e9;
}

#btnSearch {
	border: 1px solid #D1D3E2;
	background-color: #F8F9FA;
}

.selectSearch{
    width: 130px;
    height: 30px;
    float: left;
    margin: 0px 5px 0px 0px;
    font-size: 0.8rem;
}

.clsPagingArea {
	margin-top:  20px;
	justify-content: flex-end;
}

.card {
	width: 80%;  /*목록 넓이*/
}

.textCenter {
    text-align:center;
}

.gugubun{
   width: 130px;
   height: 40px;
   font-size: 1rem; 
   margin-left: -5px;
 } 

.stustu {
   display: inline-block;
}
.cloclose {
   width: 70px;
}
</style>

</head>
<body>
<p style="display:none;"><sec:authentication property="principal"/></p>
<p style="display:none;"><sec:authentication property="principal.userInfoVO"/></p>
<p style="display:none;"><sec:authentication property="principal.userInfoVO.userName"/></p>
<p style="display:none;"><sec:authentication property="principal.username"   var="merong"/></p>
<p style="display:none;"><sec:authentication property="principal.userInfoVO.authorityVOList"  var="myAuths"/></p>
	<h3>휴학 관리</h3>
	<br>
	<div class="card" style="margin: auto;">
		<div class="card-header" style="background-color: #fff;">
			<div class="brd-search">
				<select title="검색 조건 선택" id="searchCnd" class="selectSearch form-control">
					<option value="1">학번</option>
					<option value="2">이름</option>
					<option value="3">연락처</option>
				</select>

				<div class="input-group input-group-sm"
					style="width: 280px; float: left;">
					<input type="text" name="table_search"
						class="form-control float-left" placeholder="검색어를 입력하세요">
					<div class="input-group-append">
						<button type="button" class="btn btn-default" id="btnSearch">
							<i class="fas fa-search"></i>
						</button>
					</div>
				</div>
				<p><input type="hidden" name="authority" value="${myAuths[0].authority}"></p>
<!-- 				<button type="button" name="authorityBtn" class="btn btn-block btn-outline-primary wkrtjdBut" id="newwrite">작성</button> -->
			</div>
		</div>

		<div class="card-body table-responsive p-0">
			<table class="table table-hover text-nowrap">
				<thead>
					<tr class="trBackground textCenter" style="color:black;">
						<th style="width: 5%;">번호</th>
						<th style="width: 10%;">학번</th>
						<th style="width: 10%;">이름</th>
						<th style="width: 15%;">학과</th>
						<th style="width: 15%;">학년</th>
						<th style="width: 15%;">학적상태</th>
						<th style="width: 20%;">연락처</th>
					</tr>
				</thead>
				<tbody id="trShow">
<%-- 					<c:forEach var="CommonNoticeVO" items="${articlePage.content}" varStatus="stat"> --%>
					<tr name="trHref" data-toggle="modal" data-target="#modalDetail" style="cursor:pointer">
						<td class="textCenter">1</td>
						<td class="textCenter">20200428</td>
						<td class="textCenter">김성규</td>
						<td class="textCenter">컴퓨터공학과</td>
						<td class="textCenter">4학년</td>
						<td class="textCenter">재학</td>
						<td class="textCenter">010-9510-7530</td>
					</tr>
					<tr name="trHref" style="cursor:pointer">
						<td class="textCenter">2</td>
						<td class="textCenter">20200313</td>
						<td class="textCenter">김명수</td>
						<td class="textCenter">컴퓨터공학과</td>
						<td class="textCenter">4학년</td>
						<td class="textCenter">재학</td>
						<td class="textCenter">010-1235-9876</td>
					</tr>
					<tr name="trHref" style="cursor:pointer">
						<td class="textCenter">3</td>
						<td class="textCenter">20210208</td>
						<td class="textCenter">남우현</td>
						<td class="textCenter">컴퓨터공학과</td>
						<td class="textCenter">3학년</td>
						<td class="textCenter">휴학</td>
						<td class="textCenter">010-6542-3218</td>
					</tr>
					<tr name="trHref" style="cursor:pointer">
						<td class="textCenter">4</td>
						<td class="textCenter">20210827</td>
						<td class="textCenter">이성열</td>
						<td class="textCenter">컴퓨터공학과</td>
						<td class="textCenter">3학년</td>
						<td class="textCenter">휴학</td>
						<td class="textCenter">010-3572-1594</td>
					</tr>
					<tr name="trHref" style="cursor:pointer">
						<td class="textCenter">5</td>
						<td class="textCenter">20220903</td>
						<td class="textCenter">이성종</td>
						<td class="textCenter">컴퓨터공학과</td>
						<td class="textCenter">2학년</td>
						<td class="textCenter">재학</td>
						<td class="textCenter">010-8520-7613</td>
					</tr>
					<tr name="trHref" style="cursor:pointer">
						<td class="textCenter">6</td>
						<td class="textCenter">20200423</td>
						<td class="textCenter">김성규</td>
						<td class="textCenter">컴퓨터공학과</td>
						<td class="textCenter">4학년</td>
						<td class="textCenter">재학</td>
						<td class="textCenter">010-9510-7730</td>
					</tr>
					<tr name="trHref" style="cursor:pointer">
						<td class="textCenter">7</td>
						<td class="textCenter">20200413</td>
						<td class="textCenter">김명수</td>
						<td class="textCenter">컴퓨터공학과</td>
						<td class="textCenter">4학년</td>
						<td class="textCenter">재학</td>
						<td class="textCenter">010-1235-9076</td>
					</tr>
					<tr name="trHref" style="cursor:pointer">
						<td class="textCenter">8</td>
						<td class="textCenter">20211208</td>
						<td class="textCenter">남우현</td>
						<td class="textCenter">컴퓨터공학과</td>
						<td class="textCenter">3학년</td>
						<td class="textCenter">휴학</td>
						<td class="textCenter">010-6542-3918</td>
					</tr>
					<tr name="trHref" style="cursor:pointer">
						<td class="textCenter">9</td>
						<td class="textCenter">20210927</td>
						<td class="textCenter">이성열</td>
						<td class="textCenter">컴퓨터공학과</td>
						<td class="textCenter">3학년</td>
						<td class="textCenter">휴학</td>
						<td class="textCenter">010-3572-1094</td>
					</tr>
					<tr name="trHref" style="cursor:pointer">
						<td class="textCenter">10</td>
						<td class="textCenter">20220913</td>
						<td class="textCenter">이성종</td>
						<td class="textCenter">컴퓨터공학과</td>
						<td class="textCenter">2학년</td>
						<td class="textCenter">재학</td>
						<td class="textCenter">010-8520-7313</td>
					</tr>
<%-- 					</c:forEach> --%>
				</tbody>
			</table>
		</div>
	</div>

	<div class="row clsPagingArea">
	    <div class='col-sm-12 col-md-7'>
	        <div class='dataTables_paginate paging_simple_numbers' id='example2_paginate'>
	            <ul class='pagination'>
	                <!-- Previous Button -->
	                <li class='paginate_button page-item previous disabled' id='example2_previous'>
	                    <a href='#' onclick="getList('keyword', startPage - 5, queGubun)" aria-controls='example2' data-dt-idx='0' tabindex='0' class='page-link'>&lt;&lt;</a>
	                </li>
	                
	                <!-- Page Numbers -->
	                <li class='paginate_button page-item active'>
	                    <a href='#' onclick="getList('keyword', 1, queGubun)" aria-controls='example2' data-dt-idx='1' tabindex='0' class='page-link'>1</a>
	                </li>
	                <li class='paginate_button page-item'>
	                    <a href='#' onclick="getList('keyword', 2, queGubun)" aria-controls='example2' data-dt-idx='2' tabindex='0' class='page-link'>2</a>
	                </li>
	                <li class='paginate_button page-item'>
	                    <a href='#' onclick="getList('keyword', 3, queGubun)" aria-controls='example2' data-dt-idx='3' tabindex='0' class='page-link'>3</a>
	                </li>
	                <li class='paginate_button page-item'>
	                    <a href='#' onclick="getList('keyword', 4, queGubun)" aria-controls='example2' data-dt-idx='4' tabindex='0' class='page-link'>4</a>
	                </li>
	                <li class='paginate_button page-item'>
	                    <a href='#' onclick="getList('keyword', 5, queGubun)" aria-controls='example2' data-dt-idx='5' tabindex='0' class='page-link'>5</a>
	                </li>
	                <!-- Next Button -->
	                <li class='paginate_button page-item next' id='example2_next'>
	                    <a href='#' onclick="getList('keyword', startPage + 5, queGubun)" aria-controls='example2' data-dt-idx='7' tabindex='0' class='page-link'>&gt;&gt;</a>
	                </li>
	            </ul>
	        </div>
	    </div>
	</div>


	<!-- 모달 -->
	<div class="modal fade" id="modalDetail" tabindex="-1" role="dialog" aria-labelledby="consultingModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content" style="width: 600px;">
				<div class="modal-header">
					<h5 class="modal-title" id="consultingModalLabel">휴학 신청서 상세 내용</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form>
						<div class="form-group stustu">
							<label for="modalstno">학번</label>
							<input type="text" class="form-control" id="stno" style="width: 277px" value="20200428" readonly>
						</div>
						&nbsp;
						<div class="form-group stustu">
							<label for="modalname">이름</label>
							<input type="text" class="form-control" id="name" style="width: 277px" value="김성규" readonly>
						</div>
						<div class="form-group stustu">
							<label for="modalgubun">학적상태</label>
							<input type="text" class="form-control" id="gubun" value="재학" style="width: 277px" readonly>
						</div>
						&nbsp;
						<div class="form-group stustu">
							<label for="modalTime">접수일자</label>
							<input type="text" class="form-control" id="Time" value="2024-05-30" style="width: 277px" readonly>
						</div>
						<div class="form-group stustu">
							<label for="modalgubun">휴학 시작일</label>
							<input type="date" class="form-control pull-right pickers mSpan" id="datepickerssDetail1" name="datepickerssDetail" value="2024-09-01" disabled>
						</div>
						&nbsp;
						<div class="form-group stustu">
							<label for="modalTime">휴학 종료 예정일</label>
							<input type="date" class="form-control pull-right pickers mSpan" id="datepickerssDetail2" name="datepickerssDetail" value="2026-02-07" disabled>
						</div>

						<div class="form-group">
							<label for="modalcontent">휴학 사유</label>
							<textarea rows="5" id="textareaDetail" class="form-control textAreaMar" disabled>자기개발 시간을 갖고 싶습니다.</textarea>
						</div>

						<div class="form-group">
				            <div class="custom-file">
				                <input type="file" name="queAttFile" class="custom-file-input" id="customFile" multiple disabled/>  <!-- input,label 순서 고정 -->
				                <label class="custom-file-label" for="customFile">첨부파일</label>
				            </div>
						</div>

						<label for="modalCondition">승인 여부</label>
						<div class="form-group" style="margin-left: 5px;">
							<select title="구분 선택" id="modalCondition" name="modalCondition" class="selectSearch form-control gugubun">
								<option value="1">대기</option>
								<option value="2">승인</option>
								<option value="3">반려</option>
							</select>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" id="modelBtnUpdate" class="btn btn-block btn-outline-primary cloclose">저장</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
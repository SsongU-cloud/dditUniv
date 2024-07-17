<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!-- 
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script> -->
<html>
<head>
<script type="text/javascript">
let locationHref = window.location.href;
$(function () {
	$('#modelBtnUpdate').on('click', function(){
		$("#datepickerssDetail1").removeAttr("disabled");
		$("#datepickerssDetail2").removeAttr("disabled");
		$("#stuLecNoDetail").removeAttr("disabled");
		$("#textareaDetail").removeAttr("disabled");
		$("#customFileDetail").removeAttr("disabled");
		
		document.getElementById('modelBtnUpdate').style.display = 'none';
		
		document.getElementById('modelBtnSave').style.display = 'block';
		document.getElementById('modelBtnNo').style.display = 'block';
	});
	
	$('#modelBtnSave').on('click', function(){
		$("#datepickerssDetail1").attr("disabled",true);
		$("#datepickerssDetail2").attr("disabled",true);
		$("#stuLecNoDetail").attr("disabled",true);
		$("#textareaDetail").attr("disabled",true);
		$("#customFileDetail").attr("disabled",true);
		
		document.getElementById('modelBtnUpdate').style.display = 'block';
		
		document.getElementById('modelBtnSave').style.display = 'none';
		document.getElementById('modelBtnNo').style.display = 'none';
	});
	
	$('#modelBtnSave').on('click', function(){
		Swal.fire({
            title: '수정하시겠습니까?',
            text: "기존 데이터로 되돌릴 수 없습니다",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: '저장',
            cancelButtonText: '취소'
        }).then((result) => {
			$("#datepickerssDetail1").attr("disabled",true);
			$("#datepickerssDetail2").attr("disabled",true);
			$("#stuLecNoDetail").attr("disabled",true);
			$("#textareaDetail").attr("disabled",true);
			$("#customFileDetail").attr("disabled",true);
			
			document.getElementById('modelBtnUpdate').style.display = 'block';
			
			document.getElementById('modelBtnSave').style.display = 'none';
			document.getElementById('modelBtnNo').style.display = 'none';
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
* {
	font-family: 'NanumSquareNeo'; 
}
h3 {
    margin-top: 40px;
    margin-left: 160px;
} 
.h4Class {
    margin-bottom: 20px;
    margin-top: 20px;
    margin-left: 160px;
} 
.trBackground {
    background-color: #ebf1e9;
}
.wkrtjdBut {
    width: 105px;
    float: right;
}
.selectSearch{
    width: 130px;
    height: 30px;
    float: left;
    margin: 0px 5px 0px 0px;
    font-size: 0.8rem;
}
.divCardHeader {
    background-color: #fff;
}
.divSearch {
    width: 280px;
    float: left;
}
.textCenter {
    text-align:center;
}
.clsPagingArea {
	margin-top: 20px;
	justify-content: flex-end;
}
#btnSearch {
   border: 1px solid #D1D3E2;
   background-color: #F8F9FA;
}
.card {
   width: 80%;  /*목록 넓이*/
   margin: auto;
}
.expBox {
    background-color: white;
    border: 1px solid #ced4da;
    width: 80%;
    margin-left: 160px;
    margin-bottom: 30px;
    padding: 40px 40px 30px 40px;
}
#wrap{
	margin: 0 auto;
	width : 80%;
}
.h3Box{
	color: black;
    margin-bottom: 30px;
    margin-top: 40px;
}
.table.table-head-fixed thead tr:nth-child(1) th {
	background-color:#ebf1e9;
	border-bottom: 0;
	box-shadow: inset 0 1px 0 #dee2e6, inset 0 -1px 0 #dee2e6;
	position: sticky;
	top: 0;
	z-index: 10;
}
.btn.disabled, .btn:disabled {
    cursor: not-allowed;
}
.mSpan{
    display: inline-block;
    width: 185px;
}
</style>

</head>
<body>
<p style="display:none;"><sec:authentication property="principal"/></p>
<p style="display:none;"><sec:authentication property="principal.userInfoVO"/></p>
<p style="display:none;"><sec:authentication property="principal.userInfoVO.userName"/></p>
<p style="display:none;"><sec:authentication property="principal.username"   var="merong"/></p>
<p style="display:none;"><sec:authentication property="principal.userInfoVO.authorityVOList"  var="myAuths"/></p>
	<h3 style="color:black;">복학</h3>
	<h4 class="h4Class" style="color:black;">신청/승인 이력</h4>
	<br>
	<div class="expBox" style="color:black;">
		<strong>
			<h4>※안내사항</h4>
			<br>
			<p>
				1. 「 복학신청 → 승인대기 → 승인 」단계 절차로 이루어집니다.
			</p>
			<br>
			<p>
				2. 반려 가능성이 있습니다.
			</p>
		</strong>
	</div>
    <div class="card">
        <div class="card-header" class="divCardHeader" style="background-color: #fff;">
            <div class="brd-search">
                <select title="검색 조건 선택" id="searchCnd" class="selectSearch form-control">
                    <option value="1">신청일자</option>
                    <option value="2">승인여부</option>
                </select>

                <div class="input-group input-group-sm divSearch">
                    <input type="text" name="table_search" class="form-control float-left" placeholder="검색어를 입력하세요">
                    <div class="input-group-append">
                        <button type="button" class="btn btn-default" id="btnSearch">
                            <i class="fas fa-search"></i>
                        </button>
                    </div>
                </div>
				<p><input type="hidden" name="authority" value="${myAuths[0].authority}"></p>
                <button type="button" name="authorityBtn" class="btn btn-block btn-outline-primary wkrtjdBut" data-toggle="modal" data-target="#modalCreate">작성</button>
            </div>
        </div>

        <div class="card-body table-responsive p-0">
            <table class="table table-hover text-nowrap">
                <thead>
                    <tr class="trBackground textCenter" style="color:black;">
                        <th style="width: 5%;">번호</th>
                        <th style="width: 15%;">신청일자</th>
                        <th style="width: 20%;">복학 학기</th>
                        <th style="width: 10%;">승인여부</th>
                    </tr>
                </thead>
                <tbody id="trShow">
                    <tr name="trHref" data-toggle="modal" data-target="#modalDetail" style="cursor:pointer">
                        <td class="textCenter">1</td>
                        <td class="textCenter">2023-02-20 20:34</td>
                        <td class="textCenter">2023년도 1학기</td>
                        <td class="textCenter" style="color: blue;">승인</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    
    <div class="row clsPagingArea">
        ${articlePage.pagingArea}
    </div>
    <!-- 페이징 처리 -->


	<!-- 작성 모달 시작 -->
	<div class="modal fade" id="modalCreate" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">복학 상세정보</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body flex">
					<p>
						<div>신청 일자</div>
						<input type="date" class="form-control pull-right pickers mSpan" id="datepickerss" name="datepickerss" required="required">
					</p>
					<p>
						<span class="mSpan">담당 교수</span>
						<span>
							<input type="text" id="stuLecNo" class="form-control" disabled value="남예준 교수님">
						</span>
					</p>
					<p>
						<span class="mSpan">복학 사유</span>
						<span>
							<textarea rows="5" class="form-control textAreaMar"></textarea>
						</span>
					</p>
					<p>
			            <div class="custom-file">
			                <input type="file" name="queAttFile" class="custom-file-input" id="customFile" multiple/>  <!-- input,label 순서 고정 -->
			                <label class="custom-file-label" for="customFile">첨부파일</label>
			            </div>
					</p>
				</div>
				<div class="modal-footer">
					<button type="button" id="lecExSubBtn" class="btn btn-outline-primary">신청</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 모달 끝 -->


	<!-- 디테일 모달 시작 -->
	<div class="modal fade" id="modalDetail" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">휴학 상세정보</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body flex">
					<p>
						<div>신청 일자</div>
						<input type="date" class="form-control pull-right pickers mSpan" id="datepickerssDetail1" name="datepickerssDetail" value="2023-02-20" disabled>
					</p>
					<p>
						<span class="mSpan">담당 교수</span>
						<span>
							<input type="text" id="stuLecNoDetail" class="form-control" disabled value="남예준 교수님">
						</span>
					</p>
					<p>
						<span class="mSpan">휴학 사유</span>
						<span>
							<textarea rows="5" id="textareaDetail" class="form-control textAreaMar" disabled>휴학 기간이 끝나 복학합니다.</textarea>
						</span>
					</p>
					<p>
			            <div class="custom-file">
			                <input type="file" name="queAttFile" class="custom-file-input" id="customFileDetail" multiple disabled/>  <!-- input,label 순서 고정 -->
			                <label class="custom-file-label" for="customFile"></label>
			            </div>
					</p>
				</div>
				<div class="modal-footer">
<!-- 					<button type="button" id="modelBtnUpdate" class="btn btn-outline-warning">수정</button> -->
<!-- 					<button type="button" id="modelBtnSave" class="btn btn-outline-success" style="display: none;">저장</button> -->
<!-- 					<button type="button" id="modelBtnNo" class="btn btn-outline-secondary" style="display: none;">취소</button> -->
				</div>
			</div>
		</div>
	</div>
	<!-- 모달 끝 -->
</body>
</html>
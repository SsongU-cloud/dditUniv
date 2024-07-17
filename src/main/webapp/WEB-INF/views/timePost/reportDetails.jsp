<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<html>
<head>
<script type="text/javascript">
let locationHref = window.location.href;
$(function () {
	
	console.log("locationHref >> ", locationHref);
	let temp = document.getElementsByName("trHref").href;
    console.log("temp >> ", temp);
	
	$('#btnSearch').on('click', function() {
		let keyword = $("input[name='table_search']").val();
		console.log("table_search: " + keyword);
		
		let searchCnd = document.getElementById("searchCnd").value;
		console.log("searchCnd >> ", searchCnd);
		
		getList(keyword, 1, searchCnd);
	})
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
		url: "/timePost/reportDetailsAjax", //ajax용 url 변경
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
			
			$.each(result.content, function(idx, TimeDeclareVO){
				str += `<tr name="trHref" onclick="window.open('\${TimeDeclareVO.timeDeUrl}')" style="cursor:pointer">
				<td class="textCenter">\${TimeDeclareVO.rn}</td>
				<td class="textCenter">\${TimeDeclareVO.comDetCodeVOMap.comDetCodeName2}</td>
				<td>\${TimeDeclareVO.timeDeTitle}</td>
				<td class="textCenter">\${TimeDeclareVO.userInfoVOMap.userName}</td>
				<td class="textCenter">\${TimeDeclareVO.timeDeDate}</td>
				<td class="textCenter" style="color: red;">\${TimeDeclareVO.comDetCodeVOMap.comDetCodeName1}</td>`;
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

</style>

</head>
<body>
	<h3>신고 내역 조회</h3>
	<br>
	<div class="card" style="margin: auto;">
		<div class="card-header" style="background-color: #fff;">
			<div class="brd-search">
				<select title="검색 조건 선택" id="searchCnd" class="selectSearch form-control">
					<option value="1" selected="selected">게시판 구분</option>
					<option value="2">게시글 제목</option>
					<option value="3">신고자</option>
					<option value="4">신고사유</option>
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
			</div>
		</div>

		<div class="card-body table-responsive p-0">
			<table class="table table-hover text-nowrap">
				<thead>
					<tr class="trBackground textCenter">
						<th style="width: 8%;">번호</th>
						<th style="width: 12%;">게시판 구분</th>
						<th>게시글 제목</th>
						<th style="width: 10%;">신고자</th>
						<th style="width: 10%;">신고일</th>
						<th style="width: 15%;">신고사유</th>
					</tr>
				</thead>
				<tbody id="trShow">
					<c:forEach var="TimeDeclareVO" items="${articlePage.content}" varStatus="stat">
<%-- 					${TimeDeclareVO} --%>
					<tr name="trHref" onclick="window.open('${TimeDeclareVO.timeDeUrl}')" style="cursor:pointer">
						<td class="textCenter">${TimeDeclareVO.rn}</td>
						<td class="textCenter">${TimeDeclareVO.comDetCodeVOMap.comDetCodeName2}</td>
						<td>${TimeDeclareVO.timeDeTitle}</td>
						<td class="textCenter">${TimeDeclareVO.userInfoVOMap.userName}</td>
						<td class="textCenter">${TimeDeclareVO.timeDeDate}</td>
						<td class="textCenter" style="color: red;">${TimeDeclareVO.comDetCodeVOMap.comDetCodeName1}</td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>

	<div class="row clsPagingArea">
		${articlePage.pagingArea}
	</div>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<html>
<head>
<script type="text/javascript">
	$(function () {
		
/* 		$(".clsPagingArea").html(result.pagingArea);
		
		$("#trShow").html(str); */
		
		$("#newwrite").on("click", function(){
		   location.href = "/timePost/freBoaAdd?menuId=injFreArd";
		   console.log("확인용");
		        });
		});
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
.expBox {
    background-color: white;
    border: 1px solid #ced4da;
    width: 80%;
    margin-left: 160px;
    margin-bottom: 30px;
    padding: 40px 40px 30px 40px;
}
.blue{
 color: blue;
}
.red{
 color: red;
}
</style>
</head>
<body>

<p style="display:none;"><sec:authentication property="principal"/></p>
<p style="display:none;"><sec:authentication property="principal.userInfoVO"/></p>
<p style="display:none;"><sec:authentication property="principal.userInfoVO.userName"/></p>
<p style="display:none;"><sec:authentication property="principal.username"   var="merong"/></p>
<p style="display:none;"><sec:authentication property="principal.userInfoVO.authorityVOList"  var="myAuths"/></p>
	<h3>자유게시판</h3>
	<br>
   <div class="expBox">
      <p><strong>
                           ※ 자유게시판은 학생들의 여러 궁금 및 의견을 자유롭게 제시할 수 있는 게시판입니다.
      </strong></p>
      <br>
      <p><strong>
      	건전한 자유게시판을 위하여 상업성 광고, 저속한 표현, 특정인에 대한 비방, 정치적 목적이나 성향, 동일인이라고 
		인정되는 자가 동일 또는 유사내용을 반복한 게시물 등은 관리자에 의해 통보 없이 삭제될 수 있습니다. 또한 홈페이지를 통하여 
		불법유해 정보를 게시하거나 배포하면 정보통신망 이용촉진 및 정보보호 등에 관한 법률 제74조에 의거 1년 이하의 징역 또는 1천만원 이하의 벌금에 처해질 수 있습니다.
	
      </strong></p>
   </div>
	<div class="card" style="margin: auto;">
		<div class="card-header" style="background-color: #fff;">
<!-- 	<form> -->
			<div class="brd-search">
				<select title="검색 조건 선택" id="searchCnd" class="selectSearch form-control">
					<option value="1" selected="selected">제목</option>
					<option value="2">구분</option>
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
				<p>
				<input type="hidden" name="authority" value="${myAuths[0].authority}"></p>
<!-- 				<button type="button" name="newwrite" class="btn btn-block btn-outline-primary wkrtjdBut" id="newwrite">글쓰기</button> -->
			</div>
<!-- 	</form> -->
		</div>

		<div class="card-body table-responsive p-0">
			<table class="table table-hover text-nowrap">
				<thead>
					<tr class="trBackground textCenter">
						<th style="width: 10%;">번호</th>
						<th>제목</th>
						<th style="width: 12%;">게시일</th>
						<th style="width: 15%;">조회수</th>
						<th style="width: 8%;">블라인드</th>
					</tr>
				</thead>
			<tbody id="trShow">
				    <tr name="trHref" onclick="location.href='/timePost/freeBoaDetailAdmin?menuId=jaeFreBoA=1'" style="cursor:pointer">
				        <td class="textCenter">1</td>
				        <td class="textCenter" style="text-align: left;">STS에 렉이 너무 많이 걸려요..도움! </td>
				        <td class="textCenter">2024-07-14</td>
				        <td class="textCenter">97</td>
				        <td class="textCenter blue">N</td>
				    </tr>
				    <tr name="trHref" onclick="location.href='/timePost/freeBoaDetailAdmin?menuId=jaeFreBoA=2'" style="cursor:pointer">
				        <td class="textCenter">2</td>
				        <td class="textCenter"style="text-align: left;">기숙사생들 오늘 저녁에 치킨먹을사람 구함.</td>
				        <td class="textCenter">2024-07-14</td>
				        <td class="textCenter">61</td>
				        <td class="textCenter blue">N</td>
				    </tr>
				    <tr name="trHref" onclick="location.href='/timePost/freeBoaDetailAdmin?menuId=jaeFreBoA=3'" style="cursor:pointer">
				        <td class="textCenter">3</td>
				        <td class="textCenter"style="text-align: left;">카카오페이지 자주 이용하시는 분들 같이 토이프로젝트 의견 나눠보실 분 있나요</td>
				        <td class="textCenter">2024-07-13</td>
				        <td class="textCenter">81</td>
				        <td class="textCenter blue">N</td>
				    </tr>
				    <tr name="trHref" onclick="location.href='/timePost/freeBoaDetailAdmin?menuId=jaeFreBoA=4" style="cursor:pointer">
				        <td class="textCenter">4</td>
				        <td class="textCenter"style="text-align: left;">2년 경력 개발자, 개발경력 버리고 간호학과 진학 관련</td>
				        <td class="textCenter">2024-07-13</td>
				        <td class="textCenter">90</td>
				         <td class="textCenter blue">N</td>
				    </tr>
				    
				    <tr name="trHref" onclick="location.href='/timePost/freeBoaDetailAdmin?menuId=jaeFreBoA=5" style="cursor:pointer">
				        <td class="textCenter">5</td>
				        <td class="textCenter"style="text-align: left;">아 진짜 교수뒤통수 떄리고싶다 </td>
				        <td class="textCenter">2024-07-13</td>
				        <td class="textCenter">5</td>
				         <td class="textCenter red">Y</td>
				    </tr>
				    <tr name="trHref" onclick="location.href='/timePost/freeBoaDetailAdmin?menuId=jaeFreBoA=6'" style="cursor:pointer">
				        <td class="textCenter">6</td>
				        <td class="textCenter"style="text-align: left;">내일  과 시험 벼락치기로 도서관가서 같이 할사람 </td>
				        <td class="textCenter">2024-07-13</td>
				        <td class="textCenter">88</td>
				        <td class="textCenter blue">N</td>
				    </tr>
				    <tr name="trHref" onclick="location.href='/timePost/freeBoaDetailAdmin?menuId=jaeFreBoA=7'" style="cursor:pointer">
				        <td class="textCenter">7</td>
				        <td class="textCenter"style="text-align: left;">정보처리 기사 꿀팁 정보 공유 함</td>
				        <td class="textCenter">2024-07-13</td>
				        <td class="textCenter">102</td>
				        <td class="textCenter blue">N</td>
				    </tr>
				    <tr name="trHref" onclick="location.href='/timePost/freeBoaDetailAdmin?menuId=jaeFreBoA=8'" style="cursor:pointer">
				        <td class="textCenter">8</td>
				        <td class="textCenter"style="text-align: left;">[정보]제주 삼다수는 화산 암반수임 </td>
				        <td class="textCenter">2024-07-13</td>
				        <td class="textCenter">160</td>
				        <td class="textCenter blue">N</td>
				    </tr>
				    <tr name="trHref" onclick="location.href='/timePost/freeBoaDetailAdmin?menuId=jaeFreBoA=9'" style="cursor:pointer">
				        <td class="textCenter">9</td>
				        <td class="textCenter"style="text-align: left;">[정보]카라멜 팝콘은 160g에  684kcal 였다는 사실 </td>
				        <td class="textCenter">2024-07-12</td>
				        <td class="textCenter">105</td>
				         <td class="textCenter blue">N</td>
				    </tr>
				    <tr name="trHref" onclick="location.href='/timePost/freeBoaDetailAdmin?menuId=jaeFreBoA=10'" style="cursor:pointer">
				        <td class="textCenter">10</td>
				        <td class="textCenter"style="text-align: left;">오버워치 2는 사실 없던거야 </td>
				        <td class="textCenter">2024-07-12</td>
				        <td class="textCenter">220</td>
				        <td class="textCenter blue">N</td>
				    </tr>
<!-- 				<tr name="trHref" onclick="location.href='/timePost/freeBoaDetail?menuId=annNotIce&comNotNo=10'" style="cursor:pointer">
				        <td class="textCenter">10</td>
				        <td class="textCenter"style="text-align: left;">코딩테스트 같이 공부할사람 구함</td>
				        <td class="textCenter">2024-07-12</td>
				        <td class="textCenter">404</td>
				        <td class="textCenter blue">N</td>
				    </tr> -->
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
</body>
</html>
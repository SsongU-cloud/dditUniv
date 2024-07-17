<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-neo.css" rel="stylesheet">
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<style>
* {
	font-family: 'NanumSquareNeo'; 
}
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
.lostItemBox {
    background-color: white;
    border: 1px solid #ced4da;
    width: 80%;
    margin-left: 165px;
    margin-bottom: 30px;
    padding: 40px 40px 30px 40px;
}
</style>
<h3>분실물 게시판</h3>
<div class="lostItemBox">
   <p><strong>
                        ※ 본 분실물 검색 메뉴는 분실자들이 자신의 분실물을 신고한 내역입니다.
                        <br><br>
      	이 목록에 분실신고되어 있는 물품을 습득해 보관하고 있다면 여기 기재된 관할관서로 즉시 연락/제보 바랍니다.
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
		</div>
	</div>
	<div class="card-body table-responsive p-0">
		<table class="table table-hover text-nowrap">
			<thead>
				<tr class="trBackground textCenter">
					<th style="width: 7%;">번호</th>
					<th>제목</th>
					<th style="width: 7%;">구분</th>
					<th style="width: 12%;">작성자</th>
					<th style="width: 12%;">게시일</th>
					<th style="width: 7%;">조회수</th>
					<th style="width: 7%;">회수 여부</th>
					<th style="width: 12%;">블라인드</th>
				</tr>
			</thead>
			<tbody id="trShow">
<%-- 					<c:forEach var="CommonNoticeVO" items="${articlePage.content}" varStatus="stat"> --%>
				<tr name="trHref" onclick="location.href='/timePost/lostItemDetailAdmin?menuId=injlosIte&timeLoNo=1'" style="cursor:pointer">
					<td class="textCenter">1</td>
					<td>공과대학 앞에서 습득했습니다.</td>
					<td class="textCenter">카드</td>
					<td class="textCenter">이종진</td>
					<td class="textCenter">2024-07-15</td>
					<td class="textCenter">5</td>
					<td class="textCenter" style="color:red;">보관중</td>
					<td class="textCenter" style="color:blue;">N</td>
				</tr>
<%-- 					</c:forEach> --%>
			</tbody>
			<tbody id="trShow">
<%-- 					<c:forEach var="CommonNoticeVO" items="${articlePage.content}" varStatus="stat"> --%>
				<tr name="trHref" onclick="location.href='/timePost/lostItemDetailAdmin?menuId=injlosIte&timeLoNo=2'" style="cursor:pointer">
					<td class="textCenter">2</td>
					<td>다이소 앞에서 주웠는데 주인분~</td>
					<td class="textCenter">지갑</td>
					<td class="textCenter">강현석</td>
					<td class="textCenter">2024-06-30</td>
					<td class="textCenter">11</td>
					<td class="textCenter" style="color:red;">보관중</td>
					<td class="textCenter" style="color:blue;">N</td>
				</tr>
<%-- 					</c:forEach> --%>
			</tbody>
			<tbody id="trShow">
<%-- 					<c:forEach var="CommonNoticeVO" items="${articlePage.content}" varStatus="stat"> --%>
				<tr name="trHref" onclick="location.href='/timePost/lostItemDetailAdmin?menuId=injlosIte&timeLoNo=3'" style="cursor:pointer">
					<td class="textCenter">3</td>
					<td>운동장 골대 옆에 놓고가신분</td>
					<td class="textCenter">외투</td>
					<td class="textCenter">오병준</td>
					<td class="textCenter">2024-06-27</td>
					<td class="textCenter">16</td>
					<td class="textCenter" style="color:red;">보관중</td>
					<td class="textCenter" style="color:blue;">N</td>
				</tr>
<%-- 					</c:forEach> --%>
			</tbody>
			<tbody id="trShow">
<%-- 					<c:forEach var="CommonNoticeVO" items="${articlePage.content}" varStatus="stat"> --%>
				<tr name="trHref" onclick="location.href='/timePost/lostItemDetailAdmin?menuId=injlosIte&timeLoNo=4'" style="cursor:pointer">
					<td class="textCenter">4</td>
					<td>도서관 2층 복도에서 주웠습니다</td>
					<td class="textCenter">지갑</td>
					<td class="textCenter">최준</td>
					<td class="textCenter">2024-06-23</td>
					<td class="textCenter">22</td>
					<td class="textCenter" style="color:red;">보관중</td>
					<td class="textCenter" style="color:blue;">N</td>
				</tr>
<%-- 					</c:forEach> --%>
			</tbody>
			<tbody id="trShow">
<%-- 					<c:forEach var="CommonNoticeVO" items="${articlePage.content}" varStatus="stat"> --%>
				<tr name="trHref" onclick="location.href='/timePost/lostItemDetailAdmin?menuId=injlosIte&timeLoNo=5'" style="cursor:pointer">
					<td class="textCenter">5</td>
					<td>인형 두고가신분</td>
					<td class="textCenter">인형</td>
					<td class="textCenter">백은혜</td>
					<td class="textCenter">2024-06-21</td>
					<td class="textCenter">17</td>
					<td class="textCenter" style="color:red;">보관중</td>
					<td class="textCenter" style="color:blue;">N</td>
				</tr>
<%-- 					</c:forEach> --%>
			</tbody>
			<tbody id="trShow">
<%-- 					<c:forEach var="CommonNoticeVO" items="${articlePage.content}" varStatus="stat"> --%>
				<tr name="trHref" onclick="location.href='/timePost/lostItemDetailAdmin?menuId=injlosIte&timeLoNo=6'" style="cursor:pointer">
					<td class="textCenter">6</td>
					<td>학생증 주웠습니다</td>
					<td class="textCenter">학생증</td>
					<td class="textCenter">김일규</td>
					<td class="textCenter">2024-06-19</td>
					<td class="textCenter">34</td>
					<td class="textCenter" style="color:red;">보관중</td>
					<td class="textCenter" style="color:blue;">N</td>
				</tr>
<%-- 					</c:forEach> --%>
			</tbody>
			<tbody id="trShow">
<%-- 					<c:forEach var="CommonNoticeVO" items="${articlePage.content}" varStatus="stat"> --%>
				<tr name="trHref" onclick="location.href='/timePost/lostItemDetailAdmin?menuId=injlosIte&timeLoNo=7'" style="cursor:pointer">
					<td class="textCenter">7</td>
					<td>도서관에서 발견했는데 찾아가세여</td>
					<td class="textCenter">카드</td>
					<td class="textCenter">지수찬</td>
					<td class="textCenter">2024-06-16</td>
					<td class="textCenter">19</td>
					<td class="textCenter" style="color:red;">보관중</td>
					<td class="textCenter" style="color:blue;">N</td>
				</tr>
<%-- 					</c:forEach> --%>
			</tbody>
			<tbody id="trShow">
<%-- 					<c:forEach var="CommonNoticeVO" items="${articlePage.content}" varStatus="stat"> --%>
				<tr name="trHref" onclick="location.href='/timePost/lostItemDetailAdmin?menuId=injlosIte&timeLoNo=8'" style="cursor:pointer">
					<td class="textCenter">8</td>
					<td>인문대학 벤치에서 주웠습니다.</td>
					<td class="textCenter">지갑</td>
					<td class="textCenter">최준호</td>
					<td class="textCenter">2024-06-16</td>
					<td class="textCenter">24</td>
					<td class="textCenter" style="color:red;">보관중</td>
					<td class="textCenter" style="color:blue;">N</td>
				</tr>
<%-- 					</c:forEach> --%>
			</tbody>
			<tbody id="trShow">
<%-- 					<c:forEach var="CommonNoticeVO" items="${articlePage.content}" varStatus="stat"> --%>
				<tr name="trHref" onclick="location.href='/timePost/lostItemDetailAdmin?menuId=injlosIte&timeLoNo=9'" style="cursor:pointer">
					<td class="textCenter">9</td>
					<td>운동장에 계단에 놓고가신 분</td>
					<td class="textCenter">핸드폰</td>
					<td class="textCenter">김수진</td>
					<td class="textCenter">2024-06-15</td>
					<td class="textCenter">29</td>
					<td class="textCenter" style="color:blue;">회수 완료</td>
					<td class="textCenter" style="color:blue;">N</td>
				</tr>
<%-- 					</c:forEach> --%>
			</tbody>
			<tbody id="trShow">
<%-- 					<c:forEach var="CommonNoticeVO" items="${articlePage.content}" varStatus="stat"> --%>
				<tr name="trHref" onclick="location.href='/timePost/lostItemDetailAdmin?menuId=injlosIte&timeLoNo=10'" style="cursor:pointer">
					<td class="textCenter">10</td>
					<td>**분식 앞에서 주웠음.</td>
					<td class="textCenter">지갑</td>
					<td class="textCenter">강현수</td>
					<td class="textCenter">2024-06-15</td>
					<td class="textCenter">21</td>
					<td class="textCenter" style="color:blue;">회수 완료</td>
					<td class="textCenter" style="color:blue;">N</td>
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
                
                <!-- Next Button -->
                <li class='paginate_button page-item next' id='example2_next'>
                    <a href='#' onclick="getList('keyword', startPage + 5, queGubun)" aria-controls='example2' data-dt-idx='7' tabindex='0' class='page-link'>&gt;&gt;</a>
                </li>
            </ul>
        </div>
    </div>
</div>

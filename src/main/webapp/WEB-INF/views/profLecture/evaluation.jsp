<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<style>
#wrap{
	margin: 0 auto;
	width : 80%;
}
.selectSearch{
    width: 130px;
    height: 30px;
    float: left;
    margin: 0px 5px 0px 0px;
    font-size: 0.8rem;
}
.back_white{
	background-color: white;
	position: relative;
    top: -2px;
}
.trBackground, th {
  background-color: #ebf1e9;
}
.clsPagingArea {
	margin-top: 20px;
	justify-content: flex-end;
}
.pointer{
	cursor:pointer;
}
.h3Box {
   color: black;
   margin-bottom: 30px;
   margin-top: 40px;
}
</style>
<script type="text/javascript" src="/resources/js/adminlte.min.js"></script>
<div id="wrap">
	<div class="h3Box" style="height: 50px;">
		<h3 style="color: black;">강의평가 조회</h3>
	</div>
	<div class="card" style="margin: auto;">
		<div class="card-header" style="background-color: #fff;">
			<div class="brd-search">
				<select title="검색 조건 선택" id="searchCnd" class="selectSearch form-control">
					<option value="1">최신순</option>
					<option value="2">강의명순</option>
				</select>
				<div class="input-group input-group-sm" style="width: 280px; float: left; margin-bottom: 15px;">
					<input type="text" name="table_search" class="form-control float-left" placeholder="검색어를 입력하세요">
					<div class="input-group-append">
						<button type="button" class="btn btn-default" id="btnSearch">
							<i class="fas fa-search"></i>
						</button>
					</div>
				</div>
				<p><input type="hidden" name="authority" value="ROLE_PROFESSOR"></p>
			</div>
		</div>
	</div>
	<div class="tableWrap"> 
		<table class="table table-hover back_white">
			<thead>
				<tr class="text-center" style="color: black;">
					<th>번호</th>
					<th>강의번호</th>
					<th>강의연도</th>
					<th>강의학기</th>
					<th>강의명</th>
					<th>강의실번호</th>
					<th>수강인원</th>
				</tr>
			</thead>
			<tbody>
				<tr data-widget="expandable-table" aria-expanded="false" class="pointer">
					<td class="text-center">1</td>
					<td class="text-center">LECB016</td>
					<td class="text-center">2024년도</td>
					<td class="text-center">1학기</td>
					<td>C프로그래밍</td>
					<td class="text-center">C301</td>
					<td class="text-center">65명</td>
				</tr>
				<tr class="expandable-body">
					<td colspan="7">
						<p style="color: black; font-size: 20px;">평점 
						<span style="font-size: 16px; color:#858796;">4.5 / 5.0</span></p><br>
						<p style="color: black; font-size: 20px;">기타의견</p>

						<table class="table table-bordered">
							<tr>
								<td>교수님은 제가 부족했던부분들을 알려주시고 모르는부분이있으면은 그것을 이해할떄까지 옆에서 알려주셔서
									너무 좋았고 제가 이저 까지 배운교수중에 가장 완벽한 사람이였습니다 진짜 최고의 교수님였습니다</td>
							</tr>
							<tr>
								<td>한학기동안 감사했습니다.</td>
							</tr>
							<tr>
								<td>수업 너무 좋았습니다</td>
							</tr>
							<tr>
								<td>교수님이 점심밥도 같이 먹으면서 힘든 고민있으면 상담도 해주시면서 응원도 해주셔서 감동이였고
									수업시간떄 분위기가 다운되면은 재밌는썰도 풀어주면서 수업하는게 너무 좋았습니다</td>
							</tr>
							<tr>
								<td>대학다니면서 여러 수업을 듣을면서 항상 교수님 말을 이해를 못했지만 
									이 교수님은 이해하기 쉽도록 반복적으로 알려주시면 여러 꿀팁등 정보를 알려줘서 정말 유익한 수업이었습니다. .	
							</td>
							</tr>
							<tr>
								<td>수고하셨습니다.</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr data-widget="expandable-table" aria-expanded="false" class="pointer">
					<td class="text-center">2</td>
					<td class="text-center">LECB017</td>
					<td class="text-center">2024년도</td>
					<td class="text-center">1학기</td>
					<td>컴퓨터알고리즘</td>
					<td class="text-center">C301</td>
					<td class="text-center">30명</td>
				</tr>
				<tr class="expandable-body">
					<td colspan="7">
						<p style="">평점 4.5</p>
						<p>기타의견</p>
						<table class="table table-bordered">
							<tr>
								<td>교수님 너무 좋아요.</td>
							</tr>
							<tr>
								<td>한학기동안 감사했습니다.</td>
							</tr>
							<tr>
								<td>수업 너무 좋았습니다</td>
							</tr>
							<tr>
								<td>수업 준비가 미흡한거같습니다.</td>
							</tr>
							<tr>
								<td>ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ</td>
							</tr>
							<tr>
								<td>수고하셨습니다.</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr data-widget="expandable-table" aria-expanded="false" class="pointer">
					<td class="text-center">3</td>
					<td class="text-center">LECB018</td>
					<td class="text-center">2024년도</td>
					<td class="text-center">1학기</td>
					<td>모바일프로그래밍</td>
					<td class="text-center">C304</td>
					<td class="text-center">30명</td>
				</tr>
				<tr class="expandable-body">
					<td colspan="7">
						<p style="">평점 4.5</p>
						<p>기타의견</p>
						<table class="table table-bordered">
							<tr>
								<td>교수님 너무 좋아요.</td>
							</tr>
							<tr>
								<td>한학기동안 감사했습니다.</td>
							</tr>
							<tr>
								<td>수업 너무 좋았습니다</td>
							</tr>
							<tr>
								<td>수업 준비가 미흡한거같습니다.</td>
							</tr>
							<tr>
								<td>ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ</td>
							</tr>
							<tr>
								<td>수고하셨습니다.</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr data-widget="expandable-table" aria-expanded="false" class="pointer">
					<td class="text-center">4</td>
					<td class="text-center">LECB019</td>
					<td class="text-center">2024년도</td>
					<td class="text-center">1학기</td>
					<td>유닉스와 리눅스</td>
					<td class="text-center">C301</td>
					<td class="text-center">60명</td>
				</tr>
				<tr class="expandable-body">
					<td colspan="7">
						<p style="">평점 4.5</p>
						<p>기타의견</p>
						<table class="table table-bordered">
							<tr>
								<td>교수님 너무 좋아요.</td>
							</tr>
							<tr>
								<td>한학기동안 감사했습니다.</td>
							</tr>
							<tr>
								<td>수업 너무 좋았습니다</td>
							</tr>
							<tr>
								<td>수업 준비가 미흡한거같습니다.</td>
							</tr>
							<tr>
								<td>ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ</td>
							</tr>
							<tr>
								<td>수고하셨습니다.</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr data-widget="expandable-table" aria-expanded="false">
					<td class="text-center">5</td>
					<td class="text-center">LECB020</td>
					<td class="text-center">2024년도</td>
					<td class="text-center">1학기</td>
					<td>고급프로그래밍</td>
					<td class="text-center">C301</td>
					<td class="text-center">65명</td>
				</tr>
				<tr class="expandable-body">
					<td colspan="7">
						<p style="">평점 4.5</p>
						<p>기타의견</p>
						<table class="table table-bordered">
							<tr>
								<td>교수님 너무 좋아요.</td>
							</tr>
							<tr>
								<td>한학기동안 감사했습니다.</td>
							</tr>
							<tr>
								<td>수업 너무 좋았습니다</td>
							</tr>
							<tr>
								<td>수업 준비가 미흡한거같습니다.</td>
							</tr>
							<tr>
								<td>ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ</td>
							</tr>
							<tr>
								<td>수고하셨습니다.</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr data-widget="expandable-table" aria-expanded="false">
					<td class="text-center">6</td>
					<td class="text-center">LECB005</td>
					<td class="text-center">2023년도</td>
					<td class="text-center">1학기</td>
					<td>컴퓨터통신</td>
					<td class="text-center">C301</td>
					<td class="text-center">65명</td>
				</tr>
				<tr class="expandable-body">
					<td colspan="7">
						<p style="">평점 4.5</p>
						<p>기타의견</p>
						<table class="table table-bordered">
							<tr>
								<td>교수님 너무 좋아요.</td>
							</tr>
							<tr>
								<td>한학기동안 감사했습니다.</td>
							</tr>
							<tr>
								<td>수업 너무 좋았습니다</td>
							</tr>
							<tr>
								<td>수업 준비가 미흡한거같습니다.</td>
							</tr>
							<tr>
								<td>ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ</td>
							</tr>
							<tr>
								<td>수고하셨습니다.</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr data-widget="expandable-table" aria-expanded="false">
					<td class="text-center">7</td>
					<td class="text-center">LECB004</td>
					<td class="text-center">2023년도</td>
					<td class="text-center">2학기</td>
					<td>전산영어</td>
					<td class="text-center">C201</td>
					<td class="text-center">70명</td>
				</tr>
				<tr class="expandable-body">
					<td colspan="7">
						<p style="">평점 4.5</p>
						<p>기타의견</p>
						<table class="table table-bordered">
							<tr>
								<td>교수님 너무 좋아요.</td>
							</tr>
							<tr>
								<td>한학기동안 감사했습니다.</td>
							</tr>
							<tr>
								<td>수업 너무 좋았습니다</td>
							</tr>
							<tr>
								<td>수업 준비가 미흡한거같습니다.</td>
							</tr>
							<tr>
								<td>ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ</td>
							</tr>
							<tr>
								<td>수고하셨습니다.</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr data-widget="expandable-table" aria-expanded="false">
					<td class="text-center">8</td>
					<td class="text-center">LECB002</td>
					<td class="text-center">2023년도</td>
					<td class="text-center">2학기</td>
					<td>객체지향프로그래밍</td>
					<td class="text-center">C303</td>
					<td class="text-center">60명</td>
				</tr>
				<tr class="expandable-body">
					<td colspan="7">
						<p style="">평점 4.5</p>
						<p>기타의견</p>
						<table class="table table-bordered">
							<tr>
								<td>교수님 너무 좋아요.</td>
							</tr>
							<tr>
								<td>한학기동안 감사했습니다.</td>
							</tr>
							<tr>
								<td>수업 너무 좋았습니다</td>
							</tr>
							<tr>
								<td>수업 준비가 미흡한거같습니다.</td>
							</tr>
							<tr>
								<td>ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ</td>
							</tr>
							<tr>
								<td>수고하셨습니다.</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr data-widget="expandable-table" aria-expanded="false">
					<td class="text-center">9</td>
					<td class="text-center">LECB001</td>
					<td class="text-center">2023년도</td>
					<td class="text-center">1학기</td>
					<td>고급알고리즘</td>
					<td class="text-center">C302</td>
					<td class="text-center">55명</td>
				</tr>
				<tr class="expandable-body">
					<td colspan="7">
						<p style="">평점 4.5</p>
						<p>기타의견</p>
						<table class="table table-bordered">
							<tr>
								<td>교수님 너무 좋아요.</td>
							</tr>
							<tr>
								<td>한학기동안 감사했습니다.</td>
							</tr>
							<tr>
								<td>수업 너무 좋았습니다</td>
							</tr>
							<tr>
								<td>수업 준비가 미흡한거같습니다.</td>
							</tr>
							<tr>
								<td>ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ</td>
							</tr>
							<tr>
								<td>수고하셨습니다.</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr data-widget="expandable-table" aria-expanded="false">
					<td class="text-center">10</td>
					<td class="text-center">LECB021</td>
					<td class="text-center">2023년도</td>
					<td class="text-center">1학기</td>
					<td>고급프로그래밍</td>
					<td class="text-center">C201</td>
					<td class="text-center">65명</td>
				</tr>
				<tr class="expandable-body">
					<td colspan="7">
						<p style="">평점 4.5</p>
						<p>기타의견</p>
						<table class="table table-bordered">
							<tr>
								<td>교수님 너무 좋아요.</td>
							</tr>
							<tr>
								<td>한학기동안 감사했습니다.</td>
							</tr>
							<tr>
								<td>수업 너무 좋았습니다</td>
							</tr>
							<tr>
								<td>수업 준비가 미흡한거같습니다.</td>
							</tr>
							<tr>
								<td>ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ</td>
							</tr>
							<tr>
								<td>수고하셨습니다.</td>
							</tr>
						</table>
					</td>
				</tr>
			</tbody>
		</table>
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
</div>
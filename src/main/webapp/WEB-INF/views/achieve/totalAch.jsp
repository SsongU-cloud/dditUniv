<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
#wrap{
	width: 80%;
	margin: 0 auto;
}
.back_white{
	background-color: white;
}
.table thead tr:nth-child(1) th {
	background-color:#ebf1e9;
	border-bottom: 0;
	box-shadow: inset 0 1px 0 #dee2e6, inset 0 -1px 0 #dee2e6;
	position: sticky;
	top: 0;
	z-index: 10;
}
.table-header{
	background-color:#ebf1e9;
/* 	border-bottom: 0; */
/* 	box-shadow: inset 0 1px 0 #dee2e6, inset 0 -1px 0 #dee2e6; */
}
#achDivedArea{
	display: flex;
    justify-content: space-around;
}
.h3Box{
	color: black;
    margin-bottom: 30px;
    margin-top: 40px;
}
.pointer{
	cursor:pointer;
}
</style>
<script>
	$(function(){
		$("#grade4-1").on("click",function(){
			let achTrHtml = `
				<td>19</td>
				<td>19</td>
				<td>67</td>
				<td>3.07</td>
				<td>3.07</td>
				<td>84.0</td>
				<td>13/28</td>
			`;
			
			let lecListHtml = `
			<tr>
				<td class="text-center">LECB109008</td>
				<td style="width: 58px;" >오토메타형식언어</td>
				<td class="text-center">3</td>
				<td class="text-center">전필</td>
				<td class="text-center">A</td>
			</tr>
			<tr>
				<td class="text-center">LECB093008</td>
				<td style="width: 10px" >공학과학적사고</td>
				<td class="text-center">2</td>
				<td class="text-center">교선</td>
				<td class="text-center">A+</td>
			</tr>
			<tr>
				<td class="text-center" >LECB113008</td>
				<td style="width: 10px" >인공지능확률</td>
				<td class="text-center">3</td>
				<td class="text-center">전필</td>
				<td class="text-center">C+</td>
			</tr>
			<tr>
				<td class="text-center">LECB112008</td>
				<td style="width: 10px" >임베디드프로그래밍</td>
				<td class="text-center">3</td>
				<td class="text-center">전필</td>
				<td class="text-center">C+</td>
			</tr>
			<tr>
				<td class="text-center">LECB111006</td>
				<td style="width: 10px" >데이터베이스프로그래밍</td>
				<td class="text-center">3</td>
				<td class="text-center">전필</td>
				<td class="text-center">C</td>
			</tr>
			<tr>
				<td class="text-center">LECB110008</td>
				<td style="width: 10px" >통신공학</td>
				<td class="text-center">3</td>
				<td class="text-center">전필</td>
				<td class="text-center">C+</td>
			</tr>
			<tr>
				<td class="text-center">LECB026008</td>
				<td style="width: 10px" >디지털 시스템 설계</td>
				<td class="text-center">2</td>
				<td class="text-center">교선</td>
				<td class="text-center">B+</td>
			</tr>
			`;
			let yearSemTh = `2024년도 1학기<br>(3학년-정시학기)`;
			$("#achTr").html(achTrHtml);
			$("#lecListArea").html(lecListHtml);
			$("#yearSemTh").html(yearSemTh);	
		});
		
		$("#grade3-2").on("click",function(){
			let achTrHtml = `
				<td>18</td>
				<td>18</td>
				<td>90.5</td>
				<td>4.0</td>
				<td>4.0</td>
				<td>94.0</td>
				<td>6/28</td>
			`;
			
			let lecListHtml = `
				<tr>
				<td class="text-center">LECB003010</td>
				<td style="width: 58px;">코딩의 역사2</td>
				<td class="text-center">3</td>
				<td class="text-center">전필</td>
				<td class="text-center">A+</td>
			</tr>
			<tr>
				<td class="text-center" style="width: 10px" >LECB034010</td>
				<td style="width: 10px" >비즈니스컴퓨팅기술</td>
				<td class="text-center">3</td>
				<td class="text-center">전선</td>
				<td class="text-center">A</td>
			</tr>
			<tr>
				<td class="text-center">LECB035011</td>
				<td>소프트웨어공학</td>
				<td class="text-center">3</td>
				<td class="text-center">전선</td>
				<td class="text-center">B</td>
			</tr>
			<tr>
				<td class="text-center">LECB026022</td>
				<td>디지털 시스템 설계</td>
				<td class="text-center">3</td>
				<td class="text-center">전필</td>
				<td class="text-center">A+</td>
			</tr>
			<tr>
				<td class="text-center">LECB039030</td>
				<td>네트워크관리</td>
				<td class="text-center">3</td>
				<td class="text-center">교선</td>
				<td class="text-center">B+</td>
			</tr>
			<tr>
				<td class="text-center">LECB041011</td>
				<td>가상화시스템</td>
				<td class="text-center">3</td>
				<td class="text-center">전선</td>
				<td class="text-center">A+</td>
			</tr>
			`;
			let yearSemTh = `2023년도 2학기<br>(2학년-정시학기)`;
			$("#achTr").html(achTrHtml);
			$("#lecListArea").html(lecListHtml);
			$("#yearSemTh").html(yearSemTh);
		});
		
	});
</script>
<div id="wrap">
	<div class="h3Box" style="height:50px;">
		<h3>전체 성적 조회</h3>
	</div>
	<h5 style="color:black;">집계정보</h5>
	<div class="tableWrap">
		<table class="table table-bordered back_white">
			<thead class="text-center">
				<tr style="color:black;">
					<th colspan="2">총계</th>
					<th colspan="4">교양영역</th>
					<th colspan="4">전공영역</th>
				</tr>
			</thead>
			<tbody>
				<tr class="text-center" style="color:black;">
					<td>신청학점</td>
					<td>취득학점</td>
					<td>교필</td>
					<td>교선</td>
					<td>소계</td>
					<td>평균평점</td>
					<td>전필</td>
					<td>전선</td>
					<td>소계</td>
					<td>평균평점</td>
				</tr>
				<tr class="text-center" style="color:black;">
					<td>103</td>
					<td>103</td>
					<td>22</td>
					<td>30</td>
					<td>52</td>
					<td>4.12</td>
					<td>60</td>
					<td>30</td>
					<td>90</td>
					<td>3.65</td>
				</tr>
			</tbody>
		</table>
	</div>
	<div style="padding:10px;">
		<i class="fas fa-check bg-green" 
		   style="
				color: #fff !important;
				background-color: #28a745 !important;
			    background-color: #adb5bd;
			    border-radius: 50%;
			    font-size: 16px;
			    height: 30px;
			    line-height: 30px;
			    text-align: center;
			    top: 0;
			    width: 30px;
			  	"
		></i>
		<h5 style="display:inline-block">아래의 학기를 선택하세요</h5>
	</div>
	<div id="achDivedArea">
		<div>
		</div>
		<table class="table table-hover text-nowrap back_white text-center" style="width:24%;">
			<thead>
				<tr style="color:black;">
					<th>연도</th>
					<th>학기</th>
					<th>이수형태</th>
					<th>학년</th>
				</tr>
			</thead>
			<tbody>
				<tr id="grade4-1" class="pointer">
					<td>2024</td>
					<td>1학기</td>
					<td>정시학기</td>
					<td>3학년</td>
				</tr>
				<tr id="grade3-2" class="pointer">
					<td>2023</td>
					<td>2학기</td>
					<td>정시학기</td>
					<td>2학년</td>
				</tr>
				<tr class="pointer">
					<td>2023</td>
					<td>1학기</td>
					<td>정시학기</td>
					<td>2학년</td>
				</tr>
				<tr class="pointer">
					<td>2022</td>
					<td>2학기</td>
					<td>정시학기</td>
					<td>1학년</td>
				</tr>
				<tr class="pointer">
					<td>2022</td>
					<td>1학기</td>
					<td>정시학기</td>
					<td>1학년</td>
				</tr>
				<tr class="pointer">
					<td>.</td>
					<td>.</td>
					<td>.</td>
					<td>.</td>
				</tr>
				<tr class="pointer">
					<td>.</td>
					<td>.</td>
					<td>.</td>
					<td>.</td>
				</tr>
				<tr class="pointer">
					<td>.</td>
					<td>.</td>
					<td>.</td>
					<td>.</td>
				</tr>
			</tbody>
		</table>
		<div id="achDivedAreaChild" style="width:75%;">
			<table class="table table-bordered back_white">
				<colgroup>
					<col width="*"/>
					<col width="12%"/>
					<col width="12%"/>
					<col width="12%"/>
					<col width="12%"/>
					<col width="12%"/>
					<col width="12%"/>
					<col width="12%"/>
				</colgroup>
				<tbody class="text-center">
					<tr class="table-header" style="color:black;">
						<th rowspan="2" id="yearSemTh" style="padding-top: 34px;">2024년도 1학기<br>(3학년-정시학기)</th>
						<th>신청학점</th>
						<th>취득학점</th>
						<th>평점계</th>
						<th>평점평균</th>
						<th style="font-size:15px;">재수강후<br>평점평균</th>
						<th>백분위</th>
						<th>석차</th>
					</tr>
					<tr class="text-center" id="achTr">
						<td>19</td>
						<td>19</td>
						<td>67</td>
						<td>3.07</td>
						<td>3.07</td>
						<td>84.0</td>
						<td>13/28</td>
					</tr>
				</tbody>
			</table>
			<table class="table table-bordered back_white" style="height:393px;">
				<colgroup>
					<col width="15%"/>
					<col width="*"/>
					<col width="15%"/>
					<col width="15%"/>
					<col width="15%"/>
				</colgroup>
				<thead class="text-center">
					<tr class="table-header" style="color:black;">
						<th>수강코드</th>
						<th>과목명</th>
						<th>학점</th>
						<th>이수구분</th>
						<th>등급</th>
					</tr>
				</thead>
				<tbody id="lecListArea">
					<tr>
						<td class="text-center">LECB109008</td>
						<td style="width: 58px;" >오토메타형식언어</td>
						<td class="text-center">3</td>
						<td class="text-center">전필</td>
						<td class="text-center">A</td>
					</tr>
					<tr>
						<td class="text-center">LECB093008</td>
						<td style="width: 10px" >공학과학적사고</td>
						<td class="text-center">2</td>
						<td class="text-center">교선</td>
						<td class="text-center">A+</td>
					</tr>
					<tr>
						<td class="text-center" >LECB113008</td>
						<td style="width: 10px" >인공지능확률</td>
						<td class="text-center">3</td>
						<td class="text-center">전필</td>
						<td class="text-center">C+</td>
					</tr>
					<tr>
						<td class="text-center">LECB112008</td>
						<td style="width: 10px" >임베디드프로그래밍</td>
						<td class="text-center">3</td>
						<td class="text-center">전필</td>
						<td class="text-center">C+</td>
					</tr>
					<tr>
						<td class="text-center">LECB111006</td>
						<td style="width: 10px" >데이터베이스프로그래밍</td>
						<td class="text-center">3</td>
						<td class="text-center">전필</td>
						<td class="text-center">C</td>
					</tr>
					<tr>
						<td class="text-center">LECB110008</td>
						<td style="width: 10px" >통신공학</td>
						<td class="text-center">3</td>
						<td class="text-center">전필</td>
						<td class="text-center">C+</td>
					</tr>
					<tr>
						<td class="text-center">LECB026008</td>
						<td style="width: 10px" >디지털 시스템 설계</td>
						<td class="text-center">2</td>
						<td class="text-center">교선</td>
						<td class="text-center">B+</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
</div>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
#wrap{
	margin: 0 auto;
	width : 80%;
}
.h3Box{
	color: black;
    margin-bottom: 30px;
    margin-top: 40px;
}
.back_white{
	background-color: white;
	position: relative;
    top: -2px;
}
.table thead tr:nth-child(1) th {
	background-color:#ebf1e9;
	border-bottom: 0;
	box-shadow: inset 0 1px 0 #dee2e6, inset 0 -1px 0 #dee2e6;
	position: sticky;
	top: 0;
	z-index: 10;
}
.clsPagingArea {
	margin-top: 20px;
	justify-content: flex-end;
}
.selectSearch{
    width: 130px;
    height: 30px;
    float: left;
    margin: 0px 5px 0px 0px;
    font-size: 0.8rem;
}
.divCard {
    margin: auto;
}
.divCardHeader {
    background-color: #fff;
}
.divSearch {
    width: 280px;
    float: left;
}

.trBackground, th {
  background-color: #ebf1e9;
}
.tableModel>td {
  text-align:left;
}
.w130px{
	width: 130px;
	text-align:center;	
}
.flexBetween{
	display:flex;
	justify-content:space-between;
}
</style>  

<script>
$(function(){
	$(".lecList").on("click",function(){
		// 버튼의 data-* 속성에서 데이터 가져오기
		
        let lecNo = $(this).data('lecno');
        let lecName = $(this).data('lecname');
        let lecGrade = $(this).data('lecgrade');
        let lecScore = $(this).data('lecscore');
        let lecDiv = $(this).data('lecdiv');
        let lecType = $(this).data('lectype');
        let lecPer = $(this).data('lecper');
        let lecDays = $(this).data('lecdays');
        let lecTimes = $(this).data('lectimes');
        let dept = $(this).data('dept');
        let college = $(this).data('college');
        let lecRoName = $(this).data('lecroname');
        
        
        let str = "";
        
        $.ajax({
        	url:"/profLecture/lecDetail",
        	contentType:"application/json;charset=utf-8",
    		data: lecNo,
    		type:"post",
    		dataType:"json",
    		beforeSend:function(xhr){
                xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
            },
    		success:function(result){
    			console.log(result);
    			$.each(result, function(idx, lecDetailVO) {
	        		str += `
	        				<tr>
								<th colspan="6" class="text-center">
									<span>\${lecDetailVO.lecNum}회차</span>
								</th>
							</tr>
							<tr>
								<td colspan="6">\${lecDetailVO.lecCon}</td>
							</tr>`;
	        	});
    			console.log("str >> ",str);
    			$('#lecDetail').html(str);
    		}
        });
				
        $('#lecName').text(lecName);
        
        if(lecGrade==null||lecGrade==0){
	        $('#lecGrade').text("전학년");
        }
        else{
        	
	        $('#lecGrade').text(lecGrade+"학년");
        }
        $('#lecScore').text(lecScore+"학점");
        $('#lecDiv').text(lecDiv);
        $('#lecType').text(lecType);
        $('#lecPer').text(lecPer+"명");
        $('#lecDays').text(lecDays);
        $('#lecTimes').text(lecTimes+" 교시");
        $('#dept').text(dept);
        $('#college').text(college);
        $('#lecRoName').text(lecRoName);
        
        console.log("lecDetail >> ", $('#lecDetail')[0]);
        
	});
});
function getList(keyword, currentPage, queGubun) {
	// JSON 오브젝트
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
		url: "/profLecture/lecList", //ajax용 url 변경
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
			
			$.each(result.content, function(idx, lecPlan){
				str += `<tr name="trHref" data-toggle="modal" data-target="#lecPlanModal" style="cursor:pointer">`;
				str += `<td class="text-center">\${lecPlan.rownum}</td>`;
				str += `<td class="text-center">\${lecPlan.lecNo}</td>`;
				str += `<td class="text-center">\${lecPlan.lecYear}년도</td>`;
				str += `<td class="text-center">\${lecPlan.lecSemester}학기</td>`; 
				str += `<td>\${lecPlan.lecName}</td>`;
				str += `<td class="text-center">\${lecPlan.lecDiv}</td>`;
				str += `<td class="text-center">\${lecPlan.lecScore}학점</td>`;
				str += `</tr>`;
			});
			
			$(".clsPagingArea").html(result.pagingArea);
			
			$("#trShow").html(str);
		}
	});
}
</script>
<div id="wrap">
	<div class="h3Box" style="height:50px;">
		<h3 style="color:black;">강의 내역</h3>
	</div>
	<div class="flexBetween">
		<div class="brd-search">
			<select title="검색 조건 선택" id="searchCnd" class="selectSearch form-control">
				<option value="1" selected="selected">제목</option>
				<option value="2">구분</option>
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
		<span>* 이번 학기의 강의만 조회 가능합니다</span>
	</div>
	<div class="table-responsive p-0 back_white">
		<table class="table table-hover text-nowrap">
			<thead class=" text-center">
				<tr style="color:black;">
					<th>번호</th>
					<th>강의번호</th>
					<th>강의연도</th>
					<th>강의학기</th>
					<th>강의명</th>
					<th>이수구분</th>
					<th>학점</th>
				</tr>
			</thead>
			<tbody id="trShow">
				<c:forEach var="lectureVO" items="${articlePage.content}" varStatus="stat">
					<tr name="trHref" id="dhTr${stat.count}" class="lecList" style="cursor:pointer" data-toggle="modal" data-target="#lecPlanModal"
					data-lecname="${lectureVO.lecName}"
					data-lecno="${lectureVO.lecNo}"
					data-lecgrade="${lectureVO.lecGrade}"
					data-lecscore="${lectureVO.lecScore}"
					data-lecdiv="${lectureVO.lecDiv}"
					data-lectype="${lectureVO.lecType}"
					data-lecper="${lectureVO.lecPer}"
					data-lecdays="${lectureVO.lecDays}"
					data-lectimes="${lectureVO.lecTimes}"
					data-dept="${lectureVO.comDetCodeVO.comDetCodeName}"
					data-college="${lectureVO.comCodeVO.comCodeName}"
					data-lecroname="${lectureVO.lectureRoomVO.lecRoName}"
					>
						<td class=" text-center">${stat.index+1}</td>
						<td class=" text-center">${lectureVO.lecNo}</td>
						<td class=" text-center">${lectureVO.lecYear}년도</td>
						<td class=" text-center">${lectureVO.lecSemester}학기</td>
						<td>${lectureVO.lecName}</td>
						<td class=" text-center">${lectureVO.lecDiv}</td>
						<td class=" text-center">${lectureVO.lecScore}학점</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<div class="row clsPagingArea">
   	    ${articlePage.pagingArea}
    </div>
    
    <!-- 모달 시작 -->
	<div class="modal fade" id="lecPlanModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered" style="max-width: 1000px;">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">강의 계획서</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body flex">
			<div id="tableWrap" style="margin:20px;">
				<table class="table table-bordered tableModel">
					<tbody>
					<tr>
						<th class="w130px">강의명</th>
						<td id="lecName"style="width: 250px;"></td>
						<th class="w130px">수강 학년</th>
						<td id="lecGrade"></td>
						<th class="w130px">학점</th>
						<td id="lecScore"></td>
					</tr>
					<tr>
						<th class="w130px">단과대학</th>
						<td id="college"></td>
						<th class="w130px">학과</th>
						<td id="dept"></td>
						<th class="w130px">강의실</th>
						<td id="lecRoName"></td>
					</tr>
					<tr>
						<th class="w130px">이수구분</th>
						<td id="lecDiv"></td>
						<th class="w130px">강의영역</th>
						<td id="lecType"></td>
						<th class="w130px">수강최대인원</th>
						<td id="lecPer"></td>
					</tr>
					<tr>
						<th class="w130px">강의요일</th>
						<td id="lecDays"></td>
						<th class="w130px">강의 시간</th>
						<td id="lecTimes" colspan="3"></td>
					</tr>
					</tbody></table>
					<br>
					<table class="table table-bordered tableModel">
						<tbody id="lecDetail">
							<tr>
								<th colspan="6">
									<span>1회차</span>
								</th>
							</tr>
							<tr>
								<td colspan="6">오리엔테이션</td>
							</tr>
						</tbody>
					</table>
				</div>
	      </div>
	      <div class="modal-footer">
	      </div>
	    </div>
	  </div>
	</div>
	<!-- 모달 끝 -->
</div>

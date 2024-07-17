<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
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
.table thead tr:nth-child(1) th {
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
    width: 86px;
}
.pointer{
	cursor:pointer;
}
</style>
<script type="text/javascript">
//<form action="/achieve/lecEvaluation">
$(function(){
	$(".evBtn").on("click",function(){
		console.log("버튼클릭");
		let stLecNo = $(this).parent().parent().attr("id");
		
		$("input[name='stuLecNo']").val(stLecNo);
		
		console.log("form >> ","#form"+stLecNo);
		
		$("#formAch").submit();
	});
	
	$('.exBtn').on('click', function() {
        // 버튼의 data-* 속성에서 데이터 가져오기
        let stuLecNo = $(this).data('stulecno');
        let lecName = $(this).data('lecname');
        let lecYear = $(this).data('lecyear');
        let lecSemester = $(this).data('lecsemester');
        let achieveGrade = $(this).data('achievegrade');
        let userName = $(this).data('username');
		
        console.log(stuLecNo);
        console.log(lecName);
        console.log("연도 >> ",lecYear+"/"+lecSemester+"학기");
        console.log("교수명 >> ",userName);
        
        // 모달의 각 필드에 데이터 설정
        $('#lecExModal #stuLecNo').val(stuLecNo);
        $('#lecExModal #lecName').val(lecName);
        $('#lecExModal #lecYear').val(`\${lecYear}/\${lecSemester}학기`);
        $('#lecExModal #achieveGrade').val(achieveGrade);
        $('#lecExModal #userName').val(userName);
    });
	
	$("#lecExSubBtn").on("click",function(){
		let stuLecNo = $('#lecExModal #stuLecNo').val();
		let achieveGrade = $('#lecExModal #achieveGrade').val();
		let achExeptionCon = $("#achExCon").val();
		
		$("#achExCon").val("");
		
		data ={
			"stuLecNo" : stuLecNo,
			"achExeptionBefore" : achieveGrade,
			"achExeptionCon" : achExeptionCon
		}
		
		$.ajax({
			url:"/achieve/lecExeptionCreate",
			contentType:"application/json;charset=utf-8",
			data: JSON.stringify(data),
			type:"post",
			dataType:"json",
			beforeSend:function(xhr){
	               xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
	        },
	        success:function(result){
	        	console.log(result);
	        	Swal.fire({
                    position: "center",
                    icon: "success",
                    title: "이의신청 등록이 완료 되었습니다.",
                    timer: 1800,
                    showConfirmButton: false // 확인 버튼을 숨깁니다.
                  });
	    		$('#lecExModal').modal('hide');
	    		setTimeout(() => location.href = "/achieve/nowAch?menuId=cybAciChk", 1500);
	        }
		});
	});
	
	$(".achExeptionVOList").on("click",function(){
		
		let stuLecNo = $(this).data('stulecno');
		let lecName = $(this).data('lecname');
        let lecYear = $(this).data('lecyear');
        let lecSemester = $(this).data('lecsemester');
        let achExeptionCon = $(this).data('achexeptioncon');
        let achExepStat = $(this).data('achexepstat');
        let achExepAns = $(this).data('achexepans');
        
     	// 모달의 각 필드에 데이터 설정
        $('#lecExChkModal #stuLecNo').val(stuLecNo);
        $('#lecExChkModal #lecName').val(lecName);
        $('#lecExChkModal #lecYear').val(`\${lecYear}/\${lecSemester}학기`);
        $('#lecExChkModal #achExCon').val(achExeptionCon);
        $('#lecExChkModal #achExepStat').val(achExepStat);
        $('#lecExChkModal #achExAns').val(achExepAns);
        
        console.log('achExepStat >>',achExepStat);
        
        if(achExepStat!='대기'){
        	$("#exBtnArea").html('');
        }
        
	});
	
	// 이의신청 - 수정 버튼 
	$(document).on("click","#lecExUpdBtn",function(){
		lecExUpdBtn();
		
	});
	
	// 이의신청 - 수정 취소버튼 
	$(document).on("click","#lecExUpdCanBtn",function(){
		lecExUpdCanBtn();
	});
	
	
	$(document).on("click","#lecExUpdSubBtn",function(){
		console.log("수정 확인 버튼 클릭 ");
		
		let stuLecNo = $('#lecExChkModal #stuLecNo').val();
		let achExeptionCon = $("#lecExChkModal #achExCon").val();
		
		data = {
				"stuLecNo" : stuLecNo,
				"achExeptionCon" :achExeptionCon
		};
		
		$.ajax({
			url:"/achieve/lecExUpd",
			contentType:"application/json;charset=utf-8",
			data: JSON.stringify(data),
			type:"post",
			dataType:"json",
			beforeSend:function(xhr){
	               xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
	        },
	        success:function(result){
	        	Swal.fire({
                    position: "center",
                    icon: "success",
                    title: "이의신청 수정이 완료 되었습니다.",
                    timer: 1800,
                    showConfirmButton: false // 확인 버튼을 숨깁니다.
                  });
	    		$('#lecExModal').modal('hide');
	    		setTimeout(() => location.href = "/achieve/nowAch?menuId=cybAciChk", 1500);
	        }
		});
		
	});
	
	// 이의신청 삭제 버튼 클릭
	$(document).on("click","#lecExDelBtn",function(){
		
		let stuLecNo = $('#lecExChkModal #stuLecNo').val();
		
		Swal.fire({
		    title: '삭제하시겠습니까?',
		    text: "삭제 후 다시 신청하실 수 있습니다",
		    icon: 'warning',
		    showCancelButton: true,
		    confirmButtonColor: '#3085d6',
		    cancelButtonColor: '#d33',
		    confirmButtonText: '삭제',
		    cancelButtonText: '취소'
		}).then((result) => {
		    if (result.isConfirmed) {
		        $.ajax({
		            url : "/achieve/lecExDel",
		            contentType : "application/json;charset=utf-8",
		            data : stuLecNo,
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
		                        '이의신청이 삭제되었습니다.',
		                        'success'
		                    ).then(() => {
		                    	setTimeout(() => location.href = "/achieve/nowAch?menuId=cybAciChk", 800);
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
	$('#auto').on('click', function(){
		$('#achExCon').text('점수가 너무 낮은것같은데 한번 더 확인해주세요');
	})
});

function lecExUpdBtn(){
	let str = `
		<button type="button" id="lecExUpdSubBtn" class="btn btn-success">확인</button>
		<button type="button" id="lecExUpdCanBtn" class="btn btn-secondary">취소</button>
	`;
	$("#lecExChkModal #achExCon").removeAttr("readonly");
	$("#exBtnArea").html(str);
}
  
function lecExUpdCanBtn(){
	let str = `
		<button type="button" id="lecExUpdBtn" class="btn btn-warning">수정</button>
        <button type="button" id="lecExDelBtn" class="btn btn-danger">삭제</button>
	`;
	$("#lecExChkModal #achExCon").attr("readonly",true);
	$("#exBtnArea").html(str);
} 
</script>

<div id="wrap">
	<div class="h3Box" style="height:50px;">
		<h3 style="color:black;">현재 성적 조회</h3>
	</div>
	<div class="row" style="margin-top:40px; margin-bottom:50px;">
		<div class="col-12">
		<%
	    	Date date = new Date();
	    	SimpleDateFormat simpleDateYYYY = new SimpleDateFormat("yyyy");
	    	SimpleDateFormat simpleDateMM = new SimpleDateFormat("MM");
	    	String strYear = simpleDateYYYY.format(date);
	    %>
			<h5 style="color:black;"><%=strYear %>년도 1학기(${studentVO.stGrade}학년-정시학기)</h5>
		</div>
		<div class="col-12">
			<div class="card">
				<div class="card-body table-responsive p-0">
					<table class="table text-nowrap text-center">
						<thead> 
							<tr style="color:black;">
								<th>신청학점</th>
								<th>취득학점</th>
								<th>평점계</th>
								<th>평점평균</th>
								<th>백분위</th>
								<th>석차</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>${appScore}</td>
								<td>${achScore}</td>
								<td>${ttAvg}</td>
								<td>${avgAch}</td>
								<td>${percentage}</td>
								<td>${rank}/${count}</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-12">
			<div class="card">
				<div class="card-body table-responsive p-0" style="height: 300px;">
					<form id="formAch" action="/achieve/lecEvaluation?menuId=cybAciChk" method="post">
						<input type="hidden" name="stuLecNo"/>
						<sec:csrfInput />
					</form>
					<table class="table table-head-fixed text-nowrap">
						<thead class="bg-green">
							<tr class="text-center" style="color:black;">
								<th>수강코드</th>
								<th>과목명</th>
								<th>학점</th>
								<th>이수구분</th>
								<th>등급</th>
								<th>이의신청</th>
								<th>강의평가</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="stuLectureVO" items="${stuLectureVOList}" varStatus="stat">
									<tr id="${stuLectureVO.stuLecNo}">
										<td class="text-center">${stuLectureVO.stuLecNo}</td>
										<td>${stuLectureVO.lectureVOList.lecName}</td>
										<td class="text-center">${stuLectureVO.lectureVOList.lecScore}학점</td>
										<td class="text-center">${stuLectureVO.lectureVOList.lecDiv}</td>
										<td class="text-center">${stuLectureVO.achievementVO.achieveGrade}</td>
										<c:if test="${stuLectureVO.exepYn eq 'Y'}">
										<td class="text-center"><button type="button" class="btn btn-outline-secondary disabled">신청완료</button></td>
										</c:if>
										<c:if test="${stuLectureVO.exepYn eq 'N'}">
										<td class="text-center"><button type="button" class="btn btn-outline-warning exBtn" data-toggle="modal" data-target="#lecExModal"
										data-stulecno="${stuLectureVO.stuLecNo}" 
					                    data-lecname="${stuLectureVO.lectureVOList.lecName}" 
					                    data-lecyear="${stuLectureVO.lectureVOList.lecYear}" 
					                    data-lecsemester="${stuLectureVO.lectureVOList.lecSemester}" 
					                    data-achievegrade="${stuLectureVO.achievementVO.achieveGrade}"
					                    data-username="${stuLectureVO.userInfoVO.userName}">이의신청</button></td>
					                    </c:if>
										<c:if test="${stuLectureVO.evalYn eq 'Y'}">
										<td class="text-center"><button type="button" class="btn btn-outline-secondary disabled">평가완료</button></td>
										</c:if>
										<c:if test="${stuLectureVO.evalYn eq 'N'}">
										<td class="text-center"><button type="button" class="btn btn-outline-primary evBtn">강의평가</button></td>
										</c:if>
									</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
	<div class="h3Box" style="margin-top:40px;">
		<h3>학적이의신청 목록</h3>
	</div>
	<div class="row">
		<div class="col-12">
			<div class="card timeline">
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
					상세보기를 볼 경우 아래 과목을 선택하세요
				</div>
				<div class="card-body table-responsive p-0">
					<table class="table table-head-fixed text-nowrap">
						<thead class="text-center">
							<tr style="color:black;">
								<th>수강코드</th>
								<th>과목명</th>
								<th>학점</th>
								<th>이수구분</th>
								<th>등급</th>
								<th>이의신청</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${empty achExeptionVOList}">
								<tr class="text-center">
									<td colspan="6">등록된 이의신청이 없습니다</td>
								</tr>
							</c:if>
							<c:if test="${not empty achExeptionVOList}">
								<c:forEach var="achExeptionVO" items="${achExeptionVOList}" varStatus="stat">
									<tr class="achExeptionVOList pointer" data-toggle="modal" data-target="#lecExChkModal"
									data-stulecno="${achExeptionVO.stuLecNo}"
									data-lecyear="${achExeptionVO.lectureVO.lecYear}"
									data-lecsemester="${achExeptionVO.lectureVO.lecSemester}"
									data-lecname="${achExeptionVO.lectureVO.lecName}"
									data-achexeptioncon="${achExeptionVO.achExeptionCon}"
									data-achexepstat="${achExeptionVO.achExepStat}"
									data-achexepans="${achExeptionVO.achExepAns}"
									>
										<td class="text-center">${achExeptionVO.stuLecNo}</td>
										<td>${achExeptionVO.lectureVO.lecName}</td>
										<td class="text-center">${achExeptionVO.lectureVO.lecScore}학점</td>
										<td class="text-center">${achExeptionVO.lectureVO.lecDiv}</td>
										<td class="text-center">${achExeptionVO.achExeptionBefore}</td>
										<c:if test="${achExeptionVO.achExepStat eq '대기'}">
											<td style="color:green;" class="text-center">${achExeptionVO.achExepStat}</td>
										</c:if>
										<c:if test="${achExeptionVO.achExepStat eq '승인'}">
											<td style="color:blue;" class="text-center">${achExeptionVO.achExepStat}</td>
										</c:if>
										<c:if test="${achExeptionVO.achExepStat eq '반려'}">
											<td style="color:red;" class="text-center">${achExeptionVO.achExepStat}</td>
										</c:if>
									</tr>
								</c:forEach>
							</c:if>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		
		<!-- 모달 시작 -->
		<div class="modal fade" id="lecExModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog modal-dialog-centered">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalLabel">이의 신청</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <div class="modal-body flex">
				<p>
					<span class="mSpan" readonly>년도/학기</span>
					<span><input type="text" id="lecYear" class="form-control" style="display:inline-block; width: 25%;"></span>
					<span class="mSpan" style="margin-left: 21px;">현재성적</span>
					<span><input type="text" id="achieveGrade" class="form-control" style="display:inline-block; width:25%" readonly></span>
				</p>
				<p>
					<span class="mSpan">수강코드</span>
					<span><input type="text" id="stuLecNo" class="form-control" style="display:inline-block; width:75%" readonly></span>
				</p>
				<p>
					<span class="mSpan">강의명</span>
					<span><input type="text" id="lecName" class="form-control" style="display:inline-block; width:75%" readonly></span>
				</p>
				<p>
					<span class="mSpan">교수명</span>
					<span><input type="text" id="userName" class="form-control" style="display:inline-block; width:75%" readonly></span>
				</p>
				<p>
					<p>내용</p>
					<span>
						<textarea rows="5" class="form-control" id="achExCon"></textarea>
					</span>
				</p>
		      </div>
		      <div class="modal-footer">
		      	<button type="button" class="btn btn-outline-light" id="auto">자동 완성</button>
		        <button type="button" id="lecExSubBtn" class="btn btn-outline-primary">신청 등록</button>
		      </div>
		    </div>
		  </div>
		</div>
		<!-- 모달 끝 -->
		
		<!-- 이의신청조회 모달 시작 -->
		<div class="modal fade" id="lecExChkModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog modal-dialog-centered">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalLabel">이의 신청</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <div class="modal-body flex">
				<p>
					<span class="mSpan">년도/학기</span>
					<span><input type="text" id="lecYear" class="form-control" style="display:inline-block; width: 25%;" readonly></span>
					<span class="mSpan" style="margin-left: 21px;">신청 상태</span>
					<span><input type="text" id="achExepStat" class="form-control" style="display:inline-block; width:25%" readonly></span>
				</p>
				<p>
					<span class="mSpan">수강코드</span>
					<span><input type="text" id="stuLecNo" class="form-control" style="display:inline-block; width:75%" readonly></span>
				</p>
				<p>
					<span class="mSpan">강의명</span>
					<span><input type="text" id="lecName" class="form-control" style="display:inline-block; width:75%" readonly></span>
				</p>
				<p>
					<p>내용</p>
					<span>
						<textarea rows="3" class="form-control" id="achExCon" readonly></textarea>
					</span>
				</p>
				<p>
					<p>답변</p>
					<span>
						<textarea rows="3" class="form-control" id="achExAns" readonly></textarea>
					</span>
				</p>
		      </div>
		      <div class="modal-footer" id="exBtnArea">
		        <button type="button" id="lecExUpdBtn" class="btn btn-outline-warning">수정</button>
		        <button type="button" id="lecExDelBtn" class="btn btn-outline-danger">삭제</button>
		      </div>
		    </div>
		  </div>
		</div>
		<!-- 모달 끝 -->
	</div>
</div>
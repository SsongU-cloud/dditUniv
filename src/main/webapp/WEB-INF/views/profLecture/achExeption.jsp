<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<style>
#wrap {
	margin: 0 auto;
	width: 95%;
}

#tableWrap {
	display: flex;
	justify-content: space-around;
}

.h3Box {
	color: black;
	margin-bottom: 30px;
	margin-top: 40px;
}

.box {
	display: flex;
	justify-content: space-between;
}

.table.table-head-fixed thead tr:nth-child(1) th {
	background-color: #ebf1e9;
	border-bottom: 0;
	box-shadow: inset 0 1px 0 #dee2e6, inset 0 -1px 0 #dee2e6;
	position: sticky;
	top: 0;
	z-index: 10;
}

.pointer {
	cursor: pointer;
}

.back_white {
	background-color: white;
}

.mSpan {
	display: inline-block;
	width: 86px;
}

.marginTop{
	margin-top: 10px;
}
</style>
<script>
const dhGrade = [
	{  grd:"A+", pnt:"4.5"},
	{  grd:"A", pnt:"4.0"},
	{  grd:"B+", pnt:"3.5"},
	{  grd:"B", pnt:"3.0"},
	{  grd:"C+", pnt:"2.5"},
	{  grd:"C", pnt:"2.0"},
	{  grd:"D+", pnt:"1.5"},
	{  grd:"D", pnt:"1.0"},
	{  grd:"F", pnt:"0"}
];

let optStr ="";
for(let grade of dhGrade){
	optStr +=`<option id="\${grade.pnt}" value="\${grade.grd}" >\${grade.grd}</option>`;
}

$(function(){
	$(".exList").on("click",function(){
		
		let stuLecNo = $(this).data('stulecno');
		let stNo = $(this).data('stno');
		let lecNo = $(this).data('lecno');
		let lecName = $(this).data('lecname');
		let lecYear = $(this).data('lecyear');
        let lecSemester = $(this).data('lecsemester');
        let achExeptionCon = $(this).data('achexeptioncon');
        let achExepStat = $(this).data('achexepstat');
        let achExepAns = $(this).data('achexepans');
        let userName = $(this).data('username');
		
        console.log("achExepAns : ",achExepAns);
        
        $.ajax({
        	url:"/profLecture/achExepDetail",
			contentType:"application/json;charset=utf-8",
			data: stuLecNo,
			type:"post",
			dataType:"json",
			beforeSend:function(xhr){
	               xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
	        },
	        success:function(result){
	        	console.log("result >> ",result);
	        	console.log("result.stNo >> ",result.stNo);
	        	let str =`
	    			<tr>
	    				<td>1</td>
	    				<td>\${result.stNo}</td>
	    				<td>\${result.userInfoVO.userName}</td>
	    				<td>\${result.comDetCodeVO.comDetCodeName}</td>
	    				<td>\${result.studentVO.stGrade}</td>
					`;
	        	
				if(result.stuLecReYn == 'Y'){
					str += `<td>○</td>`
				}else{
					str += `<td>-</td>`
				}

				let attScore = result.attScore;
	    		let assigScore = result.assigSituVO.assigScore;
	    		let middleTestScore = result.stuTestResVO.middleTestScore;
	    		let endTestScore = result.stuTestResVO.endTestScore;
	    		
	    		let ttScore = attScore+assigScore+middleTestScore+endTestScore;
	    		
	    		let achScore = result.achievementVO.achieveScore;
	    		
	    		if(result.achievementVO.achieveScore%1 == 0){
	    			achScore = result.achievementVO.achieveScore+".0";
	    		}
	    		if(achExepStat == '대기'){
	    			
	    		}
	    		str +=	`
	    				<td id="attScore">\${attScore}</td>
	    				<td><input type="number" class="form-control text-center score" id="assigScore" value="\${assigScore}" style="width:66px"/></td>
	    				<td><input type="number" class="form-control text-center score" id="middleTestScore"  value="\${middleTestScore}" style="width:66px"/></td>
	    				<td><input type="number" class="form-control text-center score" id="endTestScore" value="\${endTestScore}" style="width:66px"/></td>
	    				<td id="ttScore">\${ttScore}</td>
	    				<td>
		       				<select id="gradeSelect" class="form-control gradeSelect score">
		       					<option></option>
								\${optStr}
		       				</select>
        				</td>
	    				<td id="fGrade">\${achScore}</td>
	    			</tr>
	    			`;
	    			
	        	$("#achievement").html(str);
	        	
        		if(result.achievementVO.achieveGrade == null){
		        	$(`#gradeSelect`).val("").prop("selected",true);
        		} else {
        			console.log("achieveGrade >> ",result.achievementVO.achieveGrade);
		        	$(`#gradeSelect`).val(result.achievementVO.achieveGrade).prop("selected",true);
		        	grade = $(`#gradeSelect option:selected`).attr("id");
        		}
        		
        		if(achExepStat != '대기'){
        			$(`.score`).prop("readonly",true);
        			$("#achExAnsCon").prop("readonly",true);
        			$(".btnBox").html("");
        			$("#gradeSelect").css("background-color", "#EAECF4");
        			$("#gradeSelect").css("pointer-events", "none");
        		}
	        }
        });
        
        $("#exStatSelect").val(achExepStat).prop("selected", true);
        
		$("#lecYear").val(lecYear+"/"+lecSemester+"학기");
		$("#stuLecNo").val(stuLecNo);
		$("#lecName").val(lecName);
		$("#stuNo").val(stNo);
		$("#userName").val(userName);
		$("#achExCon").val(achExeptionCon);
		$("#achExAnsCon").val(achExepAns);
	});
	
	// 등급 변경 했을때 최종점수 변경
	$(document).on("change",".gradeSelect",function(){
		let grade = $(`#gradeSelect option:selected`).attr("id");
		$(`#fGrade`).text(grade);
		//console.log("grade >>>>>>>>> ",grade);
	});
	
	// 과제, 중간, 기말 점수 입력했을 때 
	$(document).on("input","#assigScore, #middleTestScore, #endTestScore",function(){
		
		let index = $(this).closest('tr').index() + 1;
        let attScore = Number($(`#attScore`).text());
        let assigScore = parseFloat($(`#assigScore`).val()) || 0;
        let middleTestScore = parseFloat($(`#middleTestScore`).val()) || 0;
        let endTestScore = parseFloat($(`#endTestScore`).val()) || 0;
     	
        // 입력한 값 정규화
        // 과제점수
		if(assigScore<0||assigScore>20){
			const Toast = Swal.mixin({
	    		  toast: true,
	    		  position: "top-end",
	    		  showConfirmButton: false,
	    		  timer: 3000,
	    		  timerProgressBar: true,
	    		  didOpen: (toast) => {
	    		    toast.onmouseenter = Swal.stopTimer;
	    		    toast.onmouseleave = Swal.resumeTimer;
	    		  }
	    		});
	    		Toast.fire({
	    		  icon: "warning",
	    		  title: "과제 점수는 0에서 20사이의 숫자를 입력해주세요"
	    		});
	    	$(`#assigScore`).val(0);
	    	return;
		}
		if(middleTestScore<0||middleTestScore>35){
			const Toast = Swal.mixin({
	    		  toast: true,
	    		  position: "top-end",
	    		  showConfirmButton: false,
	    		  timer: 3000,
	    		  timerProgressBar: true,
	    		  didOpen: (toast) => {
	    		    toast.onmouseenter = Swal.stopTimer;
	    		    toast.onmouseleave = Swal.resumeTimer;
	    		  }
	    		});
	    		Toast.fire({
	    		  icon: "warning",
	    		  title: "중간 점수는 0에서 35사이의 숫자를 입력해주세요"
	    		});
	    	$(`#middleTestScore`).val(0);
	    	return;
		}
		if(endTestScore<0||endTestScore>35){
			const Toast = Swal.mixin({
	    		  toast: true,
	    		  position: "top-end",
	    		  showConfirmButton: false,
	    		  timer: 3000,
	    		  timerProgressBar: true,
	    		  didOpen: (toast) => {
	    		    toast.onmouseenter = Swal.stopTimer;
	    		    toast.onmouseleave = Swal.resumeTimer;
	    		  }
	    		});
	    		Toast.fire({
	    		  icon: "warning",
	    		  title: "기말 점수는 0에서 35사이의 숫자를 입력해주세요"
	    		});
	    	$(`#endTestScore`).val(0);
	    	return;
		}

		// 총점 구하기
        let ttScore = attScore + assigScore + middleTestScore + endTestScore;
        //console.log("ttScore >>>>>>>>>", ttScore);

        $(`#ttScore`).text(ttScore);
	});
	
	// 이의신청 데이터 전송
	$("#lecExSubBtn").on("click",function(){
		let exStat = $("#exStatSelect option:selected").val();
		let achExAnsCon = $("#achExAnsCon").val();
		console.log("achExAnsCon >> ",achExAnsCon);
		
		// 이의신청 답변 내용 비어있을 경우 return
		if(achExAnsCon == null || achExAnsCon == ""){
			const Toast = Swal.mixin({
	    		  toast: true,
	    		  position: "top-end",
	    		  showConfirmButton: false,
	    		  timer: 1800,
	    		  timerProgressBar: true,
	    		  didOpen: (toast) => {
	    		    toast.onmouseenter = Swal.stopTimer;
	    		    toast.onmouseleave = Swal.resumeTimer;
	    		  }
	    		});
				Toast.fire({
	    		  icon: "warning",
	    		  title: "답변 입력 후 저장 가능합니다."
	    		});
			$("#achExAnsCon").focus();
			return;
		}else {
			if(exStat == '대기'){
				const Toast = Swal.mixin({
		    		  toast: true,
		    		  position: "top-end",
		    		  showConfirmButton: false,
		    		  timer: 1800,
		    		  timerProgressBar: true,
		    		  didOpen: (toast) => {
		    		    toast.onmouseenter = Swal.stopTimer;
		    		    toast.onmouseleave = Swal.resumeTimer;
		    		  }
		    		});
		    		Toast.fire({
		    		  icon: "warning",
		    		  title: "이의신청 상태를 변경해주세요."
		    		});
		    	return;
			}
			// 이의신청 답변  , 상태 수정 
			let stuLecNo = $(`#stuLecNo`).val();
			let data ={
				"stuLecNo": stuLecNo,
				"achExepAns":achExAnsCon,
				"achExepStat":exStat
			}
			console.log("data >> ",data);
			
			$.ajax({
				url:"/profLecture/achExepStatUpdate",
				processData:false,
				contentType: "application/json",
		        data: JSON.stringify(data),
				type:"post",
				dataType:"text",
				beforeSend:function(xhr){
		               xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		        },
				success:function(result){
					console.log("result : ",result);
				  	Swal.fire({
	                     position: "center",
	                     icon: "success",
	                     title: "등록완료 되었습니다.",
	                     timer: 1800,
	                     showConfirmButton: false // 확인 버튼을 숨깁니다.
	                   });
				}
			});
			
			if(exStat = '승인'){
		        let stuLecNo = $(`#stuLecNo`).val();	
			    let attScore = $(`#attScore`).text();
			    let assigScore = $(`#assigScore`).val();
			    let middleTestScore = $(`#middleTestScore`).val();
			    let endTestScore = $(`#endTestScore`).val();
			    let achieveGrade = $(`#gradeSelect option:selected`).val();
			    let achieveScore = Number($(`#fGrade`).text())
				
				let stuLectureVO = {
		            "stuLecNo": stuLecNo,
		            "assigSituVO": {
		                "assigScore": assigScore
		            },
		            "stuTestResVO": {
		            	"middleTestScore": middleTestScore,
		            	"endTestScore":endTestScore
		            },
		            "achievementVO": {
		            	"achieveGrade":achieveGrade,
		            	"achieveScore":achieveScore
		            }
		        };
			    
			    // 성적 수정 ajax
			    $.ajax({
					url:"/profLecture/achExepUpdate",
					processData:false,
					contentType: "application/json",
			        data: JSON.stringify(stuLectureVO),
					type:"post",
					dataType:"text",
					beforeSend:function(xhr){
			               xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			        },
					success:function(result){
						console.log("result : ",result);
						location.href = "/profLecture/achExeption?menuId=lecAchAtt";
					}
				});
			} // 성적 수정 else if end
		}
	});
	
	$('#auto').on('click', function(){
		$('#exStatSelect').val('반려')
		$('#achExAnsCon').html('기말고사 점수가 안좋습니다. 학점 변동은 없습니다')
	})
});
</script>
<div id="wrap">
	<div class="h3Box" style="height: 50px;">
		<h3 style="color: black;">성적 이의 신청 관리</h3>
	</div>
	<div id="tableWrap">
		<div style="width: 1013.86px">
			<div class="box">
				<h5 class="card-title" style="color:black;">성적이의신청 목록</h5>
				<div class="card-tools">
					<div class="input-group input-group-sm" style="width: 150px;">
						<select class="form-control">
							<option>최신순</option>
							<option>강의이름순</option>
							<option>학생이름순</option>
						</select>
					</div>
				</div>
			</div>
			<div class="table-responsive back_white" style="height: 500px;">
				<table class="table table-head-fixed text-nowrap table-hover ">
					<colgroup>
						<col width="5%" />
						<col width="12%" />
						<col width="12%" />
						<col width="12%" />
						<col width="*" />
						<col width="10%" />
						<col width="10%" />
						<col width="10%" />
					</colgroup>
					<thead>
						<tr class="text-center" style="color:black;">
							<th>번호</th>
							<th>년도 / 학기</th>
							<th>신청일자</th>
							<th>강의번호</th>
							<th>강의명</th>
							<th>학번</th>
							<th>이름</th>
							<th>승인여부</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="achExeptionVO" items="${achExeptionVOList}"
							varStatus="stat">
							<tr class="pointer exList"
								data-stulecno="${achExeptionVO.stuLecNo}"
								data-stno="${achExeptionVO.stuLectureVO.stNo}"
								data-lecno="${achExeptionVO.lectureVO.lecNo}"
								data-lecname="${achExeptionVO.lectureVO.lecName}"
								data-lecyear="${achExeptionVO.lectureVO.lecYear}"
								data-lecsemester="${achExeptionVO.lectureVO.lecSemester}"
								data-achexeptioncon="${achExeptionVO.achExeptionCon}"
								data-achexepstat="${achExeptionVO.achExepStat}"
								data-achexepans="${achExeptionVO.achExepAns}"
								data-username="${achExeptionVO.userInfoVO.userName}">
								<td class="text-center">${stat.index+1}</td>
								<td class="listLecSemseter text-center">${achExeptionVO.lectureVO.lecYear}/${achExeptionVO.lectureVO.lecSemester}학기</td>
								<td class="text-center">${achExeptionVO.achExepAppDate}</td>
								<td class="listLecNo text-center">${achExeptionVO.lectureVO.lecNo}</td>
								<td>${achExeptionVO.lectureVO.lecName}</td>
								<td class="text-center">${achExeptionVO.stuLectureVO.stNo}</td>
								<td class="text-center">${achExeptionVO.userInfoVO.userName}</td>
								<c:if test="${achExeptionVO.achExepStat eq '대기'}">
								<td class="text-center" style="color: green;">${achExeptionVO.achExepStat}</td>
								</c:if>
								<c:if test="${achExeptionVO.achExepStat eq '승인'}">
								<td class="text-center" style="color: blue;">${achExeptionVO.achExepStat}</td>
								</c:if>
								<c:if test="${achExeptionVO.achExepStat eq '반려'}">
								<td class="text-center" style="color: red;">${achExeptionVO.achExepStat}</td>
								</c:if>
								
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div>
				<div class="box marginTop">
					<h5 class="card-title" style="color:black;">학생 기존 성적</h5>
					<span>* 과제 : 20점 / 중간 : 35점 / 기말 : 35점</span>
				</div>
				<table
					class="table back_white table-head-fixed text-nowrap text-center">
					<thead>
						<tr style="color:black;">
							<th>번호</th>
							<th>학번</th>
							<th>이름</th>
							<th>학과</th>
							<th>학년</th>
							<th>재수강</th>
							<th>출결</th>
							<th>과제</th>
							<th>중간</th>
							<th>기말</th>
							<th>총점</th>
							<th>성적</th>
							<th>최종점수</th>
						</tr>
					</thead>
					<tbody id="achievement">
						<tr>
							<td colspan="13">이의신청 목록 선택시 성적 출력</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div style="width: 500px; height: 500px;">
			<div class="box">
				<h5 class="card-title" style="color:black;">학생 이의신청 내용</h5>
			</div>
			<div class="card card-row card-success" style="height: 647px;">
				<div class="card-body">
					<p>
						<span class="mSpan">년도/학기</span> 
						<span><input type="text"
							id="lecYear" class="form-control"
							style="display: inline-block; width: 51%;" readonly></span> 
						<span class="mSpan" style="margin-left: 21px;"> 
							<select id="exStatSelect" class="form-control">
								<option value="대기">대기</option>
								<option value="승인">승인</option>
								<option value="반려">반려</option>
							</select>
						</span>
					</p>
					<p>
						<span class="mSpan">수강코드</span> <span><input type="text"
							id="stuLecNo" class="form-control"
							style="display: inline-block; width: 75%" readonly></span>
					</p>
					<p>
						<span class="mSpan">강의명</span> <span><input type="text"
							id="lecName" class="form-control"
							style="display: inline-block; width: 75%" readonly></span>
					</p>
					<p>
						<span class="mSpan">학번</span> <span><input type="text"
							id="stuNo" class="form-control"
							style="display: inline-block; width: 75%" readonly></span>
					</p>
					<p>
						<span class="mSpan">이름</span> <span><input type="text"
							id="userName" class="form-control"
							style="display: inline-block; width: 75%" readonly></span>
					</p>
					<p>
					<p>내용</p>
					<span> <textarea rows="3" class="form-control" id="achExCon"
							readonly></textarea>
					</span>
					</p>
					<p>
					<p>답변</p>
					<span> <textarea rows="4" class="form-control" id="achExAnsCon"></textarea>
					</span>
					</p>
					<div class="btnBox" style="display: flex; justify-content: center; position:relative; left:50px;">
						<button type="button" id="lecExSubBtn" class="btn btn-outline-success" >확인</button>
						<button type="button" class="btn btn-outline-light" id="auto">자동 완성</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
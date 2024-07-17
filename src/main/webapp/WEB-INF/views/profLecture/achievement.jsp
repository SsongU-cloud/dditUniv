<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<style>
	#wrap{
	    margin: 50px auto;
	    width: 80%;
	}
	.marginAuto{
		margin: 0px auto;
	}
	.table.table-head-fixed thead tr:nth-child(1) th {
		background-color:#ebf1e9;
		  border-bottom: 0;
		  box-shadow: inset 0 1px 0 #dee2e6, inset 0 -1px 0 #dee2e6;
		  position: sticky;
		  top: 0;
		  z-index: 10;
	}
	.tableWrap{
		height: 500px;
	}
	
	.scoreInput{
		width: 100px;
    	margin: 0 auto;
	}
	
	.flexBetween{
		display: flex;
   	    justify-content: space-between;
	}
	.subBtnWrap{
		display: flex;
		justify-content: center;
		margin-top: 20px;
	}
</style>
<script>
// DB에 넣지 않을 거면 요따구 상수를 선언해서 사용합시당.
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
	// 강의 선택했을때 
	$("#lectureNo").on("change",function(){
		let lectureNo = $("#lectureNo option:selected").val();
		console.log("lectureNo >>>>>",lectureNo);
		
		// 강의 정보 출력
		$.ajax({
			url:"/profLecture/achLectureDetail",
			contentType:"application/json;charset=utf-8",
			data: lectureNo,
			type:"post",
			dataType:"json",
			beforeSend:function(xhr){
	               xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
	        },
	        success:function(result){
	        	let str = "";
	        	console.log("강의 정보 : ",result);
	        	
	        	str += `
	        		<td>\${result.lecName}</td>
	        		`;
	        	if(result.lecGrade == null || result.lecGrade == 0){
	        		str += `<td>전학년</td>`;
	        	}else{
					str += `<td>\${result.lecGrade}학년</td>`;
	        	}
	        	str += `
					<td>\${result.lecScore}학점</td>
					<td>\${result.stuCount}명</td>
	        	`;
	        	
	        	$("#lecDetail").html(str);
	        }
		});
		
		// 수강생 목록 출력
		$.ajax({
			url:"/profLecture/stuLetureList",
			contentType:"application/json;charset=utf-8",
			data: lectureNo,
			type:"post",
			dataType:"json",
			beforeSend:function(xhr){
	               xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
	        },
	        success:function(result){
	        	let str = "";
	        	console.log("result : ",result);
	        	// 수강생 목록 출력하는 each
	        	$.each(result, function(idx,data) {
	        		str += `<tr class="stu">
	        			<input type="hidden" name="stuLecNo" id="stuLecNo\${idx+1}"
	        				value="\${data.stuLecNo}" />
	        			<td class="text-center">\${idx+1}</td>
	        			<td class="text-center">\${data.stNo}</td>
	        			<td class="text-center">\${data.userInfoVO.userName}</td>
	        			<td class="text-center">\${data.comDetCodeVO.comDetCodeName}</td>
	        			<td class="text-center">\${data.studentVO.stGrade}</td>`;
	        		
		        	if(data.stuLecReYn=='N'){
		        		str += `<td class="text-center">-</td>`;
		        	}else{
		        		str += `<td class="text-center">O</td>`;
		        	}
		        	
	        		str += `<td id="attScore\${idx+1}" class="text-center">\${data.attScore}</td>
	        				<td><input type="number" id="assigScore\${idx+1}" class="assigScore form-control scoreInput text-right" 
	        				name="assigScore" value="\${data.assigSituVO.assigScore}"></td>
	        				<td><input type="number" id="middleTestScore\${idx+1}" class="middleTestScore form-control scoreInput text-right" 
	        				name="middleTestScore" value="\${data.stuTestResVO.middleTestScore}"></td>
	        				<td><input type="number" id="endTestScore\${idx+1}" class="endTestScore form-control scoreInput text-right" 
	        				name="endTestScore" value="\${data.stuTestResVO.endTestScore}"></td>
	        				<td id="ttScore\${idx+1}" class="ttScore text-center">\${data.attScore}</td>
	        				<td class="text-center">
	        				<select id="gradeSelect\${idx+1}" class="form-control gradeSelect">
	        					<option></option>
								\${optStr}
	        				</select>
	        				</td>
	        				<td id="fGrade\${idx+1}" class="text-center"></td>
	        				</tr>`;
	        	});
	        	$("#stuList").html(str);
	        	// 가져온 값과 일치하는 등급으로 셀렉트 
	        	$(".gradeSelect").each(function(idx,data) {
	        		let grade = "";
	        		if(result[idx].achievementVO.achieveGrade == null){
			        	$(`#gradeSelect\${idx+1}`).val("").prop("selected",true);
	        		}else{
			        	$(`#gradeSelect\${idx+1}`).val(`\${result[idx].achievementVO.achieveGrade}`).prop("selected",true);
			        	grade = $(`#gradeSelect\${idx+1} option:selected`).attr("id");
	        		}
		        	
		        	$(`#fGrade\${idx+1}`).text(grade);
				});
	        	
	        	$(".stu").each(function(idx){
	        		let attScore = parseFloat($(`#attScore\${idx}`).text());
	                let assigScore = parseFloat($(`#assigScore\${idx}`).val()) || 0;
	                let middleTestScore = parseFloat($(`#middleTestScore\${idx}`).val()) || 0;
	                let endTestScore = parseFloat($(`#endTestScore\${idx}`).val()) || 0;
	             	// 총점 구하기
	                let ttScore = attScore + assigScore + middleTestScore + endTestScore;
	                //console.log("ttScore >>>>>>>>>", ttScore);

	                $(`#ttScore\${idx}`).text(ttScore);
	        	});
	        }
		}); 
		
	});
	
	// 과제, 중간, 기말 점수 입력했을 때 
	$(document).on("input",".assigScore, .middleTestScore, .endTestScore",function(){
		
		let index = $(this).closest('tr').index() + 1;
        let attScore = Number($(`#attScore\${index}`).text());
        let assigScore = parseFloat($(`#assigScore\${index}`).val()) || 0;
        let middleTestScore = parseFloat($(`#middleTestScore\${index}`).val()) || 0;
        let endTestScore = parseFloat($(`#endTestScore\${index}`).val()) || 0;
     	
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
	    	$(`#assigScore\${index}`).val("");
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
	    	$(`#middleTestScore\${index}`).val("");
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
	    	$(`#endTestScore\${index}`).val("");
	    	return;
		}

		// 총점 구하기
        let ttScore = attScore + assigScore + middleTestScore + endTestScore;
        //console.log("ttScore >>>>>>>>>", ttScore);

        $(`#ttScore\${index}`).text(ttScore);
	});
	
	// 등급 변경 했을때 최종점수 변경
	$(document).on("change",".gradeSelect",function(){
		let index = $(this).closest('tr').index() + 1;
		let grade = $(`#gradeSelect\${index} option:selected`).attr("id");
		$(`#fGrade\${index}`).text(grade);
		//console.log("grade >>>>>>>>> ",grade);
	});
	
	$("#submit").on("click",function(){
		let stuLan = $(".stu").length;
		console.log("학생 수 : ",stuLan);
		
		let stuLectureVOList = [];
		
		//let formData = new FormData();
		
		$(".stu").each(function(idx,data){
		    let stuLecNo = $(`#stuLecNo\${idx+1}`).val();	
		    let attScore = $(`#attScore\${idx+1}`).text();
		    let assigScore = $(`#assigScore\${idx+1}`).val();
		    let middleTestScore = $(`#middleTestScore\${idx+1}`).val();
		    let endTestScore = $(`#endTestScore\${idx+1}`).val();
		    let achieveGrade = $(`#gradeSelect\${idx+1} option:selected`).val();
		    let achieveScore = $(`#fGrade\${idx+1}`).text();
		    if(achieveScore==""||achieveScore==null){
		    	achieveScore = 0;
		    }
			
			stuLectureVOList.push({
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
	        });
		});
		
		$.ajax({
			url:"/profLecture/achieveInsert",
			processData:false,
			contentType: "application/json",
	        data: JSON.stringify(stuLectureVOList),
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
	});
	
});
</script>
<sec:authentication property="principal.userInfoVO" var="userInfoVO" />
<h3 class="marginAuto" style="width:80%; color:black;">학생 성적 입력</h3>
<div id="wrap" class="marginAuto">
	<div>
		<p class="flexBetween">
			<select id="lectureNo" class="form-control w-25">
				<option>- 강의 목록 선택</option>
				<c:forEach var="lectureVO" items="${lectureVOList}" varStatus="stat">
					<option value="${lectureVO.lecNo}">${lectureVO.lecName}</option>
				</c:forEach>
			</select>
			<span>* 과제 : 20점 / 중간 : 35점 / 기말 : 35점</span>
		</p>
		<div class="card-body table-responsive p-0" style="background-color:white;margin-bottom:30px;" >
			<table class="table table-head-fixed text-nowrap text-center">
				<colgroup>
					<col width="*"/>
					<col width="20%"/>
					<col width="20%"/>
					<col width="20%"/>
				</colgroup>
				<thead>
					<tr style="color:black;">
						<th>강의명</th>
						<th>학년</th>
						<th>학점</th>
						<th>수강인원</th>
					</tr>
				</thead>
				<tbody>
					<tr id="lecDetail">
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="card-body table-responsive p-0" style="height: 500px; background-color:white;">
			<table class="table table-head-fixed text-nowrap">
				<thead>
					<tr style="color:black;" class="text-center">
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
				<tbody id="stuList">
				</tbody>
			</table>
		</div>
		<div class="subBtnWrap">
			<button id="submit" type="button" class="btn btn btn-outline-success col-md-1">등록</button>
		</div>
	</div>
</div>
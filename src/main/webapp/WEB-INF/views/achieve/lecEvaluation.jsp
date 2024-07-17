<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
#wrap{
	margin: 0 auto;
	width : 80%;
}
.back_green{
	background-color: #ebf1e9;
}
.back_white{
	background-color: white;
}
.margin2{
    margin: 2px;
}
.h3Box{
	color: black;
    margin-bottom: 30px;
    margin-top: 40px;
}

</style>
<script>
$(function(){
	$("#subBtn").on("click",function(){
		let lecEvaluationVOList = [];
		let ques = document.querySelectorAll(".que");
		let queSubs = document.querySelectorAll(".queSub");
		let stuLecNo = `${stuLectureVO.stuLecNo}`;
		
		console.log("stuLecNo >> ",stuLecNo)
		
	    for(let i=0; i<ques.length; i++){
	        let que = ques[i];
	        let code = que.dataset.code;
	        
	        let radioChk = validateRadio(que.querySelectorAll(`[name=\${code}]`));
	        
	        console.log("radioChk >> ",radioChk)
	        if(!radioChk){
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
	  	 		  title: "빈 칸 없이 모두 체크해주세요"
	  	 		});
	        	return;
	        }
	        
	        let value = que.querySelector(`[name=\${code}]:checked`).value;
			
// 	        console.log("que : ",que);
// 	        console.log("value : ",value);
	        
	        let lecEvaluationVO = {
	        	"stuLecNo" : stuLecNo,
        		"lecEvalItemNo": code,
        		"lecEvalScore" : value 
	        }
	        lecEvaluationVOList.push(lecEvaluationVO);
	    }
	    
	    for(let i=0; i<queSubs.length; i++){
	    	let queSub = queSubs[i];
	        let code = queSub.dataset.code;
	        let value = queSub.querySelector(`[name=\${code}]`).value;
	        
	        validateInput(value);
	        
	        if(!validateInput){
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
		  	 		  title: "빈 칸 없이 모두 체크해주세요"
		  	 		});
		        	return;
	        }
	        
// 	        console.log("queSubs >> queSub : ",queSub);
// 	        console.log("queSubs >> value : ",value);
	        
	        let lecEvaluationVO = {
        		"stuLecNo" : stuLecNo,
	            "lecEvalItemNo" : code,
	            "lecEvalScore" :value 
	        }
	        lecEvaluationVOList.push(lecEvaluationVO);
	    }
	    
// 	    console.log("datas : ", datas);

		$.ajax({
			url:"/achieve/lecEvaluationCreate",
			contentType:"application/json;charset=utf-8",
			data: JSON.stringify(lecEvaluationVOList),
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
                    title: "강의 평가 등록완료 되었습니다.",
                    timer: 1800,
                    showConfirmButton: false // 확인 버튼을 숨깁니다.
                  });
	        	location.href = "/achieve/nowAch?menuId=cybAciChk";
	        }
		});
	    
	});
	
	function validateRadio(obj){
		let isChecked;
		console.log("validateRadio >> obj: ",obj)
		for(i=0; i<obj.length; i++){
			if(obj[i].checked){
				isChecked = true;
				break;
			}
		}
		if(isChecked){
			return true;
		}else{
			return false;
		}
	}
	
	function validateInput(obj){
		let isChecked = true;
		if(!obj){
			isChecked = false;	
		}
		return isChecked;
	}
	
	// 자동입력 버튼
	$("#outoInput").on("click",function(){
		$("input[type=radio][value='5']").prop("checked",true);
		$("#queSub").val("한학기동안 감사했습니다.");
	});
	
});

</script>
<div id="wrap">
	<div class="h3Box">
		<h3>강의평가</h3>
	</div>
	<div style="display:flex; justify-content: end;">
		<button type="button" id="outoInput" class="btn btn-outline-light" style="margin:3px;">자동입력</button>
	</div>
	<div> 
		<div class="back_green" style="padding:50px;color:#636363;">
			 강의평가 내용은 <span style="color:blue;">정보통신망 이용촉진 및 정보보호 등에 관한 법</span>에 따라  <span style="color:red;">절대 익명성이 보장</span>됩니다. 명예를 훼손하거나 비방글은 자제하여 주시기 바라오며 이 설문조사는 한 학기동안의 수업에 대한 수강생들의 의견을 들어 수업의 질을 제고하고 더 좋은 강의를 위한  <span style="color:blue;">강의개선에 귀중한 기초자료</span>로 활용되오니 성실하게 답변하여 주시기 바랍니다.
		</div>
	</div>
	<div class="w-100 text-center" style="margin-top:1rem;">
		<div class="w-50" style="margin:0 auto;">
			<table class="table table-bordered back_white">
				<thead class="back_green">
					<tr>
						<th>과목명</th>	
						<th>담당교수</th>	
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>${stuLectureVO.lectureVOList.lecName}</td>
						<td>${stuLectureVO.userInfoVO.userName}</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	<div>
		<div class="row">
			<div class="col-12">
				<form action="">
					<table class="table table-bordered back_white">
						<tr data-code="e1-01" class="que">
							<td rowspan="2" class="back_green text-center" style="width:71px;">학습자<br>자가<br>진단</td>
							<td>1. ${selfEvalItemList[0].lecEvalItemCon}</td>
							<td>
								<input type="radio" id="e1-01-1" name="e1-01" value="1">
								<label for="e1-01-1" class="margin2">전혀 그렇지 않다</label>
								<input type="radio" id="e1-01-2" name="e1-01" value="2">
								<label for="e1-01-2" class="margin2">대체로 그렇지 않다</label>
								<input type="radio" id="e1-01-3" name="e1-01" value="3">
								<label for="e1-01-3" class="margin2">보통이다</label>
								<input type="radio" id="e1-01-4" name="e1-01" value="4">
								<label for="e1-01-4" class="margin2">대체로 그렇다</label>
								<input type="radio" id="e1-01-5" name="e1-01" value="5">
								<label for="e1-01-5" class="margin2">매우 그렇다</label>
							</td>
						</tr>
						<tr data-code="e1-02" class="que">
							<td>2. ${selfEvalItemList[1].lecEvalItemCon}</td>
							<td>
								<input type="radio" name="e1-02" id="e1-2-1" value="1">
								<label for="e1-2-1" class="margin2">4번 이상</label>
								<input type="radio" name="e1-02" id="e1-2-2" value="2">
								<label for="e1-2-2" class="margin2">3번 이상</label>
								<input type="radio" name="e1-02" id="e1-2-3" value="3">
								<label for="e1-2-3" class="margin2">2번</label>
								<input type="radio" name="e1-02" id="e1-2-4" value="4">
								<label for="e1-2-4" class="margin2">1번</label>
								<input type="radio" name="e1-02" id="e1-2-5" value="5">
								<label for="e1-2-5" class="margin2">전혀없다</label>
							</td>
						</tr>
					</table>
					<table class="table table-bordered text-nowrap back_white">
						<thead class="back_green">
							<tr class="text-center ">
								<th>순번</th>
								<th>평가문항</th>
								<th class="w-12">매우그렇다</th>
								<th>그렇다</th>
								<th>보통이다</th>
								<th>그렇지않다</th>
								<th>매우그렇지않다</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="multiChoiceEvalItem" items="${multiChoiceEvalItemList}" varStatus="stat">
								<tr data-code="${multiChoiceEvalItem.lecEvalItemNo}" class="que">
									<td class="text-center">${stat.index+1}</td>
									<td>${multiChoiceEvalItem.lecEvalItemCon}</td>
									<td class="text-center"><input type="radio" name="${multiChoiceEvalItem.lecEvalItemNo}" value="5"></td>
									<td class="text-center"><input type="radio" name="${multiChoiceEvalItem.lecEvalItemNo}" value="4"></td>
									<td class="text-center"><input type="radio" name="${multiChoiceEvalItem.lecEvalItemNo}" value="3"></td>
									<td class="text-center"><input type="radio" name="${multiChoiceEvalItem.lecEvalItemNo}" value="2"></td>
									<td class="text-center"><input type="radio" name="${multiChoiceEvalItem.lecEvalItemNo}" value="1"></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<table class="table table-bordered back_white">
						<tr data-code="${subjectiveEvalItemList[0].lecEvalItemNo}" class="queSub">
							<td rowspan="2" class="back_green text-center" style="width:71px;">개방형문항</td>
							<td style="padding-top: 24px;">1. ${subjectiveEvalItemList[0].lecEvalItemCon}</td>
							<td>
								<input type="text" name="${subjectiveEvalItemList[0].lecEvalItemNo}" id="queSub" class="form-control">
							</td>
						</tr>
					</table>
					<div style="display:flex; justify-content: center;">
						<button type="button" id="subBtn" class="btn btn-outline-primary col-1">등록</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

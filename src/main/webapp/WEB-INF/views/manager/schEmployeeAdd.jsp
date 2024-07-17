<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
h3 {
	color:black;
    margin-bottom: 30px;
    margin-top: 40px;
    margin-left: 165px;
} 
.trBackground {
    background-color: #ebf1e9;
    text-align: center;
}
#save, #auto {
  width: 100px;
  margin-top: 20px;
}
#save {
    margin-left: auto;
    margin-right: auto;
}

#auto {
    position: absolute;
    right: 135px;
}
</style>
<script>
$(function(){
    $('#univ').on('change',function(){
    	univ = $('#univ').val();
        console.log(univ)
	    let data = {
        	univ
	    };
	
	    $.ajax({
	        url:"/manager/schEmNo",
	        contentType:"application/json;charset='utf-8'",
	        data:JSON.stringify(data),
	        type:"post",
	        dataType:"text",
	        beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
	        success:function(result){
// 	            console.log(result);
	            $('#schEmNo').val(result)
	        }
	    })
    })

    $('#save').on('click', function(){
    	const form = document.getElementById('form');
        const formData = new FormData(form);
        const data = {};
        formData.forEach((value, key) => {
            data[key] = value;
        });
        
        console.log(data);
        
        $.ajax({
        	url:"/manager/createSchEmAjax",
	        contentType:"application/json;charset='utf-8'",
	        data:JSON.stringify(data),
	        type:"post",
	        dataType:"text",
	        beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
	        success:function(result){
	            console.log(result)
	            if(result > 0){
	            	
		            Swal.fire({
	                    position: "center",
	                    icon: "success",
	                    title: "등록완료 되었습니다.",
	                    timer: 1800,
	                    showConfirmButton: false // 확인 버튼을 숨깁니다.
	                  }).then(() => {
	                    // Swal.fire의 타이머가 끝난 후 호출됩니다.
	                    location.href = "/manager/schEmployeeList?menuId=pstEmpMan";
	                  });
	            }
	        }
        })
    })
    $('#auto').on('click', function(){
    	$('#schEmName').val("홍길동");
    	$('#schEmStart').val("2024-07-16");
    	$('#schEmEnd').val("2025-07-16");
    	$('#schEmSalary').val(2800);
    })
})    
function comma(str) {
    str = String(str);
    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
}

function uncomma(str) {
    str = String(str);
    return str.replace(/[^\d]+/g, '');
} 

function inputNumberFormat(obj) {
    obj.value = comma(uncomma(obj.value));
}

function inputOnlyNumberFormat(obj) {
    obj.value = onlynumber(uncomma(obj.value));
}

function onlynumber(str) {
 str = String(str);
 return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g,'$1');
}
</script>
<h3>교직원 추가</h3>
<div class="col-12">
	<div class="card col-10" class="divCard" style="padding-right: 0px; padding-left: 0px; margin-left: 150px">
	    <div class="card-body table-responsive p-0">
	        <table class="table table-hover text-nowrap">
	            <thead>
	                <tr class="trBackground textCenter" style="color:black;">
	                    <th>단과대학</th>
	                    <th>교직원번호</th>
	                    <th>교직원명</th>
	                    <th>입사일</th>
	                    <th>종료(예정)일</th>
	                    <th>연봉[단위 : 만]</th>
	                </tr>
	            </thead>
	            <tbody id="trShow" class="text-center">
	                <form action="" id="form">
	                     <tr name="trHref">
	                        <td class="col-2">
	                            <select class="form-control" name="schEmDept" id="univ">
									<option selected disabled>학과 선택</option>
									<c:forEach var="comCodeVO" items="${univList}" varStatus="stat">
	                                    <option value="${comCodeVO.comCode}">${comCodeVO.comCodeName}</option>
									</c:forEach>
								  </select>
	                        </td>
	                        <td class="col-2">
	                            <input type="text" class="form-control" id="schEmNo" name="schEmNo" readonly
	                            	placeholder="단과대학 선택시 자동완성">
	                        </td>
	                        <td class="col-2">
	                            <input type="text" class="form-control" id="schEmName" name="schEmName">
	                        </td>
	                        <td class="col-2">
	                            <input type="date" class="form-control" id="schEmStart" name="schEmStart">
	                        </td>
	                        <td class="col-2">
	                            <input type="date" class="form-control" id="schEmEnd" name="schEmEnd">
	                        </td>
	                        <td class="col-2">
	                            <input type="text" class="form-control text-right" id="schEmSalary" name="schEmSalary" onkeyup="inputNumberFormat(this);">
	                        </td>
	                    </tr>
	                </form>
	            </tbody>
	        </table>
	    </div>
	</div>
</div>
<div class="text-center" style="display: flex;
            justify-content: center;
            position: relative;">
		<button type="button" class="btn btn-outline-primary" id="save">등록</button>
		<button type="button" class="btn btn-outline-light" id="auto">자동 완성</button>
</div>
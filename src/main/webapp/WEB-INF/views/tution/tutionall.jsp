<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- 포트원 결제 -->
<!DOCTYPE html>
<html>
<head>
<link
	href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-neo.css"
	rel="stylesheet">
<link rel="stylesheet" href="/resources/css/sweetalert2.min.css">
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<!-- 포트원 결제 -->
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<!-- jQuery -->
<script type="text/javascript"
	src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<!-- iamport.payment.js -->
<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
* {
	font-family: 'NanumSquareNeo';
}

h3 {
	color: black;
    margin-bottom: 30px;
    margin-top: 40px;
    margin-left: 230px;
} 

thead {
	background-color: #ebf1e9;
	text-align: center;
}

h6 {
	color: black;
}

td {
	color: black;
	text-align: center;
}
.noticeBox {
	background-color: white;
    border: 1px solid #ced4da;
    margin-bottom: 30px;
    padding: 40px 40px 30px 40px;
}
</style>
</head>

<body>
	<h3>등록금 전체 납부</h3>

<!-- 	<div class="card-body" style="width: 80%"> -->
	<div class="container-fluid col-9">
		<div class="card card-light card-outline noticeBox">
<!-- 			<div class="card-body" style="border-width: 3px;"> -->
<!-- 			<div class="card-body col-11" style="border-width: 3px; width: 80%"> -->
			<div class="card-body table-responsive p-0">
				<strong>
					<p>
						※ 안내사항 최종등록기간까지 등록금을 완납하지 않으면 미등록 제적될 수 있습니다.
						<br><br>
						등록금 결제 시 취소가 불가능합니다
						<br><br>
						등록금 납부 방법 : 카카오 페이, 가상계좌 입금, 행정실 방문 후 카드 결제
					</p>
				</strong>
			</div>
		</div>
	<c:set var="now" value="<%=new Date()%>" />
	<fmt:formatDate var="sysYear" value="${now}" pattern="yyyy-MM-dd" />

	<h6 style="display: inline-block; margin-left: 20px">> 오늘 날짜는 ${sysYear}</h6>
	<c:if test="${term eq 0}">
		<h6 style="color: blue; display: inline-block">전체 납부</h6>
	</c:if>
	<c:if test="${term ne 0}">
		<h6 style="color: red; display: inline-block">분할 납부</h6>
	</c:if>
	<h6 style="display: inline-block">기간 입니다.</h6>
		<div class="card">
			<div class="card-body table-responsive p-0">
				<table class="table table-head-fixed text-nowrap"
					style="border: 3px; height: 100px">
					<thead>
						<tr style="color:black;">
							<th align="center">년도</th>
							<th align="center">학기</th>
							<th align="center">기간</th>
							<th>납부할 금액(단위 :원)</th>
							<th>납부상태</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>${tuitionVO.year}년도</td>
							<td>${tuitionVO.semester}학기</td>
							<td>${tuitionVO.divPayTermVO.divPayStDate}~
								${tuitionVO.divPayTermVO.divPayEnDate}</td>
							<td style="text-align: right;"><fmt:formatNumber value="${tuitionVO.tuiCost}"
									pattern="#,###"></fmt:formatNumber>원</td>
							<c:if test="${tuitionVO.tuiPayYn eq 'Y'}">
								<td style="color: blue">납부완료</td>
							</c:if>
							<c:if test="${tuitionVO.tuiPayYn eq 'N'}">
<!-- 								<td id="nowpay" onclick="nowpay()" style="color: red; cursor:pointer"> -->
								<td>
									<button onclick="nowpay()" class="btn btn-outline-danger">납부하기</button>
								</td>
							</c:if>
						</tr>
					</tbody>
				</table>
		</div>
	</div>
</div>

<script type="text/javascript">

function nowpay(){

	let scolar = 0;
	let pay = 0;
	let realpay = 0;
	let year = 0;
	let semester = 0;
	
	let data0 = {
		"test" : 1
	}
	
//	scolarshipHistoryVO.scolarPay
	
		$.ajax({
			
		url:"/tution/tutionallview",
		contentType:"application/json;charset=utf-8",
		data:JSON.stringify(data0),
		type:"post",
		dataType:"json",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success:function(result){
			console.log("result 결과 : ", result);
// 			scolar = result.scolAmount;
//			scolar = result.scolarshipHistoryVO.scolarPay;
			scolar = result.scolarPay;
			pay = result.tuiCost;
			realpay = pay - scolar;
			year = result.year;
			semester = result.semester;
			console.log("scolar : " + scolar);
			let data = {
				"semester" : semester,
				"year" : year,
				"pay"	: pay,
				"scolar" : scolar,
				"realpay" : realpay	
					
			}
//			alert("클릭 테스트")
			// 완납
			// 현재 등록금 전체에 대한 정보 ${tuitionVO.tuiCost}
			// 장학금액 (등록금차감) 에 대한 정보 ${tuitionVO.scolAmount}
			// 내야할 금액 : 등록금 - 장학금

			     Swal.fire({
			            title: '등록금 납부를 진행하시겠습니까?',
			            html: `<br/>
			     				<div>
			     					<div style="display: flex;
			     					    justify-content: space-between;
			     						width:250px;
			     						margin:auto;">
				     					<span>등록금</span><span>` + pay.toLocaleString('ko-KR') + `원</span>
				     				</div>
				     				<br>
				     				<div style="display: flex;
			     					    justify-content: space-between;
			     						width:250px;
			     						margin:auto;">
				     					<span>장학금</span><span>` + scolar.toLocaleString('ko-KR') + `원</span>
				     				</div>
				     				<br>
				     				<br>
		     						<b style="display: flex;
			     					    justify-content: space-between;
			     						width:250px;
			     						margin:auto;">
			     						<span>총 납부 금액</span><span>` + realpay.toLocaleString('ko-KR') + `원</span>
		     						</b>
			     				</div>`,
			            icon: 'warning',
			            showCancelButton: true,
			            confirmButtonColor: '#3085d6',
			            cancelButtonColor: '#d33',
			            confirmButtonText: '확인',
			            cancelButtonText: '취소'
			        }).then((result) => {
			        	// 확인 버튼 눌렀을 때
			            if (result.isConfirmed) {
			            	
			            	// 카카오페이 결제 실행
							payment(data);
			            }

       				})
				}
		})
}

// 카카오페이 결제 > db 저장 )}
function payment(data){
    IMP.init("imp08578838"); // 가맹점 식별코드
    IMP.request_pay(
    		// 기본정보
    {   
     pg: "kakaopay",
        pay_method: "card",
        name: "대덕인재대학교 등록금",
//       amount: data.realpay, // 결제할 금액
        amount: 1, // 결제할 금액
        m_redirect_url: "/tution/tutionall", // 모바일 결제후 리다이렉트될 주소!!
    }, async function (rsp) { // 카카오페이 진행
    	
    	// insert 할 데이터
    	let ajdata = {
    
    		"year" : data.year,
    		"semester" : data.semester,
			"tuiCost"	: data.pay, // 등록금총액
			"scolAmount" : data.scolar, // 장학금
			"realpay" : data.realpay	// 실납부
    		
    	}
    
    	console.log("ajdata : " , ajdata)
    
    	// 카카오페이 성공시
    	if (rsp.success) {
    		
    		console.log("카카오 페이 성공했다 아직 ajax 실행 전")
    		
    		// db 저장
    		$.ajax({
    		
    		url:"/tution/tuitionallpay",
    		contentType:"application/json;charset=utf-8",
    		data: JSON.stringify(ajdata),
    		type:"post",
    		dataType:"text",
    		beforeSend:function(xhr){
    			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
    		},
    		success:function(result){
    			console.log(result);
    			if(result == "SUCCESS"){
    	 			Swal.fire({
    	  				title: '등록금 납부 완료',         // Alert 제목
    	  				text: '등록금 납부가 완료되었습니다. 납부내역에서 확인해주세요!',  // Alert 내용
    	  				icon: 'success',                         // Alert 타입
    					})
    					.then(function(){
    						window.location.href = "/tution/tutionall?menuId=cybTuiPay";
    					});
    	 				
    					}
    		
    	 			// AJAX 실패
    			else {
    				Swal.fire({
      				title: '등록금 납부 실패.',         // Alert 제목
      				text: '등록금 납부 실패되었습니다. 다시 신청해주세요.',  // Alert 내용
      				icon: 'error',                         // Alert 타입
    				});
    			
    				}
    			}
        	}) 
        } 
    
    	// 카카오 페이 실패시
    	else {
        	
			Swal.fire({
  				title: '등록금 결제 실패.',         // Alert 제목
  				text: '등록금 결제 실패되었습니다. 다시 신청해주세요.',  // Alert 내용
  				icon: 'error',                         // Alert 타입
				});	
        
          //      alert(`error${response.status}\n결제요청 실패되었습니다. 다시 진행해주세요`);
      	 	}
    	}
    )
}

</script>
</body>
</html>
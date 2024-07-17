<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<link
	href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-neo.css"
	rel="stylesheet">
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script type="text/javascript" src="/resources/js/printThis.js"></script>
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
	margin-left: 170px;
}  

thead {
	background-color: #ebf1e9;
	color: black;
	text-align: center;
}

td {
	text-align: center;
}
</style>
</head>

<body>
<h3>장학금 수혜 내역</h3>
<div class="container-fluid col-10">
	<div id="condiv"></div>
</div>

<script type="text/javascript">

console.log("스크립트")
function checkOnlyOne(element) {
  
  const checkboxes 
      = document.getElementsByName("semester");
  
  checkboxes.forEach((cb) => {
    cb.checked = false;
  })
  
  element.checked = true;
}

    
$(function () {
	
	
    $.ajax({
    	
    	url:"/tution/scolarship2",
    	contentType: "application/json;charset=utf-8",
    	type:"post",
    	dataType:"json",
		beforeSend:function(xhr){
            xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
     	},
		success:function(result){
			console.log("db 결과 result : ", result);
			let str = "";
 			let result3 = result.length;
			console.log("result3 : ", result3);
			
				str+= "<h5 style='margin-left: 1240px'>[총 "+result3+"건]</h5>";
				str+= "<div class='col-12'>";
				str+= "<div class='card'>";
				str+= "<div class='card-body table-responsive p-0' style='height: 100%;'>";
				str+= "<table class='table table-head-fixed text-nowrap' style='border: 3px; color:black'>";
				str+="<thead>";		
				str+="<tr>";
				str+="<th style= 'width:5%'>번호</th>";
				str+="<th style='width: 10%'>대상년도</th>";
				str+="<th>학기</th>";
				str+="<th>학년</th>";
				str+="<th>종류</th>";
				str+="<th>구분</th>";
				str+="<th>교내(단위: 원)</th>";
				str+="<th>교외(단위: 원)</th>";
				str+="<th>총합(단위: 원)</th>";
				str+="<th>구분</th>";
				str+="<th>사용여부</th>";
				str+="</tr>";
				str+="<thead>";
				str+="<tbody>";		
				$.each(result,function(idx,scolarShipHistoryVO){
					str+= "<tr>";
					str+= "<td>"+(idx+1)+"</td>";
					str+= "<td>"+scolarShipHistoryVO.year+"년도</td>";
					str+= "<td>"+scolarShipHistoryVO.semester+"학기</td>";
					str+= "<td>"+(scolarShipHistoryVO.year - scolarShipHistoryVO.studentVO.admissionDate.substring(0,4) + 1)+"학년</td>";
					str+= "<td>"+scolarShipHistoryVO.scolarshipVO.scolType+"</td>";
					str+= "<td style='text-align: left;'>"+scolarShipHistoryVO.scolarshipVO.scolName+"</td>";
					
					if(scolarShipHistoryVO.scolarshipVO.scolGubun=="교내"){
						str+= "<td style='text-align: right;'>"+((scolarShipHistoryVO.scolarPay).toLocaleString('ko-KR'))+"원</td>";
					}else if(scolarShipHistoryVO.scolarshipVO.scolGubun=="교외"){
						str+= "<td style='text-align: right;'>0원</td>";
					}
					
					if(scolarShipHistoryVO.scolarshipVO.scolGubun=="교외"){
						str+= "<td style='text-align: right;'>"+((scolarShipHistoryVO.scolarPay).toLocaleString('ko-KR'))+"원</td>";
					}else if(scolarShipHistoryVO.scolarshipVO.scolGubun=="교내"){
						str+= "<td style='text-align: right;'>0원</td>";
					}
					
					str+= "<td style='text-align: right;'>"+((scolarShipHistoryVO.scolarPay).toLocaleString('ko-KR'))+"원</td>";
					str+= "<td>"+scolarShipHistoryVO.scolMethod+"</td>";
					
					if(scolarShipHistoryVO.scolHiYn=="Y"){
						str+= "<td style='color: blue'>사용완료</td>";
					}else{
						str+= "<td style='color: red'>미사용</td>";
					}
					
					str+= "</tr>";
				});
				str+= "</tbody>";
				str+= "</table>";
				str+= "</div>";
				str+= "</div>";
				str+= "</div>";
				str+= "<br>";

			$("#condiv").html(str);
		}
    })
})
</script>

</body>
</html>
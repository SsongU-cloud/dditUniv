<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<!-- <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script> -->
<head>
<meta charset="UTF-8">
<title>수강조회</title>
<style>
.container-fluid h5 {
	display: inline-block;
    margin-right: 995px;
    margin-left: 173px;
} 
.hearderH5 {
 	float: left;
 	margin-top: 40px;
 	margin-bottom: 30px;
	display: inline-block;
	margin-right: 1030px;
	margin-left: 173px;
}
.rkddmlrjfoBut {
	display: inline-block;
	height: 50px;
    width: 125px;
    font-size: 18px;
}
.tbe {
	height: 80vh;
	width: 80%;
	table-layout: fixed;
	text-align: center;
 	margin: 50px 170px 30px 170px;
	background-color: white;
	border-color: #d2d8d0;
}
.heardTr {
	height: 41px;
}
.h5Button {
	display: inline-block;
	color: black;
}
.tableModel>td {
  text-align:left;
}
th {
	background-color: #ebf1e9;
	color: black;
}
.table-disp {
  margin: auto;
  padding: 0;
  text-align: center;
}
.w130px{
	width: 130px;
	text-align:center;	
}
.w150px{
	width: 150px;
	text-align:center;	
}
#exampleModalLabel {
	margin:0px;
	margin-left:18px;
}
</style>
<script>
$(function(){
	
	//아작나써유..(피)씨다타써...
	$.ajax({
		url: "/stuLecture/listAjax", //ajax용 url 변경
// 		contentType:"application/json;charset=utf-8",
// 		data:"",
		type:"get",
		dataType:"json",
		success:function(result){
// 			console.log("result.length : ",result.length);
// 			console.log("result : ", result);
// 			console.log("result[0].lecNo : ", result[0].lecNo);
// 			console.log("result[0].lectureVOList.lecCol : ", result[0].lectureVOList.lecCol);
// 			console.log("result[0].lectureVOList.lectureDetailVOList[0].lectureRoomVO.lecRoName : ", result[0].lectureVOList.lectureDetailVOList[0].lectureRoomVO.lecRoName);
			
			for(let i=0; i<result.length; i++) {
				let lecNo = result[i].lecNo; //강의 번호
				let lecName = result[i].lectureVOList.lecName; //강의명
				let lecRoName = result[i].lectureVOList.lectureRoomVO.lecRoName; //강의실명
				let lecCol = result[i].lectureVOList.lecCol; //색상 코드
				let lecDay = result[i].lectureVOList.lecTimeVO.lecDay; //강의 요일
				let lecSt = result[i].lectureVOList.lecTimeVO.lecSt; //강의 시작 교시
				let lecEnd = result[i].lectureVOList.lecTimeVO.lecEnd; //강의 종료 교시
				
				weekCheck(lecNo, lecName, lecRoName, lecCol, lecDay, lecSt, lecEnd);
			}
			
		},
	    error: function (request, status, error) {
	        console.log("code: " + request.status)
	        console.log("message: " + request.responseText)
	        console.log("error: " + error);
	    }
	});
});

// 요일 확인
function weekCheck(lecNo, lecName, lecRoName, lecCol, lecDay, lecSt, lecEnd) {
// 	console.log("lecDay : ", lecDay);
	
	if(lecDay == "월"){
		lecCheck(lecNo, lecName, lecRoName, lecCol, "lectureMon", lecSt, lecEnd);
	} else if(lecDay == "화"){
		lecCheck(lecNo, lecName, lecRoName, lecCol, "lectureTue", lecSt, lecEnd);
	} else if(lecDay == "수"){
		lecCheck(lecNo, lecName, lecRoName, lecCol, "lectureWed", lecSt, lecEnd);
	} else if(lecDay == "목"){
		lecCheck(lecNo, lecName, lecRoName, lecCol, "lectureThu", lecSt, lecEnd);
	} else if(lecDay == "금"){
		lecCheck(lecNo, lecName, lecRoName, lecCol, "lectureFri", lecSt, lecEnd);
	}
}

// 교시 확인 & 값 넣기
function lecCheck(lecNo, lecName, lecRoName, lecCol, classTemp, lecSt, lecEnd) {
// 	console.log("교시 확인! : ", classTemp, lecSt, lecEnd);

	
	let element = null;
	for(let i=lecSt; i<=lecEnd; i++) {
		let classNum = classTemp + i;
		element =  document.getElementsByClassName(classNum)[0];
		document.getElementsByClassName(classNum)[0].style.backgroundColor = lecCol;
		let str = "";
		str += lecName + "<br>";
		str += lecRoName;
		
		element.style.color = "white";
		element.innerHTML = str;
		element.style.cursor = 'pointer';
		element.classList.add('lecList');
	    element.setAttribute('data-toggle', 'modal');
	    element.setAttribute('data-target', '#lecPlanModal');
	    element.setAttribute('data-lecNo', lecNo);
	    element.onclick = function(){
	    	let lecNo = this.getAttribute('data-lecNo');
	        console.log('Lecture Number:', lecNo); // lecNo 값을 콘솔에 출력
	        
	        let data = {
	        	lecNo
	        }
	        
	        $.ajax({
    			url:"/lecture/detailHandbook",
    			contentType:"application/json;charset=utf-8",
    			data:JSON.stringify(data),
    			type:"post",
    			dataType:"json",
    			beforeSend:function(xhr){
    				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
    			},
    			success:function(result){
    				console.log(result)
    				
    				let lecName = result.lecName;
    				let lecGrade = result.lecGrade + '학년';
    				let lecScore = result.lecScore + '학점';
    				let college = result.comCodeVO.comCodeName;
    				let dept = result.comDetCodeVO.comDetCodeName;
    				let lecRoName = result.lectureRoomVO.lecRoName;
    				let lecDiv = result.lecDiv;
    				let lecType = result.lecType;
    				let lecPer = result.lecPer + '명';
    				let lecDays = result.lecDay;
    				
    				$('#lecName').text(lecName);
    				$('#lecGrade').text(lecGrade);
    				$('#lecScore').text(lecScore);
    				$('#college').text(college);
    				$('#dept').text(dept);
    				$('#lecRoName').text(lecRoName);
    				$('#lecDiv').text(lecDiv);
    				$('#lecType').text(lecType);
    				$('#lecPer').text(lecPer);
    				$('#lecDays').text(lecDays);
    				
    				$.ajax({
            			url:"/lecture/lectureDetail",
            			contentType:"application/json;charset=utf-8",
            			data:JSON.stringify(data),
            			type:"post",
            			dataType:"json",
            			beforeSend:function(xhr){
            				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
            			},
            			success:function(detailList){
            				console.log("detailList >>> ", detailList)
            				let str = "";
            				
            				if(detailList.length == 0){
            					str += `
            						<tr>
	        							<th colspan="6" class="text-center">
	        								<span>회차가 존재하지 않습니다.</span>
	        							</th>
	        						</tr>
            					`;
            				}
            				
            				$.each(detailList, function(idx, detailVO){
            					str +=`
            						<tr>
	        							<th colspan="6" class="text-center">
	    									<span>\${detailVO.lecNum}회차</span>
    	    							</th>
    	    						</tr>
    	    						<tr>
    	    							<td colspan="6">\${detailVO.lecCon}</td>
    	    						</tr>
    							`;
            				})
            				$('#lecDetail').html(str);
            			}
            		}); // ajax 끝
    			}
    		});// ajax 끝
	    }
		
// 		document.getElementsByClassName(classNum)[0].style.color = "white";
// 		document.getElementsByClassName(classNum)[0].innerHTML = str;
// 		document.getElementsByClassName(classNum)[0].addEventListener('click')
	}
}
function lectureTransfer() {
	let today = new Date();   

	let year = today.getFullYear(); // 년도
	let month = today.getMonth() + 1;  // 월
	let date = today.getDate();  // 날짜
	let day = today.getDay();  // 요일

	let todayDate = year + '/' + month + '/' + date;
	console.log("todayDate : ", todayDate);
	
	if((date <= 31) && (month <= 7)) { // 7월 19일까지 수강신청 거래 가능
		location.href="/stuLecture/exchange?menuId=couRegChk";
	}
}
</script>
</head>
<body>
<!-- 모달 시작 -->
<div class="modal fade" id="lecPlanModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable" style="max-width: 1000px;">
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
				<th class="w150px">강의명</th>
				<td id="lecName"style="width: 250px;"></td>
					<th class="w130px">수강 학년</th>
					<td id="lecGrade"></td>
					<th class="w130px">학점</th>
					<td id="lecScore"></td>
				</tr>
				<tr>
					<th class="w150px">단과대학</th>
					<td id="college"></td>
					<th class="w130px">학과</th>
					<td id="dept"></td>
					<th class="w130px">강의실</th>
					<td id="lecRoName"></td>
				</tr>
				<tr>
					<th class="w150px">이수구분</th>
					<td id="lecDiv"></td>
					<th class="w130px">강의영역</th>
					<td id="lecType"></td>
					<th class="w130px">수강최대인원</th>
					<td id="lecPer"></td>
				</tr>
				<tr>
					<th class="w150px">강의 요일 / 시간</th>
					<td id="lecDays" colspan="5"></td>
				</tr>
				</tbody></table>
				<br>
				<hr>
				<br>
				<table class="table table-bordered tableModel">
				<tbody id="lecDetail">
					<tr>
						<th colspan="6" class="text-center">
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
    <div class="h5Button">
    <%
    	Date date = new Date();
    	SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy");
    	String strYear = simpleDate.format(date);
    %>
        <h4 class="hearderH5" style="color:black;"><%=strYear %>년도&nbsp;&nbsp;${studentVO.stGrade}학년&nbsp;&nbsp;${studentVO.stSemester}학기</h4>
        <h5 style="color:black;">현재 학기&nbsp; 총&nbsp;${grades}학점 </h5>
        <button type="button" class="btn btn-block btn-outline-success rkddmlrjfoBut"
    		onclick="lectureTransfer()">강의 전송</button>
    </div>
    <div>
	    <table border="1" class="tbe">
	    	<colgroup>
	    		<col style="width:10%">
	    		<col style="width:13%">
	    	</colgroup>
	        <thead>
	            <tr class="heardTr"style="color:black;">
	                <th style="height:50px;">교시</th>
	                <th>시간</th>
	                <th>월</th>
	                <th>화</th>
	                <th>수</th>
	                <th>목</th>
	                <th>금</th>
	            </tr>
	        </thead>
	        <tbody>
	            <tr>
	                <td style="height:80px;">1교시</td>
	                <td>09:00 ~ 09:50</td>
	                <td class="lectureMon1"></td>
	                <td class="lectureTue1"></td>
	                <td class="lectureWed1"></td>
	                <td class="lectureThu1"></td>
	                <td class="lectureFri1"></td>
	            </tr>
	            <tr>
	                <td style="height:80px;">2교시</td>
	                <td>10:00 ~ 10:50</td>
	                <td class="lectureMon2"></td>
	                <td class="lectureTue2"></td>
	                <td class="lectureWed2"></td>
	                <td class="lectureThu2"></td>
	                <td class="lectureFri2"></td>
	            </tr>
	            <tr>
	                <td style="height:80px;">3교시</td>
	                <td>11:00 ~ 11:50</td>
	                <td class="lectureMon3"></td>
	                <td class="lectureTue3"></td>
	                <td class="lectureWed3"></td>
	                <td class="lectureThu3"></td>
	                <td class="lectureFri3"></td>
	            </tr>
	            <tr>
	                <td style="height:80px;">4교시</td>
	                <td>12:00 ~ 12:50</td>
	                <td class="lectureMon4"></td>
	                <td class="lectureTue4"></td>
	                <td class="lectureWed4"></td>
	                <td class="lectureThu4"></td>
	                <td class="lectureFri4"></td>
	            </tr>
	            <tr>
	                <td style="height:80px;">5교시</td>
	                <td>13:00 ~ 13:50</td>
	                <td class="lectureMon5"></td>
	                <td class="lectureTue5"></td>
	                <td class="lectureWed5"></td>
	                <td class="lectureThu5"></td>
	                <td class="lectureFri5"></td>
	            </tr>
	            <tr>
	                <td style="height:80px;">6교시</td>
	                <td>14:00 ~ 14:50</td>
	                <td class="lectureMon6"></td>
	                <td class="lectureTue6"></td>
	                <td class="lectureWed6"></td>
	                <td class="lectureThu6"></td>
	                <td class="lectureFri6"></td>
	            </tr>
	            <tr>
	                <td style="height:80px;">7교시</td>
	                <td>15:00 ~ 15:50</td>
	                <td class="lectureMon7"></td>
	                <td class="lectureTue7"></td>
	                <td class="lectureWed7"></td>
	                <td class="lectureThu7"></td>
	                <td class="lectureFri7"></td>
	            </tr>
	            <tr>
	                <td style="height:80px;">8교시</td>
	                <td>16:00 ~ 16:50</td>
	                <td class="lectureMon8"></td>
	                <td class="lectureTue8"></td>
	                <td class="lectureWed8"></td>
	                <td class="lectureThu8"></td>
	                <td class="lectureFri8"></td>
	            </tr>
	            <tr>
	                <td style="height:80px;">9교시</td>
	                <td>17:00 ~ 17:50</td>
	                <td class="lectureMon9"></td>
	                <td class="lectureTue9"></td>
	                <td class="lectureWed9"></td>
	                <td class="lectureThu9"></td>
	                <td class="lectureFri9"></td>
	            </tr>
	        </tbody>
	    </table>
    </div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet"> -->
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-neo.css" rel="stylesheet">
<!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script> -->
<style>
* {
  font-family: 'NanumSquareNeo'; 
}
.row {
  text-align: center;
}
h3{
    margin-bottom: 50px;
    margin-top: 60px;
    color: black;
} 
h4 {
  margin-bottom: 12px;		
  margin-top: 40px;
  margin-left: 20px;
  color: black;
} 
h6 {
  margin-bottom: 10px;
  margin-left: 20px;
  color: black;
} 
.table {
  margin: auto;
}
.trBackground {
  background-color: #ebf1e9;
  position: sticky;
  top: -1px;
  z-index: 1;
}
.card {
  display: flex;
  align-items: center;
}
.card-body {
  width: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
}
label {
  margin-bottom: 0px;
}
.rhkahrtn {
  display:flex;
  margin-top: 30px;
  margin-bottom: 10px;
  margin-left: 5px;
}
.search-table {
  overflow-y: scroll;
  width: 100%;
  height: 350px;
  display: block;
}
.hearderH5 {
 	float: left;
 	margin-top: 40px;
 	margin-bottom: 30px;
	display: inline-block;
	margin-right: 1020px;
	margin-left: 173px;
}
.rkddmlrjfoBut {
	width: 165px;
    margin-top: 34px;
}
.tbe {
	height: 80vh;
	width: 100%;
	table-layout: fixed;
	text-align: center;
	margin-bottom: 30px;
	background-color: white;
	border-color: #d2d8d0;
}
.heardTr {
	background-color: #ebf1e9;
	height: 41px;
	color: black;
}
.h5Button {
	display: inline-block;
}
.timeTableShow td {
	height: 70px;
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
</style>
<script>
let locationHref = window.location.href;
let lecNo = '';
$(function(){
	
	// 강의목록 출력 함수 호출
	lecList();
	
	// 장바구니 출력 함수 호출
	cartList();
	
	// 시간표 테이블 호출
	timeTable()
	
	let gubun = $('select[name="gubun"]');
	let type= $('select[name="type"]');
	let lecName = $('#lecName');
	let profName = $('#profName');
	let lecScore = $('#lecScore');
	let dept = $('select[name="dept"]');
	
	console.log("locationHref >> ", locationHref);

	$('.search').on('click', function(){
		let gubunTemp = gubun.val() != null ? gubun.val() : "";
		let typeTemp = type.val() != null ? type.val() : "";
		let lecNameTemp = lecName.val() != null ? lecName.val() : "";
		let profNameTemp = profName.val() != null ? profName.val() : "";
		let lecScoreTemp = lecScore.val() != null ? lecScore.val() : "";
		let deptTemp = dept.val() != null ? dept.val() : "";
		
		
		if(isNaN(lecScoreTemp)){
			Swal.fire({
				  icon: "error",
				  text: "학점에 숫자만 입력해주세요",
				  timer:'1500'
				});
			return;
		}
		
		let data = {
			'lecDiv':gubunTemp,
			'lecType':typeTemp,
			'lecName':lecNameTemp,
			'userName':profNameTemp,
			'lecScore':lecScoreTemp,
			'comDetCode':deptTemp
		}
		
		console.log(data);
		
		$.ajax({
			url:"/lecture/searchLecAjax",
			contentType:"application/json;charset=utf-8",
			data:JSON.stringify(data),
			type:"post",
			dataType:"json",
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
			success:function(result){
// 				console.log(result.lectureSearchList)
				
				let str = "";
				
				if(result.lectureSearchList.length == 0) {
					str += `<tr>`;
					str += `<td colspan="12" style="text-align:center; font-size:30px; color:#8C9090;">검색 결과가 없습니다.</td>`;
					str += `</tr>`;
				}
				
				$.each(result.lectureSearchList, function(idx, lecture){
					console.log("lecture >>> ",lecture)
					console.log("lecture.userInfoVO >>> ", lecture.userInfoVO)
					str += `
							<tr style="cursor:pointer" class="lecList" data-toggle="modal" data-target="#lecPlanModal"
								data-lecno="\${lecture.lecNo}" onclick="fSyllabus()">
							<td onclick='event.stopPropagation()'>\${idx+1}</td>
							<td onclick="event.stopPropagation()">`;

					// result.cartList에 해당 lecture가 있는지 확인
				    let inCart = false;
				    for (let i = 0; i < result.cartList.length; i++) {
				        if (result.cartList[i].lecNo === lecture.lecNo) {
				            inCart = true;
				            break;
				        }
				    }
				    
				 	// 조건에 따라 다른 버튼 추가
				    if (inCart) {
				        str += `<button type="button" class="btn btn-outline-danger btn-xs col-12 cart-in" disabled>담김</button>`;
				    } else {
				        str += `<button type="button" class="btn btn-outline-primary btn-xs col-12 cart-in" value="\${lecture.lecNo}"
				        onclick="cartIn(this)">담기</button>`;
				    }
							    
					str += `</td>
							<td>\${lecture.lecDiv}</td>
							<td>\${lecture.lecType}</td>`;
							if(lecture.lecGrade == 0){
								str += `<td>전학년</td>`;
							} else {
								str += `<td>\${lecture.lecGrade}학년</td>`;
							}	
					str += `<td>\${lecture.lecScore}학점</td>
							<td class="text-left">\${lecture.comDetCodeVO.comDetCodeName}</td>
							<td>\${lecture.userInfoVO.userName}</td>
							<td>\${lecture.lecPer}명</td>
							<td class="text-left">\${lecture.lecName}</td>
							<td class="text-left">\${lecture.lecDay}</td>
							<td>\${lecture.lectureRoomVO.lecRoName}</td>
							</tr>
						`;
				});
				$("#search-trShow").html(str);
				
				console.log('강의계획서 출력');
				
				$(".lecList").on("click",function(){
					let lecNo2 = $(this).data('lecno');
					
					let data = {
						"lecNo":lecNo2
					}
					
					console.log("조회할 강의 번호",data)
					
					if(lecNo2 != null && lecNo2 != ''){
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
			    				
			    				let lecName2 = result.lecName;
			    				let lecGrade2 = result.lecGrade + '학년';
			    				let lecScore2 = result.lecScore + '학점';
			    				let college2 = result.comCodeVO.comCodeName;
			    				let dept2 = result.comDetCodeVO.comDetCodeName;
			    				let lecRoName2 = result.lectureRoomVO.lecRoName;
			    				let lecDiv2 = result.lecDiv;
			    				let lecType2 = result.lecType;
			    				let lecPer2 = result.lecPer + '명';
			    				let lecDays = result.lecDay;
			    				
			    				$('#lecName2').text(lecName2);
			    				$('#lecGrade2').text(lecGrade2);
			    				$('#lecScore2').text(lecScore2);
			    				$('#college2').text(college2);
			    				$('#dept2').text(dept2);
			    				$('#lecRoName2').text(lecRoName2);
			    				$('#lecDiv2').text(lecDiv2);
			    				$('#lecType2').text(lecType2);
			    				$('#lecPer2').text(lecPer2);
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
					};
					
				});// ajax 끝
			}
		})
	})
});

function timeTable(){
	console.log("timeTable 호출")
	console.log($('.timeTableShow').html(`
											<tr>
								            <td>1교시</td>
								            <td class="lectureMon1"></td>
								            <td class="lectureTue1"></td>
								            <td class="lectureWed1"></td>
								            <td class="lectureThu1"></td>
								            <td class="lectureFri1"></td>
								        </tr>
								        <tr>
								            <td>2교시</td>
								            <td class="lectureMon2"></td>
								            <td class="lectureTue2"></td>
								            <td class="lectureWed2"></td>
								            <td class="lectureThu2"></td>
								            <td class="lectureFri2"></td>
								        </tr>
								        <tr>
								            <td>3교시</td>
								            <td class="lectureMon3"></td>
								            <td class="lectureTue3"></td>
								            <td class="lectureWed3"></td>
								            <td class="lectureThu3"></td>
								            <td class="lectureFri3"></td>
								        </tr>
								        <tr>
								            <td>4교시</td>
								            <td class="lectureMon4"></td>
								            <td class="lectureTue4"></td>
								            <td class="lectureWed4"></td>
								            <td class="lectureThu4"></td>
								            <td class="lectureFri4"></td>
								        </tr>
								        <tr>
								            <td>5교시</td>
								            <td class="lectureMon5"></td>
								            <td class="lectureTue5"></td>
								            <td class="lectureWed5"></td>
								            <td class="lectureThu5"></td>
								            <td class="lectureFri5"></td>
								        </tr>
								        <tr>
								            <td>6교시</td>
								            <td class="lectureMon6"></td>
								            <td class="lectureTue6"></td>
								            <td class="lectureWed6"></td>
								            <td class="lectureThu6"></td>
								            <td class="lectureFri6"></td>
								        </tr>
								        <tr>
								            <td>7교시</td>
								            <td class="lectureMon7"></td>
								            <td class="lectureTue7"></td>
								            <td class="lectureWed7"></td>
								            <td class="lectureThu7"></td>
								            <td class="lectureFri7"></td>
								        </tr>
								        <tr>
								            <td>8교시</td>
								            <td class="lectureMon8"></td>
								            <td class="lectureTue8"></td>
								            <td class="lectureWed8"></td>
								            <td class="lectureThu8"></td>
								            <td class="lectureFri8"></td>
								        </tr>
								        <tr>
								            <td>9교시</td>
								            <td class="lectureMon9"></td>
								            <td class="lectureTue9"></td>
								            <td class="lectureWed9"></td>
								            <td class="lectureThu9"></td>
								            <td class="lectureFri9"></td>
								        </tr>`
        ))
	
	//아작나써유..(피)씨다타써...
	$.ajax({
		url: "/lecture/timeTableListAjax", //ajax용 url 변경
		type:"get",
		dataType:"json",
		success:function(result){
			console.log("result.length : ",result.length);
			
			for(let i=0; i<result.length; i++) {	
				let lecNo = result[i].lecNo; //강의 번호
				let lecName = result[i].lectureVOList[0].lecName; //강의명
				let lecRoName = result[i].lectureRoomVOList[0].lecRoName; //강의실명
				let lecCol = result[i].lectureVOList[0].lecCol; //색상 코드
				for(let j = 0; j<result[i].lecTimeVOList.length; j++){
				
					let lecDay = result[i].lecTimeVOList[j].lecDay; //강의 요일
					let lecSt = result[i].lecTimeVOList[j].lecSt; //강의 시작 교시
					let lecEnd = result[i].lecTimeVOList[j].lecEnd; //강의 종료 교시
					
					console.log(lecNo,', ',lecName,', ',lecRoName,', ',lecCol,', ',lecDay,', ',lecSt,', ',lecEnd);
					weekCheck(lecNo, lecName, lecRoName, lecCol, lecDay, lecSt, lecEnd);
				}
			}
			
		},
	    error: function (request, status, error) {
	        console.log("code: " + request.status)
	        console.log("message: " + request.responseText)
	        console.log("error: " + error);
	    }
	});
	
	// 요일 확인
	function weekCheck(lecNo, lecName, lecRoName, lecCol, lecDay, lecSt, lecEnd) {
//	 	console.log("lecDay : ", lecDay);
		
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
//	 	console.log("교시 확인! : ", classTemp, lecSt, lecEnd);

		
		
		for(let i=lecSt; i<=lecEnd; i++) {
			let classNum = classTemp + i;
			document.getElementsByClassName(classNum)[0].style.backgroundColor = lecCol;
			let str = "";
			str += lecName + "<br>";
			str += lecRoName;
			
			document.getElementsByClassName(classNum)[0].style.color = "white"; // 회의해보기
			document.getElementsByClassName(classNum)[0].innerHTML = str;
		}
	}
}

function lecList(){
	console.log("강의목록")
	
	$.ajax({
			url:"/lecture/listAjax",
			contentType:"application/json;charset=utf-8",
			type:"post",
			dataType:"json",
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
			success:function(result){
// 				console.log("result.cartList",result.cartList)
				
				let str = "";
				
				
				$.each(result.lectureList, function(idx, lecture){
// 					console.log("lecture >>> ",lecture)
// 					console.log("lecture.userInfoVO >>> ", lecture.userInfoVO)
					str += `
							<tr style="cursor:pointer" class="lecList" data-toggle="modal" data-target="#lecPlanModal"
								data-lecno="\${lecture.lecNo}">
							<td onclick='event.stopPropagation()'>\${idx+1}</td>
							<td onclick="event.stopPropagation()">`;

					// result.cartList에 해당 lecture가 있는지 확인
				    let inCart = false;
				    for (let i = 0; i < result.cartList.length; i++) {
				        if (result.cartList[i].lecNo === lecture.lecNo) {
				            inCart = true;
				            break;
				        }
				    }
				    
				 	// 조건에 따라 다른 버튼 추가
				    if (inCart) {
				        str += `<button type="button" class="btn btn-outline-danger btn-xs col-12 cart-in" disabled>담김</button>`;
				    } else {
				        str += `<button type="button" class="btn btn-outline-primary btn-xs col-12 cart-in" value="\${lecture.lecNo}"
				        onclick="cartIn(this)">담기</button>`;
				    }
							    
					str += `</td>
							<td>\${lecture.lecDiv}</td>
							<td>\${lecture.lecType}</td>`;
					if(lecture.lecGrade == 0){
						str += `<td>전학년</td>`;
					} else {
						str += `<td>\${lecture.lecGrade}학년</td>`;
					}
							
					str += `<td>\${lecture.lecScore}학점</td>
							<td class="text-left">\${lecture.comDetCodeVO.comDetCodeName}</td>
							<td>\${lecture.userInfoVO.userName}</td>
							<td>\${lecture.lecPer}명</td>
							<td class="text-left">\${lecture.lecName}</td>
							<td class="text-left">\${lecture.lecDay}</td>
							<td>\${lecture.lectureRoomVO.lecRoName}</td>
							</tr>
						`;
				});
				$("#search-trShow").html(str);
				
				console.log('강의계획서 출력');
				
				$(".lecList").on("click",function(){
					let lecNo2 = $(this).data('lecno');
					
					let data = {
						"lecNo":lecNo2
					}
					
					console.log("조회할 강의 번호",data)
					
					if(lecNo2 != null && lecNo2 != ''){
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
			    				
			    				let lecName2 = result.lecName;
// 			    				let lecGrade2 = result.lecGrade + '학년';
			    				let lecGrade2 = '';
			    				if(result.lecGrade == 0){
			    					lecGrade2 = '전학년';
								} else {
			    					lecGrade2 = result.lecGrade + '학년';
								}
			    				let lecScore2 = result.lecScore + '학점';
			    				let college2 = result.comCodeVO.comCodeName;
			    				let dept2 = result.comDetCodeVO.comDetCodeName;
			    				let lecRoName2 = result.lectureRoomVO.lecRoName;
			    				let lecDiv2 = result.lecDiv;
			    				let lecType2 = result.lecType;
			    				let lecPer2 = result.lecPer + '명';
			    				let lecDays = result.lecDay;
			    				
			    				$('#lecName2').text(lecName2);
			    				$('#lecGrade2').text(lecGrade2);
			    				$('#lecScore2').text(lecScore2);
			    				$('#college2').text(college2);
			    				$('#dept2').text(dept2);
			    				$('#lecRoName2').text(lecRoName2);
			    				$('#lecDiv2').text(lecDiv2);
			    				$('#lecType2').text(lecType2);
			    				$('#lecPer2').text(lecPer2);
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
					};
					
				});// ajax 끝
			}
		})
	
}

function cartList(){
	console.log('내 강의목록 출력')
	let mySumGrade = $('.rhkahrtn');
	
	$.ajax({
		url:"/lecture/cartList",
		contentType:"application/json;charset=utf-8",
		type:"post",
		dataType:"json",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success:function(result){
// 			console.log(result.cartList)
			mySumGrade.text(`과목 수 : \${result.
				countLec}건, 총 학점 : \${result.sumLecScore}`);
			
			let str = '';
			
			if(result.cartList.length == 0) {
				str += `<tr>`;
				str += `<td colspan="8" style="text-align:center;">장바구니가 비어있습니다.</td>`;
				str += `</tr>`;
			}
			
			
			$.each(result.cartList, function(idx, cartVO){
				$.each(cartVO.lectureVOList, function(index, lectureVO){
					$.each(cartVO.userInfoVOList, function(index, userInfoVO){
						$.each(cartVO.lectureRoomVOList, function(index, lectureRoomVO){
								str += `<tr class="myCart">`;
								str += `<td>`;
								str += `\${idx+1}`;
								str += `<input name="cartLecNo" class="cartLecNo" type="hidden" value="\${lectureVO.lecNo}">`;
								str += `</td>`;
								str += `<td>\${lectureVO.lecDiv}</td>`;
								if(lectureVO.lecGrade == 0){
									str += `<td>전학년</td>`;
								} else {
									str += `<td>\${lectureVO.lecGrade}학년</td>`;
								}
								str += `<td>\${lectureVO.lecScore}학점</td>`;
								str += `<td>\${userInfoVO.userName}</td>`;
								str += `<td>\${lectureVO.lecPer}명</td>`;
								str += `<td  class="text-left">`;
								str += `\${lectureVO.lecName} / `;
								str += `\${cartVO.stuLecDay} / `;
								str += `\${lectureRoomVO.lecRoName}`;
								str += `</td>`;
								str += `<td>`;
								str += `<button type="button" class="btn btn-outline-danger btn-xs col-12 cart-in" value="\${lectureVO.lecNo}"`;
								str += `onclick="cartOut(this)">취소</button>`;
								str += `</td>`;
								str += `</tr>`;
						})
					})
				})
			})
			$('#card-trShow').html(str);
		}
	})
}
function cartIn(e){
	lecNo = e.value;
	let btn = $('.cartIn')
	
	let data = {
		lecNo
	}
	
	$.ajax ({
		url:"/lecture/insertCart",
		contentType:"application/json;charset=utf-8",
		data:JSON.stringify(data),
		type:"post",
		dataType:"text",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success:function(result){
// 			console.log(result)
			if(result > 0){
// 				Swal.fire({
// 					  title: "장바구니에 담겼습니다.",
// 					  icon: "success",
// 					  timer: 1500
// 					});
				cartList();
				lecList();
				timeTable();
			}
		}
	})
}
function cartOut(e){
	lecNo = e.value;
	console.log(lecNo)
	
	let data = {
		lecNo
	}
	
	const Toast = Swal.mixin({
        toast: true,
        position: 'center',
        showConfirmButton: false,
        timer: 300000,
    });

    Swal.fire({
    	  title: "관심과목을 제거하시겠습니까?",
    	  icon: "warning",
    	  showCancelButton: true,
    	  confirmButtonColor: "#3085d6",
    	  cancelButtonColor: "#d33",
    	  confirmButtonText: "예",
    	  cancelButtonText:"아니오"
    	}).then((result) => {
    	  if (result.isConfirmed) {
    		  $.ajax ({
   				url:"/lecture/deleteCart",
   				contentType:"application/json;charset=utf-8",
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
  			    	      title: "제거되었습니다!",
  			    	      icon: "success"
  			    	    });
   						cartList();
   						lecList();
   						timeTable();
   					}
   				}
   			})
    	  }
	})
	
}
//요일 확인
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
	
	for(let i=lecSt; i<=lecEnd; i++) {
		let classNum = classTemp + i;
		document.getElementsByClassName(classNum)[0].style.backgroundColor = lecCol;
		let str = "";
		str += lecName + "<br>";
		str += lecRoName;
		
		document.getElementsByClassName(classNum)[0].style.color = "white";
		document.getElementsByClassName(classNum)[0].innerHTML = str;
	}
}
</script>
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
				<td id="lecName2"style="width: 250px;"></td>
					<th class="w130px">수강 학년</th>
					<td id="lecGrade2"></td>
					<th class="w130px">학점</th>
					<td id="lecScore2"></td>
				</tr>
				<tr>
					<th class="w150px">단과대학</th>
					<td id="college2"></td>
					<th class="w130px">학과</th>
					<td id="dept2"></td>
					<th class="w130px">강의실</th>
					<td id="lecRoName2"></td>
				</tr>
				<tr>
					<th class="w150px">이수구분</th>
					<td id="lecDiv2"></td>
					<th class="w130px">강의영역</th>
					<td id="lecType2"></td>
					<th class="w130px">수강최대인원</th>
					<td id="lecPer2"></td>
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
<h3>관심 과목 등록</h3>
<h5 style="color:black;">수강 학점 현황</h5>
<div class="row">
    <div class="col-12">
        <div class="card">
            <div class="card-body table-responsive p-0">
                <table class="table table-hover text-nowrap">
                    <thead>
                        <tr class="trBackground" style="color:black;">
                            <th colspan='3'>전공 영역</th>
                            <th colspan='3'>교양 영역</th>
                            <th rowspan='2' style="vertical-align: middle;">총 취득 학점</th>
                        </tr>
                        <tr class="trBackground" style="color:black;">
                            <th>전필</th>
                            <th>전선</th>
                            <th>소계</th>
                            <th>교필</th>
                            <th>교선</th>
                            <th>소계</th>
                        </tr>
                    </thead>
                    <tbody id="trShow" class="text-center">
                        <tr>
                            <td>${hakjum.junpil}</td>
                            <td>${hakjum.junsun}</td>
                            <td>${hakjum.junpil+hakjum.junsun}</td>
                            <td>${hakjum.gyopil}</td>
                            <td>${hakjum.gyosun}</td>
                            <td>${hakjum.gyopil+hakjum.gyosun}</td>
                            <td>${hakjum.junpil+hakjum.junsun+hakjum.gyopil+hakjum.gyosun}</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <div>
		<h4 class="text-left">강의 검색</h4>
	</div>
    <div class="col-12">
        <div class="card">
			<form action="" id="form">
				<div class="card-body">
					<select class="form-control col-1" name="gubun" id="gubun" style="margin-right: 50px;">
						<option value="" selected>이수 구분</option>                    
						<option value="1">전필</option>                
						<option value="2">전선</option>                
						<option value="3">교필</option>                
						<option value="4">교선</option>                
					</select>
					<select class="form-control col-1" name="type" id="type" style="margin-right: 50px;">
						<option value="" selected>강의 영역</option>                    
						<option value="1">자연</option>                
						<option value="2">인문</option>                
						<option value="3">음악</option>                
						<option value="4">컴퓨터</option>                
						<option value="5">경영</option>                
					</select>
					<select class="form-control deptSelect" name="dept" id="dept" style="margin-right: 50px; width:150px;">
						<option value="" selected>학과 선택</option>
                            <c:forEach var="comCodeVO" items="${deptList}" varStatus="stat">
                                <c:forEach var="dept" items="${comCodeVO.comDetCodeVOList}" varStatus="stat">
                                    <option value="${dept.comDetCode}">${dept.comDetCodeName}</option>
                                </c:forEach>	
                            </c:forEach>              
					</select>
                    <label for="profName">교수명 :&nbsp;</label>
                    <input type="text" class="form-control col-1" id="profName" name="profName" style="margin-right: 50px;">
                    <label for="lecScore">학점 :&nbsp;</label>
                    <input type="text" class="form-control col-1" id="lecScore" name="lecScore" style="margin-right: 50px;">
					<label for="lecName">강의명 :&nbsp;</label>
					<input type="text" class="form-control col-2" id="lecName" name="lecName" style="margin-right: 50px;">
					<button type="button" class="btn btn-outline-primary col-1 search">조&nbsp;&nbsp;&nbsp;회</button>
				</div>
			</form>
        </div>
    </div>
    <div class="text-left">
	    <h4 style="color:black;">검색 결과</h4>
	    <h6 style="margin-top:5px;"><i class="fas fa-check bg-green" 
					   style="
							color: #fff !important;
							background-color: #28a745 !important;
							background-color: #adb5bd;
							border-radius: 50%;
							font-size: 10px;
							height: 20px;
							line-height: 20px;
							text-align: center;
							top: 0;
							width: 20px;
						  	"
					></i>
		클릭시 강의계획서를 열람하실 수 있습니다.</h6>
	</div>
    <div class="col-12">
		<div class="card">
            <div class="card-body table-responsive p-0 search-table">
                <table class="table table-hover text-nowrap lectureList">
                	<colgroup>
                		<col style="width:5%">
                		<col style="width:10%">
                		<col style="width:5%">
                		<col style="width:5%">
                		<col style="width:7%">
                		<col style="width:7%">
                		<col style="width:8%">
                		<col style="width:7%">
                		<col style="width:5%">
                		<col style="">
                		<col style="width:9%">
                		<col style="width:10%">
                	</colgroup>
                    <thead>
                        <tr class="trBackground" style="color:black;">
                            <th>번호</th>
							<th>담기</th>
							<th>이수구분</th>
							<th>강의영역</th>
							<th>학년</th>
							<th>학점</th>
							<th>개설학과</th>
							<th>교수</th>
							<th>최대인원</th>
							<th>강의명</th>
							<th>강의시간</th>
							<th>강의실</th>
                        </tr>
                    </thead>
                    <tbody id="search-trShow" class="text-center scroll">
						<!-- 강의 리스트 출력 영역 -->
                    </tbody>
                </table>
            </div>
        </div>
    </div>
  	<h5 style="color:black;" class="col-12 rhkahrtn"></h5>
  <h6><i class="fas fa-check bg-green" 
					   style="
							color: #fff !important;
							background-color: #28a745 !important;
							background-color: #adb5bd;
							border-radius: 50%;
							font-size: 10px;
							height: 20px;
							line-height: 20px;
							text-align: center;
							top: 0;
							width: 20px;
						  	"
					></i>
					관심 과목 등록은 과목 수와 학점의 제한이 없습니다.</h6>
  	<div class="col-12" style="display:flex;">
	    <div class="col-7" style="margin-bottom:50px; padding:0px;">
			<div class="card">
	            <div class="card-body table-responsive p-0">
	                <table class="table table-hover text-nowrap">
	                	<colgroup>
	                		<col style="width:5%">
	                		<col style="width:7%">
	                		<col style="width:7%">
	                		<col style="width:7%">
	                		<col style="width:10%">
	                		<col style="width:7%">
	                		<col style="">
	                		<col style="width:12%">
	                	</colgroup>
	                    <thead>
	                        <tr class="trBackground" style="color:black;">
	                            <th>번호</th>
								<th>이수구분</th>
								<th>학년</th>
								<th>학점</th>
								<th>교수</th>
								<th>최대인원</th>
								<th>과목명/강의시간/강의실</th>
								<th>취소</th>
	                        </tr>
	                    </thead>
	                    <tbody id="card-trShow" class="text-center">
	                    	<!-- myCartList 함수 출력 위치 -->
	                    </tbody>
	                </table>
	            </div>
	        </div>
	    </div>
		<div class="col-5 timeTable">
		    <table border="1" class="tbe">
		        <thead>
		            <tr class="heardTr" style="height: 5.5vh;" style="color:black;">
		                <th>교시</th>
		                <th>월</th>
		                <th>화</th>
		                <th>수</th>
		                <th>목</th>
		                <th>금</th>
		            </tr>
		        </thead>
		        <tbody class="timeTableShow">
		            <tr>
		                <td>1교시</td>
		                <td class="lectureMon1"></td>
		                <td class="lectureTue1"></td>
		                <td class="lectureWed1"></td>
		                <td class="lectureThu1"></td>
		                <td class="lectureFri1"></td>
		            </tr>
		            <tr>
		                <td>2교시</td>
		                <td class="lectureMon2"></td>
		                <td class="lectureTue2"></td>
		                <td class="lectureWed2"></td>
		                <td class="lectureThu2"></td>
		                <td class="lectureFri2"></td>
		            </tr>
		            <tr>
		                <td>3교시</td>
		                <td class="lectureMon3"></td>
		                <td class="lectureTue3"></td>
		                <td class="lectureWed3"></td>
		                <td class="lectureThu3"></td>
		                <td class="lectureFri3"></td>
		            </tr>
		            <tr>
		                <td>4교시</td>
		                <td class="lectureMon4"></td>
		                <td class="lectureTue4"></td>
		                <td class="lectureWed4"></td>
		                <td class="lectureThu4"></td>
		                <td class="lectureFri4"></td>
		            </tr>
		            <tr>
		                <td>5교시</td>
		                <td class="lectureMon5"></td>
		                <td class="lectureTue5"></td>
		                <td class="lectureWed5"></td>
		                <td class="lectureThu5"></td>
		                <td class="lectureFri5"></td>
		            </tr>
		            <tr>
		                <td>6교시</td>
		                <td class="lectureMon6"></td>
		                <td class="lectureTue6"></td>
		                <td class="lectureWed6"></td>
		                <td class="lectureThu6"></td>
		                <td class="lectureFri6"></td>
		            </tr>
		            <tr>
		                <td>7교시</td>
		                <td class="lectureMon7"></td>
		                <td class="lectureTue7"></td>
		                <td class="lectureWed7"></td>
		                <td class="lectureThu7"></td>
		                <td class="lectureFri7"></td>
		            </tr>
		            <tr>
		                <td>8교시</td>
		                <td class="lectureMon8"></td>
		                <td class="lectureTue8"></td>
		                <td class="lectureWed8"></td>
		                <td class="lectureThu8"></td>
		                <td class="lectureFri8"></td>
		            </tr>
		            <tr>
		                <td>9교시</td>
		                <td class="lectureMon9"></td>
		                <td class="lectureTue9"></td>
		                <td class="lectureWed9"></td>
		                <td class="lectureThu9"></td>
		                <td class="lectureFri9"></td>
		            </tr>
		        </tbody>
		    </table>
	    </div>
    </div>
</div>

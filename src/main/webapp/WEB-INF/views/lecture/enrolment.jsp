<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- <link href="https://maxcdn.bootstrapcdn.com	/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet"> -->
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
  margin-top: 40px;
  margin-left: 15px;
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
  color: black;
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
	display: flex;
	margin-top: 30px;
	margin-bottom: 10px;
	margin-left: 0px;
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
.myLecInfo {
	margin-top: 30px;
/* 	margin-left: 15px; */
}
.timeTableShow td {
	height: 70px;
}
.cart {
	background-color:white; 
}
</style>
<script>
let locationHref = window.location.href;
let lecNo = '';
let lecSumGrade = '';
$(function(){
	
	// 강의목록 출력 함수 호출
	lecList();
	
	// 장바구니 출력 함수 호출
	enrolList();
	
// 	// 시간표 테이블 호출
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
			url:"/lecture/searchLecEnrolment",
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
					str += `<td colspan="11" style="text-align:center; font-size:30px; color:#8C9090;">검색 결과가 없습니다.</td>`;
					str += `</tr>`;
				}
				
// 				console.log("result >>> ",result.lectureSearchList[0].stuCount) 
				$.each(result.lectureSearchList, function(idx, lecture){
// 					console.log("lecture.lecPer >>> ",lecture.lecPer) 
					str += `
							<tr>
							<td onclick='event.stopPropagation()'>\${idx+1}</td>
							<td onclick="event.stopPropagation()">`;

					// result.myLecList에 해당 lecture가 있는지 확인
				    let inCart = false;
				    for (let i = 0; i < result.myLecList.length; i++) {
				        if (result.myLecList[i].lecNo === lecture.lecNo) {
				            inCart = true;
				            break;
				        }
				    }
				    
				 	// 조건에 따라 다른 버튼 추가
				    if(lecture.stuCount < lecture.lecPer) {
					    if (inCart) {
					        str += `<button type="button" class="btn btn-outline-success btn-xs col-10" disabled>신청 완료</button>`;
					    } else {
					        str += `<button type="button" class="btn btn-outline-primary btn-xs col-10" value="\${lecture.lecNo}"
					        onclick="application(this)">신청하기</button>`;
					    }
				 	}
				 	else {
				 		str += `<button type="button" class="btn btn-outline-secondary btn-xs col-10" disabled>마감</button>`;
				 	}
							    
					str += `</td>
							<td class="lecDiv">\${lecture.lecDiv}</td>
							<td>\${lecture.lecType}</td>`;
							if(lecture.lecGrade == 0){
								str += `<td>전학년</td>`;
							} else {
								str += `<td>\${lecture.lecGrade}학년</td>`;
							}
					str += `<td>\${lecture.lecScore}학점</td>
							<td>\${lecture.comDetCodeVO.comDetCodeName}</td>
							<td>\${lecture.userInfoVO.userName}</td>
							<td>\${lecture.lecPer}명</td>
							<td class="text-left">\${lecture.lecName}</td>
							<td class="text-left">\${lecture.lecDay}</td>
							<td>\${lecture.lectureRoomVO.lecRoName}</td>
							</tr>
						`;
				});
				$("#search-trShow").html(str);
			}
		})
	})
	
	$('.cart').on('click', function(){

		$.ajax({
			url:"/lecture/myCartList",
			contentType:"application/json;charset=utf-8",
			type:"post",
			dataType:"json",
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
			success:function(result){
	// 			console.log(result.cartList)
				
				let str = '';
				
				if(result.cartList.length == 0) {
					str += `<tr>`;
					str += `<td colspan="11" style="text-align:center; font-size:30px; color:#8C9090;">장바구니가 비어있습니다.</td>`;
					str += `</tr>`;
				}
				
				
				$.each(result.cartList, function(idx, cartVO){
// 					console.log(cartVO)
					$.each(cartVO.lectureVOList, function(index, lectureVO){
						$.each(cartVO.userInfoVOList, function(index, userInfoVO){
							$.each(cartVO.lectureRoomVOList, function(index, lectureRoomVO){
								$.each(cartVO.comDetCodeVOList, function(index, comDetCodeVO){
								str += `
									<tr onclick="fSyllabus()">
									<td onclick='event.stopPropagation()'>\${idx+1}</td>
									<td onclick="event.stopPropagation()">`;
									
								// result.cartList에 해당 lecture가 있는지 확인
							    let inCart = false;
							    for (let i = 0; i < result.myLecList.length; i++) {
							        if (result.myLecList[i].lecNo === lectureVO.lecNo) {
							            inCart = true;
							            break;
							        }
							    }
							    
							 	// 조건에 따라 다른 버튼 추가
// 							    if (inCart) {
// 							        str += `<button type="button" class="btn btn-outline-danger btn-xs col-10 cart-in" disabled>신청 완료</button>`;
// 							    } else {
// 							        str += `<button type="button" class="btn btn-outline-primary btn-xs col-10 cart-in" value="\${lectureVO.lecNo}"
// 							        onclick="application(this)">신청하기</button>`;
// 							    }
							    if(lectureVO.stuCount < lectureVO.lecPer) {
								    if (inCart) {
								        str += `<button type="button" class="btn btn-outline-success btn-xs col-10" disabled>신청 완료</button>`;
								    } else {
								        str += `<button type="button" class="btn btn-outline-primary btn-xs col-10" value="\${lectureVO.lecNo}"
								        onclick="application(this)">신청하기</button>`;
								    }
							 	}
							 	else {
							 		str += `<button type="button" class="btn btn-outline-secondary btn-xs col-10" disabled>마감</button>`;
							 	}
								str += `</td>
									<td class="lecDiv">\${lectureVO.lecDiv}</td>
									<td>\${lectureVO.lecType}</td>`;
									
									if(lectureVO.lecGrade == 0){
										str += `<td>전학년</td>`;
									} else {
										str += `<td>\${lectureVO.lecGrade}학년</td>`;
									}
									
								str += `<td>\${lectureVO.lecScore}학점</td>
									<td class="text-left">\${comDetCodeVO.comDetCodeName}</td>
									<td>\${userInfoVO.userName}</td>
									<td>\${lectureVO.lecPer}명</td>
									<td class="text-left">\${lectureVO.lecName}</td>
									<td class="text-left">\${cartVO.stuLecDay}</td>
									<td>\${lectureRoomVO.lecRoName}</td>
									</tr>`;
								});
							})
						})
					})
				})
				$('#search-trShow').html(str);
			}
		})
	
	})
	
});
	
function lecList(){
	console.log("강의목록")
	
	$.ajax({
			url:"/lecture/lecList",
			contentType:"application/json;charset=utf-8",
			type:"post",
			dataType:"json",
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
			success:function(result){
// 				console.log("result >>> ",result)
				
				let str = "";
				
				$.each(result.lectureList, function(idx, lecture){
// 					console.log("최대 수강 인원 >>> ",lecture.lecPer)
// 					console.log("현재 수강 인원 >>> ",lecture.stuCount)
// 					console.log("lecture.userInfoVO >>> ", lecture.userInfoVO)
					str += `
							<tr onclick="fSyllabus()">
							<td onclick='event.stopPropagation()'>\${idx+1}</td>
							<td onclick="event.stopPropagation()">`;

					// result.myLecList에 해당 lecture가 있는지 확인
				    let inCart = false;
				    for (let i = 0; i < result.myLecList.length; i++) {
				        if (result.myLecList[i].lecNo === lecture.lecNo) {
				            inCart = true;
				            break;
				        }
				    }
				    
				 	// 조건에 따라 다른 버튼 추가
				 	if(lecture.stuCount < lecture.lecPer) {
					    if (inCart) {
					        str += `<button type="button" class="btn btn-outline-success btn-xs col-10" disabled>신청 완료</button>`;
					    } else {
					        str += `<button type="button" class="btn btn-outline-primary btn-xs col-10" value="\${lecture.lecNo}"
					        onclick="application(this)">신청하기</button>`;
					    }
				 	}
				 	else {
				 		str += `<button type="button" class="btn btn-outline-secondary btn-xs col-10" disabled>마감</button>`;
				 	}
							    
					str += `</td>
							<td class="lecDiv">\${lecture.lecDiv}</td>
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
							<td  class="text-left">\${lecture.lecName}</td>
							<td class="text-left">\${lecture.lecDay}</td>
							<td>\${lecture.lectureRoomVO.lecRoName}</td>
							</tr>
						`;
				});
				$("#search-trShow").html(str);
			}
		})
	
}

function enrolList(){
	console.log('내 강의신청 목록')

	let mySumGrade = $('.rhkahrtn');
	
	$.ajax({
		url:"/lecture/myStuLec",
		type:"post",
		dataType:"json",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success:function(result){
// 			console.log(result)
			let str = '';
			$.each(result.myLecList, function(idx, stuLectureVO){
				
				str += `
						<tr class="myCart">
						<td>
						\${idx+1}
						<input name="cartLecNo" class="cartLecNo" type="hidden" value="\${stuLectureVO.lecNo}">
						</td>
						<td>\${stuLectureVO.stuLecDiv}</td>`;
						
						if(stuLectureVO.lectureVOList.lecGrade == 0){
							str += `<td>전학년</td>`;
						} else {
							str += `<td>\${stuLectureVO.lectureVOList.lecGrade}학년</td>`;
						}
						
				str += `<td>\${stuLectureVO.lectureVOList.lecScore}학점</td>
						<td>\${stuLectureVO.lectureVOList.userInfoVO.userName}</td>
						<td>\${stuLectureVO.lectureVOList.lecPer}명</td>
						<td class="text-left">
							\${stuLectureVO.lectureVOList.lecName} / 
							\${stuLectureVO.stuLecDay} / 
							\${stuLectureVO.lectureVOList.lectureRoomVO.lecRoName}
						</td>
						<td>
						<button type="button" class="btn btn-outline-danger btn-xs col-12" value="\${stuLectureVO.lecNo}"
						onclick="cancel(this)">강의 취소</button>
						</td>
						</tr>
					`;
			})
			
			$('#card-trShow').html(str);
			
			let mySumGrade = '';
			
// 			if(result.lecSum > 20){
// 				mySumGrade += `<h5>과목 수 : \${result.lecCount}건, 총 학점 : </h5><h5 style="color:red;">&nbsp;\${result.lecSum}</h5>`;
// 			}
// 			if(result.lecSum < 20){
				mySumGrade += `
					<h5 style="color: black; margin-left: 13px;">과목 수 : \${result.lecCount}건,&nbsp;&nbsp; 총 신청 학점 : \${result.lecSum} / 20</h5>
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
								margin-left: -65px;
							  	"
						></i>
						최대 20학점을 넘길 수 없습니다.</h6>
					`;
				
// 			}
			
			$('.myLecInfo').html(mySumGrade);
		}
	})
}
function application(e){
	lecNo = e.value;
	let lecDiv = e.parentElement.parentElement.querySelector('.lecDiv').innerText
	
// 	console.log(lecSumGrade)

	let data = {
		lecNo,
		lecDiv
	}
	
	$.ajax({
		url:"/lecture/checkTime",
		contentType:"application/json;charset=utf-8",
		data:JSON.stringify(data),
		type:"post",
		dataType:"text",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success:function(result){
			console.log(result)
			if(result == 1){
// 				console.log("result : " , result)
				$.ajax ({
					url:"/lecture/insertMyLec",
					contentType:"application/json;charset=utf-8",
					data:JSON.stringify(data),
					type:"post",
					dataType:"text",
					beforeSend:function(xhr){
						xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
					},
					success:function(insertResult){
						if(insertResult > 0){
							console.log("신청 성공")
							lecList();
							enrolList()
							timeTable();
						}
					}
				});
			} 
			if(result == 0){
				Swal.fire({
					  icon: "error",
					  title: "수강신청에 실패했습니다",
					  text: "중복된 강의시간입니다",
					});
				lecList();
				enrolList()
				timeTable();
				return;
			}
			if(result == 2){
				Swal.fire({
					  icon: "error",
					  title: "수강신청에 실패했습니다",
					  text: "자신의 학년보다 높은 학년의 수업은 신청할 수 없습니다",
					});
				lecList();
				enrolList()
				timeTable();
				return;
			}
			if(result == 3){
				Swal.fire({
					  icon: "error",
					  title: "수강신청에 실패했습니다",
					  text: "최대 20학점까지만 수강하실 수 있습니다",
					});
				lecList();
				enrolList()
				timeTable();
				return;
			}
			if(result == 4){
				Swal.fire({
					  icon: "error",
					  title: "수강신청에 실패했습니다",
					  text: "정원이 가득찼습니다",
					});
				lecList();
				enrolList()
				timeTable();
				return;
			}
// 			if(result == 5){
// 				Swal.fire({
// 					  icon: "error",
// 					  title: "수강신청에 실패했습니다",
// 					  text: "수강 했던 과목은 신청이 불가능합니다",
// 					});
// 				lecList();
// 				enrolList()
// 				timeTable();
// 				return;
// 			}
		}
	})
}
function cancel(e){
	lecNo = e.value;
// 	console.log(lecNo)
	
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
    	  title: "수강을 취소하시겠습니까??",
    	  icon: "warning",
    	  showCancelButton: true,
    	  confirmButtonColor: "#3085d6",
    	  cancelButtonColor: "#d33",
    	  confirmButtonText: "예",
    	  cancelButtonText:"아니오"
    	}).then((result) => {
    	  if (result.isConfirmed) {
    		  $.ajax ({
    			url:"/lecture/deleteMyLec",
    			contentType:"application/json;charset=utf-8",
   				data:JSON.stringify(data),
   				type:"post",
   				dataType:"text",
   				beforeSend:function(xhr){
    				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
    			},
    			success:function(result){
//    		 		console.log(result)
   					if(result > 0){
   						Swal.fire({
    			    	      title: "삭제되었습니다!",
    			    	      icon: "success"
    			    	    });
    					lecList();
    					enrolList()
    					timeTable();
    				}
    			}
    		});
    	  }
	})
}

function timeTable(){
	console.log("timeTable 호출")
	$('.timeTableShow').html(`
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
        )
	
	$.ajax({
		url: "/lecture/timeTableList", //ajax용 url 변경
		type:"get",
		dataType:"json",
		success:function(result){
			
			for(let i=0; i<result.length; i++) {	
// 				console.log(result)
				let lecNo = result[i].lecNo; //강의 번호
				let lecName = result[i].lectureVOList.lecName; //강의명
				let lecRoName = result[i].lectureVOList.lectureRoomVO.lecRoName; //강의실명
				let lecCol = result[i].lectureVOList.lecCol; //색상 코드
				for(let j = 0; j<result[i].lecTimeVOList.length; j++){
					
					let lecDay = result[i].lecTimeVOList[j].lecDay; //강의 요일
					let lecSt = result[i].lecTimeVOList[j].lecSt; //강의 시작 교시
					let lecEnd = result[i].lecTimeVOList[j].lecEnd; //강의 종료 교시
					
// 					console.log(lecNo,', ',lecName,', ',lecRoName,', ',lecCol,', ',lecDay,', ',lecSt,', ',lecEnd);
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
			
			document.getElementsByClassName(classNum)[0].style.color = "white";
			document.getElementsByClassName(classNum)[0].innerHTML = str;
		}
	}
}
</script>
<h3>수강신청</h3>
<h5 style="color: black;">수강 학점 현황</h5>
<div class="row">
	<div class="col-12">
		<div class="card">
			<div class="card-body table-responsive p-0">
				<table class="table table-hover text-nowrap">
					<thead>
						<tr class="trBackground">
							<th colspan='3'>전공 영역</th>
							<th colspan='3'>교양 영역</th>
							<th rowspan='2' style="vertical-align: middle;">총 취득 학점</th>
						</tr>
						<tr class="trBackground">
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
	<h4>강의 검색</h4>
	<div class="col-12">
		<div class="card">
			<form action="" id="form">
				<div class="card-body">
					<select class="form-control col-1" name="gubun" id="gubun"
						style="margin-right: 50px;">
						<option value="" selected>이수 구분</option>
						<option value="1">전필</option>
						<option value="2">전선</option>
						<option value="3">교필</option>
						<option value="4">교선</option>
					</select> <select class="form-control col-1" name="type" id="type"
						style="margin-right: 50px;">
						<option value="" selected>강의 영역</option>
						<option value="1">자연</option>
						<option value="2">인문</option>
						<option value="3">음악</option>
						<option value="4">컴퓨터</option>
						<option value="5">경영</option>
					</select> <select class="form-control col-1 deptSelect" name="dept"
						id="dept" style="margin-right: 50px;">
						<option value="" selected>학과 선택</option>
						<c:forEach var="comCodeVO" items="${deptList}" varStatus="stat">
							<c:forEach var="dept" items="${comCodeVO.comDetCodeVOList}"
								varStatus="stat">
								<option value="${dept.comDetCode}">${dept.comDetCodeName}</option>
							</c:forEach>
						</c:forEach>
					</select> <label for="profName">교수명 :&nbsp;</label> <input type="text"
						class="form-control col-1" id="profName" name="profName"
						style="margin-right: 50px;"> <label for="lecScore">학점
						:&nbsp;</label> <input type="text" class="form-control col-1"
						id="lecScore" name="lecScore" style="margin-right: 50px;">
					<label for="lecName">강의명 :&nbsp;</label> <input type="text"
						class="form-control col-2" id="lecName" name="lecName"
						style="margin-right: 50px;">
					<button type="button" class="btn btn-outline-primary col-1 search">조&nbsp;&nbsp;&nbsp;회</button>
				</div>
			</form>
		</div>
	</div>
	<div class="col-12 text-left"
		style="display: flex; align-items: flex-end; margin-bottom: 15px;">
		<h4 style="margin-left: 0px;">검색 결과</h4>
		<button style="width: 200px; height: 50px; margin-left: 1320px;"
			type="button" class="btn btn-block btn-outline-success btn-lg cart">
			내 관심 강의 조회</button>
	</div>
	<div class="col-12">
		<div class="card">
			<div class="card-body table-responsive p-0 search-table">
				<table class="table table-hover text-nowrap lectureList">
					<colgroup>
						<col style="width: 5%">
						<col style="width: 10%">
						<col style="width: 5%">
						<col style="width: 5%">
						<col style="width: 7%">
						<col style="width: 7%">
						<col style="width: 8%">
						<col style="width: 7%">
						<col style="width: 5%">
						<col style="">
						<col style="width: 9%">
						<col style="width: 10%">
					</colgroup>
					<thead>
						<tr class="trBackground">
							<th>번호</th>
							<th>신청</th>
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
	<div class="myLecInfo"></div>
	<div class="col-12" style="display: flex; padding: 0px;">
		<div class="col-7" style="margin-bottom: 50px;">
			<div class="card">
				<div class="card-body table-responsive p-0">
					<table class="table table-hover text-nowrap">
						<colgroup>
							<col style="width: 5%">
							<col style="width: 5%">
							<col style="width: 5%">
							<col style="width: 5%">
							<col style="width: 10%">
							<col style="width: 7%">
							<col style="">
							<col style="width: 12%">
						</colgroup>
						<thead>
							<tr class="trBackground">
								<th>번호</th>
								<th>이수구분</th>
								<th>학년</th>
								<th>학점</th>
								<th>교수</th>
								<th>최대인원</th>
								<th>과목명/강의시간/강의실</th>
								<th>강의취소</th>
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
					<tr class="heardTr" style="height: 5.5vh;">
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
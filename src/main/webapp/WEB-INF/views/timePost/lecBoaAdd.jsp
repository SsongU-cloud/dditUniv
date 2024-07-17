<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>  
<link type="text/css" href="/resources/ckeditor5/sample/css/sample.css" rel="stylesheet" media="screen" />
<script src="https://cdn.ckeditor.com/ckeditor5/11.0.1/classic/ckeditor.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.js"></script>
<html>
<head>

<style type="text/css">
h5 {
    margin-bottom: 30px;
    margin-top: 40px;
} 
.rkddmlrjfoBut {
	width: 165px;
    margin-top: 34px;
}
.tbe {
	height: 80vh;
	width: 93%;
	table-layout: fixed;
	text-align: center;
    margin-left: auto;
    margin-right: auto;
    margin-top: 50px;
	background-color: white;
	border-color: #d2d8d0;
}
.heardTr {
	height: 41px;
}
.h5Button {
	display: inline-block;
}    
.divSuburb {
    margin: auto;
    min-height: 678px;
    width: 80%;
}

.card-header {
    background-color: white;
}

.btnbtn {
    text-align: center;
}

.btncli {
    width: 105px;
    margin: auto;
    display: inline-block;
}

.btn-block+.btn-block {
    margin-top: 0;
}

h3 {
    color: black;
    margin-bottom: 30px;
    margin-top: 40px;
    margin-left: 165px;
} 

.hea {
    width: 70%;
    float: left;
}

.der {
    width: 28%;
    float: right;
}
 .card-body {
   padding: 2.25rem;
}
.card-header {
   padding: .75rem 2.25rem;
}
.lectureSchedule{
   height:80px;
}
</style>
</head>
<body>
<h3>강의자랑게시글 작성</h3>
<br>
<div class="card card-outline card-info divSuburb">
    <form id="frm" name="frm" action="#" method="post" enctype="multipart/form-data">
        <div class="card-body">
            <div class="hea">
                <label for="subject">제목</label> 
                <input type="text" id="subject" class="form-control" name="recuTitle" 
                    maxlength='45' placeholder="제목을 입력하세요." required/>
            </div>  
                
            <div class="der">
                <label for="gubun">학번</label> 
                <input type="text" class="selectSearch form-control" value="${stNo}" disabled>
            </div>
        </div>
		<br>
        <div>
            <table border="1" class="tbe">
                <thead>
                    <tr class="heardTr">
                        <th>교시</th>
                        <th>시간</th>
                        <th>월</th>
                        <th>화</th>
                        <th>수</th>
                        <th>목</th>
                        <th>금</th>
                    </tr>
                </thead>
                <tbody>
                    <tr class="lectureSchedule">
                        <td>1교시</td>
                        <td>09:00 ~ 09:50</td>
                        <td class="lectureMon1"></td>
                        <td class="lectureTue1"></td>
                        <td class="lectureWed1"></td>
                        <td class="lectureThu1"></td>
                        <td class="lectureFri1"></td>
                    </tr>
                    <tr class="lectureSchedule">
                        <td>2교시</td>
                        <td>10:00 ~ 10:50</td>
                        <td class="lectureMon2"></td>
                        <td class="lectureTue2"></td>
                        <td class="lectureWed2"></td>
                        <td class="lectureThu2"></td>
                        <td class="lectureFri2"></td>
                    </tr>
                    <tr class="lectureSchedule">
                        <td>3교시</td>
                        <td>11:00 ~ 11:50</td>
                        <td class="lectureMon3"></td>
                        <td class="lectureTue3"></td>
                        <td class="lectureWed3"></td>
                        <td class="lectureThu3"></td>
                        <td class="lectureFri3"></td>
                    </tr>
                    <tr class="lectureSchedule">
                        <td>4교시</td>
                        <td>12:00 ~ 12:50</td>
                        <td class="lectureMon4"></td>
                        <td class="lectureTue4"></td>
                        <td class="lectureWed4"></td>
                        <td class="lectureThu4"></td>
                        <td class="lectureFri4"></td>
                    </tr>
                    <tr class="lectureSchedule">
                        <td>5교시</td>
                        <td>13:00 ~ 13:50</td>
                        <td class="lectureMon5"></td>
                        <td class="lectureTue5"></td>
                        <td class="lectureWed5"></td>
                        <td class="lectureThu5"></td>
                        <td class="lectureFri5"></td>
                    </tr>
                    <tr class="lectureSchedule">
                        <td>6교시</td>
                        <td>14:00 ~ 14:50</td>
                        <td class="lectureMon6"></td>
                        <td class="lectureTue6"></td>
                        <td class="lectureWed6"></td>
                        <td class="lectureThu6"></td>
                        <td class="lectureFri6"></td>
                    </tr>
                    <tr class="lectureSchedule">
                        <td>7교시</td>
                        <td>15:00 ~ 15:50</td>
                        <td class="lectureMon7"></td>
                        <td class="lectureTue7"></td>
                        <td class="lectureWed7"></td>
                        <td class="lectureThu7"></td>
                        <td class="lectureFri7"></td>
                    </tr>
                    <tr class="lectureSchedule">
                        <td>8교시</td>
                        <td>16:00 ~ 16:50</td>
                        <td class="lectureMon8"></td>
                        <td class="lectureTue8"></td>
                        <td class="lectureWed8"></td>
                        <td class="lectureThu8"></td>
                        <td class="lectureFri8"></td>
                    </tr>
                    <tr class="lectureSchedule">
                        <td>9교시</td>
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

        <!--  -->
        <div class="card-body" style="margin-bottom: -25px;">
            <label for="cttf">내용</label>
            <div id="ckClassic"></div>
            <textarea name="recuContent" class="form-control" id="cttf" placeholder="내용을 입력하세요." style="display: none;" required></textarea>
        </div>
        
        <div class="card-header btnbtn">
            <button type="button" class="btn btn-block btn-outline-primary btncli" id="btnregi" style="margin-left:50px;">등록</button>
            <button type="button" class="btn btn-block btn-outline-secondary btncli" id="btncanc">취소</button>
            <button type="button" class="btn btn-outline-light" id="auto"
            	style="position: relative; left:350px; width: 150px;">자동 완성</button>
        </div>
        <sec:csrfInput />
    </form>
</div>

<script type="text/javascript">
ClassicEditor.create(document.querySelector("#ckClassic"), {
    ckfinder: {
        uploadUrl: '/image/upload?${_csrf.parameterName}=${_csrf.token}'
    }
})
.then(editor => {
    window.editor = editor;
})
.catch(err => {
    console.error(err.stack);
});

$(function(){
	
	//ckeditor 내용 => textarea로 복사
	$(".ck-blurred").keydown(function(){
		console.log("str : " + window.editor.getData());

	$("#cttf").val(window.editor.getData());
	});

	$(".ck-blurred").on("focusout",function(){
		$("#cttf").val(window.editor.getData());
	});
	
	//높이를 480으로 고정 입력이 480을 넘으면 스크롤이 생김
	$('style').append('.ck-content { height: 200px; }');

	objEditor = editor;
    ///////////////////////
    $.ajax({
    url: "/timePost/myLectureAjax", // ajax용 URL 변경
    type:"get",
    dataType:"json",
    success:function(result){
        // 성공적으로 데이터를 가져왔을 때 실행되는 함수
        // result.length : result 배열의 길이
        // result : 가져온 데이터 전체
        // result[0].lecNo : 첫 번째 강의의 강의 번호
        // result[0].lectureVOList.lecCol : 첫 번째 강의의 색상 코드
        // result[0].lectureVOList.lectureDetailVOList[0].lectureRoomVO.lecRoName : 첫 번째 강의의 강의실 이름
        
        for(let i=0; i<result.length; i++) {
            let lecNo = result[i].lecNo; // 강의 번호
            let lecName = result[i].lectureVOList.lecName; // 강의명
            let lecRoName = result[i].lectureVOList.lectureRoomVO.lecRoName; // 강의실명
            let lecCol = result[i].lectureVOList.lecCol; // 색상 코드
            let lecDay = result[i].lectureVOList.lecTimeVO.lecDay; // 강의 요일
            let lecSt = result[i].lectureVOList.lecTimeVO.lecSt; // 강의 시작 교시
            let lecEnd = result[i].lectureVOList.lecTimeVO.lecEnd; // 강의 종료 교시
            
            weekCheck(lecNo, lecName, lecRoName, lecCol, lecDay, lecSt, lecEnd);
        }
        
    },
    error: function (request, status, error) {
        // 에러가 발생했을 때 실행되는 함수
        console.log("code: " + request.status) // 에러 코드 출력
        console.log("message: " + request.responseText) // 에러 메시지 출력
        console.log("error: " + error); // 에러 객체 출력
    }
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
    
    for(let i=lecSt; i<=lecEnd; i++) {
        let classNum = classTemp + i;
        document.getElementsByClassName(classNum)[0].style.backgroundColor = lecCol; // 강의 배경 색상 설정
        let str = "";
        str += lecName + "&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;"; // 강의명 추가
        str += lecRoName; // 강의실명 추가
        
        document.getElementsByClassName(classNum)[0].style.color = "white"; // 텍스트 색상 설정
        document.getElementsByClassName(classNum)[0].innerHTML = str; // 강의명과 강의실명을 HTML에 추가
    }
}
    ///////////
    $("#btncanc").on("click", function(){
        location.href = "/timePost/lecutreBoast?menuId=injTopBoa";
    });
    

    $("#btnregi").on("click", function(event){
        
		let timeLecBoName = $('#subject').val().trim();
    	console.log("recuTitle =>",timeLecBoName);

	    if (timeLecBoName === '') {
	        return; 
	    }

	    console.log("내용:",editor.getData());
	    //정규표현식 적용
	    
        let timeLecBoCon = editor.getData().match(/<p>(.*)<\/p>/)[1];
            timeLecBoCon = timeLecBoCon.replaceAll("&nbsp;","").trim();
        // console.log(recuContent);

        if(!timeLecBoCon){
            return;
        }
        let data ={
            timeLecBoName,
            timeLecBoCon
        }
        console.log("data>>",data);
        Swal.fire({
            title: '등록하시겠습니까?',
            text: "등록하면 목록으로 이동합니다.",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: '등록',
            cancelButtonText: '취소'
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    url:"/timePost/lecBoaAddAjax",
                    contentType:"application/json;charset=utf-8",
                    data:JSON.stringify(data),
                    type:"post",
                    dataType:"text",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                    },
                    success:function(result){
                        console.log("result", result);
                        if(result>0){
                            Swal.fire({
                                title: "등록 성공!",
                                text: "목록으로 이동합니다",
                                icon: "success"
                            }).then((result) => {
                                location.href="/timePost/lecutreBoast?menuId=injTopBoa";
                            });
                        }
                    }
                });
            }else {
            	return; 
            }
            	
        });
    });
    $('#auto').on('click', function(){
    	$('#subject').val('내 수강신청 자랑해봅니다~!')
    	
    	editor.setData(`무려 금공강이 있는 시간표`);
    	
    })
    
});
</script>
</body>
</html>

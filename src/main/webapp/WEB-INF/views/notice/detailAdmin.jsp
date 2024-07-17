<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!-- <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script> -->

<!--jQuery -->    
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>

<html>
<head>
<style type="text/css">
h3 {
	color: black;
	margin-bottom: 30px;
	margin-top: 40px;
	margin-left: 165px;
}

td {
	padding: 0px;
}

.table {
	padding: 0px;
	margin: 0;
}

.btnbtn {
	text-align: center;
}

.btncli {
	width: 105px;
	display: inline-block;
	margin-right: 10px;
}

.btn-block+.btn-block {
	margin-top: 0;
}

.mainbd {
	padding-top: 40px;
	margin: auto;
	width: 80%;
}

.mainbdol {
	border-radius: .25em;
}

.mailbox-read-time {
	margin: 10px 0px 0px 0px;
}

h4 {
	margin-bottom: 20px;
}

.cardFooterDiv {
	border-top: 0px solid #e3e6f0;
	background-color: transparent;
}

.clearfix {
	margin-top: 16px;
}

.attname {
	font-size: 13px;
}

input:focus {
	outline: none;
}

.marginLeft {
	margin-left: 10px;
}

.mainbdFoot {
	margin: 50px 170px 40px 170px;
	width: 80%;
	background-color: white;
	padding: 30px 30px 30px 30px;
}

.queH4 {
	display: inline-block;
}

.btnregi {
	margin-top: 15px;
	margin-left: 1140px;
}

.dateDay {
	display: inline;
	margin-left: 1020px;
	font-size: 13px;
}

.ansContent {
	height: 200px;
	background-color: #e9ecef;
}
</style>
<script type="text/javascript">
let queTitle = "${questionVO.queTitle}";
let queAttFile = "${questionVO.queAttFile}";
let queContent = `${questionVO.queContent}`;

        
$(function() {
	
	//답글 내용 있는지 확인 (없을때)
	let ansContent = "${answer.answerVOList.ansContent}".trim();
	console.log("ansContent >> ", ansContent);
	
	if(ansContent == null || ansContent == '') {
		document.getElementById("dateDay").style.display = 'none';
		document.getElementById("ansContent").style.display = 'none';
		
		document.getElementById("replyCont").style.display = 'block';
		document.getElementById("btnregi").style.display = 'block';
	} else {
		//답글 내용 있는지 확인 (있을때)
		document.getElementById("dateDay").style.display = 'inline';
		$("#dateDay").removeAttr("disabled");
		
		document.getElementById("ansContent").style.display = 'block';
		
		document.getElementById("replyCont").style.display = 'none';
		document.getElementById("btnregi").style.display = 'none';
	}
	
	   
	//댓글 등록
	$('#btnregi').on("click",function() {
		
		let queNo = "${questionVO.queNo}";
		let replyCont = $("#replyCont").val().trim();
		
		if(replyCont != null || replyCont != "") {
			replyCont = replyCont.replaceAll('\n', '<br>');
		}
		
		let data = {
			"queNo" : queNo,
			"replyCont" : replyCont
		}
		
		$.ajax({
            url : "/notice/commentCreateAjax",
            contentType : "application/json;charset=utf-8",
            data : JSON.stringify(data),
            type : "post",
            dataType : "json",
            beforeSend: function(xhr){
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
            success: function(result) {
            	document.getElementById("btnregi").style.display = 'none'; //답글 버튼
            	document.getElementById("replyCont").style.display = 'none'; //textarea
            	
            	document.getElementById("dateDay").style.display = 'inline'; //작성일
            	document.getElementById("ansContent").style.display = 'block'; //작성일
            	
            	let today = new Date();   

            	let year = today.getFullYear(); // 년도
            	let month = (today.getMonth() + 1);  // 월
            	let date = (today.getDate());  // 날짜
            	let hours = today.getHours(); // 시
            	let minutes = today.getMinutes();  // 분
            	
            	if(month < 10) {
            		month = "0" + month;
            	}
            	if(date < 10) {
            		date = "0" + date;
            	}
            	if(hours < 10) {
            		hours = "0" + hours;
            	}
            	if(minutes < 10) {
            		minutes = "0" + minutes;
            	}
            	
            	let timeDateDay = year + "-" + month + "-" + date + " " + hours + ":" + minutes;
            	
            	$("#dateDaySpan").text(timeDateDay); //작성일 값 추가
            	$("#ansContent").html(replyCont); //div 사이에 값 추가
            },
    		error: function (request, status, error) {
    		    console.log("code: " + request.status)
    		    console.log("message: " + request.responseText)
    		    console.log("error: " + error);
    		}
        });  
	});
	
	//목록 버튼 클릭 시 
	$('#list').on('click', function() {
		location.href = "/notice/listAdmin?menuId=manInqUir";
	});

});
</script>
</head>
<body>
	<input type="hidden" value="${questionVO.queNo}">
	<div>
		<h3 class="card-title">문의사항</h3>
		<div class="mainbd">
			<div class="card card-primary card-outline mainbdol">
				<div class="card-header" style="background-color: #fff; margin-top: 12px;">
					<h4 class="marginLeft">[ ${questionVO.queGubun} ] ${questionVO.queTitle}</h4>
					<div class="card-body p-0">
						<div class="mailbox-read-time attname" id="formdata">
							<table class="table">
								<tr>
									<td>작성일 &nbsp; ${questionVO.queDate} &nbsp;|&nbsp; 수정일
										&nbsp; ${questionVO.queFDate} &nbsp;|&nbsp; 작성자 &nbsp;
										${questionVO.userInfoVOList.userName} &nbsp;|&nbsp; 답변상태
										&nbsp; 
										<c:choose>
											<c:when test="${questionVO.queYn == 'N'}">
												<span class="textCenter" style="color: red;">미완료</span>
											</c:when>
											<c:when test="${questionVO.queYn == 'Y'}">
												<span class="textCenter" style="color: blue;">완료</span>
											</c:when>
										</c:choose>
									</td>
								</tr>
							</table>
						</div>
					</div>
				</div>

				<div class="card-header bg-white">
					<div class="mailbox-attachment-info">
						<span class="marginLeft">첨부파일</span>
						<div class="form-group marginLeft">
							<input type="hidden" id="COM_ATT_M_ID" name="comAttMId" value="">
							<c:forEach var="file" items="${fileList}">
								<a href="${file.comAttachDetVOList.phySaveRoute}" download="${file.comAttachDetVOList.logiFileName}">
									<i class="fas fa-paperclip"></i>
									${file.comAttachDetVOList.logiFileName}
								</a>
								<br>
								<!-- 첨부파일 두개 이상일시 아래로 내리기 위해 -->
							</c:forEach>
						</div>
					</div>
				</div>

				<div class="mailbox-read-message" style="min-height: 460px; margin: 18px 28px 18px 30px;">
					<p>${questionVO.queContent}</p>
				</div>
			</div>

			<div class="card-footer cardFooterDiv">
				<div class="btnbtn">
					<p id="p1">
						<button type="button" class="btn btn-block btn-outline-secondary btncli" id="list">목록</button>
					</p>
				</div>
			</div>
		</div>
		<sec:csrfInput />

		<div class="mainbdFoot card card-primary card-outline">
			<div>
				<h4 class="queH4">답글</h4>
				<div class="dateDay" id="dateDay">
					<span>작성일 </span>
					<span id="dateDaySpan">${answer.answerVOList.ansFDate}</span>
				</div>
			</div>
			<div>
				<div class="form-control ansContent" id="ansContent">${answer.answerVOList.ansContent}</div>
				<textarea name="replyCont" id="replyCont" rows="5" class="form-control"></textarea>
			</div>
			<div>
				<button type="button" class="btn btn-block btn-outline-primary btncli btnregi" id="btnregi">등록</button>
			</div>
		</div>
	</div>

</body>
</html>

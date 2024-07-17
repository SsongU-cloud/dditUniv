<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>  
<!-- link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script -->
<link type="text/css" href="/resources/ckeditor5/sample/css/sample.css" rel="stylesheet" media="screen" />
<script src="https://cdn.ckeditor.com/ckeditor5/11.0.1/classic/ckeditor.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.js"></script>
<html>
<head>

<style type="text/css">
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
    width: 60%;
    float: left;
}

.der {
    width: 19%;
    float: right;
    margin-left: 12px;
}
 .card-body {
   padding: 2.25rem;
}
.card-header {
   padding: .75rem 2.25rem;
}
</style>
</head>
<body>
<sec:authorize access="isAnonymous()">
	<script type="text/javascript">
		location.href="/login";
	</script>
</sec:authorize>
<h3>강의 거래</h3>
<br>
<div class="card card-outline card-info divSuburb">
    <form id="frm" name="frm" action="/notice/addPost" method="post">
        <div class="card-body">
            <div class="hea">
                <label for="subject">제목</label> 
                <input type="text" id="subject" class="form-control" name="queTitle" 
                    maxlength='45' placeholder="제목을 입력하세요." required/>
            </div>  
                
            <div class="der">
				<label for="lectureStatus">강의 상태</label>
				<select title="강의 상태 선택" id="lectureStatus" name="lectureStatus" class="selectSearch form-control" disabled>
					<option value="1">대기</option>
					<option value="2">완료</option>
				</select>
            </div>
                
            <div class="der">
				<label for="gubun">구분</label>
				<select title="구분 선택" id="gubun" name="queGubun" class="selectSearch form-control">
					<option value="1">양도</option>
					<option value="2">구함</option>
				</select>
            </div>
        </div>
		<br>
        <div class="card-body">
            <label for="cttf">내용</label>
            <div id="ckClassic"></div>
            <textarea name="queContent" class="form-control" id="cttf" placeholder="내용을 입력하세요." style="display: none;" required></textarea>
        </div>

        <div class="card-header btnbtn">
            <button type="button" class="btn btn-block btn-outline-primary btncli" id="btnregi">등록</button>
            <button type="button" class="btn btn-block btn-outline-secondary btncli" id="btncanc">취소</button>
        </div>
        <sec:csrfInput />
    </form>
</div>

<script type="text/javascript">
ClassicEditor.create(document.querySelector("#ckClassic"), {
    ckfinder: {
//         uploadUrl: '/image/upload?${_csrf.parameterName}=${_csrf.token}'
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
	$('style').append('.ck-content { height: 480px; }');

	objEditor = editor;

    
    $("#btncanc").on("click", function(){
        location.href = "/timePost/exchaBoard?menuId=injLecDea";
    });
    

    $("#btnregi").on("click", function(event){
        
		let subject = $('#subject').val();
    	let subjectTrim = subject.trim();
    	console.log("subjectTrim =>",subjectTrim);

	    if (subjectTrim === '') {
	        return; 
	    }

	    console.log("내용:",editor.getData());
	    //정규표현식 적용
	    
        let nhStr = editor.getData().match(/<p>(.*)<\/p>/)[1];
        console.log(nhStr);
        nhStr = nhStr.replaceAll("&nbsp;","").trim();

        if(!nhStr){
            return;
        }
    
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
                // 폼 제출
            	Swal.fire({
          		  title: "등록 성공!",
          		  text: "목록으로 이동합니다",
          		  icon: "success"
          		}).then((result) => {
	                $("#frm").submit();
                });
            }else {
            	return; 
            }
            	
        });
    });
    
    
});
</script>
</body>
</html>

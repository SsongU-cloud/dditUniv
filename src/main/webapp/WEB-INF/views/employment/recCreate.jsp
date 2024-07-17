<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>  
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
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
</style>
</head>
<body>
<sec:authorize access="isAnonymous()">
	<script type="text/javascript">
		location.href="/login";
	</script>
</sec:authorize>
<h3>채용정보 작성</h3>
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
                <label for="gubun">작성자</label> 
                <input type="text" class="selectSearch form-control" value="${adminName}" disabled>
                
            </div>
        </div>
		<br>
        <div class="card-body" style="margin-bottom: -25px;">
            <label for="cttf">내용</label>
            <div id="ckClassic"></div>
            <textarea name="recuContent" class="form-control" id="cttf" placeholder="내용을 입력하세요." style="display: none;" required></textarea>
        </div>

        <div class="card-header">
            <div class="custom-file">
                <input type="file" name="recuAttFile" class="custom-file-input" id="customFile" required multiple/>  <!-- input,label 순서 고정 -->
                <label class="custom-file-label" for="customFile">첨부파일</label>
            </div>
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
	$('style').append('.ck-content { height: 480px; }');

	objEditor = editor;

    // 첨부파일 이름 바뀌는거
    document.querySelector('#customFile').addEventListener('change', function (e) {
    	let files = document.getElementById("customFile").files;
    	console.log("files : ", files);
		
		let fileName = "";
		
    	for (let i = 0; i < files.length; i++) {
    		if(i == (files.length-1)) {
    			fileName += files[i].name;
    		} else {
	    		fileName += files[i].name + ", ";
    		}
		}
    	console.log("fileName >> ", fileName);
    	
    	let nextSibling = e.target.nextElementSibling;
		nextSibling.innerText = fileName;
    });
    
    $("#btncanc").on("click", function(){
        location.href = "/commonNotice/list?menuId=annNotIce";
    });
    

    $("#btnregi").on("click", function(event){
        
		let recuTitle = $('#subject').val().trim();
    	console.log("recuTitle =>",recuTitle);

	    if (recuTitle === '') {
	        return; 
	    }

	    console.log("내용:",editor.getData());
	    //정규표현식 적용
	    
        let recuContent = editor.getData().match(/<p>(.*)<\/p>/)[1];
        recuContent = recuContent.replaceAll("&nbsp;","").trim();
        console.log(recuContent);

        if(!recuContent){
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
                let formData = new FormData();
                formData.append("recuTitle",recuTitle);
                formData.append("recuContent",recuContent);
                let inpufile =$("#customFile");
                let file = inpufile[0].files;
                console.log("file.length",file.length);
                for(let i = 0 ; i < file.length;i++){
                    formData.append("recuAttFile",file[i]);
                }
                console.log("formData>>",formData)
                $.ajax({
                    url:"/employment/reCreateAjax",
                    processData: false,
                    contentType: false,
                    data: formData,
                    type: "post",
                    dataType:"text",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                    },
                    success:function(result){
                        console.log("result", result);

                    }
                    
                })
                // 폼 제출
            	Swal.fire({
          		  title: "등록 성공!",
          		  text: "목록으로 이동합니다",
          		  icon: "success"
          		}).then((result) => {
                    location.href="/employment/recruitment?menuId=manRecRui";
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

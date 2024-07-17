<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.js"></script>
<script src="https://cdn.ckeditor.com/ckeditor5/34.0.0/classic/ckeditor.js"></script>

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
.marginLeft{
	margin-left:10px;
}
/* 수정 */
.divSuburb {
    margin: auto;
    min-height: 678px;
    width: 100%;
}
.btn-block+.btn-block {
    margin-top: 0;
}
.btncli {
    width: 105px;
    margin: auto;
    display: inline-block;
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
.strikethrough {
	text-decoration: line-through;
}
</style>
<script type="text/javascript">
	let recuTitle = `${recruitmentVO.recuTitle}`;
	let recuContent = `${recruitmentVO.recuContent}`;
	$(function() {
		
		$('#list').on('click', function() {
			location.href = "/employment/recruitmentAdmin?menuId=manRecRui";
		});

		$("#btnUpdate").on("click",function() {

			let recuNo = $("#recuNo").val();
			console.log("ck",recuNo);
			let data = {
	                "recuNo": recuNo
	        };
			
			fRecDetailAjax(data);
			$("#p1").css("display", "none");
			$("#p2").css("display", "block");
		});
		$("#delete").on("click", function() {
	            let recuNo = $("#recuNo").val();
	            console.log(recuNo);
	            let data = {
	                "recuNo": recuNo
	            };

	            Swal.fire({
	                title: '삭제하시겠습니까?',
	                text: "삭제하면 목록으로 이동합니다.",
	                icon: 'warning',
	                showCancelButton: true,
	                confirmButtonColor: '#3085d6',
	                cancelButtonColor: '#d33',
	                confirmButtonText: '삭제',
	                cancelButtonText: '취소'
	            }).then((result) => {
	                if (result.isConfirmed) {
	                    $.ajax({
	                        url : "/employment/recrDeleteAjax",
	                        contentType : "application/json;charset=utf-8",
	                        data : JSON.stringify(data),
	                        type : "post",
	                        dataType : "text",
	                        beforeSend: function(xhr){
	                            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	                        },
	                        success: function(result) {
	                            console.log("삭제 결과:", result);
	                            if (result > 0) {
	                                Swal.fire(
	                                    '삭제 완료!',
	                                    '해당 공지가 삭제되었습니다.',
	                                    'success'
	                                ).then(() => {
	                                    location.href = "/employment/recruitmentAdmin?menuId=manRecRui";
	                                });
	                            } else {
	                                Swal.fire(
	                                    '삭제 취소!',
	                                    '삭제 취소하였습니다.',
	                                    'error'
	                                );
	                            }
	                        },
	                    });
	                }
	            });
	        });
		$(document).on("click","#btnFileDelete",function(){
			let recrVO=`${jsonRecruimentVOList}`;
			let recrVOObject = JSON.parse(recrVO);
			let recrNolist =[];
			for(let i = 0 ; i<recrVOObject.comAttachDetVOList.length; i++){
				let No= recrVOObject.comAttachDetVOList[i].comAttDetNo;
				recrNolist.push(No);
			}
			
			let comAttMId = recrVOObject.recuAttFileId;
			let recuNo = `${recruitmentVO.recuNo}`;
			let data={
				comAttMId,
				recuNo
			}
			// console.log(recrVOObject.comAttachDetVOList[0].comAttDetNo);
			// console.log(">>",recrVOObject.comAttachDetVOList.length);
			// console.log("recrNolist>>",recrNolist);
			// console.log(comAttMId);
			// console.log(data);
			$.ajax({
				url:"/employment/recrUpdateFileDelete",
				contentType:"application/json;charset=utf-8",
				data:JSON.stringify(data),
				type:"post",
				dataType:"text",
				beforeSend: function (xhr) {
			 		xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			 	},
				success:function(result){
					console.log("result : ", result);
					if(result>0){
						// fChangeUpdateMode();
						// fCkEditor();
						fRecDetailAjax(data);
					}//if end
				}
			});
		})
		$("#btnSave").on("click",function(){
			//recruitmentVO 해당 내용
			let recuNo= `${recruitmentVO.recuNo}`;
			let recuTitle = $("#subject").val();
			let recuContent= editor.getData();
			recuContent= recuContent.match(/<p>(.*)<\/p>/)[1].replaceAll("&nbsp;","").trim();
			let inputfile = $("#customFile");
			let recuAttFileId = `${recruitmentVO.recuAttFileId}`;
			// console.log("recuTitle",recuTitle);
			// console.log("recuContent",recuContent);
			// console.log("fileNoArr",fileNoArr);
			let comAttDetNo= fileNoArr;
			let formData = new FormData();
			formData.append("recuTitle",recuTitle);
			formData.append("recuContent",recuContent);
			formData.append("recuAttFileId",`${recruitmentVO.recuAttFileId}`);
			let data={
				recuNo
			}
			console.log('data',data)
			//com
			let recruitmentVO = {
				recuNo: recuNo,
				recuTitle: recuTitle,
				recuContent: recuContent,
				recuAttFileId: recuAttFileId,
				comAttachDetVOList: []
			};

			for (let i = 0; i < comAttDetNo.length; i++) {
				recruitmentVO.comAttachDetVOList.push({ comAttDetNo: comAttDetNo[i] });
			}

			console.log("recruitmentVO",recruitmentVO)
			formData.append("recruitmentVO",new Blob([JSON.stringify(recruitmentVO)],{type:"application/json;charset=utf-8"}));

			if(typeof  inputfile[0] =='undefined'||inputfile[0].files.length==0){
				console.log("추가한 파일이 없습니다.");
			}else{
				let file = inputfile[0].files;
				console.log("file.length",file.length);
				for(let i = 0 ; i < file.length;i++){
					formData.append("sbFiles",file[i]);
				}
			}
			$.ajax({
				url:"/employment/recrUpdateAjax",
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
					if(result >0){
						// fChangeDetailMode();
						$("#p1").css("display", "block");
						$("#p2").css("display", "none");
						fRecDetailDispAjax(data);
					}
				}
			});
		});	
		$('#cancel').on('click',function() {
			$("#p1").css("display", "block");
			$("#p2").css("display", "none");
			let recuNo= `${recruitmentVO.recuNo}`;
			let data ={
				recuNo
			}
			// fChangeDetailMode();
			fRecDetailDispAjax(data);
		});

	});//$function()end
	let fileNoArr=[];
	function fFile_checkbox(e){
		// console.log("e",e);
		// console.log("e.value",e.value);
		let fileNo =e.value;
		// fileNoArr.push(fileNo);
		
		const link = e.nextElementSibling;
		if (e.checked) {
			link.classList.add('strikethrough');
		} else {
			link.classList.remove('strikethrough');
		}
	}
	function fRecDetailAjax(data){
		$.ajax({
				url:"/employment/recDetailAjax",
				contentType:"application/json;charset=utf-8",
				data:JSON.stringify(data),
				type:"post",
				dataType:"json",
				beforeSend: function (xhr) {
					xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
				},
				success:function(result){
					// console.log("수정 누를시!!result>>",result)
					// console.log("editor>>",recuContent);
					let changeNameUpdateMode=`
						<h3 class="card-title">채용정보 상세수정</h3>
						`;
					let changeUpdateAjaxMode ="";
					changeUpdateAjaxMode +=`
							<div class="card card-outline card-info divSuburb">
								<form id="frm" name="frm" action="#" method="post" enctype="multipart/form-data">
									<div class="card-body">
										<div class="hea">
											<p>
												<label for="subject">제목</label>
											</p>
											<p>
												<input type="text" id="subject" class="form-control" name="recuTitle" style="width: 940px;height: 39px;"
													maxlength='45' value="\${result.recuTitle}"/>
											</p>
										</div>  
										<div class="der">
											<p>
												<label for="gubun">작성자</label> 
											</p>
											<p>
												<input type="text" class="selectSearch form-control" value="\${result.userInfoVOList.userName}" disabled>
											</p>
										</div>
									</div>
									<div class="card-body" style="margin-bottom: -25px;margin-top: -40px;">
										<label for="cttf">내용</label>
										<div id="ckClassic"></div>
										<textarea name="recuContent" class="form-control" id="cttf" style="display: none;"></textarea>
									</div>
									`;
									changeUpdateAjaxMode+=`<div class="mailbox-attachment-info" style="margin-left:29px;">
											<button type="button"
													class="btn btn-block btn-outline-danger" id="btnFileDelete" style="width:130px;margin-left:7px;margin-bottom:7px;">전체 파일 삭제</button>
											<div class="form-group marginLeft">
												<input type="hidden" id="comAttMId" name="comAttMId" value="${recruitmentVO.recuAttFileId}">
												<c:forEach var="comAttachDetVO" items="${recruitmentVO.comAttachDetVOList}">
												`;
									let filesArr =result.comAttachDetVOList;
									console.log("filesArr>>>",filesArr)
									filesArr.forEach(function(file){
										console.log("file",file)
										changeUpdateAjaxMode+=`<a href="\${file.phySaveRoute}"
										download="\${file.logiFileName}"> <i
										class="fas fa-paperclip"></i>\${file.logiFileName}</a>
										<br>
										`;
									});
									changeUpdateAjaxMode+=`</c:forEach>
											</div>
										</div>
										`;
										changeUpdateAjaxMode += `
									<div class="card-header">
										<div class="custom-file">
											<input type="file" name="recuAttFile" class="custom-file-input" id="customFile" multiple/> 
											<label class="custom-file-label" for="customFile">새로운 첨부파일</label>
										</div>
									</div>
									<sec:csrfInput />
								</form>
							</div>		
						`;
						// console.log(changeUpdateMode);
						$("#changeMode").html(changeNameUpdateMode);
						$("#infoMode").html(changeUpdateAjaxMode);
						fCkEditor(result.recuContent);
				}
			});
	}
	function fRecDetailDispAjax(data){
		$.ajax({
			url:"/employment/recDetailAjax",
			contentType:"application/json;charset=utf-8",
			data:JSON.stringify(data),
			type:"post",
			dataType:"json",
			beforeSend: function (xhr) {
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			success:function(result){
				// console.log("아작스 안에 아작스",result)
				let changeNameDetailMode=`
				<h3 class="card-title">채용정보 상세조회</h3>
				`
				let changeDetailAjaxMode ="";
				changeDetailAjaxMode +=`
						<div class="card card-primary card-outline mainbdol">
							<div class="card-header"
								style="background-color: #fff; margin-top: 12px;">
								<input type="hidden" id="recuNo" value="\${result.recuNo}">
								<h4 class="marginLeft">\${result.recuTitle}</h4>
								<div class="card-body p-0">
									<div class="mailbox-read-time attname" id="formdata">
										<table class="table">
											<tr>
												<td>작성일 &nbsp; \${result.recuFirstDataDisplay}
													&nbsp;|&nbsp; 수정일 &nbsp; \${result.recuEndDataDisplay}
													&nbsp;|&nbsp; 작성자 &nbsp;
													\${result.userInfoVOList.userName} &nbsp;|&nbsp;</td>
											</tr>
										</table>
									</div>
								</div>
							</div>
							<div class="card-header bg-white">
								<div class="mailbox-attachment-info">
									<span class="marginLeft">첨부파일</span>
									`;
									changeDetailAjaxMode+=
							`<div class="form-group marginLeft">
								
								<c:forEach var="comAttachDetVO" items="\${result.comAttachDetVOList}">
								`;
						let filesArr =result.comAttachDetVOList;
						filesArr.forEach(function(file){
							changeDetailAjaxMode+=`<a href="\${file.phySaveRoute}"
							download="\${file.logiFileName}"> <i
							class="fas fa-paperclip"></i>\${file.logiFileName}</a>
							<br>
							`;
						});
						changeDetailAjaxMode+=`
								</c:forEach>
							</div>
							`;
							changeDetailAjaxMode+=`</div>
											</div>
											<div class="mailbox-read-message"
												style="min-height: 460px; margin: 18px 28px 18px 30px;">
												<p>\${result.recuContent}</p>
											</div>
										</div>
							`;
				$("#changeMode").html(changeNameDetailMode);
				$("#infoMode").html(changeDetailAjaxMode);
			}//success end
		});
	}
</script>
</head>

<body>
	<div id="allDisp">
		<div id="changeMode">
			<h3 class="card-title">채용정보 상세조회</h3>
		</div>
		<!-- ${recruitmentVO} -->
		<form id="frm" name="frm" action="#"
			method="post">
			<div class="mainbd">
				<div id="infoMode">
					<div  class="card card-primary card-outline mainbdol">
						<div class="card-header"
							style="background-color: #fff; margin-top: 12px;">
							<input type="hidden" id="recuNo" value="${recruitmentVO.recuNo}">
							<h4 class="marginLeft">${recruitmentVO.recuTitle}</h4>
							<div class="card-body p-0">
								<div class="mailbox-read-time attname" id="formdata">
									<table class="table">
										<tr>
											<td>작성일 &nbsp; ${recruitmentVO.recuFirstDataDisplay}
												&nbsp;|&nbsp; 수정일 &nbsp; ${recruitmentVO.recuEndDataDisplay}
												&nbsp;|&nbsp; 작성자 &nbsp;
												${recruitmentVO.userInfoVOList.userName} &nbsp;</td>
										</tr>
									</table>
								</div>
							</div>
						</div>
						<div class="card-header bg-white">
							<div class="mailbox-attachment-info">
								<span class="marginLeft">첨부파일</span>
								<div class="form-group marginLeft">
									<input type="hidden" id="comAttMId" name="comAttMId" value="${recruitmentVO.recuAttFileId}">
									<c:forEach var="comAttachDetVO" items="${recruitmentVO.comAttachDetVOList}">
										<!-- <p>${comAttachDetVO} </p>  -->
										<a href="${comAttachDetVO.phySaveRoute}"
											download="${file.comAttachDetVOLis.logiFileName}"> <i
											class="fas fa-paperclip"></i>${comAttachDetVO.logiFileName}</a>
										<br> <!-- 첨부파일 두개 이상일시 아래로 내리기 위해 -->
									</c:forEach>
								</div>
							</div>
						</div>

						<div class="mailbox-read-message"
							style="min-height: 460px; margin: 18px 28px 18px 30px;">
							<p>${recruitmentVO.recuContent}</p>
						</div>
					</div>
				</div>
				<div class="card-footer cardFooterDiv">
					<div class="btnbtn">
						<p id="p1">
							<sec:authorize access="hasRole('ROLE_ADMIN')">
								<button type="button"
									class="btn btn-block btn-outline-warning btncli" id="btnUpdate">수정</button>
									</sec:authorize>
								<button type="button"
									class="btn btn-block btn-outline-secondary btncli" id="list" style="margin: 10px;">목록</button>
							<sec:authorize access="hasRole('ROLE_ADMIN')">
								<button type="button"
									class="btn btn-block btn-outline-danger btncli" id="delete">삭제</button>
							</sec:authorize>
						</p>
						<p id="p2" style="display: none;">
							<button type="button"
								class="btn btn-block btn-outline-primary btncli" id="btnSave" style="margin: 10px;">확인</button>
							<button type="button"
								class="btn btn-block btn-outline-secondary btncli" id="cancel">취소</button>
						</p>
					</div>
				</div>
			</div>
			<sec:csrfInput />
		</form>
	</div>
<script type="text/javascript">
	  function fCkEditor(){
            ClassicEditor.create(document.querySelector("#ckClassic"), {
                ckfinder: {
                    uploadUrl: '/image/upload?${_csrf.parameterName}=${_csrf.token}'
                }
            })
            .then(editor => {
                window.editor = editor;
                editor.setData(recruitmentVO.recuContent);
            })
            .catch(err => {
                console.error(err.stack);
            });

            $(document).on("keydown", ".ck-blurred", function() {
                $("#cttf").val(window.editor.getData());
            });

            $(document).on("focusout", ".ck-blurred", function() {
                $("#cttf").val(window.editor.getData());
            });

            $('style').append('.ck-content { height: 480px; }');
        }
		function fCkEditor(content) {
			ClassicEditor.create(document.querySelector("#ckClassic"), {
				ckfinder: {
					uploadUrl: '/image/upload?${_csrf.parameterName}=${_csrf.token}'
				}
			})
			.then(editor => {
				window.editor = editor;
				editor.setData(content); // Set the content from the result
			})
			.catch(err => {
				console.error(err.stack);
			});

			$(document).on("keydown", ".ck-blurred", function() {
				$("#cttf").val(window.editor.getData());
			});

			$(document).on("focusout", ".ck-blurred", function() {
				$("#cttf").val(window.editor.getData());
			});

			$('style').append('.ck-content { height: 480px; }');
		}		

	// 첨부파일 이름 바뀌는거
	$(document).on("change", "#customFile", function() {
    console.log("fileck");

    let fileInput = $("#customFile")[0];
    let fileNames = [];
    for (let i = 0; i < fileInput.files.length; i++) {
        fileNames.push(fileInput.files[i].name);
    }
    let label = $(this).next(".custom-file-label");
    if (label.length) {
        label.text(fileNames.join(", "));
    } else {
        console.error('custom-file-label 요소를 찾을 수 없습니다.');
    }
});

		$("#btncanc").on("click", function(){
			location.href = "#";
		});

		$("#btnregi").on("click", function(event){
			let recuTitle = $('#subject').val().trim();
			if (recuTitle === '') {
				return; 
			}

			let recuContent = editor.getData().match(/<p>(.*)<\/p>/)[1];
			recuContent = recuContent.replaceAll("&nbsp;","").trim();
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
					formData.append("recuTitle", recuTitle);
					formData.append("recuContent", recuContent);
					let inpufile = $("#customFile");
					let file = inpufile[0].files;
					for(let i = 0 ; i < file.length; i++){
						formData.append("recuAttFile", file[i]);
					}
					$.ajax({
						url: "/employment/reCreateAjax",
						processData: false,
						contentType: false,
						data: formData,
						type: "post",
						dataType: "text",
						beforeSend: function (xhr) {
							xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
						},
						success: function(result){
							console.log("result", result);
						}
					});
					Swal.fire({
						title: "등록 성공!",
						text: "목록으로 이동합니다",
						icon: "success"
					}).then(() => {
						location.href = "/employment/recruitmentAdmin?menuId=manRecRui";
					});
				} else {
					return; 
				}
			});
		});
</script>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>  

<!-- <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min." rel="stylesheet">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script> -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css" />

<style>
.card {
	width: 80%; /*목록 넓이*/
}

h3 {
	color: black;
	margin-bottom: 30px;
	margin-top: 40px;
	margin-left: 165px;
}

.card-header {
	background-color: white;
}

.btn-block+.btn-block {
	margin-top: 0;
}

.btnbtn {
	text-align: center;
	padding-top: 15px;
}

.btncli {
	width: 105px;
	margin: auto;
	display: inline-block;
}

.barrier {
	margin: 40px 50px 15px 50px;
}

.regreg {
	padding: 0px 0px;
}

.pickers {
	width: 200px;
	display: inline-block;
}

.nav-tabs {
    border-bottom: 1px solid #dee2e6;
}

.expBox {
    background-color: white;
    border: 1px solid #ced4da;
    width: 79%;
    margin-left: 170px;
    margin-bottom: 30px;
    padding: 40px 40px 30px 40px;
    color: black;
}

i{
	font-size: small;
}

</style>


<body class="sidebar-mini sidebar-closed sidebar-collapse"
	style="height: auto;">

	<h3>상담신청</h3>
	<br>

	<div class="expBox">
		<strong>
			<p>※안내사항</p> 
			<p>1. 상단의 휴학 , 자퇴 , 졸업 탭 중 신청하려는 상담의 항목 탭을 선택합니다.</p>
			<p>2. 담당 교수님은 자동으로 지정됩니다. 담당 교수님 항목을 제외한 모든 항목을 작성하여야 신청이 됩니다.</p>
			<p>3. 신청한 상담은 상담 - 상담내역 탭에서 확인 할 수 있습니다.</p>
			<p>4. 상담신청을 완료하면 '대기' 로 표기되며 담당 교수님께서 '승인' 또는 '반려' 를 선택하여 상담이 진행 또는 취소 됩니다.</p>
			<i>&nbsp;&nbsp;&nbsp;&nbsp;* 무조건적으로 '승인' 되는것이 아닌 담당 교수님의 스케줄에 따라 '반려' 될 수 있음을 인지하여주시고 양해 바랍니다.</i>
		</strong>
	</div>


	<div class="card card-primary card-outline card-outline-tabs" style="margin: auto;">
		<div class="tab-pane active" id="settings">
			<form id="frm" name="frm" action="/consulting/list?menuId=cybConSul" method="post">

			<div class="card-header p-0 border-bottom-0">
			<ul class="nav nav-tabs" id="custom-tabs-four-tab" role="tablist">
				<li class="nav-item"><a class="nav-link active"
					id="consulCateg" data-toggle="pill"
					href="#break" role="tab"
					aria-controls="custom-tabs-four-home" aria-selected="true">휴학</a>
				</li>
				<li class="nav-item"><a class="nav-link"
					id="consulCateg" data-toggle="pill"
					href="#dropout" role="tab"
					aria-controls="custom-tabs-four-profile" aria-selected="false">자퇴</a>
				</li>
				<li class="nav-item"><a class="nav-link"
					id="consulCateg" data-toggle="pill"
					href="#graduate" role="tab"
					aria-controls="custom-tabs-four-profile" aria-selected="false">졸업</a>
				</li>
			</ul>
		</div>
				<div class="barrier">
					<div class="form-group row">
						<br> <label for="inputName" class="col-sm-2 col-form-label">담당교수님</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="prof" name="prof"
								value="${proName} 교수님" readonly="readonly">
						</div>
					</div>
					<div class="form-group row">
						<label for="inputEmail" class="col-sm-2 col-form-label">제목</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="consulTitle"
								name="consulTitle" placeholder="제목" required="required">
						</div>
					</div>
					<div class="form-group row">
						<label for="inputExperience" class="col-sm-2 col-form-label">상담내용</label>
						<div class="col-sm-10">
							<textarea class="form-control" id="consulCon" name="consulCon"
								placeholder="상담내용" required="required" style="height: 200px;"></textarea>
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-2 control-label regreg">상담예약일시</label>
						<input type="date" class="form-control pull-right pickers" id="consulReqDay" name="consulReqDay" required="required">
						<input type="time" class="form-control pull-right pickers" id="consulReqTime" name="consulReqTime" required="required">
					</div>



					<div class="card-body btnbtn">
						<button type="button" style="margin-left: 150px;"
							class="btn btn-block btn-outline-primary btncli" id="btnregi">등록</button>
						<button type="button"
							class="btn btn-block btn-outline-secondary btncli" id="btnlist">취소</button>
						<button type="button" class="btn btn-outline-light" id="auto"
           					style="position: relative; left:350px; width: 150px;">자동 완성</button>
					</div>
					<sec:csrfInput />
				</div>
			</form>
		</div>

	</div>
	
	<br>

</body>

<script>
$(function() {
    $('#btnlist').on('click', function() {
        location.href = "/consulting/list?menuId=cybConSul";
    });

    $("#btnregi").on("click", function(event) {
// 		let stNo = $("#stNo").val();
		let consulTitle = $("#consulTitle").val();
		let consulCon = $("#consulCon").val();
		let consulReqDay = $("#consulReqDay").val();
		let consulReqTime = $("#consulReqTime").val();
		let dayAndTime = consulReqDay + "  |  " + consulReqTime;
		let consulCateg = $(".nav-tabs .nav-link.active").text(); // 현재 선택된 탭의 텍스트
		console.log(consulTitle);
		
        let data = {
//             "stNo": stNo,
            "consulTitle": consulTitle,
            "consulCon": consulCon,
            "dayAndTime": dayAndTime,
            "consulCateg": consulCateg
        };
        console.log(data);

        
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
                    url: "/consulting/createAjax",
                    contentType: "application/json;charset=utf-8",
                    data: JSON.stringify(data),
                    type: "post", 
                    dataType: "json",
                    beforeSend: function(xhr) {
                        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                    },
                    success: function(result) {
                    	console.log("등록 결과:", result);
                        if (result != null) {
                            Swal.fire({
                                title: "등록 성공!",
                                text: "목록으로 이동합니다",
                                icon: "success"
                            }).then((result) => {
                                location.href = "/consulting/list?menuId=cybConSul";
                            });
                        }else {
	                        Swal.fire({
	                            title: '등록 취소',
	                            text: '등록을 취소했습니다.',
	                            icon: 'error'
	                        });
            			}
                    }
        		});
             }
    	});
	});
    
    $('#auto').on('click', function(){
 	   $('#consulTitle').val('휴학 상담 신청합니다');
 	   $('#consulCon').val('개인 사유로 인해 이번년도에는 휴학을 하려 합니다.');
 	   $('#consulReqDay').val('2024-08-05');
 	   $('#consulReqTime').val('14:00');
    })
});

</script>

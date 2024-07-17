<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>  

<!-- <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet"> -->
<!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script> -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.js"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css"/>

<style>

.card {
   width: 80%;  /* 목록 넓이 */
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
    padding-top: 12px;
}

.btncli {
    width: 105px;
    margin: auto;
    display: inline-block;
}

.barrier{
	margin: 40px 40px 0px 40px;
}

.regreg{
	padding: 0px 0px;
}

.pickers{
	width: 200px;
	display: inline-block;
}

.selectSearch{
    width: 130px;
    height: 40px;
    margin: 0px 5px 0px 0px;
    font-size: 1rem;
}

.consultbody {
	border-bottom: 2px solid #EBF1E9; 
    border-top: 2px solid #EBF1E9; 
    border-right: 2px solid #EBF1E9;
}

#green {
	background-color: #EBF1E9;
 	text-align: center;
	vertical-align : bottom;
}

#settings{
	padding: 20px 20px 20px 20px;
}

#content{
	resize: none;
}



</style>


<body class="sidebar-mini sidebar-closed sidebar-collapse"
	style="height: auto;">

	<h3>상담 내역</h3>
	<br>

	<div class="card" style="margin: auto;">
		<div class="tab-pane active" id="settings">
			<form id="frm" name="frm" action="/student/requestDetail" method="post">
    			<input type="hidden" name="consulReqNo" value="${consultingRequestVO.consulReqNo}">

				<div class="barrier">
					<table class="table table-borderless">
						<tbody class="consultbody">
							<tr class="consultbody">
								<td scope="row" class="col-sm-2" id="green" style="padding-bottom: 20px">학번</td>
								<td class="col-sm-4">
									${consultingRequestVO.stNo}
								</td>
								<td scope="row" class="col-sm-2" id="green" style="padding-bottom: 20px">이름</td>
								<td class="col-sm-4">
									${consultingRequestVO.userInfoVOMap.userName}
								</td>
							</tr>
                            <tr class="consultbody">
								<td scope="row" class="col-sm-2" id="green" style="padding-bottom: 20px">신청날짜</td>
								<td class="col-sm-4">
									${consultingRequestVO.consulReqDate}
								</td>
								<td scope="row" class="col-sm-2" id="green" style="padding-bottom: 20px">상담현황</td>
								<td class="col-sm-4" style="color: blue;" value="${consultingRequestVO.consultingRecordVOMap.conCont}">
									완료
								</td>
							</tr>

							<tr class="consultbody">
								<td scope="row" class="col-sm-2" id="green" style="padding-bottom: 20px">구분</td>
								<td class="col-sm-4">
									${consultingRequestVO.consulCateg}
								</td>
								<td scope="row" class="col-sm-2" id="green" style="padding-bottom: 20px">상담예약일 및 시간</td>
								<td class="col-sm-4">
									${consultingRequestVO.consulReqTime}
								</td>
							</tr>
							<tr class="consultbody">
								<td scope="row" class="col-sm-2" id="green" style="padding-bottom: 20px">제목</td>
								<td class="col-sm-10" colspan="3">
									${consultingRequestVO.consulTitle}
								</td>
							</tr>
							
							<tr class="consultbody">
								<td scope="row" class="col-sm-2" id="green" style="padding-bottom: 100px">상담기록</td>
								<td class="col-sm-10" colspan="3">
									<textarea class="form-control content" id="content" name="content" style="height: 200px; background-color: transparent; border: 0px;"></textarea>
								</td>
							</tr>
						</tbody>
					</table>

					<div class="card-body btnbtn">
						<button type="button" class="btn btn-block btn-outline-primary btncli" id="btnregi">저장</button>
						<button type="button" class="btn btn-block btn-outline-secondary btncli" id="btnlist">목록</button>
						<button type="button" class="btn btn-outline-light" id="auto">자동 완성</button>
					</div>
					<sec:csrfInput />
				</div>
			</form>
		</div>
	</div>

</body>

<script>

$(function() {
    $('#btnlist').on('click', function() {
        location.href = "/student/requestHistory?menuId=proEvaLua";
    });
    
    $('#btnregi').on('click', function() {
//         var formData = {
//             consulReqNo: "${consultingRequestVO.consulReqNo}",  // consulReqNo 추가
//             content: $('#content').val()
//         };
        
//         $.ajax({
//             type: "POST",
//             url: "/student/hislistAjax",
//             data: JSON.stringify(formData),
//             contentType: "application/json",
//             success: function(response) {
//             	Swal.fire({
//                     title: "등록 성공!",
//                     text: "상세화면으로 이동합니다",
//                     icon: "success"
//                 }).then((result) => {
// //                 location.href = "/student/requestHistory?menuId=proEvaLua";
//                 location.href = "/student/requestHistory?menuId=proEvaLua&consulReqNo=${conReqNo}";
//                 });
//             },
//             error: function(error) {
//                 Swal.fire('저장 중 오류가 발생했습니다.');
//             }
//         });

        Swal.fire({
            title: '저장하시겠습니까?',
            text: "기존 데이터로 되돌릴 수 없습니다",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: '저장',
            cancelButtonText: '취소'
        }).then((result) => {
        	Swal.fire({
        		  title: "저장 성공!",
        		  text: "상세화면으로 이동합니다",
        		  icon: "success"
        		}).then((result) => {
		        	$(".content").attr("disabled",true);
		        	document.getElementById('btnregi').style.display = 'none';
			    	location.href="/student/requestHistory?menuId=proEvaLua";
        	});
        });
    });
    
    $('#auto').on('click', function(){
//     	console.log($('textarea[name=content]'))
    	$('textarea[name=content]').html("졸업 및 취업 관련 상담 진행");
    })
});

</script>

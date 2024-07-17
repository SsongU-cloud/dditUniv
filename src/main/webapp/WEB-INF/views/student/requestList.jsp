<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!-- <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet"> -->
<!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script> -->
<html>
<head>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
    <style type="text/css">
        h3 {
            color: black;
            margin-bottom: 30px;
            margin-top: 40px;
            margin-left: 165px;
        } 
        .wkrtjdBut {
            width: 105px;
            float: right;
        }
        .trBackground {
            background-color: #ebf1e9;
        }
        #btnSearch {
            border: 1px solid #D1D3E2;
            background-color: #F8F9FA;
        }
        .sssear{
            width: 130px;
            height: 30px;
            float: left;
            margin: 0px 5px 0px 0px;
            font-size: 0.8rem;
        }
        .clsPagingArea {
            margin-top: 20px;
            justify-content: flex-end;
        }
        .card {
            width: 80%;  /*목록 넓이*/
        }
        .textCenter {
            text-align: center;
        }
        .wawarn {
            width: 70px;
        }
        .cloclose {
            width: 70px;
        }
        .btn-block+.btn-block {  
            margin: 0;
        }
        #content{
            resize: none;
        }
        .gugubun{
            width: 130px;
            height: 40px;
            margin: 0px 5px 0px 0px;
            font-size: 1rem; 
        } 
        .stustu {
            display: inline-block;
        }
    </style>
    <script>
        let locationHref = location.href;
        let nhForm;  // 전역변수

        $(function () {
            nhForm = document.querySelector("#nhForm");

            console.log("locationHref >> ", locationHref);
            let temp = document.getElementsByName("trHref").href;
            console.log("temp >> ", temp);
            
            $('#btnSearch').on('click', function() {
                let keyword = $("input[name='table_search']").val();
                console.log("table_search: " + keyword);

                let searchCnd = document.getElementById("searchCnd").value;
                console.log("searchCnd >> ", searchCnd);

                getList(keyword, 1, searchCnd);
            });
			
            // 모달이 열릴 때
            $('#consultingModal').on('show.bs.modal', function () {
                let tr = event.target.closest("tr");  // 클릭이벤트가 td에서 발생하므로-> 상위 tr찾기

                let data = tr.dataset;    // 줄여쓰기

                nhForm.stno.value = data.stno;
//                 nhForm.consulReqNo.value = document.getElementById('consulReqNo').value;
                nhForm.name.value = data.name;
                nhForm.categ.value = data.categ; 
                nhForm.time.value = data.date;
                nhForm.title.value = data.title; 
                nhForm.content.value = data.content; 
                nhForm.consult.value = data.time;
            });
        });
        
        
        //목록
        function getList(keyword, currentPage, queGubun) {
            let queGubunTemp = "";
            if(queGubun != null) {
                queGubunTemp = queGubun;
            }

            // JSON 오브젝트
            let data = {
                "keyword": keyword,
                "currentPage": currentPage,
                "queGubun": queGubunTemp //구분 추가
            };

            console.log("data : " , data);

            //아작나써유..(피)씨다타써...
            $.ajax({
                url: "/student/stulistAjax", //ajax용 url 변경
                contentType:"application/json;charset=utf-8",
                data:JSON.stringify(data),
                type:"post",
                dataType:"json",
                beforeSend:function(xhr){
                    xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                },
                success:function(result){
                    console.log("result.content : ", result.content);

                    let str = "";

                    if(result.content.length == 0) {
                        str += `<tr>`;
                        str += `<td colspan="8" style="text-align:center;">검색 결과가 없습니다.</td>`;
                        str += `</tr>`;
                    }

                    $.each(result.content, function(idx, consultingRequestVO){
                        str += `<tr name="trHref" style="cursor:pointer" data-toggle="modal" data-target="#consultingModal"
                                    data-rn="${consultingRequestVO.rn}"
                                    data-consulReqNo="${consultingRequestVO.consulReqNo}"
                                    data-stNo="${consultingRequestVO.stNo}"
                                    data-name="${consultingRequestVO.userInfoVOMap.userName}"
                                    data-categ="${consultingRequestVO.consulCateg}"
                                    data-title="${consultingRequestVO.consulTitle}"
                                    data-content="${consultingRequestVO.consulCon}"
                                    data-date="${consultingRequestVO.consulReqDate}"
                                    data-time="${consultingRequestVO.consulReqTime}"
                                    data-condition="${consultingRequestVO.consulReqCondition}">
                            <td class="textCenter">${consultingRequestVO.rn}</td>
                            <input type="hidden" value="${consultingRequestVO.consulReqNo}">
                            <td class="textCenter">${consultingRequestVO.stNo}</td>
                            <td class="textCenter">${consultingRequestVO.userInfoVOMap.userName}</td>
                            <td class="textCenter">${consultingRequestVO.consulCateg}</td>
                            <td>${consultingRequestVO.consulTitle}</td>
                            <td class="textCenter">${consultingRequestVO.consulReqDate}</td>
                            <td class="textCenter">${consultingRequestVO.consulReqTime}</td>`;
                            if(consultingRequestVO.consulReqCondition == '1') {
                                str += `<td class="textCenter" style="color: green;">대기</td>`;
                            } else if(consultingRequestVO.consulReqCondition == '2') {
                                str += `<td class="textCenter" style="color: blue;">승인</td>`;
                            } else if(consultingRequestVO.consulReqCondition == '3') {
                                str += `<td class="textCenter" style="color: red;">반려</td>`;
                            }
                            str += `</tr>`;
                    });

                    $(".clsPagingArea").html(result.pagingArea);
                    $("#trShow").html(str);
                }
            });
        }
        
        $(document).ready(function() {
            $('#jang').on('click', function() {
            	console.log($('#consulReqNo').val())
                let formData = {
                    "stNo": nhForm.stno.value,
//                     "consulReqNo": nhForm.consulReqNo.value,
                    "consulReqNo": $('#consulReqNo').val(),
                    "name": nhForm.name.value,
                    "categ": nhForm.categ.value,
                    "date": nhForm.time.value,
                    "title": nhForm.title.value,
                    "content": nhForm.content.value,
                    "consult": nhForm.consult.value,
                    "condition": $('#gubun').val()
                };

                console.log("formData: ", formData);
                
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
                    if (result.isConfirmed) {
                        $.ajax({
                            url: "/student/updateAjax",
                            contentType: "application/json;charset=utf-8",
                            data: JSON.stringify(formData),
                            type: "post",
                            dataType: "json",
                            beforeSend: function(xhr) {
                                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                            },
                            success: function(result) {
                                if (result != null) {
                                	Swal.fire({
                                        title: "저장 성공!",
                                        text: "목록으로 이동합니다",
                                        icon: "success"
                                    }).then((result) => {
//                                     	$('#gubun').attr("disabled",true);
//                                     	document.getElementById('jang').style.display = 'none';
                                        location.href = "/student/requestList?menuId=proEvaLua";
                                    });
                                } else {
                                    Swal.fire({
                                        title: '저장 취소',
                                        text: '저장을 취소했습니다.',
                                        icon: 'error'
                                    });
								}
                            }
                        });
                  	}
                });
            });
        });
    </script>
</head>
<body>
    <h3>상담 신청 조회</h3>

   <br>
   <div class="card" style="margin: auto;">
      <div class="card-header" style="background-color: #fff;">
         <div class="brd-search">
            <select title="검색 조건 선택" id="searchCnd" class="selectSearch form-control sssear">
               <option value="1" selected="selected">학번</option>
               <option value="2">이름</option>
               <option value="3">구분</option>
               <option value="4">상담기록</option>
            </select>

            <div class="input-group input-group-sm"
               style="width: 280px; float: left;">
               <input type="text" name="table_search"
                  class="form-control float-left" placeholder="검색어를 입력하세요">
               <div class="input-group-append">
                  <button type="button" class="btn btn-default" id="btnSearch">
                     <i class="fas fa-search"></i>
                  </button>
               </div>
            </div>
         </div>
      </div>

      <div class="card-body table-responsive p-0">
         <table class="table table-hover text-nowrap">
            <thead>
               <tr class="trBackground textCenter" style="color:black;">
                  <th style="width: 6%;">번호</th>
                  <th style="width: 7%;">학번</th>
                  <th style="width: 7%;">이름</th>
                  <th style="width: 7%;">구분</th>
                  <th style="width: 25%;">제목</th>
                  <th style="width: 12%;">신청 날짜</th>
                  <th style="width: 12%;">예약 날짜</th>
                  <th style="width: 7%;">상담현황</th>
               </tr>
            </thead>
            <tbody id="trShow">
               <c:forEach var="consultingRequestVO" items="${articlePage.content}" varStatus="stat">
               <tr class="trHref" style="cursor:pointer" data-toggle="modal" data-target="#consultingModal"
                data-rn="${consultingRequestVO.rn}"
                data-consulReqNo="${consultingRequestVO.consulReqNo}"
                data-stNo="${consultingRequestVO.stNo}"
                data-name="${consultingRequestVO.userInfoVOMap.userName}"
                data-categ="${consultingRequestVO.consulCateg}"
                data-title="${consultingRequestVO.consulTitle}"
                data-content="${consultingRequestVO.consulCon}"
                data-date="${consultingRequestVO.consulReqDate}"
                data-time="${consultingRequestVO.consulReqTime}"
                data-condition="${consultingRequestVO.consulReqCondition}">
                  <td class="textCenter">${consultingRequestVO.rn}</td>
                  <input id="consulReqNo" type="hidden" value="${consultingRequestVO.consulReqNo}">
                  <td class="textCenter">${consultingRequestVO.stNo}</td>
                  <td class="textCenter">${consultingRequestVO.userInfoVOMap.userName}</td>
                  <td class="textCenter">${consultingRequestVO.consulCateg}</td>
                  <td>${consultingRequestVO.consulTitle}</td>
                  <td class="textCenter">${consultingRequestVO.consulReqDate}</td>
                  <td class="textCenter">${consultingRequestVO.consulReqTime}</td>
							<c:choose>
								<c:when test="${consultingRequestVO.consulReqCondition == '1'}">
									<td class="textCenter" style="color: green;">대기</td>
								</c:when>
								<c:when test="${consultingRequestVO.consulReqCondition == '2'}">
									<td class="textCenter" style="color: blue;">승인</td>
								</c:when>
								<c:when test="${consultingRequestVO.consulReqCondition == '3'}">
									<td class="textCenter" style="color: red;">반려</td>
								</c:when>
							</c:choose>
						</tr>
               </c:forEach>
            </tbody>
         </table>
      </div>
      
      <!-- 모달 -->
	<div class="modal fade" id="consultingModal" tabindex="-1" role="dialog" aria-labelledby="consultingModalLabel" aria-hidden="true">
	    <div class="modal-dialog" role="document">
	        <div class="modal-content" style="width: 600px;">
	            <div class="modal-header">
	                <h5 class="modal-title" id="consultingModalLabel">상담 상세 내용</h5>
	                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	                    <span aria-hidden="true">&times;</span>
	                </button>
	            </div>
	            <div class="modal-body">
	                <form id="nhForm">
	                    <div class="form-group stustu">
	                        <label for="modalstno">학번</label>
	                        <input type="text" class="form-control" id="stno" name="stno" style="width: 277px" readonly>
	                    </div>
	                    
	                        <input type="hidden" class="form-control reqNo" id="consulReqNo" name="consulReqNo" value="${consultingRequestVO.consulReqNo}" style="width: 277px" readonly>
	                    
	                    &nbsp;
	                    <div class="form-group stustu">
	                        <label for="modalname">이름</label>
	                        <input type="text" class="form-control" id="name" name="name" style="width: 277px" readonly>
	                    </div>
	                    <div class="form-group stustu">
	                        <label for="modalgubun">구분</label>
	                        <input type="text" class="form-control" id="categ" name="categ" style="width: 277px" readonly>
	                    </div>
	                    &nbsp;
	                    <div class="form-group stustu">
	                        <label for="modalTime">신청날짜</label>
	                        <input type="text" class="form-control" id="time" name="time" style="width: 277px" readonly>
	                    </div>
	                    
	                    <div class="form-group">
	                        <label for="modaltitle">제목</label>
	                        <input type="text" class="form-control" id="title" name="title" readonly>
	                    </div>
	                    <div class="form-group">
	                        <label for="modalcontent">상담내용</label>
								<textarea class="form-control" id="content" name="content" style="height: 200px" readonly></textarea>
	                    </div>
	                    
	                    <div class="form-group">
	                        <label for="modalconsult">상담예약일 및 시간</label>
	                        <input type="text" class="form-control" id="consult" name="consult" readonly>
	                    </div>
	                    
	                    <div class="form-group">
	                        <label for="modalCondition">상담현황</label>
		                    <select title="구분 선택" id="gubun" name="gubun" class="selectSearch form-control gugubun">
<!-- 			                   <option value="1" selected="selected">대기</option> -->
				               <option value="1">대기</option>
				               <option value="2">승인</option>
				               <option value="3">반려</option>
			                </select>
	                    </div>
	                </form>
	            </div>
	            <div class="modal-footer">
	            	<button type="button" class="btn btn-block btn-outline-primary cloclose" id="jang">저장</button>
	            </div>
	        </div>
	    </div>
   </div>
   
   </div>

	<div class="row clsPagingArea">
    <div class='col-sm-12 col-md-7'>
        <div class='dataTables_paginate paging_simple_numbers' id='example2_paginate'>
            <ul class='pagination'>
                <!-- Previous Button -->
                <li class='paginate_button page-item previous disabled' id='example2_previous'>
                    <a href='#' onclick="getList('keyword', startPage - 5, queGubun)" aria-controls='example2' data-dt-idx='0' tabindex='0' class='page-link'>&lt;&lt;</a>
                </li>
                
                <!-- Page Numbers -->
                <li class='paginate_button page-item active'>
                    <a href='#' onclick="getList('keyword', 1, queGubun)" aria-controls='example2' data-dt-idx='1' tabindex='0' class='page-link'>1</a>
                </li>
                <li class='paginate_button page-item'>
                    <a href='#' onclick="getList('keyword', 2, queGubun)" aria-controls='example2' data-dt-idx='2' tabindex='0' class='page-link'>2</a>
                </li>
                <li class='paginate_button page-item'>
                    <a href='#' onclick="getList('keyword', 3, queGubun)" aria-controls='example2' data-dt-idx='3' tabindex='0' class='page-link'>3</a>
                </li>
                <li class='paginate_button page-item'>
                    <a href='#' onclick="getList('keyword', 4, queGubun)" aria-controls='example2' data-dt-idx='4' tabindex='0' class='page-link'>4</a>
                </li>
                <li class='paginate_button page-item'>
                    <a href='#' onclick="getList('keyword', 5, queGubun)" aria-controls='example2' data-dt-idx='5' tabindex='0' class='page-link'>5</a>
                </li>
                <!-- Next Button -->
                <li class='paginate_button page-item next' id='example2_next'>
                    <a href='#' onclick="getList('keyword', startPage + 5, queGubun)" aria-controls='example2' data-dt-idx='7' tabindex='0' class='page-link'>&gt;&gt;</a>
                </li>
            </ul>
        </div>
    </div>
</div>

</body>
</html>
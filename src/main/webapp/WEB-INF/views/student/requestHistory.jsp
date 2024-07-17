<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!-- <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet"> -->
<!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script> -->
<html>
<head>
<script type="text/javascript">
let locationHref = window.location.href;
$(function () {
   
   console.log("locationHref >> ", locationHref);
   let temp = document.getElementsByName("trHref").href;
    console.log("temp >> ", temp);
   
   $('#btnSearch').on('click', function() {
      let keyword = $("input[name='table_search']").val();
      console.log("table_search: " + keyword);
      
      let searchCnd = document.getElementById("searchCnd").value;
      console.log("searchCnd >> ", searchCnd);
      
      getList(keyword, 1, searchCnd);
   })

});



//목록
function getList(keyword, currentPage, queGubun) {
   let queGubunTemp = "";
   if(queGubun != null) {
      queGubunTemp = queGubun;
   }
   
   // JSON 오브젝트
   let data = {
      "keyword":keyword,
      "currentPage":currentPage,
      "queGubun":queGubunTemp //구분 추가
   };
   
   console.log("data : " , data);
   
 //아작나써유..(피)씨다타써...
   $.ajax({
      url: "/student/hislistAjax", //ajax용 url 변경
      contentType:"application/json;charset=utf-8",
      data:JSON.stringify(data),
      type:"post",
      dataType:"json",
      beforeSend:function(xhr){
            xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
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
            str += `<tr name="trHref" onclick="location.href='/student/requestDetail?menuId=proEvaLua&consulReqNo=\${consultingRequestVO.consulReqNo}'" style="cursor:pointer">
            <td class="textCenter">\${consultingRequestVO.rn}</td>
            <td class="textCenter">\${consultingRequestVO.stNo}</td>
            <td class="textCenter">\${consultingRequestVO.userInfoVOMap.userName}</td>
            <td class="textCenter">\${consultingRequestVO.consulCateg}</td>
            <td>\${consultingRequestVO.consulTitle}</td>
            <td class="textCenter">\${consultingRequestVO.consulReqDate}</td>
            <td class="textCenter">\${consultingRequestVO.consulReqTime}</td>`;
//             <td class="textCenter">\${consultingRequestVO.consulReqCondition}</td>`;
            if(`\${consultingRequestVO.consultingRecordVOMap.conCont}` == '1') {
                str += `<td class="textCenter" style="color: green;">대기</td>`;
             } if(`\${consultingRequestVO.consultingRecordVOMap.conCont}` == '2') {
                str += `<td class="textCenter" style="color: blue;">완료</td>`;
 			} str += `</tr>`;
         });
         
         $(".clsPagingArea").html(result.pagingArea);
         
         $("#trShow").html(str);
      }
   });
}   
   
   
</script>
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
   margin-top:  20px;
   justify-content: flex-end;
}

.card {
   width: 80%;  /*목록 넓이*/
}

.textCenter {
    text-align:center;
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

.gugubun{
	width: 130px;
	height: 40px;
	margin: 0px 5px 0px 0px;
	font-size: 1rem; 
 } 


</style>

</head>
<body>
   <h3>상담 내역</h3>
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
      
<%-- <p>${articlePage.content}</p> --%>
      <div class="card-body table-responsive p-0">
         <table class="table table-hover text-nowrap">
            <thead>
               <tr class="trBackground textCenter">
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
<%--                ${consultingRequestVO.consulReqNo} --%>
               <tr id="trHref" onclick="location.href='/student/requestDetail?menuId=proEvaLua&consulReqNo=${consultingRequestVO.consulReqNo}'" style="cursor:pointer">
                  <td class="textCenter">${consultingRequestVO.rn}</td>
                  <td class="textCenter">${consultingRequestVO.stNo}</td>
                  <td class="textCenter">${consultingRequestVO.userInfoVOMap.userName}</td>
                  <td class="textCenter">${consultingRequestVO.consulCateg}</td>
                  <td>${consultingRequestVO.consulTitle}</td>
                  <td class="textCenter">${consultingRequestVO.consulReqDate}</td>
                  <td class="textCenter">${consultingRequestVO.consulReqTime}</td>
<%--                   <td class="textCenter">${consultingRequestVO.consultingRecordVOMap.conCont}</td> --%>
							<c:choose>
								<c:when test="${consultingRequestVO.consultingRecordVOMap.conCont == '1'}">
									<td class="textCenter" style="color: green;">대기</td>
								</c:when>
								<c:when test="${consultingRequestVO.consultingRecordVOMap.conCont == '2'}">
									<td class="textCenter" style="color: blue;">완료</td>
								</c:when>
							</c:choose>
						</tr>
               </c:forEach>
            </tbody>
         </table>
      </div>
   </div>

<!--    <div class="row clsPagingArea"> -->
<%--       ${articlePage.pagingArea} --%>
<!--    </div> -->
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
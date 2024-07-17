<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!-- <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script> -->
<html>
<head>
<script type="text/javascript">
let locationHref = window.location.href;
$(function () {
   
   $('#consult').on('click', function(){
      location.href = "/consulting/request?menuId=cybConSul";   
   });
   
   
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

// 	//table tr을 클릭 하면 모달창 show
// 	$('#table').on('click', 'tbody tr', function (e) {
// 		$('#modalXl').modal('show');
// 	})
	
// 	//table tr 안에 button modal event 막는 스크립트
// 	$('#table').on('click', 'tbody tr button', function (e) {
// 		e.stopPropagation();
// 	})

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
      url: "/consulting/listAjax", //ajax용 url 변경
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
            str += `<tr name="trHref" onclick="location.href='/consulting/detail?menuId=cybConSul&consulReqNo=\${consultingRequestVO.consulReqNo}'" style="cursor:pointer">
            <td class="textCenter">\${consultingRequestVO.rn}</td>
            <td class="textCenter">\${consultingRequestVO.consulCateg}</td>
            <td>\${consultingRequestVO.consulTitle}</td>
            <td class="textCenter">\${consultingRequestVO.consulReqTime}</td>`;
//             <td class="textCenter">\${consultingRequestVO.consulReqCondition}</td>`;
//             str += `<td class="textCenter">\${consultingRequestVO.consulReqCondition}</td>`;
            if(`\${consultingRequestVO.consulReqCondition}` == '1') {
               str += `<td class="textCenter" style="color: green;">대기</td>`;
            } if(`\${consultingRequestVO.consulReqCondition}` == '2') {
               str += `<td class="textCenter" style="color: blue;">승인</td>`;
            } if(`\${consultingRequestVO.consulReqCondition}` == '3') {
               str += `<td class="textCenter" style="color: red;">반려</td>`;
			} str += `</tr>`;
         });
         
         $(".clsPagingArea").html(result.pagingArea);
         
         $("#trShow").html(str);
      }
   });
}   
   
   /*
$('#consultingModal').on('show.bs.modal', function (event) {
    var button = $(event.relatedTarget); // 클릭한 <tr> 요소
    var rn = button.data('rn');
    var categ = button.data('categ');
    var title = button.data('title');
    var time = button.data('time');
    var condition = button.data('condition');
    
    var modal = $(this);
    modal.find('.modal-body #modalRn').val(rn);
    modal.find('.modal-body #modalCateg').val(categ);
    modal.find('.modal-body #modalTitle').val(title);
    modal.find('.modal-body #modalTime').val(time);
    modal.find('.modal-body #modalCondition').val(condition);
});
   */   
   
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

.selectSearch{
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

</head>
<body>
   <h3>상담내역</h3>
   <br>
   
   <div class="expBox">
		<strong>
			<p>
				※신청한 상담의 상세내역과 상담현황을 조회 할 수 있습니다.
			</p>
			<br>
			<p>
				[상담현황]
			</p>
			<p>상담신청 완료 직후 '대기' 로 표기되며 담당 교수님께서 '승인' 또는 '반려' 를 선택하여 상담이 진행 또는 취소 됩니다.</p>
			<i>*무조건적으로 '승인' 되는 것이 아닌 담당 교수님의 스케줄에 따라 '반려' 될 수 있음을 인지하여주시고 양해 바랍니다.</i>
			</p>
		</strong>
	</div>
   
   <div class="card" style="margin: auto;">
      <div class="card-header" style="background-color: #fff;">
         <div class="brd-search">
            <select title="검색 조건 선택" id="searchCnd" class="selectSearch form-control">
               <option value="1" selected="selected">구분</option>
               <option value="2">제목</option>
               <option value="3">상담예약일</option>
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
            <button type="button" name="consult" class="btn btn-block btn-outline-primary wkrtjdBut" id="consult">상담신청</button>
         </div>
      </div>

      <div class="card-body table-responsive p-0">
         <table class="table table-hover text-nowrap">
            <thead>
               <tr class="trBackground textCenter" style="color:black;">
                  <th style="width: 8%;">번호</th>
                  <th style="width: 12%;">구분</th>
                  <th>제목</th>
                  <th style="width: 15%;">상담예약일시</th>
                  <th style="width: 15%;">상담현황</th>
               </tr>
            </thead>
            <tbody id="trShow">
               <c:forEach var="consultingRequestVO" items="${articlePage.content}" varStatus="stat">
               <tr id="trHref" onclick="location.href='/consulting/detail?menuId=cybConSul&consulReqNo=${consultingRequestVO.consulReqNo}'" style="cursor:pointer">
                  <td class="textCenter">${consultingRequestVO.rn}</td>
                  <td class="textCenter">${consultingRequestVO.consulCateg}</td>
                  <td>${consultingRequestVO.consulTitle}</td>
                  <td class="textCenter">${consultingRequestVO.consulReqTime}</td>
<%--                   <td class="textCenter">${consultingRequestVO.consulReqCondition}</td> --%>
							<c:choose>
								<c:when test="${consultingRequestVO.consulReqCondition == '1'}">
									<td class="textCenter" style="color: green;">대기</td>
								</c:when>
								<c:when test="${consultingRequestVO.consulReqCondition == '2'}">
									<td class="textCenter" style="color: blue;">완료</td>
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
      
     
   
   </div>

   <div class="row clsPagingArea">
      ${articlePage.pagingArea}
   </div>

</body>
</html>
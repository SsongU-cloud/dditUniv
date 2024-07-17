<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet"> -->
<!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script> -->
<html>
<head>
<style>
h3 {
        color: black;
        margin-bottom: 15px;
        margin-top: 40px;
        margin-left: 165px;
    }
/* .mainbd {
    padding-top: 40px;
    margin-left: 165px;
    margin-bottom: 20px;
    width: 80%;
    } */
.trBackground {
    background-color: #ebf1e9;
}
.wkrtjdBut {
    width: 121px;
    float: right;
}
.selectSearch{
    width: 130px;
    height: 30px;
    float: left;
    margin: 0px 5px 0px 0px;
    font-size: 0.8rem;
}
/* .divCard {
    margin: auto;
} */
.divCardHeader {
    background-color: #fff;
}
.divSearch {
    width: 280px;
    float: left;
}
.textCenter {
    text-align:center;
}
.clsPagingArea {
   margin-top: 20px;
   justify-content: flex-end;
}
#btnSearch {
   border: 1px solid #D1D3E2;
   background-color: #F8F9FA;
}

</style>
<script type="text/javascript">
let locationHref = window.location.href;
$(function () {
   console.log("locationHref >> ", locationHref);
   let temp = document.getElementsByName("trHref").href;
   console.log("temp >> ", temp);
   
   $("#btnVolAdd").on("click",function(){
      location.href="/employment/volAdd?menuId=cybJobHun";
   });
   
   $('#btnSearch').on('click', function () {
      let keyword = $("input[name='table_search']").val();
      console.log("table_search: " + keyword);

      let searchCnd = document.getElementById("searchCnd").value;
      console.log("searchCnd >> ", searchCnd);
      
      getList(keyword, 1, searchCnd);
   });
});

// 목록
function getList(keyword, currentPage, queGubun) {
   let queGubunTemp = "";
   if (queGubun != null) {
      queGubunTemp = queGubun;
   }
   
   // JSON 오브젝트
   let data = {
      "keyword": keyword,
      "currentPage": currentPage,
      "queGubun": queGubunTemp // 구분 추가
   };
   
   console.log("data : ", data);
   
   // Ajax 호출
   $.ajax({
      url: "/employment/volunteerAjax", // Ajax 요청 URL
      contentType: "application/json;charset=utf-8",
      data: JSON.stringify(data),
      type: "post",
      dataType: "json",
      beforeSend: function (xhr) {
         xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
      },
      success: function (result) {
         console.log("result.content : ", result.content);
         
         let str = "";
         
         if (result.content.length == 0) {
            str += `<tr>`;
            str += `<td colspan="5" style="text-align:center;">검색 결과가 없습니다.</td>`;
            str += `</tr>`;
         }
         
         $.each(result.content, function (idx, volunteerVO) {
            console.log("volunteerVO", volunteerVO);
            console.log("volunteerVO", volunteerVO);
            str += `<tr name="trHref" onclick="location.href='/employment/volDetail?menuId=cybJobHun&volNo=\${volunteerVO.volNo}'" style="cursor:pointer">`;
            str += `<td class="textCenter">\${volunteerVO.rowNum}</td>`;
            str += `<td class="textCenter">\${volunteerVO.volTime}시간</td>`;
            str += `<td>\${volunteerVO.volCon}</td>`;
            str += `<td class="textCenter">\${volunteerVO.volStartDisplay}</td>`;
            str += `<td class="textCenter">\${volunteerVO.volEndDisplay}</td>`; 
            str += `</tr>`;
         });
         
         $("#trShow").html(str);
         $(".clsPagingArea").html(result.pagingArea);
      }
   });
}
</script>
</head>
<body>
    <h3>봉사활동</h3>
    <br>
   <h5 style="margin-left: 165px;">봉사활동 총 <span style="color: red;">${volTotalTime}</span> 시간</h5>
    <br>
    <div class="card" style="width: 80%; margin-left: 165px;">
        <div class="card-header" class="divCardHeader" style="background-color: #fff;">
            <div class="brd-search">
                <select title="검색 조건 선택" id="searchCnd" class="selectSearch form-control">
                    <option value="1">번호</option>
                    <option value="2">봉사시간</option>
                    <option value="3">봉사시작날짜</option>
                    <option value="4">봉사종료날짜</option>
                    <option value="5">봉사내역</option>
                </select>

                <div class="input-group input-group-sm divSearch">
                    <input type="text" name="table_search" class="form-control float-left" placeholder="검색어를 입력하세요">
                    <div class="input-group-append">
                        <button type="button" class="btn btn-default" id="btnSearch">
                            <i class="fas fa-search"></i>
                        </button>
                    </div>
                </div>
                <button type="button" id="btnVolAdd" class="btn btn-block btn-outline-primary wkrtjdBut">작성</button>

            </div>
        </div>
        <div class="card-body table-responsive p-0">
            <table class="table table-hover text-nowrap">
                <thead>
                    <tr class="trBackground textCenter" style="color:black;">
                        <th style="width: 8%;">번호</th>
                        <th style="width: 10%;">봉사시간</th>
                        <th>봉사내역</th>
                        <th style="width: 15%;">봉사시작날짜</th>
                        <th style="width: 15%;">봉사종료날짜</th>
                    </tr>
                </thead>
                <tbody id="trShow">
                    <c:forEach var="volunteerVO" items="${articlePage.content}" varStatus="stat">
                 <!-- ${volunteerVO}  -->
                            <tr name="trHref" onclick="location.href='/employment/volDetail?menuId=cybJobHun&volNo=${volunteerVO.volNo}'" style="cursor:pointer">
                                 <td class="textCenter">${volunteerVO.rowNum}</td> 
                                 <td class="textCenter">${volunteerVO.volTime}시간</td>
                                 <td>${volunteerVO.volCon}</td>
                                 <td class="textCenter">${volunteerVO.volStartDisplay}</td>
                                 <td class="textCenter">${volunteerVO.volEndDisplay}</td>
                            </tr>
                    </c:forEach>
            </table>
        </div>
    </div>
    
    <div class="row clsPagingArea">
        ${articlePage.pagingArea}
    </div>
    <!-- 페이징 처리 -->
</body>
</html>
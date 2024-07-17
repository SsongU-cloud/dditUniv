<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!-- <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script> -->
<html>
<head>
<style>
h3 {
	color: black;
    margin-bottom: 30px;
    margin-top: 40px;
    margin-left: 165px;
} 
.trBackground {
    background-color: #ebf1e9;
}
.expBox {
    background-color: white;
    border: 1px solid #ced4da;
    width: 80%;
    margin-left: 160px;
    margin-bottom: 30px;
    padding: 40px 40px 30px 40px;
}
.wkrtjdBut {
    width: 105px;
    float: right;
}
.selectSearch{
    width: 130px;
    height: 30px;
    float: left;
    margin: 0px 5px 0px 0px;
    font-size: 0.8rem;
}
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
.fas.fa-heart{
    margin-right: 5px;
    color: #ffc3c3;
}

</style>
<script type="text/javascript">
let locationHref = window.location.href;
$(function () {
    $('#btnSearch').on('click', function () {
        let keyword = $("input[name='table_search']").val();
        console.log("table_search: " + keyword);

        let searchCnd = document.getElementById("searchCnd").value;
        console.log("searchCnd >> ", searchCnd);
        
        getList(keyword, 1, searchCnd);
    })
    //작성버튼 클릭시
    $('#newwrite').on('click', function(){
		location.href = "/timePost/lecBoaAdd?menuId=injTopBoa";	
	});
    /**
     * 좋아요 많이 받은 게시물 top5
     */
    $.ajax({
        url:"/timePost/mostLikeList",
        type:"get",
        dataType:"json",
        beforeSend:function(xhr){
            xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
        },
        success:function(result){
            console.log(" 추천테이블 result>",result);
            mostLikeList="";
            mostLikeList+=`
            <div class="card-body table-responsive p-0">
                <table class="table table-hover text-nowrap">
                    <thead>
                        <tr class="trBackground textCenter">
                            <th style="width:10%;">구분</th>
                            <th style="width:40%;">제목</th>
                            <th style="width:10%;">작성일자</th>
                            <th style="width:5%;">조회수</th>
                            <th style="width:5%;">좋아요</th>
                        </tr>
                    </thead>
                    <tbody id="">
                    `;
                    $.each(result, function(idx, timeLecutreBoastVO){
                        console.log("timeLecutreBoastVO",timeLecutreBoastVO);
                        let inputData = `\${timeLecutreBoastVO.timeLecDate}`;
                        let formattedDateValue = formattedDate(inputData);

                    mostLikeList+=`
                          <tr name="trHref" onclick="location.href='/timePost/lecBoaDetail?menuId=injTopBoa&timeLecBoNo=\${timeLecutreBoastVO.timeLecBoNo}'" style="cursor:pointer">
                            <td class="textCenter" style="color:red;">[추천]</td>
                            <td>\${timeLecutreBoastVO.timeLecBoName}</td>
                            <td class="textCenter">\${formattedDateValue}</td>
                            <td class="textCenter">\${timeLecutreBoastVO.timeViews}</td>
                            <td class="textCenter"><i class="fas fa-heart"></i>\${timeLecutreBoastVO.timeLecLike}</td>
                        </tr>
                        `;
                    });
                mostLikeList+=`</tbody>
                </table>
            </div>            
            `;
            $("#mostLikeListDisp").html(mostLikeList);

        }//success end
    })
    //추천테이블 end

});//function end

// 목록
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
      console.log("data : ", data);
   
   $.ajax({
      url: "/timePost/lecutreBoastAjax", 
      contentType:"application/json;charset=utf-8",
      data:JSON.stringify(data),
      type:"post",
      dataType:"json",
      beforeSend:function(xhr){
            xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
        },
      success:function(result){
         let str = "";
         
         if(result.content.length == 0) {
            str += `<tr>`;
            str += `<td colspan="5" style="text-align:center;">검색 결과가 없습니다.</td>`;
            str += `</tr>`;
         }
         
         $.each(result.content, function(idx, timeLecutreBoastVO){
            // console.log("timeLecutreBoastVO",timeLecutreBoastVO);
            str += `<tr name="trHref" onclick="location.href='/timePost/lecBoaDetail?menuId=injTopBoa&timeLecBoNo=\${timeLecutreBoastVO.timeLecBoNo}'" style="cursor:pointer">`;
            str += `<td class="textCenter">\${idx+1}</td>`;
            str += `<td class="textCenter">[일반]</td>`;
            str += `<td>\${timeLecutreBoastVO.timeLecBoName}</td>`;
            str += `<td class="textCenter"> \${timeLecutreBoastVO.timeLecDate}</td>`;
            str += `<td class="textCenter"> \${timeLecutreBoastVO.timeViews}</td>`;
            str += `<td class="textCenter"><i class="fas fa-heart"></i>\${timeLecutreBoastVO.timeLecLike}</td>`;         
            str += `</tr>`;
         });
         
         $(".clsPagingArea").html(result.pagingArea);
         
         $("#trShow").html(str);
      }
   });
}
function formattedDate(inputData){
    let dateObj = new Date(inputData);
    // yyyy-mm-dd 형식으로 변환
    var year = dateObj.getFullYear();
    var month = ('0' + (dateObj.getMonth() + 1)).slice(-2); // 월은 0부터 시작하므로 +1 필요
    var day = ('0' + dateObj.getDate()).slice(-2);

    var formattedDate = year + '-' + month + '-' + day;
    console.log("formattedDate", formattedDate);
    
    return formattedDate; // 변환된 날짜를 반환
}
</script>
</head>

<body>
    <h3 style="margin-bottom: 30px;margin-top: 40px;color:black;">강의자랑게시글</h3>
     <br>
    <div class="expBox">
		<strong style="color:black;">
			<p>
				※이 게시판은 강의자와 학생들이 유용한 정보를 교환하기 위한 공간입니다. 아래와 같은 게시물은 금지되며, 위반 시 민형사상 불이익을 받을 수 있습니다.
			</p>
			<br>
			<p>
				상업성 광고
                정치적 목적 게시물
                특정단체 개인의 명예훼손 게시물
				음란물 등 미풍양속에 어긋나는 게시물
			</p>
			<p>
				관리자의 권한으로 삭제될 수 있으니, 게시판의 성격에 맞는 내용만 게시해 주시기 바랍니다.
			</p>
		</strong>
	</div>

    <div id="mostLikeListDisp" class="card" style="margin:auto;width: 80%;">
        <div class="card-body table-responsive p-0">
            <table class="table table-hover text-nowrap">
                <thead>
                    <tr class="trBackground textCenter" style="color:black;">
                        <th style="width:8%;">번호</th>
                        <th style="width:10%;">구분</th>
                        <th style="width:40%;">제목</th>
                        <th style="width:10%;">작성일자</th>
                        <th style="width:5%;">조회수</th>
                        <th style="width:5%;">좋아요</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="timeLecutreBoastVO" items="${articlePage.content}" varStatus="stat">
                            <tr name="trHref" onclick="'/timePost/lecBoaDetail?menuId=injTopBoa'" style="cursor:pointer">
                                <td class="textCenter">[추천]</td>
                                <td>${timeLecutreBoastVO.timeLecBoName}</td>
                                <td class="textCenter">${timeLecutreBoastVO.timeLecDate}</td>
                                <td class="textCenter">${timeLecutreBoastVO.timeViews}</td>
                                <td class="textCenter"><i class="fas fa-heart"></i>${timeLecutreBoastVO.timeLecLike}</td>
                            </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <br>
    <br>
    <div class="card" style="margin:auto;width: 80%;">
        <div class="card-header" class="divCardHeader" style="background-color: #fff;">
            <div class="brd-search">
                <select title="검색 조건 선택" id="searchCnd" class="selectSearch form-control">
                    <option value="1">제목</option>
                    <option value="2">작성일자</option>
                    <option value="3">조회수</option>
                    <option value="4">좋아요</option>
                </select>

                <div class="input-group input-group-sm divSearch">
                    <input type="text" name="table_search" class="form-control float-left" placeholder="검색어를 입력하세요">
                    <div class="input-group-append">
                        <button type="button" class="btn btn-default" id="btnSearch">
                            <i class="fas fa-search"></i>
                        </button>
                    </div>
                </div>
            </div>
            	<button type="button" name="authorityBtn" class="btn btn-block btn-outline-primary wkrtjdBut" id="newwrite">작성</button>
            </div>

        <div class="card-body table-responsive p-0">
            <table class="table table-hover text-nowrap">
                <thead>
                    <tr class="trBackground textCenter" style="color:black;">
                        <th style="width:8%;">번호</th>
                        <th style="width:10%;">구분</th>
                        <th style="width:40%;">제목</th>
                        <th style="width:10%;">작성일자</th>
                        <th style="width:5%;">조회수</th>
                        <th style="width:5%;">좋아요</th>
                    </tr>
                </thead>
                <tbody id="trShow">
                    <c:forEach var="timeLecutreBoastVO" items="${articlePage.content}" varStatus="stat">
                        <!-- ${timeLecutreBoastVO} -->
                        <tr name="trHref" onclick="location.href='/timePost/lecBoaDetail?menuId=injTopBoa&timeLecBoNo=${timeLecutreBoastVO.timeLecBoNo}'" style="cursor:pointer">
                            <td class="textCenter">${stat.index + 1}</td>
                            <td class="textCenter">[일반]</td>
                            <td>${timeLecutreBoastVO.timeLecBoName}</td>
                            <td class="textCenter">${timeLecutreBoastVO.timeLecDate}</td>
                            <td class="textCenter">${timeLecutreBoastVO.timeViews}</td>
                            <td class="textCenter"><i class="fas fa-heart"></i>${timeLecutreBoastVO.timeLecLike}</td>
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
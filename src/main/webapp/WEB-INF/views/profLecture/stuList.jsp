<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<!-- <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet"> -->
<!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script> -->
<html>
<head>
<style>
* {
	font-family: 'NanumSquareNeo'; 
}
h3 {
    margin-bottom: 30px;
    margin-top: 40px;
    margin-left: 160px;
    display: inline-block;
} 
.trBackground {
    background-color: #ebf1e9;
}
.wkrtjdBut {
    width: 105px;
    float: right;
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
.card {
   width: 80%;  /*목록 넓이*/
   margin: auto;
}
</style>
<script type="text/javascript">
$(function () {
	
});

</script>
</head>

<body>
    <h3 style="color:black;">수강 학생 조회(내 강의 목록)</h3>
    <br>
    <div class="card">
<!--         <div class="card-header" class="divCardHeader" style="background-color: #fff;"> -->
<!--             <div class="brd-search"> -->
<!--             </div> -->
<!--         </div> -->

        <div class="card-body table-responsive p-0">
            <table class="table table-hover text-nowrap">
                <thead>
                    <tr class="trBackground textCenter" style="color:black;">
                        <th style="width: 5%;">번호</th>
                        <th style="width: 15%;">강의 번호</th>
                        <th style="width: 15%;">강의 연도</th>
                        <th style="width: 15%;">강의 학년</th>
                        <th style="width: 15%;">강의 학기</th>
                        <th>강의명</th>
                        <th style="width: 10%;">강의실 번호</th>
                        <th style="width: 15%;">수강인원</th>
                    </tr>
                </thead>
                <tbody id="trShow">
                    <c:forEach var="stuVO" items="${stuList}" varStatus="stat">
                            <tr name="trHref" onclick="location.href='/profLecture/stuDetail?menuId=lecProGre&lecNo=${stuVO.lecNo}'" style="cursor:pointer">
                                <td class="textCenter">${stuVO.rn}</td>
                                <td class="textCenter">${stuVO.lecNo}</td>
                                <td class="textCenter">${stuVO.lecYear}년도</td>
								<c:choose>
		                            <c:when test="${stuVO.lecGrade == 0}">
		                                <td class="textCenter">전학년</td>
		                            </c:when>
		                            <c:otherwise>
		                                <td class="textCenter">${stuVO.lecGrade}학년</td>
		                            </c:otherwise>
		                        </c:choose>
                                <td class="textCenter">${stuVO.lecSemester}학기</td>
                                <td>${stuVO.lecName}</td>
                                <td class="textCenter">${stuVO.lectureRoomVO.lecRoName}</td>
                                <td class="textCenter">${stuVO.lecPer}명</td>
                            </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
    
    <div class="row clsPagingArea">
        ${articlePage.pagingArea}
    </div>
    <!-- 페이징 처리 -->
</body>
</html>
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
    margin-left: 180px;
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
    display: inline-block;
    height: 50vh;
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
.userImage{
	width: 260px;
	height: 345px;
	margin-left: 25px;
	margin-bottom: 370px;
	display: inline;
}
.tableMargin {
	margin-left: 30px;
	display: inline-block;
	width: 70%;
}
.tableMarginTop {
	margin-top: 50px;
}
.displayInline {
	display: inline;
}
.btncli {
	width: 105px;
	display: inline-block;
	margin-left: 750px;
	margin-top: 20px;
}
</style>
<script type="text/javascript">
$(function() {
	$('#list').on('click', function() {
		location.href = "/student/stuTotalList?menuId=proChaMan";
	});

});
</script>
</head>

<body>
    <h3>학과 학생 조회 - 상세조회 </h3>
    <br>
    <div class="card">
        <div class="card-header divCardHeader" style="background-color: #fff;">
        
	        <div class="col-5 text-center displayInline">
	            <!-- 사진 불러오기, 적용 안함 -->
	        <%-- 	<img src="../../../resources/images/${studentVO.stuAttachFileVO.stuName}.${studentVO.stuAttachFileVO.stuAttType}" --%>
	             <img src="${stuTotalDetail.stuAttachFileVO.stuFilePath}" alt="user-avatar" class="img-square img-fluid userImage">
	        </div>
	
	        <div class="card-body table-responsive p-0 tableMargin">
	            <table class="table table-hover text-nowrap tableMarginTop">
					<tbody id="trShow">
	                    <tr>
	                        <th class="trBackground textCenter" style="width: 25%;">성명</th>
	                        <td style="width: 25%;">${stuTotalDetail.userInfoVO.userName}</td>
	                        <th class="trBackground textCenter" style="width: 25%;">생년월일</th>
	                        <td style="width: 25%;">${stuTotalDetail.userInfoVO.userBirth}</td>
	                    </tr>
	                    <tr>
	                        <th class="trBackground textCenter" style="width: 25%;">학년</th>
	                        <td style="width: 25%;">${stuTotalDetail.stGrade}학년</td>
	                        <th class="trBackground textCenter" style="width: 25%;">상태</th>
	                        <td>${stStat}</td>
	                    </tr>
	                    <tr>
	                        <th class="trBackground textCenter">연락처</th>
	                        <td colspan="3">${stuTotalDetail.userInfoVO.userTel}</td>
	                    </tr>
	                    <tr>
	                        <th class="trBackground textCenter">이메일</th>
	                        <td colspan="3">${stuTotalDetail.stEmail}</td>
	                    </tr>
	                    <tr>
	                        <th class="trBackground textCenter">우편번호</th>
	                        <td colspan="3">${stuTotalDetail.stPostno}</td>
	                    </tr>
	                    <tr>
	                        <th class="trBackground textCenter">주소</th>
	                        <td colspan="3">${stuTotalDetail.stAddr}</td>
	                    </tr>
	                    <tr>
	                        <th class="trBackground textCenter">상세 주소</th>
	                        <td colspan="3">${stuTotalDetail.stAddrDet}</td>
	                    </tr>
	                </tbody>
	            </table>
	        </div>
       </div>
    </div>
    <button type="button" class="btn btn-block btn-outline-secondary btncli" id="list">목록</button>
</body>
</html>
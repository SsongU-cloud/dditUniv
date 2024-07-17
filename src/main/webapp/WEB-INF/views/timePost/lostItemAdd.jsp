<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>  
<!-- <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet"> -->
<!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script> -->
<link type="text/css" href="../../../resources/ckeditor/samples/css/samples.css" rel="stylesheet" media="screen" />
<script src="https://cdn.ckeditor.com/ckeditor5/11.0.1/classic/ckeditor.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.js"></script>
<html>
<head>

<style type="text/css">
.trBackground {
    background-color: #ebf1e9;
}
h3 {
    color: black;
    margin-top: 40px;
    margin-left: 165px;
} 
.card-outline {
  margin:auto;
  width: 1320px;
  padding:20px;
}
.title {
	display: flex;
    align-items: baseline;
}
.table>th, .table>td {
    vertical-align: middle;
    padding: 8px;
}
.editable-container {
    border: 1px solid #ced4da;
    padding: 8px;
    min-height: 400px;
}
.editable-container img {
    max-width: 200px;
    height: auto;
    display: block;
    margin-top: 10px;
}
</style>
</head>
<body>
<h3>분실물 게시글 작성</h3>
<br>
<div class="card card-outline card-info">
	<div class="title">
		<label for="title" style="font-size:20px; margin-right:20px">제목</label>
		<input class="form-control col-9" id="title" type="text">
		<label for="writer" style="font-size:14px; margin-left:40px; margin-right:20px">작성자</label>
		<input class="form-control" style="width:150px;" id="writer" type="text" disabled>
	</div>
	<hr>
	<div class="card-body table-responsive p-0">
		<table class="table table-hover text-nowrap">
			<thead>
				<tr>
					<th class="trBackground text-center" style="width:200px; vertical-align: middle; padding: 8px;">습득일</th>
					<td style="width:400px; vertical-align: middle; padding: 8px;">
						<input type="date" class="form-control" id="takeDate"> 
					</td>
					<th class="trBackground text-center" style="width:200px; vertical-align: middle; padding: 8px;">습득장소</th>
					<td style="width:400px; vertical-align: middle; padding: 8px;">
						<input type="text" class="form-control" id="place"> 
					</td>
				</tr>
			</thead>
			<thead>
				<tr>
					<th class="trBackground text-center" style="width:200px; vertical-align: middle; padding: 8px;">분실물 상태</th>
					<td style="width:400px; vertical-align: middle; padding: 8px;">
						<select class="custom-select" id="lostItemStat">
							<option selected disabled>========================================</option>
							<option>보관중</option>
							<option>회수 완료</option>
						</select>
					</td>
					<th class="trBackground text-center" style="width:200px; vertical-align: middle; padding: 8px;">연락처</th>
					<td style="width:400px; vertical-align: middle; padding: 8px;">
						<input type="text" class="form-control" id="telNo"> 
					</td>
				</tr>
			</thead>
			<thead>
				<tr>
					<th class="trBackground text-center" style="width:200px; vertical-align: middle; padding: 8px;">분실물명</th>
					<td style="vertical-align: middle; padding: 8px;" colspan='3'>
						<input type="text" class="form-control" id="lostItemName"> 
					</td>
				</tr>
			</thead>
			<thead>
				<tr>
					<th class="trBackground text-center" style="width:200px; vertical-align: middle; padding: 8px;">물품 사진</th>
					<td style=" vertical-align: middle; padding: 8px;" colspan='3'>
						<input type="file" name="uploadFile" class="" id="uploadFile">
					</td>
				</tr>
			</thead>
			<thead>
				<tr>
					<th class="trBackground text-center" style="width:200px; vertical-align: middle; padding: 8px;">내용</th>
					<th style=" vertical-align: middle; padding: 8px;" colspan='3'>
						<div class="textarea-container">
	                        <div class="editable-container" contenteditable="true" id="description"></div>
                    	</div>
					</th>
				</tr>
			</thead>
		</table>
	</div>
</div>
<div class="text-center" style="margin-top: 20px;">
	<p id="p1">
		<button type="button" class="btn btn-outline-primary col-1" id="modify">등&nbsp;&nbsp;록</button>
		<button type="button" class="btn btn-outline-secondary col-1" id="list" onclick="location.href='/timePost/lostItem?menuId=injlosIte'">목&nbsp;&nbsp;록</button>
	</p>
</div>
<script>
document.getElementById('uploadFile').addEventListener('change', function(event) {
    const file = event.target.files[0];
    if (file && file.type.startsWith('image/')) {
        const reader = new FileReader();
        reader.onload = function(e) {
            const div = document.getElementById('description');
            // 이전 이미지 제거
            const oldImg = div.querySelector('img');
            if (oldImg) {
                div.removeChild(oldImg);
            }
            // 새로운 이미지 추가
            const img = document.createElement('img');
            img.src = e.target.result;
            div.appendChild(img);
        };
        reader.readAsDataURL(file);
    }
});
</script>
</body>
</html>

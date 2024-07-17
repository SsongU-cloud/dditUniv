<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/resources/js/sweetalert2.min.js"></script>
<html>
<head>
<script type="text/javascript">
let locationHref = window.location.href;
$(function () {


    // 학과 선택 시 게시판 ajax
// 	$("#seldept").change(function(){

// 		var comDetCodeName = $("#seldept").val();
// 		console.log("셀렉트 값 : " + comDetCodeName);

		
// 		// 리스트 ajax
// 		getList(comDetCodeName,1);
// 	})
	
		// 모달창 단과대학 선택시 학과 출력
    $('select[id="funsel1"] ').on('change', function()  {
        let arrType = getAgreeType();
        let optionType = $(this).parents('#mysel').find($('select[id="funsel2"]'));
        optionType.empty();
        console.log("현재 선택 값 : ", $(this).val())
        console.log("현재 선택 옵션 값 : ", arrType)

        if($(this).val() == '공과대학'){ 
            for(prop in arrType['공과대학']){
                optionType.append('<option value='+prop+' >'+arrType['공과대학'][prop]+'</option>');
            }
        } else if($(this).val() == '예술대학'){ 
            for(prop in arrType['예술대학']){
                optionType.append('<option value='+prop+' >'+arrType['예술대학'][prop]+'</option>');
            }
        }
        else if($(this).val() == '자연과학대학'){ 
            for(prop in arrType['자연과학대학']){
                optionType.append('<option value='+prop+' >'+arrType['자연과학대학'][prop]+'</option>');
            }
        }
        else if($(this).val() == '사범대학'){ 
            for(prop in arrType['사범대학']){
                optionType.append('<option value='+prop+' >'+arrType['사범대학'][prop]+'</option>');
            }
        }
        else if($(this).val() == '경상대학'){ 
            for(prop in arrType['경상대학']){
                optionType.append('<option value='+prop+' >'+arrType['경상대학'][prop]+'</option>');
            }
        }
        else{                            
            for(prop in arrType['인문사회대학']){
                optionType.append('<option value='+prop+' >'+arrType['인문사회대학'][prop]+'</option>');
            }                  
        }        
    });
	
	// 단과대학 선택시 학과 출력 해용
    $('select[id="selectSearch"] ').on('change', function()  {
        let arrType = getAgreeType();
        let optionType = $(this).parents('#mydiv').find($('select[id="searchCnd"]'));
        optionType.empty();
        console.log("현재 선택 값 : ", $(this).val())
        console.log("현재 선택 옵션 값 : ", arrType)

        if($(this).val() == '공과대학'){ 
            for(prop in arrType['공과대학']){
                optionType.append('<option value='+prop+' >'+arrType['공과대학'][prop]+'</option>');
                $('select[id="searchCnd"] ').on('change', function()  {
                	getList($(this).val(),1); 
                	})
            }
        } else if($(this).val() == '예술대학'){ 
            for(prop in arrType['예술대학']){
                optionType.append('<option value='+prop+' >'+arrType['예술대학'][prop]+'</option>');
                $('select[id="searchCnd"] ').on('change', function()  {
                	getList($(this).val(),1); 
                	})
            }
        }
        else if($(this).val() == '자연과학대학'){ 
            for(prop in arrType['자연과학대학']){
                optionType.append('<option value='+prop+' >'+arrType['자연과학대학'][prop]+'</option>');
                $('select[id="searchCnd"] ').on('change', function()  {
                	getList($(this).val(),1); 
                	})
            }
        }
        else if($(this).val() == '사범대학'){ 
            for(prop in arrType['사범대학']){
                optionType.append('<option value='+prop+' >'+arrType['사범대학'][prop]+'</option>');
                $('select[id="searchCnd"] ').on('change', function()  {
                	getList($(this).val(),1); 
                	})
            }
        }
        else if($(this).val() == '경상대학'){ 
            for(prop in arrType['경상대학']){
                optionType.append('<option value='+prop+' >'+arrType['경상대학'][prop]+'</option>');
                $('select[id="searchCnd"] ').on('change', function()  {
                	getList($(this).val(),1); 
                	})
            }
        }
        else{                            
            for(prop in arrType['인문사회대학']){
                optionType.append('<option value='+prop+' >'+arrType['인문사회대학'][prop]+'</option>');
                $('select[id="searchCnd"] ').on('change', function()  {
                	getList($(this).val(),1); 
                	})
            }                  
        }        
    });
	
    $('#auto').on('click', function(){
    	// 년도
    	$('#funsel3').val("2025");
    	// 학기
    	$('#funsel4').val("1");
    	// 등록금
    	$('#funsel5').val(2800000);
    	// 납부기간 
    	$('#funsel6').val('2025-01-27');
    	$('#funsel7').val('2025-02-07');
    })
});

function getAgreeType() {    
    var obj = {
        "공과대학" : {
        	'학과' : '학과',
            '기계공학과' : '기계공학과',
            '컴퓨터공학과' : '컴퓨터공학과',
            '전자공학과' : '전자공학과',
            '화학공학과' : '화학공학과',
            '건축학과' : '건축학과', 
            '신소재공학과' : '신소재공학과'
        },
        "예술대학" : {
        	'학과' : '학과',
            '음악과' : '음악과',
            '디자인학과' : '디자인학과',
            '무용학과' : '무용학과',
            '회화과' : '회화과'
        },
        "자연과학대학" : {
        	'학과' : '학과',
            '수학과' : '수학과',
            '물리학과' : '물리학과',
            '천문학과' : '천문학과',
            '환경학과' : '환경학과',
            '해양학과' : '해양학과',
            '스포츠과학과' : '스포츠과학과'
        },
        "사범대학" : {
        	'학과' : '학과',
            '국어교육과' : '국어교육과',
            '영어교육과' : '영어교육과',
            '수학교육과' : '수학교육과',
            '체육교육과' : '체육교육과',
            '사회교육과' : '사회교육과',
            '과학교육과' : '과학교육과'
        },
        "경상대학" : {
        	'학과' : '학과',
            '경제학과' : '경제학과',
            '경영학과' : '경영학과',
            '무역학과' : '무역학과',
            '회계학과' : '회계학과'
        },
        "인문사회대학" : {
        	'학과' : '학과',
            '국어국문학과' : '국어국문학과',
            '영어영문학과' : '영어영문학과',
            '한문학과' : '한문학과',
            '불어불문학과' : '불어불문학과',
            '중어중문학과' : '중어중문학과',
            '일어일문학과' : '일어일문학과',
            '국사학과' : '국사학과',
            '철학과' : '철학과'
        }
    }
    
    return obj;
}

//목록
//1) 학과 선택
//2) 페이징  : onclick="getList('기계공학과', 2, )"
function getList(comDetCodeName,currentPage,queGubun) {

	
	// JSON 오브젝트
	let data = {
		"comDetCodeName" : comDetCodeName,
		"currentPage":currentPage,
		"queGubun":queGubun
	};
	
	console.log("data : " , data);
	
	//아작나써유..(피)씨다타써...
	$.ajax({
		url: "/tution/deptlist", //ajax용 url 변경
		contentType:"application/json;charset=utf-8",
		data:JSON.stringify(data),
		type:"post",
		dataType:"json",
		beforeSend:function(xhr){
            xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
        },
		success:function(result){
			console.log("result.content : ", result.content);
			console.log("result 페이징 : " , result.pagingArea)
			let str = "";
			
			if(result.content.length == 0) {
				str += `<tr>`;
				str += `<td colspan="6" style="text-align:center;">해당 과는 고지사항이 없습니다.</td>`;
				str += `</tr>`;
			}
			
			str+= "<div class='card-body table-responsive p-0' style='margin-top: -100px; height:100%'>";
			str+= "<table class='table table-hover text-nowrap' style='height:100%'>";
			str+= "<thead>";
			str+= "<tr class='trBackground textCenter'>";
			str+="<th style='width: 10%;'>번호</th>";
			str+="<th style='width: 15%;'>학과</th>";
			str+="<th style='width: 10%;'>년도</th>";
			str+="<th style='width: 10%;'>학기</th>";
			str+="<th style='width: 20%;'>납부시작일</th>";
			str+="<th style='width: 20%;'>납부종료일</th>";
			str+="<th>실 납입 금액(단위 : 원)</th>";
			str+="</tr>";
			str+="</thead>";
			str+="<tbody id='trShow'>";	
			
			$.each(result.content, function(idx, DeptTuitionPayVO){
// 				str += `<tr name="trHref" onclick="location.href='/commonNotice/detail?menuId=annNotIce&comNotNo=\${CommonNoticeVO.comNotNo}'" style="cursor:pointer">
// 				<td class="textCenter">\${CommonNoticeVO.rn}</td>
// 				<td class="textCenter">\${CommonNoticeVO.comGubun}</td>
// 				<td>\${CommonNoticeVO.comNotName}</td>
// 				<td class="textCenter">\${CommonNoticeVO.userInfoVOList.userName}</td>
// 				<td class="textCenter">\${CommonNoticeVO.comFirstDate}</td>
// 				<td class="textCenter">\${CommonNoticeVO.comNotViews}</td>`;
				str+= "<tr>";
				str+= "<td class='textCenter'>"+DeptTuitionPayVO.rnum+"</td>";
				str+= "<td class='textCenter'>"+DeptTuitionPayVO.comDetCodeName+"</td>";
				str+= "<td class='textCenter'>"+DeptTuitionPayVO.year+"년도</td>";
				str+= "<td class='textCenter'>"+DeptTuitionPayVO.semester+"학기</td>";
				str+= "<td class='textCenter'>"+DeptTuitionPayVO.divPayStDate.substring(0,10)+"</td>";
				str+= "<td class='textCenter'>"+DeptTuitionPayVO.divPayEnDate.substring(0,10)+"</td>";
				str+= "<td class='textCenter' style='text-align: right;'>"+DeptTuitionPayVO.deptTuiPay.toLocaleString('ko-KR')+"원</td>";
				str+= "</tr>";

			});
			
			str+= "</tbody>";
			str+= "</table>";
			str+= "</div>";
//			str+= "</div>";
//			str+= "</div>";
			str+= "<br>";
			
			$("#paging").html(result.pagingArea);

			$("#thislist").html(str);
			
// 			$(".clsPagingArea").html(result.pagingArea);
			
// 			$("#trShow").html(str);
		}
	});
}

function myclick(){
	
	let year = $("#funsel3").val();
	let semester = $("#funsel4").val();
	let comDetCodeName = $("#funsel2").val();
	let tuipay = $("#funsel5").val();
	let divPayStDate = $("#funsel6").val();
	let divPayEnDate = $("#funsel7").val();
	
	let data = {
			"year": year,
			"semester": semester,
			"comDetCodeName": comDetCodeName,
			"deptTuiPay": tuipay,
			"divPayStDate": divPayStDate,
			"divPayEnDate": divPayEnDate
			
	}
	
	console.log("data : " , data);
	
	$.ajax({
		
		url:"/tution/inserttui",
		contentType:"application/json;charset=utf-8",
		data:JSON.stringify(data),
		type:"post",
		dataType:"text",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success:function(result){
			
			Swal.fire({
  				title: '등록금 등록 성공.',         // Alert 제목
  				text: '등록금을 등록하였습니다.',  // Alert 내용
  				icon: 'success',                         // Alert 타입
				}).then(function(){
					window.location.href = "/tution/manConfirmation?menuId=stuTuiPay";
				});
			
			},
			error:function(result2){
				
				Swal.fire({
	  				title: '등록금 등록 실패.',         // Alert 제목
	  				text: '해당 학기 등록금이 이미 존재합니다. 다시 입력해주세요',  // Alert 내용
	  				icon: 'error',                         // Alert 타입
					});
				
			}
		
	})
	
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

.selectSearch{
    width: 130px;
    height: 30px;
    float: left;
    margin: 0px 5px 0px 0px;
    font-size: 0.8rem;
}

#paging {
	margin-top:  20px;
	justify-content: flex-end;
}

.card {
	width: 80%;  /*목록 넓이*/
}

.textCenter {
    text-align:center;
}

input {

 	border: none; 
 	background: transparent; 
	text-align: center;
	border-bottom-style: solid;
	border-bottom-color: #e3e6f0;


}


input:focus{
  border-color:#e3e6f0;
  outline: none; 
}

td {

height: 40px

}

</style>

</head>
<body>
	<h3>등록금 고지</h3>
	<div id="mydiv" class="container-fluid col-12" style="height: 630px; width:80%; background-color: white;">
		<br>
				<select title="검색 조건 선택" id="selectSearch"
					class="selectSearch form-control">
					<option value="1" disabled selected>단과대학</option>
					<option value="공과대학">공과대학</option>
					<option value="예술대학">예술대학</option>
					<option value="자연과학대학">자연과학대학</option>
					<option value="사범대학">사범대학</option>
					<option value="경상대학">경상대학</option>
					<option value="인문사회대학">인문사회대학</option>
				</select> 
				<select title="검색 조건 선택" id="searchCnd" class="selectSearch form-control">
					<option value="1" selected disabled>학과</option>
				</select>
<button type="button" class="btn btn-block btn-outline-primary btncli" id="btnregi" 
	style="width: 100px; height: 35px; margin-bottom: -10px; float: right;" data-toggle="modal" data-target="#tuiinsert">등록</button>
	<br><br>
	<div id="thislist">
	<br><br><br><br><br><br>
	<h1 style="text-align: center;">학과를<br> 
	선택해주세요.</h1></div>
<!-- 	<div id="line1" style="background-color: #e3e6f0; height: 3px"> -->
	<br><br>
	</div><br>
	<div class="row clsPagingArea" id="paging" style="margin-top: -20px; margin-left: 650px; margin: auto;"></div>
	<br>

<!-- 등록금 등록화면 모달창 -->
	<div class="modal fade" id="tuiinsert">
		<div class="modal-dialog">
			<div class="modal-content">
				<div id="myinsert">
					<div class="modal-header">
						<h4 class="modal-title" align="center" style="color: black">등록금 등록</h4>
						<br>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>

					</div>
					<div id="mysel" class="modal-body">
						<table border="1" style="width: 100%; text-align: center">
							<tbody>
							
								<tr>
									<td colspan='4' style="background-color : #ebf1e9; width: 25%;">대학</td>
									<td colspan='4'>대덕인재대학교</td>
								</tr>
							
								<tr>
									<td colspan='4' style="width: 25%; height: 40px; background-color : #ebf1e9">년도</td>
									<td colspan='4' id="myyear">
								<select id="funsel3" class="selectSearch form-control" style="margin-left: 23px; width: 300px">
									<option value="" disabled selected>년도</option>
									<option value="2025">2025</option>
									<option value="2024">2024</option>
									<option value="2023">2023</option>
									<option value="2022">2022</option>
									<option value="2021">2021</option>
									<option value="2020">2020</option>
									<option value="2019">2019</option>
									<option value="2018">2018</option>
									<option value="2017">2017</option>
									<option value="2016">2016</option>
									<option value="2015">2015</option>
									<option value="2014">2014</option>
									<option value="2013">2013</option>
									<option value="2012">2012</option>
									<option value="2011">2011</option>
									<option value="2010">2010</option>
									</select>
									</td></tr>
									<tr><td colspan='4' style="background-color : #ebf1e9; width: 25%;">학기</td>
									<td colspan='4' id="myyear">
								<select id="funsel4" class="selectSearch form-control" style="margin-left: 23px; width: 300px">
									<option>학기</option>
									<option value="1">1학기</option>
									<option value="2">2학기</option>
									</select>
									</td>
								</tr>
								<tr>
									<td colspan="4" style="text-align: center; background-color : #ebf1e9; width: 25%">단과대학</td>
									<td colspan="4" style="text-align: center;">
									<select id="funsel1" class="selectSearch form-control" style="margin-left: 23px; width: 300px">
										<option value="" disabled selected>단과대학</option>
										<option value="공과대학">공과대학</option>
										<option value="예술대학">예술대학</option>
										<option value="자연과학대학">자연과학대학</option>
										<option value="사범대학">사범대학</option>
										<option value="경상대학">경상대학</option>
										<option value="인문사회대학">인문사회대학</option>
									</select></td></tr>
									<tr><td colspan="4" style="background-color : #ebf1e9; width: 25%">학과</td>
									<td colspan="4">
									<select title="학과" id="funsel2" class="selectSearch form-control" style="margin-left: 23px; width: 300px">
										<option>학과</option>	
									</select>
								</td>

								</tr>
								<tr>
									<td colspan="4" style="background-color : #ebf1e9; width: 25%">등록금</td>
									<td colspan="4">
									<input type="text" id="funsel5">
									원</td>

								</tr>
								<tr>
								<td colspan="4" style="background-color : #ebf1e9; width: 25%">납부기간</td>
									<td colspan="4">
									<input type="date" id="funsel6">~
									<input type="date" id="funsel7">
									</td>
								</tr>
							</tbody>
						</table><br>
							<div style="display: inline-block"><h5 style="text-align: center; color: black; display: inline-block;
							margin-left: 150px; margin-top: -51px;">대덕인재대학교 총장</h5>
							</div>
							<div>
								<img id="profileMyImg" src="/upload/admin/대덕인재대직인.jpg" alt="프로필사진" style="display: inline-block; margin-left: 340px; margin-top: -43px">
								<br>
							</div>
					</div>
				</div>
				<div class="modal-footer justify-content-between">
					<button type="button" class="btn btn-outline-light" id="auto">자동 완성</button>
					<button id="mytui" type="button" class="btn btn-block btn-outline-primary btncli"
					data-toggle="modal" data-target="#modal-info" onclick="myclick()" style="display:inline-block;width:90px;">등록</button>
				</div>
			</div>
		</div>
	</div>



</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
   prefix="sec"%>

<!-- <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet"> -->
<!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script> -->
<html>
<head>
<script type="text/javascript">

$(function () {
   
   
   // 모달창 단과대학 선택시 학과 출력에용
    $('select[id="selectSearch"] ').on('change', function() {
        let arrType = getAgreeType();
        let optionType = $(this).parents('.brd-search').find($('select[id="searchCnd"]'));
        optionType.empty();
        console.log("현재 선택 값 : ", $(this).val())
        console.log("현재 선택 옵션 값 : ", arrType)

        if($(this).val() == '공과대학'){ 
            for(prop in arrType['공과대학']){
                optionType.append('<option value='+prop+' >'+arrType['공과대학'][prop]+'</option>');
                $('select[id="searchCnd"] ').on('change', function()  {
                   console.log("현재 선택 옵션 값 ",$(this).val())
//                getList($(this).val())})
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
   

})

function getList(optionType,currentPage,queGubun) {
   
   console.log("arrType 값 : " , optionType);
   
 //목록
 //1) 학과 선택
 //2) 페이징  : onclick="getList('기계공학과', 2, )"

 	
 	// JSON 오브젝트
 	let data = {
 		"comDetCodeName" : optionType,
 		"currentPage":currentPage,
 		"queGubun":queGubun
 	};

 console.log("data : "  , data)
 
   $.ajax({
	
	   url:"/tution/tutionNoticeList",
	   contentType:"application/json;charset=utf-8",
	   data:JSON.stringify(data),
	   type:"post",
	   dataType:"json",
		beforeSend:function(xhr){
            xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
        },
	   success:function(result){
		   
		   console.log("result : " , result)
		   console.log("result 페이징 : " , result.pagingArea)
		   
		   let str = "";
		   
			if(result.content.length == 0) {
				str += `<tr>`;
				str += `<td colspan="6" style="text-align:center;">해당 과는 납부내역이 없습니다.</td>`;
				str += `</tr>`;
			}
		   
			str += "<div class='card-body table-responsive p-0'>"
			str += "<table class='table table-hover text-nowrap' style='color: black'>"
			str += "<thead>"
			str += "<tr class='trBackground textCenter'>"
			str += "<th style='width: 5%;'>번호</th>"
			str += "<th style='width: 15%;'>학과</th>"
			str += "<th style='width: 10%;'>학번</th>"
			str += "<th style='width: 10%;'>이름</th>"
			str += "<th style='width: 10%;'>년도</th>"
			str += "<th style='width: 10%;'>학기</th>"
			str += "<th style='width: 15%;'>등록 고지액(단위 : 원)</th>"
			str += "<th style='width: 15%;'>납부액(단위 : 원)</th>"
			str += "<th style='width: 15%;'>장학금(단위 : 원)</th>"
			str += "<th style='width: 15%;'>잔액(단위 : 원)</th>"
			str += "<th style='width: 12%;'>납부상태</th>"
			str += "</tr>"
			str += "</thead>"
			str += "<tbody id='trShow'>"
		$.each(result.content, function(idx, TuitionListVO){
			str += "<tr name='trHref' >"
			str += "<td class='textCenter'>"+TuitionListVO.rnum+"</td>"
			str += "<td name='mydept' class='textCenter'>" +TuitionListVO.comDetCodeName+"</td>"
			str += "<td class='textCenter'>" +TuitionListVO.tuitionPayVO.stNo+"</td>"
			str += "<td class='textCenter'>" +TuitionListVO.userName+"</td>"
			str += "<td class='textCenter'>" +TuitionListVO.tuitionPayVO.year+"년도</td>"
			str += "<td class='textCenter'>" +TuitionListVO.tuitionPayVO.semester+"학기</td>"
			str += "<td class='textCenter' style='text-align: right;'>" +TuitionListVO.tuitionPayVO.tuiPayAmount.toLocaleString('ko-KR')+"원</td>"
			str += "<td class='textCenter' style='text-align: right;'>" +TuitionListVO.tuitionDivPayVO.divPayAmount.toLocaleString('ko-KR')+"원</td>"
			str += "<td class='textCenter' style='text-align: right;'>" +TuitionListVO.tuitionDivPayVO.scolAmount.toLocaleString('ko-KR')+"원</td>"
			str += "<td class='textCenter' style='text-align: right;'>" +TuitionListVO.tuitionDivPayVO.divChanges.toLocaleString('ko-KR')+"원</td>"
			if(TuitionListVO.tuitionDivPayVO.divPaySq == 0){
// 				if(TuitionListVO.tuitionVO.tuiPayYn = 'N'){
				if(TuitionListVO.tuitionPayVO.tuiPayInstallYn == 'N'){
				str += "<td class='textCenter' style='color: red'>미납</td>"}
				else {
					str += "<td class='textCenter' style='color: blue'>완납</td>"}		
} 
			
			else if(TuitionListVO.tuitionDivPayVO.divPaySq == 1){
				str += "<td class='textCenter' style='color: red'>분할 1차</td>"}
			else if(TuitionListVO.tuitionDivPayVO.divPaySq == 2){
				str += "<td class='textCenter' style='color: red'>분할 2차</td>"}
			else if(TuitionListVO.tuitionDivPayVO.divPaySq == 3){
				str += "<td class='textCenter' style='color: red'>분할 3차</td>"}
				
				
			str += "</tr>"
			
		})

			str += "</tbody>"
			str += "</table>"
			str += "</div>"


			$("#thispage").html(result.pagingArea);

			$("#thislist").html(str);

//			$("#thispage").show()
			//      $(".row clsPagingArea").html(page);
		   
	   }
	   
   })
   
   
   
	

	}

	function getAgreeType() {
		var obj = {
			"공과대학" : {
				'단과대학' : '단과대학',
				'기계공학과' : '기계공학과',
				'컴퓨터공학과' : '컴퓨터공학과',
				'전자공학과' : '전자공학과',
				'화학공학과' : '화학공학과',
				'건축학과' : '건축학과',
				'신소재공학과' : '신소재공학과'
			},
			"예술대학" : {
				'단과대학' : '단과대학',
				'음악과' : '음악과',
				'디자인학과' : '디자인학과',
				'무용학과' : '무용학과',
				'회화과' : '회화과'
			},
			"자연과학대학" : {
				'단과대학' : '단과대학',
				'수학과' : '수학과',
				'물리학과' : '물리학과',
				'천문학과' : '천문학과',
				'환경학과' : '환경학과',
				'해양학과' : '해양학과',
				'스포츠과학과' : '스포츠과학과'
			},
			"사범대학" : {
				'단과대학' : '단과대학',
				'국어교육과' : '국어교육과',
				'영어교육과' : '영어교육과',
				'수학교육과' : '수학교육과',
				'체육교육과' : '체육교육과',
				'사회교육과' : '사회교육과',
				'과학교육과' : '과학교육과'
			},
			"경상대학" : {
				'단과대학' : '단과대학',
				'경제학과' : '경제학과',
				'경영학과' : '경영학과',
				'무역학과' : '무역학과',
				'회계학과' : '회계학과'
			},
			"인문사회대학" : {
				'단과대학' : '단과대학',
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

.selectSearch {
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
   width: 80%; /*목록 넓이*/
}

.textCenter {
   text-align: center;
}

.expBox {
   background-color: white;
   border: 1px solid #ced4da;
   width: 80%;
   margin-left: 160px;
   margin-bottom: 30px;
   padding: 40px 40px 30px 40px;
}
</style>
</head>
<body>

   <p style="display: none;">
      <sec:authentication property="principal" />
   </p>
   <p style="display: none;">
      <sec:authentication property="principal.userInfoVO" />
   </p>
   <p style="display: none;">
      <sec:authentication property="principal.userInfoVO.userName" />
   </p>
   <p style="display: none;">
      <sec:authentication property="principal.username" var="merong" />
   </p>
   <p style="display: none;">
      <sec:authentication property="principal.userInfoVO.authorityVOList"
         var="myAuths" />
   </p>
   <h3>납부 내역 조회</h3>
   <div class="card" style="margin: auto; height: 630px;">
      <div class="card-header" style="background-color: #fff;">
         <!--    <form> -->
         <div class="brd-search">
            <select title="검색 조건 선택" id="selectSearch"
               class="selectSearch form-control" style="margin-top: -15px;">
               <option value="1" selected="selected">단과대학</option>
               <option value="공과대학">공과대학</option>
               <option value="예술대학">예술대학</option>
               <option value="자연과학대학">자연과학대학</option>
               <option value="사범대학">사범대학</option>
               <option value="경상대학">경상대학</option>
               <option value="인문사회대학">인문사회대학</option>
            </select> <select title="검색 조건 선택" id="searchCnd" style="margin-top: -15px;"
               class="selectSearch form-control">
               <option value="1" selected="selected">학과</option>
            </select>

            <p>
               <input type="hidden" name="authority"
                  value="${myAuths[0].authority}">
            </p>
         </div>
         <!--    </form> -->
      </div>

      <div id="thislist">
         <br>
         <br>
         <br>
         <br>
         <br>
         <br>
         <br>
         <br>
         <h1 style="text-align: center; color:black">
            학과를<br> 선택해주세요.
         </h1>
      </div>

   
   </div>
   <div id="thispage" class="row clsPagingArea">
<!--   <div class='col-sm-12 col-md-7'> -->
<!--         <div class='dataTables_paginate paging_simple_numbers' id='example2_paginate'> -->
<!--             <ul class='pagination'> -->
<!--                 Previous Button -->
<!--                 <li class='paginate_button page-item previous disabled' id='example2_previous'> -->
<!--                     <a href='#' onclick="getList('keyword', startPage - 5, queGubun)" aria-controls='example2' data-dt-idx='0' tabindex='0' class='page-link'>&lt;&lt;</a> -->
<!--                 </li> -->
                
<!--                 Page Numbers -->
<!--                 <li class='paginate_button page-item active'> -->
<!--                     <a href='#' onclick="getList('keyword', 1, queGubun)" aria-controls='example2' data-dt-idx='1' tabindex='0' class='page-link'>1</a> -->
<!--                 </li> -->
<!--                 <li class='paginate_button page-item'> -->
<!--                     <a href='#' onclick="getList('keyword', 2, queGubun)" aria-controls='example2' data-dt-idx='2' tabindex='0' class='page-link'>2</a> -->
<!--                 </li> -->
<!--                 <li class='paginate_button page-item'> -->
<!--                     <a href='#' onclick="getList('keyword', 3, queGubun)" aria-controls='example2' data-dt-idx='3' tabindex='0' class='page-link'>3</a> -->
<!--                 </li> -->
<!--                 <li class='paginate_button page-item'> -->
<!--                     <a href='#' onclick="getList('keyword', 4, queGubun)" aria-controls='example2' data-dt-idx='4' tabindex='0' class='page-link'>4</a> -->
<!--                 </li> -->
<!--                 <li class='paginate_button page-item'> -->
<!--                     <a href='#' onclick="getList('keyword', 5, queGubun)" aria-controls='example2' data-dt-idx='5' tabindex='0' class='page-link'>5</a> -->
<!--                 </li> -->
<!--                 Next Button -->
<!--                 <li class='paginate_button page-item next' id='example2_next'> -->
<!--                     <a href='#' onclick="getList('keyword', startPage + 5, queGubun)" aria-controls='example2' data-dt-idx='7' tabindex='0' class='page-link'>&gt;&gt;</a> -->
<!--                 </li> -->
<!--             </ul> -->
<!--         </div> -->
<!--     </div> -->
   </div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet"> -->
<link rel="stylesheet" href="/resources/css/sweetalert2.min.css" />
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-neo.css" rel="stylesheet">
<!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script> -->
<script type="text/javascript" src="/resources/js/sweetalert2.min.js"></script>
<style>
* {
	font-family: 'NanumSquareNeo'; 
}
h3 {
   color: black;
   margin-bottom: 30px;
   margin-top: 40px;
   margin-left: 135px;
} 
.card-body {
    display: flex;
    align-items: baseline;
}
.first {
  padding-left: 30px;
  padding-top: 30px;
  padding-bottom: 10px;
  margin-left: 70px;
}
.second {
  padding-top: 10px;
  padding-left: 30px;
  padding-bottom: 30px;
  margin-left: 70px;
}
.trBackground, th {
  background-color: #ebf1e9;
  color: black;
}
.tableModel>td {
  text-align:left;
}
.table-disp {
  margin: auto;
  padding: 0;
  text-align: center;
}
.w130px{
	width: 130px;
	text-align:center;	
}
.w150px{
	width: 150px;
	text-align:center;	
}
</style>
<script type="text/javascript">
$(function(){
	$('#univ').on('change', function(){
	      let univ = $('#univ');
	      console.log(univ.val());
	      
	      let data = {
	         "univ": univ.val()
	      };
	      
	      $.ajax({
	         url: "/manager/deptAjax",
	         contentType: "application/json;charset='utf-8'",
	         data: JSON.stringify(data),
	         type: "post",
	         dataType: "json",
	         beforeSend: function(xhr){
	            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	         },
	         success: function(result){
// 	            console.log(result);
	            
	            let str = "";
	            
	            str += `<option selected disabled>학과</option>`;
	            $.each(result, function(idx, deptList){
	            	console.log(deptList.comDetCodeName)
	               str += `<option value="\${deptList.comDetCode}">\${deptList.comDetCodeName}</option>`;
	            });
	            $('#dept').html(str);
	         }
	      });
	   });
	
	let dept = $('select[name="dept"]');
    let year = $('select[name="year"]');
	let div= $('select[name="div"]');
	let grade= $('select[name="grade"]');
	let semester= $('select[name="semester"]');
	let lecName = $('#lecName');
    
    $('#search').on('click', function(){
//         console.log('검색 ㄱㄱ')
        
		let deptTemp = dept.val() != null ? dept.val() : "";
		let yearTemp = year.val() != null ? year.val() : "";
		let divTemp = div.val() != null ? div.val() : "";
		let gradeTemp = grade.val() != null ? grade.val() : "";
		let semesterTemp = semester.val() != null ? semester.val() : "";
		let lecNameTemp = lecName.val() != null ? lecName.val() : "";
		
		if(deptTemp === '' && yearTemp === '' && divTemp === '' && gradeTemp === '' && semesterTemp === '' && lecNameTemp === ''){
            // 경고 메시지 표시
            Swal.fire({
                icon: "error",
                html: "1개 이상의 검색 키워드를 선택해주세요 <br><br> (단과대학과 학과는 합쳐서 1개 취급합니다.)",
                });
            return;
        }
		
		let data = {
			'dept':deptTemp,
			'year':yearTemp,
			'div':divTemp,
			'grade':gradeTemp,
			'semester':semesterTemp,
			'lecName':lecNameTemp
		}
		
		console.log(data);

        $.ajax({
            url:"/lecture/searchHandbook",
            contentType:"application/json;charset=utf-8",
            data:JSON.stringify(data),
            type:"post",
            dataType:"json",
            beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
            success:function(result){
                let str = '';

                if(result.length == 0){
                    str += `<tr>
                                <td colspan="12" style="border-bottom: none; font-size: 30px;">조회 결과가 존재하지 않습니다. </td>
                            </tr>`;
                }
                
                $.each(result, function(idx, searchHandbookVO){
                	console.log(searchHandbookVO)
	                str += `
	                	<tr style="cursor:pointer" class="lecList" data-toggle="modal" data-target="#lecPlanModal"
	                		data-lecno="\${searchHandbookVO.lecNo}">
	                    <td>\${idx+1}</td>
	                    <td>\${searchHandbookVO.lecDiv}</td>
	                    <td>\${searchHandbookVO.lecType}</td>`;
	                	if(searchHandbookVO.lecGrade == 0){
							str += `<td>전학년</td>`;
						} else {
							str += `<td>\${searchHandbookVO.lecGrade}학년</td>`;
						}
	                str += `<td>\${searchHandbookVO.lecSemester}학기</td>
	                    <td>\${searchHandbookVO.lecScore}학점</td>
	                    <td class="text-left">\${searchHandbookVO.comDetCodeVO.comDetCodeName}</td>
	                    <td>\${searchHandbookVO.userInfoVO.userName}</td>
	                    <td>\${searchHandbookVO.lecPer}명</td>
	                    <td class="text-left">\${searchHandbookVO.lecName}</td>
	                    <td class="text-left">\${searchHandbookVO.lecDay}</td>
	                    <td>\${searchHandbookVO.lectureRoomVO.lecRoName}</td>
	                	</tr>
	                `;
                })
                $('#search-trShow').html(str);
                
            	$(".lecList").on("click",function(){
            		let lecNo = $(this).data('lecno');
            		
            		let data = {
            			lecNo
            		}
            		
            		console.log("조회할 강의 번호",lecNo)
            		
            		if(lecNo != null && lecNo != ''){
	            		$.ajax({
	            			url:"/lecture/detailHandbook",
	            			contentType:"application/json;charset=utf-8",
	            			data:JSON.stringify(data),
	            			type:"post",
	            			dataType:"json",
	            			beforeSend:function(xhr){
	            				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
	            			},
	            			success:function(result){
	            				console.log(result)
	            				
	            				let lecNameDetail = result.lecName;
	            				let lecGradeDetail = '';
	            				if(result.lecGrade == 0){
		            				lecGradeDetail = '전학년';
	            				}
	            				else{
		            				lecGradeDetail = result.lecGrade + '학년';
	            				}
	            				let lecScoreDetail = result.lecScore + '학점';
	            				let collegeDetail = result.comCodeVO.comCodeName;
	            				let deptDetail = result.comDetCodeVO.comDetCodeName;
	            				let lecRoNameDetail = result.lectureRoomVO.lecRoName;
	            				let lecDivDetail = result.lecDiv;
	            				let lecTypeDetail = result.lecType;
	            				let lecPerDetail = result.lecPer + '명';
	            				let lecDaysDetail = result.lecDay;
	            				
	            				$('#lecNameDeatil').text(lecNameDetail);
	            				$('#lecGrade').text(lecGradeDetail);
	            				$('#lecScore').text(lecScoreDetail);
	            				$('#college').text(collegeDetail);
	            				$('#deptDetail').text(deptDetail);
	            				$('#lecRoName').text(lecRoNameDetail);
	            				$('#lecDiv').text(lecDivDetail);
	            				$('#lecType').text(lecTypeDetail);
	            				$('#lecPer').text(lecPerDetail);
	            				$('#lecDays').text(lecDaysDetail);
	            				
	            				$.ajax({
	    	            			url:"/lecture/lectureDetail",
	    	            			contentType:"application/json;charset=utf-8",
	    	            			data:JSON.stringify(data),
	    	            			type:"post",
	    	            			dataType:"json",
	    	            			beforeSend:function(xhr){
	    	            				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
	    	            			},
	    	            			success:function(detailList){
	    	            				console.log("detailList >>> ", detailList)
	    	            				let str = "";
	    	            				
	    	            				if(detailList.length == 0){
	    	            					str += `
	    	            						<tr>
		    	        							<th colspan="6" class="text-center">
		    	        								<span>회차가 존재하지 않습니다.</span>
		    	        							</th>
		    	        						</tr>
	    	            					`;
	    	            				}
	    	            				
	    	            				$.each(detailList, function(idx, detailVO){
	    	            					str +=`
	    	            						<tr>
		    	        							<th colspan="6" class="text-center">
		    	    									<span>\${detailVO.lecNum}회차</span>
			    	    							</th>
			    	    						</tr>
			    	    						<tr>
			    	    							<td colspan="6">\${detailVO.lecCon}</td>
			    	    						</tr>
	    	    							`;
	    	            				})
	    	            				$('#lecDetail').html(str);
	    	            			}
	    	            		}); // ajax 끝
	            			}
	            		});// ajax 끝
            		};
            		
            	});// ajax 끝
            }
        });// ajax 끝
    
    });

    $('#reset').on('click', function(){
        console.log('검색 키워드 초기화')
        
        document.querySelector('#univ').selectedIndex = 0;
        document.querySelector('#dept').selectedIndex = 0;
        document.querySelector('#year').selectedIndex = 0;
        document.querySelector('#div').selectedIndex = 0;
        document.querySelector('#grade').selectedIndex = 0;
        document.querySelector('#semester').selectedIndex = 0;
        lecName.val('');
        
        let str = '';
        str += `
        	<tr>
	            <td colspan="12" style="border-bottom: none; font-size: 30px;">키워드를 선택해주세요 </td>
	        </tr>
        `;
        $('#search-trShow').html(str);
        
    })

})


</script>
 <!-- 모달 시작 -->
	<div class="modal fade" id="lecPlanModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable" style="max-width: 1000px;">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">강의 계획서</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body flex">
			<div id="tableWrap" style="margin:20px;">
				<table class="table table-bordered tableModel">
					<tbody>
					<tr>
						<th class="w150px">강의명</th>
						<td id="lecNameDeatil"style="width: 250px;"></td>
						<th class="w130px">수강 학년</th>
						<td id="lecGrade"></td>
						<th class="w130px">학점</th>
						<td id="lecScore"></td>
					</tr>
					<tr>
						<th class="w150px">단과대학</th>
						<td id="college"></td>
						<th class="w130px">학과</th>
						<td id="deptDetail"></td>
						<th class="w130px">강의실</th>
						<td id="lecRoName"></td>
					</tr>
					<tr>
						<th class="w150px">이수구분</th>
						<td id="lecDiv"></td>
						<th class="w130px">강의영역</th>
						<td id="lecType"></td>
						<th class="w130px">수강최대인원</th>
						<td id="lecPer"></td>
					</tr>
					<tr>
						<th class="w150px">강의 요일 / 시간</th>
						<td id="lecDays" colspan="5"></td>
					</tr>
					</tbody></table>
					<br>
					<hr>
					<br>
					<table class="table table-bordered tableModel">
					<tbody id="lecDetail">
						<tr>
							<th colspan="6" class="text-center">
								<span>1회차</span>
							</th>
						</tr>
						<tr>
							<td colspan="6">오리엔테이션</td>
						</tr>
					</tbody>
				</table>
			</div>
	      </div>
	      <div class="modal-footer">
	      </div>
	    </div>
	  </div>
	</div>
	<!-- 모달 끝 -->
<h3>수강 편람</h3>
<div class="col-10" style="margin: auto; padding:0px;">
    <div class="card">
        <form action="" id="form">
            <div class="card-body first">
                <label for="univ">단과대학 :&nbsp;</label>
                <select class="form-control col-2" name="univ" id="univ" style="margin-right: 30px;">
                    <option disabled selected class="basic" value="">단과 대학</option>
                    <c:forEach var="univ" items="${univList}" varStatus="stat">
                        <option value="${univ.comCode}">${univ.comCodeName}</option>
                    </c:forEach>
                </select>
                <label for="dept">학과 :&nbsp;</label>
                <select class="form-control col-2" name="dept" id="dept" style="margin-right: 30px;">
                    <option disabled selected class="basic">학과</option>
                </select>
                <label for="year">년도 :&nbsp;</label>
                <select class="form-control col-2" name="year" id="year" style="margin-right: 30px;">
                    <option disabled selected class="basic" value="">년도</option>
                    <option value="2024">2024</option>
                    <option value="2023">2023</option>
                    <option value="2022">2022</option>
                    <option value="2021">2021</option>
                    <option value="2020">2020</option>
                </select>
                <label for="div">이수 구분 :&nbsp;</label>
                <select class="form-control col-2" name="div" id="div" style="margin-right: 30px;">
                    <option disabled selected class="basic" value="">구분</option>
                    <option value="1">전필</option>
                    <option value="2">전선</option>
                    <option value="3">교필</option>
                    <option value="4">교선</option>
                </select>
            </div>
            <div class="card-body second">
                <label for="grade">학년 :&nbsp;</label>
                <select class="form-control col-1" name="grade" id="grade" style="margin-right: 30px;">
                    <option disabled selected class="basic" value="">학년</option>
                    <option value="5">전학년</option>
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
                </select>
                <label for="semester">학기 :&nbsp;</label>
                <select class="form-control col-1" name="semester" id="semester" style="margin-right: 30px;">
                    <option disabled selected class="basic" value="">학기</option>
                    <option value="1">1</option>
                    <option value="2">2</option>
                </select>
                <label for="lecName">강의명 :&nbsp;</label>
                <input class="basic form-control col-3" id="lecName" value="">
                <input class="btn btn-outline-primary" id="search" value="조 회" 
                	style="margin-left: 105px; width: 150px;">
                <input class="btn btn-outline-secondary" id="reset" value="초기화" style="margin-left: 30px; width: 150px;">
            </div>
        </form>
    </div>
</div>
<br>	
<div class="card col-10 table-disp" style="margin: auto;">
    <div class="card-body table-responsive p-0 search-table">
        <table class="table table-hover text-nowrap lectureList text-center">
        	<colgroup>
        		<col style="width:5%"/>
        		<col style="width:6%"/>
        		<col style="width:6%"/>
        		<col style="width:7%"/>
        		<col style="width:7%"/>
        		<col style="width:7%"/>
        		<col style="width:9%"/>
        		<col style="width:7%"/>
        		<col style="width:7%"/>
        		<col style=""/>
        		<col style="width:10%"/>
        		<col style="width:7%"/>
        	</colgroup>
            <thead>
                <tr class="trBackground text-center">
                    <th>번호</th>
                    <th>이수구분</th>
                    <th>강의영역</th>
                    <th>학년</th>
                    <th>학기</th>
                    <th>학점</th>
                    <th>개설학과</th>
                    <th>교수</th>
                    <th>최대인원</th>
                    <th>강의명</th>
                    <th>강의시간</th>
                    <th>강의실</th>
                </tr>
            </thead>
            <tbody id="search-trShow" class="text-center scroll">
                <!-- 강의 리스트 출력 영역 -->
                <tr>
                    <td colspan="12" style="border-bottom: none; font-size: 30px;">키워드를 선택해주세요 </td>
                </tr>
            </tbody>
        </table>
    </div>  
</div>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        h3 {
            color: black;
            margin-bottom: 30px;
            margin-top: 40px;
            margin-left: 165px;
        }
        .textCenter {
            text-align:center;
        }
        .selectSearch{
            width: 60px;
            height: 30px;
            float: left;
            margin: 0px 5px 0px 0px;
            font-size: 0.7rem;
        }
        #btnSearch {
            border: 1px solid #D1D3E2;
            background-color: #F8F9FA;
        }
        .divSearch {
            width: 280px;
            float: left;
        }
        .wkrtjdBut {
            width: 130px;
            /* float: right; */
            margin: auto;
        }
        #styled_box{
            /* border: 5px groove pink; */
            /* width: 300px;*/
            height: 442px; 
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            /*padding: 10px; */
            /* border: 1px solid #ccc; */
            border-radius: 5px;
            background-color: #f9f9f9;
            margin-bottom: 20px;
        }
        .header h5 {
            margin: 0;
            font-size: 1.2em;
        }
        #allSelAttendance {
            display: flex;
            align-items: center;
        }
        #allSelAttendance label {
            margin-left: 5px;
            font-size: 1em;
        }
        .trBackground{
            cursor: pointer;
        }
    </style>
    <script>
        let dateString ; //현재 날짜
        let attStudList; //출석목록 disp
        let data;//fAttStudList 데이터
        let nowData; // nowAttendStudList json 데이터
        let lecNo ;
        let lecName;
        let lecRoNo;
        let attComCode;
        let attComCodeLen ;
        //강의 클릭시
        function lectInfo(pThis){
            $("#cbAllSelAttendance").prop("checked",false);
            // console.log(pThis);
            dateString
            console.log("dateString",dateString);
            // dateString ="24/06/05";//테스트용!!
             lecNo = pThis.cells[1].innerText;
            let lecSemester = pThis.cells[2].innerText;
            let lecYear = pThis.cells[3].innerText;
             lecName = pThis.cells[4].innerText;
             lecRoNo = pThis.cells[5].innerText;
            attComCode =`${comCodeVOList}`;//버그 (``)사용하면 json 형태 안나옴
            jsonAttComCode=JSON.parse(attComCode)
            // console.log("attComCodet",jsonAttComCode);
            
            nowData = {
                lecNo,
                lecSemester,
                lecYear,
                lecName,
                lecRoNo,
                dateString,
                keyword:''
            }
            console.log("nowData>>>",nowData);
            data = {
                lecNo,
                lecSemester,
                lecYear,
                lecName,
                lecRoNo,
                keyword:''
            }
            // console.log(nowData);
            console.log("data",data);
            //강의클릭 > 당일 출석 나옴
            fNowAttendStudList(nowData);
        }//lecInfo end

            function fBtnSave(pThis){
                let lecNum= $('#nowStudentList thead th').eq(5).text().replace('회차','')
                let lecNo2 =$("input[name='lecNo']").val();
                // dateString ="24/06/05";//테스트용!
                dateString;//테스트용!
                let lecDate = dateString;
                console.log("dateString>>",dateString);
                
                let attstudentcomcodeData = [];
                // console.log( $('#nowStudentList'));
                $('#nowStudentList tbody tr').each(function(){
                    let row = $(this);
                    let attCode = row.find('select[name="attCode"]').val();

                    if(attCode=='AD00101'){
                        attCode = 'AD00104';
                        row.find('select[name="attCode"]').val(attCode);
                    }
                    
                    
                    let student = {
                        stNo: row.find('td').eq(1).text(),
                        lecNum,
                        lecDate,
                        lecNo2,
                        attCode
                    };
                    attstudentcomcodeData.push(student);
                });
                console.log("attstudentcomcodeData",attstudentcomcodeData)

                $.ajax({
                    url:"/profLecture/attendanceInsert",
                    contentType: "application/json;charset=utf-8",
                    data: JSON.stringify(attstudentcomcodeData),
                    type:"post",
                    dataType:"text",
                    beforeSend:function(xhr){
					xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
				    },
                    success:function(result){
                        console.log("result",result);
                        if(result>0){
                            Swal.fire({
                                position: "center",
                                icon: "success",
                                title: "저장완료 되었습니다.",
                                showConfirmButton: false,
                                timer: 1500
                                });
                            $('#nowStudentList tbody tr').each(function(){
                                let row = $(this);
                                let attCode = row.find('select[name="attCode"]').val();

                                if(attCode=='AD00101'){
                                    attCode = 'AD00104';
                                    row.find('select[name="attCode"]').val('AD00104');
                                }

                                row.find('select[name="attCode"]').attr('disabled','true');
                            });
                            $("#btnSave").prop("disabled", true);
                            $("#cbAllSelAttendance").prop('disabled',true);
                            $("#attStudListDisp").html(attStudList);
                            $("#allSelAttendance").html('');
                            $("#nowStudentSaveBtnDisp").html('');
                            // $("#attStudListDisp").html(attStudList);
                            // console.log("attStudList>>",attStudList);

                            fAttStudList(data);
                        }
                    },
                    error: function (xhr, status, error) {
                        console.log("code: " + xhr.status)
                        console.log("message: " + xhr.responseText)
                        console.log("error: " + error);
                    }
                })
            } 
            $(function() {
                DateTime();
                setInterval(DateTime, 1000);  // 1초마다 DateTime 함수 호출
                $(document).on('click',"#btnSearch",function(){
                    console.log("ck");
                    let keyword = $("input[name='table_search']");
                    // console.log("table_search: " + keyword.val());
                    getList(keyword.val(), nowData);
                
                });
                $(document).on('click',"#btnSearchAttList",function(){
                    let keyword = $("input[name='table_search_attList']");
                    // console.log("table_search: " + keyword.val());
                    // getList(keyword.val(), nowData);
                    getAttList(keyword.val())
                });
                /**
                 * 전체출석 선택 누를시
                 */
                $(document).on('click','#btnCbAllSelAttendance',function(e){
                    // console.log("전체출석 체크>>",e);
                    let isChecked = $(e).is(":checked");
                    console.log(isChecked);
                    if(!isChecked){
                        // console.log($("select[name='attCode']"));
                        $("select[name='attCode']").val("AD00102");
                    }
                })
            });
            function getAttList(keyword){
                data.keyword=keyword;
                // console.log("keyword",keyword);
                // console.log("nowData",nowData);
                fAttStudList(data)
                // console.log("data>>>>",data);
            }
            function getList(keyword,nowData){
                nowData.keyword = keyword;
                console.log("keyword",keyword);
                console.log("nowData",nowData);
                fNowAttendStudList(nowData);
            }
            function DateTime() {
                let today = new Date();
                let year = today.getFullYear(); // 월은 0부터 시작하므로 1을 더함
                let month = String(today.getMonth() + 1).padStart(2, '0'); // 월은 0부터 시작하므로 1을 더함
                let day = String(today.getDate()).padStart(2, '0'); // 일자를 반환

                let hours = String(today.getHours()).padStart(2, '0');
                let minutes = String(today.getMinutes()).padStart(2, '0');
                let seconds = String(today.getSeconds()).padStart(2, '0');

                dateString = year+"/"+month + "/" + day;
                let timeString = hours + ":" + minutes + ":" + seconds;

                // console.log("dateString: " + dateString + " timeString: " + timeString);

                document.querySelector("#nowDate").innerHTML = dateString;
                document.querySelector("#nowClock").innerHTML = timeString;
            }

/**
 * 당일출석목록 AJAX
 */
function fNowAttendStudList(nowData){
    console.log("nowData>",nowData)
    $.ajax({
        url:"/profLecture/nowAttendStudList",
        contentType:"application/json;charset=utf-8",
        data:JSON.stringify(nowData),
        type:"post",
        dataType:"json",
        beforeSend:function(xhr){
        xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
        },
        success:function(result){
            console.log("nowAttendStudList_result",result);
            let nowLecInfo="";//강의정보 출력
            let nowStudentListDisp ="";//당일출석 목록 출력
            let brd_search="";//검색창 출력
            /**
             * 당일출석이 아닐 경우
             */
            console.log("attendanceVOList_result",result.attendanceVOList[0]);
            if(typeof result.stuLectureVOList[0]  == 'undefined'){
                brd_search+=`
                    <div class="input-group input-group-sm divSearch">
                        <input type="text" name="table_search" class="form-control float-left" placeholder="이름을 입력하세요">
                        <div class="input-group-append">
                            <button type="button" class="btn btn-default" id="btnSearch">
                                <i class="fas fa-search"></i>
                            </button>
                        </div>
                    </div>                        
                `;
                nowStudentListDisp +=`
                    <input type="hidden" name="lecNo" value="\${lecNo}">
                    <thead style="background-color:#ebf1e9;max-height: 290px;overflow-y: auto;position: sticky;top:0px;">
                        <tr>
                            <th class="textCenter" style="width: 50px;">번호</th>
                            <th class="textCenter" style="width: 80px;">학번</th>
                            <th class="textCenter" style="width: 80px;">이름</th>
                            <th class="textCenter" style="width: 50px;">학년</th>                            
                            <th class="textCenter" style="width: 100px;">학과</th>
                        </tr>
                    </thead>
                    <tbody id="" class="text-center scroll search-trShow">
                        <!-- 출결 체크 출력 영역 -->
                        <tr>
                            <td colspan="6" style="text-align:center;">당일출석 학생이 없습니다.</td>
                        </tr>
                    </tbody>
                    `;
                    $("#brd_searchDisp").html(brd_search); //검색어 화면 출력

                    $("#nowStudentList").html(nowStudentListDisp);
                    $("#allSelAttendance").html('');
                    $("#nowStudentSaveBtnDisp").html('');

                    fAttStudList(data);

                    // $("#styled_box").css("height", "275px");
                    // $("#attStudListDisp").css("margin-top", "600px");
                    return false;
            }
            let nowLecNum =result.stuLectureVOList[0].attendanceVO.lecNum;
                nowLecNum += "회차";
            console.log("nowLecNum",nowLecNum);
            /**
             *  당일 출석이 아닐 경우
             */
            if(nowLecNum == '0회차'){
                nowLecInfo = `
                    <h5>
                        강의번호 : <span id="nowLecNo"></span>
                        , 강의명 : <span id="nowLecNo">\${lecName}</span>
                        , 강의실번호 : <span id="nowLecRoNo">\${lecRoNo}</span>
                    </h5>
                `;
                nowStudentListDisp +=`
                    <input type="hidden" name="lecNo" value="\${lecNo}">
                    <thead style="background-color:#ebf1e9; overflow-y: auto;position: sticky;top:0px;">
                        <tr>
                            <th class="textCenter" style="width: 50px;">번호</th>
                            <th class="textCenter" style="width: 80px;">학번</th>
                            <th class="textCenter" style="width: 80px;">이름</th>
                            <th class="textCenter" style="width: 50px;">학년</th>                            
                            <th class="textCenter" style="width: 100px;">학과</th>
                        </tr>
                    </thead>
                    <tbody id="" class="text-center scroll search-trShow">
                        <!-- 출결 체크 출력 영역 -->
                        <tr>
                            <td colspan="6" style="text-align:center;">당일출석 학생이 없습니다.</td>
                        </tr>
                    </tbody>
                `;

                $("#nowLecInfoDisp").html(''); //당일출석 정보출력

                $("#nowStudentList").html(nowStudentListDisp);
                
                $("#allSelAttendance").html('');

                $("#nowStudentSaveBtnDisp").html('');
                
                fAttStudList(data);
                console.log("설마 여기 오나?")
                $("#attStudListDisp").css("margin-top", "-150px");

                return false;
            }
            
            nowLecInfo = `
            <h5>
                강의번호 : <span id="nowLecNo">\${lecNo}</span>
                , 강의명 : <span id="nowLecNo">\${lecName}</span>
                , 강의실번호 : <span id="nowLecRoNo">\${lecRoNo}</span>
            </h5>
            `;
            ////////////////
            brd_search+=`
                <div class="input-group input-group-sm divSearch">
                    <input type="text" name="table_search" class="form-control float-left" placeholder="이름을 입력하세요">
                    <div class="input-group-append">
                        <button type="button" class="btn btn-default" id="btnSearch">
                            <i class="fas fa-search"></i>
                        </button>
                    </div>
                </div>                        
            `;
            //////
            let allselBtnDisp =`
                <button name="cbAllSelAttendance" id="btnCbAllSelAttendance" class="btn btn-block btn-outline-success btn-xs">전체출석 체크</button>
            `;
            ///////////////
            nowStudentListDisp +=`
                <input type="hidden" name="lecNo" value="\${lecNo}">
                <thead style="background-color:#ebf1e9; overflow-y: auto;position: sticky;top:0px;">
                    <tr>
                        <th class="textCenter" style="width: 50px;">번호</th>
                        <th class="textCenter" style="width: 80px;">학번</th>
                        <th class="textCenter" style="width: 80px;">이름</th>
                        <th class="textCenter" style="width: 50px;">학년</th>                            
                        <th class="textCenter" style="width: 100px;">학과</th>
                        <th class="textCenter" style="width: 50px;">\${nowLecNum}</th>                            
                    </tr>
                </thead>
                <tbody class="text-center scroll search-trShow">
                    <!-- 출결 체크 출력 영역 -->
            `;
            $.each(result.stuLectureVOList,function(idx,stuLectureVO){
                // console.log("-------------------------------------")
                // console.log(">>stuLectureVO", stuLectureVO);
                // console.log("-------------------------------------")
                let attCode = stuLectureVO.comDetCodeVO.comDetCode;
                let attCodeName= stuLectureVO.attComCodeName;
                nowStudentListDisp+=`
                    <tr>
                        <td>\${idx+1}</td>
                        <td>\${stuLectureVO.stNo}</td>
                        <td class="userName">\${stuLectureVO.userInfoVO.userName}</td>
                        <td>\${stuLectureVO.studentVO.stGrade}학년</td>
                        <td id>\${stuLectureVO.comDetCodeVO.comDetCodeName}</td>
                        <td>
                `;
                        
                nowStudentListDisp+=`
                    <select id="attCode" name="attCode" class="form-control AttendComCodeSelect" style="width: 100px;margin: auto;">
                `;
                // attComCode =`${comCodeVOList}`;//버그 (``)사용하면 json 형태 안나옴
                // jsonAttComCode=JSON.parse(attComCode);
                // alert("jsonAttComCode>",jsonAttComCode);
                $.each(jsonAttComCode,function(idx,comDetCodeVO){
                    let attComDetCode =comDetCodeVO.comDetCode;
                    let attComCodeName =comDetCodeVO.comDetCodeName;
                    //console.log("attComCodeName>",attComCodeName);
                    // if(attComCodeName == "미출석"){
                    //     nowStudentListDisp += `
                    //         <option name="cbAllSelAttendance" value="\${attComDetCode}">-</option>
                    //     `;
                    // }
                    nowStudentListDisp += `
                        <option name="cbAllSelAttendance" value="\${attComDetCode}">\${attComCodeName}</option>
                    `;
                })
                // alert("jsonAttComCode",jsonAttComCode);

                $("#cbAllSelAttendance").attr('disabled',false);
                $("#btnSave").attr('disabled','false');

                nowStudentListDisp+=`
                        </select>
                    </td>
                </tr>
                `;

            })//each end
            nowStudentListDisp+=`
            </tbody>
            `;
            //저장버튼
            nowStudentSaveBtn=`
                <br>
                    <button type="button" id="btnSave" class="btn btn-block btn-outline-primary wkrtjdBut" onclick="fBtnSave(this)">저장</button>
                <br>
            `;

            // console.log("nowStudentListDisp>",nowStudentListDisp)

            $("#nowLecInfoDisp").html(nowLecInfo); //당일출석 정보출력

            $("#brd_searchDisp").html(brd_search); //검색어 화면 출력

            $("#nowLecNumDisp").html(nowLecNum);

            $("#nowStudentList").html(nowStudentListDisp);

            // $("#attStudListDisp").empty();

            console.log("ck");

            fAttStudList(data);

            $("#attStudListDisp").css("margin-top", "220px");

            /**
             * 출석 저장 후
             * 선택박스 disable
             * 전체출석 체크 버튼, 저장버튼 없애기
             */
            $("#nowStudentList tbody tr").each(function() {
                // console.log("result.attendanceVOList>>",result.attendanceVOList);
                // console.log("result.attendanceVOList attCode>>",result.attendanceVOList[0].attCode);
                let row = $(this);
                let nowStNo = row.find("td").eq(1).text().trim();
                let attCode = row.find("select[name='attCode']")[0];  // 각 행의 select 요소를 찾음
                // console.log("attCode>>",attCode)
                // console.log("attcodeval>>",attCode.value);
                $.each(result.attendanceVOList, function(idx, attendanceVO) {
                    let attendanceCompleted = attendanceVO.stNo;
                    let attendanceAttCodeName = attendanceVO.attCodeName;
                    console.log("출석후 > ", attendanceVO.attCodeName);
                    if (nowStNo == attendanceCompleted) {
                        attCode.value=attendanceVO.attCode;
                        $("#allSelAttendance").html('');
                        $("#nowStudentSaveBtnDisp").html('');
                        attCode.disabled = true;
                    }
                });
            });

            if(result.attendanceVOList.length == 0){
                $("#allSelAttendance").html(allselBtnDisp);
                $("#nowStudentSaveBtnDisp").html(nowStudentSaveBtn);
            }
            
        },
        error: function (xhr, status, error) {
            console.log("code: " + xhr.status)
            console.log("message: " + xhr.responseText)
            console.log("error: " + error);
        }
        
    })//ajax 당일출석end
}
function fAttStudList(data){
    $.ajax({
        url: "/profLecture/attendStuList", //ajax용 url 변경
        contentType:"application/json;charset=utf-8",
        data:JSON.stringify(data),
        type:"post",
        dataType:"json",
        beforeSend:function(xhr){
        xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
        },
        success:function(result){
            // console.log("attendStuList result : ",result)
            attStudList="";
            // console.log("MaxLecCount",MaxLecCount);
            if(result.length == 0){
                attStudList+=`
                    <h4>출석목록</h4>
                    <div style="margin-bottom: 50px;">
                    <div class="input-group input-group-sm divSearch">
                        <input type="text" name="table_search_attList" class="form-control float-left" placeholder="이름을 입력하세요">
                        <div class="input-group-append">
                            <button type="button" class="btn btn-default" id="btnSearchAttList">
                                <i class="fas fa-search"></i>
                            </button>
                        </div>
                    </div>
                    </div>

                    <div class="card">
                    <div class="card-body table-responsive p-0 search-table">
                        <table class="table table-hover text-nowrap lectureList">
                            <thead style="background-color: #ebf1e9;max-height: 290px;overflow-y: auto;position: sticky;top:0px;">
                                <tr id="freqList">
                                    <th class="textCenter" style="width: 50px;">번호</th>
                                    <th class="textCenter" style="width: 80px;">학번</th>
                                    <th class="textCenter" style="width: 80px;">이름</th>
                                    <th class="textCenter" style="width: 50px;">학년</th>                            
                                    <th class="textCenter" style="width: 50px;">학과</th>
                                </tr>  
                            </thead>
                            <tbody id="stuList" class="text-center scroll search-trShow">
                                <tr> 
                                    <td colspan="6" style="text-align:center;">검색 결과가 없습니다.</td>            
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    </div> 
                `;
                $("#attStudListDisp").html(attStudList);
                $("#allSelAttendance").html('');
                $("#nowStudentSaveBtnDisp").html('');
                return;
            }
            let MaxLecCount=result[0].maxLecNum;
            attStudList+=`
                <h4>출석목록</h4>
                <div style="margin-bottom: 50px;">
                    <div class="input-group input-group-sm divSearch">
                        <input type="text" name="table_search_attList" class="form-control float-left" placeholder="이름을 입력하세요">
                        <div class="input-group-append">
                            <button type="button" class="btn btn-default" id="btnSearchAttList">
                                <i class="fas fa-search"></i>
                            </button>
                        </div>
                    </div>
                </div>
                    
                <div class="card">
                    <div class="card-body table-responsive p-0 search-table" style="max-height:565px;">
                        <table class="table table-hover text-nowrap lectureList">
                            <thead style="background-color: #ebf1e9;max-height: 290px;overflow-y: auto;position: sticky;top:0px;">
                                <tr id="freqList">
                                    <th class="textCenter" style="width: 50px;">번호</th>
                                    <th class="textCenter" style="width: 80px;">학번</th>
                                    <th class="textCenter" style="width: 80px;">이름</th>
                                    <th class="textCenter" style="width: 50px;">학년</th>                            
                                    <th class="textCenter" style="width: 50px;">학과</th>
                    `;
            for(let i =0; i <MaxLecCount;i++){
                attStudList+=`<th class="textCenter" style="width: 50px;">\${i+1}회차</th>`;
            }
                attStudList+=` 
                    </tr>
                        </thead>
                        <tbody id="stuList" class="text-center scroll search-trShow">
                `;
            $.each(result, function (idx, stuLectureVO) {
                // console.log("stuLectureVO", stuLectureVO);
                // console.log("--------------------")
                let eggEname = stuLectureVO.aggEname;
                let eggEnameArr = [];
                eggEnameArr=eggEname.split(",");
                attStudList+=`
                    <tr>
                        <td>\${idx+1}</td>
                        <td>\${stuLectureVO.stNo}</td>
                        <td class="userName">\${stuLectureVO.userInfoVO.userName}</td>
                        <td>\${stuLectureVO.studentVO.stGrade}학년</td>
                        <td>\${stuLectureVO.comDetCodeVO.comDetCodeName}</td>
                `;
                eggEnameArr.forEach(function(eggEname,idx){
                    //console.log("eggEname>",eggEname);
                    //console.log("idx",idx);
                    if(eggEname=="출석"){
                        attStudList+=`<td style="font-weight: bold;">\${eggEname}</td>`;
                    }
                    else if(eggEname == "미출석"){
                        attStudList+=`<td style="color: #adacac;">_</td>`;
                    }else{
                        attStudList+=`<td>\${eggEname}</td>`;
                    }
                });

                attStudList+=`</tr>
                `; 
                //ajax 회차 내용 end
            });
            attStudList+=` 
                            </tbody>
                        </table>
                    </div>
                </div> 
                    `;

            // console.log("attStudList : ",attStudList); // 목록 출력
            // $("#freqList").html(listDisp);
            $("#attStudListDisp").html(attStudList);
        }
    });//ajax end
}
    </script>

<h3>학생 출결</h3>
<div id="allDisp" style="margin: 50px auto;width: 80%;">
    <!-- 강의선택 start -->
    <div class="col-12">
        <div class="card">
            <div class="card-body table-responsive p-0 search-table" style="overflow-y: scroll;width: 100%;height: 345px;">
                <table class="table table-hover text-nowrap lectureList">
                    <thead style="background-color: #ebf1e9;position: sticky;top: -1px;">
                        <tr class="trBackground">
                            <th class="textCenter">번호</th>
                            <th class="textCenter">강의번호</th>
                            <th class="textCenter">강의연도</th>
                            <th class="textCenter">강의학기</th>
                            <th class="textCenter"style="width: 15%;">강의명</th>
                            <th class="textCenter">강의실번호</th>
                            <th class="textCenter">수강인원</th>
                        </tr>
                    </thead>
                    <tbody id="search-trShow" class="text-center scroll">
                        <!-- ${stuLectureVOCount.lecNo} -->
                        <c:forEach var="lectureVO" items="${lectureVOList}" varStatus="stat">
                            <tr class="trBackground" onclick="lectInfo(this)">
                                <th>${stat.index + 1}</th>
                                <c:set var="hasIcon" value="false" />
                                <c:forEach var="nowlecNo" items="${nowlecNoList}">
                                    <c:if test="${nowlecNo.lecNo eq lectureVO.lecNo}">
                                        <c:set var="hasIcon" value="true" />
                                    </c:if>
                                </c:forEach>
                                <c:choose>
                                    <c:when test="${hasIcon}">
                                        <th style="text-align: center;">
                                            <div style="display: flex; align-items: center; justify-content: center;">
                                                <div style="display: flex; align-items: center;">
                                                    <i class="fa-solid fa-calendar-day" style="
                                                        color: #053828 !important;
                                                        background-color: #ffffff !important;
                                                        border-radius: 50%;
                                                        font-size: 19px;
                                                        height: 20px;
                                                        width: 20px;
                                                        display: flex;
                                                        justify-content: center;
                                                        align-items: center;
                                                        margin-right: 8px;
                                                    "></i>
                                                    <div style="margin-right: 27px;">${lectureVO.lecNo}</div>
                                                </div>
                                            </div>
                                        </th>
                                    </c:when>
                                    <c:otherwise>
                                        <th>${lectureVO.lecNo}</th>
                                    </c:otherwise>
                                </c:choose>
                                <th>${lectureVO.lecYear}년도</th>
                                <th>${lectureVO.lecSemester}학기</th>
                                <th style="text-align: left;">${lectureVO.lecName}</th>
                                <th>${lectureVO.lectureRoomVO.lecRoName}</th>
                                <th>
                                    <c:set var="matchFound" value="false" />
                                    <c:forEach var="stuLectureVOCount" items="${stuLectureVOCountList}" varStatus="countStat">
                                        <c:if test="${lectureVO.lecNo eq stuLectureVOCount.lecNo}">
                                            ${stuLectureVOCount.stuLecCount}명
                                            <c:set var="matchFound" value="true" />
                                        </c:if>
                                    </c:forEach>
                                    <c:if test="${!matchFound}">
                                        0명
                                    </c:if>
                                </th>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <br>
    <!-- 강의선택 end -->
    <!-- 출결시스템 안내 start -->
    <div class="col-md-12" style="margin: 10px 0px;">
        <div class="card card-default">
            <div class="card-header" style="background-color: #ebf1e9;text-align: center; color:black;">
                <h5 class="card-title" style="padding-top: 5px;" style="color:black;">출결시스템안내</h5>
            </div>
            <div class="card-body p-0">
                <div style=" margin-left: 20px;margin-top: 20px; color:black;">
                    <p>
                        (1) 출결표는 회차로 구분합니다.
                    </p>
                    <p>
                        (2) 당일 출결 선택에서 '미출결'로 되어 있는 경우, 저장을 누르면 '결석'으로 변경됩니다.
                    </p>
                    <p>
                        (3) <i class="fa-solid fa-calendar-day"></i> 당일 출석 가능한 강의 입니다.
                    </p>
                </div>
            </div>
        </div>
    </div>
    <br>
    <!-- 출결시스템 안내 end -->
    <!-- 당일 출석 구역 start -->
    <div id="styled_box" class="col-12">
        <h4 style="display: inline-block; color:black;">당일 출석</h4>
        <div id="nowLecInfoDisp">
        </div>
        <div class="header" style="margin-bottom: 5px;">
            <!-- <h5><span id="nowDate">yyyy-mm-dd</span> <span id="nowClock">00:00</span>  <span id="nowLecNumDisp"></span>회차</h5> -->
            <h5 style="margin: 20px 0px 0px;"><span id="nowDate">yyyy-mm-dd</span> <span id="nowClock">00:00</span>  <span id="nowLecNumDisp"></span></h5>
            <div id="allSelAttendance">
                <!-- 전체출석 체크 버튼 -->
            </div>
        </div>
        <div id="brd_searchDisp" class="brd-search" style="margin-bottom: 20px;">
<!--             <div class="input-group input-group-sm divSearch"> -->
<!--                 <input type="text" name="table_search" class="form-control float-left" placeholder="이름을 입력하세요"> -->
<!--                 <div class="input-group-append"> -->
<!--                     <button type="button" class="btn btn-default" id="btnSearch"> -->
<!--                         <i class="fas fa-search"></i> -->
<!--                     </button> -->
<!--                 </div> -->
<!--             </div> -->
        </div>
        <br>
        <div class="card">
            <div class="card-body table-responsive p-0 search-table" style="max-height: 430px;overflow-y: auto;">
                <table id="nowStudentList" class="table table-hover text-nowrap lectureList" >
                    <thead style="background-color: #ebf1e9;position: sticky;top: -6px;">
                        <tr style="color:black;">                       
                            <th class="textCenter" style="width: 50px;">번호</th>
                            <th class="textCenter" style="width: 80px;">학번</th>
                            <th class="textCenter" style="width: 80px;">이름</th>
                            <th class="textCenter" style="width: 50px;">학년</th>                            
                            <th class="textCenter" style="width: 100px;">학과</th>
                            <th class="textCenter" style="width: 50px;">회차</th>                            
                        </tr>
                    </thead>
                    <tbody class="text-center scroll search-trShow">
                        <!-- 출결 체크 출력 영역 -->
                        <tr>
                            <td colspan="6" style="text-align:center;"><h4 style="margin: 12px 0px 4px;">강의 선택하세요</h4></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
        <div id="nowStudentSaveBtnDisp">
        </div>
    </div>
    <!-- 당일 출석 구역 end -->
    <br>
    <br>
    <!-- 출결체크리스트 -->
    <div id="attStudListDisp" class="col-12" > 
    </div> <!-- end -->
    <!-- 출결체크 end -->
    <br>
    
</div>
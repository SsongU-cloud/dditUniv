<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
      <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

         <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
         <script src="https://cdn.ckeditor.com/ckeditor5/34.0.0/classic/ckeditor.js"></script>
         <html>

         <head>
            <style type="text/css">
               h3 {
                  color: black;
                  margin-bottom: 30px;
                  margin-top: 40px;
                  margin-left: 165px;
               }

               td {
                  padding: 0px;
               }

               .table {
                  padding: 0px;
                  margin: 0;
               }

               .btnbtn {
                  text-align: center;
               }

               .btncli {
                  width: 105px;
                  display: inline-block;
                  margin-right: 10px;
               }

               .btn-block+.btn-block {
                  margin-top: 0;
               }

               .mainbd {
                  padding-top: 40px;
                  margin: auto;
                  width: 80%;
               }

               .mainbdol {
                  border-radius: .25em;
               }

               .mailbox-read-time {
                  margin: 10px 0px 0px 0px;
               }

               h4 {
                  margin-bottom: 20px;
               }

               .cardFooterDiv {
                  border-top: 0px solid #e3e6f0;
                  background-color: transparent;
               }

               .clearfix {
                  margin-top: 16px;
               }

               .attname {
                  font-size: 13px;
               }

               input:focus {
                  outline: none;
               }

               .marginLeft {
                  margin-left: 10px;
               }

               .mainbdFoot {
                  margin: 50px 170px 40px 170px;
                  width: 80%;
                  background-color: white;
                  padding: 30px 30px 30px 30px;
               }

               .queH4 {
                  display: inline-block;
               }

               .btnregi {
                  margin-top: 15px;
                  margin-left: 1153px;
               }

               .dateDay {
                  display: inline;
                  margin-left: 1140px;
                  font-size: 13px;
               }

               .btncliDecl {
                  width: 75px;
                  display: inline-block;
                  margin-bottom: 10px;
                  padding: .125rem .25rem;
               }

               .commentBor {
                  border: 1px solid #ced4da;
               }

               .tdPadding {
                  padding: 10px 0px 10px 10px;
               }

               .tdPaddingNic {
                  padding: 10px 10px 10px 20px;
               }

               .tdPaddingBut {
                  padding: 10px 10px 0px 10px;
               }

               .tableMarginTop {
                  margin-top: 20px;
               }

               .textAreaMar {
                  margin-top: 50px;
               }

               .tdPaddingClo {
                  padding: 10px 10px 10px 10px;
                  display: flex;
                  justify-content: center;
               }

               .tbe {
                  height: 80vh;
                  width: 93%;
                  table-layout: fixed;
                  text-align: center;
                  margin-left: auto;
                  margin-right: auto;
                  margin-top: 50px;
                  background-color: white;
                  border-color: #d2d8d0;
               }

               .icon-button {
                  display: inline-flex;
                  align-items: center;
                  justify-content: center;
                  border: none;
                  padding: 10px;
                  background-color: #f8f9fc;
                  color: #eaeaea;
                  font-size: 1.5em;
                  cursor: pointer;
                  transition: background-color 0.3s;
               }

               .icon-button:hover {
                  color: red;
               }

               .icon-button:active .fa-heart {
                  color: red;
               }

               .tdPaddingClo {
                  padding: 10px 10px 10px 10px;
                  display: flex;
                  justify-content: center;
               }

               .lectureSchedule {
                  height: 80px;
               }
            </style>
            <script type="text/javascript">
               // let queTitle = "${questionVO.queTitle}";
               let writerStNo = `${timeLecutreBoastVO.studentVO.stNo}`;
               console.log("writerStNo", writerStNo);

               $(function () {
                  /////
                  let data = {
                     stNo: `${timeLecutreBoastVO.studentVO.stNo}`
                  }
                  console.log("시간표stno", data);
                  $.ajax({
                     url: "/timePost/LectureAjax", // ajax용 URL 변경
                     contentType: "application/json;charset=utf-8",
                     data: JSON.stringify(data),
                     type: "post",
                     dataType: "json",
                     beforeSend: function (xhr) {
                        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                     },
                     success: function (result) {
                        // 성공적으로 데이터를 가져왔을 때 실행되는 함수
                        // result.length : result 배열의 길이
                        // result : 가져온 데이터 전체
                        // result[0].lecNo : 첫 번째 강의의 강의 번호
                        // result[0].lectureVOList.lecCol : 첫 번째 강의의 색상 코드
                        // result[0].lectureVOList.lectureDetailVOList[0].lectureRoomVO.lecRoName : 첫 번째 강의의 강의실 이름

                        for (let i = 0; i < result.length; i++) {
                           let lecNo = result[i].lecNo; // 강의 번호
                           let lecName = result[i].lectureVOList.lecName; // 강의명
                           let lecRoName = result[i].lectureVOList.lectureRoomVO.lecRoName; // 강의실명
                           let lecCol = result[i].lectureVOList.lecCol; // 색상 코드
                           let lecDay = result[i].lectureVOList.lecTimeVO.lecDay; // 강의 요일
                           let lecSt = result[i].lectureVOList.lecTimeVO.lecSt; // 강의 시작 교시
                           let lecEnd = result[i].lectureVOList.lecTimeVO.lecEnd; // 강의 종료 교시

                           weekCheck(lecNo, lecName, lecRoName, lecCol, lecDay, lecSt, lecEnd);
                        }

                     },
                     error: function (request, status, error) {
                        // 에러가 발생했을 때 실행되는 함수
                        console.log("code: " + request.status) // 에러 코드 출력
                        console.log("message: " + request.responseText) // 에러 메시지 출력
                        console.log("error: " + error); // 에러 객체 출력
                     }
                  });

                  // 요일 확인
                  function weekCheck(lecNo, lecName, lecRoName, lecCol, lecDay, lecSt, lecEnd) {
                     // 	console.log("lecDay : ", lecDay);

                     if (lecDay == "월") {
                        lecCheck(lecNo, lecName, lecRoName, lecCol, "lectureMon", lecSt, lecEnd);
                     } else if (lecDay == "화") {
                        lecCheck(lecNo, lecName, lecRoName, lecCol, "lectureTue", lecSt, lecEnd);
                     } else if (lecDay == "수") {
                        lecCheck(lecNo, lecName, lecRoName, lecCol, "lectureWed", lecSt, lecEnd);
                     } else if (lecDay == "목") {
                        lecCheck(lecNo, lecName, lecRoName, lecCol, "lectureThu", lecSt, lecEnd);
                     } else if (lecDay == "금") {
                        lecCheck(lecNo, lecName, lecRoName, lecCol, "lectureFri", lecSt, lecEnd);
                     }
                  }

                  // 교시 확인 & 값 넣기
                  function lecCheck(lecNo, lecName, lecRoName, lecCol, classTemp, lecSt, lecEnd) {
                     // 	console.log("교시 확인! : ", classTemp, lecSt, lecEnd);

                     for (let i = lecSt; i <= lecEnd; i++) {
                        let classNum = classTemp + i;
                        document.getElementsByClassName(classNum)[0].style.backgroundColor = lecCol; // 강의 배경 색상 설정
                        let str = "";
                        str += lecName + "&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;"; // 강의명 추가
                        str += lecRoName; // 강의실명 추가

                        document.getElementsByClassName(classNum)[0].style.color = "white"; // 텍스트 색상 설정
                        document.getElementsByClassName(classNum)[0].innerHTML = str; // 강의명과 강의실명을 HTML에 추가
                     }
                  }
                  //////
                  // 현재 URL 가져오기
                  let url = window.location.href;
                  console.log("현재 URL:", url);

                  let timeLecBoNo = "";

                  // URL에서 '&' 문자의 위치 찾기
                  let index = url.indexOf("&");
                  // console.log("인덱스:", index);

                  // '&' 문자가 존재하면
                  if (index !== -1) {
                     // '?' 이후의 부분에서 '=' 문자를 기준으로 분리하고, 그 다음 인덱스(1)에 있는 값을 가져옴
                     timeLecBoNo = url.split("timeLecBoNo=")[1];
                     // console.log("timeLecBoNo 값:", timeLecBoNo);
                  } else {
                     console.log("URL에서 '&' 문자가 존재하지 않습니다.");
                  }

                  let timeLecBoNoData = {
                     timeLecBoNo
                  }
                  console.log("timeLecBoNoData", timeLecBoNoData);

                  $('#list').on('click', function () {
                     location.href = "/timePost/lecutreBoast?menuId=jaeBoaArd";
                  });

                  $("#btnUpdate").on("click", function () {
                     $("#p1").css("display", "none");
                     $("#p2").css("display", "block");
                     fUpdateMode();
                  });

                  $("#btnSave").on("click", function () {
                     console.log("수정후 확인 버튼")
                     let timeLecBoNo = `${timeLecutreBoastVO.timeLecBoNo}`;
                     let timeLecBoName = "";
                     let timeLecBoCon = "";

                     timeLecBoName = $("#timeLecBoName").val();

                     timeLecBoCon = editor.getData();
                     timeLecBoCon = timeLecBoCon.replace(/<p><\/p>/g, '').trim();

                     let data = {
                        timeLecBoNo,
                        timeLecBoName,
                        timeLecBoCon
                     }
                     console.log("btnSave_data", data);
                     $.ajax({
                        url: "/timePost/lecBoaUpdate",
                        contentType: "application/json;charset=utf-8",
                        data: JSON.stringify(data),
                        type: "post",
                        dataType: "text",
                        beforeSend: function (xhr) {
                           xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                        },
                        success: function (result) {
                           // console.log("lecBoaUpdate_result",result);
                           if (result > 0) {
                              fDetailMode();
                              $("#p1").css("display", "block");
                              $("#p2").css("display", "none");
                           }
                        }
                     })
                  })
                  $("#btnDelete").on("click", function () {
                     let timeLecBoNo = `${timeLecutreBoastVO.timeLecBoNo}`;
                     let data = {
                        timeLecBoNo
                     };
                     console.log("delete_data>", data)
                     Swal.fire({
                        title: '삭제하시겠습니까?',
                        text: "삭제하면 목록으로 이동합니다.",
                        icon: 'warning',
                        showCancelButton: true,
                        confirmButtonColor: '#3085d6',
                        cancelButtonColor: '#d33',
                        confirmButtonText: '삭제',
                        cancelButtonText: '취소'
                     }).then((result) => {
                        if (result.isConfirmed) {
                           $.ajax({
                              url: "/timePost/lecBoaDelete",
                              contentType: "application/json;charset=utf-8",
                              data: JSON.stringify(data),
                              type: "post",
                              dataType: "json",
                              beforeSend: function (xhr) {
                                 xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                              },
                              success: function (result) {
                                 //  console.log("삭제 결과:", result);

                                 if (result != null) {
                                    Swal.fire(
                                       '삭제 완료!',
                                       '해당 공지가 삭제되었습니다.',
                                       'success'
                                    ).then(() => {
                                       location.href = "/timePost/lecutreBoast?menuId=jaeBoaArd";
                                    });
                                 } else {
                                    Swal.fire(
                                       '삭제 취소!',
                                       '삭제 취소하였습니다.',
                                       'error'
                                    );
                                 }
                              }
                           });
                        }
                     });
                  });

                  likeList();//좋아요 상태
                  $("#btnLike").on("click", function () {
                     // console.log("btnList ck");
                     //   console.log("userLoggedIn", userLoggedIn);

                     let timeLecBoNo = `${timeLecutreBoastVO.timeLecBoNo}`;
                     let data = { timeLecBoNo: timeLecBoNo };

                     $.ajax({
                        url: "/timePost/likeList",
                        contentType: "application/json;charset=utf-8",
                        data: JSON.stringify(data),
                        type: "post",
                        dataType: "json",
                        beforeSend: function (xhr) {
                           xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                        },
                        success: function (result) {
                           //  console.log("likeList result:", result);
                           let isLiked = false;
                           let timeLectureRecomVO = null;
                           $.each(result, function (idx, eachLike) {
                              //   console.log("eachLike.stNo>", eachLike.stNo);
                              if (userLoggedIn == eachLike.stNo) {
                                 isLiked = true;
                                 timeLectureRecomVO = eachLike;
                                 return false;
                              }
                           });

                           if (isLiked) {
                              // 이미 좋아요를 누른 상태 -> 삭제
                              let data = {
                                 stNo: timeLectureRecomVO.stNo,
                                 timeLecBoNo: timeLectureRecomVO.timeLecBoNo
                              };
                              $.ajax({
                                 url: "/timePost/likeDelete",
                                 contentType: "application/json;charset=utf-8",
                                 data: JSON.stringify(data),
                                 type: "post",
                                 dataType: "json",
                                 beforeSend: function (xhr) {
                                    xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                                 },
                                 success: function (result) {
                                    //  console.log("likeDelete_result:", result);
                                    likeList();
                                 },
                                 error: function (xhr, status, error) {
                                    console.error("Error in likeDelete:", error);
                                 }
                              });
                           } else {
                              // 좋아요를 누르지 않은 상태 -> 추가
                              let data = {
                                 stNo: userLoggedIn,
                                 timeLecBoNo: timeLecBoNo
                              };
                              $.ajax({
                                 url: "/timePost/likeInsert",
                                 contentType: "application/json;charset=utf-8",
                                 data: JSON.stringify(data),
                                 type: "post",
                                 dataType: "json",
                                 beforeSend: function (xhr) {
                                    xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                                 },
                                 success: function (result) {
                                    //  console.log("likeInsert_result:", result);
                                    likeList();
                                 },
                                 error: function (xhr, status, error) {
                                    console.error("Error in likeInsert:", error);
                                 }
                              });
                           }
                        },
                        error: function (xhr, status, error) {
                           console.error("Error in likeList:", error);
                        }
                     });
                  });

                  timeBoastComm();
                  $("#btnregi").on("click", function () {
                     let timeLecBoNo = `${timeLecutreBoastVO.timeLecBoNo}`;
                     let timeBoaCommCon = $("#replyCont").val();
                     if (!timeBoaCommCon) { // 댓글 입력 안하는 경우
                        $("#replyCont").focus();
                        const Toast = Swal.mixin({
                           toast: true,
                           position: "top-end",
                           showConfirmButton: false,
                           timer: 1800,
                        });
                        Toast.fire({
                           icon: "warning",
                           title: "댓글 입력하세요"
                        });
                        return;
                     }
                     let data = {
                        timeLecBoNo,
                        timeBoaCommCon
                     }
                     console.log("data>", data);
                     $.ajax({
                        url: "/timePost/timeBoastCommInsert",
                        contentType: "application/json;charset=utf-8",
                        data: JSON.stringify(data),
                        type: "post",
                        dataType: "text",
                        beforeSend: function (xhr) {
                           xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                        },
                        success: function (result) {
                           // console.log("timeBoastCommInsert_data",result);
                           if (result > 0) {
                              $("#replyCont").val("");
                              timeBoastComm();
                           }
                        }
                     })

                  })
                  // $("#replyCont").keyup(function(event) { //엔터키 입력
                  //    if (event.keyCode === 13) { // 엔터 키 입력 시
                  //       event.preventDefault(); // 기본 동작 방지
                  //       let timeBoaCommCon = $("#replyCont").val();
                  //    if(!timeBoaCommCon){ // 댓글 입력 안하는 경우
                  //       $("#replyCont").focus();
                  //       const Toast = Swal.mixin({
                  //          toast: true,
                  //          position: "top-end",
                  //          showConfirmButton: false,
                  //          timer: 1800,
                  //          });
                  //          Toast.fire({
                  //          icon: "warning",
                  //          title: "댓글 입력하세요"
                  //          });
                  //          return;
                  //    }
                  //       $("#btnregi").click(); // 등록 버튼 클릭과 동일한 동작 수행
                  //    }
                  // });
                  $('#cancel').on('click', function () {
                     fDetailMode();
                     $("#p1").css("display", "block");
                     $("#p2").css("display", "none");

                  });
                  $(document).on("click", "#btnDeclaration", function () {
                     console.log("신고버튼 클릭");
                     $('#modal-default').modal('show');
                     let timeDeBNo = `${timeLecutreBoastVO.timeLecBoNo}`;
                     sessionStorage.setItem("timeDeBNo", timeDeBNo);

                     let timeDeTitle = `${timeLecutreBoastVO.timeLecBoName}`;
                     sessionStorage.setItem("timeDeTitle", timeDeTitle);
                  });

                  $(document).on("click", "#btnCommDeclaration", function (e) {
                     // console.log("댓글 신고버튼 클릭");
                     // console.log("e>>",e)
                     // console.log("e>>",e.target.value);
                     $('#modal-default').modal('show');
                     let timeDeBNo = e.target.value//신고글번호
                     sessionStorage.setItem("timeDeBNo", timeDeBNo);

                     // 신고 버튼이 있는 tr 요소 찾기
                     let commentRow = $(e.target).closest('tr.commentBor');

                     // 다음 형제 요소 중에서 commContent 클래스를 가진 tr 요소 찾기
                     let commentContent = commentRow.next('.commContent');

                     // commentContent 요소 내용 출력
                     // console.log("Comment Content: ", commentContent.find('div').text());
                     let timeDeTitle = commentContent.find('div').text();
                     console.log("timeDeTitle>", timeDeTitle);
                     sessionStorage.setItem("timeDeTitle", timeDeTitle);

                  });

                  $("#btnDeclarationSend").on("click", function () {
                     // console.log("신고안에 있는 신고버튼");
                     let timeDereason = $("input[name=declarationComDetCode]:checked").val();
                     let timeBDiv = $("#timeBDiv").val();
                     timeDeBNo = sessionStorage.getItem("timeDeBNo");
                     let timeDeUrl = window.location.href;
                     timeDeUrl = timeDeUrl.replace("menuId=injTopBoa", "menuId=jaeRepDet");
                     let timeDeId = userLoggedIn;
                     let timeDeTitle = sessionStorage.getItem("timeDeTitle");;
                     let data = {
                        timeDereason,
                        timeBDiv,
                        timeDeBNo,
                        timeDeUrl,
                        timeDeId,
                        timeDeTitle
                     }
                     console.log("btnDeclarationSend_data", data);
                     if (!timeDereason) {
                        const Toast = Swal.mixin({
                           toast: true,
                           position: "top-end",
                           showConfirmButton: false,
                           timer: 1800,
                        });
                        Toast.fire({
                           icon: "error",
                           title: "사유 선택 해주십시오."
                        });
                        return false;
                     }
                     flecBoaDeclaration(data);
                  });
                  $(document).on("click", "#btnLectureBlind", function () {
                     let timeLecBoNo = `${timeLecutreBoastVO.timeLecBoNo}`;
                     let data = {
                        timeLecBoNo
                     }
                     console.log("data", data)
                     $.ajax({
                        url: "/timePost/lecBoaAdminBlindUpdateY",
                        contentType: "application/json;charset=utf-8",
                        data: JSON.stringify(data),
                        type: "post",
                        dataType: "text",
                        beforeSend: function (xhr) {
                           xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                        },
                        success: function (result) {
                           if (result > 0) {
                              let blindEnd = "";
                              blindEnd = `
                                 <button type="button" class="btn btn-block btn-outline-secondary btncli" id="list" style="width: 118px;">목록</button>
                                 <button type="button" class="btn btn-block btn-outline-danger btncli" id="btnLectureBlind" style="width: 118px;" disabled>블라인드완료</button>
                              `;
                              $("#p1").html(blindEnd);
                           }
                        }
                     })
                  });
                  $(document).on("click","#btnCommBlind",function(e){
                     console.log("ck",e.target.value);
                     let timeBoaCommNo =e.target.value;
                     let data ={
                        timeBoaCommNo
                     }
                     console.log("data",data)
                     $.ajax({
                        url: "/timePost/lecBoaAdminCommBlindUpdateY",
                        contentType: "application/json;charset=utf-8",
                        data: JSON.stringify(data),
                        type: "post",
                        dataType: "text",
                        beforeSend: function (xhr) {
                           xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                        },
                        success:function(result){
                           console.log("result>",result);
                           if(result>0){
                              timeBoastComm();
                           }
                        }
                     })
                  })
               });//function end

               function flecBoaDeclaration(data) {
                  $.ajax({
                     url: "/timePost/lecBoaDeclaration",
                     contentType: "application/json;charset=utf-8",
                     data: JSON.stringify(data),
                     type: "post",
                     dataType: "text",
                     beforeSend: function (xhr) {
                        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                     },
                     success: function (result) {
                        console.log("lecBoaDeclaration_result", result)
                        if (result > 0) {
                           Swal.fire({
                              position: "center",
                              icon: "success",
                              title: "신고완료 되었습니다.",
                              timer: 1800,
                              showConfirmButton: false // 확인 버튼을 숨깁니다.
                           }).then(() => {
                              // Swal.fire의 타이머가 끝난 후 호출됩니다.
                              location.href = "/timePost/lecutreBoast?menuId=jaeBoaArd";
                           });
                        }
                     }
                  });
               }
               function likeList() {
                  let timeLecBoNo = `${timeLecutreBoastVO.timeLecBoNo}`;
                  let data = { timeLecBoNo };
                  console.log("likeList_data>", data);
                  $.ajax({
                     url: "/timePost/likeList",
                     contentType: "application/json;charset=utf-8",
                     data: JSON.stringify(data),
                     type: "post",
                     dataType: "json",
                     beforeSend: function (xhr) {
                        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                     },
                     success: function (result) {
                        console.log("likeList result:", result);
                        let isLiked = false;
                        $.each(result, function (idx, eachLike) {
                           //  console.log("eachLike.stNo>", eachLike.stNo);
                           if (userLoggedIn == eachLike.stNo) {
                              isLiked = true;
                              return false;
                           }
                        });

                        if (isLiked) {
                           $("#btnLike").css("color", "red");
                        } else {
                           $("#btnLike").css("color", "#eaeaea");
                        }
                        $("#likeCount").text(result.length ? result.length : 0); // 좋아요 개수 업데이트
                     },
                     error: function (xhr, status, error) {
                        console.error("Error in likeList:", error);
                     }
                  });
               }
               function timeBoastComm() {
                  let timeLecBoNo = `${timeLecutreBoastVO.timeLecBoNo}`;
                  let data = {
                     timeLecBoNo
                  }
                  $.ajax({
                     url: "/timePost/timeBoastCommAdmin",
                     contentType: "application/json;charset=utf-8",
                     data: JSON.stringify(data),
                     type: "post",
                     dataType: "json",
                     beforeSend: function (xhr) {
                        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                     },
                     success: function (result) {
                        console.log("result>>",result);
                        let commCount = result.length;
                        let timeBoastComm = "";

                        $.each(result, function (idx, timeBoastCommVO) {
                           // console.log("timeBoastCommVO",timeBoastCommVO.timeBoaCommNo)
                            console.log("timeBoastCommVO",timeBoastCommVO);

                           timeBoastComm += `
                                    <tr class="commentBor" style="background-color: #ebf1e9">
                                       <td class="tdPaddingNic" style="width: 70%;">천재님</td>
                                       <td class="tdPadding">\${timeBoastCommVO.timeBoaCommDate}</td>
                           `;

                           if (dataRole.includes("ADMIN")) {
                              if(`\${timeBoastCommVO.timeBoaCommYn}` == 'N'){
                                 timeBoastComm += `<td class="tdPaddingBut">
                                    <button type="button" class="btn btn-block btn-outline-danger btn-xs btncliDecl" id="btnCommBlind" value="\${timeBoastCommVO.timeBoaCommNo}">블라인드</button>
                                 </td>
                                 `;
                              }
                              if(`\${timeBoastCommVO.timeBoaCommYn}` == 'Y'){
                                 timeBoastComm += `<td class="tdPaddingBut">
                                    <button type="button" class="btn btn-block btn-outline-danger btn-xs btncliDecl" id="btnCommBlind" style ="" disabled>블라인드완료</button>
                                 </td>
                                 `;
                              }
                           }
                           //////학생권한 , 사용자ID 댓글 작성자 다른경우
                           else if (dataRole.includes("STUDENT") && userLoggedIn != timeBoastCommVO.stNo) {
                              let declared = false;
                              $.each(result.timeDeclareVOList, function (idx, timeDeclareVO) {
                                 if (timeBoastCommVO.timeBoaCommNo == timeDeclareVO.timeDeBNo) {
                                    declared = true;
                                    return false;
                                 }
                              });
                              if (declared) {
                                 // console.log("신고완료")
                                 timeBoastComm += `
                  <td class="tdPaddingBut">
                        <button type="button" id="btnCommDeclaration" class="btn btn-block btn-outline-danger btn-xs btncliDecl" value="\${timeBoastCommVO.timeBoaCommNo}" disabled>신고완료</button>
                  </td>`;
                              } else {
                                 // console.log("신고")
                                 timeBoastComm += `
                  <td class="tdPaddingBut">
                        <button type="button" id="btnCommDeclaration" class="btn btn-block btn-outline-danger btn-xs btncliDecl" value="\${timeBoastCommVO.timeBoaCommNo}">신고</button>
                  </td>`;
                              }
                           }
                           /////            
                           else if (dataRole.includes("STUDENT") && userLoggedIn == timeBoastCommVO.stNo) {
                              timeBoastComm += `<td class="tdPaddingClo">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close" value="\${timeBoastCommVO.timeBoaCommNo}" onclick="fCommDelete(this)">
               <span aria-hidden="true">&times;</span>
            </button>
         </td>
         `;
                           }
                           timeBoastComm += ` 
            </tr>
            <tr class="commentBor commContent">
               <td class="tdPaddingNic" colspan="3">
                  <div>\${timeBoastCommVO.timeBoaCommCon}</div>
               </td>
            </tr>         
               `;

                        });//each 끝
                        let boastDeclaration = "";
                        //게시판 신고버튼클릭 유무
                        let declared = false;
                        console.log("result.timeDeclareVOList밖", result.timeDeclareVOList);
                        $.each(result.timeDeclareVOList, function (idx, timeDeclareVO) {
                           // console.log("timeDeclareVO안>>",timeDeclareVO)
                           // console.log("timeDeclareVO.timeDeBNo안>>",timeDeclareVO.timeDeBNo)
                           // console.log("timeBoastCommVO.timeBoaCommNo안>>",timeBoastCommVO.timeBoaCommNo)
                           let timeLecBoNo = `${timeLecutreBoastVO.timeLecBoNo}`
                           console.log("timeLecBoNo안>>", timeLecBoNo)
                           if (timeLecBoNo == timeDeclareVO.timeDeBNo) {
                              declared = true;
                              return false; //for문 중단
                           }
                        });
                        if (declared) {
                           boastDeclaration = `
            <button type="button" class="btn btn-block btn-outline-danger btncli" id="btnDeclaration" style="height: 40px;" disabled>신고완료</button>
         `;
                        } else {
                           boastDeclaration = `
            <button type="button" class="btn btn-block btn-outline-danger btncli" id="btnDeclaration" style="height: 40px;">신고</button>
         `;
                        }

                        $("#commCountDisp").html(commCount);
                        $("#timeBoastCommDisp").html(timeBoastComm);
                        $("#boastDeclarationDisp").html(boastDeclaration); // 게시판 신고버튼 클릭 유무
                        // dataRole 변수가 정의되지 않은 경우 처리
                        if (typeof dataRole === 'undefined') {
                           console.error("dataRole 변수가 정의되지 않았습니다.");
                        }
                     }

                  });
               }//timeBoastComm end
               function fCommDelete(e) {
                  //  console.log("e.value",e);
                  //  console.log("e.value",e.value);
                  let timeBoaCommNo = e.value;
                  let timeLecBoNo = `${timeLecutreBoastVO.timeLecBoNo}`
                  let data = {
                     timeBoaCommNo,
                     timeLecBoNo
                  }
                  $.ajax({
                     url: "/timePost/timeBoastCommDelete",
                     contentType: "application/json;charset=utf-8",
                     data: JSON.stringify(data),
                     type: "post",
                     dataType: "json",
                     beforeSend: function (xhr) {
                        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                     },
                     success: function (result) {
                        console.log("timeBoastCommDelete_result", result)
                        if (result > 0) {
                           timeBoastComm();
                           const Toast = Swal.mixin({
                              toast: true,
                              position: "top-end",
                              showConfirmButton: false,
                              timer: 1800,
                           });
                           Toast.fire({
                              icon: "success",
                              title: "댓글 삭제되었습니다."
                           });
                        }
                     }
                  })
               }
               function fUpdateMode() {
                  let timeLecBoNo = `${timeLecutreBoastVO.timeLecBoNo}`;
                  let data = {
                     timeLecBoNo
                  }
                  console.log("detailMode_data>", data);
                  $.ajax({
                     url: "/timePost/updateMode",
                     contentType: "application/json;charset=utf-8",
                     data: JSON.stringify(data),
                     type: "post",
                     dataType: "json",
                     beforeSend: function (xhr) {
                        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                     },
                     success: function (result) {
                        // console.log("detailMode_result",result);
                        let updateModeTitle = "";
                        let updateModeCon = "";
                        updateModeTitle += `
         <input type="text" id="timeLecBoName" class="form-control col-6 form-control-lg" placeholder="강의자랑게시글 제목" value="\${result.timeLecBoName}">
      `;
                        updateModeCon += `
         <div id="ckClassic"></div>
         <textarea name="timeLecBoCon" class="form-control" id="cttf" placeholder="내용을 입력하세요." style="display: none;" required></textarea>
      `;

                        // console.log("updateModeCon",updateModeCon);
                        // console.log("updateModeConDisp", $("#updateModeConDisp")[0]);
                        $("#updateModeTitleDisp").html(updateModeTitle);
                        $("#updateModeConDisp").html(updateModeCon);
                        fCkEditor(result.timeLecBoCon);
                     }
                  })
               }
               function fDetailMode() {
                  let timeLecBoNo = `${timeLecutreBoastVO.timeLecBoNo}`;
                  let data = {
                     timeLecBoNo
                  }
                  $.ajax({
                     url: "/timePost/detailMode",
                     contentType: "application/json;charset=utf-8",
                     data: JSON.stringify(data),
                     type: "post",
                     dataType: "json",
                     beforeSend: function (xhr) {
                        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                     },
                     success: function (result) {
                        // console.log("detailMode_result",result);
                        let updateModeTitle = "";
                        let updateModeCon = "";
                        updateModeTitle += `
               <h4 class="marginLeft">\${result.timeLecBoName}</h4>
            `;
                        let cleanContent = result.timeLecBoCon.replace(/<p><\/p>/g, '');

                        updateModeCon += `
               \${cleanContent}
            `;

                        $("#updateModeTitleDisp").html(updateModeTitle);
                        $("#updateModeConDisp").html(updateModeCon);
                     }
                  });
               }
               function fCkEditor(content) {
                  ClassicEditor.create(document.querySelector("#ckClassic"), {
                     ckfinder: {
                        uploadUrl: '/image/upload?${_csrf.parameterName}=${_csrf.token}'
                     }
                  })
                     .then(editor => {
                        window.editor = editor;
                        editor.setData(content); // Set the content from the result
                     })
                     .catch(err => {
                        console.error(err.stack);
                     });

                  $(document).on("keydown", ".ck-blurred", function () {
                     $("#cttf").val(window.editor.getData());
                  });

                  $(document).on("focusout", ".ck-blurred", function () {
                     $("#cttf").val(window.editor.getData());
                  });

                  $('style').append('.ck-content { height: 150px; }');
               }

            </script>
         </head>

         <body>

            <div>
               <h3 class="card-title">강의자랑 게시글</h3>
               <br>
               <form id="frm" name="frm" method="post">
                  <div class="mainbd">
                     <div class="card card-primary card-outline mainbdol">
                        <div class="card-header" style="background-color: #fff; margin-top: 12px;">
                           <div id="updateModeTitleDisp">
                              <h4 class="marginLeft">${timeLecutreBoastVO.timeLecBoName}</h4>
                           </div>
                           <div class="card-body p-0">
                              <div class="mailbox-read-time attname" id="formdata">
                                 <table class="table">
                                    <tr>
                                       <td>작성일 &nbsp; ${timeLecutreBoastVO.timeLecDate} &nbsp;|&nbsp; 수정일 &nbsp;
                                          ${timeLecutreBoastVO.timeLecUpdDate} &nbsp;|&nbsp; 작성자 &nbsp;
                                          ${timeLecutreBoastVO.userInfoVO.userName} &nbsp;
                                          &nbsp;
                                          &nbsp;
                                       </td>
                                    </tr>
                                 </table>
                              </div>
                           </div>
                        </div>
                        <div class="mailbox-read-message" style="min-height: 460px; margin: 2px 28px 18px 30px;">
                           <table border="1" class="tbe">
                              <thead>
                                 <tr class="heardTr">
                                    <th>교시</th>
                                    <th>시간</th>
                                    <th>월</th>
                                    <th>화</th>
                                    <th>수</th>
                                    <th>목</th>
                                    <th>금</th>
                                 </tr>
                              </thead>
                              <tbody>
                                 <tr class="lectureSchedule">
                                    <td>1교시</td>
                                    <td>09:00 ~ 09:50</td>
                                    <td class="lectureMon1"></td>
                                    <td class="lectureTue1"></td>
                                    <td class="lectureWed1"></td>
                                    <td class="lectureThu1"></td>
                                    <td class="lectureFri1"></td>
                                 </tr>
                                 <tr class="lectureSchedule">
                                    <td>2교시</td>
                                    <td>10:00 ~ 10:50</td>
                                    <td class="lectureMon2"></td>
                                    <td class="lectureTue2"></td>
                                    <td class="lectureWed2"></td>
                                    <td class="lectureThu2"></td>
                                    <td class="lectureFri2"></td>
                                 </tr>
                                 <tr class="lectureSchedule">
                                    <td>3교시</td>
                                    <td>11:00 ~ 11:50</td>
                                    <td class="lectureMon3"></td>
                                    <td class="lectureTue3"></td>
                                    <td class="lectureWed3"></td>
                                    <td class="lectureThu3"></td>
                                    <td class="lectureFri3"></td>
                                 </tr>
                                 <tr class="lectureSchedule">
                                    <td>4교시</td>
                                    <td>12:00 ~ 12:50</td>
                                    <td class="lectureMon4"></td>
                                    <td class="lectureTue4"></td>
                                    <td class="lectureWed4"></td>
                                    <td class="lectureThu4"></td>
                                    <td class="lectureFri4"></td>
                                 </tr>
                                 <tr class="lectureSchedule">
                                    <td>5교시</td>
                                    <td>13:00 ~ 13:50</td>
                                    <td class="lectureMon5"></td>
                                    <td class="lectureTue5"></td>
                                    <td class="lectureWed5"></td>
                                    <td class="lectureThu5"></td>
                                    <td class="lectureFri5"></td>
                                 </tr>
                                 <tr class="lectureSchedule">
                                    <td>6교시</td>
                                    <td>14:00 ~ 14:50</td>
                                    <td class="lectureMon6"></td>
                                    <td class="lectureTue6"></td>
                                    <td class="lectureWed6"></td>
                                    <td class="lectureThu6"></td>
                                    <td class="lectureFri6"></td>
                                 </tr>
                                 <tr class="lectureSchedule">
                                    <td>7교시</td>
                                    <td>15:00 ~ 15:50</td>
                                    <td class="lectureMon7"></td>
                                    <td class="lectureTue7"></td>
                                    <td class="lectureWed7"></td>
                                    <td class="lectureThu7"></td>
                                    <td class="lectureFri7"></td>
                                 </tr>
                                 <tr class="lectureSchedule">
                                    <td>8교시</td>
                                    <td>16:00 ~ 16:50</td>
                                    <td class="lectureMon8"></td>
                                    <td class="lectureTue8"></td>
                                    <td class="lectureWed8"></td>
                                    <td class="lectureThu8"></td>
                                    <td class="lectureFri8"></td>
                                 </tr>
                                 <tr class="lectureSchedule">
                                    <td>9교시</td>
                                    <td>17:00 ~ 17:50</td>
                                    <td class="lectureMon9"></td>
                                    <td class="lectureTue9"></td>
                                    <td class="lectureWed9"></td>
                                    <td class="lectureThu9"></td>
                                    <td class="lectureFri9"></td>
                                 </tr>
                              </tbody>
                           </table>
                           <br>
                           <p id="updateModeConDisp" style="font-size: 20px;">${timeLecutreBoastVO.timeLecBoCon}</p>
                        </div>
                     </div>

                     <sec:authorize access="isAuthenticated()">
                        <script>
                           var userLoggedIn = '<sec:authentication property="principal.username"/>';
                           var dataRole = "<sec:authentication property='authorities'/>";
                           console.log("userLoggedIn", userLoggedIn)
                           console.log("dataRole", dataRole)
                        </script>
                     </sec:authorize>

                     <div class="card-footer cardFooterDiv row">
                        <div id="likeDisp" style="font-size: 20px;">
                           <!-- <button type="button" id="btnLike" class="icon-button" > -->
                           <i class="fas fa-heart" style="color: red;"></i>
                           <!-- </button> -->
                           추천 <span id="likeCount">${timeLecutreBoastVO.timeLecLike}</span>
                        </div>
                        <div class="btnbtn row" style="margin: auto;">
                           <p id="p1">
                              <sec:authorize access="principal.username == '${timeLecutreBoastVO.stNo}'">
                                 <button type="button" class="btn btn-block btn-outline-warning btncli"
                                    id="btnUpdate">수정</button>
                              </sec:authorize>
                              <button type="button" class="btn btn-block btn-outline-secondary btncli"
                                 id="list">목록</button>
                              <sec:authorize access="hasRole('ROLE_ADMIN')">
                                 <c:if test = "${timeLecutreBoastVO.timeLecDelYn eq 'N'}">
                                    <button type="button" class="btn btn-block btn-outline-danger btncli" id="btnLectureBlind">블라인드</button>
                                 </c:if>
                                 <c:if test = "${timeLecutreBoastVO.timeLecDelYn eq 'Y'}">
                                    <button type="button" class="btn btn-block btn-outline-danger btncli" id="btnLectureBlind" style="width: 118px;" disabled>블라인드완료</button>
                                 </c:if>

                              </sec:authorize>
                              <sec:authorize
                                 access="hasRole('ROLE_STUDENT') and !principal.username.equals('${timeLecutreBoastVO.stNo}')">
                                 <div id="boastDeclarationDisp">
                                    <button type="button" class="btn btn-block btn-outline-danger btncli"
                                       id="btnDeclaration" style="height: 40px;">신고</button>
                                 </div>
                              </sec:authorize>
                              <sec:authorize
                                 access="hasRole('ROLE_STUDENT') and principal.username.equals('${timeLecutreBoastVO.stNo}')">
                                 <button type="button" class="btn btn-block btn-outline-danger btncli"
                                    id="btnDelete">삭제</button>
                              </sec:authorize>
                           </p>
                           <p id="p2" style="display: none;">
                              <button type="button" class="btn btn-block btn-outline-primary btncli"
                                 id="btnSave">확인</button>
                              <button type="button" class="btn btn-block btn-outline-secondary btncli"
                                 id="cancel">취소</button>
                           </p>
                        </div>
                     </div>
                  </div>
                  <sec:csrfInput />
               </form>

               <div class="mainbdFoot card card-primary card-outline">
                  <div>
                     <h5 class="queH4 far fa-comments">댓글 <span
                           id="commCountDisp">${timeLecutreBoastVO.timeLecLike}</span></h5>
                  </div>
                  <table class="commentBor tableMarginTop">
                     <tbody id="timeBoastCommDisp">
                        <!-- <tr class="commentBor" style="background-color: #ebf1e9">
                     <td class="tdPaddingNic" style="width: 70%;">천재님</td>
                     <td class="tdPadding">2024-07-04 12:21:28</td>
                     <td class="tdPaddingClo">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close" value="48" onclick="fCommDelete(this)">
                              <span aria-hidden="true">&times;</span>
                        </button>
                     </td>
                  </tr>
                  <tr class="commentBor">
                     <td class="tdPaddingNic" colspan="3">
                        <div>1</div>
                     </td>
                  </tr> -->
                     </tbody>
                  </table>
                  <div>
                     <textarea name="replyCont" id="replyCont" rows="5" class="form-control textAreaMar"></textarea>
                  </div>
                  <div>
                     <button type="button" class="btn btn-block btn-outline-primary btncli btnregi"
                        id="btnregi">등록</button>
                  </div>
               </div>
            </div>
            <!-- 모달 -->
            <div class="modal fade" id="modal-default" tabindex="-1" role="dialog" aria-labelledby="modal-default-label"
               aria-hidden="true">
               <div class="modal-dialog" role="document">
                  <div class="modal-content">
                     <div class="modal-header">
                        <h4 class="modal-title" id="modal-default-label">신고하기</h4>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                           <span aria-hidden="true">×</span>
                        </button>
                     </div>
                     <div class="modal-body">
                        <p style="font-weight: 900;font-size: 25px;">사유선택</p>
                        <table class="table table-hover text-nowrap">
                           <c:forEach var="comDetCode" items="${comDetCodeVOList}" varStatus="stat">
                              <tr>
                                 <td>
                                    <input type="radio" name="declarationComDetCode" value="${comDetCode.comDetCode}">
                                    ${comDetCode.comDetCodeName}
                                 </td>
                              </tr>
                           </c:forEach>
                        </table>
                        <input type="hidden" name="timeBDiv" id="timeBDiv" value="BB001002">
                     </div>
                     <div class="modal-footer justify-content-between">
                        <button type="button" class="btn btn-default" data-dismiss="modal"></button>
                        <button type="button" id="btnDeclarationSend" class="btn btn-outline-danger">신고</button>
                     </div>
                  </div>
               </div>
            </div>
         </body>

         </html>
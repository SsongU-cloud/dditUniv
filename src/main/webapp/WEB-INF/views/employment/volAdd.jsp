<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <style>
        h3 {
            color: black;
            margin-bottom: 15px;
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
        /* padding-top: 40px; */
        margin-left: 165px;
        margin-bottom: 20px;
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
        .marginLeft{
        margin-left:10px;
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
            width: 105px;
            display: inline-block;
            margin-right: 10px;
        }
        .commentBor {
        border: 1px solid #ced4da;
        }
        .tdPadding{
        padding: 10px 0px 10px 10px;
        }
        .tdPaddingNic{
        padding: 10px 10px 10px 20px;
        }
        .tdPaddingBut{
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
        .button-container {
            display: flex;
            justify-content: center; /* 가로 중앙 정렬 */
            align-items: center; /* 세로 중앙 정렬, 필요시 사용 */
            height: 100%; /* 부모 높이를 100%로 설정 */
        }

    </style>
    <script>
        $(function () {
            $("#btnSave").on("click", function () {
                let volStart = $("input[name='volStart']").val();
                let volEnd = $("input[name='volEnd']").val();
                let volTime = $("input[name='volTime']").val();
                let volPlace = $("input[name='volPlace']").val();
                let volCon = $("#volCon").val();
                let vonFile = $("input[name='vonFile']").val();
                console.log(volStart, ">", volEnd, ">", volTime, ">", volPlace, ">", volCon);
                
                if (!volStart || !volTime || !volPlace || !volCon || !vonFile) {
                    if (!volStart) {
                        $("input[name='volStart']").focus();
                    }
                    else if(!volEnd) {
                        $("input[name='volEnd']").focus();
                    }
                    else if(!volTime) {
                        $("input[name='volTime']").focus();
                    }
                    else if(!volPlace) {
                        $("input[name='volPlace']").focus();
                    }
                    else if(!volCon) {
                        $("input[name='volCon']").focus();
                    }
                    else if(!vonFile) {
                        $("input[name='vonFile']").focus();
                    }
                    const Toast = Swal.mixin({
                        toast: true,
                        position: "top-end",
                        showConfirmButton: false,
                        timer: 1800,
                        timerProgressBar: true,
                        // didOpen: (toast) => {
                        //     toast.onmouseenter = Swal.stopTimer;
                        //     toast.onmouseleave = Swal.resumeTimer;
                        // }
                    });
                        Toast.fire({
                            icon: "warning",
                        title:  "모든 필수 항목을 채워주세요."
                    });

                    return false;
                }
                
                let formData = new FormData();

                formData.append("volStart", volStart);
                formData.append("volEnd", volEnd);
                formData.append("volTime", volTime);
                formData.append("volPlace", volPlace);
                formData.append("volCon", volCon);
                let inputFile = $("#customFile");
                let file = inputFile[0].files;
                console.log("file.length:" + file.length);
                for (let i = 0; i < file.length; i++) {
                    formData.append("vonFile", file[i]);
                }
                $.ajax({
                    url: "/employment/volAddAjax",
                    processData: false,
                    contentType: false,
                    data: formData,
                    type: "post",
                    dataType: "text",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                    },
                    success: function (rslt) {
                        console.log("rslt", rslt);
                        //알람창
                        Swal.fire({
                            position: "center",
                            icon: "success",
                            title: "등록완료 되었습니다.",
                            timer: 1800,
                            showConfirmButton: false // 확인 버튼을 숨깁니다.
                        }).then(() => {
                            // Swal.fire의 타이머가 끝난 후 호출됩니다.
                            location.href = "/employment/volunteer?menuId=cybJobHun";
                        });
                    }
                });//ajax end
            })//#btnsave end
            $("#btnCancel").on("click",function(){
                location.href="/employment/volunteer?menuId=cybJobHun"
            })
            $('#auto').on('click', function(){
            	$('#volStart').val('2024-07-16');
            	$('#volEnd').val('2024-07-16');
            	$('#volTime').val('8');
            	$('#volCon').text('반려 동물 공원 청소 및 동물 돌보기');
			})
			
        })//$function end
    </script>
    <h3 style="color:black;margin-bottom:30px;margin-top: 40px;">봉사활동 등록</h3>
    <br>
    <form id="frm" action="/" method="post" enctype="multipart/form-data">
        <div class="mainbd">
            <div class="card card-primary card-outline mainbdol">
                <div style="margin-left: 25px;margin-bottom: 25px;">
	                <div class="form-group row" style="margin-top: 25px;margin-left: 1px;">
                        <div>
                            <label style="font-weight: bolder;">봉사시작날짜</label>
                            <br>
                            <input class="form-control" type="date" name="volStart" id="volStart" required>
                        </div>
                        <div style="margin: 20px;margin-top: 35px;font-weight: 900;">
                            ~
                        </div>
                        <div>
                            <label style="font-weight: bolder;">봉사종료날짜</label>
                            <br>
                            <input class="form-control" type="date" id="volEnd" name="volEnd">
                        </div>
                        <br>
                        <div style="margin-left: 15px;margin-top: -1px;">
                            <label style="font-weight:bolder;">봉사시간</label>
                            <br>
                            <input class="form-control" type="number" id="volTime" name="volTime" style="display: inline-block; width: 70px;" required>
                            <span style="font-weight:bolder;">&nbsp;시간</span>
                        </div>
                    </div><!-- row end -->
                    <div>
                        <input type="text" class="form-control col-6" name="volPlace" id="sample5_address" placeholder="봉사활동장소"
                            style="display: inline;margin-bottom: 15px;" required>
                        <input type="button" class="btn btn-outline-success" onclick="sample5_execDaumPostcode()" value="주소 검색"
                            style="margin-bottom:5px;margin-left: 5px;">
                        <br>
                        <div id="map" style="width:300px;height:300px;margin-top:10px;display:block"></div>
                    </div>
                    <br>
                    <div class="form-group">
                        <label>봉사내역</label>
                        <textarea class="form-control" id="volCon" name="volCon" rows="3" cols="50" placeholder="봉사내역 내용" style="width: 900px;" required></textarea>
                    </div>
                    <div class="form-group">
                        <div class="custom-file" style="width: 900px;margin-bottom: 20px;">
                            <input type="file" class="custom-file-input" id="customFile" name="vonFile" required>
                            <label class="custom-file-label" for="customFile">파일 선택</label>
                        </div>
                        <div class="col-12 text-center d-flex align-items-center justify-content-center" id="pImg"></div>
                    </div>
                    <div id="p1" style="text-align: center;">
                        <button type="button" id="btnSave" class="btn btn-outline-primary btncli" >등록</button>
                        <button type="button" id="btnCancel" class="btn btn-block btn-outline-secondary btncli">취소</button>
                        <button type="button" class="btn btn-outline-light" id="auto">자동 완성</button>
                    </div>
                    <sec:csrfInput />
                </div>
            </div>
        </div>
    </form>

    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d4c2ba0057e1164adb08128bb0b217a7&libraries=services"></script>
    <script>
        document.querySelector('#customFile').addEventListener('change', function (e) {
            var fileName = document.getElementById("customFile").files[0].name;
            var nextSibling = e.target.nextElementSibling;
            nextSibling.innerText = fileName;
            //미리보기
            let files = e.target.files;
            console.log("files>>",files);
            let fileArr = Array.prototype.slice.call(files);
            fileArr.forEach(function(f){
                let reader = new FileReader();
                reader.onload = function(e){
                    let img_html = "<img src=\"" + e.target.result + "\" style='width:50%;' />";
                    $("#pImg").html(img_html);
                }
                reader.readAsDataURL(f);
            });//end forEach
        });
        //다음 지도 api
        // 지도를 표시할 div와 옵션을 설정합니다.
        var mapContainer = document.getElementById('map'),
            mapOption = {
                center: new daum.maps.LatLng(37.566535, 126.97796919999996), // 지도의 중심좌표
                level: 5 // 지도의 확대 레벨
            };

        // 지도를 생성합니다.
        var map = new daum.maps.Map(mapContainer, mapOption);

        // 주소-좌표 변환 객체를 생성합니다.
        var geocoder = new daum.maps.services.Geocoder();
        // 마커를 생성합니다.
       var marker = new daum.maps.Marker({
        position: new daum.maps.LatLng(37.537187, 127.005476),
        map: map
    });


    function sample5_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                var addr = data.address; // 최종 주소 변수

                // 주소 정보를 해당 필드에 넣는다.
                document.getElementById("sample5_address").value = addr;
                // 주소로 상세 정보를 검색
                geocoder.addressSearch(data.address, function(results, status) {
                    // 정상적으로 검색이 완료됐으면
                    if (status === daum.maps.services.Status.OK) {

                        var result = results[0]; //첫번째 결과의 값을 활용

                        // 해당 주소에 대한 좌표를 받아서
                        var coords = new daum.maps.LatLng(result.y, result.x);
                        // 지도를 보여준다.
                        mapContainer.style.display = "block";
                        map.relayout();
                        // 지도 중심을 변경한다.
                        map.setCenter(coords);
                        // 마커를 결과값으로 받은 위치로 옮긴다.
                        marker.setPosition(coords)
                    }
                });
            }
        }).open();
    }

    </script>
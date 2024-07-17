<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js'></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<style>
#calendar {
    width: 80vw;
    height: 80vh;
}

#yrModal {
    position: fixed;
    width: 100%;
    height: 100%;
    background-color: rgba(50, 150, 150, 0.7);
    display: none;
    z-index: 1000;
}
.table-hover {
	border-top: 1px solid #e3e6f0;
    border-bottom: 1px solid #e3e6f0;
}
#cont {
    margin: 50px auto;
    width: 50%;
    height: 70%;
    background-color: darkblue;
    color: yellow;
}
.card-info {
  margin-top: 60px;
  padding: 30px;
  margin-bottom: 30px;
  width: 1530px;
  margin-left: auto;
  margin-right: auto;
  padding-bottom: 0px;
}
.trBackground {
  background-color: #ebf1e9;
  color:black;
}
.menu>td {
	vertical-align: middle !important;
}
.modal.fade {
    transition: opacity .15s linear;
}
.modal.fade.show {
    display: block;
    opacity: 1;
}

.modal.fade.hide {
    opacity: 0;
    display: block;
}
.modal-backdrop {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5);
    opacity: 0;
    transition: opacity .15s linear;
    z-index: 1040; /* Just below the modal's z-index */
}
.modal-backdrop.show {
    opacity: 1;
}
#modal-footer {
	display: flex;
 justify-content: center;
    padding-bottom: 20px;
}
#addBtn, #deleteBtn {
	margin-right:7.5px;
}
#close {
	margin-left:7.5px;
}
</style>
</head>

<body>
<!-- <div id="yrModal"> -->
<!--     <div id="cont" style="text-align: center;"> -->
<!--         <br> -->
<!--         <h1>예린 모달 모달</h1> -->
<!--         시작일 <input type="text" id="schStart" value=""><br> -->
<!--         종료일 <input type="text" id="schEnd" value=""><br> -->
<!--         제목 <input type="text" id="schTitle" value=""><br> -->
<!--         하루종일 <input type="checkbox" id="allDay"><br> -->
<!--         배경색<input type="color" id="schBColor" value=""> -->
<!--         글자색<input type="color" id="schFColor" value=""> -->
<!--         <button onclick="fCalAdd()">추강</button><br> -->
<!--         <button onclick="fMClose()">X</button> -->
<!--     </div> -->
<!-- </div> -->
<div class="col-12 card card-outline card-info">
	<!-- 실제 화면을 담을 영역 -->
	<div id="Wrapper" style="display:flex;">
	    <div class="col-6">
			<h5 style="margin-left:10px; margin-bottom:20px; color:black;">학사일정</h5>
		    <div id='calendar' class="col-12" style="margin-bottom:20px;">
		    	<!-- 캘린더 화면 -->
		    </div>
	    </div>
	    <div id='notice' class="col-6" style="margin-bottom:20px;">
	    	<div style="display:flex; align-items: baseline;">
		    	<h5 style=" margin-bottom: 20px; color:black;">공지사항</h5>
		    	<h6 style="margin-left:570px; cursor:pointer;" onclick="location.href='/commonNotice/list?menuId=annNotIce'">더보기 +</h6>
	    	</div>
	    	<div class="card-body table-responsive p-0" style="height:320px; margin-bottom: 10px;">
	    		<table class="table table-hover text-nowrap text-center">
	    			<thead>
		    			<tr class="trBackground">
		    				<th style="width:15%">구분</th>
		    				<th>제목</th>
		    				<th style="width:25%">작성일</th>
		    			</tr>
	    			</thead>
	   				<tbody>
	   					<c:forEach var="noticeVO" items="${noticeList}" varStatus="stat">
			    			<tr onclick="location.href='/commonNotice/detail?menuId=annNotIce&comNotNo=${noticeVO.comNotNo}'" style="cursor:pointer;">	
			    				<td>${noticeVO.comGubun}</td>
			    				<td class="text-left">${noticeVO.comNotName}</td>
			    				<td>${noticeVO.comFirstDate}</td>
			    			</tr>
		    			</c:forEach>
	    			</tbody>
		   		</table>
	    	</div>
	    	<h5 style="color:black;">주간 식단표</h5>
	    	<div class="card-body table-responsive p-0" style="height:410px; overflow: hidden;">
	    		<table class="table table-bordered text-nowrap text-center">
	    			<thead>
		    			<tr class="trBackground">
		    				<th></th>
		    				<th>월&nbsp;(7/15)</th>
		    				<th>화&nbsp;(7/16)</th>
		    				<th>수&nbsp;(7/17)</th>
		    				<th>목&nbsp;(7/18)</th>
		    				<th>금&nbsp;(7/19)</th>
		    			</tr>
	    			</thead>
	   				<tbody>
	   					<tr class="menu">
	   						<td width="15%" height="170px">점심</td>
	   						<td width="123px">
	   							옥수수밥<br>
								무된장국<br>
								소불고기<br>
								명태코다리강정<br>
								두부&양념장<br>
								배추김치
							</td>
	   						<td width="123px">
	   							차조밥<br>
								콩나물국<br>
								닭볶음탕<br>
								비엔나야채볶음<br>
								야채스틱<br>
								배추김치
							</td>
	   						<td width="123px">
	   							현미밥<br>
	   							두부김치국<br>
								돈탕수육<br>
								자장떡볶이<br>
								양배추쌈/쌈장<br>
								배추김치
							</td>
	   						<td width="123px">
	   							보리혼식밥<br>
								청국장찌개<br>
								갈치구이<br>
								닭가슴살겨자채<br>
								감자채햄볶음<br>
								배추김치
							</td>
	   						<td width="123px">
	   							보리열무비빔밥<br>
								계란후라이<br>
								무된장국<br>
								새우튀김<br>
								떠먹는 요거트<br>
							</td>
	   					</tr>
	   					<tr class="menu" style="font-size:15px;">
	   						<td width="15%" height="170px">저녁</td>
	   						<td width="123px">
	   							마파두부덮밥<br>
								맑은장국<br>
								갈비만두<br>
								돈탕수육<br>
								청경채겉절이<br>
								배추김치
							</td>
	   						<td width="123px">
	   							카레덮밥<br>
								맑은장국<br>
								새우튀김<br>
								콩나물잡채<br>
								두부&양념장<br>
								배추김치
							</td>
	   						<td width="123px">
	   							치즈돈까스<br>
								맑은장국<br>
								팬네파스타<br>
								파인애플샐러드<br>
								배추김치<br>
							</td>
	   						<td width="123px">
	   							날치알비빔밥<br>
								맑은장국<br>
								만두구이<br>
								떡잡채<br>
								미역줄기볶음<br>
								배추김치
							</td>
	   						<td width="123px">
	   							소불고기덮밥<br>
								맑은장국<br>
								핫바<br>
								해초곤약국수<br>
								배추김치
							</td>
	   					</tr>
	    			</tbody>
		   		</table>
	    	</div>
	    </div>
	</div>
</div>
<!-- 모달 -->
<div class="modal fade" id="modal-default" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">일정</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="hideModal()">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="form-group row" style="margin-left: 0px;">
                    <div style="display: inline-block;width: 180px;">
                        <label>시작일</label><br>
                        <input type="date" id="schStart" class="form-control" value="">
                    </div>
                    <div style="margin: 20px;margin-top: 35px;font-weight: 900;">
                        ~
                    </div>
                    <div style="display: inline-block;width: 180px; margin-bottom:15px;">
                        <label>종료일</label><br>
                        <input type="date" id="schEnd" class="form-control" value="">
                    </div>
                </div>
		                일정 <input type="text" id="schTitle" class="form-control" value="" style="margin-bottom:15px;">
            </div>
        </div>
    </div>
</div>
    <script>
    let selectedEvent = null;

    function showModal() {
        const modal = document.getElementById('modal-default');
        const backdrop = document.createElement('div');
        backdrop.classList.add('modal-backdrop', 'fade');
        document.body.appendChild(backdrop);

        setTimeout(() => {
            modal.style.display = 'block';
            modal.classList.add('show');
            modal.classList.remove('hide');
            backdrop.classList.add('show');
        }, 10);
    }

    function hideModal() {
        const modal = document.getElementById('modal-default');
        const backdrop = document.querySelector('.modal-backdrop');

        modal.classList.add('hide');
        modal.classList.remove('show');
        backdrop.classList.remove('show');

        setTimeout(() => {
            modal.style.display = 'none';
            if (backdrop) {
                document.body.removeChild(backdrop);
            }
        }, 150); // This should match the transition duration
    }

    const YrModal = document.querySelector("#modal-default");
    const calendarEl = document.querySelector('#calendar');
    const mySchStart = document.querySelector("#schStart");
    const mySchEnd = document.querySelector("#schEnd");
    const mySchTitle = document.querySelector("#schTitle");
    const mySchBColor = document.querySelector("#schBColor");
    const addBtn = document.querySelector("#addBtn");
    const deleteBtn = document.querySelector("#deleteBtn");

    //캘린더 헤더 옵션
    const headerToolbar = {
    	left: 'prev',
    	center: 'title',
    	right: 'next,today'
    }


    // 캘린더 생성 옵션(참공)
    const calendarOption = {
        // height: '500px', // calendar 높이 설정
        expandRows: true, // 화면에 맞게 높이 재설정
        slotMinTime: '09:00', // Day 캘린더 시작 시간
        slotMaxTime: '18:00', // Day 캘린더 종료 시간
        // 맨 위 헤더 지정
        headerToolbar: headerToolbar,
        // initialView: 'dayGridMonth',  // default: dayGridMonth 'dayGridWeek', 'timeGridDay', 'listWeek'
        locale: 'kr',        // 언어 설정
        selectable: true,    // 영역 선택
        selectMirror: true,  // 오직 TimeGrid view에만 적용됨, default false
        eventDidMount: function(info) {
            // 이벤트의 엘리먼트에 보더 스타일을 직접 설정
            info.el.style.border = 'none';
            // 추가 스타일 적용 가능
            info.el.style.borderRadius = '5px'; // 모서리 둥글게
            info.el.style.boxShadow = '0 2px 5px rgba(0, 0, 0, 0.2)'; // 그림자 추가
        },
        
        dayMaxEventRows: true,  // Row 높이보다 많으면 +숫자 more 링크 보임!

        views: {
            dayGridMonth: {
                dayMaxEventRows: 2
            }
        },

        nowIndicator: true,
        events: function(info, successCallback, failureCallback) {
            $.ajax({
            	url:"/manager/getschduleList",
            	type:"get",
                dataType: "json",
                beforeSend: function(xhr) {
                    xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                },
                success: function(data) {
                	console.log(data)
                    var events = data.map(function(event) {

                        return {
                            id: event.scheNo,
                            title: event.scheName,
                            start: event.scheStrDate,
                            end: event.scheEndDate,
                            color: event.scheColor,
                            "textColor":"black"
                        }
                    });
                    successCallback(events);
                },
                error: function() {
                    failureCallback();
                }
            });
    	}
    }

    console.log("앙 기모띠 >>>> ", calendarOption)

    // 캘린더 생성	
    const calendar = new FullCalendar.Calendar(calendarEl, calendarOption);
    // 캘린더 그리깅
    calendar.render();

    document.querySelector('.fc-prev-button').style.backgroundColor = '#ebf1e9';
    document.querySelector('.fc-prev-button').style.color = 'gray';
    document.querySelector('.fc-prev-button').style.border = 'none';
    document.querySelector('.fc-prev-button').onclick = calendar.removeAllEvents();

    document.querySelector('.fc-next-button').style.backgroundColor = '#ebf1e9';
    document.querySelector('.fc-next-button').style.color = 'gray';
    document.querySelector('.fc-next-button').style.border = 'none';
    document.querySelector('.fc-next-button').style.marginRight = '5px';
    document.querySelector('.fc-next-button').onclick = calendar.removeAllEvents()

    document.querySelector('.fc-today-button').style.backgroundColor = '#ebf1e9';
    document.querySelector('.fc-today-button').style.color = 'black';
    document.querySelector('.fc-today-button').style.border = 'none';
    document.querySelector('.fc-today-button').onclick = calendar.removeAllEvents()

    // 캘린더 이벤트 등록
    calendar.on("eventAdd", info => console.log("Add:", info));
    calendar.on("eventChange", info => console.log("Change:", info));
    calendar.on("eventRemove", info => console.log("Remove:", info));
    calendar.on("eventClick", info => {
        console.log("eClick:", info);

        // 시작일과 종료일 설정
        mySchStart.value = info.event.startStr;
        mySchEnd.value = moment(info.event.endStr).subtract(1, 'days').format('YYYY-MM-DD');

        // 일정 제목, 배경색
        mySchTitle.value = info.event.title;

        // 선택한 이벤트 설정
        selectedEvent = info.event;

        mySchStart.disabled = true;
        mySchEnd.disabled = true;
        mySchTitle.disabled = true;

        showModal();
    });
    </script>
</body>

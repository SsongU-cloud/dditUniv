<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js'></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<style>
    h3 {
        color: black;
        margin-bottom: 30px;
        margin-top: 40px;
        margin-left: 165px;
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
	    justify-content: flex-end;
	    padding-bottom: 20px;
	    margin-right: 20px;
    }

</style>
<div class="col-12">
	
    <h3>학사일정</h3>
    <br>
    <div style="width: 80%; margin: auto;">
        <div class="card" style="margin-bottom: 30px;">
            <div id='calendar' class="col-12" style="margin-top: 30px; padding: 30px;">
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
                    <div style="display: inline-block;width: 180px;">
                        <label>종료일</label><br>
                        <input type="date" id="schEnd" class="form-control" value="">
                    </div>
                </div>
			                일정 <input type="text" id="schTitle" class="form-control" value=""><br>
			                배경색 <input type="color" id="schBColor" value="#ffffff">
            </div>
            <hr width="99%">
            <div id="modal-footer">
                <button type="button" class="btn btn-outline-primary col-2" id="addBtn" onclick="fCalAdd()">등록</button>
                <button type="button" class="btn btn-outline-danger col-2" id="deleteBtn" onclick="fCalDelete()">삭제</button>
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
                dayMaxEventRows: 4
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
        mySchBColor.value = info.event.backgroundColor;

        // 선택한 이벤트 설정
        selectedEvent = info.event;

        // 버튼 표시 설정
        addBtn.style.display = 'none'; // 수정 시 버튼
        deleteBtn.style.display = 'block'; // 삭제 버튼
        
        mySchStart.disabled = true;
        mySchEnd.disabled = true;
        mySchTitle.disabled = true;
        mySchBColor.disabled = true;

        showModal();
    });
    
    calendar.on("eventMouseEnter", info => console.log("eEnter:", info));
    calendar.on("eventMouseLeave", info => console.log("eLeave:", info));
    calendar.on("dateClick", info => console.log("dateClick:", info));
    calendar.on("select", info => {
        console.log("체킁 info:", info);
        console.log("체킁 mySchStart:", mySchStart);

        selectedEvent = null;

        mySchStart.value = info.startStr;
        // 종료일이 시작일과 같다면, 단일 날짜 선택으로 간주하여 동일하게 설정
        if (info.startStr === moment(info.endStr).subtract(1, 'days').format('YYYY-MM-DD')) {
            mySchEnd.value = info.startStr;
        } else {
            // 종료일은 범위 선택의 끝으로 설정
            mySchEnd.value = moment(info.endStr).subtract(1, 'days').format('YYYY-MM-DD');
        }
        mySchTitle.value = "";
        mySchBColor.value = "#ffffff";

		mySchStart.disabled = false;
        mySchEnd.disabled = false;
        mySchTitle.disabled = false;
        mySchBColor.disabled = false;

        addBtn.style.display = 'block';
        deleteBtn.style.display = 'none';

        showModal();
    });

    // 일정(이벤트) 추가/수정하깅
    function fCalAdd() {
    	if (!mySchTitle.value) {
            alert("일정 입력하세요.")
            mySchTitle.focus();
            return;
        }
        let bColor = mySchBColor.value;

        let event = {
            start: mySchStart.value,
            end: moment(mySchEnd.value).add(1, 'days').format('YYYY-MM-DD'),
            title: mySchTitle.value,
            backgroundColor: bColor,
            "textColor":"black"
        };

        if (selectedEvent) {
            selectedEvent.setProp('title', event.title);
            selectedEvent.setProp('start', event.start);
            selectedEvent.setProp('end', event.end);
            selectedEvent.setProp('backgroundColor', event.backgroundColor);
        } else {
        	console.log("event",event)
            
	        $.ajax({
				url:"/manager/insertSchedule",
				contentType:"application/json;charset=utf-8",
				data:JSON.stringify(event),
				type:"post",
				dataType:"text",
				beforeSend: function(xhr) {
	                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	            },
	            success:function(result){
	            	console.log(result)
	            	if(result > 0){
	            		Swal.fire({
	  					  position: "center",
	  					  icon: "success",
	  					  title: "등록완료 되었습니다.",
	  					  showConfirmButton: false,
	  					  timer: 1200
	  					});
	            	}
// 	            	calendar.addEvent(event);
	            }
	        });
        }
        hideModal();
        calendar.removeAllEvents()
        calendar.refetchEvents();
    }

    // 일정(이벤트) 삭제
    function fCalDelete() {
        if (selectedEvent) {
        	console.log("삭제할껑 >> ",selectedEvent)
//         	console.log("삭제할껑 >> ",selectedEvent._def.publicId)

			let data;	

			if(selectedEvent._def.publicId == ""){
				console.log("여기로 오나연??")
				
				data = {
	        		"scheNo":0
	        	}
				
				console.log("아무것도 없을 때 >>> ",data)
			} else {
				data = {
	        		"scheNo":selectedEvent._def.publicId
	        	}
				
				console.log("데이터가 있을 때 >>> ",data)
			}
        	
        	
        	const Toast = Swal.mixin({
                toast: true,
                position: 'center',
                showConfirmButton: false,
                timer: 300000,
            });

            Swal.fire({
            	  title: "삭제하겠습니까?",
            	  icon: "warning",
            	  showCancelButton: true,
            	  confirmButtonColor: "#3085d6",
            	  cancelButtonColor: "#d33",
            	  confirmButtonText: "삭제",
            	  cancelButtonText:"취소"
            	}).then((result) => {
            	  if (result.isConfirmed) {
            		  $.ajax({
                  		url:"/manager/deleteSchedule",
          				contentType:"application/json;charset=utf-8",
          				data:JSON.stringify(data),
          				type:"post",
          				dataType:"text",
          				beforeSend: function(xhr) {
          	                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
          	            },
          	            success:function(result){
          	            	console.log(result)
          	            	if(result > 0){
	          	            	Swal.fire({
	                      	      title: "삭제되었습니다!",
	                      	      icon: "success",
		                      	  showConfirmButton: false,
		  	  					  timer: 1200
	                      	    });
	          	            	selectedEvent.remove();
	          	              	hideModal();
	          	            	calendar.removeAllEvents()
	          	                calendar.refetchEvents();
          	            	}
          	            }
                  	})
            	  }
            	});
            
        } else {
            alert("삭제할 일정이 없습니다.");
        }
    }


</script>
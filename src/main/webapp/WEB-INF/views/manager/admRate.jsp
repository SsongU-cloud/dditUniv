<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-colorschemes"></script>
<style>
* {
	font-family: 'NanumSquareNeo';
}

.card {
	margin: auto;
	max-width: 1323px;
	height: 850px;
}

h3 {
	color: black;
	margin-bottom: 30px;
	margin-top: 40px;
	margin-left: 165px;
}
.selectForm {
	margin: 15px 15px 0px;
}
#myChart1 {
    margin:auto;
}
</style>
<script type="text/javascript">
var myChart1;
$(function(){
   $('#univ').on('change', function(){
      	let univ = $('#univ');
      
		chart(univ.val());
   })
})

function chart(univ){
	
	// 플러그인 등록
    Chart.register(ChartDataLabels);

    // 이미 차트가 존재하면 파괴합니다.
    if (myChart1) {
        myChart1.destroy();
    }

    if(univ == 'D001') {
        // 차트를 새로 생성합니다.
        myChart1 = new Chart(document.getElementById('myChart1'), {
        	type: 'line',
        	 data: {
        	        labels: ['2020', '2021', '2022', '2023', '2024'],
        	        datasets: [
        	            {
        	                label: '기계공학',
        	                data: [60, 58, 59, 60, 57],
        	                borderColor: 'rgba(255,99,132,1)',
        	                backgroundColor: 'rgba(255,99,132,0.2)',
        	                fill: false
        	            },
        	            {
        	                label: '컴퓨터공학',
        	                data: [60, 65, 67, 68, 70],
        	                borderColor: 'rgba(54,162,235,1)',
        	                backgroundColor: 'rgba(54,162,235,0.2)',
        	                fill: false
        	            },
        	            {
        	                label: '전자공학',
        	                data: [55, 60, 63, 64, 61],
        	                borderColor: 'rgba(255,206,86,1)',
        	                backgroundColor: 'rgba(255,206,86,0.2)',
        	                fill: false
        	            },
        	            {
        	                label: '화학공학',
        	                data: [50, 55, 53, 50, 50],
        	                borderColor: 'rgba(75,192,192,1)',
        	                backgroundColor: 'rgba(75,192,192,0.2)',
        	                fill: false
        	            },
        	            {
        	                label: '건축학',
        	                data: [65, 62, 59, 61, 64],
        	                borderColor: 'rgba(153,102,255,1)',
        	                backgroundColor: 'rgba(153,102,255,0.2)',
        	                fill: false
        	            },
        	            {
        	                label: '신소재공학',
        	                data: [47, 50, 50, 46, 48],
        	                borderColor: 'rgba(255,159,64,1)',
        	                backgroundColor: 'rgba(255,159,64,0.2)',
        	                fill: false
        	            }
        	        ]
        	    },
            options: {
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            stepSize: 20 // y축 눈금 간격
                        }
                    }
                },
                plugins: {
                    legend: {
                        labels: {
                            font: {
                                size: 16 // 범례 레이블의 글씨 크기 설정
                            }
                        }
                    },
                    datalabels: {
                        color: '#000000',
                        anchor: 'center',
                        align: 'top',
                        offset: -10,
                        font: {
                            size: 18,
                            weight: 'bold'
                        }
                    }
                }
            }
        });
    } else if(univ == 'D002'){
    	myChart1 = new Chart(document.getElementById('myChart1'), {
	    	type: 'line',
	        data: {
	            labels: ['2020', '2021', '2022', '2023', '2024'],
	            datasets: [
	                {
	                    label: '음악과',
	                    data: [34,30,28,31,30], // 예시 데이터
	                    borderColor: 'rgba(54,162,235,1)',
	                    backgroundColor: 'rgba(54,162,235,1)',
	                    fill: false
	                },
	                {
	                    label: '디자인학과',
	                    data: [40,44,41,43,45], // 예시 데이터
	                    borderColor: 'rgba(255,99,132,1)',
	                    backgroundColor: 'rgba(255,99,132,0.2)',
	                    fill: false
	                },
	                {
	                    label: '무용학과',
	                    data: [31,35,33,35,38], // 예시 데이터
	                    borderColor: 'rgba(255,206,86,1)',
	                    backgroundColor: 'rgba(255,206,86,0.2)',
	                    fill: false
	                },
	                {
	                    label: '회화과',
	                    data: [30,28,31,34,34], // 예시 데이터
	                    borderColor: 'rgba(255,159,64,1)',
	                    backgroundColor: 'rgba(255,159,64,0.2)',
	                    fill: false
	                }
	            ]
	        },
	        options: {
	            scales: {
	                y: {
	                    beginAtZero: true,
	                    ticks: {
	                        stepSize: 10 // y축 눈금 간격
	                    }
	                }
	            },
	            plugins: {
	                legend: {
	                    labels: {
	                        font: {
	                            size: 16 // 범례 레이블의 글씨 크기 설정
	                        }
	                    }
	                },
	                datalabels: {
	                    color: '#000000',
	                    anchor: 'center',
	                    align: 'top',
	                    offset: -10,
	                    font: {
	                        size: 18,
	                        weight: 'bold'
	                    }
	                }
	            }
	        }
	    });
    }
}
 
</script>
<h3>학과 별 입학률 조회</h3>
<div class="card">
	<div class="selectForm" style="display: flex; align-items: baseline;" >
		<select class="form-control col-2" name="univ" id="univ"
			style="margin-right: 30px;">
			<option selected disabled>단과대학</option>
			<c:forEach var="univ" items="${univList}" varStatus="stat">
				<option value="${univ.comCode}">${univ.comCodeName}</option>
			</c:forEach>
		</select>
		<h5 style="margin-left:840px;">(범위 : 5년,&nbsp;&nbsp;단위 : 명)</h5>
	</div>
	<hr>
	<canvas id="myChart1" width="1200" height="700"></canvas>
</div>
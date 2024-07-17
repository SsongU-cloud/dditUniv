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
            console.log(result);
            
            let str = "";
            
            str += `<option selected disabled>학과</option>`;
            $.each(result, function(idx, deptList){
               str += `<option value="\${deptList.comDetCode}">\${deptList.comDetCodeName}</option>`;
            });
            $('#dept').html(str);
         }
      });
   });
   
   $('#dept').on('change', function(){
	      let dept = $('#dept');
	      
	      chart(dept.val());
	   });
});

function chart(dept){
	
	// 플러그인 등록
    Chart.register(ChartDataLabels);

    // 이미 차트가 존재하면 파괴합니다.
    if (myChart1) {
        myChart1.destroy();
    }

    if(dept == 'D001001') {
        // 차트를 새로 생성합니다.
        myChart1 = new Chart(document.getElementById('myChart1'), {
        	 type: 'bar',
        	    data: {
        	        labels: ['2020', '2021', '2022', '2023', '2024'],
        	        datasets: [
        	        	{
        	                label: '1학년 재학',
        	                data: [50, 55, 60, 65, 70],
        	                backgroundColor: 'rgba(54, 162, 235, 0.6)',
        	                stack:'1학년'
        	            },
        	            {
        	                label: '1학년 휴학',
        	                data: [5, 7, 6, 8, 9],
        	                backgroundColor: 'rgba(255, 206, 86, 0.6)',
        	                stack:'1학년'
        	            },
        	            {
        	                label: '1학년 제적',
        	                data: [1, 1, 0, 1, 0],
        	                backgroundColor: 'rgba(255, 99, 132, 0.6)',
        	                stack:'1학년'
        	            },
        	            {
        	                label: '2학년 재학',
        	                data: [48, 53, 58, 63, 68],
        	                backgroundColor: 'rgba(54, 162, 235, 0.8)',
        	                stack:'2학년'
        	            },
        	            {
        	                label: '2학년 휴학',
        	                data: [13, 16, 15, 12, 16],
        	                backgroundColor: 'rgba(255, 206, 86, 0.8)',
        	                stack:'2학년'
        	            },
        	            {
        	                label: '2학년 제적',
        	                data: [2, 2, 1, 1, 2],
        	                backgroundColor: 'rgba(255, 99, 132, 0.8)',
        	                stack:'2학년'
        	            },
        	            {
        	                label: '3학년 재학',
        	                data: [46, 51, 56, 61, 66],
        	                backgroundColor: 'rgba(54, 162, 235, 1.0)',
        	                stack:'3학년'
        	            },
        	            {
        	                label: '3학년 휴학',
        	                data: [8, 7, 5, 8, 9],
        	                backgroundColor: 'rgba(255, 206, 86, 1.0)',
        	                stack:'3학년'
        	            },
        	            {
        	                label: '3학년 제적',
        	                data: [2, 1, 1, 2, 3],
        	                backgroundColor: 'rgba(255, 99, 132, 1.0)',
        	                stack:'3학년'
        	            },
        	            {
        	                label: '4학년 재학',
        	                data: [44, 49, 54, 59, 64],
        	                backgroundColor: 'rgba(54, 162, 235, 0.4)',
        	                stack:'4학년'
        	            },
        	            {
        	                label: '4학년 휴학',
        	                data: [8, 10, 9, 11, 12],
        	                backgroundColor: 'rgba(255, 206, 86, 0.4)',
        	                stack:'4학년'
        	            },
        	            {
        	                label: '4학년 제적',
        	                data: [3, 4, 3, 3, 4],
        	                backgroundColor: 'rgba(255, 99, 132, 0.4)',
        	                stack:'4학년'
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
        	            },
        	            xAxes: [{
        	                stacked: true
        	            }],
        	            yAxes: [{
        	                stacked: true
        	            }]
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
        	                    size: 14,
        	                    weight: 'bold'
        	                }
        	            }
        	        }
        	    }
        });
    } else if(dept == 'D001002'){
    	myChart1 = new Chart(document.getElementById('myChart1'), {
        	type: 'bar',
       	 	data: {
       	        labels: ['2020', '2021', '2022', '2023', '2024'],
       	     datasets: [
	 	        	{
	 	                label: '1학년 재학',
	 	                data: [50, 52, 57, 55, 53],
	 	                backgroundColor: 'rgba(54, 162, 235, 0.6)',
	 	                stack:'1학년'
	 	            },
	 	            {
	 	                label: '1학년 휴학',
	 	                data: [5, 5, 6, 5, 4],
	 	                backgroundColor: 'rgba(255, 206, 86, 0.6)',
	 	                stack:'1학년'
	 	            },
	 	            {
	 	                label: '1학년 제적',
	 	                data: [1, 0, 0, 1, 0],
	 	                backgroundColor: 'rgba(255, 99, 132, 0.6)',
	 	                stack:'1학년'
	 	            },
	 	            {
	 	                label: '2학년 재학',
	 	                data: [52, 54, 50, 49, 51],
	 	                backgroundColor: 'rgba(54, 162, 235, 0.8)',
	 	                stack:'2학년'
	 	            },
	 	            {
	 	                label: '2학년 휴학',
	 	                data: [12, 15, 18, 16, 19],
	 	                backgroundColor: 'rgba(255, 206, 86, 0.8)',
	 	                stack:'2학년'
	 	            },
	 	            {
	 	                label: '2학년 제적',
	 	                data: [2, 2, 1, 1, 2],
	 	                backgroundColor: 'rgba(255, 99, 132, 0.8)',
	 	                stack:'2학년'
	 	            },
	 	            {
	 	                label: '3학년 재학',
	 	                data: [46, 50, 53, 50, 57],
	 	                backgroundColor: 'rgba(54, 162, 235, 1.0)',
	 	                stack:'3학년'
	 	            },
	 	            {
	 	                label: '3학년 휴학',
	 	                data: [8, 7, 5, 8, 9],
	 	                backgroundColor: 'rgba(255, 206, 86, 1.0)',
	 	                stack:'3학년'
	 	            },
	 	            {
	 	                label: '3학년 제적',
	 	                data: [2, 1, 1, 2, 3],
	 	                backgroundColor: 'rgba(255, 99, 132, 1.0)',
	 	                stack:'3학년'
	 	            },
	 	            {
	 	                label: '4학년 재학',
	 	                data: [45, 48, 52, 56, 60],
	 	                backgroundColor: 'rgba(54, 162, 235, 0.4)',
	 	                stack:'4학년'
	 	            },
	 	            {
	 	                label: '4학년 휴학',
	 	                data: [8, 10, 9, 11, 12],
	 	                backgroundColor: 'rgba(255, 206, 86, 0.4)',
	 	                stack:'4학년'
	 	            },
	 	            {
	 	                label: '4학년 제적',
	 	                data: [3, 4, 3, 3, 4],
	 	                backgroundColor: 'rgba(255, 99, 132, 0.4)',
	 	                stack:'4학년'
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
                           size: 16,
                           weight: 'bold'
                       }
                   }
               }
           }
	    });
    }
}
 
</script>
<h3>학과 별 학생 상태</h3>
<div class="card">
	<div class="selectForm" style="display: flex; align-items: baseline;" >
		<select class="form-control col-2" name="univ" id="univ"
			style="margin-right: 30px;">
			<option selected disabled>단과대학</option>
			<c:forEach var="univ" items="${univList}" varStatus="stat">
				<option value="${univ.comCode}">${univ.comCodeName}</option>
			</c:forEach>
		</select>
		<select class="form-control col-2" name="dept" id="dept"
			style="margin-right: 30px;">
			<option selected disabled>학과</option>
		</select>
		<h5 style="margin-left:590px;">(범위 : 5년,&nbsp;&nbsp;단위 : 명)</h5>
	</div>
	<hr>
	<canvas id="myChart1" width="1200" height="700"></canvas>
</div>
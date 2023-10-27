<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Job Korea</title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script src="https://unpkg.com/axios@0.12.0/dist/axios.min.js"></script>
<script src="https://unpkg.com/lodash@4.13.1/lodash.min.js"></script>
<!-- 추가 script -->
<script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
<!-- D3 -->

<script type="text/javascript">

	// 온로드 시, 함수 호출 하여 데이터를 가져오는 작업(데이터가 있는 상태에서 차트 띄워야함)
	$(function() {
		
		unData();		
		chartData();		
	});

	function unData(){
		
		var resultCallback = function(data) {
			console.log("data@@@@@@@@@@@@@@@@@@@@@@@@@@@@@:"+ JSON.stringify(data));
	        
			$("#Unanswered").text(data.getDataUnanswered + " 건");
			$("#Unrefund").text(data.getDataUnrefund + " 건");
			$("#Undeli").text(data.getDataUndeli + " 건");
		};
		
		callAjax("/dashboard/scm/data", "post", "json", true, null, resultCallback);
	}
	
	function chartData(){
		
		var chartCallback = function(returndata) {
			
			// getTotalRefundList 로 받은 데이터 배열 생성
			var refundTotalArray = []; // 빈 배열 생성

				for (var i = 0; i < returndata.getTotalRefundList.length; i++) {
				  var refundTotal = returndata.getTotalRefundList[i].refund_total;
				  refundTotalArray.push(parseInt(refundTotal));
				}
			  console.log(typeof refundTotal); 
			  console.log(refundTotalArray); // [9, 158, 9, 7, 4, 5, 70, 5]
			  
			// getTotalOrderList 로 받은 데이터 배열 생성
			var orderTotalArray = []; // 빈 배열 생성

				for (var i = 0; i < returndata.getTotalOrderList.length; i++) {
				  var orderTotal = returndata.getTotalOrderList[i].order_total;
				  orderTotalArray.push(parseInt(orderTotal));
				}
			  console.log(orderTotalArray); // [191, 999, 132, 83, 80, 34, 322, 28, 3, 3, 1, 1]
			  
			// pro_cd 데이터 배열 생성
			var procdTotalArray = []; // 빈 배열 생성

				for (var i = 0; i < returndata.getTotalOrderList.length; i++) {
				  var procdTotal = returndata.getTotalOrderList[i].pro_cd;
				  procdTotalArray.push(parseInt(procdTotal));
				}
			  console.log(procdTotalArray); // [1, 2, 3, 4, 5, 6, 7, 8, 9, 20, 22, 23]
			
	        apexChart(refundTotalArray, orderTotalArray, procdTotalArray); // 변환된 데이터를 apexChart 함수에 전달
	        console.log(typeof refundTotalArray)
	        console.log(typeof orderTotalArray)
	        console.log(typeof procdTotalArray)
		};
		
		callAjax("/dashboard/scm/chart", "post", "json", true, null, chartCallback);
	}
	

	function apexChart(refundTotalArray, orderTotalArray, procdTotalArray){
	// chart
	
		var options = {
          series: [{
          name: '상품 누적 판매 건수',
          type: 'column',
          data: orderTotalArray.map(function(item) {
        	  return item.toString();
          })
        }, {
          name: '상품 누적 반품 건수',
          type: 'line',
          data: refundTotalArray.map(function(item) {
        	  return item.toString();
          })
        }],
          chart: {
          height: 350,
          type: 'line',
        },
        stroke: {
          width: [1, 2]
        },
        title: {
          text: '상품 누적 판매 및 반품 현황 (상품코드 기준)',
          align: 'center',
     	  style: {
     	      fontSize: '25px'
     	  }
        },
        dataLabels: {
          enabled: true,
          enabledOnSeries: [0, 1]
        },
        labels: procdTotalArray.map(function(item) {
        	  return item.toString();
        }),
        xaxis: {
          type: 'Number'
        },
        yaxis: [{
          title: {
            text: '상품 누적 판매 (건)',
          },
        
        }, {
          opposite: true,
          title: {
            text: '상품 누적 반품 (건)'
          },
          min: 0,   // 최소값 설정
          max: 1000  // 최대값 설정
        }]
        };
	
	// chart를 div에 뿌리기!
          var chart = new ApexCharts(document.querySelector("#chart"), options);
          chart.render();
	}
          
</script>

<style>
	 .unbox {
	 	width: 33%; 
	 	padding: 0 2%; 
	 	border:1px solid #b8b9b94d;
	 	margin : 0 1%;
	 }
	 .undata {
	 	font-size : 13pt;
	 	margin-top: 4%;
	 	text-align: center;
	 	font-weight: bold;
	 	color: #d79540d4;
	 	height: 30px;
    	line-height: 350%;
	 }
	 .undataNum {
	 	height: 100px;
	    font-size: 40pt;
	    line-height: 280%;
	    text-align: center;
	    color : #f58d31;
	 }
</style>

</head>
<body>
	<hr/>
	<div style="height:20px;"></div>
    <div style="display: flex; justify-content: center; width: 100%; height: 200px; ">
        <div id="unanswer" class="unbox">
        	<p class="undata">미응답 1:1 문의 건수</p>
			<p class="undataNum" id="Unanswered"></p>
        </div> 
        <div id="unrefund" class="unbox">
        	<p class="undata">미승인 반품 신청 건수</p>
        	<p class="undataNum" id="Unrefund"></p>
        </div>
        <div id="undeli" class="unbox">
        	<p class="undata">미배송 배송 건수</p>
        	<p class="undataNum" id="Undeli"></p>
        </div>
    </div>
	<div style="height:20px;"></div>
    <div id="chart">
	</div>
</body>
</html>
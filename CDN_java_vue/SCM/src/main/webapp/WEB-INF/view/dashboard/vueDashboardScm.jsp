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

//
//
//
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!이 페이지는 npm만 구현하기로 해서 cdn일때는 하지 않는걸로 중단된 페이지 입니다!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//
//
//
//
//

	/**  new Vue el */
	var dashData;
	var dashChart;
	
	/** onload */
	$(function() {
		
		// Vue
		vueInit()
		
		// SCM 정보
		unData();		
		chartData();		
	});
	
	function vueInit() {
		
		dashData = new Vue({
					el: "#dashData",
				  data: {
					  //style
					  ht1: "height: 20px",
					  unchartSt: {
						  display: "flex",
						  "justify-content": "center",
						  width: "100%",
						  height: "200px",
					  },
					  unbox: {
						  width: "33%",
					 	  padding: "0 2%", 
					 	  border:"1px solid #b8b9b94d",
					 	  margin : "0 1%",
					  },
					  undata: {
						  "font-size": "13pt",
					 	  "margin-top": "4%",
					 	  "text-align": "left",
					 	  "font-weight": "bold",
					 	  color: "#d79540d4",
					 	  height: "30px",
						  "line-height": "350%",
					  },
					  undataNum: {
						  "font-size": "40pt",
						  "text-align": "center",
						  color: "#f58d31",
						  height: "100px",
						  "line-height": "280%",
					  },
					  //v-model
					  Unanswered: "",
					  Unrefund: "",
					  Undeli: "",
				  },
		});
		dashChart: new Vue({
							el: "#dashChart",
					components: {
						apexcharts: VueApexCharts,
					},
						  data: {
							  // 차트의 데이터 시리즈 정의
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
					         // 차트의 외관 및 레이아웃 설정
					         chartOptions: {
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
					               }],
					         },
						  },
		});
	}

	function unData() {
		
		var resultCallback = function(data) {
			
			scmDash.Unanswered = data.getDataUnanswered + " 건";
			scmDash.Unrefund = data.getDataUnrefund + " 건";
			scmDash.Undeli = data.getDataUndeli + " 건";
		};
		callAjax("/dashboard/scm/datavue", "post", "json", true, null, resultCallback);
	}
	
	function chartData() {
		
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
		callAjax("/dashboard/scm/chartvue", "post", "json", true, null, chartCallback);
	}
</script>
</head>

<body>
	<hr/>
	<p>이 페이지는 npm으로만 진행할 것이고,  cdn으로는 작성되지 않았습니다</p>
	<template id="dashData">
		<div :style="ht1"></div>
	    <div :style="unchartSt">
	        <div id="unanswer" :style="unbox">
	        	<p :style="undata">미응답 1:1 문의 건수</p>
				<p :style="undataNum" id="Unanswered" v-model="Unanswered"></p>
	        </div> 
	        <div id="unrefund" :style="unbox">
	        	<p :style="undata">미승인 반품 신청 건수</p>
	        	<p :style="undataNum" id="Unrefund" v-model="Unrefund"></p>
	        </div>
	        <div id="undeli" :style="unbox">
	        	<p :style="undata">미배송 배송 건수</p>
	        	<p :style="undataNum" id="Undeli" v-model="Undeli"></p>
	        </div>
	    </div>
	</template>
	<template id="dashChart">
		<div></div>
	    <div id="chart">
	    	<apexchart type="line" height="350" :options="chartOptions" :series="series"></apexchart>
		</div>
	</template>
</body>
</html>
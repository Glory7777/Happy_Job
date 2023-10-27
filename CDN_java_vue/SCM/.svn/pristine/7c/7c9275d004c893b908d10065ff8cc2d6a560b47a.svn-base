<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>매출 현황</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>

    				
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link rel="stylesheet" type="text/css" href="${CTX_PATH}/css/admin/basic.css" />
<link rel="stylesheet" type="text/css" href="${CTX_PATH}/css/jh_css/style.css" />
<link rel="stylesheet" type="text/css" href="${CTX_PATH}/js/jquery-ui/jquery-ui-1.11.4/jquery-ui.css" />
<link rel="stylesheet" type="text/css" href="${CTX_PATH}/js/jquery-ui/jquery-ui-1.11.4/jquery-ui.min.css" />
<link rel="stylesheet" type="text/css" href="${CTX_PATH}/css/vuecss/bootstrap-datepicker3.css" />
<link rel="stylesheet" type="text/css" href="${CTX_PATH}/css/vuecss/bootstrap-datepicker3.min.css" />
<link rel="stylesheet" type="text/css" href="${CTX_PATH}/css/vuecss/bootstrap-datepicker3.standalone.min.css" />
<link rel="stylesheet" type="text/css" href="${CTX_PATH}/css/vuecss/bootstrap-datepicker3.standalone.css" />
<link rel="stylesheet" type="text/css" href="${CTX_PATH}/js/bootstrap/custom_bootstrap.css" />
<%-- <link rel="stylesheet" type="text/css" href="${CTX_PATH}/js/statistics/css/font-awesome.min.css" /> --%>
<!-- 나눔고딕폰트 import -->
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic+Coding&display=swap" rel="stylesheet">

<script type="text/javascript" charset="utf-8" src="${CTX_PATH}/js/jquery-1.11.2.min.js"></script>
<script type="text/javascript" charset="utf-8" src="${CTX_PATH}/js/underscore-min.js"></script>	
<script type="text/javascript" charset="utf-8" src="${CTX_PATH}/js/jquery-ui/jquery-ui-1.11.4/jquery-ui.js"></script>
<script type="text/javascript" charset="utf-8" src="${CTX_PATH}/js/jquery-ui/jquery-ui-1.11.4/jquery-ui.min.js"></script>
<script type="text/javascript" charset="utf-8" src="${CTX_PATH}/js/jquery.form.min.js"></script>
<!-- 모달팝업 -->
<script type="text/javascript" charset="utf-8" src="${CTX_PATH}/js/global_pub.js"></script>
<script type="text/javascript" charset="utf-8" src="${CTX_PATH}/js/jquery.model.js"></script>
<!-- IE 8 이하에서 HTML5 태그 지원 -->
<script type="text/javascript" charset="utf-8" src="${CTX_PATH}/js/html5shiv.js"></script>
<!-- 공통 스크립트 -->
<script type="text/javascript" charset="utf-8" src="${CTX_PATH}/js/common.js"></script>
<script type="text/javascript" charset="utf-8" src="${CTX_PATH}/js/commonAdd.js"></script>
<script type="text/javascript" charset="utf-8" src="${CTX_PATH}/js/commonAjax.js"></script>

<script type="text/javascript" charset="utf-8" src="${CTX_PATH}/js/stringBuffer.js"></script>

<script type="text/javascript" charset="utf-8" src="${CTX_PATH}/js/jquery.blockUI.js"></script>

<script src="https://cdn.jsdelivr.net/npm/vue@2.6.0"></script>  
<script src="https://unpkg.com/vue-router@3.5.1/dist/vue-router.js"></script>
<script type="text/javascript" src="https://unpkg.com/axios/dist/axios.min.js"></script>

<script type="text/javascript" src="//rawgit.com/wenzhixin/vue-bootstrap-table/develop/docs/static/dist/vue-bootstrap-table.js"></script>
<script type="text/javascript" src="//rawgit.com/wenzhixin/vue-bootstrap-table/develop/docs/static/dist/vue-bootstrap-table.js"></script>

<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/es6-promise@4/dist/es6-promise.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/es6-promise@4/dist/es6-promise.auto.min.js"></script> 

<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>


<!-- 엑셀 다운로드 -->
<script src="${CTX_PATH}/js/table2excel/jquery.table2excel.js"></script>


<script src="https://cdn.jsdelivr.net/npm/chart.js@3.0.0/dist/chart.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@2.0.0"></script>

<script type="text/javascript">
	
	
	// 페이징 설정
	var pageSize = 5;
	var pageBlockSize = 5;

	
	$(function() {
	
		// 세가지 차트에 쓸 데이터 가져오기
		fn_ChartData();
		/* fn_ctChartDetail(); */
	});



	function fn_ChartData(){
		
		var resultCallback = function(data) {

			
			fn_donutChartjs(data.ctSales);
		};
		
		callAjax("/exe/saChart.do", "post", "json", true, null, resultCallback);
		
	}
	
	
	function fn_donutChartjs(data){

		var sales = new Array();

		sales = data;
		
		var projectLabel = [];
        var projectCount = [];
        var percent = [];
        
        var sum = 0; 
        
        for(var i = 0; i< sales.length; i++){
        	
        	projectLabel.push(sales[i].ct_nm);
        	console.log(sales[i].ct_nm);
    		projectCount.push(parseInt(sales[i].ct_total,10).toFixed(1));
    		console.log(sales[i].ct_total);
    		
    		sum += parseInt(sales[i].ct_total,10);
    		
    	}
        
        console.log("합계: " + sum);
		
		var polarArea = document
        .getElementById('polarArea')
        .getContext('2d');
		var myChart = new Chart(polarArea, {
			plugins: [ChartDataLabels],
			type: 'doughnut', // 차트의 형태
            data: { // 차트에 들어갈 데이터
                datasets: [
                    { //데이터
                        cutout: "40%", 
                        label: '매출', 
                        fill: false, 
                        data: projectCount,
                        backgroundColor: [
                            
                            '#30B893',//초록
                            '#ABD904',//연두
                            '#FF7B89',//분홍
                            '#04A2E4',//하늘
                            '#FBD315',//노랑
                            '#9BA4B1',// 회색
                            '#F20574',//진분홍
                            '#FFB4BF',
                            '#FF979D',
                            '#EDEBF0',  
                            '#04D9D9',
                            '#F25C05',
                        ],
                        borderColor: [
                            //경계선 색상
                            'white',
                            'white',
                            'white',
                            'white',
                            'white',
                            'white',
                            'white',
                        ],
                        borderWidth: 4 //경계선 굵기
                        
                    }
                ],
                labels: projectLabel ,
            },
            options: {
                responsive: true,
                plugins:{ 
                	
                	datalabels: { // datalables 플러그인 세팅
                        formatter: function (value, context) {
                        	var per = value/sum*100; 
                        	if (per < 5){
                        		return "";
                        	}
 	                         return  (value/sum*100).toFixed(1) + '%';
                        },
                        font:{size: 20}, // 범례 폰트 사이즈
                        fontColor: 'white',
                	},
                    align: 'top', // 도넛 차트에서 툴팁이 잘리는 경우 사용
            
                    legend: {
                        display: true, // 범례 유무
                        position: 'bottom', // 범례위치
                        align: 'center', // 범례 정렬
                        labels:{
                            margin : 10, // 범례 패딩
                            font:{size: 15}, // 범례 폰트 사이즈
                            fontColor: 'black',
                        }
                    },
                    doughnutlabel: {
                        labels: [
                          {
                            text: '550',
                            font: {
                              size: 20,
                              weight: 'bold',
                            },
                          },
                          {
                            text: 'total',
                          },
                        ],
                    },
                },
                onClick: function(point, event){
                	
                	var clickedObj = sales[event[0]['index']].ct_nm;
                	
                	console.log(clickedObj);
                    
                	fn_ctChartDetail(clickedObj);
                	
                	

                },
            },
            maintainAspectRatio :false,

        });
	}

	function fn_ctChartDetail(data){
		
		var currentPage = currentPage || 1;
		
		console.log(data);
    	
    	var param = {
    			pageSize : pageSize,
    			currentPage : currentPage,
    			ct_nm : data,
    	}
    	
        var listcallback = function(returndata) {
    		
    		$("#selProductList").empty().append(returndata);
    		
    		var totalCnt = $("#totalCnt").val();
    		
    		// 현재 페이지 설정
    		$("#currentPageSelProduct").val(currentPage);
    		
    		// 금액표시 포맷
    		fn_formatCash(); 
    		
    	}
    	
    	callAjax("/exe/selCategory.do", "post", "text", true, param, listcallback); 
		
	}
	
	// 엑셀 다운로드
    function fExcelDownload(tableID, fileID){
    	 $("#"+tableID).table2excel({
    		 exclude: ".noExl",
    		 name: "Excel Document Name",
    		 filename: fileID +'.xls', 
    		 fileext: ".xls",
    		 exclude_img: true,
    		 exclude_links: true,
    		 exclude_inputs: true
    		 });
    }
    

	function fn_selProductChart(data){
		
	    var resetCanvas = function () {
	        $('#lineArea').remove();
	        $('#spChart').append('<canvas id="lineArea"></canvas>');
	    };
	    
		var param = {
    		pro_cd : data
		}
		
		
		var resultCallback = function(returnData) {

			console.log("콜백성공");
			

			var chartArr = new Array();
			
			chartArr = returnData;

			var labelArr = [];
			var dataArr = [];
			
			for(var i = 0; i < chartArr.length; i++){
				labelArr.push(chartArr[i].tMonth);
				dataArr.push(parseInt(chartArr[i].month_profit,10));
			}
			
			// 기존 차트 제거
	        resetCanvas();
			
			const ctx = document.
			getElementById('lineArea').
			getContext('2d');
			
			const lineArea = new Chart(ctx, {
				type: 'line',
				data: {
					labels: labelArr,
					datasets: [{
						label: name,
						data: dataArr,
						borderColor:'rgba(255, 99, 132, 1)',
						borderWidth: 1
					}]
				},

				options: {
				  responsive: true,
				  plugins: {
					legend: {
					  display: false
					}
				  }
				}
			});
			
			
		
		};
		
		callAjax("/exe/selProductChart.do", "post", "json", true, param, resultCallback);
		
	}
	



	

</script>

</head>

<body>
<c:if test="${sessionScope.userType ne 'E'}">
    <c:redirect url="/dashboard/dashboard.do"/>
</c:if>

<form id="myForm" action="" method="">
	<input type="hidden" id="currentPageSales" />
	<input type="hidden" id="selectProductCd"  name="selectProductCd" />
	<input type="hidden" id="currentPageProduct" />
	<input type="hidden" id="currentPageSelProduct" />
	<input type="hidden" id="selectProductCd"  name="selectProductCd" />
	<input type="hidden" id="pro_cd"  name="pro_cd" />
	 
	<div id="wrap_area">
			<h2 class="hidden">header 영역</h2>
			<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>
			<h2 class="hidden">컨텐츠 영역</h2>
			<div id="container">
				<ul>
					<li class="lnb">
						<!-- lnb 영역 --> 
						<jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include>
					</li>
					<li class="contents">
						<!-- contents -->
						<h3 class="hidden">contents 영역</h3> <!-- content -->
						<div class="content">
							<p class="Location">
								<a href="/dashboard/dashboard.do" class="btn_set home">메인으로</a> 
								<a class="btn_nav">기준 정보</a>
								 <span class="btn_nav bold">판매 분석</span> 
								<a href="" class="btn_set refresh">새로고침</a>
							</p>

							<p class="conTitle">
								<span>카테고리별 매출 분석</span>
							</p>
							
							<div id="infoBox" style="margin: 55px 0 0 0; display: flex; flex-direction: row; justify-content: space-between;">
								
								<div id="ctChart" class="canvas" style="height:400px; width:40%">
									<canvas id="polarArea" aria-label="Hello ARIA World" role="img" ></canvas>
								</div>
								
								<div id=tableBox style="width: 55%;">
									
									<table id="salesTable" class="col">
										<caption>caption</caption>
										<colgroup>
											<col width="50%">
											<col width="25%">
											<col width="25%">										
										</colgroup>
	
										<thead>
											<tr>
												<th scope="col">상품명</th>
												<th scope="col">총판매량</th>
												<th scope="col">매출총합</th>
											</tr>
										</thead>
										<tbody id="selProductList"></tbody>
									</table>
									<div class="paging_area" id="selProductPagination"></div>
								</div>
							</div>		
							
							
							<p class="conTitle" style="margin-top: 1%">
								<span>상품별 매출</span> <span class="fr"></span>
							</p>
						
							<div id="spChart" class="canvas"  width="500" height="200">
								<canvas id="lineArea"></canvas>
							</div>
					
							

						</div> <!--// content -->

						<h3 class="hidden">풋터 영역</h3> <jsp:include
							page="/WEB-INF/view/common/footer.jsp"></jsp:include>
					</li>
				</ul>
			</div>
		</div>

</form>

</body>
</html>
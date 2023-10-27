<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>상품별 통계</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->

<!-- chart import -->
<script src="
https://cdn.jsdelivr.net/npm/vue-apexcharts@1.6.2/dist/vue-apexcharts.min.js
"></script>

<!-- 엑셀 다운로드 -->
<script src="${CTX_PATH}/js/table2excel/jquery.table2excel.js"></script>
              
<script type="text/javascript">

	// 페이징 설정
	var pageSize = 5;
	var pageBlockSize = 5;
	
	// 페이징 설정
	var detailPageSize = 5;
	var detailPageBlockSize = 5;
	
	var divProductList;
	var divDetailList;

	$(function() {
		
		vueinit();
		
		// 공지사항 조회
		fn_productList();
		
		fn_pieChart();

		fRegisterButtonClickEvent();
		
	});
	
	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();
	
			var btnId = $(this).attr('id');
	
			switch (btnId) {
				case 'btnClose' :
					gfCloseModal();
					break;
					
			}
		});
	}
	
	function vueinit() {
		
		divProductList = new Vue({
			                  el:"#divProductList",
			              data: {
			            	  datalist:[],
		                      totalcnt:0,
		                      pagingnavi: "",
		                      currentPage:0,
			              } ,
			            methods : {
			            	fn_detail : function(pro_cd) {
			            		//alert("fn_detail : " + pro_cd);
			            		fn_detail(pro_cd);
			            	}
			            	
			            }  
			                  
		});
		
		divDetailList = new Vue({
			            el:"#divDetailList",
			        data: {
			      	   detaillist:[],
			        } 
			      	
			      
			            
				})
		
		chartBox = new Vue({
	        el: '#app',
	        components: {
	          apexchart: VueApexCharts,
	        },
	        data: {
	        inChitChart: {
	          series: [{
	            name: 'Net Profit',
	            data: [44, 55, 57, 56, 61, 58, 63, 60, 66]
	          }]
	         }
	       }
	     })
		
		
	}
	
	 
	/* 상품 리스트 조회 */
    function fn_productList(currentPage) {
    	
		var currentPage = currentPage || 1;
    	
    	var param = {
    			pageSize : pageSize,
    			currentPage : currentPage,
    			searchDel : ""
    	}
    	
       var listcallback = function(returnData) {
    		console.log(returnData);
    		
    		divProductList.datalist = returnData.productList;
    		divProductList.totalcnt = returnData.totalCnt;
    		
    		var paginationHtml = getPaginationHtml(
    						currentPage, 
		    				divProductList.totalcnt, 
		    				pageSize, 
		    				pageBlockSize, 
		    				'fn_productList');
    		console.log("paginationHtml : " + paginationHtml);
    		//swal(paginationHtml);
    		divProductList.pagingnavi = paginationHtml;
    		
    		divProductList.currentPage = currentPage;
    		
    	}
    		// 금액표시 포맷
    		fn_formatCash();
    		
    	
    	callAjax("/exe/productListvue.do", "post", "json", true, param, listcallback);
    	
    }
	
	function fn_pieChart(){
		
    	var param = {
    			
    	}
		
        var seriesArr = [];
        var labelArr = [];
        
		var listcallback = function(productList) {
			
			console.log(JSON.stringify(productList));
			console.log(productList.length);
			
			for(var i = 0; i< productList.length; i++){
				labelArr.push(productList[i].pro_nm);
				seriesArr.push(parseInt(productList[i].total_sales, 10));
			}
			
			 var options = {
					 series: [],
			            chart: {
			            width: 560,
			            type: 'pie',
			            toolbar: {
			                show: true,
			                offsetX: 0,
			                offsetY: 0,
			                tools: {
			                  download: true | '<i class="fas fa-cloud-download-alt" width="20"></i>',
			                  selection: true,
			                  zoom: true,
			                  zoomin: true,
			                  zoomout: true,
			                  pan: true,
			                  reset: true | '<i class="fas fa-redo-alt" width="20"></i>',
			                  customIcons: []
			                },
			                export: {
			                  csv: {
			                    filename: undefined,
			                    columnDelimiter: ',',
			                    headerCategory: 'category',
			                    headerValue: 'value'
			                  }
			                },
			                autoSelected: 'zoom' 
			              },
				
			          },
			          labels: [],
			          responsive: [{
			              breakpoint: 480,
			              options: {
			                chart: {
			                  width: 200
			                },
			                legend: {
			                  position: 'bottom',
			                  formatter: undefined
			                }
			              }
			            }],
			          colors: [ '#FF8080' ,'#FFCF96',
			                    '#F1B4BB' ,
			                    '#F6FDC3' ,'#CDFAD5', 
			                    '#FDF0F0',
			                    '#132043', '#1F4172', 
			                    '#321E1E', '#4E3636', 
			                    '#D83F31' ,
			                    '#241468', '#9F0D7F', 
			                    '#EA1179', '#F79BD3', 
			                    '#E9B824' ,
			                    
			                    ]
			          };
			 		  
			    options.series = seriesArr;
			    options.labels = labelArr;
			 
			 
		        var chart = new ApexCharts(document.querySelector("#chartBox"), options);
		        chart.render();
			 
		}
		callAjax("/exe/productPieChart.do", "post", "json", true, param, listcallback);
	}

    
    /* 상품별 매출 상세 조회 */
    function fn_detail(pro_cd) {
    	
    	var currentPage = currentPage || 1;
    	
    	var param = {
    			pro_cd : pro_cd,
    	}
    	
    	var listcallback = function(returnData) {
    		console.log(returnData);
    		
    		Vue.set(divDetailList, 'detaillist', returnData.dtList);
    		
    	}
    		// 금액표시 포맷
    		fn_formatCash();
    	
    	callAjax("/exe/psDetailvue.do", "post", "json", true, param, listcallback);
    	
    }
    
    

	
	

</script>

</head>

<body>

<form id="myForm" action="" method="">
	<input type="hidden" id="currentPageProduct" />
	<input type="hidden" id="currentPageDetail" />
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
								 <span class="btn_nav bold">상품 정보</span> 
								<a href="" class="btn_set refresh">새로고침</a>
							</p>

							<p class="conTitle" >
								<span>상품 정보</span>
							</p>

							<div class="productList">
								<div class="conTitle" style="margin: 0 25px 10px 0; float: right;">
								</div>
							</div>
							
							<div id="infoBox" style="margin: 55px 0 0 0; display: flex; flex-direction: row; justify-content: space-between;">
								<div id="divProductList" style="width: 55%;">
									<table id="salesTable" class="col">
										<caption>caption</caption>
										<colgroup>
											<col width="50%">
											<col width="10%">
											<col width="20%">
											<col width="20%">										
										</colgroup>
	
										<thead>
											<tr>
												<th scope="col">상품명</th>
												<th scope="col">재고</th>
												<th scope="col">총판매량</th>
												<th scope="col">매출총합</th>
											</tr>
										</thead>
										<tbody id="productList">
											<template v-if="totalcnt == 0">
												<tr>   
													<td colspan=4> 데이터가 업습니다.  </td> 
												</tr>
											</template> 
											<template v-else v-for="product in datalist">
												<tr @click="fn_detail(product.pro_cd)">
													<td>{{product.pro_nm}}</td>						
													<td>{{product.pro_stock}}</td>
													<td>{{product.pro_total_sales_cnt}}</td>
													<td class="cash">{{product.total_sales}}</td>
												</tr>
											</template>		
										</tbody>
									</table>
									<div class="paging_area" id="pagingnavi" v-html="pagingnavi"></div>
								</div>
								<div id="chartBox">
									<apexchart 
									    type="pie"
									    height="350"
									    :options="chartOptions"
									    :series="series">
									</apexchart>
								</div>
							</div>							
							

							

							
							<!-- 디테일 -->
							<p class="conTitle mt50">
								<span>상품별 매출상세</span>
							</p>
							
							<div id="divDetailList" class="divDetailList">
								<table class="col">
									<caption>caption</caption>
									<colgroup>
										<col width="10%">
										<col width="30%">
										<col width="10%">
										<col width="25%">
										<col width="25%">
									</colgroup>
									<thead>
										<tr>
											<th scope="col">주문번호</th>
											<th scope="col">고객명</th>
											<th scope="col">수량</th>
											<th scope="col">거래일</th>
											<th scope="col">거래액</th>
										</tr>
									</thead>
									<tbody id=detail>
										<template v-if="detaillist.length === 0">
											<tr>   
												<td colspan=5> 데이터가 없습니다.  </td> 
											</tr>
										</template>
										<template v-else v-for="detail in detaillist">
											<tr>
												<td>{{detail.order_cd}}</td>						
												<td>{{detail.name}}</td>
												<td>{{detail.order_cnt}}</td>
												<td>{{detail.order_date}}</td>												
												<td class="cash">{{detail.order_price}}</td>
											</tr>
										</template>	
									</tbody>
								</table>
<!-- 								<div class="paging_area" id="detailPagingnavi" v-html="detailPagingnavi"></div> -->
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
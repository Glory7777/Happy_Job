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
<script type="text/javascript" src="${CTX_PATH}/js/apexcharts/apexcharts.js"></script>

<script src="https://cdn.jsdelivr.net/npm/vue-apexcharts@1.6.2/dist/vue-apexcharts.min.js"></script>


<!-- 엑셀 다운로드 -->
<script src="${CTX_PATH}/js/table2excel/jquery.table2excel.js"></script>
              
<script type="text/javascript">

	// 페이징 설정
	var pageSize = 5;
	var pageBlockSize = 5;
	

	// 페이징 설정
	var pageSizeDetail = 5;
	var pageBlockSizeDetail = 5;

	$(function() {
		
		// 공지사항 조회
		fn_productList();
		
		fRegisterButtonClickEvent();
		
		fn_pieChart();
	});
	
	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();
	
			var btnId = $(this).attr('id');
	
			switch (btnId) {
				case 'btnSave' :
					fn_Save();
					break;
				case 'btnSavefile' :	
					fn_Savefile();
					break;					
				case 'btnDelete' :
					fn_Delete();
					break;
				case 'btnClosefile' :	
				case 'btnClose' :
					gfCloseModal();
					if($("#action").val() == "I") {
	    				fn_serachlist();
	    			} else if($("#action").val() == "U") {
	    				fn_serachlist($("#currentPagenotice").val());
	    			} else if($("#action").val() == "D") {
	    				fn_serachlist();
	    			}
					break;
				case 'btnDeletefile' :
					fn_Deletefile();
					break;
					
			}
		});
	}
	
	 
	/* 상품 리스트 조회 */
    function fn_productList(currentPage) {
    	
    	var currentPage = currentPage || 1;
    	
    	var param = {
    			pageSize : pageSize,
    			currentPage : currentPage,
    			searchText : $("#searchText").val()
    	}
    	
       var listcallback = function(returndata) {
    		
    		$("#productList").empty().append(returndata);
    		
    		
    		var totalCnt = $("#totalCnt").val();
    		
    		var paginationHtml = getPaginationHtml(currentPage, totalCnt, pageSize, pageBlockSize, 'fn_productList');
    		//swal(paginationHtml);
    		$("#productPagination").empty().append( paginationHtml );
    		
    		// 현재 페이지 설정
    		$("#currentPageProduct").val(currentPage);
    		
    		// 금액표시 포맷
    		fn_formatCash();
    		
    	}
    	
    	callAjax("/exe/productList.do", "post", "text", true, param, listcallback);
    	
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
    			pageSize : pageSizeDetail,
    			currentPage : currentPage,
    	}
    	
       var listcallback = function(returndata) {
    		console.log(returndata);
    		
    		$("#detail").empty().append(returndata);
    		
    		var totalCntD = $("#dtTotalCnt").val();
    		
    		var paginationHtml = getPaginationHtml(currentPage, totalCntD, pageSizeDetail, pageBlockSizeDetail, 'fn_detail');
    		
    		$("#detailPagination").empty().append( paginationHtml );
    		
    		// 현재 페이지 설정
    		$("#currentPageDetail").val(currentPage);
    		
    		// 금액표시 포맷
    		fn_formatCash();
    		
    	}
    	
    	callAjax("/exe/psDetail.do", "post", "text", true, param, listcallback);
    	
    }
    
    

	
	

</script>

</head>

<body>
<c:if test="${sessionScope.userType ne 'E'}">
    <c:redirect url="/dashboard/dashboard.do"/>
</c:if>

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
<!-- 									<input type="text" style="width: 160px; height: 30px;" id="searchText" name="searchText">
									<a href="" class="btnType blue" id="searchBtn" name="btn"> 
										<span>검 색</span>
									</a>  -->
								</div>
							</div>
							
							<div id="infoBox" style="margin: 55px 0 0 0; display: flex; flex-direction: row; justify-content: space-between;">
								<div id=tableBox style="width: 55%;">
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
										<tbody id="productList"></tbody>
									</table>
									<div class="paging_area" id="productPagination"></div>
								</div>
								<div id="chartBox">
								</div>
							</div>							
							

							

							
							<!-- 디테일 -->
							<p class="conTitle mt50">
								<span>상품별 매출상세</span>
							</p>
							
							<div class="DetailList">
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
										<tr>
											<td colspan="5">상품을 선택해 주세요.</td>
										</tr>
									</tbody>
								</table>
							</div>

							<!-- <div class="paging_area" id="detailPagination"></div> -->
							



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
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
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->
<style>
	input[name=date].datetype{
			padding:4px 2px 5px 25px; width:95px; border:1px solid #CACACA;
     font-size:11px; color:#666; 
     background:url('http://cfile23.uf.tistory.com/image/26100D4F5864C76827F535') no-repeat 2px 2px; background-size:15px
   } 
</style>

<!-- 엑셀 다운로드 -->
<script src="${CTX_PATH}/js/table2excel/jquery.table2excel.js"></script>
              
<script type="text/javascript">

	// 페이징 설정
	var pageSize = 15;
	var pageBlockSize = 5;
	
	// 페이징 설정
	var pageSizeSales = 15;
	var pageBlockSizeSales = 5;
	
	$(function() {
		
		// 공지사항 조회
		fn_ssList();
		
		// 데이트 피커 안씀
		fDatePicker();
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
	 
	/* 매출현황 리스트 조회 */
    function fn_ssList(currentPage) {
    	
    	var currentPage = currentPage || 1;
    	
		var searchStartDate = $("#searchStartDate").val();
		var searchEndDate = $("#searchEndDate").val();
		
		if((searchStartDate !== '' && searchEndDate !== '') && searchEndDate < searchStartDate){
			
			searchEndDate = $("#searchStartDate").val();
			searchStartDate = $("#searchEndDate").val();
			
		}  else if(searchEndDate == searchStartDate){
			
			searchStartDate = $("#searchStartDate").val();
			searchEndDate = $("#searchEndDate").val();
		}
			
    	
    	var param = {
    			pageSize : pageSize,
    			currentPage : currentPage,
    			searchText : $("#searchText").val(),
				searchStartDate : searchStartDate,
				searchEndDate : searchEndDate

    	}
    	
       var listcallback = function(returndata) {
    		console.log(returndata);
    		
    		$("#ssList").empty().append(returndata);
    		
    		console.log($("#totalCnt").val());
    		
    		var totalCnt = $("#totalCnt").val();
    		
    		var paginationHtml = getPaginationHtml(currentPage, totalCnt, pageSizeSales, pageBlockSizeSales, 'fn_ssList');
    		console.log("paginationHtml : " + paginationHtml);
    		
    		//swal(paginationHtml);
    		$("#salesPagination").empty().append( paginationHtml );
    		
    		// 현재 페이지 설정
    		$("#currentPageSales").val(currentPage);
    		
    		$("#searchText").val('');
    		
    		// 금액표시 포맷
    		fn_formatCash();
    		
    	}
    	
    	callAjax("/exe/salesStatusList.do", "post", "text", true, param, listcallback);
    	
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
    


	

</script>

</head>

<body>
<c:if test="${sessionScope.userType ne 'E'}">
    <c:redirect url="/dashboard/dashboard.do"/>
</c:if>

<form id="myForm" action="" method="">
	<input type="hidden" id="currentPageSales" />
	<input type="hidden" id="selectProductCd"  name="selectProductCd" />
	 
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
								 <span class="btn_nav bold">매출 현황</span> 
								<a href="" class="btn_set refresh">새로고침</a>
							</p>

							<p class="conTitle">
								<span>매출 현황</span>
								<span>
									<img src='/images/excel/excel.png' style="height: 50px; width: 50px; margin-left:2%; float:right;" onclick="fExcelDownload('salesTable', '거래 상세 내역');">
								</span>
							</p>

							<div class="ssList">
								<div class="conTitle" style="margin: 0 25px 10px 0; float: right;">
								<label style="margin-right: 10px;">조회 일자</label>
								<input type="date" id="searchStartDate" name="searchStartDate" style="height: 25px;" />-
							    <input type="date" id="searchEndDate" name="searchEndDate" style="height: 25px; margin-right: 10px;" />
									<input type="text" style="width: 160px; height: 30px;" id="searchText" name="searchText">
									<a href="javascript:fn_ssList();" class="btnType blue" id="searchBtn" name="btn"> 
										<span>검 색</span>
									</a> 
								</div>
								<table id="salesTable" class="col">
									<caption>caption</caption>
									<colgroup>
										<col width="10%">
										<col width="24%">
										<col width="13">
										<col width="7%">
										<col width="12%">
										<col width="10%">
										<col width="12%">
										<col width="12%">										
									</colgroup>

									<thead>
										<tr>
											<th scope="col">주문번호</th>
											<th scope="col">제품명</th>
											<th scope="col">주문자</th>
											<th scope="col">환불여부</th>
											<th scopt="col">거래일</th>
											<th scopt="col">수량</th>
											<th scope="col">거래액</th>
											<th scope="col">순수익</th>
										</tr>
									</thead>
									<tbody id="ssList"></tbody>
								</table>
							</div>

							<div class="paging_area" id="salesPagination"></div>



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
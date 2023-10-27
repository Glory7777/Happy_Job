<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>발주 지시서 목록</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->
              
<script type="text/javascript">
	// 페이징 설정
	var pageSize = 10;
	var pageBlockSize = 5;
	
	// 화면이 열리면 바로 실행되는 jQuery
    $(function() {    	
    	
    	// 발주 리스트
    	fn_scmPurchaseList();  
    	
    	// 버튼 이벤트 등록
		fRegisterButtonClickEvent();		
    	
    	// 라디오 버튼
		fn_radio();
	});
	
	
    /** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();
	
			var btnId = $(this).attr('id');
	
			switch (btnId) {				
				case 'btnClose' :
					gfCloseModal();
				    if($("#action").val() == "U") {
	    				fn_serachlist($("#currentPagePurchase").val());
	    			}
					break;					
			}
		});
	}
	
	function fn_scmPurchaseList(currentPage) {
		
		var currentPage=currentPage || 1;
		
		var searchStartDate = $("#searchStartDate").val();
		
		var searchEndDate = $("#searchEndDate").val();
		
		var param = {
				
				pageSize : pageSize,
				currentPage : currentPage,
				searchsel : $("#searchsel").val(),
    			searchtext : $("#searchtext").val(),
    			searchStartDate : searchStartDate,
    			searchEndDate : searchEndDate
		}
		
		var listCallBack = function(returnData) {
			
			console.log(returnData);
			
			$("#scmPurchaseList").empty().append(returnData);
			
			console.log($("#totalCnt").val());
			
			var totalCnt=$("#totalCnt").val();
			
			var paginationHtml = getPaginationHtml(currentPage, totalCnt, pageSize, pageBlockSize, 'fn_scmPurchaseList');
			
			console.log("paginationHtml : "+paginationHtml);
			
			$("#scmPurchasePagination").empty().append(paginationHtml);
			
			// 현재 페이지 설정
			$("#currentPagePurchase").val(currentPage);			
			
		}
		
		callAjax("/scm/scmPurchaseList.do", "post", "text", true, param, listCallBack);
		
	}	
	
	// 라디오버튼
	function fn_radio(){
		
		$('input[name=searchSt]').on('change', function() {
			
		    var selectedRadio = $('input[name=searchSt]:checked').val();
		    
		    if(selectedRadio == 'all'){
		    	
		    	fn_scmPurchaseList();
		    	
		    } else {
		    	fn_scmPurchaseListRadio();
		    }
		});
	}
	
	// 라디오 버튼 클릭시, 해당 발주 목록 조회
	function fn_scmPurchaseListRadio(currentPage) {
		
		var currentPage=currentPage || 1;
		
		var searchStartDate = $("#searchStartDate").val();
		
		var searchEndDate = $("#searchEndDate").val();
		
		var selectedRadio = $('input[name=searchSt]:checked').val();
		
		var param = {
				
				pageSize : pageSize,
				currentPage : currentPage,
				searchsel : $("#searchsel").val(),
    			searchtext : $("#searchtext").val(), 
    			searchStartDate : searchStartDate,
    			searchEndDate : searchEndDate,
    			selectedRadio : selectedRadio
		}
		
		var listCallBack = function(returnData) {
			
			console.log(returnData);
			
			$("#scmPurchaseList").empty().append(returnData);
			
			console.log($("#totalCnt").val());
			
			var totalCnt=$("#totalCnt").val();
			
			var paginationHtml = getPaginationHtml(currentPage, totalCnt, pageSize, pageBlockSize, 'fn_scmPurchaseListRadio');
			
			console.log("paginationHtml : "+paginationHtml);
			
			$("#scmPurchasePagination").empty().append(paginationHtml);
			
			// 현재 페이지 설정
			$("#currentPagePurchase").val(currentPage);			
			
		}
		
		callAjax("/scm/scmPurchaseList.do", "post", "text", true, param, listCallBack);
		
	}	
	
	
	function fn_selectPurchase(pur_cd) {
		
		var param = {				 
				pur_cd : pur_cd
		}
		
		var selectCallBack = function(returnData) {
			
			console.log(JSON.stringify(returnData));		
						
			fn_popupInt(returnData.sectInfo);
			
			gfModalPop("#scmPurchasePop");
			
		}		
		
		callAjax("/scm/selectScmPurchase.do", "post", "json", true, param, selectCallBack);
		
	}
	
	
	 function fn_popupInt(data) {	    			 
		 
		 var pro_unit_price = data.pro_unit_price.toLocaleString();
		 var pur_cnt = data.pur_cnt.toLocaleString();		
		 var pur_total_unit_price = data.pur_total_unit_price.toLocaleString();	
		 var pro_stock = data.pro_stock.toLocaleString();		 
	    	
		$("#action").val("U");
		$("#pur_cd").text(data.pur_cd);
		$("#pro_cd").text(data.pro_cd);
		$("#pro_nm").text(data.pro_nm);
		$("#pro_unit_price").text(pro_unit_price);
		
		$("#pur_cnt").text(data.pur_cnt);
		$("#pur_total_unit_price").text(pur_total_unit_price);
		$("#sup_cd").text(data.sup_cd);
		$("#sup_nm").text(data.sup_nm);
		
		if(data.pur_appr == '0') {
			$("#pur_appr").text('미승인');		
			
		} else if(data.pur_appr == '1') {
			$("#pur_appr").text('승인');		
			
		} else if(data.pur_appr == '2') {
			$("#pur_appr").text('입금 완료');	
			
		} else if(data.pur_appr == '3') {
			$("#pur_appr").text('입고 완료');	
			
		};
		
		$("#pur_nm1").text(data.pur_nm1);
		$("#pur_date").text(data.pur_date);
		
		if(data.admin_nm == null) {			
			$("#admin_nm").text('');			
		} else {			
			$("#admin_nm").text(data.admin_nm);			
		}				
		
		$("#pur_appr_date").text(data.pur_appr_date);
		
		if(data.pur_nm2 == null) {			
			$("#pur_nm2").text('');			
		} else {			
			$("#pur_nm2").text(data.pur_nm2);			
		}		
		
		if(data.pur_dps_date == null) {			
			$("#pur_dps_date").text('');			
		} else {			
			$("#pur_dps_date").text(data.pur_dps_date);			
		}			
		
		if(data.del_nm == null) {			
			$("#del_nm").text('');			
		} else {			
			$("#del_nm").text(data.del_nm);			
		}
		
		if(data.pur_stk_date == null) {			
			$("#pur_stk_date").text('');			
		} else {			
			$("#pur_stk_date").text(data.pur_stk_date);		
		}		
		
		if(data.pur_stk_cnt == 0) {			
			$("#pur_stk_cnt").text('');			
		} else {		
			
			var pur_stk_cnt = data.pro_unit_price.toLocaleString();
			
			$("#pur_stk_cnt").text(pur_stk_cnt);		
		}		
		
		$("#pro_stock").text(pro_stock);		
		 
	} 	   
	


	
</script>

</head>
<body>
<form id="myForm" action=""  method="">
	  <input type="hidden" id="currentPagePurchase" />
	  <input type="hidden" id="action"  name="action" />	 	
	
	
	
	<!-- 모달 배경 -->
	<div id="mask"></div>

	<div id="wrap_area">

		<h2 class="hidden">header 영역</h2>
		<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>

		<h2 class="hidden">컨텐츠 영역</h2>
		<div id="container">
			<ul>
				<li class="lnb">
					<!-- lnb 영역 --> <jsp:include
						page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
				</li>
				<li class="contents">
					<!-- contents -->
					<h3 class="hidden">contents 영역</h3> <!-- content -->
					<div class="content">
						
						<p class="Location">
							<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a>&nbsp;/&nbsp;
							<a href="">작업 지시서</a>&nbsp;/&nbsp;
							<span><strong>발주 지시서 목록</strong></span>
							
							<a href="/scm/purchaseDir.do" class="btn_set refresh">새로고침</a>
                       </p>						
						
						<p class="conTitle">
							<span>발주 지시서 목록</span> 
							<span class="fr">
								<input type="date" id="searchStartDate" name="searchStartDate" style="height: 25px;">&nbsp;~&nbsp;	
								<input type="date" id="searchEndDate" name="searchEndDate" style="height: 25px;">&nbsp;&nbsp;&nbsp;&nbsp;					
															     							    		
							    <select id="searchsel" name="searchsel" style="width:100px;">
							         <option value="">전체</option>
							         <option value="product">상품명</option>
							         <option value="supplier">납품 업체명</option>							         
							    </select>
							    <input type="text" id="searchtext" name="searchtext"  style="width: 150px; height: 25px;" />
							    <a class="btnType blue" href="javascript:fn_scmPurchaseList();" name="modal"><span>검색</span></a>							    
							</span>
						</p>
						<br>
						
						<div style="text-align: right; margin-bottom: 10px;">
							<input type="radio" id="all" name="searchSt" value="all" checked>&nbsp;<label for="all">전체</label>&nbsp;&nbsp;
							<input type="radio" id="unAppr" name="searchSt" value="unAppr">&nbsp;<label for="unAppr">미승인</label>&nbsp;&nbsp;
							<input type="radio" id="appr" name="searchSt" value="appr">&nbsp;<label for="appr">승인</label>&nbsp;&nbsp;
							<input type="radio" id="deposit" name="searchSt" value="deposit">&nbsp;<label for="deposit">입금 완료</label>&nbsp;&nbsp;
							<input type="radio" id="stock" name="searchSt" value="stock">&nbsp;<label for="stock">입고 완료</label>&nbsp;&nbsp;
						</div>
												
						<div class="divComGrpCodList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="7%">
									<col width="16%">
									<col width="10%">
									<col width="7%">
									<col width="10%">
									<col width="10%">
									<col width="13%">
									<col width="10%">
									<col width="10%">		
									<col width="7%">															
								</colgroup>
								
								<thead>
									<tr>
										<th scope="col">발주 코드</th>
										<th scope="col">상품명</th>
										<th scope="col">납품 단가</th>
										<th scope="col">발주 수량</th>
										<th scope="col">총 납품액</th>
										<th scope="col">납품 업체명</th>
										<th scope="col">발주자</th>
										<th scope="col">발주 일자</th>
										<th scope="col">발주 상태</th>
										<th scope="col">상세보기</th>										
									</tr>
								</thead>
								<tbody id="scmPurchaseList"></tbody>
							</table>
						</div>			
	
						<div class="paging_area" id="scmPurchasePagination"></div>
						
						
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>
	
	<!-- // 모달 팝업 -->
	<div id="scmPurchasePop" class="layerPop layerType2" style="width: 1000px;">
		<dl>
			<dt>
				<strong>발주 관련 모든 정보</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>
					<colgroup>
						<col width="120px">
						<col width="*">
						<col width="120px">
						<col width="*">	
						<col width="120px">
						<col width="*">
						<col width="120px">
						<col width="*">					
					</colgroup>

					<tbody>
						<tr>						
							<th scope="row">발주 코드</th>
							<td id="pur_cd">
							</td>
							<th scope="row">상품 코드</th>
							<td id="pro_cd">
							</td>
							<th scope="row">상품명</th>
							<td id="pro_nm">
							</td>
							<th scope="row">납품 단가</th>
							<td id="pro_unit_price">
							</td>
						</tr>
						<tr>						
							<th scope="row">발주 수량</th>
							<td id="pur_cnt">
							</td>
							<th scope="row">총 납품액</th>
							<td id="pur_total_unit_price">
							</td>
							<th scope="row">납품 업체 코드</th>
							<td id="sup_cd">
							</td>
							<th scope="row">납품 업체명</th>
							<td id="sup_nm">
							</td>
						</tr>
						<tr>						
							<th scope="row">발주 상태</th>
							<td id="pur_appr">
							</td>
							<th scope="row">발주자</th>
							<td id="pur_nm1">
							</td>
							<th scope="row">발주 일자</th>
							<td id="pur_date">
							</td>
							<th scope="row">승인자</th>
							<td id="admin_nm">
							</td>
						</tr>
						<tr>						
							<th scope="row">승인 일자</th>
							<td id="pur_appr_date">
							</td>
							<th scope="row">구매 담당자</th>
							<td id="pur_nm2">
							</td>
							<th scope="row">입금 일자</th>
							<td id="pur_dps_date">
							</td>
							<th scope="row">배송 담당자</th>
							<td id="del_nm">
							</td>
						</tr>
						<tr>						
							<th scope="row">입고 일자</th>
							<td id="pur_stk_date">
							</td>
							<th scope="row">입고 수량</th>
							<td id="pur_stk_cnt">
							</td>
							<th scope="row">재고</th>
							<td id="pro_stock" colspan="3">
							</td>						
						</tr>
												
				</table>
				
				<div class="btn_areaC mt30">					
					<a href="" class="btnType gray" id="btnClose" name="btn"><span>닫기</span></a>
				</div>

			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>		
	</div>
	
</form>
</body>
</html>
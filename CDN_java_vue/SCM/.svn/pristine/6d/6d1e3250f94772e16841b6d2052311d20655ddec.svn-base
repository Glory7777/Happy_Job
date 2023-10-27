<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>주문현황 / 반품신청</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->
              
<script type="text/javascript">

	// 페이징 설정
	var pageSize = 10;
	var pageBlockSize = 5;
	
	var searchArea;
	var divRefundHistory;
	var refundHistoryPop;
	
	$(function(){
		
		// 뷰 초기설정
		vueInit();
		
		// 반품현황 목록 조회
		fn_refundHistoryList();
		
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
		
	});
	
	
	// 뷰 초기설정
	function vueInit(){
		
		searchArea = new Vue({
			el : "#searchArea",
			data : {
				searchStartDate : "",
				searchEndDate : "",
			}
		});
		
		divRefundHistory = new Vue({
			el : "#divRefundHistory",
			data : {
				datalist : [],
				totalcnt : 0,
				refundHistoryListPagination : "",
				currentPage : 0,
			}
		});
		
		refundHistoryPop = new Vue({
			el : "#refundHistoryPop",
			data : {
				refundCd : "",
				orderCd : "",
				proModelNm : "",
				proNm : "",
				refundCnt : "",
				refundPrice : "",
				refundDate : "",
				refundText : "",
				refundSt : "",
			}
		});
		
	}
	
	
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
	
	
	// 반품신청 목록 조회
	function fn_refundHistoryList(currentPage){
		
		var currentPage = currentPage || 1;
		
		var searchStartDate = searchArea.searchStartDate;
		var searchEndDate = searchArea.searchEndDate;
		
		if((searchStartDate !== '' && searchEndDate !== '') && searchEndDate < searchStartDate){
			
			searchEndDate = searchArea.searchStartDate;
			searchStartDate = searchArea.searchEndDate;
			
		}  else if(searchEndDate == searchStartDate){
			
			searchStartDate = searchArea.searchStartDate;
			searchEndDate = searchArea.searchEndDate;
		}
		
		var param = {
			pageSize : pageSize,
			currentPage : currentPage,
			searchStartDate : searchStartDate,
			searchEndDate : searchEndDate,
			loginId : '${loginId}'
		}
		
		var listCallback = function(returndata){
			
			divRefundHistory.datalist = returndata.refundHistoryList;
			divRefundHistory.totalcnt = returndata.totalcnt;
			
			var pagenationHtml = getPaginationHtml(currentPage, divRefundHistory.totalcnt, pageSize, pageBlockSize, 'fn_refundHistoryList');
			
			divRefundHistory.refundHistoryListPagination = pagenationHtml;
			
			// 현재페이지 설정
			divRefundHistory.currentPage = currentPage;
			
		}
		
    	callAjax("/cus/vueRefundHistoryList.do", "post", "json", true, param, listCallback);
	}
	
	
	// 모달 팝업
	function fn_refundHistoryDetail(refund_cd, order_cd, pro_nm, pro_model_nm, refund_cnt, refund_date
			, refund_text, refund_st, refund_price) {
		
		var data = {
				refundCd : refund_cd,
				orderCd : order_cd,
				proModelNm : pro_model_nm,
				proNm : pro_nm,
				refundCnt : refund_cnt,
				refundDate : refund_date,
				refundText : refund_text,
				refundSt : refund_st,
				refundPrice : refund_price
		}
		
		// 모달(반품 상세조회)에 내용 집어넣기
		fn_popupInit(data);
		
		// 모달 열기
		gfModalPop("#refundHistoryPop");
	}
	
	// 반품상품 정보
	function fn_popupInit(data){
		
		var refundText = null;
		
		switch(data.refundText){
			case '1' : 
				refundText = '상품 불량';
				break;
			case '2' : 
				refundText = '상품 파손';
				break;
			case '3' : 
				refundText = '상품 오배송';
				break;
			case '4' : 
				refundText = '지연 배송';
				break;
			case '5' : 
				refundText = '상품 불만족';
				break;
			case '6' : 
				refundText = '주문 착오';
				break;
			case '7' : 
				refundText = '기타사유';
				break;
		}
		
		var refundSt = null;
		
		switch(data.refundSt){
		case '0' : 
			refundSt = '반품신청';
			break;
		case '1' : 
			refundSt = '반품 승인';
			break;
		case '2' : 
			refundSt = '수거완료';
			break;
		case '3' : 
			refundSt = '반품 완료';
			break;
		}
		
		// 금액형식으로 바꾸기
		function formatPrice(number) {
		    return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		}

		var moneyformat = formatPrice(data.refundPrice);
		
		refundHistoryPop.refundCd = data.refundCd;
		refundHistoryPop.orderCd = data.orderCd;
		refundHistoryPop.proModelNm = data.proModelNm;
		refundHistoryPop.proNm = data.proNm;
		refundHistoryPop.refundCnt = data.refundCnt;
		refundHistoryPop.refundDate = data.refundDate;
		refundHistoryPop.refundText = refundText;
		refundHistoryPop.refundSt = refundSt;
		refundHistoryPop.refundPrice = moneyformat + "원";
	}
	
	
</script>

</head>
<body>
<form id="myForm" action=""  method="">
	
	<!-- 모달 배경 -->
	<div id="mask"></div>

	<div id="wrap_area">

		<h2 class="hidden">header 영역</h2>
		<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>

		<h2 class="hidden">컨텐츠 영역</h2>
		<div id="container">
			<ul>
				<li class="lnb">
					<!-- lnb 영역 --> <jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
				</li>
				<li class="contents">
					<!-- contents -->
					<h3 class="hidden">contents 영역</h3> <!-- content -->
					<div class="content">

						<p class="Location">
							<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a>
							<span class="btn_nav bold">현황</span> <span class="btn_nav bold">반품 현황</span>
							<a href="/cus/refundHistoryvue.do" class="btn_set refresh">새로고침</a>
						</p>
							
						<p id="searchArea" class="conTitle">
							<span>반품 현황</span> 
							<span class="fr"> 
								<label style="margin-right: 10px; margin-left: 30px;">반품 신청 일자</label><input type="date" id="searchStartDate" v-model="searchStartDate" name="searchStartDate" style="height: 25px;" />
								<label style="margin-right: 10px;">-</label><input type="date" id="searchEndDate"  v-model="searchEndDate" name="searchEndDate" style="height: 25px; margin-right: 30px;" />
							    <a class="btnType blue" href="javascript:fn_refundHistoryList();" name="modal"><span>검색</span></a>
							</span>
						</p>
						
						<div id="divRefundHistory" class="divRefundHistory">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="10%">
									<col width="10%">
									<col width="40%">
									<col width="20%">
									<col width="20%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">반품번호</th>
										<th scope="col">주문 번호</th>
										<th scope="col">상품 명</th>
										<th scope="col">반품 신청 날짜</th>
										<th scope="col">반품 상태</th>
									</tr>
								</thead>
								<tbody>
									<template v-if="totalcnt == 0">
										<tr>
											<td colspan=5> 데이터가 없습니다.</td>
										</tr>
									</template>
									<template v-else v-for="one in datalist">
										<tr style="cursor: pointer;" @click="fn_refundHistoryDetail(one.refund_cd, one.order_cd, one.pro_nm, one.pro_model_nm, one.refund_cnt, one.refund_date
																			, one.refund_text, one.refund_st, one.refund_price)">
											<td>{{ one.refund_cd }}</td>
											<td>{{ one.order_cd}}</td>
											<td>{{ one.pro_nm}}</td>
											<td>{{ one.refund_date}}</td>
											<td v-if="one.refund_st ==='0'" style="color: tomato; font-weight: bold;">반품 신청</td>
											<td v-else-if="one.refund_st ==='1'" style="color: #4ea5d9; font-weight: bold;">반품 승인</td>
											<td v-else-if="one.refund_st ==='2'" style="color: darkgray; font-weight: bold;">수거 완료</td>
											<td v-else-if="one.refund_st ==='3'" style="color: darkgray; font-weight: bold;">반품 완료</td>
										</tr>
									</template>
								</tbody>
							</table>
							
							<div class="paging_area" id="refundHistoryListPagination" v-html="refundHistoryListPagination"> </div>
						</div>
						
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>

	<!--// 모달팝업 -->
	<div id="refundHistoryPop" class="layerPop layerType2" style="width: 1000px;">
		<dl>
			<dt>
				<strong>상세 조회</strong>
			</dt>
			<dd class="content">
				<table class="col">
					<caption>caption</caption>
					<colgroup>
						<col width="8%">
						<col width="8%">
						<col width="15%">
						<col width="20%">
						<col width="8%">
						<col width="13%">
						<col width="10%">
						<col width="10%">
						<col width="8%">
					</colgroup>
					
					<thead>
						<tr>
							<th scope="col">반품 번호</th>
							<th scope="col">주문 번호</th>
							<th scope="col">반품 상품 모델명</th>
							<th scope="col">반품 상품 명</th>
							<th scope="col">반품 수량</th>
							<th scope="col">반품 금액</th>
							<th scope="col">반품 일자</th>
							<th scope="col">반품 사유</th>
							<th scope="col">반품 상태</th>
						</tr>
					</thead>
					
					<tbody>
						<tr>
							<td id="refundCd" v-text="refundCd"></td>
							<td id="orderCd" v-text="orderCd"></td>
							<td id="proModelNm" v-text="proModelNm"></td>
							<td id="proNm" v-text="proNm"></td>
							<td id="refundCnt" v-text="refundCnt">
							<td id="refundPrice" v-text="refundPrice"></td>
							<td id="refundDate" v-text="refundDate"></td>
							<td id="refundText" v-text="refundText"></td>
							<td id="refundSt" v-text="refundSt"></td>
						</tr>
					</tbody>
				</table>

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnClose" name="btn"><span>확인</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop" id="btnClose" name="btn"><span class="hidden">닫기</span></a>
	</div>
	
		
	
</form>
</body>
</html>
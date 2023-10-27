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
	
	$(function(){
		
		// 반품현황 목록 조회
		fn_refundHistoryList();
		
		// 버튼 이벤트 등록
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
	
	// 반품신청 목록 조회
	function fn_refundHistoryList(currentPage){
		
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
			searchStartDate : searchStartDate,
			searchEndDate : searchEndDate
		}
		
		var listCallback = function(returndata){
			console.log("리턴데이터 : " + returndata);
			
			$("#refundHistoryList").empty().append(returndata);
			
			console.log("totalcnt : " + $("#totalcnt").val());
			
			var totalcnt = $("#totalcnt").val();
			
			var pagenationHtml = getPaginationHtml(currentPage, totalcnt, pageSize, pageBlockSize, 'fn_refundHistoryList');
			console.log("pagenationHtml : " + pagenationHtml);
			
			$("#refundHistoryListPagination").empty().append(pagenationHtml);
			
			// 현재페이지 설정
			$("#currentPagenotice").val(currentPage);
			
		}
		
    	callAjax("/cus/refundHistoryList.do", "post", "text", true, param, listCallback);
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
		
		$("#refundCd").text(data.refundCd);
		$("#orderCd").text(data.orderCd);
		$("#proModelNm").text(data.proModelNm);
		$("#proNm").text(data.proNm);
		$("#refundCnt").text(data.refundCnt);
		$("#refundDate").text(data.refundDate);
		$("#refundText").text(refundText);
		$("#refundSt").text(refundSt);
		$("#refundPrice").text(moneyformat + "원");
	}
	
	
</script>

</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" id="currentPagenotice" />
	
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
							<a href="/cus/refundHistory.do" class="btn_set refresh">새로고침</a>
						</p>
							
						<p class="conTitle">
							<span>반품 현황</span> 
							<span class="fr"> 
								<label style="margin-right: 10px; margin-left: 30px;">반품 신청 일자</label><input type="date" id="searchStartDate" name="searchStartDate" style="height: 25px;" />
								<label style="margin-right: 10px;">-</label><input type="date" id="searchEndDate" name="searchEndDate" style="height: 25px; margin-right: 30px;" />
							    <a class="btnType blue" href="javascript:fn_refundHistoryList();" name="modal"><span>검색</span></a>
							</span>
						</p>
						
						<div class="divComGrpCodList">
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
								<tbody id="refundHistoryList"></tbody>
							</table>
						</div>
	
						<div class="paging_area"  id="refundHistoryListPagination"> </div>
						
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
				<!-- s : 여기에 내용입력 -->
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
							<td id="refundCd"></td>
							<td id="orderCd"></td>
							<td id="proModelNm"></td>
							<td id="proNm"></td>
							<td id="refundCnt">
							<td id="refundPrice"></td>
							<td id="refundDate"></td>
							<td id="refundText"></td>
							<td id="refundSt"></td>
						</tr>
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnClose" name="btn"><span>확인</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	
		
	
</form>
</body>
</html>
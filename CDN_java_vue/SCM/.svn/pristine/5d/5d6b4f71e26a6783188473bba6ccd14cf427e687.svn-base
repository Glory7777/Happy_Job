<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>공지사항</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->
              
<script type="text/javascript">
	// 페이징 설정
	var pageSize = 10;
	var pageBlockSize = 5;
	
	$(function() {
		
		// 반품 신청 목록
		fn_refundList();
	
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
		
	});
	
	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();
	
			var btnId = $(this).attr('id');
	
			switch (btnId) {
				case 'btnConfirm' :
					fn_directionConfirm();
					break;
				case 'btnClose' :
					gfCloseModal();
					break;
			}
		});
	}
	
	// 반품 목록 조회
	function fn_refundList(currentPage){
		
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
				searchEndDate : searchEndDate,
				searchSel : $("#searchSel").val(),
				searchText : $("#searchText").val()
		}
		
		var listCallback = function(returndata){
			
			$("#refundList").empty().append(returndata);
			
			var totalcnt = $("#totalcnt").val();
    		var paginationHtml = getPaginationHtml(currentPage, totalcnt, pageSize, pageBlockSize, 'fn_refundList');

    		$("#refundListPagination").empty().append( paginationHtml );
    		
    		$("#currentPagenotice").val(currentPage);
		}
		
    	callAjax("/scm/refundRequestList.do", "post", "text", true, param, listCallback);
	}
	
	
	// 반품지시서 열기
	function fn_refundDirection(refund_cd, pro_mfc, pro_model_nm, pro_nm, refund_date, order_cnt, refund_cnt, refund_price, refund_text){
		
		var data = {
				refundCd : refund_cd,
				proMfc : pro_mfc,
				proModelNm : pro_model_nm,
				proNm : pro_nm,
				refundDate : refund_date,
				orderCnt : order_cnt,
				refundCnt : refund_cnt,
				refundPrice : refund_price,
				refundText : refund_text,
		}
		
		// 모달(반품지시서)에 내용 집어넣기
		fn_popupInit(data);
		
		// 모달 열기
		gfModalPop("#directionPop");
	}
	
	// 반품지시서 모달 팝업
	function fn_popupInit(data){

		var refundText = null;
		
		switch (data.refundText){
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
				refundText = '주문착오';
				break;
			case '7' :
				refundText = '기타 사유';
				break;
		}
		
		// 금액형식으로 바꾸기
		function formatPrice(number) {
		    return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		}

		var moneyformat = formatPrice(data.refundPrice);
		
		$("#refundCd").text(data.refundCd);
		$("#proMfc").text(data.proMfc);
		$("#proModelNm").text(data.proModelNm);
		$("#proNm").text(data.proNm);
		$("#refundDate").text(data.refundDate);
		$("#orderCnt").text(data.orderCnt);
		$("#refundCnt").text(data.refundCnt);
		$("#refundPrice").text(moneyformat + ' 원');
		$("#mocalRefundText").text(refundText);
		
	}
	
	// 반품 승인 요청
	function fn_directionConfirm(){
		
		var param = {
			refundCd : $("#refundCd").text(),
			direcNote : $("#mocalRefundText").text(),
			orderCd : $("#orderCd").val()
		}
		
		var directionConfirmCallback = function(returnData){
			
			if(returnData.result == "success"){
				
				// 왜 에러 뜨는지 모르겠음요.. 실행은 잘 됨..
				swal("승인 요청이 완료 되었습니다.");
				
				gfCloseModal();
				fn_refundList($("#currentPagenotice").val());
			}
		}
		
		callAjax("/scm/directionConfirm.do", "post", "json", true, param, directionConfirmCallback);
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
					<!-- lnb 영역 --> <jsp:include
						page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
				</li>
				<li class="contents">
					<!-- contents -->
					<h3 class="hidden">contents 영역</h3> <!-- content -->
					<div class="content">

						<p class="Location">
							<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a>
							<span class="btn_nav bold">거래내역</span> <span class="btn_nav bold"> 반품 신청 목록</span>
							<a href="/scm/refundList.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>반품 신청 목록</span> 
							<span class="fr"> 
							    <input type="date" id="searchStartDate" name="searchStartDate" style="height: 25px;" />-
							    <input type="date" id="searchEndDate" name="searchEndDate" style="height: 25px; margin-right: 10px;" />
							    <select id="searchSel" name="searchsel" style="width: 100px; height: 27px;" >
							         <option value="">반품 전체</option>
							         <option value="refundCd">반품 코드</option>
							         <option value="proMfc">제조사</option>
							         <option value="proNm">상품 명</option>
							    </select>
							    <input type="text" id="searchText" name="searchtext"  style="width: 150px; height: 25px;" />
							    <a class="btnType blue" href="javascript:fn_refundList();" name="modal"><span>검색</span></a>
							</span>
						</p>
						
						<div class="divComGrpCodList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="7%">
									<col width="8%">
									<col width="10%">
									<col width="25%">
									<col width="11%">
									<col width="8%">
									<col width="8%">
									<col width="13%">
									<col width="10%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">반품코드</th>
										<th scope="col">제조사</th>
										<th scope="col">상품모델명</th>
										<th scope="col">상품명</th>
										<th scope="col">반품신청일</th>
										<th scope="col">주문수량</th>
										<th scope="col">반품수량</th>
										<th scope="col">반품 총 금액</th>
										<th scope="col">반품지시서</th>
									</tr>
								</thead>
								<tbody id="refundList"></tbody>
							</table>
						</div>
	
						<div class="paging_area"  id="refundListPagination"> </div>
						
						
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>

	<!--// 모달팝업 -->
	<div id="directionPop" class="layerPop layerType2" style="width: 1000px;">
		<dl>
			<dt>
				<strong>반품 지시서</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="col">
					<caption>caption</caption>
					<colgroup>
						<col width="10%">
						<col width="20%">
						<col width="30%">
						<col width="40%">
					</colgroup>
					
					<thead>
						<tr>
							<th scope="col">반품코드</th>
							<th scope="col">제조사</th>
							<th scope="col">상품모델명</th>
							<th scope="col">상품명</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td id="refundCd"></td>
							<td id="proMfc"></td>
							<td id="proModelNm"></td>
							<td id="proNm"></td>
						</tr>
					</tbody>
				</table>
				<table class="col">
					<caption>caption</caption>
					<colgroup>
						<col width="30%">
						<col width="20%">
						<col width="20%">
						<col width="40%">
					</colgroup>
					<thead>
						<tr>
							<th scope="col">반품신청일</th>
							<th scope="col">주문수량</th>
							<th scope="col">반품수량</th>
							<th scope="col">반품 총 금액</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td id="refundDate"></td>
							<td id="orderCnt"></td>
							<td id="refundCnt"></td>
							<td id="refundPrice"></td>
						</tr>
					</tbody>
				</table>
				<table class="row">
					<caption>caption</caption>
					<colgroup>
						<col width="30%">
						<col width="70%">
					</colgroup>
					<tbody>
						<tr>
							<th scope="row" style="background: #dce1e6; border: 1px solid #bbc2cd;">반품 신청 이유</th>
							<td id="mocalRefundText" style="border: 1px solid #bbc2cd; text-align: center;"></td>
						</tr>
					</tbody>
					
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnConfirm" name="btn"><span>승인요청</span></a> 
					<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	
</form>
</body>
</html>
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
		
		comcombo("productCD", "searchProCtdt", "all", "");
		comcombo("bankCD", "bankCd", "all", "");
		
		// 주문목록 조회
		fn_orderList();
		
		$(".refund").hide();
		
		// 버튼이벤트 등록
		fn_buttonClickEvent();
		
	});
	
	// 버튼클릭 이벤트
	function fn_buttonClickEvent(){
		$('a[name=btn]').click(function(e) {
			e.preventDefault();
			
			var btnId = $(this).attr("id");
			
			switch (btnId){
				case 'btnRefund' :
					fn_refund();
					break;
				case 'btnClose' :
					fn_modalClose();
					break;
			}
		});
	}
	
	
	// 모달 - 취소
	function fn_modalClose(){
		gfCloseModal();
	}
	
	
	// 모달 - 반품신청 
	function fn_refund(){
		
		// 환불 수량
		var proCd = $("#listRefund").find('input[name=select]:checked').eq(0).val();
		
		var proCdRefundCnt = "#" + proCd + "refundCnt";
		var proCdREfundPrice = "#" + proCd + "refundPrice";

// 		console.log($(proCdREfundPrice).text());
		
		if($("#selectRefundText").val() == 0){
			
			swal("반품사유를 선택해주세요");
			
		} else {
			
	 		var param = {
				orderCd : $("#listRefund").find("td").eq(1).text(),
				proCd : proCd,
				refundCnt : $(proCdRefundCnt).val(),
				refundPrice : $(proCdREfundPrice).text().trim().replace(/,/g, '').replace('원', ''),
				refundText : $("#selectRefundText").val()
			}
		
			var refundCallback = function(returndata){
				console.log(JSON.stringify(returndata));
			
				if(returndata.result == "success"){
					swal("반품신청이 완료 되었습니다.");
					gfCloseModal();
					
					$(".refund").hide();
					
					fn_orderList($("#currentPagenotice").val());
				}
			}
	 		
			callAjax("/cus/refund.do", "post", "json", true, param, refundCallback);
		}
	}
	
	
	// 주문 목록 조회
	function fn_orderList(currentPage){
		
		var currentPage = currentPage || 1;
		
		var searchStartDate = $("#searchStartDate").val();
		var searchEndDate = $("#searchEndDate").val();
		
		if((searchStartDate !== '' && searchEndDate !== '') && searchEndDate < searchStartDate){
			searchEndDate = $("#searchStartDate").val();
			searchStartDate = $("#searchEndDate").val();
			console.log(searchEndDate);
		}  else if(searchEndDate == searchStartDate){
			searchStartDate = $("#searchStartDate").val();
			searchEndDate = $("#searchEndDate").val();
		}
		
		var param = {
			pageSize : pageSize,
			currentPage : currentPage,
			searchText : $("#searchText").val(),
			searchStartDate : searchStartDate,
			searchEndDate : searchEndDate,
			loginId : '${loginId}'
		}
		
		var listCallback = function(returndata){
			console.log("리턴데이터 : " + returndata);
			
			$("#listOrder").empty().append(returndata);
			
			console.log("totalcnt : " + $("#totalcnt").val());
			
			var totalcnt = $("#totalcnt").val();
			
			var pagenationHtml = getPaginationHtml(currentPage, totalcnt, pageSize, pageBlockSize, 'fn_orderList');
			console.log("pagenationHtml : " + pagenationHtml);
			
			$("#orderListPagination").empty().append(pagenationHtml);
			
			// 현재페이지 설정
			$("#currentPagenotice").val(currentPage);
			
		}
		
    	callAjax("/cus/listOrder.do", "post", "text", true, param, listCallback);
	}
	
	
	// 주문목록 상세 조회
	function fn_selectOrderDetail(order_cd){
		
		$(".refund").show();
		
		console.log("order_cd : " + order_cd);
		
		var param = {
				orderCd : order_cd,
		}
		
		var orderDetailCallback = function(orderDetail){
			console.log("상세목록 : " + orderDetail);
			$("#listRefund").empty().append(orderDetail);
			
			// 환불할 상품 선택하지 않았을때, 환불 수량 입력하지 않았을때
			$("#refundBtn").on("click", function(){
				
				var proCd = $("#listRefund").find('input[name=select]:checked').eq(0).val();
				var proCdrefundCnt = "#" + proCd + "refundCnt";
				
				if(proCd === undefined){
					swal("환불할 상품을 선택해주세요.");
				}
				
				if($(proCdrefundCnt).val() == 0){
					swal("환불 수량을 입력해주세요.");
				}
			});
		}
		
		callAjax("/cus/orderDetail.do", "post", "text", true, param, orderDetailCallback)
	}
	
	
	// 환불 수량
	function fn_refundCnt(orderPrice, orderCnt, proCd){
		
		var proCdrefundCnt = "#" + proCd + "refundCnt";
		var proCdrefundPrice = "#" + proCd + "refundPrice";
		var proCdRadio = "#" + proCd + "Select";
		
		var refundCnt = $(proCdrefundCnt).val();
		
		if(orderCnt < refundCnt){
			swal("구매수량보다 큰 값은 입력할 수 없습니다.");
			$(proCdrefundCnt).val(0);
			$(proCdrefundPrice).text('-');
			
		} else if(refundCnt < 0){
			swal("환불 수량을 다시 입력해주세요.");
			$(proCdrefundCnt).val(0);
			$(proCdrefundPrice).text('-');
		} else {

			var refundPrice = Math.round(orderPrice / orderCnt) * refundCnt;
			
			// 금액형식으로 바꾸기
			function formatPrice(number) {
			    return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			}

			var moneyformat = formatPrice(refundPrice);

			$(proCdrefundPrice).text(moneyformat + ' 원');
			
			// 해당 tr의 라디오버튼 자동 선택
			$(proCdRadio).prop("checked", true);
			
		}

		// 선택되지 않은 라디오 버튼 요소
		var unselectedRadios = $("input[name='select']").not(":checked");

		// 선택되지 않은 각 라디오 버튼 처리
		unselectedRadios.each(function() {
		    var unselectedValue = $(this).val(); // 선택되지 않은 라디오 버튼의 값 가져오기
		    
		    var refundPrice = "#" + unselectedValue + "refundPrice";
		    var refundCnt = "#" + unselectedValue + "refundCnt";
		    
		    // 선택 안된 tr 환불수량, 환불 예정금액 초기화
		    $(refundPrice).text('-');
		    $(refundCnt).val(0);
		    
		});
		
		
		// 반품 버튼 눌렀을때 함수 실행
		$("#refundBtn").on("click", function(){
			
			var proCd = $("#listRefund").find('input[name=select]:checked').eq(0).val();
			
			if(proCd === undefined){
				swal("환불할 상품을 선택해주세요.");
				
			}else {
				fn_openPopup();
			}
		});
	}
	
	
	// 모달 팝업
	function fn_openPopup() {
		
		var proCd = $("#listRefund").find('input[name=select]:checked').eq(0).val();
		
		var proCdRefundCnt = "#" + proCd + "refundCnt";
		
		if($(proCdRefundCnt).val() == 0){
			swal("환불수량을 입력해주세요.");
		} else{
			
			var loginId = "${loginId}";
			
			// 계좌정보 조회 위한 Ajax
			var param = {
					loginId : loginId
			}
			
			var userInfoCallback = function(returnData){
// 				console.log("리턴데이터 : " + JSON.stringify(returnData));
				
				fn_popupInit(returnData.orderUserInfo);
				
				gfModalPop("#refundPop");
			}
			
	    	callAjax("/cus/orderUserInfo.do", "post", "json", true, param, userInfoCallback);
		}
	}
	
	
	// 반품상품 정보 모달...???
	function fn_popupInit(data){
		
		$("#selectRefundText").val('0');
		
		var proCd = $("#listRefund").find('input[name=select]:checked').eq(0).val();
		
		var orderCd = $("#listRefund").find('input[name=select]:checked').eq(0).parent().next().text();
		
		var proModelNm = $("#listRefund").find('input[name=select]:checked').eq(0).parent().next().next().text();
		
		var proNm = $("#listRefund").find('input[name=select]:checked').eq(0).parent().next().next().next().text();
		
		var proCdRefundCnt = "#" + proCd + "refundCnt";
		
		var refundCnt = $(proCdRefundCnt).val();
		
		var refundPrice = $("#listRefund").find('input[name=select]:checked').eq(0).parent().next().next().next().next().next().next().next().next().next().text();


		// 금액형식으로 바꾸기
		function formatPrice(number) {
		    return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		}

		var moneyformat = formatPrice(refundPrice);
		
		$("#orderCd").text(orderCd);
		$("#refundProModelNm").text(proModelNm);
		$("#refundProNm").text(proNm);
		$("#refundCntModal").text(refundCnt);
		$("#refundPriceModal").text(moneyformat);
		$("#refundAccount").text(data.account_num);
		$("#bankCd").val(data.bank_cd);
	}
	
	// 배송완료 되지 않은 내역들 상세조회
	function fn_OrderDetail(order_cd){
		
		console.log("order_cd : " + order_cd);
		
		var param = {
			orderCd : order_cd
		}
		
		var orderDetailCallback = function(returnData){
			console.log("상세목록 : " + returnData);
			
			$("#notDeliveryOrderDetailList").empty().append(returnData);
			
			$(".refund").hide();
			gfModalPop("#orderDetailPop");
		}
		
		callAjax("/cus/notDeliveryOrderDetail.do", "post", "text", true, param, orderDetailCallback);
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
							<span class="btn_nav bold">기준정보</span> <span class="btn_nav bold">주문현황/반품신청</span>
							<a href="/cus/refundRequest.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>주문현황/반품신청</span> 
						</p>
							
						<p class="conTitle">
							<span>주문내역</span> 
							<span class="fr"> 
								<label style="margin-right: 10px;">상품명</label><input type="text" id="searchText" name="searchtext" style="width: 200px; height: 25px;" />
								<label style="margin-right: 10px; margin-left: 30px;">주문일자</label><input type="date" id="searchStartDate" name="searchStartDate" style="height: 25px;" />
								<label style="margin-right: 10px;">-</label><input type="date" id="searchEndDate" name="searchEndDate" style="height: 25px; margin-right: 30px;" />
							    <a class="btnType blue" href="javascript:fn_orderList();" name="modal"><span>검색</span></a>
							</span>
						</p>
						
						<div class="divComGrpCodList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="7%">
									<col width="28%">
									<col width="8%">
									<col width="15%">
									<col width="16%">
									<col width="16%">
									<col width="10%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">주문번호</th>
										<th scope="col">주문 상품명</th>
										<th scope="col">총 수량</th>
										<th scope="col">결제금액</th>
										<th scope="col">주문일자</th>
										<th scope="col">배송일자</th>
										<th scope="col">주문현황</th>
									</tr>
								</thead>
								<tbody id="listOrder"></tbody>
							</table>
						</div>
	
						<div class="paging_area"  id="orderListPagination"> </div>
						
						<br><br>
						<div class="refund">
							<p class="conTitle">
								<span>반품신청</span> 
							</p>
							
							<div class="divComGrpCodList">
								<table class="col">
									<caption>caption</caption>
									<colgroup>
										<col width="5%">
										<col width="7%">
										<col width="7%">
										<col width="15%">
										<col width="22%">
										<col width="7%">
										<col width="8%">
										<col width="12%">
										<col width="5%">
										<col width="12%">
									</colgroup>
		
									<thead>
										<tr>
											<th scope="col">선택</th>
											<th scope="col">주문번호</th>
											<th scope="col">상품구분</th>
											<th scope="col">상품 모델 명</th>
											<th scope="col">상품 명</th>
											<th scope="col">제조사</th>
											<th scope="col">주문 수량</th>
											<th scope="col">결제 금액</th>
											<th scope="col">환불 수량</th>
											<th scope="col">환불 예정 금액</th>
										</tr>
									</thead>
									<tbody id="listRefund"></tbody>
								</table>
							</div>
							
							<p style="height: 40px;">
								<span class="fr" style="margin-top: 10px; text-align: center;">
									<a class="btnType blue" id="refundBtn"><span>반품</span></a>
								</span>
							</p>
							
						</div>
						
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>

	<!--// 모달팝업 -->
	<div id="refundPop" class="layerPop layerType2" style="width: 1000px;">
		<dl>
			<dt>
				<strong>반품 신청</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="col">
					<caption>caption</caption>
					<colgroup>
						<col width="10%">
						<col width="20%">
						<col width="30%">
						<col width="10%">
						<col width="30%">
					</colgroup>
					
					<thead>
						<tr>
							<th scope="col">주문번호</th>
							<th scope="col">반품 상품 모델명</th>
							<th scope="col">반품 상품명</th>
							<th scope="col">반품수량</th>
							<th scope="col">반품사유</th>
						</tr>
					</thead>
					
					<tbody>
						<tr>
							<td id="orderCd"></td>
							<td id="refundProModelNm"></td>
							<td id="refundProNm"></td>
							<td id="refundCntModal"></td>
							<td id="refundText">
								<select id="selectRefundText" name="selectRefundText">
									<option value="0">사유 선택</option>
									<option value="1">상품 불량</option>
									<option value="2">상품 파손</option>
									<option value="3">상품 오배송</option>
									<option value="4">지연 배송</option>
									<option value="5">상품 불만족</option>
									<option value="6">주문 착오</option>
									<option value="7">기타사유</option>
								</select>
							</td>
						</tr>
						<tr>
					</tbody>
				</table>
				
				
				<table class="col" style="margin-top: 10px;">
					<caption>caption</caption>
					<colgroup>
						<col width="120px">
						<col width="*">
						<col width="120px">
						<col width="*">
					</colgroup>

					<tbody>
						<tr>
							<th style="background: #dce1e6; border: 1px solid #bbc2cd;">환불 계좌</th>
							<td>
								<select id="bankCd" name="bankCd" disabled style="border:none; appearance:none; text-align: right; margin-right: 10px;"></select>
								<span id="refundAccount"></span>
							</td>
							<th  style="background: #dce1e6; border: 1px solid #bbc2cd;">환불 예정 금액</th>
							<td id="refundPriceModal"></td>
						</tr>
					</tbody>
				</table>
				

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnRefund" name="btn"><span>반품신청</span></a> 
					<a href="" class="btnType gray"  id="btnClose" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	
		<!--// 모달팝업 -->
	<div id="orderDetailPop" class="layerPop layerType2" style="width: 1000px;">
		<dl>
			<dt>
				<strong>주문내역 상세</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="col">
					<caption>caption</caption>
					<colgroup>
						<col width="8%">
						<col width="10%">
						<col width="20%">
						<col width="30%">
						<col width="10%">
						<col width="10%">
						<col width="12%">
					</colgroup>
					
					<thead>
						<tr>
							<th scope="col">주문번호</th>
							<th scope="col">상품구분</th>
							<th scope="col">상품 모델 명</th>
							<th scope="col">상품 명</th>
							<th scope="col">제조사</th>
							<th scope="col">주문 수량</th>
							<th scope="col">결제 금액</th>
						</tr>
					</thead>
					<tbody id="notDeliveryOrderDetailList"></tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue"  id="btnClose" name="btn"><span>확인</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	
</form>
</body>
</html>
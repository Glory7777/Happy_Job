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
	var divOrderList;
	var divRefundList;
	var orderDetailPop;
	var refundPop;
	
	
	$(function(){
		
		// 뷰 초기 설정
		vueInit();
		
		// 주문목록 조회
		fn_orderList();
		
		// 버튼이벤트 등록
		fn_buttonClickEvent();
		
		comcombo("productCD", "searchProCtdt", "all", "");
		comcombo("bankCD", "bankCd", "all", "");
		
	});
	
	
	/** 버튼 이벤트 등록 */
	function fn_buttonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();
	
			var btnId = $(this).attr('id');
	
			switch (btnId) {
				case 'btnRefund' :
					fn_refund();
					break;
				case 'btnClose' :
					gfCloseModal();
					break;
			}
		});
	}
	
	
	// 뷰 초기 설정
	function vueInit(){
		
		searchArea = new Vue({
			el: "#searchArea",
			data: {
				searchText : "",
				searchStartDate : "",
				searchEndDate : "",
			}
		});
		
		divOrderList = new Vue({
			el: "#divOrderList",
			data: {
				datalist :[],
				loginId : "${loginId}",
				totalcnt :0,
				currentPage : 0,
				orderListPagination : "",
			},
			filters:{
				  comma(val){
				  	return String(val).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
				},
			},
			methods : {
				fn_selectOrderDetail : function(order_cd){
					fn_selectOrderDetail(order_cd);
				},
				fn_OrderDetail : function(order_cd){
					fn_OrderDetail(order_cd);
				}
			}
		});
		
		divRefundList = new Vue({
			el : "#divRefundList",
			data : {
				datalist : [],
				vShow : false,
				refundCnt : "",
				refundPrice : "",
				selectedRadio: null,
				orderCd : "",
				proModelNm : "",
				proNm : "",
				proCd : "",
				
			},
			filters:{
				  comma(val){
				  	return String(val).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
				},
			},
			methods : {
				
				updateRefundInfo(one, index) {
					console.log(index);
					
					if (one.order_cnt < one.refundCnt) {
						
						swal("구매수량보다 큰 값은 입력할 수 없습니다.");
		                
						one.refundCnt = "";
						one.refundPrice = "";
						
						
						
					} else if (one.refundCnt < 0) {
						
						swal("반품 수량을 다시 입력해주세요.");
						
						one.refundCnt = "";
						one.refundPrice = "";
		                
		            } else {
		            	
		            	// 금액 형식으로 변경
		            	function formatPrice(number) {
		            		return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
						}
		            	
		            	one.refundPrice = formatPrice(Math.round(one.order_price / one.order_cnt) * one.refundCnt) + " 원";
		            	this.selectedRadio = one.pro_cd; // 선택한 라디오 버튼 설정
		            	
		            	console.log(one.refundPrice);
		            	
		            	divRefundList.refundCnt = one.refundCnt;
		            	divRefundList.refundPrice = one.refundPrice;
		            	divRefundList.orderCd = one.order_cd;
		            	divRefundList.proModelNm = one.pro_model_nm;
		            	divRefundList.proNm = one.pro_nm;
		            	divRefundList.proCd = one.pro_cd;
		            	
		            }
					
					this.datalist.forEach((other, otherIndex) => {
						
						if (otherIndex !== index) {
// 							other.refundCnt = "";
							other.refundPrice = "";
						}
					});
				},
				
				refundCheck(){
					
					if(divRefundList.refundCnt == 0 || divRefundList.refundCnt == ""){
						swal("반품 수량을 입력해주세요.");
					} else{
						fn_openPopup();
					}
				}
			},
		});
		
		orderDetailPop = new Vue({
			el : "#orderDetailPop",
			data : {
				datalist : [],
			},
			filters:{
				  comma(val){
				  	return String(val).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
				},
			},
		});
		
		refundPop = new Vue({
			el : "#refundPop",
			data : {
				orderCd : "",
		 		refundProModelNm : "",
		 		refundProNm : "",
		 		refundCntModal : "",
		 		refundPriceModal : "",
		 		refundAccount : "",
		 		bankCd : "",
		 		selectRefundText : 0,
			},
			filters:{
				  comma(val){
				  	return String(val).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
				},
			},
		})
	}
	
	
	// 주문 목록 조회
	function fn_orderList(currentPage){
		
		var currentPage = currentPage || 1;
		
		var searchStartDate =  searchArea.searchStartDate;
		var searchEndDate =  searchArea.searchEndDate;
		
		if((searchStartDate !== '' && searchEndDate !== '') && searchEndDate < searchStartDate){
			searchEndDate =  searchArea.searchStartDate;
			searchStartDate =  searchArea.searchEndDate;
		}  else if(searchEndDate == searchStartDate){
			searchStartDate =  searchArea.searchStartDate;
			searchEndDate =  searchArea.searchEndDate;
		}
		
		var param = {
			pageSize : pageSize,
			currentPage : currentPage,
			searchText : searchArea.searchText,
			searchStartDate : searchStartDate,
			searchEndDate : searchEndDate,
			loginId : '${loginId}'
		}
		
		var listCallback = function(returndata){
// 			console.log("리턴데이터 : " + JSON.stringify(returndata));
			
			console.log("totalcnt : " + returndata.totalcnt);
			
			divOrderList.datalist = returndata.orderList;
			divOrderList.totalcnt = returndata.totalcnt;
			
			var pagenationHtml = getPaginationHtml(currentPage, divOrderList.totalcnt, pageSize, pageBlockSize, 'fn_orderList');
// 			console.log("pagenationHtml : " + pagenationHtml);
			
			divOrderList.orderListPagination = pagenationHtml;
			divOrderList.currentPage = currentPage;
		}
		
    	callAjax("/cus/vueListOrder.do", "post", "json", true, param, listCallback);
	}

	
	// 배송 완료된 상품 반품신청 div
	function fn_selectOrderDetail(order_cd){
		
		divRefundList.vShow = true;
		
		divRefundList.checked = false;
		divRefundList.refundCnt = 0;
		divRefundList.refundPrice = "-";
		
		var param = {
				orderCd : order_cd,
		}
		
		var orderDetailCallback = function(returndata){
			console.log("상세목록 : " + JSON.stringify(returndata));
			
			divRefundList.datalist = returndata.orderDetailList;
		}
		
		callAjax("/cus/vueOrderDetail.do", "post", "json", true, param, orderDetailCallback)
	}
	
	
	// 배송 중인 상품 주문내역 상세조회 모달
	function fn_OrderDetail(order_cd){
		
		divRefundList.vShow = false;
		
		var param = {
				orderCd : order_cd
			}
			
			var orderDetailCallback = function(returnData){
				
				orderDetailPop.datalist = returnData.notDeliveryOrderDetailList;
				
				gfModalPop("#orderDetailPop");
			}
			
			callAjax("/cus/vueNotDeliveryOrderDetail.do", "post", "json", true, param, orderDetailCallback);
	}
	
	
	// 반품 모달 팝업
	function fn_openPopup() {
		
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
			
	    	callAjax("/cus/vueOrderUserInfo.do", "post", "json", true, param, userInfoCallback);
	}
	
	
	// 반품상품 정보 모달
	function fn_popupInit(data){

		refundPop.orderCd = divRefundList.orderCd;
		refundPop.refundProModelNm = divRefundList.proModelNm;
		refundPop.refundProNm = divRefundList.proNm;
		refundPop.refundCntModal = divRefundList.refundCnt;
		refundPop.refundPriceModal = divRefundList.refundPrice;
		refundPop.refundAccount = data.account_num;
		refundPop.bankCd = data.bank_cd;
	}
	
	
	// 모달 - 반품신청 
	function fn_refund(){
		
		console.log(divRefundList.proCd);
		
		if(refundPop.selectRefundText == 0){
			
			swal("반품사유를 선택해주세요");
			
		} else {
			
	 		var param = {
				orderCd : refundPop.orderCd,
				proCd : divRefundList.proCd,
				refundCnt : refundPop.refundCntModal,
				refundPrice : refundPop.refundPriceModal.trim().replace(/,/g, '').replace('원', ''),
				refundText : refundPop.selectRefundText,
			}
	 		
			var refundCallback = function(returndata){
				console.log(JSON.stringify(returndata));
			
				if(returndata.result == "success"){
					swal("반품신청이 완료 되었습니다.");
					gfCloseModal();
					
					divRefundList.vShow = false;
					
					fn_orderList(divOrderList.currentPage);
				}
			}
	 		
			callAjax("/cus/vueRefund.do", "post", "json", true, param, refundCallback);
		}
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
							<span class="btn_nav bold">기준정보</span> <span class="btn_nav bold">주문현황/반품신청</span>
							<a href="/cus/refundRequestvue.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>주문현황/반품신청</span> 
						</p>
							
						<p id="searchArea" class="conTitle">
							<span>주문내역</span> 
							<span class="fr"> 
								<label style="margin-right: 10px;">상품명</label><input type="text" id="searchText" name="searchText" v-model="searchText" style="width: 200px; height: 25px;" />
								<label style="margin-right: 10px; margin-left: 30px;">주문일자</label><input type="date" id="searchStartDate" name="searchStartDate" v-model="searchStartDate" style="height: 25px;" />
								<label style="margin-right: 10px;">-</label><input type="date" id="searchEndDate" name="searchEndDate" v-model="searchEndDate" style="height: 25px; margin-right: 30px;" />
							    <a class="btnType blue" href="javascript:fn_orderList();" name="modal"><span>검색</span></a>
							</span>
						</p>
						
						<div id="divOrderList" class="divOrderList">
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
								<tbody>
									<template v-if="totalcnt == 0">
										<tr>
											<td colspan="7">데이터가 존재하지 않습니다.</td>
										</tr>
									</template>
									<template v-else v-for="one in datalist">
										<tr>
											<td>{{ one.order_cd }}</td>
											<td v-if="one.deli_st === '2' && one.order_st === '1'" @click="fn_selectOrderDetail(one.order_cd)">{{ one.pro_nm }}</td>
											<td v-else @click="fn_OrderDetail(one.order_cd)">{{ one.pro_nm }}</td>
											<td>{{ one.order_cnt }}</td>
											<td>{{ one.order_price | comma }} 원</td>
											<td>{{ one.order_date }}</td>
											<td>{{ one.order_hope_date }}</td>
											<td v-if="one.deli_st == null || one.order_st === '0'" style="color:black; font-weight: bold;">주문 완료</td>
											<td v-else-if="one.deli_st === '0'" style="color:blue; font-weight: bold;">배송준비중</td>
											<td v-else-if="one.deli_st === '1'" style="color:green; font-weight: bold;">배송중</td>
											<td v-else-if="one.deli_st === '2'" style="color:#9c3b3b; font-weight: bold;">배송완료</td>
										</tr>
									</template>
								</tbody>
							</table>
							
							<div class="paging_area"  id="orderListPagination" v-html="orderListPagination"> </div>
							
						</div>
						
						<br><br>
						<div class="divRefundList" id="divRefundList" v-show="vShow">
							<p class="conTitle">
								<span>반품신청</span> 
							</p>
							
							<div>
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
											<th scope="col">반품 수량</th>
											<th scope="col">환불 예정 금액</th>
										</tr>
									</thead>
									<tbody>
										<tr v-for="(one, index) in datalist">
											<td v-if="one.refund_yn === '0'">
												<input type="radio" :id="one.pro_cd" name="select" class="select" :value="one.pro_cd" v-model="selectedRadio"/>
											</td>
											<td v-else-if="one.refund_yn === '1'" style="font-size: 11px; color: tomato;">
												<input type="radio" name="select" disabled/>
											</td>
											<td><label :for="one.pro_cd">{{ one.order_cd }}</label></td>
											<td><label :for="one.pro_cd">{{ one.ct_nm }}</label></td>
											<td><label :for="one.pro_cd">{{ one.pro_model_nm }}</label></td>
											<td><label :for="one.pro_cd">{{ one.pro_nm }}</label></td>
											<td><label :for="one.pro_cd">{{ one.pro_mfc }}</label></td>
											<td><label :for="one.pro_cd">{{ one.order_cnt }}</label></td>
											<td><label :for="one.pro_cd">{{ one.order_price | comma }} 원</label></td>
											<template v-if="one.refund_yn === '0'">
												<td>
													<input type="number" style="height:25px; width: 50px;" :max="one.order_cnt" min="0" v-model="one.refundCnt" @input="updateRefundInfo(one, index)">
												</td>
												<td>
													<span :id="one.pro_cd + 'refundPrice'" class="refundPrice" v-text="one.refundPrice"></span>
												</td>
											</template>
											<template v-if="one.refund_yn === '1'">
												<td style="font-weight: bold; color: darkgray;">{{ one.refund_cnt }}</td>
												<td style="font-weight: bold; color: darkgray;">{{ one.refund_price | comma}} 원</td>
											</template>
										</tr>
									</tbody>
								</table>
							</div>
							
							<p style="height: 40px;">
								<span class="fr" style="margin-top: 10px; text-align: center;">
									<a class="btnType blue" id="refundBtn" @click="refundCheck"><span>반품</span></a>
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
							<td id="orderCd" v-text="orderCd"></td>
							<td id="refundProModelNm" v-text="refundProModelNm"></td>
							<td id="refundProNm" v-text="refundProNm"></td>
							<td id="refundCntModal" v-text="refundCntModal"></td>
							<td id="refundText">
								<select id="selectRefundText" name="selectRefundText" v-model="selectRefundText">
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
								<select id="bankCd" name="bankCd" v-model="bankCd" disabled style="border:none; appearance:none; text-align: right; margin-right: 10px;"></select>
								<span id="refundAccount" v-text="refundAccount"></span>
							</td>
							<th  style="background: #dce1e6; border: 1px solid #bbc2cd;">환불 예정 금액</th>
							<td id="refundPriceModal" v-text="refundPriceModal"></td>
						</tr>
					</tbody>
				</table>
				

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnRefund" name="btn"><span>반품신청</span></a> 
					<a href="" class="btnType gray" id="btnClose" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop" id="btnClose" name="btn"><span class="hidden">닫기</span></a>
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
					<tbody>
						<tr v-for="one in datalist">
							<td>{{ one.order_cd }}</td>
							<td>{{ one.ct_nm }}</td>
							<td>{{ one.pro_model_nm }}</td>
							<td>{{ one.pro_nm }}</td>
							<td>{{ one.pro_mfc }}</td>
							<td>{{ one.order_cnt }}</td>
							<td>{{ one.order_price | comma }} 원</td>
						</tr>
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

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
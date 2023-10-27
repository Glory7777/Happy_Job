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
	
	var searchArea;
	var divRefundDirectionList;
	var directionPop;
	
	$(function() {
		
		// 라디오 체크여부
		fn_radio();
		
		// 뷰 초기설정
		vueInit();
		
		// 반품 지시서 목록
		fn_refundDirectionList();
		
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
		
		// 공통코드
		comcombo("bankCD", "bankCd", "all", "");
		
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
	
	// 뷰 초기설정
	function vueInit(){
		
		searchArea = new Vue({
			el : "#searchArea",
			data : {
				searchStartDate : "",
				searchEndDate : "",
				searchsel : "",
				searchText : "",
				selectedRadio : "",
			}
		});
		
		divRefundDirectionList = new Vue({
			el : "#divRefundDirectionList",
			data : {
				datalist : [],
				totalcnt : 0,
				refundListPagination : "",
				currentPage : 0,
			},
			methods : {
				fn_refundDirectionDetail : function(order_cd, loginid, pro_nm, bank_cd, account_num, refund_cnt, refund_price, refund_text){
					fn_refundDirectionDetail(order_cd, loginid, pro_nm, bank_cd, account_num, refund_cnt, refund_price, refund_text);
				}
			}
		});
		
		directionPop = new Vue({
			el : "#directionPop",
			data : {
				orderCd : "",
				refundUserNm : "",
				bankCd : "",
				refundAccount : "",
				proNm : "",
				refundCnt : "",
				refundPrice : "",
				refundText : "",
			}
		});
	}
	
	
	// 반품 지시서 목록 조회
	function fn_refundDirectionList(currentPage){
		
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
				searchSel : searchArea.searchsel,
				searchText : searchArea.searchText,
		}
		
		var listCallback = function(returndata){
			console.log(JSON.stringify(returndata));
			
			divRefundDirectionList.datalist = returndata.pcmRefundDirectionList;
			divRefundDirectionList.totalcnt = returndata.totalcnt;
			
    		var paginationHtml = getPaginationHtml(currentPage, divRefundDirectionList.totalcnt, pageSize, pageBlockSize, 'fn_refundDirectionList');

//     		console.log("paginationHtml : " + paginationHtml);
    		
    		divRefundDirectionList.refundListPagination = paginationHtml;
    		
    		divRefundDirectionList.currentPage = currentPage;
    		
    		$('input[type=radio][id="all"]').prop('checked', true);
		}
		
    	callAjax("/pcm/vuePcmRefundDirectionList.do", "post", "json", true, param, listCallback);
	}
	
	// 라디오버튼
	function fn_radio(){
		
		$('input[name=refundSt]').on('change', function() {
			
			searchArea.selectedRadio = $('input[name=refundSt]:checked').val();
		    
		    if(searchArea.selectedRadio == ''){
		    	
		    	fn_refundDirectionList();
		    	
		    } else {
		    	fn_selectedRadio();
		    }
		});
	}
	
	// 라디오버튼 체크시 반품 지시서 목록 조회
	function fn_selectedRadio(currentPage){
		
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
			
		searchArea.selectedRadio = $('input[name=refundSt]:checked').val();
		    
		    var param = {
		    		pageSize : pageSize,
					currentPage : currentPage,
					searchStartDate : searchStartDate,
					searchEndDate : searchEndDate,
					searchSel : searchArea.searchsel,
					searchText : searchArea.searchText,
					selectedRadio : searchArea.selectedRadio,
			}
			
			var listCallback = function(returndata){
		    	console.log(JSON.stringify(returndata));
				
		    	divRefundDirectionList.datalist = returndata.pcmRefundDirectionList;
				divRefundDirectionList.totalcnt = returndata.totalcnt;
				
	    		var paginationHtml = getPaginationHtml(currentPage, divRefundDirectionList.totalcnt, pageSize, pageBlockSize, 'fn_refundDirectionList');

	    		divRefundDirectionList.refundListPagination = paginationHtml;
	    		
	    		divRefundDirectionList.currentPage = currentPage;
	    		
	    		searchArea.searchText = "";
			}
			
	    	callAjax("/pcm/vuePcmRadioRefDirecList.do", "post", "json", true, param, listCallback);
	}
	
	// 반품지시서 상세 조회
	function fn_refundDirectionDetail(order_cd, loginid, pro_nm, bank_cd, account_num, refund_cnt, refund_price, refund_text){
		
		var data = {
				orderCd : order_cd, 
				loginId : loginid,
				proNm : pro_nm,
				bankCd : bank_cd,
				accountNum : account_num,
				refundCnt : refund_cnt,
				refundPrice : refund_price,
				refundText : refund_text
		}
		
		// 모달에 값 집어넣기 
		fn_popupInit(data);
		
		// 모달 열기
		gfModalPop("#directionPop");
	}
	
	// 반품지시서 상세내역 모달
	function fn_popupInit(data){
	
		// 반품 사유
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
		
		directionPop.orderCd = data.orderCd;
		directionPop.refundUserNm = data.loginId;
		directionPop.bankCd = data.bankCd;
		directionPop.refundAccount = data.accountNum;
		directionPop.proNm = data.proNm;
		directionPop.refundCnt = data.refundCnt;
		directionPop.refundPrice = moneyformat + " 원";
		directionPop.refundText = refundText;
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
					<!-- lnb 영역 --> <jsp:include
						page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
				</li>
				<li class="contents">
					<!-- contents -->
					<h3 class="hidden">contents 영역</h3> <!-- content -->
					<div class="content">

						<p class="Location">
							<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a>
							<span class="btn_nav bold">납품업체</span> <span class="btn_nav bold"> 반품 지시서 목록</span>
							<a href="/pcm/refundPurchase.do" class="btn_set refresh">새로고침</a>
						</p>

						<p id="searchArea" class="conTitle">
							<span>반품 지시서 목록</span> 
							<span class="fr"> 
							    <label style="margin-right: 10px;">반품 신청 일자</label><input type="date" id="searchStartDate" name="searchStartDate" v-model="searchStartDate" style="height: 25px;" />-
							    <input type="date" id="searchEndDate" name="searchEndDate" v-model="searchEndDate" style="height: 25px; margin-right: 10px;" />
							    <select id="searchSel" name="searchsel" v-model="searchsel" style="width: 100px; height: 27px;" >
							         <option value=""> 전체</option>
							         <option value="refundUserNm">반품 신청 고객</option>
							         <option value="proNm">상품 명</option>
							    </select>
							    <input type="text" id="searchText" name="searchText" v-model="searchText" style="width: 150px; height: 25px;" />
							    <a class="btnType blue" href="javascript:fn_refundDirectionList();" name="modal"><span>검색</span></a>
							</span>
						</p>
						
						<div style="margin-bottom: 10px; text-align: right;">
							<input type="radio" id="all" name="refundSt" value="" checked/> <label for="all" style="margin-right: 10px;">전체</label>
							<input type="radio" id="confirm" name="refundSt" value="confirm" /> <label for="confirm" style="margin-right: 10px;">승인</label>
							<input type="radio" id="notConfirm" name="refundSt" value="notConfirm" /> <label for="notConfirm" style="margin-right: 10px;">미승인</label>
							<input type="radio" id="stockPlus" name="refundSt" value="stockPlus" /> <label for="stockPlus">입고처리</label>
						</div>
						
						<div id="divRefundDirectionList" class="divRefundDirectionList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="10%">
									<col width="15%">
									<col width="35%">
									<col width="20%">
									<col width="20%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">반품코드</th>
										<th scope="col">반품 신청 고객</th>
										<th scope="col">반품 상품 명</th>
										<th scope="col">반품 신청 일자</th>
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
										<tr @click="fn_refundDirectionDetail(one.order_cd, one.loginid, one.pro_nm, one.bank_cd, one.account_num, one.refund_cnt
																			, one.refund_price, one.refund_text)" style="cursor: pointer;">
											<td>{{ one.refund_cd }}</td>
											<td>{{ one.loginid }}</td>
											<td>{{ one.pro_nm }}</td>
											<td>{{ one.refund_date }}</td>
											<td v-if="one.refund_st === '0'" style="color: tomato; font-weight: bold;">미승인</td>
											<td v-else-if="one.refund_st === '1'" style="color: #4ea5d9; font-weight: bold;">반품 승인</td>
											<td v-else-if="one.refund_st === '2'" style="color: darkgray; font-weight: bold;">입고처리</td>
										</tr>
									</template>
								</tbody>
							</table>
							
							<!-- 페이징 처리  -->
							<div class="paging_area" id="refundListPagination" v-html="refundListPagination"> </div>
							
						</div>
	
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
				<strong>반품 지시서 상세내역</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="col">
					<caption>caption</caption>
					<colgroup>
						<col width="10%">
						<col width="20%">
						<col width="70%">
					</colgroup>
					
					<thead>
						<tr>
							<th scope="col">주문번호</th>
							<th scope="col">반품 신청 고객</th>
							<th scope="col">은행/계좌번호</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td id="orderCd" v-text="orderCd"></td>
							<td id="refundUserNm" v-text="refundUserNm"></td>
							<td>
								<select id="bankCd" name="bankCd" v-model="bankCd" disabled style="border:none; appearance:none; text-align: right; margin-right: 10px;"></select>
								<span id="refundAccount" v-text="refundAccount"></span>
							</td>
						</tr>
					</tbody>
				</table>
				
				<table class="col">
					<caption>caption</caption>
					<colgroup>
						<col width="40%">
						<col width="20%">
						<col width="20%">
						<col width="20%">
					</colgroup>
					<thead>
						<tr>
							<th scope="col">상품 명</th>
							<th scope="col">반품 수량</th>
							<th scope="col">반품 총 금액</th>
							<th scope="col">반품 사유</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td id="proNm" v-text="proNm"></td>
							<td id="refundCnt" v-text="refundCnt"></td>
							<td id="refundPrice" v-text="refundPrice"></td>
							<td id="refundText" v-text="refundText"></td>
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
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>주문 정보 리스트</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->

              
<script type="text/javascript">
	// 페이징 설정
	var pageSize = 10;
	var pageBlockSize = 5;
	
	var searchArea;
	var orderList;
	var orderPop;
	var deliDirection;
	
	// 화면이 열리면 바로 실행되는 jQuery
    $(function() {    
    	
    	vueInit();
    	
    	// 주문 리스트
    	fn_orderList();
    	
    	// 버튼 이벤트 등록
		fRegisterButtonClickEvent();	
    	
    	/*  $("#searchDel").change(function(){
    		 fn_orderList();
         });
    	 
    	 $("#searchPur").change(function(){
    		 fn_orderList();
           }); */
		
	});
	
    /** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();
	
			var btnId = $(this).attr('id');
	
			switch (btnId) {				
				case 'btnClose' :
					gfCloseModal();
				   
				    fn_orderList(orderList.currentPage);
	    			
					break;					
			}
		});
	}
	
	function vueInit() {
		
		searchArea = new Vue({
							
								el : "#searchArea",							
							data : {								
								searchsel : "",
				            	searchtext : "",
				            	searchStartDate : "",
				            	searchEndDate : "",
				            	searchDel : false,
				            	searchPur : false
							},
						methods : {
							fn_orderList : function() {			            		
								fn_orderList();
			            	},
			            	noDel : function() {
			            		
			            		fn_orderList();			            		
			            	},
			            	noPur : function() {
			            		
			            		fn_orderList();
			            	}
			            }			
			
		});
		
		orderList = new Vue({
			
								el : "#orderList",							
							data : {								
								dataList : [],
								totalCnt:0,
				                pagingNavi: "",
				                currentPage:0								
							},
						methods : {
							fn_selectOrder : function(order_cd, pro_cd) {			            		
								fn_selectOrder(order_cd, pro_cd);
			            	},
			            	fn_selectDelivery : function(order_cd, pro_cd) {			            		
			            		fn_selectDelivery(order_cd, pro_cd);
			            	}
			            	
			            }							
		
		});
		
		orderPop =new Vue({
								
								el : "#orderPop",							
								data : {	
									action : "I",
									
									order_cd : "",
									pro_cd : "",
									pro_nm : "",
									pro_unit_price : "",
									order_cnt : "",
									pro_stock : "",
									pur_cnt : "",
									sup_select : ""														
								},
							methods : {
								fn_Save : function() {			            		
									fn_Save();
				            	}
				            	
				            }			
		});
		
		deliDirection =new Vue({
			
									el : "#deliDirection",							
									data : {	
										action : "I",
										
										order_cd : "",
										pro_cd : "",
										order_date : "",
										loginid : "",
										pro_nm2 : "",
										order_cnt : "",
										order_cnt2 : "",
										order_cnt3 : "",		// 주문 개수
										pro_stock2 : "",	// 재고 개수												
										pro_stock3 : "",		// 재고 - 주문 개수
										
										delCheck : "",		// 재고가 부족하지 않아 주문할 수 있는 상태 ('on'일 때)
										vPlus : true
								}
					
		});		
		
	}
	
	function fn_orderList(currentPage) {
		
		var currentPage=currentPage || 1;
		
		var param = {
				
				pageSize : pageSize,
				currentPage : currentPage,
				searchsel : searchArea.searchsel,
    			searchtext : searchArea.searchtext,
    			searchDel : searchArea.searchDel,
    			searchPur : searchArea.searchPur,
    			searchStartDate : searchArea.searchStartDate,
    			searchEndDate : searchArea.searchEndDate
		}
				
		var listCallBack = function(returnData) {
			
			console.log(JSON.stringify(returnData));
			
			orderList.dataList = returnData.orderList;
			orderList.totalCnt = returnData.totalCnt;	
			
			var paginationHtml = getPaginationHtml(currentPage, orderList.totalCnt, pageSize, pageBlockSize, 'fn_orderList');
			
			console.log("paginationHtml : "+paginationHtml);
			
			orderList.pagingNavi = paginationHtml;
    		
			orderList.currentPage = currentPage;		
			
		}
		
		callAjax("/scm/orderListvue.do", "post", "json", true, param, listCallBack);
		
	}	
	
	
	function fn_selectOrder(order_cd, pro_cd) {
		
		var param = {
				order_cd : order_cd, 
				pro_cd : pro_cd
		}
		
		var selectCallBack = function(returnData) {
			
			console.log(JSON.stringify(returnData));		
						
			fn_popupInt(returnData.sectInfo);
			
			gfModalPop("#orderPop");
			
		}		
		
		callAjax("/scm/orderSelect.do", "post", "json", true, param, selectCallBack);
		
	}
	
	
	 function fn_popupInt(data) {	    	
	    
		 orderPop.order_cd = data.order_cd;
		 orderPop.pro_cd = data.pro_cd;		 
		 orderPop.pro_nm = data.pro_nm;
		 orderPop.pro_unit_price = data.pro_unit_price;
		 orderPop.order_cnt = data.order_cnt;
		 orderPop.pro_stock = data.pro_stock;
		 orderPop.pur_cnt = data.pur_cnt;
		 orderPop.sup_select = data.sup_select;		
		 		
		selectComCombo("cli", "sup_select", "sel", data.pro_cd, "");				
	} 
	 
	 
	 function fn_Save() {
		 
		 if(!fValidate()) {
			 return;			 
		 }		 		 
		 
		 var param = {	
				 order_cd : orderPop.order_cd,
				 pro_cd : orderPop.pro_cd,				 
				 pur_cnt : orderPop.pur_cnt,				 				 
				 sup_cd : $("#sup_select").val(),
				 
				 action : orderPop.action
		 }		
		 
		 var saveCallBack = function(returnValue) {
			 
			 console.log(JSON.stringify(returnValue));
			 
			 if(returnValue.result == "SUCCESS") {
				 
				 alert("발주 지시서 작성 완료");
				 gfCloseModal();
				 
				 fn_orderList(orderList.currentPage);
			 } 			 
		 }
		 
		 callAjax("/scm/purchaseSave.do", "post", "json", true, param, saveCallBack);	
		 
	 }	    	    	
		   
	    
	/** 저장 validation */
	function fValidate() {

		var chk = checkNotEmpty(
				[
						[ "pur_cnt", "수량을 입력해 주세요." ]
					,	[ "sup_select", "납품 업체를 선택해 주세요." ]			]
		);

		if (!chk) {
			return;
		}

		return true;
	}

///////////////////////////////////////////////////배송 지시서 작성//////////////////////////////////////////////////////////////////////////////////
	function fn_selectDelivery(order_cd, pro_cd) {
		
		var param = {
				order_cd : order_cd, 
				pro_cd : pro_cd
		}
		
		var selectCallBack = function(res) {
			
			console.log(JSON.stringify(res));		
						
			fn_popupIntDelivery(res.selectDelivery);
			
			gfModalPop("#deliDirection");
			
		}		
		
		callAjax("/scm/selectDelivery.do", "post", "json", true, param, selectCallBack);
		
	}
	
	
	 function fn_popupIntDelivery(data) {	    	
		console.log(data);
		
		deliDirection.order_cd = data.order_cd
		deliDirection.pro_cd = data.pro_cd;
		deliDirection.order_date = data.order_date;
		deliDirection.loginid = data.loginid;
		deliDirection.pro_nm2 = data.pro_nm;
		deliDirection.order_cnt2 = data.order_cnt;
		deliDirection.order_cnt3 = data.order_cnt;
		deliDirection.pro_stock2 = data.pro_stock;
		 
		 /* $("#delivery_tbody").children().remove(); */
		 
		 deliDirection.pro_cd = data.pro_cd;
		 /* $("#deliveryPlusBtn").show(); */
	}
	
	 function fn_deliveryPlus(){
		 
		/*  var pro_cd = $("#pro_cd").val();
		 var pro_nm = $("#pro_nm2").text(); */
		 var pro_stock = parseInt(deliDirection.pro_stock2);
		 var order_cnt = parseInt(deliDirection.order_cnt3);		
			 
		 console.log("pro_stock: "+ pro_stock);
		 console.log("order_cnt: "+ order_cnt);
		 
		 if(pro_stock < order_cnt){
			 alert("재고가 부족합니다.");
			 return;
		 }else{
			 deliDirection.delCheck = "on";
		 }
		 
		/*  var html = 
		"<tr>" +
		"<td id='pro_cd'>"+pro_cd+"</td>"+
		"<td id='pro_nm'>"+pro_nm+"</td>"+
		"<td><input type='text' class='inputTxt p100' id='order_cnt4' value='"+order_cnt+"'/></td>"+
		"<td><a class='btnType gray' href='javascript:fn_deleteDelivery()' id='deleteShppingBtn' name='deleteShppingBtn'><span>삭제</span></a></td>"
		+"</tr>"
		;
		
		$("#delivery_tbody").append(html); */		
		
		/* $("#pro_stock2").val(pro_stock - order_cnt); */
		
		deliDirection.pro_stock3 = pro_stock - order_cnt;
		
		deliDirection.vPlus = false;
		
		/* $("#deliveryPlusBtn").hide(); */
	 }
	 
	 function fn_deleteDelivery(){
		 /* $("#delivery_tbody").children().remove(); */
		 
		 deliDirection.delCheck = "";
		 
		 deliDirection.pro_stock = deliDirection.pro_stock2;
		 deliDirection.order_cnt = deliDirection.order_cnt3;
		 
		 /* deliDirection.pro_stock2 = deliDirection.pro_stock + deliDirection.order_cnt; */
		 
		 deliDirection.vPlus = true;
		 
		 /* $("#deliveryPlusBtn").show(); */
		 
	 }
	 
	 function fn_saveDelivery(){
			 
		 	/* var order_cnt4 = $("#order_cnt4").val();
		 	console.log(order_cnt4); */
		 	if(deliDirection.delCheck == ''){
		 		alert("상품을 추가해주세요.");
		 		return;
		 	} else{
		 		
		 	}
		 
			var param = {
					order_cd : deliDirection.order_cd,
					pro_cd : deliDirection.pro_cd,
					deli_cnt : deliDirection.order_cnt2,
					//////////////
	    			
	    			/* order_hope_date : $("#order_hope_date").val(), */
	    	}
			console.log("param: " + JSON.stringify(param));
			
	    	
	    	var savecallback = function(res) {
	    		console.log(JSON.stringify(res));
	    		
	    		if(res.result == "SUCCESS") {
	    			alert("작성 완료되었습니다.");
	    			gfCloseModal();
	    			fn_updateProductStock(); //재고감소
	    			
	    			fn_orderList(orderList.currentPage);
	    			
	    			deliDirection.delCheck = '';
	    			deliDirection.vPlus =true;
	    		}else{
	    			alert("주문 실패.");
	    			gfCloseModal();
	    			
	    			fn_orderList(orderList.currentPage);
	    		}
	    		
	    	}
	    	
	    	callAjax("/scm/saveDelivery.do", "post", "json", true, param, savecallback);
			
		}
	 	
	 function fn_updateProductStock(){		 
		 	
			/* var pro_stock2 = $("#pro_stock2").val();	
		 	console.log("pro_stock2: " + pro_stock2); */
		 
			var param = {
					pro_cd : deliDirection.pro_cd,
					pro_stock : deliDirection.pro_stock3
	    	}
			
			console.log("param: " + JSON.stringify(param));
			
	    	
	    	var savecallback = function(res) {
	    		console.log(JSON.stringify(res));
	    		
	    		if(res.result == "SUCCESS") {
	    			alert("재고 업데이트되었습니다.");
	    			fn_orderList(orderList.currentPage);
	    		}else{
	    			alert("재고 업데이트 실패.");
	    			fn_orderList(orderList.currentPage);
	    		}
	    		
	    	}
	    	
	    	callAjax("/scm/updateProductStock.do", "post", "json", true, param, savecallback);
			
	}
	 	

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	

	
</script>

</head>
<body>
<form id="myForm" action=""  method="">
	  <input type="hidden" id="currentPagenotice" />
	  <input type="hidden" id="action"  name="action" />
	  <input type="hidden" id="pro_cd" name="pro_cd" />
	  <input type="hidden" id="sup_cd" name="sup_cd" />
	  <input type="hidden" id="order_cd" name="order_cd" />
	 
	
	
	
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
							<a href="">거래내역</a>&nbsp;/&nbsp;
							<span><strong>일별 수주 내역</strong></span>
							
							<a href="/scm/dailyOrderHistory.do" class="btn_set refresh">새로고침</a>
                       </p>
                       <div id="searchArea">
						<p class="conTitle">  
							<span>일별 수주 내역</span> 
							<span class="fr">
								<input type="date" id="searchStartDate" name="searchStartDate" v-model="searchStartDate" style="height: 25px;">&nbsp;~&nbsp;	
								<input type="date" id="searchEndDate" name="searchEndDate" v-model="searchEndDate" style="height: 25px;">&nbsp;&nbsp;&nbsp;&nbsp;					
							     							    		
							    <select id="searchsel" name="searchsel" v-model="searchsel" style="width:100px;">
							         <option value="">전체</option>
							         <option value="product">상품명</option>
							         <option value="customer">기업 고객명</option>							         
							    </select>
							    <input type="text" id="searchtext" name="searchtext" v-model="searchtext" style="width: 150px; height: 25px;" />
							    <a class="btnType blue" @click="fn_orderList();" name="modal"><span>검색</span></a>							    
							</span> 													
						</p>
						<br>
						
						<label style="display: flex; justify-content: flex-end;">
							<input type="checkbox" name="searchDel" id="searchDel" v-model="searchDel" @change="noDel()">&nbsp;<span>미배송</span>&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="checkbox" name="searchPur" id="searchPur" v-model="searchPur" @change="noPur()">&nbsp;<span>미발주</span>&nbsp;&nbsp;&nbsp;&nbsp;
						</label>	
						</div>	
						
						<div id="orderList">
						<div class="divComGrpCodList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="5%">
									<col width="10%">
									<col width="9%">
									<col width="19%">									
									<col width="5%">
									<col width="5%">
									<col width="11%">
									<col width="7%">
									<col width="10%">
									<col width="5%">
									<col width="7%">
									<col width="7%">									
								</colgroup>
								
								<thead>
									<tr>
										<th scope="col">주문 코드</th>
										<th scope="col">주문 일자</th>
										<th scope="col">기업 고객</th>
										<th scope="col">상품명</th>										
										<th scope="col">주문 수량</th>
										<th scope="col">재고</th>
										<th scope="col">주문 총액</th>
										<th scope="col">납품 단가</th>
										<th scope="col">배송 희망일</th>
										<th scope="col">입금 여부</th>
										<th scope="col">배송</th>
										<th scope="col">발주</th>
									</tr>
								</thead>
								<tbody>
									<template v-if="totalCnt == 0">
										<tr>
											<td colspan="12">주문이 존재하지 않습니다.</td>
										</tr>
									</template>		
									<template v-else>
										<tr v-for="one in dataList">
											<td>{{ one.order_cd }}</td>
											<td>{{ one.order_date }}</td>
											<td>{{ one.name }}</td>
											<td>{{ one.pro_nm }}</td>
											<td>{{ one.order_cnt }}</td>
											<td>{{ one.pro_stock }}</td>
											<td>{{ one.order_price }}</td>
											<td>{{ one.pro_unit_price }}</td>
											<td>{{ one.order_hope_date }}</td>
											<td>입금</td>
											<td>
												<teamplate v-if="one.order_st == '0'">
													<a class="btnType3 color2" @click="fn_selectDelivery(one.order_cd, one.pro_cd)">
														<span>배송</span>
													</a>													
												</teamplate>
												<template v-else>
													배송 지시서 작성 완료													
												</template>
											</td>
											<td>
												<teamplate v-if="one.order_pur == '0'">
													<a class="btnType3 color1" @click="fn_selectOrder(one.order_cd, one.pro_cd)">
														<span>발주</span>
													</a>
												</teamplate>
												<template v-else>
													발주 지시서 작성 완료
												</template>
											</td>
										</tr>
									</template>							
								</tbody>
							</table>
						</div>			
	
						<div class="paging_area" id="pagingNavi" v-html="pagingNavi">
						</div>	
						
						</div>
						
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>
	
	<!-- // 모달 팝업 -->
	<div id="orderPop" class="layerPop layerType2" style="width: 800px;">
		<dl>
			<dt>
				<strong>발주 내역</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>
					<colgroup>
						<col width="250">
						<col width="150">
						<col width="100">
						<col width="100">
						<col width="100">
						<col width="100">
					</colgroup>

					<tbody>
						<tr>
							<th scope="row">상품명</th>							
							<th scope="row">납품 단가</th>
							<th scope="row">주문 수량</th>
							<th scope="row">재고</th>	
							<th scope="row">발주 수량</th>	
							<th scope="row">납품 업체명</th>					
						</tr>
						<tr>
							<td id="pro_nm" v-text="pro_nm" style="text-align: center;"></td>							
							<td id="pro_unit_price" v-text="pro_unit_price" style="text-align: center;"></td>
							<td id="order_cnt" v-text="order_cnt" style="text-align: center;"></td>
							<td id="pro_stock" v-text="pro_stock" style="text-align: center;"></td>
							<td>							
								<input type="text" id="pur_cnt" name="pur_cnt" v-model="pur_cnt" style="width:70px;">								
							</td>
							<td>
								<select id="sup_select"></select>
							</td>
						</tr>											
					</tbody>
				</table>
				<br>							
				<div style="text-align: center;">
					<a @click="fn_Save()" class="btnType blue" id="btnSave" name="btn"><span>발주 지시서</span></a>&nbsp;&nbsp;			
					<a href="" class="btnType gray"  id="btnClose" name="btn"><span>취소</span></a>		
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>		
	</div>
	<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@배송 지시서 작성@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->
	<!-- 모달팝업 -->
	<div id="deliDirection" class="layerPop layerType2"
		style="width: 900px;">
		<dl>
			<dt>
				<strong>배송 지시서 작성</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->

				<table class="col">
					<caption>caption</caption>
					<colgroup>
						<col width="8%">
						<col width="14%">
						<col width="10%">
						<col width="18%">
						<col width="6%">
					</colgroup>

					<thead>
						<tr>
							<th scope="col">주문 번호</th>
							<th scope="col">주문 일자</th>
							<th scope="col">고객기업명</th>
							<th scope="col">주문제품명</th>
							<th scope="col">주문 개수</th>
						</tr>
					</thead>
					<tbody>

						<tr>
							<td id="order_cd" v-text="order_cd"><!-- <a type="text" class="inputTxt p100" name="order_cd" id="order_cd" readonly="readonly" /></a> --></td>
							<td id="order_date" v-text="order_date"></td>
							<td id="loginid" v-text="loginid"></td>
							<td id="pro_nm2" v-text="pro_nm2"></td>
							<td id="order_cnt2" v-text="order_cnt2"></td>
						</tr>
					</tbody>
				</table>

				<table class="row">
					<caption>caption</caption>
					<colgroup>
						<col width="15%">
						<col width="15%">
						<col width="15%">
					</colgroup>

					<tbody>
						<tr>
							<th scope="row">재고 개수 <span class="font_red"></span></th>
							<td><input type="text" class="inputTxt p100"
							id="pro_stock2" v-model="pro_stock2" readonly="readonly" /></td>
							<th scope="row">주문 개수 <span class="font_red"></span></th>
							<td><input type="text" class="inputTxt p100"
							id="order_cnt3" v-model="order_cnt3" readonly/></td>
							<td>
							<a @click="fn_deliveryPlus()" class="btnType blue" id="deliveryPlusBtn" v-show="vPlus"><span>추가</span></a>
							</td>
						</tr>

					</tbody>
				</table>
				
				<table class="col" id ="shippingDiretionTable">
					<caption>caption</caption>
					<colgroup>
					
						<col width="3%">
						<col width="12%">
						<col width="12%">
						<col width="16%">
					</colgroup>

					<thead>
						<tr>
							<th scope="col">제품코드</th>
							<th scope="col">제품명</th>
							<th scope="col">수주 개수</th>
							<th scope="col">비고</th>
						</tr>
					</thead>
					<tbody id="delivery_tbody">
					
						<template v-if="delCheck == 'on'">
							<tr>
								<td v-text="pro_cd"></td>
								<td v-text="pro_nm2"></td>
								<td>
									<input type="text" v-model="order_cnt3" readonly>
								</td>
								<td>
									<a class='btnType gray' @click='fn_deleteDelivery()' id='deleteShppingBtn' name='deleteShppingBtn'>
										<span>삭제</span>
									</a>
								</td>
							</tr>
						</template>

						<!-- <tr>
							<td id="pro_cd"></td>
							<td id="pro_nm">
							<td></td>
							<td></td>
						</tr>
 -->


					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a @click="fn_saveDelivery();" class="btnType blue" id="saveDeliveryBtn" name="btn"><span>완료</span></a>
					<a href="" class="btnType gray" id="btnClose" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->
	
</form>
</body>
</html>
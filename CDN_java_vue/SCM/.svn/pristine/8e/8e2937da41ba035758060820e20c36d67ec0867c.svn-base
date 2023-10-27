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
	
	// 화면이 열리면 바로 실행되는 jQuery
    $(function() {    	
    	
    	// 주문 리스트
    	fn_orderList();
    	
    	 $("#searchDel").change(function(){
    		 fn_orderList();
         });
    	 
    	 $("#searchPur").change(function(){
    		 fn_orderList();
           });
		
	});
	
	function fn_orderList(currentPage) {
		
		var currentPage=currentPage || 1;
		
		var searchDel = $("#searchDel").is(":checked");
		
		var searchPur = $("#searchPur").is(":checked");
		
		var searchStartDate = $("#searchStartDate").val();
		
		var searchEndDate = $("#searchEndDate").val();
							
		var param = {
				
				pageSize : pageSize,
				currentPage : currentPage,
				searchsel : $("#searchsel").val(),
    			searchtext : $("#searchtext").val(),
    			searchDel : searchDel,
    			searchPur : searchPur,
    			searchStartDate : searchStartDate,
    			searchEndDate : searchEndDate
		}
				
		var listCallBack = function(returnData) {
			
			console.log(returnData);
			
			$("#orderList").empty().append(returnData);
			
			console.log($("#totalCnt").val());
			
			var totalCnt=$("#totalCnt").val();
			
			var paginationHtml = getPaginationHtml(currentPage, totalCnt, pageSize, pageBlockSize, 'fn_orderList');
			
			console.log("paginationHtml : "+paginationHtml);
			
			$("#orderPagination").empty().append(paginationHtml);
			
			// 현재 페이지 설정
			$("#currentPagenotice").val(currentPage);			
			
		}
		
		callAjax("/scm/orderList.do", "post", "text", true, param, listCallBack);
		
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
	    
		$("#pro_cd").val(data.pro_cd);
		$("#order_cd").val(data.order_cd);
		$("#pro_nm").text(data.pro_nm);		
		$("#pro_unit_price").text(data.pro_unit_price);
		$("#order_cnt").text(data.order_cnt);
		$("#pro_stock").text(data.pro_stock);
		$("#action").val("I");		
		$("#pur_cnt").val('');
		
		selectComCombo("cli","sup_select","sel",data.pro_cd,"");		
		 
	} 
	 
	 
	 function fn_Save() {
		 
		 if(!fValidate()) {
			 return;			 
		 }		 		 
		 
		 var param = {
				 
				 pro_cd : $("#pro_cd").val(),				 
				 pur_cnt : $("#pur_cnt").val(),	
				 sup_cd : $("#sup_select").val(),
				 order_cd : $("#order_cd").val(),				 
				 action : $("#action").val()				 
		 }		
		 
		 var saveCallBack = function(returnValue) {
			 
			 console.log(JSON.stringify(returnValue));
			 
			 if(returnValue.result == "SUCCESS") {
				 
				 alert("발주 지시서 작성 완료");
				 gfCloseModal();
				 
				 fn_orderList($("#currentPagenotice").val());
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
		 $("#order_cd").text(data.order_cd);
		 $("#order_date").text(data.order_date);
		 $("#loginid").text(data.loginid);
		 $("#pro_nm2").text(data.pro_nm);
		 $("#order_cnt2").text(data.order_cnt);
		 $("#order_cnt3").val(data.order_cnt);
		 $("#pro_stock2").val(data.pro_stock);
		 
		 $("#delivery_tbody").children().remove();
		 
		 $("#pro_cd").val(data.pro_cd);
		 $("#deliveryPlusBtn").show();
	}
	
	 function fn_deliveryPlus(){
		 
		 var pro_cd = $("#pro_cd").val();
		 var pro_nm = $("#pro_nm2").text();
		 var pro_stock = $("#pro_stock2").val() * 1;
		 var order_cnt = $("#order_cnt3").val() * 1;
			 
		 console.log("pro_stock: "+ pro_stock);
		 console.log("order_cnt: "+ order_cnt);
		 
		 if(pro_stock < order_cnt){
			 alert("재고가 부족합니다.");
			 return;
		 }else{
			 
		 }
		 
		 var html = 
		"<tr>" +
		"<td id='pro_cd'>"+pro_cd+"</td>"+
		"<td id='pro_nm'>"+pro_nm+"</td>"+
		"<td><input type='text' class='inputTxt p100' id='order_cnt4' value='"+order_cnt+"'/></td>"+
		"<td><a class='btnType gray' href='javascript:fn_deleteDelivery()' id='deleteShppingBtn' name='deleteShppingBtn'><span>삭제</span></a></td>"
		+"</tr>"
		;
		
		$("#delivery_tbody").append(html);
		
		$("#pro_stock2").val(pro_stock - order_cnt);
		
		$("#deliveryPlusBtn").hide();
	 }
	 
	 function fn_deleteDelivery(){
		 $("#delivery_tbody").children().remove();
		 
		 var pro_stock = $("#pro_stock2").val() * 1;
		 var order_cnt = $("#order_cnt3").val() * 1;
		 
		 $("#pro_stock2").val(pro_stock + order_cnt);
		 
		 $("#deliveryPlusBtn").show();
		 
	 }
	 
	 function fn_saveDelivery(){
			 
		 	var order_cnt4 = $("#order_cnt4").val();
		 	console.log(order_cnt4);
		 	if(order_cnt4 == '' || order_cnt4 == undefined || order_cnt4 == null){
		 		alert("상품을 추가해주세요.");
		 		return;
		 	} else{
		 		
		 	}
		 
			var param = {
					order_cd : $("#order_cd").text(),
					pro_cd : $("#pro_cd").val(),
					deli_cnt : order_cnt4,
					//////////////
	    			
	    			order_hope_date : $("#order_hope_date").val(),
	    	}
			console.log("param: " + JSON.stringify(param));
			
	    	
	    	var savecallback = function(res) {
	    		console.log(JSON.stringify(res));
	    		
	    		if(res.result == "SUCCESS") {
	    			alert("작성 완료되었습니다.");
	    			gfCloseModal();
	    			fn_updateProductStock(); //재고감소
	    			
	    			fn_orderList($("#currentPagenotice").val());
	    		}else{
	    			alert("주문 실패.");
	    			gfCloseModal();
	    			
	    			fn_orderList($("#currentPagenotice").val());
	    		}
	    		
	    	}
	    	
	    	callAjax("/scm/saveDelivery.do", "post", "json", true, param, savecallback);
			
		}
	 	
	 function fn_updateProductStock(){
		 	
			var pro_stock2 = $("#pro_stock2").val();	
		 	console.log("pro_stock2: " + pro_stock2);
		 
			var param = {
					pro_cd : $("#pro_cd").val(),
					pro_stock : pro_stock2
	    	}
			
			console.log("param: " + JSON.stringify(param));
			
	    	
	    	var savecallback = function(res) {
	    		console.log(JSON.stringify(res));
	    		
	    		if(res.result == "SUCCESS") {
	    			alert("재고 업데이트되었습니다.");
	    			fn_orderList($("#currentPagenotice").val());
	    		}else{
	    			alert("재고 업데이트 실패.");
	    			fn_orderList($("#currentPagenotice").val());
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
						<p class="conTitle">  
							<span>일별 수주 내역</span> 
							<span class="fr">
								<input type="date" id="searchStartDate" name="searchStartDate" style="height: 25px;">&nbsp;~&nbsp;	
								<input type="date" id="searchEndDate" name="searchEndDate" style="height: 25px;">&nbsp;&nbsp;&nbsp;&nbsp;					
							     							    		
							    <select id="searchsel" name="searchsel" style="width:100px;">
							         <option value="">전체</option>
							         <option value="product">상품명</option>
							         <option value="customer">기업 고객명</option>							         
							    </select>
							    <input type="text" id="searchtext" name="searchtext"  style="width: 150px; height: 25px;" />
							    <a class="btnType blue" href="javascript:fn_orderList();" name="modal"><span>검색</span></a>							    
							</span> 													
						</p>
						<br>
						
						<label style="display: flex; justify-content: flex-end;">
							<input type="checkbox" name="searchDel" id="searchDel">&nbsp;<span>미배송</span>&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="checkbox" name="searchPur" id="searchPur">&nbsp;<span>미발주</span>&nbsp;&nbsp;&nbsp;&nbsp;
						</label>		
						
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
								<tbody id="orderList"></tbody>
							</table>
						</div>			
	
						<div class="paging_area" id="orderPagination"></div>
						
						
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
							<td id="pro_nm" style="text-align: center;"></td>							
							<td id="pro_unit_price" style="text-align: center;"></td>
							<td id="order_cnt" style="text-align: center;"></td>
							<td id="pro_stock" style="text-align: center;"></td>
							<td>							
								<input type="text" id="pur_cnt" name="pur_cnt" style="width:70px;">								
							</td>
							<td>
								<select id="sup_select"></select>
							</td>
						</tr>											
					</tbody>
				</table>
				<br>							
				<div style="text-align: center;">
					<a href="javascript:fn_Save()" class="btnType blue" id="btnSave" name="btn"><span>발주 지시서</span></a>&nbsp;&nbsp;			
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
							<td><a type="text" class="inputTxt p100" name="order_cd" id="order_cd" readonly="readonly" /></a></td>
							<td id="order_date"></td>
							<td id="loginid"></td>
							<td id="pro_nm2"></td>
							<td id="order_cnt2"></td>
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
							id="pro_stock2" readonly="readonly" /></td>
							<th scope="row">주문 개수 <span class="font_red"></span></th>
							<td><input type="text" class="inputTxt p100"
							id="order_cnt3" /></td>
							<td>
							<a href="javascript:fn_deliveryPlus();" class="btnType blue" id="deliveryPlusBtn"><span>추가</span></a>
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

						<tr>
							<td id="pro_cd"></td>
							<td id="pro_nm">
							<td></td>
							<td></td>
						</tr>



					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="javascript:fn_saveDelivery();" class="btnType blue" id="saveDeliveryBtn" name="btn"><span>완료</span></a>
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
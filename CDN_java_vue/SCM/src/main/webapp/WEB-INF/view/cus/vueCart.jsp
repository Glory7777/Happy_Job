<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>상품 목록</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->
              
<script type="text/javascript">
	// 페이징 설정
	var pageSize = 10;
	var pageBlockSize = 5;
	
	var cartList;
	
	$(function() {
		
		$("#allCheck").click(function(){
            //만약 전체 선택 체크박스가 체크된상태일경우
            if($("#allCheck").prop("checked")) {
                $("input[type=checkbox]").prop("checked",true);
                //input type이 체크박스인것은 모두 체크함
            } else {
                $("input[type=checkbox]").prop("checked",false);
                //input type이 체크박스인것은 모두 체크 해제함
            }
            fn_changeTotalPrice();
     	});
		//체크박스 선택 시 총 금액 계산
		$(".divComGrpCodList").on("click", "input:checkbox", function () {
			console.log("click checkbox");
			fn_changeTotalPrice();
		});
		
		comcombo("productCD", "searchProCt", "all", "");
		
		vueInit();
		
		// 상품 목록 조회
		fn_serachList();
		
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
		
	});
	
	function vueInit() {
		
	cartList = new Vue({
			
								el : "#cartList",							
							data : {								
								dataList : [],
								totalCnt:0,
				                pagingNavi: "",
				                currentPage:0,
				                checkedList : [],
				                totalSum : 0,
				                orderList : [], 	// 주문리스트
				                selectAll : false
							},
						methods : {
							fn_deleteCart : function(pro_cd) {			            		
								fn_deleteCart(pro_cd);
			            	},
			            	// 장바구니 상품을 선택하면 금액을 합계하는 메서드
			            	addToSum : function(sum, index) {
			            		  //alert(index + " : " +sum);
			            		  
			            		  if(this.checkedList[index]) {
			            			  this.totalSum += sum;
			            		  } else {
			            			  this.totalSum -= sum;
			            			  
			            			  this.selectAll = false; // 전체 선택한 후, 하나를 선택 해제하면 전체 선택 또한 해제 됨
			            		  }     
			            		  
			            	      
			            	  },
			            	  // 장바구니 상품을 선택하면 주문을 위해 orderList에 넣는 메서드
			            	  finalOrder : function(pro_cd, cart_cnt, order_price, order_hope_date, index) {
			            		  
			            		  if(this.checkedList[index] == true) {
			            			 			            			  
			            			  object = { pro_cd : pro_cd, cart_cnt : cart_cnt, order_price : order_price, order_hope_date : order_hope_date }
			            			  
			            			  this.orderList.push(object);
			            			  
			            		  }else {			            			 
			            			  
			            			  this.orderList = this.orderList.filter(function(object) {
			            				  
			            			      return object.pro_cd != pro_cd;
			            			      
			            			    });			            			  
			            				  
			            		 }			            			  
			            },
			            toggleAllCheckboxes : function() {
			            	    
			            	   /*  console.log(this.selectAll);
			            	
			            	    for(var i=0; i<this.dataList.length; i++) {			            	    	
			            	    	
			            	    	this.checkedList[i] = this.selectAll;
			            	    	
			            	    	//console.log(this.dataList);
			            	    	
			            	    	console.log(i + " : " + this.checkedList[i] );			            	    	
			            	    	
				            	    if(this.selectAll) {		
				            	    	this.totalSum += this.dataList[i].pro_sup_price * this.dataList[i].cart_cnt;
				            	    } else {				            	    	
				            	    	this.totalSum = 0;
				            	    }			            	    
				            	    
			                     } */
			                     
			                  	 this.totalSum = 0;
			                     
			                     for(var i=0; i<this.dataList.length; i++) {
			                    	 
			                    	 this.checkedList[i] = this.selectAll;
			                    	 
			                    	 if(this.selectAll) {
			                    		 
			                    		 this.addToSum(this.dataList[i].pro_sup_price * this.dataList[i].cart_cnt, i);
			                    		 
			                    		 this.finalOrder(this.dataList[i].pro_cd, this.dataList[i].cart_cnt, this.dataList[i].pro_sup_price * this.dataList[i].cart_cnt, this.dataList[i].order_hope_date, i);                   		 
			                    		 		                    		 
			                    	 } else {
			                    		 
			                    		 this.orderList = [];
			                    		 
			                    	 } 	                    	 
			                    	 
			                     }			      
			                     
			            				            	
			              } 		
			      }			            		
			          
		});
		
	orderPop =new Vue({
		
									el : "#orderPop",							
									data : {										
									
										bank_cd : "",
										account_num : "",
										name : "",
										totalSum : 0
									}		
							});

		
	}	
	
	//장바구니 수량 변경 시 총 금액 계산
	function fn_changeCartCnt(inputElement) {
	    // 현재 변경된 input 요소를 찾기 위해 this를 사용합니다.
	    console.log("inputElement:" + inputElement);
	    var cartCntInput = $(inputElement);

	    // 해당 행의 수량 가져오기
	    var cartCnt = parseInt(cartCntInput.val());
		
	    // 해당 행의 상품 가격 가져오기
	    var proSupPrice = parseInt(cartCntInput.closest('tr').find('td:nth-child(5)').text());

	    // 해당 행의 총 가격 업데이트
	    var totalPrice = cartCnt * proSupPrice;
	    cartCntInput.closest('tr').find('td:nth-child(7)').text(totalPrice);
	}
	
	
	function fn_changeTotalPrice(){
		var total = 0;
		
		// 체크된 체크박스들을 순회하며 값을 합산합니다.
        $('input[name="selectedItems"]:checked').each(function() {
            var row = $(this).closest('tr'); // 체크된 체크박스의 부모 <tr>을 찾습니다.
            var price = parseFloat(row.find('td:nth-child(7)').text().replaceAll(",", "")); // 6번째 열의 가격을 가져옵니다.
            console.log("price:" + price);
            if (!isNaN(price)) {
                total += price;
            }
        });
		
		$("#hap_total_price").val(total);
	}
	
	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();
	
			var btnId = $(this).attr('id');
	
			switch (btnId) {
				case 'btnOrder' :
					fn_cartOrder();
					break;
				case 'btnClose' :
					gfCloseModal();
					break;
				case 'selectDeleteCart' :
					fn_selectDeleteCart();
					break;
				case 'selectAccount' :
					fn_selectAccount();
					break;	
					
					
					
			}
		});
	}
	
	function fn_deleteCart(pro_cd){
		console.log("pro_cd:" + pro_cd);
		
		if(confirm("삭제하시겠습니까?")) {
    		
    	} else{
    		return;
    	}
		
    	var param = {
    			pro_cd : pro_cd,
    	}
    	
    	var savecallback = function(res) {
    		console.log(JSON.stringify(res));
    		
    		if(res.result == "SUCCESS") {
    			alert("삭제되었습니다.");
    			gfCloseModal();
    			
    			fn_serachList(cartList.currentPage);
    		}else{
    			alert("실패.");
    			gfCloseModal();
    			
    			fn_serachList(cartList.currentPage);
    		}
    		
    	}
    	
    	callAjax("/cus/deleteOneCart.do", "post", "json", true, param, savecallback);
		
	}
	
	function fn_selectDeleteCart(order){
		
		var totalSum = cartList.totalSum;
		
		if(totalSum == "" || totalSum == "0"){
			alert("상품을 선택하세요.");
			return;
		}else{
			
		}
		
		if(order =="O"){
			
		}else{
			if(confirm("삭제하시겠습니까?")) {
	    		
	    	} else{
	    		return;
	    	}
		}
		
		
		var keysArr = new Array();
		
    /*   $('input[name="selectedItems"]:checked').each(function() {
            var row = $(this).closest('tr'); // 체크된 체크박스의 부모 <tr>을 찾습니다.
            var key = row.find('td:nth-child(2)').text(); // 6번째 열의 가격을 가져옵니다.
			//console.log("key:" + key);
            
			keysArr.push(key);
            console.log("keysArr:" + keysArr);
            
        }); */
        
        var orderList = cartList.orderList;
        
        for(var i=0; i<orderList.length; i++) {
        	
        	var key = orderList[i].order_price;
        	
        	var pro_cd = orderList[i].pro_cd;
        	
        	keysArr.push(key);
        	keysArr.push(pro_cd);
        }
		
    	var param = {
        		
    			paramArr : keysArr	    			
    	}
    	
    	var savecallback = function(res) {
    		console.log(JSON.stringify(res));
    		
    		if(res.result == "SUCCESS") {
    			if(order !="O"){
    				alert("삭제되었습니다.");
    			}
    			gfCloseModal();
    			
    			fn_serachList(cartList.currentPage);
    			
    			location.reload();
    		}else{
    			alert("실패.");
    			gfCloseModal();
    			
    			fn_serachList(cartList.currentPage);
    		}
    		
    	}
    	
    	callAjax("/cus/deleteCart.do", "post", "json", true, param, savecallback);
        
	}
	
    function fn_serachList(currentPage) {
    	
    	var currentPage = currentPage || 1;
    	    	
    	var param = {
    			pageSize : pageSize,
    			currntPage : currentPage,
    	}
    	
       var listcallback = function(returnData) {
    	
    		console.log(JSON.stringify(returnData));
    		
    		cartList.dataList = returnData.listCart;
    		cartList.totalCnt = returnData.totalCnt;
    		    		
    		var paginationHtml = getPaginationHtml(currentPage, cartList.totalCnt, pageSize, pageBlockSize, 'fn_serachList');
    		
			console.log("paginationHtml : "+paginationHtml);
						
			cartList.pagingNavi = paginationHtml;
    		
			cartList.currentPage = currentPage;	
    		
    	}
    	
    	callAjax("/cus/listCartvue.do", "post", "json", true, param, listcallback);
    	
    }
    
    function fn_popupint(data) {
   		console.log("data:"+JSON.stringify(data));
   		
   		orderPop.bank_cd = data.bank_cd;
   		orderPop.account_num = data.account_num;
   		orderPop.name = data.name;
   		orderPop.totalSum = cartList.totalSum;
       	
    }
    
	function fn_selectAccount() {
    	
		var totalSum = cartList.totalSum;
		
		if(totalSum == "" || totalSum == "0"){
			alert("상품을 선택하세요.");
			return;
		}else{
			
		}
		
    	var param = {
    			pro_cd : ""
    	}
    	
    	var selectcallback = function(res) {
    		console.log(JSON.stringify(res));  
    		fn_popupint(res.selectAccount);
    		
    		gfModalPop("#orderPop");
    		
    		
    	}
    	
    	callAjax("/cus/selectAccount.do", "post", "json", true, param, selectcallback);
    	
    }
	
	function fn_cartOrder(){
		
			var ctOrderArrayList = new Array();
			
			var orderList = cartList.orderList;
			
			for(i=0; i<orderList.length; i++) {								
				
	            var pro_cd = orderList[i].pro_cd;
	            var cart_cnt = orderList[i].cart_cnt;
	            var order_price = orderList[i].order_price;
	            var order_hope_date = orderList[i].order_hope_date;
	             
	            var item = pro_cd + "/" + cart_cnt + "/" + order_price + "/" + order_hope_date;
	            
	            ctOrderArrayList.push(item);
				
				
			}
		
	
		
		var STctOrderArrayList = JSON.stringify(ctOrderArrayList);
		console.log("ctOrderArrayList:" + STctOrderArrayList);
		
		
		var param = {
				ctOrderArrayList : STctOrderArrayList
    	}
    	
    	var savecallback = function(res) {
    		console.log(JSON.stringify(res));
    		
    		if(res.result == "SUCCESS") {
    			alert("주문 완료되었습니다.");
    			gfCloseModal();
    			
    			fn_selectDeleteCart("O"); // 주문한 항목 삭제
    			
    			fn_serachList(cartList.currentPage);
    			
    			
    		}else{
    			alert("주문 실패.");
    			gfCloseModal();
    			
    			fn_serachList(cartList.currentPage);
    		}
    		
    	}
    	
    	callAjax("/cus/orderCart.do", "post", "json", true, param, savecallback);
		
	}
	
	/** 저장 validation */
	function fValidate() {

		var chk = checkNotEmpty(
			[
				[ "order_hope_date", "납품 희망일을 입력해 주세요." ]
				,[ "cart_cnt", "수량을 입력해 주세요." ]
			]
		);

		if (!chk) {
			return;
		}

		return true;
	}
	
</script>

</head>
<body>
<form id="myForm" action=""  method="">
	  <input type="hidden" id="currentPagenotice" />
	  <input type="hidden" id="action"  name="action" />
	  <input type="hidden" id="selnoticecd"  name="selnoticecd" />
	  <input type="hidden" id="file_cd"  name="file_cd" />
	
	
	
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
							<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a> <span
								class="btn_nav bold">주문</span> <span class="btn_nav bold"> 장바구니
								</span> <a href="/cus/cart.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>장바구니</span> 
							<span class="fr"> 
							</span>
						</p>
						
						<div id="cartList">
						<div class="divComGrpCodList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="5%">
									<col width="5%">
									<col width="10%">
									<col width="15%">
									<col width="10%">
									<col width="5%">
									<col width="15%">
									<col width="10%">
									<col width="5%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col"><input type="checkbox" id="allCheck" v-model="selectAll" @change="toggleAllCheckboxes"></th>
										<th scope="col">상품코드</th>
										<th scope="col">사진</th>
										<th scope="col">상품명</th>
										<th scope="col">판매단가</th>
										<th scope="col">수량</th>
										<th scope="col">총 금액</th>
										<th scope="col">납품 희망일자</th>
										<th scope="col">삭제</th>
									</tr>
								</thead>
								<tbody>
									 <template v-if="totalCnt == 0">
									 	<tr>
									 		<td colspan="9">장바구니에 담긴 상품이 없습니다.</td>
									 	</tr>
									 </template>
									 <template v-else>
									 	<tr v-for="(one,index) in dataList">
									 		<td><input type="checkbox" name="selectedItems" class="selectedItems" v-model="checkedList[index]"  @change="addToSum(one.pro_sup_price * one.cart_cnt, index), finalOrder(one.pro_cd, one.cart_cnt, one.pro_sup_price * one.cart_cnt, one.order_hope_date, index)"></td>
									 		<td>{{ one.pro_cd }}</td>
									 		<td><img alt="제품 이미지" :src="one.logic_path" width="100" height="100"></td>
									 		<td>{{ one.pro_nm }}</td>
									 		<td>{{ one.pro_sup_price }}</td>
									 		<td><input type="number" name="cart_cnt" id="cart_cnt" v-model="one.cart_cnt" onchange="javascript:fn_changeCartCnt(this)"></td></td>
									 		<td>{{ one.pro_sup_price * one.cart_cnt }}</td>
									 		<td><input type="date" name="order_hope_date" id="order_hope_date" v-model="one.order_hope_date"></td>
									 		<td><a @click="fn_deleteCart(one.pro_cd)"	class="btnType gray"  id="deleteCart" name="btn"><span>취소</span></a></td>
									 	</tr>									 	
									 </template>																											 
								</tbody>
							</table>
						</div>
	
						<div class="paging_area" id="pagingNavi" v-html="pagingNavi">
						</div>
																		
						<br /><br /><br />
							<div id="cart_hap" style="float:right; width:300px; font-size:20px;">
								<p></p>
									<span>장바구니 총액</span>
									<br />
									<hr />
									<span>합계 금액</span> 
									<input type="text" class="inputTxt p100" name="hap_total_price" id="hap_total_price" v-model="totalSum" readonly/>
									<br /><br />
								
								<div id="cart_deldiv" style="float:right;">
									<a class="btnType blue" href="" id="selectDeleteCart" name="btn"><span>선택취소</span></a>
									<a class="btnType blue" href="" id="selectAccount" name="btn"><span>주문하기</span></a>
								</div>
							</div>
								
					</div>
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>

	<!--// 모달팝업 -->
	<div id="orderPop" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong>주문하기</strong>
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
					</colgroup>

					<tbody>
						<tr>
							<th scope="row">은행명</th>
							<td>
								<input type="text" class="inputTxt p100" name="bank_cd" id="bank_cd" v-model="bank_cd" readonly/>
							 </td>
						</tr>
						<tr>
							<th scope="row">계좌번호</th>
							<td>
								<input type="text" class="inputTxt p100" name="account_num" id="account_num" v-model="account_num" readonly/>
							 </td>
						</tr>
						<tr>
							<th scope="row">예금주</th>
							<td>
								<input type="text" class="inputTxt p100" name="name" id="name" v-model="name" readonly/>
							 </td>
						</tr>
						<tr>
							<th scope="row">결제금액<span class="font_red">*</span></th>
							<td>
								<input type="text" class="inputTxt p100" name="hap_total_price2" id="hap_total_price2" v-model="totalSum" readonly/>
							 </td>
						</tr>
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnOrder" name="btn"><span>주문하기</span></a> 
					<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>	
	
</form>
</body>
</html>
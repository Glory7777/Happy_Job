<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Job Korea</title>
<style>
	.slideshow-container {
	  position: relative;
	}
	
	/* effect */
	.fade {
		-webkit-animation-name: fade;
		-webkit-animation-duration: 1.5s;
		animation-name: fade;
		animation-duration: 1.5s;
	}
	
	@-webkit-keyframes fade {
		from {opacity: .4} 
		to {opacity: 1}
	}
	
	@keyframes fade {
		from {opacity: .4} 
		to {opacity: 1}
	}
	
	.slidePrev, .slideNext {
		cursor: pointer;
		position: absolute;
		top: 200px;	
		width: auto;
		padding: 16px;
		color: darkgray;
		font-weight: bold;
		font-size: 18px;
	}
	
	.slideNext {
		right: 0;
	}

	
</style>

<!-- slick slide 라이브러리 -> 왜 안되는지 모르겠음요! 알려주세요 -->
<link rel="stylesheet" type="text/css" href="${CTX_PATH}/css/slick/slick.css" />
<link rel="stylesheet" type="text/css" href="${CTX_PATH}/css/slick/slick-theme.css" />
<script type="text/javascript" charset="utf-8" src="${CTX_PATH}/js/slick/slick.js"></script>
<script type="text/javascript" charset="utf-8" src="${CTX_PATH}/js/slick/slick.min.js"></script>

<script type="text/javascript">

	var timer = null;
	
	var searchArea;
	var divProductList;
	var productPop;
	
	/* onload 이벤트  */
	$(document).ready(function() {
		
		// 뷰 초기설정
		vueInit();
		
		// 판매상품 조회
		fn_product();
		
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
		
		//오늘 이전날짜 선택 불가
		dateCheck();
		
		//공통코드 콤보박스
		comcombo("productCD", "searchSel", "all", "");
		comcombo("productCD", "searchProCtdt", "all", "");
		
    });
		
		
	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		
		// 버튼이벤트제거... 이거 안하면 장바구니 추가, 구매 버튼이 중복 실행됨...
		$('a[name=btn]').off('click');
		
		$('a[name=btn]').click(function(e) {
			e.preventDefault();
	
			var btnId = $(this).attr('id');
	
			switch (btnId) {
				case 'btnSaveCart' :	
					fn_saveCart();
					break;					
				case 'btnOrder' :
					fn_order();
					break;
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
				searchSel : "",
			},
			methods : {
				seahchSelChange(){
					
					// 슬라이드 중지
					$(".slideDiv").stop();
					
					// 타이머 중지
					clearInterval(timer);
					
					fn_product();
				}
			}
		});
		
		divProductList = new Vue({
			el : "#divProductList",
			data : {
				datalist : [],
				totalcnt : 0,
				currentIndex : 0,	// 현재 나타난 슬라이드의 인덱스 변수
				newIndex : 0,		// 새롭게 나타낼 div의 index
				slideDiv : "",
			},
			filters : {
				comma(val){
					return String(val).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
				}
			},
			computed: {
				splitDatalist() {
					const chunks = [];
					for (let i = 0; i < this.datalist.length; i += 3) {
						chunks.push(this.datalist.slice(i, i + 3));
					}
					return chunks;
				}
			},
			methods : {
				fn_selectProduct : function(pro_cd){
					fn_selectProduct(pro_cd);
				},
				fn_prevSlide : function(){
					fn_prevSlide();
				},
				fn_nextSlide : function(){
					fn_nextSlide();
				}
			}
		});
		
		productPop = new Vue({
			el : "#productPop",
			data : {
				pro_cd : "",
				pro_mfc : "",
				pro_sup_price : "",
				pro_dt : "",
				cart_cnt : 1,
				order_hope_date : "",
				order_hope_date_min : "",
				searchProCtdt : "",
				action : "",
				inserhtml : "",
			},
		});
	}

	// 판매 상품 조회
	function fn_product(){
		
		var param = {
				searchSel : searchArea.searchSel,
		}
		
		var resultCallback = function(returndata){
			
			divProductList.datalist = returndata.producImagetList;
			divProductList.totalcnt = returndata.totalcnt;
			
			$(".slideDiv").not(".active").hide();
			timer = setInterval(fn_nextSlide, 6000);
			
		};
		callAjax("/dashboard/vueCusProductList.do", "post", "json", true, param, resultCallback);
	}

	
	// 상품상세 모달
    function fn_popupint(data) {
    	
       	productPop.pro_cd = data.pro_cd;
       	productPop.pro_mfc = data.pro_mfc;  
       	productPop.pro_sup_price = data.pro_sup_price;
       	productPop.pro_dt = data.pro_dt;
       	
       	productPop.searchProCtdt = data.ct_cd;
       	//$("#action").val("U"); 
       	
       	var file_extention = data.file_extention;
       	productPop.inserhtml = "";
    	
    	if(data.file_nm == "" || data.file_nm == null) {
    	} else {
    		
			if(file_extention.toLowerCase() == "jpg" ||  file_extention.toLowerCase() == "png"  ||  file_extention.toLowerCase() == "gif" ) {
				productPop.inserhtml += "<img src='" + data.logic_path + "'   style='width: 100px; height: 100px;''   />";
			} else {
	        	productPop.inserhtml += data.file_nm;
			}        		
    	}
    }
	
	
	// 상품 선택
	function fn_selectProduct(pro_cd) {
    	
    	var param = {
    			pro_cd : pro_cd
    	}
    	
    	var selectcallback = function(res) {
//     		console.log(JSON.stringify(res)); 
    		
    		fn_popupint(res.selectProduct);
    		
    		gfModalPop("#productPop");
    	}
    	callAjax("/cus/vueSelectProduct.do", "post", "json", true, param, selectcallback);
    }
	
	
	// 장바구니 담기
	function fn_saveCart(){
		if(!fValidate()) {
    		return;
    	}
		
		productPop.action = "C";
		
    	var param = {
    			action : productPop.action,
    			pro_cd : productPop.pro_cd,
    			cart_cnt : productPop.cart_cnt,
    			order_hope_date : productPop.order_hope_date
    	}
    	
    	var savecallback = function(res) {
    		console.log(JSON.stringify(res));
    		
    		if(res.result == "SUCCESS") {
    			alert("장바구니에 추가 되었습니다.");
    			gfCloseModal();
    			
    			productPop.cart_cnt = 1;
    			productPop.order_hope_date = "";
    			
    			fn_product(divProductList.currentPage);
    		}else{
    			alert("이미 장바구니에 있는 상품입니다.");
    			gfCloseModal();
    			
    			productPop.cart_cnt = 1;
    			productPop.order_hope_date = "";
    			
    			fn_product(divProductList.currentPage);
    		}
    	}
    	callAjax("/cus/vueSaveProduct.do", "post", "json", true, param, savecallback);
	}
	
	
	// 주문하기
	function fn_order(){
		if(!fValidate()) {
    		return;
    	}
		
		productPop.action = "O";
		
		var param = {
    			action : productPop.action,
    			pro_cd : productPop.pro_cd,
    			order_hope_date : productPop.order_hope_date,
    			order_price : productPop.pro_sup_price * productPop.cart_cnt,
    			cart_cnt : productPop.pro_cd,
    	}
    	
    	var savecallback = function(res) {
    		console.log(JSON.stringify(res));
    		
    		if(res.result == "SUCCESS") {
    			alert("주문 완료되었습니다.");
    			gfCloseModal();
    			
    			productPop.cart_cnt = 1;
    			productPop.order_hope_date = "";
    			
    			fn_product(divProductList.currentPage);
    		}else{
    			alert("주문 실패.");
    			gfCloseModal();
    			
    			productPop.cart_cnt = 1;
    			productPop.order_hope_date = "";
    			
    			fn_product(divProductList.currentPage);
    		}
    	}
    	callAjax("/cus/vueSaveProduct.do", "post", "json", true, param, savecallback);
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
	
	
	function dateCheck(){
		
		// 현재 날짜 가져오기
		var today = new Date();

		// YYYY-MM-DD 형식으로 현재 날짜를 문자열로 변환
		var formattedDate = today.toISOString().substr(0, 10);

		// order_hope_date_min에 오늘 날짜 집어넣기
		productPop.order_hope_date_min = formattedDate;
	}
	
	// 이전 슬라이드
	function fn_prevSlide() {
		$(".slideDiv").hide();			// 모든 div 숨김
		var allSlide = $(".slideDiv");	// 모든 div객체를 변수에 저장
		
		// 반복문으로 현재 active클래스를 가진 div를 찾아 index 저장
		$(".slideDiv").each(function(index, item){ 
			if($(this).hasClass("active")) {
				divProductList.currentIndex = index;
			}
		});
	    
		if(divProductList.currentIndex <= 0) {
			// 현재 슬라이드의 index가 0인 경우 마지막 슬라이드로 보냄(무한반복)
			divProductList.newIndex = allSlide.length-1;
		} else {
			// 현재 슬라이드의 index에서 한 칸 만큼 뒤로 간 index 지정
			divProductList.newIndex = divProductList.currentIndex-1;
		}

		// 모든 div에서 active 클래스 제거
		$(".slideDiv").removeClass("active");
	    
		// 새롭게 지정한 index번째 슬라이드에 active 클래스 부여 후 show()
		$(".slideDiv").eq(divProductList.newIndex).addClass("active");
		$(".slideDiv").eq(divProductList.newIndex).show();

	}

	// 다음 슬라이드
	function fn_nextSlide() {
		$(".slideDiv").hide();
		var allSlide = $(".slideDiv");
		
		$(".slideDiv").each(function(index, item){
			if($(this).hasClass("active")) {
				divProductList.currentIndex = index;
			} 
		});
		
		if(divProductList.currentIndex >= allSlide.length-1) {
			// 현재 슬라이드 index가 마지막 순서면 0번째로 보냄(무한반복)
			divProductList.newIndex = 0;
		} else {
			// 현재 슬라이드의 index에서 한 칸 만큼 앞으로 간 index 지정
			divProductList.newIndex = divProductList.currentIndex+1;
		}

		$(".slideDiv").removeClass("active");
		$(".slideDiv").eq(divProductList.newIndex).addClass("active");
		$(".slideDiv").eq(divProductList.newIndex).show();
		
	}
	
</script>

</head>
<body>
<form id="myForm" action=""  method="">

	<!-- 모달 배경 -->
	<div id="mask"></div>
	<div class="content" style="margin-bottom:20px;">
		<div style=" height: 550px; overflow: hidden;">
			<p id="searchArea" class="conTitle">
				<span>판매 상품</span>
				<span class="fr"> 
				    <select id="searchSel" name="searchSel" v-model="searchSel" @change="seahchSelChange" style="width: 100px; height: 27px;" ></select>
				</span>
			</p>
			<div id="divProductList">
				<div class="slideshow-container" style="margin-top: 50px;">
					<template v-if="totalcnt == 0">
						<div style="text-align: center; margin-top: 25%; color:darkgray; font-weight: bold;">데이터가 존재하지 않습니다.</div>
					</template>
					
					<template v-else>
						<div v-for="(group, groupIndex) in splitDatalist" class="slideDiv fade" v-model="slideDiv" :class="[groupIndex === 0 ? 'active' : '']" style="display: flex; justify-content: center;">
							<div v-for="(one, index) in group" :key="index">
							
								<div style="width: 280px; margin: 10px;" @click="fn_selectProduct(one.pro_cd)">
									<template v-if="one.logic_path === null">
										<div style="overflow: hidden; width: 278px; height: 200px; border: 1px solid black; background: lightgray;">
											<p style="text-align: center; margin-top: 30%; color: darkgray;">No Image</p>
										</div>
									</template>
									<template v-else>
										<div style="overflow: hidden; width: 278px; height: 200px; border: 1px solid black;">
											<img :src="one.logic_path" style="width: 100%; height: 100%; object-fit: cover; object-position: center;">
										</div>
									</template>
								
									<div style="padding: 10px;">
										<div style="white-space:nowrap; text-overflow: ellipsis; overflow: hidden; font-weight: bold;">상품 명 : {{ one.pro_nm }}</div>
										<div style="font-weight: bold;">가격 : {{ one.pro_sup_price | comma }} 원</div>
										<textarea readonly="readonly" style="resize:none; margin-top: 10px; height:150px; border: 1px solid lightgray;">{{ one.pro_dt }}</textarea>
									</div>
								</div>
							</div>
						</div>
						
						<a class="slidePrev" @click="fn_prevSlide()">&#10094;</a>
						<a class="slideNext" @click="fn_nextSlide()">&#10095;</a>
						
					</template>
				</div>
			</div>
		</div>
	</div>  

	<!--// 모달팝업 -->
	<div id="productPop" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong>상품 정보</strong>
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
							<th scope="row">모델 번호</th>
							<td>
								<input type="text" class="inputTxt p100" name="pro_cd" id="pro_cd" v-model="pro_cd" readonly/>
							 </td>
							 <th scope="row">카테고리</th>
							<td>
								<select id="searchProCtdt" name="searchProCtdt" v-model="searchProCtdt" disabled>
							    </select>
							 </td>
						</tr>
						<tr>
							<th scope="row">제품 이미지</th>
							<td colspan="3">
							      <div id="filepreview" v-html="inserhtml"></div>
							 </td>
						</tr>
						<tr>
							<th scope="row">제조사</th>
							<td>
								<input type="text" class="inputTxt p100" name="pro_mfc" id="pro_mfc" v-model="pro_mfc" readonly/>
							 </td>
							<th scope="row">주문 수량</th>
							<td id="">
								<input type="number" id="cart_cnt" name="cart_cnt" value="1" v-model="cart_cnt" class="num" min="1" style="height:28px;"/>
							 </td>
						</tr>
						<tr>
							<th scope="row">판매가격</th>
							<td>
								<input type="text" class="inputTxt p100" name="pro_sup_price" id="pro_sup_price" v-model="pro_sup_price" readonly/>
							 </td>
							<th scope="row">납품희망일</th>
							<td id=""> 
								<input type="date" id="order_hope_date" name="order_hope_date" v-model="order_hope_date" :min="order_hope_date_min" style="height:28px;">
							 </td>
						</tr>
						<tr>
							<th scope="row">상세정보 <span class="font_red">*</span></th>
							<td colspan="3">
							     <textarea name="pro_dt" id="pro_dt" v-model="pro_dt" rows="5" cols="30"  readonly></textarea>
						    </td>
						</tr>
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSaveCart" name="btn"><span>장바구니 추가</span></a> 
					<a href="" class="btnType blue" id="btnOrder" name="btn"><span>주문하기</span></a> 
					<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop" id="btnClose" name="btn"><span class="hidden">닫기</span></a>
	</div>	
      
</form>
</body>
</html>
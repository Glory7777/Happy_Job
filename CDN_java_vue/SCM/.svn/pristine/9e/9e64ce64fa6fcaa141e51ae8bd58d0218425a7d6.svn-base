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
		top: 45%;	
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
	
	/* onload 이벤트  */
	$(document).ready(function() {
		
		// 판매상품 조회
		fn_product();
		
		// 상품분류에 따른 판매상품 조회
		$("#searchSel").change(function(){
			
			// 슬라이드 중지
			$(".slideDiv").stop();
			
			// 타이머 중지
			clearInterval(timer);
			
			fn_product();
		})
		
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
		

	// 판매 상품 조회
	function fn_product(){
		
		var param = {
				searchSel : $("#searchSel").val()
		}
		
		var resultCallback = function(returndata){
			
			$("#productList").empty().append(returndata);
			
			$(".slideDiv").not(".active").hide();
			timer = setInterval(fn_nextSlide, 6000);
			
		};
		callAjax("/dashboard/cusProductList.do", "post", "text", true, param, resultCallback);
	}

	
	// 상품상세 모달
    function fn_popupint(data) {
   		console.log("data:"+JSON.stringify(data));
   		
       	$("#pro_cd").val(data.pro_cd);
       	$("#pro_mfc").val(data.pro_mfc);  
       	$("#pro_sup_price").val(data.pro_sup_price);
       	console.log(data.pro_sup_price);
       	$("#pro_dt").val(data.pro_dt);
       	
       	$("#cart_cnt").val('1');
       	$("#order_hope_date").val("");
       	
       	$("#searchProCtdt").val(data.ct_cd);
       	
       	//$("#action").val("U"); 
       	
       	var file_extention = data.file_extention;
    	var inserhtml ="";
    	
    	if(data.file_nm == "" || data.file_nm == null) {
    		inserhtml = "";
    	} else {
    		    //inserhtml = "<a href='javascript:fn_download()'> "
    		
       	         if(file_extention.toLowerCase() == "jpg" ||  file_extention.toLowerCase() == "png"  ||  file_extention.toLowerCase() == "gif" ) {
			        inserhtml += "<img src='" + data.logic_path + "'   style='width: 100px; height: 100px;''   />";
		         } else {
			       inserhtml += data.file_nm;
		         }        		
    		    
    		    //inserhtml += "</a>"; 
    	}
    	// 
    	$("#filepreview").empty().append(inserhtml);
		console.log($("#filepreview").val());
    }
	
	// 상품 선택
	function fn_selectProduct(pro_cd) {
		
    	var param = {
    			pro_cd : pro_cd
    	}
    	
    	var selectcallback = function(res) {
    		console.log(JSON.stringify(res));  
    		fn_popupint(res.selectProduct);
    		
    		gfModalPop("#productPop");
    		
    	}
    	
    	callAjax("/cus/selectProduct.do", "post", "json", true, param, selectcallback);
    }
	
	
	// 장바구니 담기
	function fn_saveCart(){
		if(!fValidate()) {
    		return;
    	}
		
		$("#action").val("C");
		
    	var param = {
    			action : $("#action").val(),
    			pro_cd : $("#pro_cd").val(),
    			cart_cnt : $("#cart_cnt").val(),
    			order_hope_date : $("#order_hope_date").val()
    	}
    	
    	var savecallback = function(res) {
    		console.log(JSON.stringify(res));
    		
    		if(res.result == "SUCCESS") {
    			alert("장바구니에 추가 되었습니다.");
    			gfCloseModal();
    			
    		}else{
    			alert("이미 장바구니에 있는 상품입니다.");
    			gfCloseModal();
    			
    		}
    		
    	}
    	
    	callAjax("/cus/saveProduct.do", "post", "json", true, param, savecallback);
	}
	
	
	// 주문하기
	function fn_order(){
		if(!fValidate()) {
    		return;
    	}
		
		$("#action").val("O");
		// 단가
		var pro_sup_price = $("#pro_sup_price").val();
		// 수량
		var cart_cnt = $("#cart_cnt").val();
		// 주문금액
		var order_price = pro_sup_price * cart_cnt;
		
		var param = {
    			action : $("#action").val(),
    			
    			pro_cd : $("#pro_cd").val(),
    			order_hope_date : $("#order_hope_date").val(),
    			order_price : order_price,
    			cart_cnt : $("#cart_cnt").val(),
    	}
    	
    	var savecallback = function(res) {
    		console.log(JSON.stringify(res));
    		
    		if(res.result == "SUCCESS") {
    			alert("주문 완료되었습니다.");
    			gfCloseModal();
    			
    		}else{
    			alert("주문 실패.");
    			gfCloseModal();
    			
    		}
    		
    	}
    	
    	callAjax("/cus/saveProduct.do", "post", "json", true, param, savecallback);
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

		// input 요소 가져오기
		var inputDate = document.getElementById("order_hope_date");

		// min 속성 설정
		inputDate.setAttribute("min", formattedDate);
	}
	
	// 이전 슬라이드
	function fn_prevSlide() {
		$(".slideDiv").hide(); // 모든 div 숨김
		var allSlide = $(".slideDiv"); // 모든 div 객체를 변수에 저장
		var currentIndex = 0; // 현재 나타난 슬라이드의 인덱스 변수
		
		// 반복문으로 현재 active클래스를 가진 div를 찾아 index 저장
		$(".slideDiv").each(function(index,item){ 
			if($(this).hasClass("active")) {
				currentIndex = index;
			}
		});
		
		// 새롭게 나타낼 div의 index
		var newIndex = 0;
	    
		if(currentIndex <= 0) {
			// 현재 슬라이드의 index가 0인 경우 마지막 슬라이드로 보냄(무한반복)
			newIndex = allSlide.length-1;
		} else {
			// 현재 슬라이드의 index에서 한 칸 만큼 뒤로 간 index 지정
			newIndex = currentIndex-1;
		}

		// 모든 div에서 active 클래스 제거
		$(".slideDiv").removeClass("active");
	    
		// 새롭게 지정한 index번째 슬라이드에 active 클래스 부여 후 show()
		$(".slideDiv").eq(newIndex).addClass("active");
		$(".slideDiv").eq(newIndex).show();

	}

	// 다음 슬라이드
	function fn_nextSlide() {
		$(".slideDiv").hide();
		var allSlide = $(".slideDiv");
		var currentIndex = 0;
		
		$(".slideDiv").each(function(index,item){
			if($(this).hasClass("active")) {
				currentIndex = index;
			} 
		});
		
		var newIndex = 0;
		
		if(currentIndex >= allSlide.length-1) {
			// 현재 슬라이드 index가 마지막 순서면 0번째로 보냄(무한반복)
			newIndex = 0;
		} else {
			// 현재 슬라이드의 index에서 한 칸 만큼 앞으로 간 index 지정
			newIndex = currentIndex+1;
		}

		$(".slideDiv").removeClass("active");
		$(".slideDiv").eq(newIndex).addClass("active");
		$(".slideDiv").eq(newIndex).show();
		
	}
	
</script>

</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" id="currentPagenotice" />

	<!-- 모달 배경 -->
	<div id="mask"></div>
	<div class="content" style="margin-bottom:20px;">
		<div>
			<p class="conTitle">
				<span>판매 상품</span>
				<span class="fr"> 
				    <select id="searchSel" name="searchsel" style="width: 100px; height: 27px;" >
				    </select>
				</span>
			</p>
			<div id="productList"></div>
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
								<input type="text" class="inputTxt p100" name="pro_cd" id="pro_cd" readonly/>
							 </td>
							 <th scope="row">카테고리</th>
							<td>
								<select id="searchProCtdt" name="searchProCtdt" disabled>
							    </select>
							 </td>
						</tr>
						<tr>
							<th scope="row">제품 이미지</th>
							<td colspan="3">
							      <div id="filepreview"></div>
							 </td>
						</tr>
						<tr>
							<th scope="row">제조사</th>
							<td>
								<input type="text" class="inputTxt p100" name="pro_mfc" id="pro_mfc" readonly/>
							 </td>
							<th scope="row">주문 수량</th>
							<td id="">
								<input type="number" id="cart_cnt" name = "cart_cnt" value="1" class="num" min="1" style="height:28px;" />
							 </td>
						</tr>
						<tr>
							<th scope="row">판매가격</th>
							<td>
								<input type="text" class="inputTxt p100" name="pro_sup_price" id="pro_sup_price" readonly/>
							 </td>
							<th scope="row">납품희망일</th>
							<td id=""> 
								<input type="date" id="order_hope_date" name = "order_hope_date" style="height:28px;"/>
							 </td>
						</tr>
						<tr>
							<th scope="row">상세정보 <span class="font_red">*</span></th>
							<td colspan="3">
							     <textarea name="pro_dt" id="pro_dt"  rows="5" cols="30"  readonly></textarea>
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
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>	
      
</form>
</body>
</html>
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
	
	$(function() {
		
		comcombo("productCD", "searchProCtdt", "all", "");
		comcombo("productCD", "searchProCt", "all", "");
		
		// 상품 목록 조회
		fn_serachList();
		
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
		//오늘 이전날짜 선택 불가
		dateCheck();
		
	});
	
	 
	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
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

    function fn_serachList(currentPage) {
    	
    	var currentPage = currentPage || 1;
    	
    	var param = {
    			pageSize : pageSize,
    			currntPage : currentPage,
    			searchsel : $("#searchsel").val(),
    			searchtext : $("#searchtext").val(),
    			searchProCt : $("#searchProCt").val()
    	}
    	
       var listcallback = function(res) {
    		//console.log(res);
    		
    		$("#listProduct").empty().append(res);
    		
    		console.log($("#totalcnt").val());
    		
    		var totalcnt = $("#totalcnt").val();
    		
    		var paginationHtml = getPaginationHtml(currentPage, totalcnt, pageSize, pageBlockSize, 'fn_serachList');
    		//console.log("paginationHtml : " + paginationHtml);
    		//swal(paginationHtml);
    		$("#noticePagination").empty().append( paginationHtml );
    		
    		// 현재 페이지 설정
    		$("#currentPagenotice").val(currentPage);
    		
    	}
    	
    	callAjax("/cus/listProduct.do", "post", "text", true, param, listcallback);
    	
    }
    
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
    			
    			fn_serachList($("#currentPagenotice").val());
    		}else{
    			alert("이미 장바구니에 있는 상품입니다.");
    			gfCloseModal();
    			
    			fn_serachList($("#currentPagenotice").val());
    		}
    		
    	}
    	
    	callAjax("/cus/saveProduct.do", "post", "json", true, param, savecallback);
		
	}
	
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
    			
    			fn_serachList($("#currentPagenotice").val());
    		}else{
    			alert("주문 실패.");
    			gfCloseModal();
    			
    			fn_serachList($("#currentPagenotice").val());
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
								class="btn_nav bold">주문</span> <span class="btn_nav bold"> 상품 목록
								</span> <a href="/cus/product.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>상품 목록</span> 
							<span class="fr"> 
							    <select id="searchProCt" name="searchProCt">
							    </select>		
							    <select id="searchsel" name="searchsel">
							         <option value="">전체</option>
							         <option value="proNm">상품명</option>
							         <option value="proMfc">제조사</option>
							    </select>
							    <input type="text" id="searchtext" name="searchtext"  style="width: 150px; height: 25px;" />
							    <a class="btnType blue" href="javascript:fn_serachList();" name="modal"><span>검색</span></a>
							</span>
						</p>
						
						<div class="divComGrpCodList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="20%">
									<col width="20%">
									<col width="20%">
									<col width="20%">
									<col width="20%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">상품코드</th>
										<th scope="col">카테고리</th>
										<th scope="col">상품명</th>
										<th scope="col">제조사</th>
										<th scope="col">판매단가</th>
									</tr>
								</thead>
								<tbody id="listProduct"></tbody>
							</table>
						</div>
	
						<div class="paging_area"  id="noticePagination"> </div>
						
						
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
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
								<input type="number" id="cart_cnt" name = "cart_cnt" value="1" class="num" min="1" />
							 </td>
						</tr>
						<tr>
							<th scope="row">판매가격</th>
							<td>
								<input type="text" class="inputTxt p100" name="pro_sup_price" id="pro_sup_price" readonly/>
							 </td>
							<th scope="row">납품희망일</th>
							<td id=""> 
								<input type="date" id="order_hope_date" name = "order_hope_date" >
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
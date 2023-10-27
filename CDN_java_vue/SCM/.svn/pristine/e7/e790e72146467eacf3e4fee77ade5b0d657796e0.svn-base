<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<title>배송 지시서 </title>

<!-- common Include -->
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<script>
	// 페이징 설정
	var pageSize = 10;
	var pageBlockSize = 5;
	
	$(function() {
		
		//comcombo("productCD", "searchProCtdt", "all", "");
		//comcombo("productCD", "searchProCt", "all", "");
		
		// 상품 목록 조회
		fn_serachList();
		
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
		
		$("#deliveryStatusCheck").change(function(){
			fn_serachList();
		});
	});
	
	 
	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();
	
			var btnId = $(this).attr('id');
	
			switch (btnId) {
				case 'btnDelivery' :	
					fn_updateDelivery('0');
					break;					
				case 'btnDeliveryFin' :
					fn_updateDelivery('1');
					break;
				case 'btnClose' :
					gfCloseModal();
					break;
					
			}
		});
	}
	
	function fn_serachList(currentPage) {
		var deliveryStatusCheck = $('#deliveryStatusCheck').is(':checked');
		var startDate = $('#startDate').val();
		var endDate = $('#endDate').val();
		console.log('startDate:'+startDate+'endDate:'+endDate);
		
		var currentPage = currentPage || 1;
		
		var param = {
				pageSize : pageSize,
				currntPage : currentPage,
				deliveryStatusCheck : deliveryStatusCheck,
				startDate : startDate,
				endDate : endDate
		}
		
	   var listcallback = function(res) {
			//console.log(res);
			
			$("#listDeliveryDirection").empty().append(res);
			
			console.log($("#totalcnt").val());
			
			var totalcnt = $("#totalcnt").val();
			
			var paginationHtml = getPaginationHtml(currentPage, totalcnt, pageSize, pageBlockSize, 'fn_serachList');
			//console.log("paginationHtml : " + paginationHtml);
			//swal(paginationHtml);
			$("#listDeliveryDirectionPagination").empty().append( paginationHtml );
			
			// 현재 페이지 설정
			$("#currentPagenotice").val(currentPage);
			
		}
		
		callAjax("/dlm/listDeliveryDirection.do", "post", "text", true, param, listcallback);
		
	}
	
	function fn_popupint(data) {
			console.log("data:"+JSON.stringify(data));
		
	   	$("#order_cd").val(data.order_cd);
	   	$("#loginid").val(data.loginid);
	   	$("#addr").val(data.addr);
	   	$("#addr_dt").val(data.addr_dt);
	   	
	   	$("#pro_cd").val(data.pro_cd);
	   	$("#pro_nm").val(data.pro_nm);
	   	$("#order_cnt").val(data.order_cnt);
	   	
	
	}
	
	function fn_selectDelivery(direc_cd, status, deli_cd) {
		$("#deli_cd").val(deli_cd);
		//console.log($("#deli_cd").val());
		
		if(status == '0'){
			$("#btnDelivery").show();
			$("#btnDeliveryFin").hide();
		}else if(status == '1'){
			$("#btnDelivery").hide();
			$("#btnDeliveryFin").show();
		}else{
			$("#btnDelivery").hide();
			$("#btnDeliveryFin").hide();
		}
		
		var param = {
				direc_cd : direc_cd
		}
		
		var selectcallback = function(res) {
			console.log(JSON.stringify(res));  
			fn_popupint(res.selectDeliveryDirection);
			
			gfModalPop("#deliveryPop");
			
			
		}
		
		callAjax("/dlm/selectDeliveryDirection.do", "post", "json", true, param, selectcallback);
		
	}
	
	function fn_updateDelivery(action){
		console.log(action);
		console.log($("#deli_cd").val());
		
		var param = {
				action : action,
				deli_cd : $("#deli_cd").val(),
		}
		
		var savecallback = function(res) {
			console.log(JSON.stringify(res));
			
			if(res.result == "SUCCESS") {
				alert("배송 처리되었습니다. \n 배송상태: 배송중");
				gfCloseModal();
				
				fn_serachList($("#currentPagenotice").val());
			}else if(res.result == "SUCCESSFin"){
				alert("배송 완료되었습니다. \n 배송상태: 배송완료");
				gfCloseModal();
				
				fn_serachList($("#currentPagenotice").val());
			}else{
				alert("배송 처리 실패.");
				gfCloseModal();
				
				fn_serachList($("#currentPagenotice").val());
			}
			
		}
		
		callAjax("/dlm/updateDelivery.do", "post", "json", true, param, savecallback);
		
	}
	
	function fn_updateDeliveryFin(){
		
	}
	
</script>
</head>
<body>
	<form id="myForm" action=""  method="">
	    <input type="hidden" id="currentPagenotice" />
	    <input type="hidden" id="action"  name="action" />
	    <input type="hidden" id="deli_cd" name="deli_cd"/>
		
		<div id="wrap_area">
			
			<!-- header Include -->
			<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>
			
			<div id="container">
				<ul>
					<li class="lnb">
					
						<!-- lnb Include -->
						<jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include>
						
					</li>
					<li class="contents">
						<div class="content">
							<!-- 메뉴 경로 영역 -->
							<p class="Location">
								<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a> <a href="#"
									class="btn_nav">기업고객</a> <span class="btn_nav bold">배송 지시서 목록</span> <a href="/dlm/deliveryDirection.do" class="btn_set refresh">새로고침</a>
							</p>
							
							<!-- 검색 영역 -->
							<p class="search">
							
							</p>							
							<p class="conTitle" id="searchArea">
							<span>배송 지시서 목록_배송담당자</span>
								 <span class="fr"> 
								 		지시서 작성일 검색: 
										<input type="date" id="startDate" name="startDate" placeholder="시작일 선택"></input>
										<input type="date" id="endDate" name="endDate" placeholder="종료일 선택"></input>
										<a class="btnType blue" href="javascript:fn_serachList()" onkeydown="enterKey()" name="search">
										<span id="searchEnter">검색</span></a>			
								</span>
							</p>
							<span class="fr">								
								<input type="checkbox" id="deliveryStatusCheck"> 배송준비중만 조회
							</span>	
							<!-- 테이블 영역 -->
							<div class="divDeliveryBuyer" id="divDeliveryBuyer">
								<table class="col">
									<colgroup>
										<col width="5%">
										<col width="5%">
										<col width="5%">
										<col width="15%">
										<col width="10%">
										<col width="10%">
										<col width="5%">
									</colgroup>
									<thead>
										<tr>
											<th scope="col">배송번호</th>
											<th scope="col">주문번호</th>
											<th scope="col">상품번호</th>
											<th scope="col">상품명</th>
											<th scope="col">주문고객</th>
											<th scope="col">배송희망일</th>
											<th scope="col">배송상태</th>
										</tr>
									</thead>
									
									<!--  -->
									<tbody id="listDeliveryDirection">
									</tbody>									
								</table>
							</div>	<!-- .divDeliveryBuyerList 종료 -->
							<br/>
							<!-- 테이블 페이지 네비게이션 영역 -->
							<div class="pagingArea" id="listDeliveryDirectionPagination"></div>							
						</div>
					</li>
				</ul>
			</div>
		</div>	
		
		<!-- Modal 시작 -->
		<div id="deliveryPop" class="layerPop layerType2" style="width: 900px;">
		<dl>
			<dt>
				<strong>배송 지시서</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row mt20">
					<caption>caption</caption>
					<colgroup>
						<col width="7%">
						<col width="7%">
						<col width="7%">
						<col width="10%">
						<col width="7%">
						<col width="15%">
						<col width="7%">
						<col width="10%">
					</colgroup>

					<tbody>
						<tr>
							<th scope="row">주문번호</th>
							<td><input style="text-align: center;" type="text" class="inputTxt p100" name="order_cd" id="order_cd" readonly="readonly"/></td>
							<th scope="row">주문고객</th>
							<td><input style="text-align: center;" type="text" class="inputTxt p100" name="loginid" id="loginid" readonly="readonly"/></td>
							<th scope="row">주문고객주소</th>
							<td><input style="text-align: center;" type="text" class="inputTxt p100" name="addr" id="addr" readonly="readonly"/></td>
							<th scope="row">주문고객상세주소</th>
							<td><input style="text-align: center;" type="text" class="inputTxt p100" name="addr_dt" id="addr_dt" readonly="readonly"/></td>
						</tr>
					</tbody>
				</table>
				<table class="row mt20" id="modalDeliveryBuyerDtlList">
					<colgroup>
						<col width="5%">
						<col width="20%">
						<col width="10%">
					</colgroup>
					<thead>
						<tr style="background-color: silver;">
							<th scope="row" style="font-weight: bold;">상품번호</th>
							<th scope="row" style="font-weight: bold;">상품명</th>
							<th scope="row" style="font-weight: bold;">주문수량</th>
						</tr>
					</thead>
					<tbody>	
						<tr>
							<td><input style="text-align: center;" type="text" class="inputTxt p100" name="pro_cd" id="pro_cd" readonly="readonly"/></td>
							<td><input style="text-align: center;" type="text" class="inputTxt p100" name="pro_nm" id="pro_nm" readonly="readonly"/></td>
							<td><input style="text-align: center;" type="text" class="inputTxt p100" name="order_cnt" id="order_cnt" readonly="readonly"/></td>
						</tr>		
					</tbody>	
				</table>
				<!-- 테이블 페이지 네비게이션 영역 -->
				<div class="pagingArea" id="modalDeliveryBuyerDtlPagination"></div>	

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnDelivery" name="btn"><span>배송 처리</span></a>
					<a href="" class="btnType blue" id="btnDeliveryFin" name="btn"><span>배송완료 처리</span></a>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="javascript:gfCloseModal()"	class="btnType gray" name="btn" id="btnClose"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>	
	<!-- Modal 종료 -->		
			
	</form>	
</body>
</html>
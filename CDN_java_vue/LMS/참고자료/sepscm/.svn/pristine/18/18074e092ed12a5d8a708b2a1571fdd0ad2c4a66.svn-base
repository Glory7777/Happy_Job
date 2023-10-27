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
	
	// 화면이 열리면 바로 실행되는 jQuery
    $(function() {
		
    	fn_orderList();
		
	});
	
	function fn_orderList(currentPage) {
		
		var currentPage=currentPage || 1;
		
		var param = {
				
				pageSize : pageSize,
				currentPage : currentPage				
		}
		
		var listCallBack = function(returndata) {
			
			console.log(returndata);
			
			$("#orderList").empty().append(returndata);
			
			console.log($("#totalCnt").val());
			
			var totalCnt=$("#totalCnt").val();
			
			var paginationHtml = getPaginationHtml(currentPage, totalCnt, pageSize, pageBlockSize, 'fn_orderList');
			
			console.log("paginationHtml : "+paginationHtml);
			
			$("#orderPagination").empty().append(paginationHtml);
			
			// 현재 페이지 설정
			$("#currentPageOrder").val(currentPage);			
			
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
		$("#pro_nm").text(data.pro_nm);
		$("#sup_nm").text(data.sup_nm);
		$("#sup_cd").val(data.sup_cd);
		$("#pro_unit_price").text(data.pro_unit_price);
		$("#order_cnt").text(data.order_cnt);
		$("#pro_stock").text(data.pro_stock);
		$("#action").val("I");
		$("#sup_cd").val(data.sup_cd);
		 
	}
	 
	 
	 // 버튼 이벤트 등록
	/*  function fRegisterButtonClickEvent() {
		 
		 $('a[name=btn]').click(function(e) {
			 
			 e.preventDefault();
			 
			 var btnId = $(this).attr('id');
			 
			 switch (btnId) {
			 	
			 case 'btnSave' :
				 fn_Save();				 			 
				 break;
			
			 case 'btnClose' :
				 gfCloseModal();
				 break;			 
			 }			 
		 });		 
	 }	  */
	  
	 
	 function fn_Save() {
		 
		 if(!fValidate()) {
			 return;			 
		 }		 		 
		 
		 var param = {
				 
				 pro_cd : $("#pro_cd").val(),				 
				 pur_cnt : $("#pur_cnt").val(),
				 sup_cd : $("#sup_cd").val(),
				 action : $("#action").val()				 
		 }
		 
		 var saveCallBack = function(returnValue) {
			 
			 console.log(JSON.stringify(returnValue));
			 
			 if(returnValue.result == "SUCCESS") {
				 
				 alert("발주 지시서 작성 완료");
				 gfCloseModal();				 
			 } 			 
		 }
		 
		 callAjax("/scm/purchaseSave.do", "post", "json", true, param, saveCallBack);	
		 
	 }	    	    	
		   
		    
			/** 저장 validation */
			function fValidate() {

				var chk = checkNotEmpty(
						[
								[ "pur_cnt", "수량을 입력해 주세요." ]
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
	  <input type="hidden" id="pro_cd" name="pro_cd" />
	  <input type="hidden" id="sup_cd" name="sup_cd" />
	 
	
	
	
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
							
							<a href="/scm/noticeMgr.do" class="btn_set refresh">새로고침</a>
                       </p>
						<p class="conTitle">  
							<span>일별 수주 내역</span> 							
						</p>
						
						<div class="divComGrpCodList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="7%">
									<col width="7%">
									<col width="7%">
									<col width="16%">
									<col width="7%">
									<col width="7%">
									<col width="7%">
									<col width="7%">
									<col width="7%">
									<col width="7%">
									<col width="7%">
									<col width="7%">
									<col width="7%">									
								</colgroup>
								
								<thead>
									<tr>
										<th scope="col">주문 코드</th>
										<th scope="col">주문 일자</th>
										<th scope="col">고객 기업</th>
										<th scope="col">상품명</th>
										<th scope="col">공급 단가</th>
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
							<th scope="row">납품 업체명</th>
							<th scope="row">납품 단가</th>
							<th scope="row">주문 수량</th>
							<th scope="row">재고</th>	
							<th scope="row">발주 수량</th>						
						</tr>
						<tr>
							<td id="pro_nm" style="text-align: center;"></td>
							<td id="sup_nm" style="text-align: center;"></td>
							<td id="pro_unit_price" style="text-align: center;"></td>
							<td id="order_cnt" style="text-align: center;"></td>
							<td id="pro_stock" style="text-align: center;"></td>
							<td>							
								<input type="text" id="pur_cnt" name="pur_cnt" style="width:70px;">								
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
	
	
</form>
</body>
</html>
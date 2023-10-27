<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>발주 승인 리스트</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->

<script type="text/javascript">
	// 페이징 설정
	var pageSize = 10;
	var pageBlockSize = 5;
	
		
   $(function() {
      
	   fn_approvalList();
	      
      // 버튼 이벤트 등록
      fRegisterButtonClickEvent();
       
       $("#searchAppr").change(function(){
    	   fn_approvalList();
       });        
   
   }); 	
	
	
	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();
	
			var btnId = $(this).attr('id');
	
			switch (btnId) {
				case 'btnSave' :
					fn_Save();
					break;
				
				case 'btnClose' :
					gfCloseModal();
					
					if($("#action").val() == "U") {
	    				fn_approvalList($("#currentPageAppr").val());
	    			}					
					break;					
			}
		});
	}
	
	
	function fn_approvalList(currentPage) {
		
		var currentPage=currentPage || 1;
		
		var searchAppr = $("#searchAppr").is(":checked");
		
		var searchStartDate = $("#searchStartDate").val();
		
		var searchEndDate = $("#searchEndDate").val();
				
		var param = {
				
				pageSize : pageSize,
				currentPage : currentPage	,
				searchsel : $("#searchsel").val(),
    			searchtext : $("#searchtext").val(),    			
    			searchAppr : searchAppr,
    			searchStartDate : searchStartDate,
    			searchEndDate : searchEndDate
		}
		
		var listCallBack = function(returnData) {
			
			console.log(returnData);
			
			$("#approvalList").empty().append(returnData);
			
			console.log($("#totalCnt").val());
			
			var totalCnt=$("#totalCnt").val();
			
			var paginationHtml = getPaginationHtml(currentPage, totalCnt, pageSize, pageBlockSize, 'fn_approvalList');
			
			console.log("paginationHtml : "+paginationHtml);
			
			$("#approvalPagination").empty().append(paginationHtml);
			
			// 현재 페이지 설정
			$("#currentPageAppr").val(currentPage);			
			
		}
		
		callAjax("/exe/approvalList.do", "post", "text", true, param, listCallBack);
		
	}	
	

	function fn_selectPurchase(pur_cd) {
		
		var param = {
				pur_cd : pur_cd 				
		}
		
		var selectCallBack = function(returnData) {
			
			console.log(JSON.stringify(returnData));		
						
			fn_popupInt(returnData.sectInfo);
			
			gfModalPop("#approvalPop");
			
		}		
		
		callAjax("/exe/purchaseSelect.do", "post", "json", true, param, selectCallBack);
		
	}
	
	 function fn_popupInt(data) {	 
		    
			$("#pur_cd").val(data.pur_cd);
			$("#pro_cd").text(data.pro_cd);
			$("#pro_nm").text(data.pro_nm);
			$("#pro_sup_price").text(data.pro_sup_price);
			$("#pro_unit_price").text(data.pro_unit_price);
			$("#pro_stock").text(data.pro_stock);
			$("#pur_cnt").text(data.pur_cnt);
			$("#pur_total_unit_price").text(data.pur_total_unit_price);
			$("#sup_cd").text(data.sup_cd);
			$("#sup_nm").text(data.sup_nm);
			$("#pur_nm").text(data.pur_nm);
			$("#pur_date").text(data.pur_date);
			$("#action").val("U");
			
			$("#pur_appr_date").text(data.pur_appr_date);			
						
			if(data.pur_appr == '0') {
				
				$("#pur_appr").text('미승인');
				
			} else if(data.pur_appr == '1') {
				
				$("#pur_appr").text('승인');
				
			} else if(data.pur_appr == '2') {
				
				$("#pur_appr").text('입금 완료');
				
			} else if(data.pur_appr == '3') {
				
				$("#pur_appr").text('입고 완료');
				
			} 
			
			// 	admin_nm (승인자 이름) vale가 null인 경우 화면에 null이라 표시되므로 이런 조치 취함		
			if(data.admin_nm == null) {
				
				$("#admin_nm").text('');
				
				$("#btnSave").show();
				
			} else {
				// admin_nm (승인자 이름) vale가 null이 아닌 경우 승인 버튼(btnSave)을 숨김
				$("#admin_nm").text(data.admin_nm);
				
				$("#btnSave").hide();
				
			}			
		}
	 

	// 발주 테이블을 update하기 위한 함수
	function fn_Save() {    	
    	
    	var param = {
    			action : $("#action").val(),
    			pur_cd : $("#pur_cd").val(),
    	}
    	
    	
    	if (confirm("승인 하시겠습니까?")) {
    		 
    		var saveCallBack = function(returnValue) {
        		console.log(JSON.stringify(returnValue));
        		
        		if(returnValue.result == "SUCCESS") {
        			alert("발주 지시서 승인 완료");   
        			gfCloseModal();
        			    				
        			fn_approvalList($("#currentPageAppr").val());    			
        			
        		}
        		
        	}
        	
        	callAjax("/exe/purchaseApprovalSave.do", "post", "json", true, param, saveCallBack);
    		
    		
    		} else {
    		 
    			return;
    		}  	
    	
    	
    }



</script>
</head>

<body>
<form id="myForm" action=""  method="">
	  <input type="hidden" id="currentPageAppr" />
	  <input type="hidden" id="action"  name="action" />
	  <input type="hidden" id="pur_cd" name="pur_cd" />
	  
	 
	
	
	
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
							<a href="">승인</a>&nbsp;/&nbsp;				
							<span><strong>구매 승인</strong></span>							
							<a href="/exe/orderConfirm.do" class="btn_set refresh">새로고침</a>
                       </p>
						<p class="conTitle">  
							<span>발주 목록</span>
							<span class="fr">
								<input type="date" id="searchStartDate" name="searchStartDate" style="height: 25px;">&nbsp;~&nbsp;	
								<input type="date" id="searchEndDate" name="searchEndDate" style="height: 25px;">&nbsp;&nbsp;&nbsp;&nbsp;
															     							    		
							    <select id="searchsel" name="searchsel" style="width:100px;">
							         <option value="">전체</option>
							         <option value="product">상품명</option>
							         <option value="supplier">납품 업체명</option>							         
							    </select>
							    <input type="text" id="searchtext" name="searchtext"  style="width: 150px; height: 25px;" />
							    <a class="btnType blue" href="javascript:fn_approvalList();" name="modal"><span>검색</span></a>							    
							</span> 							
						</p>
						<br>
						
						<label style="display: flex; justify-content: flex-end;">
							<input type="checkbox" name="searchAppr" id="searchAppr">&nbsp;<span>미승인 목록 조회</span>
						</label>						
						
						<div class="divComGrpCodList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="16%">
									<col width="20%">
									<col width="9%">
									<col width="9%">
									<col width="9%">
									<col width="9%">
									<col width="9%">
									<col width="9%">
									<col width="10%">																																
								</colgroup>
								
								<thead>
									<tr>
										<th scope="col">발주 일자</th>
										<th scope="col">상품명</th>
										<th scope="col">재고</th>										
										<th scope="col">발주 수량</th>
										<th scope="col">납품 단가</th>
										<th scope="col">총 납품액</th>
										<th scope="col">납품 업체명</th>
										<th scope="col">발주 상태</th>
										<th scope="col">상세 보기</th>										
									</tr>
								</thead>
								<tbody id="approvalList"></tbody>
							</table>
						</div>			
	
						<div class="paging_area" id="approvalPagination"></div>
						
						
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>
	
	<!--// 모달팝업 -->
	<div id="approvalPop" class="layerPop layerType2" style="width: 800px;">
		<dl>
			<dt>
				<strong>발주 정보 상세</strong>
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
						<col width="120px">
						<col width="*">
					</colgroup>

					<tbody>
						<tr>							
							<th scope="row">상품명</th>
							<td id="pro_nm">
							 </td>
							 <th scope="row">공급 단가</th>
							<td id="pro_sup_price">
							 </td>
							<th scope="row">납품 단가</th>
							<td id="pro_unit_price">
							 </td>
						</tr>
						<tr>							
							 <th scope="row">재고</th>
							<td id="pro_stock">
							 </td>
							 <th scope="row">발주 수량</th>
							<td id="pur_cnt">
							 </td>
							<th scope="row">총 발주액</th>
							<td id="pur_total_unit_price">
							 </td>			
						</tr>						
						<tr>
							<th scope="row">납품 업체명</th>
							<td id="sup_nm">
							 </td>
							<th scope="row">발주자</th>
							<td id="pur_nm">
							 </td>
							 <th scope="row">발주 일자</th>
							<td id="pur_date">
							 </td>
						</tr>
						<tr>
							<th scope="row">발주 승인</th>
							<td id="pur_appr">								
							 </td>
							<th scope="row">승인자</th>
							<td id="admin_nm">									
							 </td>
							 <th scope="row">승인 일자</th>
							<td id="pur_appr_date">
							 </td>
						</tr>
						
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">					
					<a href="" class="btnType blue" id="btnSave" name="btn"><span>승인</span></a>				
					<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>

	
</form>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>상품별 재고 현황</title>
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
    	
    	// 상품 재고 리스트
    	fn_stockedProductList();    
    	
    	// 버튼 이벤트 등록
		fRegisterButtonClickEvent();		
		
	});
	
	
    /** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();
	
			var btnId = $(this).attr('id');
	
			switch (btnId) {				
			case 'btnClose' :
				gfCloseModal();
			    if($("#action").val() == "U") {
    				fn_serachlist($("#currentPageStock").val());
    			}
				break;					
		   }
		});
	}
	
	function fn_stockedProductList(currentPage) {
		
		var currentPage=currentPage || 1;
		
		var param = {
				
				pageSize : pageSize,
				currentPage : currentPage	,
				searchsel : $("#searchsel").val(),
    			searchtext : $("#searchtext").val(),
		}
		
		var listCallBack = function(returnData) {
			
			console.log(returnData);
			
			$("#stockedProductList").empty().append(returnData);
			
			console.log($("#totalCnt").val());
			
			var totalCnt=$("#totalCnt").val();
			
			var paginationHtml = getPaginationHtml(currentPage, totalCnt, pageSize, pageBlockSize, 'fn_stockedProductList');
			
			console.log("paginationHtml : "+paginationHtml);
			
			$("#stockedProductPagination").empty().append(paginationHtml);
			
			// 현재 페이지 설정
			$("#currentPageStock").val(currentPage);			
			
		}
		
		callAjax("/scm/stockedProductList.do", "post", "text", true, param, listCallBack);
		
	}	
	
	
	
	
</script>

</head>
<body>
<form id="myForm" action=""  method="">
	  <input type="hidden" id="currentPageStock" />
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
							<span><strong>상품별 재고 현황</strong></span>
							
							<a href="/scm/whInventoryForm.do" class="btn_set refresh">새로고침</a>
                       </p>
						<p class="conTitle">  
							<span>상품별 재고 현황</span> 
							<span class="fr">
															     							    		
							    <select id="searchsel" name="searchsel" style="width:100px;">
							         <option value="">전체</option>
							         <option value="category">카테고리명</option>
							         <option value="product">상품명</option>							         
							    </select>
							    <input type="text" id="searchtext" name="searchtext"  style="width: 150px; height: 25px;" />
							    <a class="btnType blue" href="javascript:fn_stockedProductList();" name="modal"><span>검색</span></a>							    
							</span>							
						</p>
						<br>
						
						<div class="divComGrpCodList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="7%">
									<col width="7%">
									<col width="17%">
									<col width="27%">
									<col width="26%">
									<col width="16%">																		
								</colgroup>
								
								<thead>
									<tr>
										<th scope="col">카테고리 코드</th>
										<th scope="col">상품 코드</th>
										<th scope="col">카테고리명</th>
										<th scope="col">상품명</th>
										<th scope="col">상품 모델명</th>
										<th scope="col">재고</th>										
									</tr>
								</thead>
								<tbody id="stockedProductList"></tbody>
							</table>
						</div>			
	
						<div class="paging_area" id="stockedProductPagination"></div>
						
						
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>
	
	
</form>

</body>
</html>
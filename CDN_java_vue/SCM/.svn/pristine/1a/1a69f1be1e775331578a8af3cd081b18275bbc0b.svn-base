<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>납품업체정보</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->
              
<script type="text/javascript">

	var pageSize = 10;
	var pageBlockSize = 5;

	/*납품업체 페이징 처리*/
	var pageSizeSupplier = 10;
	var pageBlockSizeSupplier = 5;	

	$(function() {
		
		// 공지사항 조회
		fn_supplierInfoList();
		
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
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
				case 'btnDelete' :
					fn_Delete();
					break;	
				case 'btnClose' :
					gfCloseModal();
					if($("#action").val() == "I") {
	    				fn_productList();
	    			} else if($("#action").val() == "U") {
	    				fn_productList($("#currentPagenotice").val());
	    			} else if($("#action").val() == "D") {
	    				fn_productList();
	    			}
					break;
			}
		});
	}

	
	 
	/*  납품업체 리스트 조회 */
    function fn_supplierInfoList(currentPage) {
    	
    	var currentPage = currentPage || 1;
    	
    	var param = {
    			pageSize : pageSize,
    			currentPage : currentPage,
    			searchText : $("#searchText").val()
    	}
    	
       var listcallback = function(returndata) {
    		console.log(returndata);
    		
    		$("#supplierList").empty().append(returndata);
    		
    		console.log($("#totalCnt").val());
    		
    		var totalCnt = $("#totalCnt").val();
    		
    		var paginationHtml = getPaginationHtml(currentPage, totalCnt, pageSizeSupplier, pageBlockSizeSupplier, 'fn_supplierInfoList');
    		console.log("paginationHtml : " + paginationHtml);
    		//swal(paginationHtml);
    		$("#supplierPagination").empty().append( paginationHtml );
    		
    		// 현재 페이지 설정
    		$("#currentPageSupplier").val(currentPage);
    		
    	}
    	
    	callAjax("/dlm/supplierInfoList.do", "post", "text", true, param, listcallback);
    	
    }
	

    

</script>

</head>

<body>
<c:if test="${sessionScope.userType ne 'D'}">
    <c:redirect url="/dashboard/dashboard.do"/>
</c:if>

<form id="myForm" action="" method="">
	<input type="hidden" id="currentPageSupplier" />
	<input type="hidden" id="selectProductCd"  name="selectProductCd" />
	<input type="hidden" id="file_cd"  name="file_cd" />
	<input type="hidden" id="action"  name="action" />
	 
	<!-- 모달 배경 -->
	<div id="mask"></div>
	<div id="wrap_area">
			<h2 class="hidden">header 영역</h2>
			<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>
			<h2 class="hidden">컨텐츠 영역</h2>
			<div id="container">
				<ul>
					<li class="lnb">
						<!-- lnb 영역 --> 
						<jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include>
					</li>
					<li class="contents">
						<!-- contents -->
						<h3 class="hidden">contents 영역</h3> <!-- content -->
						<div class="content">
							<p class="Location">
								<a href="/dashboard/dashboard.do" class="btn_set home">메인으로</a> 
								<a class="btn_nav">기준 정보</a>
								 <span class="btn_nav bold">납품 업체 정보</span> 
								<a href="" class="btn_set refresh">새로고침</a>
							</p>

							<p class="conTitle">
								<span>납품 업체 정보</span>
								<span class="fr"> 
								</span>
							</p>

							<div class="supplierList">
								<div class="conTitle" style="margin: 0 25px 10px 0; float: right;">
									<input type="text" style="width: 160px; height: 30px;" id="searchText" name="searchText">
									<a href="" class="btnType blue" id="searchBtn" name="btn"> 
										<span>검 색</span>
									</a> 
								</div>
								<table class="col">
									<caption>caption</caption>
									<colgroup>
										<col width="5%">
										<col width="15%">
										<col width="10%">
										<col width="10%">
										<col width="15%">
										<col width="45%">
									</colgroup>

									<thead>
										<tr>
											<th scope="col">번호</th>
											<th scope="col">납품업체명</th>
											<th scope="col">담당자명</th>
											<th scope="col">담당자 연락처</th>
											<th scopt="col">담당자 이메일</th>
											<th scopt="col">주소지</th>
										</tr>
									</thead>
									<tbody id="supplierList"></tbody>
								</table>
							</div>

							<div class="paging_area" id="supplierPagination"></div>


						</div> <!--// content -->

						<h3 class="hidden">풋터 영역</h3> <jsp:include
							page="/WEB-INF/view/common/footer.jsp"></jsp:include>
					</li>
				</ul>
			</div>
		</div>
	

</form>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>납품업체관리</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->
              
<script type="text/javascript">
	// 페이징 설정
	var pageSize = 5;
	var pageBlockSize = 5;
	
	/*납품업체 페이징 처리*/
	var pageSizeSupplier = 5;
	var pageBlockSizeSupplier = 5;

	//제품정보 페이징 처리
	var pageSizeProduct = 5;
	var pageBlockSizeProduct = 5;
	

	$(function() {
		
		// 공지사항 조회
		fn_supplierList();
		
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
						fn_supplierList();
	    			} else if($("#action").val() == "U") {
	    				fn_supplierList($("#currentPageSupplier").val());
	    			} else if($("#action").val() == "D") {
	    				fn_supplierList($("#currentPageSupplier").val());
	    			}
					break;
			}
		});
	}

	
	 
	/*  납품업체 리스트 조회 */
    function fn_supplierList(currentPage) {
    	
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
    		
    		var paginationHtml = getPaginationHtml(currentPage, totalCnt, pageSizeSupplier, pageBlockSizeSupplier, 'fn_supplierList');
    		console.log("paginationHtml : " + paginationHtml);
    		//swal(paginationHtml);
    		$("#supplierPagination").empty().append( paginationHtml );
    		
    		// 현재 페이지 설정
    		$("#currentPageSupplier").val(currentPage);
    		
    	}
    	
    	callAjax("/scm/supplierList.do", "post", "text", true, param, listcallback);
    	
    }
	
	/* 납품업체 하위 상품조회 */
    function fn_selectSupplier(sup_cd){
    	
    	var currentPage = currentPage || 1;
    	
    	var param = {
    			sup_cd : sup_cd,
    			pageSize : pageSize,
    			currentPage : currentPage
    	}
    	
       var listcallback = function(returndata) {
    		console.log(returndata);
    		
    		$("#supProductList").empty().append(returndata);
    		
    		console.log($("#productTotalCnt").val());
    		
    		var totalCnt = $("#productTotalCnt").val();
    		
    		var paginationHtml = getPaginationHtml(currentPage, totalCnt, pageSizeProduct, pageBlockSizeProduct, 'fn_selectSupplier');
    		console.log("paginationHtml : " + paginationHtml);
    		//swal(paginationHtml);
    		$("#productPagination").empty().append( paginationHtml );
    		
    		// 현재 페이지 설정
    		$("#currentPageProduct").val(currentPage);
    		
    	}
    	
    	callAjax("/scm/supProductList.do", "post", "text", true, param, listcallback);
    	
    }
	
	
	/* 등록 및 수정 팝업 */
	
	function fn_openPopup() {
		
		fn_popupint();    	
		
		gfModalPop("#supplierPop");
	}
	

    function fn_popupint(data){
    	
    	if(data == null || data == undefined || data == "") {
    		
    		$("#action").val("I");  
    		
    		$("#sup_nm").val("");    		
    		$("#sup_manager").val("");
    		$("#sup_hp").val("");
    		$("#sup_email").val("");
    		$("#sup_addr").val("");

        	$("#selectSupplierCd").val("");
        	
        	$("#btnDelete").hide();
    		
    	} else {
    		
    		$("#action").val("U");  
    		
    		$("#sup_nm").val(data.sup_nm);    		
    		$("#sup_manager").val(data.sup_manager);
    		$("#sup_hp").val(data.sup_hp);
    		$("#sup_email").val(data.sup_email);
    		$("#sup_addr").val(data.sup_addr);
    		
    		console.log(data.sup_cd + "테스트");
    		
        	$("#selectSupplierCd").val(data.sup_cd);    	
        	
        	$("#btnDelete").show();
    	}
    	
    }
    
    function fn_updateSupplier(sup_cd) {
    	
    	var param = {
    			sup_cd : sup_cd
    	}
    	
    	var selectcallback = function(returnMap) {
    		console.log(JSON.stringify(returnMap));  
    		
    		fn_popupint(returnMap.selectSupplier);
    		
    		gfModalPop("#supplierPop");
    	}
    	
    	callAjax("/scm/supplierUpdate.do", "post", "json", true, param, selectcallback);
    	
    }
    
	/** 유효성검사 validation */
	function fValidate() {

		var chk = checkNotEmpty(
				[
						[ "sup_nm", "납품업체명을 입력해 주세요." ],
						[ "sup_manager", "담당자를 입력해 주세요" ],
						[ "sup_hp", "담당자번호를 입력해 주세요." ],
						[ "sup_email", "이메일을 입력해 주세요." ],
						[ "sup_addr", "주소지를 입력해 주세요." ]
				]
		);

		if (!chk) {
			return;
		}

		return true;
	}
	

	/* 저장하기 */
    function fn_Save() {
    	
    	if(!fValidate()) {
    		return;
    	}

    	var param = {
    			action : $("#action").val(),
    			sup_nm : $("#sup_nm").val(),
    			sup_manager : $("#sup_manager").val(),
    			sup_hp : $("#sup_hp").val(),
    			sup_addr : $("#sup_addr").val(),
    			sup_email : $("#sup_email").val(),
    			sup_cd : $("#selectSupplierCd").val()
    	}
    	
    	var savecallback = function(returnvalue) {
    		console.log(JSON.stringify(returnvalue));
    		
    		if(returnvalue.result == "SUCCESS") {
    			alert("저장 되었습니다.");
    			gfCloseModal();
    			
    			if($("#action").val() == "I") {
    				fn_supplierList();
    			} else if($("#action").val() == "U") {
    				fn_supplierList($("#currentPageSupplier").val());
    			} else if($("#action").val() == "D") {
    				fn_supplierList();
    			}
    		}
    		
    	}
    	
    	callAjax("/scm/supplierSave.do", "post", "json", true, param, savecallback);
    }
	
	/* 삭제하기 */
    function fn_Delete() {
    	$("#action").val("D"); 
    	fn_Save();
    }
	
    

</script>

</head>

<body>
<c:if test="${sessionScope.userType ne 'S'}">
    <c:redirect url="/dashboard/dashboard.do"/>
</c:if>

<form id="myForm" action="" method="">
	<input type="hidden" id="currentPageSupplier" />
	<input type="hidden" id="currentPageProduct" />
	<input type="hidden" id="selectProductCd"  name="selectProductCd" />
	<input type="hidden" id="selectSupplierCd"  name="selectSupplierCd" />
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
									<a href="javascript:fn_openPopup();" class="btnType blue" name="modal">
										<span>신규등록</span>
									</a>
								</span>
							</p>

							<div class="supplierList">
								<div class="conTitle" style="margin: 0 25px 10px 0; float: right;">
									<input type="text" style="width: 160px; height: 30px;" id="searchText" name="searchText">
									<a onclick="fn_supplierList(); return false;" class="btnType blue" id="searchBtn" name="btn"> 
										<span>검 색</span>
									</a> 
								</div>
								<table class="col">
									<caption>caption</caption>
									<colgroup>
										<col width="5%">
										<col width="15%">
										<col width="8%">
										<col width="15%">
										<col width="16%">
										<col width="35%">
										<col width="6%">
									</colgroup>

									<thead>
										<tr>
											<th scope="col">번호</th>
											<th scope="col">납품업체명</th>
											<th scope="col">담당자명</th>
											<th scope="col">연락처</th>
											<th scopt="col">이메일</th>
											<th scopt="col">주소지</th>
											<th scope="col">비고</th>
										</tr>
									</thead>
									<tbody id="supplierList"></tbody>
								</table>
							</div>

							<div class="paging_area" id="supplierPagination"></div>

							<p class="conTitle mt50">
								<span>제품 정보</span>
							</p>


							<div class="ProductList">
								<table class="col">
									<caption>caption</caption>
									<colgroup>
										<col width="10%">
										<col width="40%">
										<col width="10%">
										<col width="20%">
										<col width="20%">
									</colgroup>
									<thead>
										<tr>
											<th scope="col">제품번호</th>
											<th scope="col">제품명</th>
											<th scope="col">재고</th>
											<th scope="col">공급가</th>
											<th scope="col">납품단가</th>
										</tr>
									</thead>
									<tbody id=supProductList>
										<tr>
											<td colspan="5">납품업체를 선택해 주세요.</td>
										</tr>
									</tbody>
								</table>
							</div>

							<!-- <div class="paging_area" id="productPagination"></div>
 -->

						</div> <!--// content -->

						<h3 class="hidden">풋터 영역</h3> <jsp:include
							page="/WEB-INF/view/common/footer.jsp"></jsp:include>
					</li>
				</ul>
			</div>
		</div>
		
		
		<!-- 모달! -->
		<div id="supplierPop" class="layerPop layerType2" style="width: 600px;">
			<dl>
				<dt>
					<strong>납품 업체 관리</strong>
				</dt>
				<dd class="content">
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
								<th scope="row">납품업체명 <span class="font_red">*</span></th>
								<td>
									<input type="text" class="inputTxt p100" name="sup_nm" id="sup_nm" />
									<input type="hidden" class="inputTxt p100" name="sup_cd" id="sup_cd" />
								</td>
								<th scope="row">담당자명 <span class="font_red">*</span></th>
								<td>
									<input type="text" class="inputTxt p100"name="sup_manager" id="sup_manager" />
								</td>
							</tr>
							<tr>
								<th scope="row">담당자 연락처 <span class="font_red">*</span></th>
								<td>
									<input type="text" class="inputTxt p100" name="sup_hp" id="sup_hp" />
								</td>
									<th scope="row">담당자 이메일 <span class="font_red">*</span></th>
								<td>
									<input type="text" class="inputTxt p100"name="sup_email" id="sup_email" />
								</td>
							</tr>
							<tr>
								<th scope="row">납품업체 주소지<span class="font_red">*</span></th>
								<td>
									<input type="text" class="inputTxt p100" name="sup_addr" id="sup_addr" />
								</td>
							</tr>
						</tbody>
					</table>


					<div class="btn_areaC mt30">
						<a href="" class="btnType blue"  id="btnSave" name="btn"><span>저장</span></a>
						<a href="" class="btnType blue"  id="btnDelete" name="btn"><span>삭제</span></a>
						<a href="" class="btnType gray" id="btnClose" name="btn"><span>취소</span></a> -->
					</div>
				</dd>
			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div>
	
	

</form>

</body>
</html>
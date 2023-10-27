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
	
	var searcharea;
	var divSupplierList;
	var supplierPop;
	

	$(function() {
		
		vueinit();
		
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
			case 'btnSave' : fn_Save(); //  저장
				//alert("저장버튼 클릭!!!이벤트!!");
				break;
			case 'btnDelete' : fn_Delete();	// 삭제
				//alert("삭제버튼 클릭!!!이벤트!!");		
				break;
			case 'btnUpdate' : fnUpdate();  // 수정하기
				break;
			case 'searchBtn' : fn_supplierList();  // 검색하기
				break;
			case 'btnClose' : gfCloseModal();  // 모달닫기 
				break;
			}
		});
	}
	
function vueinit() {
		
		searcharea = new Vue({
			                   el: "#searcharea",
			               data: {
			            	   searchSel : "",
			            	   searchText : "",
			            	   usertype: "${sessionScope.userType}",
			               }     
		});
		
		divSupplierList = new Vue({
			                  el:"#divSupplierList",
			              data: {
			            	  datalist:[],
		                     totalcnt:0,
		                     pagingnavi: "",
		                     currentPage:0,
		                     usertype: "${sessionScope.userType}",
			              } ,
			            methods : {
			            	fn_selectSupplier : function(pro_cd) {
			            		//alert("fn_selectProduct : " + pro_cd);
			            		fn_selectSupplier(pro_cd);
			            	}
			            	
			            }  
			                  
		});
		
		divProductList = new Vue({
			            el:"#divProductList",
			        data: {
			      	   productlist:[],
			           usertype: "${sessionScope.userType}",
			        } 
			      	
			      
			            
				})
		
		supplierPop = new Vue({
		                    el:"#supplierPop",
		                 data: {
		                	 sup_nm: "",
		                	 sup_cd: "",
		                	 sup_manager:"",
		                	 sup_hp:"",
		                	 sup_addr:"",
		                	 sup_email:"",
		                	
		                	 selectSupplierCd:"",
		                	 
		                	 delflag:false,
		                	 action:"",

		                	 swriter:"${loginId}",
		                	 usertype: "${sessionScope.userType}",
		                	 
		                	
		                 },
		                 
		})
		
		
		
	}
	
	 
	/*  납품업체 리스트 조회 */
    function fn_supplierList(currentPage) {
    	
    	var currentPage = currentPage || 1;
    	
    	var param = {
    			pageSize : pageSize,
    			currentPage : currentPage,
    			searchText : searcharea.searchText,
    			searchDel : ""
    	}
    	
       var listcallback = function(returnData) {
    		console.log(returnData);
    		
    		divSupplierList.datalist = returnData.supList;
    		divSupplierList.totalcnt = returnData.totalCnt;
    		
    		var paginationHtml = getPaginationHtml(currentPage, divSupplierList.totalcnt, pageSize, pageBlockSize, 'fn_supplierList');
    		console.log("paginationHtml : " + paginationHtml);
    		//swal(paginationHtml);
    		divSupplierList.pagingnavi = paginationHtml;
    		
    		divSupplierList.currentPage = currentPage;
    		
    	}
    	
    	callAjax("/scm/supplierListvue.do", "post", "json", true, param, listcallback);
    	
    }
	

	/* 등록 및 수정 팝업 */
	
	function fn_openPopup() {
		
		fn_popupint();    	
		
		gfModalPop("#supplierPop");
	}
	
	
	/* 납품업체 하위 상품조회 */
    function fn_selectSupplier(sup_cd){
    	
		console.log(sup_cd);
		
    	var param = {
    			sup_cd : sup_cd
    	}
    	
       var listcallback = function(returnData) {
    		console.log(returnData);
    		
    		Vue.set(divProductList, 'productlist', returnData.productList);

    	}
    	
    	callAjax("/scm/supProductListvue.do", "post", "json", true, param, listcallback);
    	
    }
	
	

    function fn_popupint(data){
    	
    	if(data == null || data == undefined || data == "") {
    		
			supplierPop.action = "I";
    		
			supplierPop.sup_nm = "";
			supplierPop.sup_manager = "";
			supplierPop.sup_hp = "";
			supplierPop.sup_email = "";
			supplierPop.sup_addr = "";
			
			supplierPop.delflag = false;
    		
    	} else {
    		
			supplierPop.action = "U";
    		
			supplierPop.sup_nm = data.sup_nm;
			supplierPop.sup_manager = data.sup_manager;
			supplierPop.sup_hp = data.sup_hp;
			supplierPop.sup_email = data.sup_email;
			supplierPop.sup_addr = data.sup_addr;
			
			supplierPop.selectSupplierCd = data.sup_cd;
			
			supplierPop.delflag = true;
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
    			action : supplierPop.action,
    			sup_nm : supplierPop.sup_nm,
    			sup_manager : supplierPop.sup_manager,
    			sup_hp : supplierPop.sup_hp,
    			sup_addr : supplierPop.sup_addr,
    			sup_email : supplierPop.sup_email,
    			sup_cd : supplierPop.selectSupplierCd
    	}
    	
    	var savecallback = function(returnvalue) {
    		console.log(JSON.stringify(returnvalue));
    		
    		if(returnvalue.result == "SUCCESS") {
    			alert("저장 되었습니다.");
    			gfCloseModal();
    			
    			if(supplierPop.action == "I") {
    				fn_supplierList();
    			} else if(supplierPop.action == "U") {
    				fn_supplierList($("#currentPageSupplier").val());
    			} else if(supplierPop.action == "D") {
    				fn_supplierList();
    			}
    		}
    		
    	}
    	
    	callAjax("/scm/supplierSave.do", "post", "json", true, param, savecallback);
    }
	
	/* 삭제하기 */
    function fn_Delete() {
    	supplierPop.action ="D";
    	fn_Save();
    }
	
    

</script>

</head>

<body>

<form id="myForm" action="" method="">
	<input type="hidden" id="currentPageSupplier" />
	<input type="hidden" id="currentPageProduct" />
	<input type="hidden" id="selectProductCd"  name="selectProductCd" />
	<input type="hidden" id="selectSupplierCd"  name="selectSupplierCd" />
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
								<div id="searcharea" class="conTitle" style="margin: 0 25px 10px 0; float: right;">
									<input type="text" v-model="searchText"  style="width: 160px; height: 30px;" id="searchText" name="searchText">
									<a onclick="fn_supplierList(); return false;" class="btnType blue" id="searchBtn" name="btn"> 
										<span>검 색</span>
									</a> 
								</div>
								<div id="divSupplierList">								
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
										<tbody id="supplierList">
											<template v-if="totalcnt == 0">
												<tr>   
													<td colspan=7> 데이터가 업습니다.  </td> 
												</tr>
											</template> 
											<template v-else v-for="supplier in datalist">
												<tr >
													<td>{{supplier.sup_cd}}</td>						
													<td @click="fn_selectSupplier(supplier.sup_cd)">{{supplier.sup_nm}}</td>
													<td>{{supplier.sup_manager}}</td>
													<td>{{supplier.sup_hp}}</td>
													<td>{{supplier.sup_email}}</td>
													<td>{{supplier.sup_addr}}</td>
													<td>
														<a @click="fn_updateSupplier(supplier.sup_cd);" class="btnType3 color1"><span>수정</span></a>
													</td>
												</tr>
											</template>										
										</tbody>
									</table>
									<div class="paging_area" id="pagingnavi" v-html="pagingnavi"></div>
								</div>
							</div>


							<p class="conTitle mt50">
								<span>제품 정보</span>
							</p>


							<div id="divProductList" class="divProductList">
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
										<template v-if="productlist.length === 0">
											<tr>   
												<td colspan=5> 데이터가 업습니다.  </td> 
											</tr>
										</template> 
										<template v-else v-for="product in productlist">
											<tr>
												<td>{{product.pro_cd}}</td>						
												<td>{{product.pro_nm}}</td>
												<td>{{product.pro_stock}}</td>
												<td>{{product.pro_unit_price}}</td>
												<td>{{product.pro_sup_price}}</td>
											</tr>
										</template>	
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
			<!-- <input type="hidden" class="inputTxt p100" name="sup_cd" id="sup_cd" /> -->
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
									<input type="text" class="inputTxt p100" name="sup_nm" id="sup_nm" v-model="sup_nm" />
								</td>
								<th scope="row">담당자명 <span class="font_red">*</span></th>
								<td>
									<input type="text" class="inputTxt p100"name="sup_manager" id="sup_manager" v-model="sup_manager" />
								</td>
							</tr>
							<tr>
								<th scope="row">담당자 연락처 <span class="font_red">*</span></th>
								<td>
									<input type="text" class="inputTxt p100" name="sup_hp" id="sup_hp" v-model="sup_hp" />
								</td>
									<th scope="row">담당자 이메일 <span class="font_red">*</span></th>
								<td>
									<input type="text" class="inputTxt p100"name="sup_email" id="sup_email" v-model="sup_email" />
								</td>
							</tr>
							<tr>
								<th scope="row">납품업체 주소지<span class="font_red">*</span></th>
								<td>
									<input type="text" class="inputTxt p100" name="sup_addr" id="sup_addr" v-model="sup_addr" />
								</td>
							</tr>
						</tbody>
					</table>


					<div class="btn_areaC mt30">
						<a href="" class="btnType blue"  id="btnSave" name="btn"><span>저장</span></a>
						<a href="" class="btnType blue"  id="btnDelete" name="btn" v-show="delflag"><span>삭제</span></a>
						<a href="" class="btnType gray" id="btnClose" name="btn"><span>취소</span></a>
					</div>
				</dd>
			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div>
	
	

</form>

</body>
</html>
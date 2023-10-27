<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>상품정보관리</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<link rel="stylesheet" href="${CTX_PATH}/css/admin/modal.css">
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->
              
<script type="text/javascript">
	// 페이징 설정
	var pageSize = 10;
	var pageBlockSize = 5;
	
	$(function() {
		
 		comcombo("productCD", "ct_cd", "sel", ""); 
		
		// 공지사항 조회
		fn_productList();
		
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
	    				fn_productList($("#currentPagenotice").val());
	    			}
					break;
			}
		});
	}

	/*  상품 리스트 조회 */
    function fn_productList(currentPage) {
    	
    	var currentPage = currentPage || 1;
    	
    	var param = {
    			pageSize : pageSize,
    			currentPage : currentPage,
    			searchSel : $("#searchSel").val(),
    			searchText : $("#searchText").val()
    	}
    	
       var listcallback = function(returndata) {
    		console.log(returndata);
    		
    		$("#productList").empty().append(returndata);
    		
    		console.log($("#totalCnt").val());
    		
    		var totalCnt = $("#totalCnt").val();
    		
    		var paginationHtml = getPaginationHtml(currentPage, totalCnt, pageSize, pageBlockSize, 'fn_productList');
    		console.log("paginationHtml : " + paginationHtml);
    		//swal(paginationHtml);
    		$("#productPagination").empty().append( paginationHtml );
    		
    		// 현재 페이지 설정
    		$("#currentPagenotice").val(currentPage);
    		
    	} 	
    	callAjax("/scm/productList.do", "post", "text", true, param, listcallback);
   	
    }
    
	
	/*  팝업창 열기 */
    function fn_openPopupReg() {
		
    	fn_popupint();    	
		
    	// 모달 팝업
		gfModalPop("#productPop");
		
    }
    
    function fn_popupint(data,supList){
    	

    	
    	if(data == null || data == undefined || data == "") {
    		
    		$("#action").val("I");  
    		
    		$("#pro_cd").val("");    		
    		$("#ct_cd").val();
    		$("#pro_nm").val("");
    		$("#pro_model_nm").val("");
    		$("#pro_mfc").val("");
    		$("#pro_sup_price").val("");
    		$("#pro_unit_price").val("");
    		$("#pro_dt").val("");
    		
    		
    		$("#sup_sel_th").show();
    		$("#sup_sel_td").show();
    		$("#sup_list_th").hide();
    		$("#sup_list_td").hide();
    		$("#sup_list_td").empty();
    		
        	$("#selectProductCd").val("");
        	
    		$("#selfile").val("");
        	$("#filepreview").empty();
        	
        	$("#btnDelete").hide();
    		
    	} else {
    		
    		$("#action").val("U");  
    		
    		$("#pro_cd").val(data.pro_cd);    		
    		$("#ct_cd").val(data.ct_cd);
    		$("#pro_nm").val(data.pro_nm);
    		$("#pro_model_nm").val(data.pro_model_nm);
    		$("#pro_mfc").val(data.pro_mfc);
    		$("#pro_sup_price").val(data.pro_sup_price);
    		$("#pro_unit_price").val(data.pro_unit_price);
    		$("#pro_dt").val(data.pro_dt);

    		$("#sup_sel_th").hide();
    		$("#sup_sel_td").hide();
    		$("#sup_list_th").show();
    		$("#sup_list_td").show();
        	$("#sup_list_td").empty().append(supList);

    		$("#selfile").val("");
    		$("#file_cd").val(data.file_cd);
    		
        	$("#selectProductCd").val(data.pro_cd);
        	
        	$("#btnDelete").show();
    		
        	var file_extention = data.file_extention;
        	var inserhtml ="";
        	
        	// 파일 분기
        	if(data.file_nm == "" || data.file_nm == null) {
        		inserhtml = "";
        	} else {
        		    inserhtml = "<a href='javascript:fn_download()'> "
        		
           	         if(file_extention.toLowerCase() == "jpg" ||  file_extention.toLowerCase() == "png"  ||  file_extention.toLowerCase() == "gif" ) {
    			        inserhtml += "<img src='" + data.logic_path + "'   style='width: 100px; height: 100px;''   />";
    		         } else {
    			       inserhtml += data.file_nm;
    		         }        		
        		    inserhtml += "</a>"; 
        	}
        	$("#filepreview").empty().append(inserhtml);

        	$("#btnDelete").show();
    	}
    	
    }

    /* 등록 상품 상세 보기 */
    function fn_selectProduct(pro_cd) {
    	
    	var param = {
    			pro_cd : pro_cd
    	}
    	
    	var selectcallback = function(returnMap) {
    		console.log(JSON.stringify(returnMap));  
    		
    		fn_popupint(returnMap.productSelect, returnMap.supList);
    		
    		gfModalPop("#productPop");
    	}
    	
    	callAjax("/scm/productSelect.do", "post", "json", true, param, selectcallback);
    	
    }
    
	/** 제품등록 유효성검사 validation */
	function fValidate() {

		var chk = checkNotEmpty(
				[
						[ "pro_cd", "상품코드를 입력해 주세요." ],
						[ "ct_cd", "상품 카테고리를 선택해 주세요" ],
						[ "pro_nm", "상품명을 입력해 주세요." ],
						[ "pro_model_nm", "모델명을 입력해 주세요." ],
						[ "pro_mfc", "제조사를 입력해 주세요." ],
						[ "pro_sup_price", "공급 가격을 입력해 주세요." ],
						[ "pro_unit_price", "납품 단가를 입력해 주세요." ],
						[ "sup_cd", "납품업체를 선택해 주세요." ],
						[ "pro_dt", "상품 상세를 입력해 주세요." ]
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

       	var frm = document.getElementById("myForm");
    	frm.enctype = 'multipart/form-data';
    	var fileData = new FormData(frm);
    	
    	var savecallback = function(returnvalue) {
    		console.log(JSON.stringify(returnvalue));
    		
    		if(returnvalue.result == "SUCCESS") {
    			alert("저장 되었습니다.");
    			gfCloseModal();
    			
    			if($("#action").val() == "I") {
    				fn_productList();
    			} else if($("#action").val() == "U") {
    				fn_productList($("#currentPagenotice").val());
    			} else if($("#action").val() == "D") {
    				fn_productList($("#currentPagenotice").val());
    			}
    		}
    		
    	}
    	
    	callAjaxFileUploadSetFormData("/scm/productSave.do", "post", "json", true, fileData, savecallback);
    }
	

    function fn_Delete() {
    	$("#action").val("D"); 
    	fn_Save();
    }

    function imagechage(event) {
    	
    	var image = event.target;
		  
		if(image.files[0]){
			
			var imagepath =  window.URL.createObjectURL(image.files[0])

			var selfile = $("#selfile").val();
			var selfilearr = selfile.split(".");
			
			var inserhtml = "";
			
		   if(selfilearr[1].toLowerCase() == "jpg" ||  selfilearr[1].toLowerCase() == "png"  ||  selfilearr[1].toLowerCase() == "gif" ) {
			   inserhtml = "<img src='" + imagepath + "'   style='width: 100px; height: 100px;''   />";
		   } else {
			   inserhtml = "";
		   }
		   
			// alert(inserhtml);
			
			$("#filepreview").empty().append( inserhtml );
			
		}
    	
    }
    
    
	
</script>

</head>

<body>
<c:if test="${sessionScope.userType ne 'S'}">
    <c:redirect url="/dashboard/dashboard.do"/>
</c:if>

<form id="myForm" action="" method="">
	<input type="hidden" id="currentPagenotice" />
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
				
				<!-- contents -->
				<li class="contents">
					<h3 class="hidden">contents 영역</h3> <!-- content -->
					<div class="content">
						<p class="Location">
							<a href=/dashboard/dashboard.do" class="btn_set home">메인으로</a> 
							<a href="#" class="btn_nav">기준 정보</a> 
								<span class="btn_nav bold">상품정보 관리</span> 
								<a onClick="top.location='javascript:location.reload()'" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>상품정보 관리 </span> 
							<span class="fr"> 
								<a class="btnType blue" href="javascript:fn_openPopupReg();" name="modal">
									<span>상품등록</span>
								</a>
							</span>
						</p>
						
					<!--검색창   -->
					<table width="100%" cellpadding="5" cellspacing="0" border="1" align="left" style="border-collapse: collapse; border: 1px #50bcdf;">
                        <tr style="border: 0px; border-color: blue">
                           <td width="100" height="25" style="font-size: 120%">&nbsp;&nbsp;</td>
                           <td width="50" height="25" style="font-size: 100%; text-align:right;padding-right:25px;">
     	                       <select id="searchSel" name="searchSel" style="width:130px; height:27px">
							       <option value="">전체</option>
							       <option value="pro_cd">상품 번호</option>
							       <option value="pro_nm">상품명</option>
							       <option value="pro_model_nm">모델명</option>
							       <option value="pro_mfc">제조사</option>
						      </select>
	                          <input type="text" id="searchText" name="searchText"  style="width: 150px; height: 25px;" />
							  <a class="btnType blue" href="javascript:fn_productList();" name="modal"><span>검색</span></a>
		
                           </td> 
                        </tr>
                     </table> &nbsp;&nbsp;
						
					<div class="divProductList">
							<table class="col">
								<caption>caption</caption>
									<colgroup>
										<col width="10%">
										<col width="25%">
										<col width="25%">
										<col width="10%">
										<col width="10%">
										<col width="10%">
										<col width="10%">
									</colgroup>
	
								<thead>
									<tr>
									      <th scope="col">상품 코드</th>							              
							              <th scope="col">상품명</th>
							              <th scope="col">모델명</th>
							              <th scope="col">제조사</th>
							              <th scope="col">재고</th>
							              <th scope="col">납품가</th>
							              <th scope="col">판매가</th>
									</tr>
								</thead>
								<tbody id="productList"></tbody>
							</table>
							
							<!-- 페이징 처리 -->
							<div class="paging_area" id="productPagination"></div>		
						</div>
					</div>
					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>

	<!-- 제품정보관리 모달 -->
		<div id="productPop" class="layerPop layerType2" style="width: 900px; height: auto;">
           <dl>
			<dt>
				<strong>상품정보관리</strong>
			</dt>
			<dd class="content">
		
				<table class="row">
					<caption>caption</caption>
					<colgroup>
						<col width="140px">
						<col width="*">
						<col width="140px">
						<col width="*">

					</colgroup>

					
					<tbody>
						<tr>
							<th scope="row">상품명 
									<span class="font_red">*</span>
								</th>
								<td colspan="3">
									<input type="text"  class="modalInput"  name="pro_nm" id="pro_nm" />
							</td>
						</tr>
						<tr>
							<th scope="row">모델명 
									<span class="font_red">*</span>
								</th>
								<td colspan="3">
									<input type="text"  class="modalInput"  name="pro_model_nm" id="pro_model_nm" />
							</td>						
						</tr>

						<tr>
							<th scope="row">카테고리 
								<span class="font_red">*</span>
							</th>
							<td colspan="3">
								<select name="ct_cd" id="ct_cd" >
								</select>
							</td>
						</tr>		
						
						<tr>
							<th scope="row">제조사 
									<span class="font_red">*</span>
							</th>
							<td colspan="3">
									<input type="text"  class="modalInput"  name="pro_mfc" id="pro_mfc" />
							</td>
							
							
						</tr>
						
						<tr>
							<th scope="row" id="sup_sel_th">납품 업체 <span class="font_red">*</span></th>
							<td id="sup_sel_td">  
								<select name="sup_cd" id="sup_cd" data-placeholder="납품업체를 선택하세요.">
									<option value="none">납품업체선택</option>
									<c:forEach var="supList" items="${supList}">
						         		<option name="sup_cd" value="${supList.sup_cd}">${supList.sup_nm}</option>
							        </c:forEach>
								</select>
							</td>	

							<th scope="row" id="sup_list_th">납품 업체 <span class="font_red">*</span></th>
							<td id="sup_list_td">  

							</td>						
						</tr>
						
						<tr>
							<th scope="row">공급 가격
									<span class="font_red">*</span>
							</th>
							<td colspan="3">
									<input type="text"  class="modalInput"  name="pro_sup_price" id="pro_sup_price" />
							</td>

						</tr>
						
						<tr>
							<th scope="row">납품 단가
									<span class="font_red">*</span>
							</th>
							<td colspan="3">
									<input type="text"  class="modalInput"  name="pro_unit_price" id="pro_unit_price" />
							</td>
						</tr>
						
						<tr>
							<th scope="row" colspan="1">상세 정보 <span class="font_red">*</span></th>
							<td colspan="3" colspan="3">
								<textarea name="pro_dt" id="pro_dt"  rows="10" cols="80"  ></textarea>
							</td>
						</tr>		
						
						<tr>
							<th scope="row" colspan="1">상품 사진 <span class="font_red">*</span></th>
							<td colspan="1">
							      <input type="file"  id="selfile" name="selfile"  class="modalInput"  onChange="javascript:imagechage(event)" />
							 </td>
							<td colspan="2">
							      <div id="filepreview"></div>
							 </td>
						</tr>			
						
					</tbody>
					
				</table>
				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSave" name="btn"><span>저장</span></a> 
					<a href="" class="btnType blue" id="btnDelete" name="btn"><span>삭제</span></a> 
					<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>취소</span></a>
				</div>
		    </dd>
          </dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
     </div>

	

</form>

</body>
</html>
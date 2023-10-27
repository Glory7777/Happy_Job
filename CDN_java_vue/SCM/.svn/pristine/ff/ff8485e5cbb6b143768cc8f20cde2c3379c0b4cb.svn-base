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
	
	var searcharea;
	var divProductList;
	var productPop;
	
	$(function() {
		
 		
 		vueinit();
		
		comcombo("productCD", "ct_cd", "all", ""); 

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
	
			switch(btnId){
			case 'btnSave' : fn_Save(); //  저장
				//alert("저장버튼 클릭!!!이벤트!!");
				break;
			case 'btnDelete' : fn_delete();	// 삭제
				//alert("삭제버튼 클릭!!!이벤트!!");		
				break;
			case 'btnUpdate' : fnUpdate();  // 수정하기
				break;
			case 'searchBtn' : fn_productList();  // 검색하기
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
		
		divProductList = new Vue({
			                  el:"#divProductList",
			              data: {
			            	  datalist:[],
		                     totalcnt:0,
		                     pagingnavi: "",
		                     currentPage:0,
		                     usertype: "${sessionScope.userType}",
			              } ,
			            methods : {
			            	fn_selectProduct : function(pro_cd) {
			            		//alert("fn_selectProduct : " + pro_cd);
			            		fn_selectProduct(pro_cd);
			            	}
			            	
			            }  
			                  
		});
		
		productPop = new Vue({
		                    el:"#productPop",
		                 data: {
		                	 pro_cd:"",
		                	 pro_nm:"",
		                	 pro_model_nm:"",
		                	 pro_mfc:"",
		                	 pro_sup_price:  "",
		                	 pro_unit_price:"",
		                	 pro_dt:"",
		                	 
		                	 sup_cd:"",
     						 supList:"",
     						 
 		                	 ct_cd:"",
     						 selectOption:[],
     						 
		                	 action:"",
		                	 
		                	 delflag:false,
		                	 isreadonly:false,
		                	 
		                	 selectProductCd:"",
		                	 selfile:"",
		                	 previewhtml:"",

		                	 swriter:"${loginId}",
		                	 usertype: "${sessionScope.userType}",
		                	 
		                 },
		                 methods:{					
							  selimg:function(event){
								  var image = event.target;
									 								  
								  if(image.files[0]){
									  
									  var filePath = image.value;
									  
									  //전체경로를 \ 나눔.
									  var filePathSplit = filePath.split('\\'); 									
										
									  //전체경로를 \ 나눔.
									  var filePathSplit = filePath.split('\\'); 
									  //전체경로를 \로 나눈 길이.
									  var filePathLength = filePathSplit.length;
									  //마지막 경로를 .으로 나눔.
									  var fileNameSplit = filePathSplit[filePathLength-1].split('.');
									  //파일명 : .으로 나눈 앞부분
									  var fileName = fileNameSplit[0];
									  //파일 확장자 : .으로 나눈 뒷부분
									   var fileExt = fileNameSplit[1];
									  //파일 크기
                                      var fileSize = image.files[0].size;
											
									  console.log('파일 경로 : ' + filePath);
									  console.log('파일명 : ' + fileName);
									  console.log('파일 확장자 : ' + fileExt);
									  console.log('파일 크기 : ' + fileSize);									  
									  
									 if(fileExt == "jpg" || fileExt == "png" || fileExt == "gif" || fileExt == "jpeg") {
										 this.previewhtml = "<img src='" + window.URL.createObjectURL(image.files[0]) + "'  style='width: 100px; height: 100px;' />";
									 } else {
										 this.previewhtml = "";
									 }
										 
								  }
								  
							  }
						  }  
		});
		
		
		
	}

	/*  상품 리스트 조회 */
    function fn_productList(currentPage) {
    	
    	currentPage = currentPage || 1;
    	
    	var param = {
    			pageSize : pageSize,
    			currentPage : currentPage,
    			searchSel : searcharea.searchSel,
    			searchText : searcharea.searchText,
    			searchDel : ""
    	}
    	
       var listcallback = function(returnData) {
    		console.log(returnData);
    		
    		productPop.selectOption = returnData.supSelectOption;
    		divProductList.datalist = returnData.productList;
    		divProductList.totalcnt = returnData.totalCnt;
    		
    		var paginationHtml = getPaginationHtml(currentPage, divProductList.totalcnt, pageSize, pageBlockSize, 'fn_productList');
    		console.log("paginationHtml : " + paginationHtml);
    		//swal(paginationHtml);
    		divProductList.pagingnavi = paginationHtml;
    		
    		divProductList.currentPage = currentPage;
    		
    	} 	
    	callAjax("/scm/productListvue.do", "post", "json", true, param, listcallback);
   	
    }
    
	
	/*  팝업창 열기 */
    function fn_openPopupReg() {
		
    	fn_popupint();    	
		
    	// 모달 팝업
		gfModalPop("#productPop");
		
    }
	
    /* 등록 상품 상세 보기 */
    function fn_selectProduct(pro_cd) {
    	
    	var param = {
    			pro_cd : pro_cd
    	}
    	
    	var selectcallback = function(returnMap) {
    		
    		console.log(JSON.stringify(returnMap.productSelect));
    		
    		fn_popupint(returnMap.productSelect, returnMap.supList);
    		
    		gfModalPop("#productPop");
    	}
    	
    	callAjax("/scm/productSelect.do", "post", "json", true, param, selectcallback);
    	
    }
    
    function fn_popupint(data,supList){
    	
    	
    	if(data == null || data == undefined || data == "") {
    		
 		   	productPop.action = "I";
    		
    		productPop.pro_cd = "";
    		productPop.ct_cd = "";
    		productPop.pro_nm = "";
    		productPop.pro_model_nm = "";
    		productPop.pro_mfc = "";
    		productPop.pro_sup_price = "";
    		productPop.pro_unit_price = "";
    		productPop.pro_dt = "";
    		
    		productPop.sup_cd = "none";
    		
    		productPop.selectProductCd = "";
    		productPop.selfile = "";
    		productPop.filepreview = "";
    		
    		productPop.delflag = false;
    		
    		productPop.supSelFlag = true;
    		productPop.supListFlag = false;
    		productPop.isreadonly = true;

    		
    	} else {

    		productPop.action = "U";
    		
    		productPop.pro_cd = data.pro_cd;
    		productPop.ct_cd = data.ct_cd;
    		productPop.pro_nm = data.pro_nm;
    		productPop.pro_model_nm = data.pro_model_nm;
    		productPop.pro_mfc = data.pro_mfc;
    		productPop.pro_sup_price = data.pro_sup_price;
    		productPop.pro_unit_price = data.pro_unit_price;
    		productPop.pro_dt = data.pro_dt;
    		
    		productPop.sup_cd = data.sup_cd;
    		
    		productPop.supList = supList;
    		
    		productPop.selectProductCd = data.pro_cd;
    		
    		productPop.selfile = "";
    		
    		productPop.delflag = true;
    		
    		productPop.supSelFlag = false;
    		productPop.supListFlag = true;
    		productPop.isreadonly = false;
    		
    		
        	var file_extention = data.file_extention;
        	
        	var inhtml = "<a href='javascript:fn_download()'>";
        	
        	// 파일 분기
        	if(data.file_nm == "" || data.file_nm == null) {
        		inhtml += "";
        	} else {
           	         if(file_extention.toLowerCase() == "jpg" ||
           	        	file_extention.toLowerCase() == "png" ||  
           	        	file_extention.toLowerCase() == "gif" 
           	        	) {
           	        	inhtml += 
           	        		"<img src='" + 
           	        		data.logic_path + 
           	        		"'   style='width: 100px; height: 100px;''   />";
    		         } else {
    		        	 inhtml += data.file_nm;
    		         }        		
        		inhtml += "</a>"; 
        	}
        	$("#filepreview").empty().append(inhtml);

        	$("#btnDelete").show();
    	}
    	
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
    	
    	fileData.append("action", productPop.action); 
    	fileData.append("pro_cd", productPop.selectProductCd);
    	
    	var savecallback = function(returnValue) {
    		console.log(JSON.stringify(returnValue));
    		
    		if(returnValue.result == "SUCCESS") {
    			alert("저장 되었습니다.");
    			gfCloseModal();
    			
    			if(productPop.action == "I") {
    				fn_productList();
    			} else if(productPop.action == "U") {
    				fn_productList(divProductList.currentPage);
    			} else if(productPop.action == "D") {
    				fn_productList(divProductList.currentPage);
    			}
    		}
    		
    	}
    	
    	callAjaxFileUploadSetFormData("/scm/productSave.do", "post", "json", true, fileData, savecallback);
    }
	
	
    function fn_delete() {
    	productPop.action = "D"; 
    	fn_Save();
    }
    
    function fn_download() {
    	
    	var params = "";
    	params += "<input type='hidden' id='pro_cd' name='pro_cd' value='"+ productPop.selectProductCd +"' />";
    	
    	jQuery("<form action='/product/productdownload.do' method='post'>"+params+"</form>").appendTo('body').submit().remove();
    }

 
    
    
	
</script>

</head>

<body>

<form id="myForm" action="" method="">

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
					<table id="searcharea" width="100%" cellpadding="5" cellspacing="0" border="1" align="left" style="border-collapse: collapse; border: 1px #50bcdf;">
                        <tr style="border: 0px; border-color: blue">
                           <td width="100" height="25" style="font-size: 120%">&nbsp;&nbsp;</td>
                           <td width="50" height="25" style="font-size: 100%; text-align:right;padding-right:25px;">
     	                       <select id="searchSel" name="searchSel" v-model="searchSel" style="width:130px; height:27px">
							       <option value="">전체</option>
							       <option value="pro_cd">상품 번호</option>
							       <option value="pro_nm">상품명</option>
							       <option value="pro_model_nm">모델명</option>
							       <option value="pro_mfc">제조사</option>
						      </select>
	                          <input type="text" id="searchText" name="searchText" v-model="searchText"  style="width: 150px; height: 25px;" />
							  <a class="btnType blue" href="javascript:fn_productList();" name="modal"><span>검색</span></a>
		
                           </td> 
                        </tr>
                     </table> &nbsp;&nbsp;
						
					<div id="divProductList" class="divProductList">
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
								<tbody>
								      <template v-if="totalcnt == 0">
								                <tr>   
													<td colspan=7> 데이터가 업습니다.  </td> 
												</tr>
								      </template> 
								      <template v-else v-for="product in datalist">
								                <tr @click="fn_selectProduct(product.pro_cd)">
													<td>{{product.pro_cd}}</td>						
												    <td>{{product.pro_nm}}</td>
													<td>{{product.pro_model_nm}}</td>
													<td>{{product.pro_mfc}}</td>
													<td>{{product.pro_stock}}</td>
													<td>{{product.pro_unit_price}}</td>
													<td>{{product.pro_sup_price}}</td>
								                </tr>
								      </template>
								</tbody>
							</table>
							
							<!-- 페이징 처리 -->
							<div class="paging_area" id="pagingnavi" v-html="pagingnavi"></div>		
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
									<input type="text"  class="modalInput"  name="pro_nm" id="pro_nm"  v-model="pro_nm"/>
							</td>
						</tr>
						<tr>
							<th scope="row">모델명 
									<span class="font_red">*</span>
								</th>
								<td colspan="3">
									<input type="text"  class="modalInput"  name="pro_model_nm" id="pro_model_nm"  v-model="pro_model_nm"/>
							</td>						
						</tr>

						<tr>
							<th scope="row">카테고리 
								<span class="font_red">*</span>
							</th>
							<td colspan="3">
								<select name="ct_cd" id="ct_cd" v-model="ct_cd" >
								</select>
							</td>
						</tr>		
						
						<tr>
							<th scope="row">제조사 
								<span class="font_red">*</span>
							</th>
							<td colspan="3">
								<input type="text"  class="modalInput"  name="pro_mfc" id="pro_mfc"  v-model="pro_mfc" />
							</td>
							
							
						</tr>
						
						<tr>
 							<template v-if="action == 'I'">
								<th scope="row" id="sup_sel_th">납품 업체 <span class="font_red">*</span></th>
								<td id="sup_sel_td">  
									<select name="sup_cd" id="sup_cd" data-placeholder="납품업체를 선택하세요." v-model="sup_cd">
										<option value="none">납품업체선택</option>
										<template v-for="option in selectOption">
							         		<option :value="option.sup_cd" :key="option.sup_cd">
							         			{{option.sup_nm}}
							         		</option>
								        </template>
									</select>
								</td>				
							</template>

							<template v-if="action == 'U'">
								<th scope="row" id="sup_list_th" v-show="supListFlag">납품 업체 <span class="font_red">*</span></th>
								<td id="sup_list_td" v-text="supList"></td>	
							</template>
							
					
						</tr>
						
						<tr>
							<th scope="row">공급 가격
									<span class="font_red">*</span>
							</th>
							<td colspan="3">
									<input type="text"  class="modalInput"  name="pro_sup_price" id="pro_sup_price" v-model="pro_sup_price" />
							</td>

						</tr>
						
						<tr>
							<th scope="row">납품 단가
									<span class="font_red">*</span>
							</th>
							<td colspan="3">
									<input type="text"  class="modalInput"  name="pro_unit_price" id="pro_unit_price" v-model="pro_unit_price"/>
							</td>
						</tr>
						
						<tr>
							<th scope="row" colspan="1">상세 정보 <span class="font_red">*</span></th>
							<td colspan="3" colspan="3">
								<textarea name="pro_dt" id="pro_dt"  rows="10" cols="80"  v-model="pro_dt"></textarea>
							</td>
						</tr>		
						
						<tr>
							<th scope="row" colspan="1">상품 사진 <span class="font_red">*</span></th>
							<td colspan="1">
							      <input type="file"  id="selfile" name="selfile"  class="modalInput"  v-model="selfile" @change="selimg" />
							 </td>
							<td colspan="2">
							      <div id="filepreview" v-html="previewhtml"></div>
							 </td>
						</tr>			
						
					</tbody>
					
				</table>
				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSave" name="btn"><span>저장</span></a> 
					<a href="" class="btnType blue" id="btnDelete" name="btn" v-show="delflag"><span>삭제</span></a> 
					<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>취소</span></a>
				</div>
		    </dd>
          </dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
     </div>

	

</form>

</body>
</html>
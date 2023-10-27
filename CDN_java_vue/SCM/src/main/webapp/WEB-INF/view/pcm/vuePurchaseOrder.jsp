<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>입금 처리</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->

<script type="text/javascript">
	//페이징 설정
	var pageSize = 10;
	var pageBlockSize = 5;
	
	var searchArea;
	var purchaseList;
	var supPop;
	
	// 화면이 열리면 바로 실행되는 jQuery
	$(function() {
		
		vueInit();
		
		fn_purchaseList();
		
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();	
		
		/*  $("#searchDt").change(function(){
			 fn_purchaseList();
	       }); */
		
	});
	
	
	 /** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();
	
			var btnId = $(this).attr('id');
	
			switch (btnId) {				
				case 'btnClose' :
					gfCloseModal();								
					
				    if(supPop.action== "U") {
				    	fn_purchaseList(purchaseList.currentPage);				    	
	    			}
					break;						
				
			}
		});
	}
	 
	 
	 function vueInit() {
		 
		 searchArea = new Vue({
			 
			 					el : "#searchArea",
			 					data : {
			 						searchsel : "",
					            	searchtext : "",
					            	searchStartDate : "",
					            	searchEndDate : "",
					            	searchDt : false	 						
			 					},
							methods : {
								fn_purchaseList : function() {			            		
									fn_purchaseList();
				            	},
				            	noDt : function() {
				            		
				            		fn_purchaseList();
				            	}
				            }				 				
		 });
		 
		 purchaseList = new Vue({
			 
			 						el : "#purchaseList",
			 						data : {
			 							dataList : [],
			 							totalCnt:0,
			 			             pagingNavi: "",
			 			             currentPage:0				 							
			 						},
		 						methods : {
		 							fn_Update : function(pur_cd, pur_total_unit_price) {			            		
		 								fn_Update(pur_cd, pur_total_unit_price);
		 				     	}
		 				     	
		 				     }			 
		 });
		 
		 supPop = new Vue({
			 
			 				el : "#supPop",
			 				data : {
			 					action : "",
			 					
			 					sup_cd : "",		 					
		 					    sup_nm : "",
		 					    sup_manager : "",
		 					    sup_hp : "",
		 					    sup_addr : "",
		 					    sup_email : ""			 					
			 				},
		 				methods : {
		 					fn_selectSup : function(sup_cd) {			            		
 								fn_selectSup(sup_cd);
 				     	}
 				     	
 				     }			 
		 });		 
		 
	 }

	 
	
	function fn_purchaseList(currentPage) {
		
		console.log(currentPage);
		
		var currentPage=currentPage || 1;		
		
		var param = {				
				
				pageSize : pageSize,
				currentPage : currentPage	,
				searchsel : searchArea.searchsel,
    			searchtext : searchArea.searchtext,    			
    			searchDt : searchArea.searchDt,
    			searchStartDate : searchArea.searchStartDate,
    			searchEndDate : searchArea.searchEndDate				
		}
		
		var listCallBack = function(returnData) {
			
			console.log(JSON.stringify(returnData));
			
			purchaseList.dataList = returnData.purchaseList;
						
			purchaseList.totalCnt = returnData.totalCnt;			
					
		
			var paginationHtml = getPaginationHtml(currentPage, purchaseList.totalCnt, pageSize, pageBlockSize, 'fn_purchaseList');
			
			console.log("paginationHtml : "+paginationHtml);
			
			purchaseList.pagingNavi = paginationHtml;
			
			purchaseList.currentPage = currentPage;
		}
		
		callAjax("/pcm/purchaseListvue.do", "post", "json", true, param, listCallBack);
		
	}	

	
	function fn_Update(pur_cd, pur_total_unit_price) {		 
		 
		 var param = {
				 
				 pur_cd : pur_cd,				 
				 				 
		 }
		 		 		 
		 // 총 납품액 xxxx를 입금하겠냐고 물음
		 if (confirm(pur_total_unit_price+"원을 입금하시겠습니까?")) {
			  
			 var updateCallBack = function(returnValue) {
				 
				 console.log(JSON.stringify(returnValue));
				 
				 if(returnValue.result == "SUCCESS") {
					 
					 alert("입금 완료");	
					 
					 fn_purchaseList(purchaseList.currentPage);
					 						 
				 } 			 
			 }
			 
			 callAjax("/pcm/purchaseUpdate.do", "post", "json", true, param, updateCallBack);	
			 
			} else {
			  
				return;
			}		
		 
	 }	
	
	
	function fn_selectSup(sup_cd) {
		
		var param = {				 
				sup_cd : sup_cd
		}
		
		var selectCallBack = function(returnData) {
			
			console.log(JSON.stringify("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"+returnData));		
						
			fn_popupInt(returnData.sectInfo);
			
			gfModalPop("#supPop");
			
		}		
		
		callAjax("/pcm/selectSup.do", "post", "json", true, param, selectCallBack);
		
	}
	
	
	 function fn_popupInt(data) {	    
		 
		 	supPop.sup_cd = data.sup_cd;
		 	supPop.sup_nm = data.sup_nm;
		 	supPop.sup_manager = data.sup_manager;
		 	supPop.sup_hp = data.sup_hp;
		 	supPop.sup_addr = data.sup_addr;
		 	supPop.sup_email = data.sup_email;
		 
		 	supPop.action = "U"
	} 
	
	
	

</script>
</head>
<body>
<form id="myForm" action=""  method="">
	  <input type="hidden" id="currentPageDeposit" />
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
					<!-- lnb 영역 --> <jsp:include
						page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
				</li>
				<li class="contents">
					<!-- contents -->
					<h3 class="hidden">contents 영역</h3> <!-- content -->
					<div class="content">
						
						<p class="Location">
							<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a>&nbsp;/&nbsp;	
							<a href="">납품 업체</a>&nbsp;/&nbsp;						
							<span><strong>발주 지시서 목록</strong></span>
							
							<a href="/pcm/purchaseOrder.do" class="btn_set refresh">새로고침</a>
                       </p>
                       <div id="searchArea">
						<p class="conTitle">  
							<span>발주 지시서 목록</span>
							<span class="fr">
								<input type="date" id="searchStartDate" name="searchStartDate" v-model="searchStartDate" style="height: 25px;">&nbsp;~&nbsp;	
								<input type="date" id="searchEndDate" name="searchEndDate" v-model="searchEndDate" style="height: 25px;">&nbsp;&nbsp;&nbsp;&nbsp;
															     							    		
							    <select id="searchsel" name="searchsel" v-model="searchsel" style="width:100px;">
							         <option value="">전체</option>
							         <option value="product">상품명</option>
							         <option value="supplier">납품 업체명</option>							         
							    </select>
							    <input type="text" id="searchtext" name="searchtext"  v-model="searchtext" style="width: 150px; height: 25px;" />
							    <a class="btnType blue" @click="fn_purchaseList();" name="modal"><span>검색</span></a>							    
							</span> 							
						</p>
						<br>
						
						<label style="display: flex; justify-content: flex-end;">
							<input type="checkbox" name="searchDt" v-model="searchDt" id="searchDt" @change="noDt()">&nbsp;<span>미입금</span>&nbsp;&nbsp;&nbsp;
						</label>
						</div>
						
						<div id="purchaseList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>									
									<col width="5%">
									<col width="10%">
									<col width="13%">
									<col width="7%">
									<col width="5%">
									<col width="10%">
									<col width="10%">
									<col width="13%">
									<col width="13%">
									<col width="7%">
									<col width="7%">																		
								</colgroup>
								
								<thead>
									<tr>
										<th scope="col">발주 코드</th>
										<th scope="col">발주 일자</th>
										<th scope="col">상품명</th>
										<th scope="col">재고</th>
										<th scope="col">발주 수량</th>
										<th scope="col">납품 단가</th>
										<th scope="col">총 발주 금액</th>
										<th scope="col">납품 업체명</th>
										<th scope="col">발주자</th>
										<th scope="col">발주 상태</th>
										<th scope="col">입금</th>																				
									</tr>
								</thead>
								<tbody>
									<template v-if="totalCnt == 0">
										<tr>
											<td colspan="11">발주 내역이 존재하지 않습니다.</td>
										</tr>
									</template>
									<template v-else v-for="one in dataList">
										<tr>
											<td>{{  one.pur_cd  }}</td>
											<td>{{  one.pur_date  }}</td>
											<td>{{  one.pro_nm  }}</td>
											<td>{{  one.pro_stock  }}</td>
											<td>{{  one.pur_cnt  }}</td>
											<td>{{  one.pro_unit_price  }}</td>
											<td>{{  one.pur_total_unit_price  }}</td>
											<td>
												<a @click="fn_selectSup(one.sup_cd)">{{  one.sup_nm  }}</a>											
											</td>
											<td>{{  one.pur_nm  }}</td>											
											<td>
												<template v-if="one.pur_appr == 1">
													승인 완료
												</template>
												<template v-else-if="one.pur_appr == 2">
													입금 완료
												</template>
												<template v-else-if="one.pur_appr == 3">
													입고 완료
												</template>			
											</td>
											<td>
												<template v-if="one.pur_appr == 1">
													<a class="btnType3 color2" @click="fn_Update(one.pur_cd, one.pur_total_unit_price)" id="btnUpdate" name="btn">
													<span>입금</span>
												</a>
												</template>
												<template v-else-if="one.pur_appr == 2">
													입금 완료
												</template>
												<template v-else-if="one.pur_appr == 3">
													입고 완료
												</template>												
											</td>
										</tr>
									</template>			
								
								</tbody>
							</table>							
	
						<div class="paging_area" id="pagingNavi" v-html="pagingNavi">						
						</div>	
						
						</div>					
						
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>
	
	<!-- // 모달 팝업 -->
	<div id="supPop" class="layerPop layerType2" style="width: 800px;">
		<dl>
			<dt>
				<strong>납품 업체 정보</strong>
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
							<th scope="row">납품 업체 코드</th>
							<td id="sup_cd" v-text="sup_cd">
							</td>
							<th scope="row">납품 업체명</th>
							<td id="sup_nm" v-text="sup_nm">
							</td>
							<th scope="row">납품담당자</th>
							<td id="sup_manager" v-text="sup_manager">
							</td>								
						</tr>
						<tr>
							<th scope="row">연락처</th>
							<td id="sup_hp" v-text="sup_hp">
							</td>
							<th scope="row">이메일</th>
							<td id="sup_email" v-text="sup_email">
							</td>
							<th scope="row">계좌번호</th>
							<td id="" v-text="">
							</td>								
						</tr>
						<tr>
							<th scope="row">주소</th>
							<td id="sup_addr" v-text="sup_addr" colspan="6">
							</td>														
						</tr>
																	
					</tbody>
				</table>
				<br>							
				<div style="text-align: center;">							
					<a href="" class="btnType gray"  id="btnClose" name="btn"><span>취소</span></a>		
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>		
	</div>
	
	
</form>

</body>
</html>
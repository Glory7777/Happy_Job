<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>입고 처리</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->

<script type="text/javascript">
	//페이징 설정
	var pageSize = 10;
	var pageBlockSize = 5;
	
	var searchArea;
	var stockedList;
	var supplierPop;
	
	// 화면이 열리면 바로 실행되는 jQuery
	$(function() {
		
		 vueInit();
		
		fn_stockedList();	
		
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();	
		
		/* $("#searchStk").change(function(){
			fn_stockedList();
	       });    */
	
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
				    	fn_stockedList($("#currentPageStock").val());
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
				            	searchStk : false
							},
						methods : {
							fn_stockedList : function() {			            		
								fn_stockedList();
			            	},
			            	noStk : function(){
			            		
			            		fn_stockedList();
			            	}
			            }		
			
		});
		
		stockedList = new Vue({
			
								el : "#stockedList",							
							data : {								
								dataList : [],								
								totalCnt:0,
				                pagingNavi: "",
				                currentPage:0
							},
						methods : {
							fn_Update : function(index, pur_cd, pro_cd) {			            		
								fn_Update(index, pur_cd, pro_cd);
			            	}
			            	
			            }
		
		});
		
		supplierPop =new Vue({
								
								el : "#supplierPop",							
								data : {								
									sup_nm : "",
									sup_manager : "",
									sup_hp : "",
									sup_email : "",
									sup_addr : ""																							
								}		
		});
		
		
	}
 
	
	function fn_stockedList(currentPage) {
		
		var currentPage=currentPage || 1;		
							
		var param = {
				
				pageSize : pageSize,
				currentPage : currentPage	,
				searchsel : searchArea.searchsel,
    			searchtext : searchArea.searchtext,    			
    			searchStk : searchArea.searchStk,
    			searchStartDate : searchArea.searchStartDate,
    			searchEndDate : searchArea.searchEndDate				
		}
				
		var listCallBack = function(returnData) {
			
			console.log(JSON.stringify(returnData));
			
			stockedList.dataList = returnData.stockedList;
			stockedList.totalCnt = returnData.totalCnt;	
									
			var paginationHtml = getPaginationHtml(currentPage, stockedList.totalCnt, pageSize, pageBlockSize, 'fn_stockedList');
			
			console.log("paginationHtml : "+paginationHtml);
			
			stockedList.pagingNavi = paginationHtml;
    		
			stockedList.currentPage = currentPage;
			
		}
		
		callAjax("/dlm/stockedListvue.do", "post", "json", true, param, listCallBack);
		
	}	
	
	
	// 입고 처리하는 함수
	function fn_Update(index, pur_cd, pro_cd) {	
				
		if(!fValidate(index)) {
    		return;
    	}		 		
		
		 var param = {
				 
				 pur_cd : pur_cd, 
				 pro_cd : pro_cd,
				 pur_stk_cnt : $("#pur_stk_cnt"+index).val(),	 
				 				 				 
		 }	
		 
		 // 발주 수량과 입고 수량을 비교하기 위해 int형태로 변환
		 
		 var pur_cnt = parseInt($("#pur_cnt"+index).text());
		 
		 var pur_stk_cnt = parseInt($("#pur_stk_cnt"+index).val());
		 
		 if(pur_cnt < pur_stk_cnt) {
			 
			 alert("입고 수량은 발주 수량을 넘을 수 없습니다.");
			 
			 $("#pur_stk_cnt"+index).val('');
			 
			 return;		 
		 }
		 
		 // x개 입고 하겠느냐? 물어서 입고 개수 확인 
		 if (confirm($("#pur_stk_cnt"+index).val()+"개를 입고 하시겠습니까?")) {
			  
			 var updateCallBack = function(returnValue) {
				 
				 console.log(JSON.stringify(returnValue));
				 
				 if(returnValue.result == "SUCCESS") {
					 
					 alert($("#pur_stk_cnt"+index).val()+"개 입고 완료");	
					 
					 fn_stockedList(stockedList.currentPage);
				 } 			 
			 }
			 
			 callAjax("/dlm/stockUpdate.do", "post", "json", true, param, updateCallBack);	
			 
			 
			} else {
				
				$("#pur_stk_cnt"+index).val('')
				
			  	return;
			}
		 
		 
		 		 
		
		 
	 }	    	
	
	/** 저장 validation */
	function fValidate(index) {
		
		var chk = checkNotEmpty(
				[
						[ "pur_stk_cnt"+index, "입고 수량을 입력해 주세요." ]
																					]
		);

		if (!chk) {
			return;
		}

		return true;
	}
	
	
	//납품 업체 정보 가져오기
	function fn_selectSup(sup_cd) {
		
		var param = {
				sup_cd : sup_cd 				
		}
		
		var selectCallBack = function(returnData) {
			
			console.log(JSON.stringify(returnData));		
						
			fn_popupInt(returnData.sectInfo);
			
			gfModalPop("#supplierPop");
			
		}		
		
		callAjax("/dlm/selectSup.do", "post", "json", true, param, selectCallBack);
		
	}
	
	
	 function fn_popupInt(data) {	    	
	    
		 supplierPop.sup_nm = data.sup_nm;
		 supplierPop.sup_manager = data.sup_manager;
		 supplierPop.sup_hp = data.sup_hp;
		 supplierPop.sup_email = data.sup_email;
		 supplierPop.sup_addr = data.sup_addr;				
	} 
	 
	 
	 
	 
	
		
	

</script>
</head>
<body>
<form id="myForm" action=""  method="">
	  <input type="hidden" id="currentPageStock" />	  
	  <input type="hidden" id="pro_cd"  name="pro_cd" />
	  <input type="hidden" id="pur_stk_cnt" name="pur_stk_cnt" />
	  
	  
	 
	
	
	
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
							<a href="">상품 발주</a>&nbsp;/&nbsp;
							<span><strong>입고 처리</strong></span>							
							<a href="/dlm/purchaseorder.do" class="btn_set refresh">새로고침</a>
                       </p>
                       
                       <div id="searchArea">
						<p class="conTitle">  
							<span>입고 처리 목록</span> 
							<span class="fr">								
							     							    		
							    <select id="searchsel" name="searchsel" v-model="searchsel" style="width:100px;">
							         <option value="">전체</option>
							         <option value="product">상품명</option>
							         <option value="supplier">납품 업체명</option>							         
							    </select>
							    <input type="text" id="searchtext" v-model="searchtext" name="searchtext"  style="width: 150px; height: 25px;" />
							    <a class="btnType blue" @click="fn_stockedList();" name="modal"><span>검색</span></a>							    
							</span>
						</p>
						<br>
						
						<label style="display: flex; justify-content: flex-end;">
							<input type="checkbox" name="searchStk" id="searchStk" v-model="searchStk" @change="noStk()">&nbsp;<span>미입고</span>&nbsp;&nbsp;&nbsp;
						</label>
						
						</div>
						
						<div id="stockedList">												
						<div class="divComGrpCodList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="5%">
									<col width="5%">
									<col width="18%">
									<col width="7%">									
									<col width="10%">
									<col width="7%">
									<col width="5%">
									<col width="7%">
									<col width="9%">
									<col width="9%">
									<col width="10%">
									<col width="8%">																																			
								</colgroup>
								
								<thead>
									<tr>
										<th scope="col">발주 코드</th>
										<th scope="col">상품 코드</th>
										<th scope="col">상품명</th>										
										<th scope="col">제조사</th>										
										<th scope="col">납품 업체명</th>
										<th scope="col">재고</th>
										<th scope="col">발주 수량</th>
										<th scope="col">입고 수량</th>	
										<th scope="col">발주 상태</th>
										<th scope="col">배송 담당</th>
										<th scope="col">입고 일자</th>
										<th scope="col">입고</th>									
									</tr>
								</thead>
								<tbody>
									<template v-if="totalCnt == 0">
										<tr>
											<td colspan="12">발주 내역이 존재하지 않습니다.</td>
										</tr>
									</template>									
									<template v-else>									
										<tr v-for="(one, index) in dataList" :key="one.pur_cd">										
											<td>{{ one.pur_cd }}</td>
											<td>{{ one.pro_cd }}</td>
											<td>{{ one.pro_nm }}</td>
											<td>{{ one.pro_mfc }}</td>
											<td>
												<a @click="fn_selectSup(one.sup_cd)">{{ one.sup_nm }}</a>
											</td>
											<td>{{ one.pro_stock }}</td>
											<td :id="'pur_cnt'+index">{{ one.pur_cnt }}</td>
											<td>
												<template v-if="one.pur_stk_cnt== null">
													<input type="number" :id="'pur_stk_cnt'+index" :name="'pur_stk_cnt'+index" style="width:70px;">
												</template>
												<template v-if="one.pur_stk_cnt != null">
													<input type="number" :id="'pur_stk_cnt'+index" :name="'pur_stk_cnt'+index" v-model="one.pur_stk_cnt" style="width:70px;" readonly>
												</template>
											</td>
											<td>
												<template v-if="one.pur_appr == '2'">
													입금 완료
												</template>
												<template v-else-if="one.pur_appr == '3'">
													입고 완료
												</template>
											</td>
											<td>{{ one.del_nm }}</td>
											<td>{{ one.pur_stk_date}}</td>
											<td>
												<template v-if="one.pur_appr == '2'">
													<a class="btnType3 color1" @click="fn_Update(index, one.pur_cd, one.pro_cd)">
														<span>입고</span>
													</a>	
												</template>
												<template v-else-if="one.pur_appr == '3'">
													입고 완료
												</template>
											</td>
										</tr>									
									</template>
								
								</tbody>
							</table>
						</div>			
	
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
	
	<!--// 모달팝업 -->
	<div id="supplierPop" class="layerPop layerType2" style="width: 600px;">
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
					</colgroup>

					<tbody>
						<tr>						
							 <th scope="row">납품 업체명</th>
							<td id="sup_nm" v-text="sup_nm">
							 </td>
							<th scope="row">납품 담당자</th>
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
						</tr>
						<tr>
							 <th scope="row">주소</th>
							<td id="sup_addr"  v-text="sup_addr" colspan="4">
							 </td>
						</tr>		
						
				</table>
				
				<div class="btn_areaC mt30">					
					<a href="" class="btnType gray" id="btnClose" name="btn"><span>닫기</span></a>
				</div>

			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>

	
</form>


</body>
</html>
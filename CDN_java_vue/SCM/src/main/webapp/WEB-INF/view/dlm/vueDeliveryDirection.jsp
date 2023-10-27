<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<title>배송 지시서 </title>

<!-- common Include -->
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<script>
	// 페이징 설정
	var pageSize = 10;
	var pageBlockSize = 5;
	
	var searcharea;
	var divDirectionList;
	var directionPop;
	
	$(function() {
		
		vueinit();
		
		// 상품 목록 조회
		fn_serachList();
		
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
		

	});
	
	 
	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();
	
			var btnId = $(this).attr('id');
	
			switch (btnId) {
				case 'btnDelivery' :	
					fn_updateDelivery('0');
					break;					
				case 'btnDeliveryFin' :
					fn_updateDelivery('1');
					break;
				case 'btnClose' :
					gfCloseModal();
					break;
					
			}
		});
	}
	
	
	function vueinit() {
		
		vari = new Vue({
	            el: "#vari",
	        data: {
	        	deli_cd : "",
	        },
		});

		
		searcharea = new Vue({
			                   el: "#searcharea",
			               data: {
			            	   startDate : "",
			            	   endDate : "",
			            	   deliveryStatusCheck : false,
			            	   usertype: "${sessionScope.userType}",
			               },
			               methods:{
			            	   handleCheckboxChange : function(){
			            		   fn_serachList();
			            	   }   
			               
			               }
		});
		
		divDirectionList = new Vue({
			                  el:"#divDirectionList",
			              data: {
			            	  datalist:[],
		                     totalcnt:0,
		                     pagingnavi: "",
		                     currentPage:0,
		                     usertype: "${sessionScope.userType}",
			              } ,
			            methods : {
			            	fn_serachList : function(pro_cd) {
			            		//alert("fn_selectProduct : " + pro_cd);
			            		fn_serachList(pro_cd);
			            	}
			            	
			            }  
			                  
		})
		
		directionPop = new Vue({
		                    el:"#directionPop",
		                 data: {
		            		
		            		 order_cd:"",
		            		 loginid:"",
		            		 addr:"",
		            		 addr_dt:"",
		            		 pro_cd:"",
		            		 pro_nm:"",
		            		 order_cnt:"",       		 
		            		 deli_cd : "",
		            		 ingflag : false,
		            		 finflag : false,
		            		 
		                 }, 
		})
		
	}
	
	function fn_serachList(currentPage) {
		
		console.log("서치 진입");
		
		var currentPage = currentPage || 1;
		
		var param = {
				pageSize : pageSize,
				currntPage : currentPage,
				deliveryStatusCheck : searcharea.deliveryStatusCheck,
				startDate : searcharea.startDate,
				endDate : searcharea.endDate
		}
		
		var listcallback = function(res) {
			
			console.log("콜백 진입");
			
   		
			divDirectionList.datalist = res.listDeliveryDirection;
			divDirectionList.totalcnt = res.totalcnt;
	   		
	   		var paginationHtml = getPaginationHtml(currentPage, divDirectionList.totalcnt, pageSize, pageBlockSize, 'fn_serachList');
	   		console.log("paginationHtml : " + paginationHtml);
	   		//swal(paginationHtml);
	   		divDirectionList.pagingnavi = paginationHtml;
	   		
	   		divDirectionList.currentPage = currentPage;
		}
		
		callAjax("/dlm/listDeliveryDirectionvue.do", "post", "json", true, param, listcallback);
		
	}
	
	
	function fnOpenPopUp() {
    	
    	fn_PopUpInt();
    	
		// 모달 팝업
		gfModalPop("#directionPop");
		
    }
	
	function fn_PopUpInt(data,status) {
		
			console.log("data:"+JSON.stringify(data));
			console.log(data.loginid);

	   		directionPop.order_cd = data.order_cd;
	   		directionPop.loginid = data.loginid;
	   		directionPop.addr = data.addr;
	   		directionPop.addr_dt = data.addr_dt;
	   		
	   		directionPop.pro_cd = data.pro_cd;
	   		directionPop.pro_nm = data.pro_nm;
	   		directionPop.order_cnt = data.order_cnt;
	   	
	   		
	   		console.log("status 값 : " + status);
	   		if(status == 0){
		   		directionPop.ingflag = true;
		   		directionPop.finflag = false;
	   		} else if(status == 1){
	   			directionPop.ingflag = false;
		   		directionPop.finflag = true;
	   		} else {
	   			directionPop.ingflag = false;
		   		directionPop.finflag = false;
	   		}
	}
	
	function fn_selectDelivery(direc_cd, status, deli_cd) {
		
		vari.deli_cd = deli_cd;
		
		vari.status = status;
				
		var param = {
				direc_cd : direc_cd
		}
		
		var selectcallback = function(res) {
			console.log(JSON.stringify(res));  
			
			fn_PopUpInt(res.selectDeliveryDirection,status);
			
			gfModalPop("#directionPop");
			
		}
		
		callAjax("/dlm/selectDeliveryDirection.do", "post", "json", true, param, selectcallback);
		
	}
	
	function fn_updateDelivery(action){
		console.log(action);
		console.log($("#deli_cd").val());
		
		var param = {
				action : action,
				deli_cd : vari.deli_cd,
		}
		
		var savecallback = function(res) {
			console.log(JSON.stringify(res));
			
			if(res.result == "SUCCESS") {
				alert("배송 처리되었습니다. \n 배송상태: 배송중");
				gfCloseModal();
				
				fn_serachList(divDirectionList.currentPage);
			}else if(res.result == "SUCCESSFin"){
				alert("배송 완료되었습니다. \n 배송상태: 배송완료");
				gfCloseModal();
				
				fn_serachList(divDirectionList.currentPage);
			}else{
				alert("배송 처리 실패.");
				gfCloseModal();
				
				fn_serachList(divDirectionList.currentPage);
			}
			
		}
		
		callAjax("/dlm/updateDelivery.do", "post", "json", true, param, savecallback);
		
	}
	
	function fn_updateDeliveryFin(){
		
	}
	
</script>
</head>
<body>
	<form id="myForm" action=""  method="">
	
		<div id="vari">
		    <input v-model="deli_cd" type="hidden" id="deli_cd" name="deli_cd"/>	
		    <input v-model="status" type="hidden" id="status" name="status"/>	
		</div>
		
	    <input type="hidden" id="currentPagenotice" />
	    <input type="hidden" id="action"  name="action" />
		
		<div id="wrap_area">
			
			<!-- header Include -->
			<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>
			
			<div id="container">
				<ul>
					<li class="lnb">
					
						<!-- lnb Include -->
						<jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include>
						
					</li>
					<li class="contents">
						<div class="content">
							<!-- 메뉴 경로 영역 -->
							<p class="Location">
								<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a> <a href="#"
									class="btn_nav">기업고객</a> <span class="btn_nav bold">배송 지시서 목록</span> <a href="/dlm/deliveryDirection.do" class="btn_set refresh">새로고침</a>
							</p>
							
							<!-- 검색 영역 -->
							<p class="search">
							
							</p>		
							<div id="searcharea">
								<p class="conTitle" >
								<span>배송 지시서 목록_배송담당자</span>
									 <span class="fr"> 
									 		지시서 작성일 검색: 
											<input v-model="startDate" type="date" id="startDate" name="startDate" placeholder="시작일 선택"></input>
											<input v-model="endDate" type="date" id="endDate" name="endDate" placeholder="종료일 선택"></input>
											<a class="btnType blue" href="javascript:fn_serachList()" onkeydown="enterKey()" name="search">
											<span id="searchEnter">검색</span></a>			
									</span>
								</p>
								<span class="fr">								
									<input v-model="deliveryStatusCheck" @change="handleCheckboxChange" type="checkbox" id="deliveryStatusCheck"> 배송준비중만 조회
								</span>	
							</div>					
							<!-- 테이블 영역 -->
							<div class="divDirectionList" id="divDirectionList">
								<table class="col">
									<colgroup>
										<col width="5%">
										<col width="5%">
										<col width="5%">
										<col width="15%">
										<col width="10%">
										<col width="10%">
										<col width="5%">
									</colgroup>
									<thead>
										<tr>
											<th scope="col">배송번호</th>
											<th scope="col">주문번호</th>
											<th scope="col">상품번호</th>
											<th scope="col">상품명</th>
											<th scope="col">주문고객</th>
											<th scope="col">배송희망일</th>
											<th scope="col">배송상태</th>
										</tr>
									</thead>
									
									<!--  -->
									<tbody>
								      <template v-if="totalcnt == 0">
								                <tr>   
													<td colspan=7> 데이터가 업습니다.  </td> 
												</tr>
								      </template> 
								      <template v-else v-for="direction in datalist">
								                <tr >
													<td>{{direction.deli_cd}}</td>									                
													<td>{{direction.order_cd}}</td>            
													<td>{{direction.pro_cd}}</td>					
												    <td>{{direction.pro_nm}}</td>
												    <td>{{direction.loginid}}</td>
													<td>{{direction.order_hope_date}}</td>
													<td>
													  <template v-if="direction.deli_st === '0'">
													    <a class="btnType3 color1" @click="fn_selectDelivery(direction.direc_cd, direction.deli_st, direction.deli_cd)">
													      <span style="color:blue; font-weight: bold;">배송준비중</span> 
													    </a>
													  </template>
													  <template v-else-if="direction.deli_st === '1'">
													    <a class="btnType3 color1" @click="fn_selectDelivery(direction.direc_cd, direction.deli_st, direction.deli_cd)">
													      <span style="color:green; font-weight: bold;">배송중</span>
													    </a> 
													  </template>
													  <template v-else-if="direction.deli_st === '2'">
													    <a class="btnType3 color1" @click="fn_selectDelivery(direction.direc_cd, direction.deli_st, direction.deli_cd)">
													      <span style="color:#9c3b3b; font-weight: bold;">배송완료</span>
													    </a>
													  </template>												
													</td>
								                </tr>
								      </template>		
									</tbody>									
								</table>
							<br/>
							<!-- 테이블 페이지 네비게이션 영역 -->
							<div class="pagingArea" id="pagingnavi" v-html="pagingnavi"></div>							
							</div>	<!-- .divDeliveryBuyerList 종료 -->
						</div>
					</li>
				</ul>
			</div>
		</div>	
		
		<!-- Modal 시작 -->
		<div id="directionPop" class="layerPop layerType2" style="width: 900px;">
		<input v-model="status" type="hidden" />
		<dl>
			<dt>
				<strong>배송 지시서</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row mt20">
					<caption>caption</caption>
					<colgroup>
						<col width="7%">
						<col width="7%">
						<col width="7%">
						<col width="10%">
						<col width="7%">
						<col width="15%">
						<col width="7%">
						<col width="10%">
					</colgroup>

					<tbody>
						<tr>
							<th scope="row">주문번호</th>
							<td><input v-model="order_cd" style="text-align: center;" type="text" class="inputTxt p100" name="order_cd" id="order_cd" readonly="readonly"/></td>
							<th scope="row">주문고객</th>
							<td><input v-model="loginid" style="text-align: center;" type="text" class="inputTxt p100" name="loginid" id="loginid" readonly="readonly"/></td>
							<th scope="row">주문고객주소</th>
							<td><input v-model="addr" style="text-align: center;" type="text" class="inputTxt p100" name="addr" id="addr" readonly="readonly"/></td>
							<th scope="row">주문고객상세주소</th>
							<td><input v-model="addr_dt" style="text-align: center;" type="text" class="inputTxt p100" name="addr_dt" id="addr_dt" readonly="readonly"/></td>
						</tr>
					</tbody>
				</table>
				<table class="row mt20" id="modalDeliveryBuyerDtlList">
					<colgroup>
						<col width="5%">
						<col width="20%">
						<col width="10%">
					</colgroup>
					<thead>
						<tr style="background-color: silver;">
							<th scope="row" style="font-weight: bold;">상품번호</th>
							<th scope="row" style="font-weight: bold;">상품명</th>
							<th scope="row" style="font-weight: bold;">주문수량</th>
						</tr>
					</thead>
					<tbody>	
						<tr>
							<td><input v-model="pro_cd" style="text-align: center;" type="text" class="inputTxt p100" name="pro_cd" id="pro_cd" readonly="readonly"/></td>
							<td><input v-model="pro_nm" style="text-align: center;" type="text" class="inputTxt p100" name="pro_nm" id="pro_nm" readonly="readonly"/></td>
							<td><input v-model="order_cnt" style="text-align: center;" type="text" class="inputTxt p100" name="order_cnt" id="order_cnt" readonly="readonly"/></td>
						</tr>		
					</tbody>	
				</table>
				<!-- 테이블 페이지 네비게이션 영역 -->
				<div class="pagingArea" id="modalDeliveryBuyerDtlPagination"></div>	

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
				    <a href="" class="btnType blue" id="btnDelivery" name="btn" v-show="ingflag"><span>배송 처리</span></a>
				    <a href="" class="btnType blue" id="btnDeliveryFin" name="btn" v-show="finflag"><span>배송완료 처리</span></a>	
				    <a href="javascript:gfCloseModal()" class="btnType gray" name="btn" id="btnClose"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>	
	<!-- Modal 종료 -->		
			
	</form>	
</body>
</html>
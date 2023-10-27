<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>공지사항</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->
              
<script type="text/javascript">
	// 페이징 설정
	var pageSize = 10;
	var pageBlockSize = 5;
	
	var searchArea;
	var divRefundConfirm;
	
	$(function() {
		
		// 뷰 초기설정
		vueInit();
		
		// 반품신청 목록
		fn_refundList();
		
	});

	// 뷰 초기설정
	function vueInit(){
		
		searchArea = new Vue({
			el : "#searchArea",
			data : {
				searchStartDate : "",
				searchEndDate : "",
				searchSel : "",
				searchText : "",
			}
		});
		
		divRefundConfirm = new Vue({
			el : "#divRefundConfirm",
			data : {
				datalist : [],
				confirmCompleteList : [],
				totalcnt : 0,
				refundListPagination : "",
                currentPage : 0,
			},
			filters : {
				comma(val){
					return String(val).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
				}
			},
			methods : {
			    isRefundApproved(refundCd) {
			        return this.confirmCompleteList.some(item => item.refund_cd === refundCd);
			    },
			    fn_refundConfirm : function(refund_cd){
			    	fn_refundConfirm(refund_cd);
			    },
			    fn_confirm : function(refund_cd){
			    	fn_confirm(refund_cd);
			    }
			}
		});
	}
	
    // 반품신청 목록 조회
	function fn_refundList(currentPage){
		
		var currentPage = currentPage || 1;
		
		var searchStartDate = searchArea.searchStartDate;
		var searchEndDate = searchArea.searchEndDate;
		
		if((searchStartDate !== '' && searchEndDate !== '') && searchEndDate < searchStartDate){
			
			searchEndDate = searchArea.searchStartDate;
			searchStartDate = searchArea.searchEndDate;
			
		}  else if(searchEndDate == searchStartDate){
			
			searchStartDate = searchArea.searchStartDate;
			searchEndDate = searchArea.searchEndDate;
		}

		var param = {
				pageSize : pageSize,
				currentPage : currentPage,
				searchStartDate : searchStartDate,
				searchEndDate : searchEndDate,
				searchSel : searchArea.searchSel,
				searchText : searchArea.searchText,
		}
		
		var listCallback = function(returndata){
			
			divRefundConfirm.datalist = returndata.refundDirectionList;
			divRefundConfirm.confirmCompleteList = returndata.confirmCompleteList;
			divRefundConfirm.totalcnt = returndata.totalcnt;
			
    		var pagenationHtml = getPaginationHtml(currentPage, divRefundConfirm.totalcnt, pageSize, pageBlockSize, 'fn_refundList');

    		console.log("pagenationHtml : " + pagenationHtml);
    		
    		divRefundConfirm.refundListPagination = pagenationHtml;
    		
    		divRefundConfirm.currentPage = currentPage;
		}
		
    	callAjax("/exe/vueRefundList.do", "post", "json", true, param, listCallback);
	}

	// 반품 승인 확인 알럿
	function fn_refundConfirm(refund_cd){
		
		swal("최종 반품을 승인하시겠습니까?", {
			buttons: {
				cancel: "취소",
			    catch: {
					text: "확인",
					value: "confirm",
				}
			},
		})
		.then((value) => {

			switch (value) {
			case "confirm":
				fn_confirm(refund_cd);
				break;
			}
		});
	}
    
// 	// 승인 확인
	function fn_confirm(refund_cd){
		
		var param = {
				refundCd : refund_cd
		}
		
		var directionConfirmCallback = function(returndata){
			if(returndata.result == "success"){
				swal("승인이 완료 되었습니다.")
				.then((value) => {
					fn_refundList(divRefundConfirm.currentPage);
				});
			}
		}
		
		callAjax("/exe/vueRefundDirectionConfirm.do", "post", "json", true, param, directionConfirmCallback);
	}
    
</script>

</head>
<body>
<form id="myForm" action=""  method="">
	
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
							<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a>
							<span class="btn_nav bold">승인</span>
							<span class="btn_nav bold"> 반품 승인</span>
							<a href="/exe/refundConfirm.do" class="btn_set refresh">새로고침</a>
						</p>

						<p id="searchArea" class="conTitle">
							<span>반품 신청 목록</span> 
							<span class="fr"> 
							    <label>반품신청일 :  </label><input type="date" id="searchStartDate" name="searchStartDate" v-model="searchStartDate" style="height: 25px;" />-
							    <input type="date" id="searchEndDate" name="searchEndDate" v-model="searchEndDate" style="height: 25px; margin-right: 10px;" />
							    <select id="searchSel" name="searchSel" v-model="searchSel" style="width: 100px; height: 27px;" >
							         <option value="">반품 전체</option>
							         <option value="refundUserId">반품 고객</option>
							         <option value="proNm">상품 명</option>
							    </select>
							    <input type="text" id="searchText" name="searchText" v-model="searchText" style="width: 150px; height: 25px;" />
							    <a class="btnType blue" href="javascript:fn_refundList();" name="modal"><span>검색</span></a>
							</span>
						</p>
						
						<div id="divRefundConfirm" class="divRefundConfirm">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="5%">
									<col width="7%">
									<col width="7%">
									<col width="25%">
									<col width="10%">
									<col width="10%">
									<col width="7%">
									<col width="7%">
									<col width="12%">
									<col width="8%">
								</colgroup>
								<thead>
									<tr>
										<th scope="col">번호</th>
										<th scope="col">반품번호</th>
										<th scope="col">반품고객</th>
										<th scope="col">상품명</th>
										<th scope="col">주문일</th>
										<th scope="col">반품신청일</th>
										<th scope="col">주문수량</th>
										<th scope="col">반품수량</th>
										<th scope="col">반품 총 금액</th>
										<th scope="col">승인여부</th>
									</tr>
								</thead>
								<tbody>
									<template v-if="totalcnt == 0">
										<tr>
											<td colspan=10> 데이터가 없습니다.</td>
										</tr>
									</template>
									<template v-else v-for="one in datalist" >
										<tr>
											<td>{{ one.direc_cd }}</td>
											<td>{{ one.refund_cd }}</td>
											<td>{{ one.loginid }}</td>
											<td>{{ one.pro_nm }}</td>
											<td>{{ one.order_date }}</td>
											<td>{{ one.refund_date }}</td>
											<td>{{ one.order_cnt }}</td>
											<td>{{ one.refund_cnt }}</td>
											<td>{{ one.refund_price | comma }}</td>
											<td>
									            <template v-if="isRefundApproved(one.refund_cd)">
									                <span style="color: darkgray; font-weight: bold;">승인 완료</span>
									            </template>
									            <template v-else>
									                <a @click="fn_refundConfirm(one.refund_cd)" class="btnType blue">
									                    <span style="cursor: pointer;">승인</span>
									                </a>
									            </template>
									        </td>
										</tr>
									</template>
								</tbody>
							</table>
							
							<div class="paging_area" id="refundListPagination" v-html="refundListPagination"> </div>
							
						</div>
						
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
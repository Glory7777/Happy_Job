<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
	var divRefundDirecList;
	
	
	$(function() {
		
		// 뷰 초기 설정
		vueInit();
		
		// 반품 신청 목록
		fn_refundDirectionList();
		
	});
	
	
	// 뷰 초기설정
	function vueInit(){
		
		searchArea = new Vue({
			el : "#searchArea",
			data : {
				searchStartDate : "",
				searchEndDate : "",
				searchText : "",
			}
		});
		
		divRefundDirecList = new Vue({
			el : "#divRefundDirecList",
			data : {
				datalist : [],
				totalcnt : 0,
				refundListPagination : "",
				currentPage : 0,
			},
			filters:{
				  comma(val){
				  	return String(val).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
				},
			}
		});
		
	}
	
	
	// 반품 목록 조회
	function fn_refundDirectionList(currentPage){
		
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
				searchText : searchArea.searchText,
		}
		
		var listCallback = function(returndata){
			
			console.log(JSON.stringify(returndata));
			
			divRefundDirecList.datalist = returndata.refundDirectionList;
			divRefundDirecList.totalcnt = returndata.totalcnt;
			
    		var paginationHtml = getPaginationHtml(currentPage, divRefundDirecList.totalcnt, pageSize, pageBlockSize, 'fn_refundDirectionList');

    		divRefundDirecList.refundListPagination = paginationHtml;
    		
    		divRefundDirecList.currentPage = currentPage;
		}
		
    	callAjax("/scm/vueRefundDirectionList.do", "post", "json", true, param, listCallback);
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
							<span class="btn_nav bold">작업지시서</span> <span class="btn_nav bold"> 반품 지시서 목록</span>
							<a href="/scm/refundDirectionvue.do" class="btn_set refresh">새로고침</a>
						</p>

						<p id="searchArea" class="conTitle">
							<span>반품 지시서 목록</span> 
							<span class="fr"> 
							    <input type="date" id="searchStartDate" name="searchStartDate" v-model="searchStartDate" style="height: 25px;" />-
							    <input type="date" id="searchEndDate" name="searchEndDate" v-model="searchEndDate" style="height: 25px; margin-right: 10px;" />
							    <label style="margin-right: 10px;">상품 명</label><input type="text" id="searchText" name="searchText" v-model="searchText" style="width: 150px; height: 25px;" />
							    <a class="btnType blue" href="javascript:fn_refundDirectionList();" name="modal"><span>검색</span></a>
							</span>
						</p>
						
						<div id="divRefundDirecList" class="divRefundDirecList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="10%">
									<col width="30%">
									<col width="20%">
									<col width="10%">
									<col width="15%">
									<col width="15%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">반품코드</th>
										<th scope="col">상품명</th>
										<th scope="col">주문 일자</th>
										<th scope="col">반품 수량</th>
										<th scope="col">반품 총 금액</th>
										<th scope="col">승인 여부</th>
									</tr>
								</thead>
								<tbody>
									<template v-if="totalcnt == 0">
										<tr>
											<td colspan=6> 데이터가 없습니다.</td>
										</tr>
									</template>
									<template v-else v-for="one in datalist">
										<tr>
											<td>{{ one.refund_cd }}</td>
											<td>{{ one.pro_nm }}</td>
											<td>{{ one.order_date }}</td>
											<td>{{ one.refund_cnt }}</td>
											<td>{{ one.refund_price | comma }} 원</td>
											<td v-if="one.refund_st === '0'" style="color: tomato; font-weight: bold;">미승인</td>
											<td v-else style="color: #4ea5d9; font-weight: bold;">승인</td>
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
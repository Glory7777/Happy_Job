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
	
	$(function() {
		
		// 반품지시서 목록 조회 (첫화면)
		fn_refundList();
		
	});

    // 반품지시서 목록 조회 (첫화면)
	function fn_refundList(currentPage){
    	
		$("#refundDetail").hide();
		
		var currentPage = currentPage || 1;
		
		var searchStartDate = $("#searchStartDate").val();
		var searchEndDate = $("#searchEndDate").val();
		
		if((searchStartDate !== '' && searchEndDate !== '') && searchEndDate < searchStartDate){
			
			searchEndDate = $("#searchStartDate").val();
			searchStartDate = $("#searchEndDate").val();
			
		}  else if(searchEndDate == searchStartDate){
			
			searchStartDate = $("#searchStartDate").val();
			searchEndDate = $("#searchEndDate").val();
		}

		var param = {
				pageSize : pageSize,
				currentPage : currentPage,
				searchStartDate : searchStartDate,
				searchEndDate : searchEndDate,
				searchText : $("#searchText").val()
		}
		
		var listCallback = function(returndata){
			
			$("#refundDirectionList").empty().append(returndata);
			
			var totalcnt = $("#totalcnt").val();
    		var paginationHtml = getPaginationHtml(currentPage, totalcnt, pageSize, pageBlockSize, 'fn_refundList');

    		$("#refundDirectionPagination").empty().append( paginationHtml );
    		
    		$("#currentPagenotice").val(currentPage);
		}
		
    	callAjax("/dlm/dlmRefundList.do", "post", "text", true, param, listCallback);
	}
    
    // 반품지시서 상세목록
    function fn_dlmRefundDetail(refund_cd, ct_nm, pro_model_nm, pro_nm, pro_mfc, refund_cnt, refund_text, pro_cd){
    	
    	$("#refundDetail").show();
    	
    	var refundText = null;
    	
    	switch (refund_text){
		case '1' :
			var refundText = '상품 불량';
			break;
		case '2' :
			refundText = '상품 파손';
			break;
		case '3' :
			refundText = '상품 오배송';
			break;
		case '4' :
			refundText = '지연 배송';
			break;
		case '5' :
			refundText = '상품 불만족';
			break;
		case '6' :
			refundText = '주문착오';
			break;
		case '7' :
			refundText = '기타 사유';
			break;
	}
    	
    	$("#refundCd").text(refund_cd);
    	$("#proCate").text(ct_nm);
    	$("#proModelNm").text(pro_model_nm);
    	$("#proNm").text(pro_nm);
    	$("#proMfc").text(pro_mfc);
    	$("#refundCnt").text(refund_cnt);
    	$("#refundText").text(refundText);
    	$("#proCd").text(pro_cd);
    
    }
    
    // 재고처리 확인 - 스윗알럿 빨간줄 뜨는데 실행은 잘 됨요
    function fn_stockPlus(){
    	
    	swal("재고처리를 하시겠습니까?", {
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
				fn_confirm();
				break;
			}
		});
    }
    
	// 재고 처리  - 스윗알럿 빨간줄 뜨는데 실행은 잘 됨요
	function fn_confirm(){
		
		var loginId = "${loginId}";
		
    	var param = {
    			proCd : $("#proCd").text(),
    			proNm : $("#proNm").text(),
    			refundCd : $("#refundCd").text(),
    			refundCnt : $("#refundCnt").text(),
    			loginId : loginId
    	}
    	
    	var listCallback = function(returndata){
			if(returndata.result == "success"){
				swal("재고처리가 완료되었습니다.")
				.then((value) => {
					fn_refundList();
				});
			}
		}
		
		callAjax("/dlm/stockPlus.do", "post", "json", true, param, listCallback);
	}

</script>

</head>
<body>
<form id="myForm" action=""  method="">
	  <input type="hidden" id="currentPagenotice" />proCd
	  <input type="hidden" id="proCd" />
	
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
							<span class="btn_nav bold">기업고객</span>
							<span class="btn_nav bold"> 반품 지시서</span>
							<a href="/dlm/dlmRefundList.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>반품 지시서</span> 
							<span class="fr"> 
							    <label style="margin-right: 10px;">반품승인일자</label><input type="date" id="searchStartDate" name="searchStartDate" style="height: 25px;" />-
							    <input type="date" id="searchEndDate" name="searchEndDate" style="height: 25px; margin-right: 10px;" />
							    <label style="margin-right: 10px;">상품 명</label>
							    <input type="text" id="searchText" name="searchtext"  style="width: 150px; height: 25px;" />
							    <a class="btnType blue" href="javascript:fn_refundList();" name="modal"><span>검색</span></a>
							</span>
						</p>
						
						<div class="divComGrpCodList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="10%">
									<col width="20%">
									<col width="35%">
									<col width="15%">
									<col width="20%">
								</colgroup>
								<thead>
									<tr>
										<th scope="col">반품번호</th>
										<th scope="col">상품 모델 명</th>
										<th scope="col">상품명</th>
										<th scope="col">반품 수량</th>
										<th scope="col">반품 처리일자</th>
									</tr>
								</thead>
								<tbody id="refundDirectionList"></tbody>
							</table>
						</div>
	
						<div class="paging_area"  id="refundDirectionPagination"> </div>
						
						<div class="divComGrpCodList"  id="refundDetail">
							<br><br>
							<p class="conTitle">
								<span>상세 내역</span> 
							</p>
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="7%">
									<col width="12%">
									<col width="18%">
									<col width="30%">
									<col width="10%">
									<col width="8%">
									<col width="15%">
								</colgroup>
								<thead>
									<tr>
										<th scope="col">반품번호</th>
										<th scope="col">제품 구분</th>
										<th scope="col">상품 모델 명</th>
										<th scope="col">상품 명</th>
										<th scope="col">제조사</th>
										<th scope="col">반품 수량</th>
										<th scope="col">반품 사유</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td scope="col" id="refundCd"></td>
										<td scope="col" id="proCate"></td>
										<td scope="col" id="proModelNm"></td>
										<td scope="col" id="proNm"></td>
										<td scope="col" id="proMfc"></td>
										<td scope="col" id="refundCnt"></td>
										<td scope="col" id="refundText"></td>
									</tr>
								</tbody>
							</table>
							
							<p style="height: 40px;">
								<span class="fr" style="margin-top: 10px; text-align: center;">
									<a class="btnType blue" href="javascript:fn_stockPlus()"><span>재고 처리</span></a>
								</span>
							</p>
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
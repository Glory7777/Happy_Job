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
		
		// 반품신청 목록
		fn_refundList();
		
	});

    // 반품신청 목록 조회
	function fn_refundList(currentPage){
		
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
				searchSel : $("#searchSel").val(),
				searchText : $("#searchText").val()
		}
		
		var listCallback = function(returndata){
			
			$("#refundList").empty().append(returndata);
			
			var totalcnt = $("#totalcnt").val();
    		var paginationHtml = getPaginationHtml(currentPage, totalcnt, pageSize, pageBlockSize, 'fn_refundList');

    		$("#refundListPagination").empty().append( paginationHtml );
    		
    		$("#currentPagenotice").val(currentPage);
		}
		
    	callAjax("/exe/refundList.do", "post", "text", true, param, listCallback);
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
    
	// 승인 확인
	function fn_confirm(refund_cd){
		console.log(refund_cd);
		
		var param = {
				refundCd : refund_cd
		}
		
		var directionConfirmCallback = function(returndata){
			if(returndata.result == "success"){
				swal("승인이 완료 되었습니다.")
				.then((value) => {
				    window.location.reload();
				});
			}
		}
		
		callAjax("/exe/refundDirectionConfirm.do", "post", "json", true, param, directionConfirmCallback);

	}
    
</script>

</head>
<body>
<form id="myForm" action=""  method="">
	  <input type="hidden" id="currentPagenotice" />
	
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

						<p class="conTitle">
							<span>반품 신청 목록</span> 
							<span class="fr"> 
							    <label>반품신청일 :  </label><input type="date" id="searchStartDate" name="searchStartDate" style="height: 25px;" />-
							    <input type="date" id="searchEndDate" name="searchEndDate" style="height: 25px; margin-right: 10px;" />
							    <select id="searchSel" name="searchsel" style="width: 100px; height: 27px;" >
							         <option value="">반품 전체</option>
							         <option value="refundUserId">반품 고객</option>
							         <option value="proNm">상품 명</option>
							    </select>
							    <input type="text" id="searchText" name="searchtext"  style="width: 150px; height: 25px;" />
							    <a class="btnType blue" href="javascript:fn_refundList();" name="modal"><span>검색</span></a>
							</span>
						</p>
						
						<div class="divComGrpCodList">
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
								<tbody id="refundList"></tbody>
							</table>
						</div>
	
						<div class="paging_area"  id="refundListPagination"> </div>
						
						
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>

	<!--// 모달팝업 -->
	<div id="noticepop" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong>공지사항 등록</strong>
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
							<th scope="row">등록 일자</th>
							<td id="regdate">
							 </td>
							<th scope="row">수정 일자</th>
							<td id="moddate">
							 </td>
						</tr>
						<tr>
							<th scope="row">공지 제목 <span class="font_red">*</span></th>
							<td colspan="3">
							      <input type="text" class="inputTxt p100" name="notice_title" id="notice_title" />
							 </td>
						</tr>
						<tr>
							<th scope="row">공지내용 <span class="font_red">*</span></th>
							<td colspan="3">
							     <textarea name="notice_content" id="notice_content"  rows="5" cols="30"  ></textarea>
						    </td>
						</tr>
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSave" name="btn"><span>저장</span></a> 
					<a href="" class="btnType blue" id="btnDelete" name="btn"><span>삭제</span></a> 
					<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	
	<!--// 모달팝업 -->
	<div id="noticepopfile" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong>공지사항 등록</strong>
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
							<th scope="row">등록 일자</th>
							<td id="regdatefile">
							 </td>
							<th scope="row">수정 일자</th>
							<td id="moddatefile">
							 </td>
						</tr>
						<tr>
							<th scope="row">공지 제목 <span class="font_red">*</span></th>
							<td colspan="3">
							      <input type="text" class="inputTxt p100" name="notice_titlefile" id="notice_titlefile" />
							 </td>
						</tr>
						<tr>
							<th scope="row">공지내용 <span class="font_red">*</span></th>
							<td colspan="3">
							     <textarea name="notice_contentfile" id="notice_contentfile"  rows="5" cols="30"  ></textarea>
						    </td>
						</tr>
						<tr>
							<th scope="row">파일 <span class="font_red">*</span></th>
							<td>
							      <input type="file"  id="selfile" name="selfile"  class="inputTxt p100"  onChange="javascript:imagechage(event)" />
							 </td>
							<td colspan="2">
							      <div id="filepreview"></div>
							 </td>
						</tr>						
						
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSavefile" name="btn"><span>저장</span></a> 
					<a href="" class="btnType blue" id="btnDeletefile" name="btn"><span>삭제</span></a> 
					<a href=""	class="btnType gray"  id="btnClosefile" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>	
	
</form>
</body>
</html>
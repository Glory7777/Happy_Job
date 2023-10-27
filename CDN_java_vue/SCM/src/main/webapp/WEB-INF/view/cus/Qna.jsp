<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
		
		comcombo("categoryCD", "searchCate", "all", "");
		
		// 공지사항 조회
		fn_searchlist();
		
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
	});
	
	
	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();
	
			var btnId = $(this).attr('id');
	
			switch (btnId) {
				case 'btnInsert' :	
				case 'btnSave' :
					fn_Save();
					break;			
				case 'btnDelete' :
					fn_Delete();
					break;
				case 'btnClose' :
					gfCloseModal();
					if($("#action").val() == "I") {
						fn_searchlist();
	    			} else if($("#action").val() == "U") {
	    				fn_searchlist($("#currentPageqna").val());
	    			} else if($("#action").val() == "D") {
	    				fn_searchlist();
	    			}
					break;
					
			}
		});
	}

    
	/** 나의 문의 내역 초기 화면 */
    function fn_searchlist(currentPage) {
    	
    	var currentPage = currentPage || 1;
    	
    	var param = {
    			pageSize : pageSize,
    			currntPage : currentPage,
    			loginid : "${sessionScope.loginId}",
    	}
    	
       var listcallback = function(returndata) {
    		console.log(returndata);
    		
    		$("#qnaList").empty().append(returndata);
    		
    		console.log($("#totalcnt").val());
    		
    		var totalcnt = $("#totalcnt").val();
    		
    		var paginationHtml = getPaginationHtml(currentPage, totalcnt, pageSize, pageBlockSize, 'fn_searchlist');
    		console.log("paginationHtml : " + paginationHtml);
    		//swal(paginationHtml);
    		$("#qnaPagination").empty().append( paginationHtml );
    		
    		// 현재 페이지 설정
    		$("#currentPageqna").val(currentPage);
    		
    	}
    	
    	callAjax("/cus/qnaList.do", "post", "text", true, param, listcallback);
	}
	
	/** 문의 내역 상세 모달 창 */
    function fn_selectqna(qna_cd) {
    	
    	var param = {
    			qna_cd : qna_cd
    	}
    	
    	var selectcallback = function(returndata) {
    		console.log(JSON.stringify(returndata));  
    		fn_popupint(returndata.sectinfo);
    		
    		gfModalPop("#qnapop");
    	}
    	
    	callAjax("/cus/qnaSelect.do", "post", "json", true, param, selectcallback);
    	
    }
	
	/** Qna 상세 모달 창 양식 */
    function fn_popupint(data) {
		
    	var param = {
    			loginid : loginid
    	}
    	//qnaSelect와 mapping
    	if(data == null || data == undefined || data == "") {
        	$("#qna_title").val("");
        	$("#searchCate").val("");    	
        	$("#loginid").text('${loginId}');  
        	$("#qna_content").val("");
        	$("#selqnacd").val("");
        	$("#action").val("I");
        	
        	$("#btnInsert").show();
        	$("#btnClose").hide();
        	$(".commentTb").hide();
        	$("#btnSave").hide();   
        	$("#btnDelete").hide(); 
        	
    	}  else {
        	$("#qna_title").val(data.qna_title);
        	$("#searchCate").val(data.qna_ct);
        	$("#loginid").text(data.loginid);
        	$("#qna_content").val(data.qna_content);
        	$("#answer_content").val(data.answer_content);
        	$("#action").val("U");  

        	$("#selqnacd").val(data.qna_cd);
        	
        	$("#btnInsert").hide();
        	$("#btnClose").show();
        	$(".commentTb").show();
        	$("#btnSave").show();   
        	$("#btnDelete").show();
    	}

    }
	
	/** 새 문의하기 모달 창 */
    function fn_creatQna() {
    	fn_popupint();
    	
		// 모달 팝업
		gfModalPop("#qnapop");
		
    }
	
    /** 문의하기 등록 */
    function fn_Save() {
    	
    	if(!fValidate()) {
    		return;
    	}
    	   	
     	var param = {
    			action : $("#action").val(),
    			qna_title : $("#qna_title").val(),
    			qna_ct : $("#searchCate").val(),
    			loginid : '${loginId}',
    			qna_content : $("#qna_content").val(),
    			
    			qna_cd : $("#selqnacd").val(),
    	}
    	
    	var savecallback = function(returnvalue) {
    		console.log(JSON.stringify(returnvalue));
    		
    		if(returnvalue.result == "SUCCESS") {
    			alert("저장 되었습니다.");
    			gfCloseModal();
    			
    			if($("#action").val() == "I") {
    				fn_searchlist();
    			} else if($("#action").val() == "U") {
    				fn_searchlist($("#currentPageqna").val());
    			} else if($("#action").val() == "D") {
    				fn_searchlist();
    			}
    		}
    		
    	}
    	callAjax("/cus/qnaSave.do", "post", "json", true, param, savecallback);
    }
    
	/** 저장 validation */
	function fValidate() {

		var chk = checkNotEmpty(
				[
						[ "qna_title", "제목을 입력해 주세요." ]
					,   [ "qna_ct", "카테고리를 선택해 주세요." ]
					,	[ "qna_content", "내용을 입력해 주세요" ]				]
		);

		if (!chk) {
			return;
		}

		return true;
	}
	
	/** 문의하기 삭제 */
    function fn_Delete() {
    	$("#action").val("D"); 
    	fn_Save();
    }
</script>
</head>

<body>
	<form id="myForm" action="" method="">
		<input type="hidden" id="currentPageqna" /> <input type="hidden"
			id="action" name="action" />
		<!-- 선택된 qna_cd  값 -->
		<input type="hidden" id="selqnacd" name="selqnacd" />

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
								<span class="btn_nav bold">고객 센터</span> <span
									class="btn_nav bold"> 1:1 문의</span> <a href="/cus/qna.do"
									class="btn_set refresh">새로고침</a>
							</p>

							<p class="conTitle">
								<span>나의 문의 내역</span> <span class="fr"> <a
									class="btnType blue" href="javascript:fn_creatQna();"
									name="modal"><span>문의하기</span></a>
								</span>
							</p>

							<div class="divComGrpCodList">
								<table class="col">
									<caption>caption</caption>
									<colgroup>
										<col width="10%">
										<col width="20%">
										<col width="40%">
										<col width="20%">
										<col width="10%">
									</colgroup>

									<thead>
										<tr>
											<th scope="col">번호</th>
											<th scope="col">카테고리</th>
											<th scope="col">제목</th>
											<th scope="col">문의일</th>
											<th scope="col">답변 상태</th>
										</tr>
									</thead>
									<tbody id="qnaList"></tbody>
								</table>
							</div>

							<div class="paging_area" id="qnaPagination"></div>


						</div> <!--// content -->

						<h3 class="hidden">풋터 영역</h3> <jsp:include
							page="/WEB-INF/view/common/footer.jsp"></jsp:include>
					</li>
				</ul>
			</div>
		</div>

		<!--// 모달팝업 -->
		<div id="qnapop" class="layerPop layerType2" style="width: 70%;">
			<dl>
				<dt>
					<strong>1:1 문의</strong>
				</dt>
				<dd class="content">

					<!-- s : 문의 내용 -->

					<table class="row">
						<caption>caption</caption>
						<colgroup>
							<col width="10%">
							<col width="30%">
							<col width="10%">
							<col width="20%">
							<col width="10%">
							<col width="20%">
						</colgroup>

						<tbody>
							<tr>
								<th scope="row">제목 <span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt p100"
									name="qna_title" id="qna_title" /></td>
								<th scope="row">카테고리 <span class="font_red">*</span></th>
								<td><select id="searchCate" name="searchCate">
								</select></td>
								<th scope="row">작성자</th>
								<td id="loginid"></td>
							</tr>
							<tr>
								<th scope="row">내용 <span class="font_red">*</span></th>
								<td colspan="6"><textarea name="qna_content"
										id="qna_content" style="height: 200px;"></textarea></td>
							</tr>
						</tbody>
					</table>

					<!-- e : 수정,  삭제 버튼-->

					<div class="btn_areaC mt10 mb30">
						<a href="" class="btnType blue" id="btnInsert" name="btn"><span>등록</span></a>
						<a href="" class="btnType blue" id="btnSave" name="btn"><span>수정</span></a>
						<a href="" class="btnType blue" id="btnDelete" name="btn"><span>삭제</span></a>
					</div>

					<!-- s : 답변 내용 (read only) -->

					<table class="row commentTb">
						<caption>caption</caption>
						<colgroup>
							<col width="100px">
							<col width="1100px">
						</colgroup>

						<tbody>
							<tr>
								<th scope="row">답변 내용</th>
								<td colspan="6"><textarea name="answer_content"
										id="answer_content" style="height: 200px;" readonly></textarea>
								</td>
							</tr>
						</tbody>
					</table>

					<!-- e : 취소 버튼-->

					<div class="btn_areaC mt10">
						<a href="" class="btnType gray" id="btnClose" name="btn"><span>취소</span></a>
					</div>

				</dd>
			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div>

	</form>
</body>
</html>
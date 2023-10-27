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
		
		// Qna 목록 조회
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
	    				fn_searchlist($("#currentPageAnswer").val());
	    			} else if($("#action").val() == "D") {
	    				fn_searchlist();
	    			}
					break;
					
			}
		});
	}

    
	/** Qna 목록 초기 화면 */
    function fn_searchlist(currentPage) {
    	
    	var currentPage = currentPage || 1;
    	
    	var param = {
    			pageSize : pageSize,
    			currntPage : currentPage
    	}
    	
       var listcallback = function(returndata) {
    		
    		$("#answerList").empty().append(returndata);
    		
    		var totalcnt = $("#totalcnt").val();
    		
    		var paginationHtml = getPaginationHtml(currentPage, totalcnt, pageSize, pageBlockSize, 'fn_searchlist');
    		console.log("paginationHtml : " + paginationHtml);
    		//swal(paginationHtml);
    		$("#answerPagination").empty().append( paginationHtml );
    		
    		// 현재 페이지 설정
    		$("#currentPageAnswer").val(currentPage);
    		
    	}
    	
    	callAjax("/scm/answerList.do", "post", "text", true, param, listcallback);
	}
	
	/** Qna 상세 모달 창 */
    function fn_selectAnswer(qna_cd) {
    	
    	var param = {
    			qna_cd : qna_cd
    	}
    	
    	var selectcallback = function(returndata) {
    		console.log(JSON.stringify(returndata));  
    		fn_popupint(returndata.sectinfo);
    		
    		gfModalPop("#answerpop");
    	}
    	
    	callAjax("/scm/answerSelect.do", "post", "json", true, param, selectcallback);
    	
    }
    
	/** Qna 상세 모달 창 양식 */
    function fn_popupint(data) {
		
    	var param = {
    			loginid : loginid
    	}

    	if(data.answer_content == null || data.answer_content == undefined || data.answer_content == "") {
        	$("#loginid").text(data.loginid);
        	$("#regdate").text(data.qna_reg_date);
        	$("#qna_title").text(data.qna_title);
        	$("#qna_content").text(data.qna_content);
        	$("#answer_content").val("");
        	$("#action").val("I");  
        	
        	$("#selAnswercd").val(data.qna_cd);
    	}  else {
        	$("#loginid").text(data.loginid);
        	$("#regdate").text(data.qna_reg_date);
        	$("#qna_title").text(data.qna_title);
        	$("#qna_content").text(data.qna_content);
        	$("#answer_content").val(data.answer_content);
        	$("#action").val("U");  
        	
        	$("#selAnswercd").val(data.qna_cd);
    	}
	}	
    /** Qna 답변 등록 */
    function fn_Save() {
    	
    	if(!fValidate()) {
    		return;
    	}
    	   	
     	var param = {
    			action : $("#action").val(),
     			answer_content :$("#answer_content").val(),
    			loginid : '${loginId}',
    			
    			qna_cd : $("#selAnswercd").val(),
    			//qna_yn : '1'
    	}
    	
    	var savecallback = function(returnvalue) {
    		console.log(JSON.stringify(returnvalue));
    		
    		if(returnvalue.result == "SUCCESS") {
    			alert("저장 되었습니다.");
    			gfCloseModal();
    			
    			if($("#action").val() == "I") {
    				fn_searchlist();
    			} else if($("#action").val() == "U") {
    				fn_searchlist($("#currentPageAnswer").val());
    			} else if($("#action").val() == "D") {
    				fn_searchlist();
    			}
    		}
    		
    	}
    	callAjax("/scm/answerSave.do", "post", "json", true, param, savecallback);
    }
    
	/** 저장 validation */
	function fValidate() {

		var chk = checkNotEmpty(
				[ "answer_content", "답변 내용을 입력해 주세요." ]
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
		<input type="hidden" id="currentPageAnswer" /> <input type="hidden"
			id="action" name="action" />
		<!-- 해당 게시글 pk 값 -->
		<input type="hidden" id="selAnswercd" name="selAnswercd" />

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
									class="btn_nav bold"> 1:1 문의</span> <a href="/scm/noticeMgr.do"
									class="btn_set refresh">새로고침</a>
							</p>

							<p class="conTitle">
								<span>1:1문의 답변</span>
							</p>

							<div class="divComGrpCodList">
								<table class="col">
									<caption>caption</caption>
									<colgroup>
										<col width="10%">
										<col width="10%">
										<col width="40%">
										<col width="20%">
										<col width="10%">
										<col width="10%">
									</colgroup>

									<thead>
										<tr>
											<th scope="col">번호</th>
											<th scope="col">카테고리</th>
											<th scope="col">제목</th>
											<th scope="col">문의일</th>
											<th scope="col">작성자</th>
											<th scope="col">답변 상태</th>
										</tr>
									</thead>
									<tbody id="answerList"></tbody>
								</table>
							</div>

							<div class="paging_area" id="answerPagination"></div>


						</div> <!--// content -->

						<h3 class="hidden">풋터 영역</h3> <jsp:include
							page="/WEB-INF/view/common/footer.jsp"></jsp:include>
					</li>
				</ul>
			</div>
		</div>

		<!--// 모달팝업 -->
		<div id="answerpop" class="layerPop layerType2" style="width: 70%;">
			<dl>
				<dt>
					<strong>1:1 문의</strong>
				</dt>
				<dd class="content">

					<!-- s : 문의 내용 -->

					<table class="row">
						<caption>caption</caption>
						<colgroup>
							<col width="15%">
							<col width="35%">
							<col width="15%">
							<col width="35%">
						</colgroup>

						<tbody>
							<tr>
								<th scope="row">문의 작성자</span></th>
								<td id="loginid"></td>
								<th scope="row">문의 작성일</th>
								<td id="regdate"></td>
							</tr>
							<tr>
								<th scope="row">문의 제목</th>
								<td colspan="3" id="qna_title"></td>
							</tr>
							<tr>
								<th scope="row">문의 내용</th>
								<td colspan="3"><textarea name="qna_content"
										id="qna_content" style="height: 200px;" readonly></textarea></td>
							</tr>
							<tr>
								<th scope="row">답변 내용 <span class="font_red">*</span></th>
								<td colspan="3"><textarea name="answer_content"
										id="answer_content" style="height: 200px;"></textarea></td>
							</tr>

						</tbody>
					</table>

					<!-- e : 저장, 삭제, 취소 버튼-->

					<div class="btn_areaC mt10 mb30">
						<a href="" class="btnType blue" id="btnInsert" name="btn"><span>저장</span></a>
						<a href="" class="btnType blue" id="btnSave" name="btn"><span>수정</span></a>
						<a href="" class="btnType blue" id="btnDelete" name="btn"><span>삭제</span></a>
						<a href="" class="btnType gray" id="btnClose" name="btn"><span>취소</span></a>
					</div>
				</dd>
			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div>

	</form>
</body>
</html>
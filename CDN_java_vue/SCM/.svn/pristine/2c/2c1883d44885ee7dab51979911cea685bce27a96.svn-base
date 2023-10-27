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

	/** 변수 선언 */
	var pageSize = 10;
	var pageBlockSize = 5;
	
	/**  new Vue el */
	var contentDiv;
	var answerpop;
	
	/** onload */
	$(function() {
		
		// Vue
		vueInit()
		
		// Qna 목록 조회
		fn_searchlist();
	});
	
	/** Vue */
	function vueInit() {
		
		contentDiv = new Vue({
							el: "#contentDiv",
						  data: {
							  allAnswerList: [],
							  totalcnt: 0,
							  answerPagination: "",
							  currntPage: 0,
						  },
		});
		
		answerpop = new Vue({
							el: "#answerpop",
						  data: {
							 	isreadonly: true,
							 	wd1: "width: 70%;",
							 	ht1: "height: 200px",
								
								loginid: "${sessionScope.loginId}",
								usernm: "${sessionScope.userNm}",
								qna_reg_date:"",
								qna_title: "",
								qna_content: "",
								action: "",
								answer_content: "",
								qna_cd: "",
								btnInsert: true,
								btnSave: false,
								btnDelete: false,
								btnClose: true,
							},
					  methods: {
								fn_ButtonClickEvent: function(event){
									event.preventDefault();
									// 클릭이벤트 실행되는 요소의 id값 가져오기
									var btnId = event.currentTarget.id;
									console.log(btnId);
									if(btnId === 'btnInsert' || btnId === 'btnSave'){
										return fn_Save();
									}else if(btnId === 'btnDelete'){
										return fn_Delete();
									}else{
										gfCloseModal();
										if(btnId == "btnInsert"){
											return fn_searchlist();
										}else if(btnId == "btnSave"){
											return fn_searchlist();
										}else{
											return fn_searchlist();
										}
									}
								}
					  },
		});
	}

	/** Qna 목록 초기 화면 */
    function fn_searchlist(currentPage) {
    	
    	var currentPage = currentPage || 1;
    	
    	var param = {
    			pageSize : pageSize,
    			currntPage : currentPage
    	};
    	
       var listcallback = function(returndata) {
    		
    		contentDiv.allAnswerList = returndata.answerList;
    		contentDiv.totalcnt = returndata.totalcnt;
    		
    		var paginationHtml = getPaginationHtml(currentPage, contentDiv.totalcnt, pageSize, pageBlockSize, 'fn_searchlist');
    		console.log("paginationHtml : " + paginationHtml);
    		//swal(paginationHtml);
    		contentDiv.answerPagination = paginationHtml;
    		// 현재 페이지 설정
    		contentDiv.currntPage = currentPage;
    	}
    	callAjax("/scm/answerListvue.do", "post", "json", true, param, listcallback);
	}
	
	/** Qna 상세 모달 창(답변 가능) */
    function fn_selectAnswer(qna_cd) {
    	
    	var param = {
    			qna_cd : qna_cd
    	};
    	
    	var selectcallback = function(returndata) {
    		// controller에서 put된 sectinfo
    		console.log(JSON.stringify(returndata));  
    		// 모달 팝업 창에 데이터 넣기
    		fn_popupint(returndata.sectinfo);
    		// 모달 팝업 창 html
    		gfModalPop("#answerpop");
    	}
    	callAjax("/scm/answerSelect.do", "post", "json", true, param, selectcallback);
    }
    
	/** Qna 상세 모달 창 양식 */
    function fn_popupint(data) {

    	if(data.answer_content == null || data.answer_content == undefined || data.answer_content == "") {
    		answerpop.loginid = data.loginid;
    		answerpop.regdate = data.qna_reg_date;
    		answerpop.qna_title = data.qna_title;
    		answerpop.qna_content = data.qna_content;
    		answerpop.answer_content = "";
    		answerpop.action = "I";
    		// 화면에 없지만 DB에 넣어주는 값
    		answerpop.qna_cd = data.qna_cd; 
    		// 버튼 show/hide
    		answerpop.btnInsert = true;
    		answerpop.btnSave = false;
    		answerpop.btnDelete = false;
    	}  else {
    		answerpop.loginid = data.loginid;
    		answerpop.regdate = data.qna_reg_date;
    		answerpop.qna_title = data.qna_title;
    		answerpop.qna_content = data.qna_content;
    		answerpop.answer_content = data.answer_content;
    		answerpop.action = "U";  
    		// 화면에 없지만 DB에 넣어주는 값
    		answerpop.qna_cd = data.qna_cd;
    		// 버튼 show/hide
    		answerpop.btnInsert = false;
    		answerpop.btnSave = true;
    		answerpop.btnDelete = true;
    	}
	}	
    /** Qna 답변 등록 */
    function fn_Save() {
    	
    	if(!fValidate()) {
    		return;
    	}
    	   	
     	var param = {
    			action: answerpop.action,
     			answer_content: answerpop.answer_content,
    			loginid: "${sessionScope.loginId}",
    			
    			qna_cd: answerpop.qna_cd,
    	};
    	
    	var savecallback = function(returnvalue) {
    		console.log(JSON.stringify(returnvalue));
    		
    		if(returnvalue.result == "SUCCESS") {
    			alert("완료 되었습니다.");
    			gfCloseModal();
    			if(answerpop.action == "I") {
    				fn_searchlist();
    			} else if(answerpop.action == "U") {
    				fn_searchlist();
    			} else if(answerpop.action == "D") {
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
    	answerpop.action = "D"; 
    	fn_Save();
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
						<!--// lnb 영역 -->
					</li>
					<li class="contents">
						<!-- contents -->
						<h3 class="hidden">contents 영역</h3> <!-- content -->
						<div class="content">
							<p class="Location">
								<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a>
								<span class="btn_nav bold">고객 센터</span>
								<span class="btn_nav bold"> 1:1 문의</span>
								<a href="/scm/noticeMgr.do" class="btn_set refresh">새로고침</a>
							</p>
							<p class="conTitle">
								<span>1:1문의 답변</span>
							</p>
							<div class="divComGrpCodList" id="contentDiv">
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
									<tbody>
										<template v-if="totalcnt == 0">
											<tr><td colspan="6">데이터가 없습니다</td></tr>
										</template>
										<template v-else v-for="sel in allAnswerList">
											<tr @click="fn_selectAnswer(sel.qna_cd)">
												<td>{{sel.qna_cd}}</td>
												<td>{{sel.qna_ct}}</td>
												<td>{{sel.qna_title}}</td>
												<td>{{sel.qna_reg_date}}</td>
												<td>{{sel.loginid}}</td>
												<td>{{sel.qna_yn}}</td>
											</tr>
										</template>
									</tbody>
								</table>
								<div class="paging_area" id="answerPagination" v-html="answerPagination"></div>
							</div>
						</div>
						<!--// content -->
						<h3 class="hidden">풋터 영역</h3> <jsp:include
							page="/WEB-INF/view/common/footer.jsp"></jsp:include>
					</li>
				</ul>
			</div>
		</div>

		<!--// 모달팝업 -->
		<div id="answerpop" class="layerPop layerType2" :style="wd1">
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
								<td id="loginid" v-text="loginid"></td>
								<th scope="row">문의 작성일</th>
								<td id="regdate" v-text="regdate"></td>
							</tr>
							<tr>
								<th scope="row">문의 제목</th>
								<td colspan="3" id="qna_title" v-text="qna_title"></td>
							</tr>
							<tr>
								<th scope="row">문의 내용</th>
								<td colspan="3">
									<textarea name="qna_content" id="qna_content" v-text="qna_content" :style="ht1" :readonly="isreadonly"></textarea>
								</td>
							</tr>
							<tr>
								<th scope="row">답변 내용 <span class="font_red">*</span></th>
								<td colspan="3">
									<textarea name="answer_content" id="answer_content" v-model="answer_content" :style="ht1"></textarea>
								</td>
							</tr>
						</tbody>
					</table>
					<!-- e : 저장, 삭제, 취소 버튼-->
					<div class="btn_areaC mt10 mb30">
						<a class="btnType blue" id="btnInsert" name="btn" v-show="btnInsert" @click="fn_ButtonClickEvent"><span>저장</span></a>
						<a class="btnType blue" id="btnSave" name="btn" v-show="btnSave" @click="fn_ButtonClickEvent"><span>수정</span></a>
						<a class="btnType blue" id="btnDelete" name="btn" v-show="btnDelete" @click="fn_ButtonClickEvent"><span>삭제</span></a>
						<a class="btnType gray" id="btnClose" name="btn" @click="fn_ButtonClickEvent"><span>취소</span></a>
					</div>
				</dd>
			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div>

	</form>
</body>
</html>
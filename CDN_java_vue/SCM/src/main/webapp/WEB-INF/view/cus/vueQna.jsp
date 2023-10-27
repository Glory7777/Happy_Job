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
	var pageSize = 10;             // 1페이지 당 글 갯수
	var pageBlockSize = 5;         // 페이지 목록 번호 갯수
	
	/**  new Vue el */
	var topDiv;
	var contentDiv;
	var qnapop;
	
	/** onload */
	$(function() {
		
		// Vue
		vueInit()
		
		// 문의 종류 카테고리 셀렉트 박스
		comcombo("categoryCD", "searchCate", "all", "");
		
		// 조회
		fn_searchlist();
	});

	/** Vue */
	function vueInit() {
		
		topDiv = new Vue({
						el: "#topDiv",
				   methods: {
					   		fn_creatQna: function(event) {
								  console.log("기업고객의 1:1문의 페이지에서 문의하기 버튼이 클릭되었습니다!");
								  return fn_creatQna();
					   		},
				   }
		});
		
		contentDiv = new Vue({
							el: "#contentDiv",
						  data: {
							    allQnaList: [],
							    loginid: "${sessionScope.loginId}",
						  	    usernm: "${sessionScope.userNm}",
							    totalcnt: 0,
							    qnaPagination: "",
							    currentPage: 0,
						  },
					  methods: {
							   fn_selectqna: function(qnacd) {
								   console.log("상세보기 팝업이 실행되었습니다!");
								   return fn_selectqna(qnacd);
						  		},
					  }
		});
		
		qnapop = new Vue({
						el: "#qnapop",
					  data: {
						  	wd1: "width: 70%;",
						  
							qna_title: "",
							loginid: "${sessionScope.loginId}",
							usernm: "${sessionScope.userNm}",
							searchCate: "",
							qna_content: "",
							qna_cd: "",
							action: "",
							answer_content: "",
							commentTb: false,
							btnInsert: true,
							btnSave: false,
							btnDelete: false,
						},
					methods: {
							  fn_ButtonClickEvent: function(event){
								  event.preventDefault();
								  // 클릭이벤트 실행되는 요소의 id값 가져오기
								  var btnId = event.currentTarget.id;
								  console.log(btnId);
								  if(btnId === 'btnInsert' || btnId === 'btnSave') {
									  return fn_Save();
								  } else if(btnId === 'btnDelete') {
									  return fn_Delete();
								  } else {
									  gfCloseModal();
									  if(btnId == "btnInsert") {
										  return fn_searchlist();
									  } else if(btnId == "btnSave") {
										  return fn_searchlist();										  
									  } else {
										  return fn_searchlist();
									  }
									  
								  }
							  },
					 },
		});
		
	}
	
	/** 나의 문의 내역 초기 화면 */
    function fn_searchlist(currentPage) {
    	
    	var currentPage = currentPage || 1;
    	
    	var param = {
    			pageSize : pageSize,
    			currntPage : currentPage,
    			loginid : contentDiv.loginid,
    	}
    	
       var listcallback = function(returndata) {
    		    		
    		contentDiv.allQnaList = returndata.qnaList;
    		contentDiv.totalcnt = returndata.totalcnt;
    		
    		var paginationHtml = getPaginationHtml(currentPage, contentDiv.totalcnt, pageSize, pageBlockSize, 'fn_searchlist');
    		
    		console.log("paginationHtml : " + paginationHtml);
    		
    		contentDiv.qnaPagination = paginationHtml;
    		contentDiv.currentPage = currentPage;
    		
    	}
    	callAjax("/cus/qnaListvue.do", "post", "json", true, param, listcallback);
	}

	/** 문의하기 버튼 모달 창 띄우기 */	
	function fn_creatQna() {
    	
		fn_popupint();
    	
		// 모달 팝업
		gfModalPop("#qnapop");
		
    }
	
	/** 모달 창 내용 구성 */
    function fn_popupint(data) {
    	
    	//qnaSelect와 mapping
    	if(data == null || data == undefined || data == "") {
    		qnapop.qna_title = "";
    		qnapop.searchCate = "";  	
    		qnapop.usernm = "${sessionScope.userNm}";
    		qnapop.qna_content = "";
    		qnapop.action = "I";
    		
    		qnapop.commentTb = false;
    		qnapop.btnInsert = true;
    		qnapop.btnSave = false;
    		qnapop.btnDelete = false;
        	
    	}   else {
    		qnapop.qna_title = data.qna_title;
    		qnapop.searchCate = data.qna_ct;
    		qnapop.usernm = data.loginid;
    		qnapop.qna_content = data.qna_content;
    		qnapop.answer_content = data.answer_content;
    		qnapop.action = "U";  

    		qnapop.qna_cd = data.qna_cd;
    		qnapop.commentTb = true;
    		qnapop.btnInsert = false;
    		qnapop.btnSave = true;
    		qnapop.btnDelete = true;
    	} 
    }
	
    /** 문의하기 등록 */
    function fn_Save() {
    	
    	if(!fValidate()) {
    		return;
    	}
    	   	
     	var param = {
    			action: qnapop.action,
    			qna_title: qnapop.qna_title,
    			qna_ct: qnapop.searchCate,
    			loginid: "${sessionScope.loginId}",
    			qna_content: qnapop.qna_content,
    			qna_cd: qnapop.qna_cd
    	}
    	
    	var savecallback = function(returnvalue) {
    		console.log(JSON.stringify(returnvalue));
    		
    		if(returnvalue.result == "SUCCESS") {
    			alert("완료 되었습니다.");
    			gfCloseModal();
    			
    			if(qnapop.action == "I") {
    				fn_searchlist();
    			} else if(qnapop.action == "U") {
    				fn_searchlist(contentDiv.currentPage);
    			} else if(qnapop.action == "D") {
    				fn_searchlist(contentDiv.currentPage);
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
					,   [ "searchCate", "카테고리를 선택해 주세요." ]
					,	[ "qna_content", "내용을 입력해 주세요" ]				]
		);

		if (!chk) {
			return;
		}

		return true;
	}
	
	/** 문의하기 1건 상세보기 */
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
	
	/** 문의하기 삭제 */
    function fn_Delete() {
    	qnapop.action = "D"; 
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
						<h3 class="hidden">contents 영역</h3>
						<div class="content">
							<p class="Location">
								<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a>
								<span class="btn_nav bold">고객 센터</span>
								<span class="btn_nav bold"> 1:1 문의</span>
								<a href="/cus/qnavue.do" class="btn_set refresh">새로고침</a>
							</p>
							<p id="topDiv" class="conTitle">
								<span>나의 문의 내역</span> 
								<span class="fr">
									<a class="btnType blue" @click="fn_creatQna" name="modal"><span>문의하기</span></a>
								</span>
							</p>
							<div id="contentDiv" class="divComGrpCodList">
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
											<th scope="col">답변상태</th>
										</tr>
									</thead>
									<tbody>
										<template v-if="totalcnt == 0">
											<tr><td colspan="5">데이터가 없습니다</td></tr>
										</template>
										<template v-else v-for="selQna in allQnaList">
											<tr @click="fn_selectqna(selQna.qna_cd)">
												<td>{{selQna.qna_cd}}</td>
												<td>{{selQna.qna_ct}}</td>
												<td>{{selQna.qna_title}}</td>
												<td>{{selQna.qna_reg_date}}</td>
												<td>{{selQna.qna_yn}}</td>
											</tr>
										</template>
									</tbody>
								</table>
								<div class="paging_area" id="qnaPagination" v-html="qnaPagination" ></div>
							</div>
						</div> <!--// content -->

						<h3 class="hidden">풋터 영역</h3> <jsp:include
							page="/WEB-INF/view/common/footer.jsp"></jsp:include>
					</li>
				</ul>
			</div>
		</div>

		<!--// 모달팝업 -->
		<div id="qnapop" class="layerPop layerType2" :style="wd1">
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
								<td>
									<input type="text" class="inputTxt p100" name="qna_title" id="qna_title" v-model="qna_title" />
								</td>
								<th scope="row">카테고리 <span class="font_red">*</span></th>
								<td>
									<select id="searchCate" name="searchCate" v-model="searchCate"></select>
								</td>
								<th scope="row">작성자</th>
								<td id="usernm" v-text="usernm" >
								</td>
								</tr>
							<tr>
								<th scope="row">내용 <span class="font_red">*</span></th>
								<td colspan="6">
									<textarea name="qna_content" id="qna_content" v-model="qna_content" style="height: 200px;"></textarea>
								</td>
							</tr>
						</tbody>
					</table>

					<!-- e : 수정,  삭제 버튼-->

					<div class="btn_areaC mt10 mb30">
						<a class="btnType blue" id="btnInsert" name="btn" v-show="btnInsert" @click="fn_ButtonClickEvent"><span>등록</span></a>
						<a class="btnType blue" id="btnSave" name="btn" v-show="btnSave" @click="fn_ButtonClickEvent"><span>수정</span></a>
						<a class="btnType blue" id="btnDelete" name="btn" v-show="btnDelete" @click="fn_ButtonClickEvent"><span>삭제</span></a>
						<a class="btnType gray" id="btnClose" name="btn" @click="fn_ButtonClickEvent"><span>취소</span></a>
					</div>

					<!-- s : 답변 내용 (read only) -->
					<table class="row" v-show="commentTb">
						<caption>caption</caption>
						<colgroup>
							<col width="100px">
							<col width="1100px">
						</colgroup>

						<tbody>
							<tr>
								<th scope="row">답변 내용</th>
								<td colspan="6">
									<textarea name="answer_content" id="answer_content" v-model="answer_content" style="height: 200px;" readonly></textarea>
								</td>
							</tr>
						</tbody>
					</table>
					<!-- // 답변 내용 table -->
				</dd>
			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div>

	</form>
</body>
</html>
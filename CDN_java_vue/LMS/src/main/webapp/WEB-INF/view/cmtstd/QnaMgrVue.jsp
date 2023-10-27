<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>QNA</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- a태그 커서 -->
<style>
	a {cursor : pointer;}
</style>


<script type="text/javascript">
	//그룹코드 페이징 설정
	var pageSize = 5;//한페이지에 몇건 보여줄래?
	var pageBlockSize = 5;

	$(function() {
	   
		// 뷰 등록
		initVue();

		// qns 조회
		fn_searchlist();
	});
	
	// 뷰 등록 --------------------

	var searchArea;
	var divComGrpCodList;
	var qnapop;
	
	function initVue(){
		
		// 검색 영역
		searchArea = new Vue({
			el : "#searchArea",
			data : {
				searchsel : "",
				searchtext : "",
				
				regBtn : false
			},
			methods : {
				fn_searchlist : function(){
					fn_searchlist();
				},
				
				fn_openpopup : function(){
					fn_openpopup();
				},
				
				searchselChange : function(event){
					console.log(event.target.value);
					this.searchsel = event.target.value;
				}
			}
		});
		
		
		// qna 목록 영역
		divComGrpCodList = new Vue({
			el : "#divComGrpCodList",
			data : {
				userType : "",
				loginId : "",
				totalcnt : 0,
				listqna : [],
				qnaPagination : "",
				
				currentPage : 0,
			},
			methods : {
				fn_titleSelectqna : function(brd_no){
					fn_titleSelectqna(brd_no);
				},
				
				fn_updateSelectqna : function(brd_no){
					fn_updateSelectqna(brd_no);
				}
			}
		});
		
		
		// 팝업창 영역
		qnapop = new Vue({
			el : "#qnapop",
			data : {
				regdate : "",
				qna_view : "",
				qna_title : "",
				qna_content : "",
				qnacomment : "",
				commentDate : "",
				brd_no : 0,
				reply_no : 0,
				ans_yn : "",
				
				action : "",
				
				qnaReadonly : false,
				repReadonly : false,
				
				btnSaveShow : false,
				btnDeleteShow : false
			},
			methods : {
				btnSave : function(){
					fn_Save();
				},
				
				btnDelete : function(){
					this.action = "D";
					fn_Save();
				},
				
				btnClose : function(){
					gfCloseModal();
				}
			}
		});
		
	}
	// 뷰 등록 끝 -----------------

	//신규등록버튼 강사는 못보도록

	
	 
	//전체조회함수
	function fn_searchlist(currentPage) {
		
		var currentPage = currentPage || 1;
		
		var param = {
			pageSize : pageSize,
			currentPage : currentPage,
			searchtext : searchArea.searchtext,
			searchsel : searchArea.searchsel
		}
		
		var listcallback = function(returndata) {
			
			divComGrpCodList.userType = returndata.userType;
			if(divComGrpCodList.userType == 'A'){
				searchArea.regBtn = true;	
			}
			divComGrpCodList.loginId = returndata.loginId;
			divComGrpCodList.totalcnt = returndata.totalcnt;
			divComGrpCodList.listqna = returndata.listqna;
			
			var totalcnt = divComGrpCodList.totalcnt;
			
			var paginationHtml = getPaginationHtml(currentPage, totalcnt, pageSize, pageBlockSize, 'fn_searchlist');
			
			divComGrpCodList.qnaPagination = paginationHtml;
			
			divComGrpCodList.currentPage = currentPage;
			
			if (returndata.userType == 'B') {
				searchArea.regBtn = false;
			}
		}
	
		callAjax("/qanda/listqnaVue.do", "post", "json", true, param, listcallback);
	
	}

   
	//데이터작업
	function fn_popupint(data) {
		
		if (data == null || data == undefined || data == "") {
			qnapop.brd_no = null;
			qnapop.reply_no = null;
			qnapop.qna_title = "";
			qnapop.qna_content = "";
			qnapop.qnacomment = "";
			qnapop.commentDate = "";
			qnapop.regdate = "";
			qnapop.qna_view = "";
			
			qnapop.qnaReadonly = false;
			
			qnapop.btnSaveShow = true;
			qnapop.btnDeleteShow = false;
			
			qnapop.action = "I";
		} else {
			
			if(divComGrpCodList.userType == 'A'){
				qnapop.qnaReadonly = false;
			}else{
				qnapop.qnaReadonly = true;
			}
			qnapop.qna_title = data.brd_title;
			qnapop.qna_content = data.brd_ctt;
			qnapop.brd_no = data.brd_no;
			qnapop.reply_no = data.reply_no;
			qnapop.ans_yn = data.ans_yn;
			qnapop.qnacomment = data.reply_ctt;
			qnapop.regdate = data.brd_reg_date;
			qnapop.qna_view = data.brd_veiws_cnt;

			qnapop.action = "U";
		}
	}
   
   
	/** 저장 validation */
	function fValidate() {
	
		var chk = checkNotEmpty(
			[
			   [ "qna_title", "제목를 입력해 주세요." ]
			,  [ "qna_content", "내용을 입력해 주세요" ]            
			]
		);
		
		if (!chk) {
			return;
		}
		
		return true;
	}

	
	//신규등록시
	function fn_openpopup() {
		//데이터작업
		fn_popupint();
	
		// 모달 팝업
		gfModalPop("#qnapop");
	
	}

   
	//제목 클릭시 단건조회
	function fn_titleSelectqna(brd_no) {
		
		var param = {
			brd_no : brd_no
		}
		
		var selectcallback = function(returndata) {
			//console.log(JSON.stringify(returndata));
			
			fn_popupint(returndata.sectinfo);
			
			if(returndata.sectinfo.reply_ctt==null || returndata.sectinfo.reply_ctt == undefined){
				if(divComGrpCodList.userType == 'A') qnapop.qnacomment = "대기중";
				else qnapop.qnacomment = "";
				
				qnapop.commentDate = "";
			}else{
				qnapop.qnacomment = returndata.sectinfo.reply_ctt;
				qnapop.commentDate = returndata.sectinfo.reg_date;
			}
			
			if(divComGrpCodList.loginId == returndata.sectinfo.loginID){
				qnapop.btnSaveShow = true;
				qnapop.btnDeleteShow = true;
				
				qnapop.qnaReadonly = false;
			} else {
				qnapop.btnSaveShow = false;
				qnapop.btnDeleteShow = false;
				
				qnapop.qnaReadonly = true;
				qnapop.repReadonly = true;
			}
			
			gfModalPop("#qnapop");
		
		}
		
		callAjax("/qanda/qnaselect.do", "post", "json", true, param, selectcallback);
	
	}

   
	//저장하기
	function fn_Save(){
		
		console.log(divComGrpCodList.userType);
		console.log(qnapop.action);
		
		if(divComGrpCodList.userType == 'A' && qnapop.action != "D"){
			console.log("123123");
			// 유효성 검사
			if(!fValidate()) {
				return;
			}
		}
		
		if(qnapop.action != "D"){
			if(divComGrpCodList.userType == 'B'){
				if(qnapop.reply_no == 0){
					qnapop.action = "I";
					fValidate();
				} else {
					qnapop.action = "U";
				}
			}
		}
		
		var param = {
			qna_title : qnapop.qna_title,
			qna_content : qnapop.qna_content,
			action : qnapop.action,
			brd_no:  qnapop.brd_no,
			userType:  divComGrpCodList.userType,
			reply_no:  qnapop.reply_no,
			qnacomment : qnapop.qnacomment
		}
		
		var savecallback = function(returnvalue) {
			//console.log(JSON.stringify(returnvalue));
		
			if(returnvalue.result == "SUCCESS") {
				swal("저장 되었습니다.");
				gfCloseModal();
			
				if(qnapop.action == "I") {
					fn_searchlist(divComGrpCodList.currentPage);
				} else if(qnapop.action == "U") {
					fn_searchlist(divComGrpCodList.currentPage);
				} else {
					fn_searchlist(divComGrpCodList.currentPage);
				}
			}
		}   
 
		callAjax("/qanda/qnasave.do", "post", "json", true, param, savecallback);
	}
   
		
	//수정하기 
	function fn_updateSelectqna(brd_no) {
		
		var param={
			brd_no: brd_no,
			userType: divComGrpCodList.userType
		}
		
		var selectcallback = function(returndata) {
			//console.log(JSON.stringify(returndata));
		 
			fn_popupint(returndata.sectinfo);
			
			qnapop.btnSaveShow = true;
			qnapop.btnDeleteShow = true;
			
			qnapop.repReadonly = false;

			gfModalPop("#qnapop");
		}
		
		callAjax("/qanda/qnaselect.do", "post", "json", true, param, selectcallback);
	}
   
</script>
<body>
	<form id="myForm" action="" method="">

		<div id="wrap_area">
			<h2 class="hidden">header 영역</h2>
			<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>
			
			<h2 class="hidden">컨텐츠 영역</h2>
			<div id="container">
				<ul>
					<li class="lnb">
					   <!-- lnb 영역 --> 
					   <jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> 
					</li>
					<li class="contents">
						<!-- contents -->
						<h3 class="hidden">contents 영역</h3> <!-- content -->
						<div class="content">
							<p class="Location">
								<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a>
								<span class="btn_nav bold">기준정보</span> 
								<span class="btn_nav bold"> Q&A관리</span> 
								<a href="/qanda/a_qanda.dovue" class="btn_set refresh">새로고침</a>
							</p>
		
							<p id="searchArea" class="conTitle">
								<span>Q&A</span> 
								<span class="fr">
									<select id="searchsel" name="searchsel" @change="searchselChange">
										<option value="">전체</option>
										<option value="title">제목</option>
										<option value="content">내용</option>
										<option value="regname">등록자</option>
									</select>
									<input type="text" id="searchtext" name="searchtext" v-model="searchtext" style="width: 150px; height: 25px;" />
									<a class="btnType blue" @click="fn_searchlist" name="modal"><span>검색</span></a>
									<a class="btnType blue" @click="fn_openpopup" name="modal" id="newRegistrationButton" v-show="regBtn"><span >신규등록</span></a>
								</span>
							</p>
		
							<div id="divComGrpCodList" class="divComGrpCodList">
								<table class="col">
									<caption>caption</caption>
									<colgroup>
										<col width="10%">
										<col width="20%">
										<col width="20%">
										<col width="10%">
										<col width="10%">
										<col width="5%">
										<template v-if="userType == 'B'">
											<col width="5%">
										</template>
									</colgroup>
								
									<thead>
										<tr>
											<th scope="col">번호</th>
											<th scope="col">제목</th>
											<th scope="col">내용</th>
											<th scope="col">작성자</th>
											<th scope="col">조회수</th>
											<th scope="col">답변여부</th>
											<template v-if="userType == 'B'">
												<th scope="col">수정</th>
											</template>    
										</tr>
									</thead>
									<tbody>
										<template v-if="totalcnt == 0">
											<tr>
												<td colspan="7">데이터가 존재하지 않습니다.</td>
											</tr>
										</template>
										<template v-else v-for="list in listqna">
											<tr>
												<td>{{ list.brd_no }}</td>
												<td>
													<a @click="fn_titleSelectqna(list.brd_no)">{{ list.brd_title }}</a>
												</td>
												<td>{{ list.brd_ctt }}</td>
												<td>{{ list.name }}</td>
												<td>{{ list.brd_veiws_cnt }}</td>
												<td>
													<template v-if="list.ans_yn == 'Y'">답변</template>
													<template v-else>미답변</template>
												</td>
												<template v-if="userType == 'B'">
													<td>
														<a class="btnType3 color1" @click="fn_updateSelectqna(list.brd_no)"><span>수정</span></a>
													</td>
												</template>
											</tr>
										</template>
									</tbody>
								</table>
								<div class="paging_area" id="qnaPagination" v-html="qnaPagination"></div>
							</div>
						</div> 
						<!--// content -->
	
						<h3 class="hidden">풋터 영역</h3> 
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
					</li>
				</ul>
			</div>
		</div>

		<!--// 모달팝업 -->
		<div id="qnapop" class="layerPop layerType2" style="width: 600px;">
			<dl>
			<dt>
				<strong>QNA 등록</strong>
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
							<tr id ="Hide">
								<th scope="row">등록 일자</th>
								<td v-text="regdate"></td>
								<th scope="row">조회수</th>
								<td v-text="qna_view"></td>
							</tr>
							<tr>
								<th scope="row">QNA 제목 <span class="font_red">*</span></th>
								<td colspan="3">
									<input type="text" class="inputTxt p100" name="qna_title" id="qna_title" v-model="qna_title" :readonly="qnaReadonly"/>
								</td>
							</tr>
							<tr>
								<th scope="row">QNA 내용 <span class="font_red">*</span></th>
								<td colspan="3">
									<textarea name="notice_content" id="qna_content" v-model="qna_content" rows="5" cols="30" :readonly="qnaReadonly"></textarea>
								</td>
							</tr>
							<tr id="commentHide">
								<th>답변</th>
								<td colspan="3">
									<template v-if="divComGrpCodList.userType == 'B'">
										<textarea name="qnacomment" class="inputTxt p100"  id="qnacomment" v-model="qnacomment" :readonly="repReadonly"></textarea>
									</template>
									<template v-else>
										<span v-text="commentDate"></span>
											<br />
										<span v-text="qnacomment"></span>
									</template>
								</td>
							</tr>
						</tbody>
					</table>
				
					<!-- e : 여기에 내용입력 -->
					<div class="btn_areaC mt30">
						<a class="btnType blue" id="btnSave" name="btn" @click="btnSave" v-show="btnSaveShow"><span>저장</span></a>
						<a class="btnType blue" id="btnDelete" name="btn" @click="btnDelete" v-show="btnDeleteShow"><span>삭제</span></a>
						<a class="btnType gray" id="btnClose" name="btn" @click="btnClose"><span>취소</span></a>
					</div>
				</dd>
			</dl>
			<a class="closePop" @click="btnClose"><span class="hidden">닫기</span></a>
		</div>

	</form>
</body>
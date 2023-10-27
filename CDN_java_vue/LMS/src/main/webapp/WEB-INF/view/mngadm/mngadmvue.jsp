<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Job Korea :: 강의 관리</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script src="https://unpkg.com/axios@0.12.0/dist/axios.min.js"></script>
<script src="https://unpkg.com/lodash@4.13.1/lodash.min.js"></script>
<!-- a태그 커서 모양 -->
<style>
	a {cursor:pointer;}
</style>

<!-- sweet swal import -->

<script type="text/javascript">
	
	// 강의 목록 페이징 설정
	var pageSize = 5;
	var pageBlockSize = 5;
	
	var showArea;		// 강의 진행 여부
	var searchArea;		// 검색
	var divLecList;		// 강의 목록
	var lecpop;			// 강의 선택 팝업창
	var divStdList;		// 학생 목록
	var lecClosePop;	// 강의종료
	
	$(function() {
		
		// 뷰js등록
		vueinit();
		
		// 공지사항 조회
		fn_searchList();
		
	});	
	
	
	// 뷰 등록 시작 ---------------------------------------------
	function vueinit(){
		
		// 진행중 강의, 종료된 강의
		showArea = new Vue({
			
			el : "#show",
			data : {
				show : "N"
			},
			methods : {
				fnShow : function(event){
					
					eventTargetID = event.currentTarget.id;

					if(eventTargetID == 'ingLec') this.show = 'N';
					else this.show = 'Y';
					
					fn_searchList();
					
				},
				
			} 
			
		});
		
		// 검색 영역
		searchArea = new Vue({
			el : "#searchArea",
			data : {
				searchSel : "",
				searchText : ""
			},
			methods : {
				fn_searchList : function(){
					fn_searchList();
					this.searchText = "";
				},
				
				fn_lecRegister : function(){
					fn_lecRegister();
				},
				
				fn_lecCloseBtn : function(){
					gfModalPop("#lecClosePop");
					console.log(lecClosePop.lecList);
					//fn_lecCloseBtn();
				}
			}
		});
		
		// 강의 목록
		divLecList = new Vue({
			el : "#divLecList",
			data : {
				lecList : [],
				totalcnt : 0,
				lecListPagnation : "",
				currentPage : 0,
				action : ""
			},
			methods : {
				fn_selectLec : function(lec_cd){
					fn_selectLec(lec_cd);
				}
			}
		});
		
		// 강의 선택 팝업창
		lecpop = new Vue({
			el : "#lecpop",
			data :{
				lec_cd : 0,
				lec_nm : "",
				lec_ctg:"",
				lec_ctg_opt : [
				           {value:"실업자", text:"실업자"},
				           {value:"재직자", text:"재직자"}
				          ],
				capacity : 0,
				loginID : "",
				loginID_opt : [],
				cls_room:"",
				cls_room_opt:[],
				lec_days : 0,
				lec_start_date : "",
				lec_end_date : "",
				before_cls_room : "",
				btnDeleteShow : false
			},
			// 버튼 이벤트
			methods :{
				
				btnSave : function(){
					fn_Save();
				},
				
				btnDelete : function(){
					fn_Delete();
				},
				
				btnClose : function(){
					gfCloseModal();

					fn_searchList(divLecList.currentPage);
				}
			}
		});
		
		// 학생 목록
		divStdList = new Vue({ 
			el : "#divStdList",
			data : {
				stdTotalcnt : 0,
				stdList : [],
				stdListPagnation : "",
				stdCurrentPage : 0
			},
		});
		
		// 강의종료
		lecClosePop = new Vue({
			el : "#lecClosePop",
			data :{
				lecList : [],
				lecListHtml : ""
			},
			methods : {
				// 개별 종료
				closeOne : function closeOne(lec_cd, cls_room){
					console.log("!23123");
					fn_closeLec(lec_cd, cls_room);
				},
				
				// 기간 종료
				closeBtn : function fn_closeBtn(){
					fn_closeLec(-1, "-1");
				},
				
				// 닫기 버튼
				btnClose : function(){
					gfCloseModal();

					fn_searchList(divLecList.currentPage);
				}
			}
		});
		
	}
	// 뷰 등록 끝 -----------------------------------------------

	// 목록 불러오기
	function fn_searchList(currentPage) {
		
		var currentPage = currentPage || 1;
		
		var param = {
				pageSize : pageSize,
				currentPage : currentPage,
				show : showArea.show,
				searchSel : searchArea.searchSel,
				searchText : searchArea.searchText
		}
		
	   var listcallback = function(returndata) {
			
			divLecList.lecList = returndata.lecList;
			divLecList.totalcnt = returndata.totalcnt;
			
			var paginationHtml = getPaginationHtml(currentPage, divLecList.totalcnt, pageSize, pageBlockSize, 'fn_searchList');
    		
			divLecList.lecListPagnation = paginationHtml;
    		
			divLecList.currentPage = currentPage;
			
			if(showArea.show == "N"){
				lecClosePop.lecList = divLecList.lecList;
			}
			
		}
		
		callAjax("/adm/lecListVue.do", "post", "json", true, param, listcallback);
		
	}
	
	// 강의 등록 버튼
	function fn_lecRegister(){
		
		// 팝업창 세팅
		initPop();
		
		// 달력 오늘 이전 날짜 클릭 제한
		minDate();
		
		// action 값 세팅
		divLecList.action = "I";
		
		// 강사 목록
		fn_insList();
		
		// 사용 가능한 강의실 목록 
		fn_clsRoomList();
		
		// 팝업창 열기
		gfModalPop("#lecpop");
	}
	
	
	// 강의 종료 버튼
	function fn_lecCloseBtn(){
		// 팝업창 열기
		//gfModalPop("#lecClosePop");
		
	}
	
	
	// 강의 종료 시키기
	function fn_closeLec(lec_cd, cls_room){
		
		var param = {
			lec_cd : lec_cd,
			cls_room : cls_room
		}
		var listcallback = function(data){
			
			swal(data.msg);
			
			gfCloseModal();
			
			fn_searchList();
			
		}
		
		callAjax("/adm/closeLec.do", "post", "json", true, param, listcallback);
		
	}
	
	// 강의실 목록 조회
	function fn_clsRoomList(){
		
		var param = null;
		var listcallback = function(data){
		
			var temp = data;
			for(var i = 0; i < temp.length; i++){
				lecpop.cls_room_opt.push(temp[i]);
			}
		}
		
		callAjax("/adm/clsRoomList.do", "post", "json", true, param, listcallback);

	}
	
	// 강사 목록 조회
	function fn_insList(){
		
		var param = null;
		var listcallback = function(data){
			
			var temp = data;
			for(var i = 0; i < data.length; i++){
				lecpop.loginID_opt.push(temp[i]);
			}
		}
		
		callAjax("/adm/insList.do", "post", "json", true, param, listcallback);
		
	}
	
	
	// 팝업창 열기 전 셋팅
	function initPop(data){
		
		if(data == null || data == "" || data == undefined){
			divLecList.action = "I";
			lecpop.lec_nm = "";
			lecpop.capacity = "";
			
			lecpop.loginID_opt = [];
			lecpop.loginID = "";
			
			lecpop.cls_room_opt = [];
			lecpop.cls_room = "";
			
			lecpop.lec_days = "";
			lecpop.lec_start_date = "";
			lecpop.lec_end_date = "";
			lecpop.lec_ctg = "";
			lecpop.lec_cd = "";
			lecpop.before_cls_room = "";
			lecpop.btnDeleteShow = false;
			
		} else{
		
			divLecList.action = "U";
			lecpop.lec_nm = data.lecModel.lec_nm;
			lecpop.lec_ctg = data.lecModel.lec_ctg;
			lecpop.capacity = data.lecModel.capacity;
			
			lecpop.loginID_opt = [];
			var temp1 = {loginID:data.lecModel.loginID, name:data.lecModel.name};
			lecpop.loginID_opt.push(temp1);
			lecpop.loginID = data.lecModel.loginID;
			
			lecpop.cls_room_opt = [];
			var temp2 = {cls_room_nm:data.lecModel.cls_room , cls_room_seat:data.lecModel.cls_room_seat};
			lecpop.cls_room_opt.push(temp2);
			lecpop.cls_room = data.lecModel.cls_room;

			lecpop.lec_days = data.lecModel.lec_days;
			lecpop.lec_start_date = data.lecModel.lec_start_date;
			lecpop.lec_end_date = data.lecModel.lec_end_date;		
			lecpop.lec_cd = data.lecModel.lec_cd;
			lecpop.before_cls_room = data.lecModel.cls_room;
			lecpop.btnDeleteShow = true;
		}
	}
	
	// 과목 하나 클릭
	function fn_selectLec(lec_cd){
	
		var param = {
			lec_cd : lec_cd
		}
		
		var listcallback = function(data){

			// 미사용 강의실 세팅
			fn_clsRoomList();
			
			// 강사 목록
			fn_insList();

			// 초기 세팅
			initPop(data);
			
			// 학생 리스트 조회
			var stdCurrentPage = null;
			fn_stdList(stdCurrentPage, lec_cd);
			
			gfModalPop("#lecpop");
		}
		
		callAjax("/adm/selectLec.do", "post", "json", true, param, listcallback);
		
	}
	
	// 저장
	function fn_Save(){
		
    	if(!fValidate()) {
    		return;
    	}
    	
		var param = {
				action : divLecList.action,
				lec_nm : lecpop.lec_nm,
				lec_ctg : lecpop.lec_ctg,
				capacity : lecpop.capacity,
				loginID : lecpop.loginID,
				cls_room : lecpop.cls_room,
				lec_days : lecpop.lec_days,
				lec_start_date : lecpop.lec_start_date,
				lec_end_date : lecpop.lec_end_date,
				lec_cd : lecpop.lec_cd,
				before_cls_room : lecpop.before_cls_room
		}
		
		var listcallback = function(returnData){

			swal(returnData.msg);
   			gfCloseModal();
			
			if(divLecList.action == "I"){
				fn_searchList();
			} else if(divLecList.action == "U"){
				fn_searchList(divLecList.currentPage);
			} else if(divLecList.action == "D"){
				fn_searchList(divLecList.currentPage);
			}
		}
		
		callAjax("/adm/saveLec.do", "post", "json", true, param, listcallback);
	}
	
	// 강의 삭제
	function fn_Delete(){
		
		console.log("123123");
		
		if(confirm("정말로 삭제하시겠습니까??")){
			divLecList.action = "D";

			fn_Save();
		}
		
		
	}
	
	// 유효성 확인
	function fValidate() {

		var chk = checkNotEmpty(
				[
						[ "lec_nm", "강의명을 입력해 주세요." ]
					,	[ "lec_ctg", "대상자를 지정해 주세요"]
					,	[ "capacity", "정원을 입력해 주세요" ]
					,	[ "lec_days", "과정 일수를 입력해 주세요" ]				
					,	[ "lec_start_date", "시작일을 입력해 주세요" ]				
					,	[ "lec_end_date", "종료일을 입력해 주세요" ]				
				]
		);
		// false가 되어야 함
		
		
		if(lecpop.cls_room == ""){
			swal("강의실을 선택해 주세요");
			chk = false;
		}

		if(lecpop.loginID == ""){
			swal("강사를 선택해 주세요");
			chk = false;
		}

		if (!chk) {
			return;
		}

		return true;
	}
	
	//------------- 학생 목록 영역 --------------------------
	
	// 학생 목록 페이징 설정
	var stdPageSize = 5;
	var stdPageBlockSize = 5;
	
	// 학생 목록 조회
	function fn_stdList(stdCurrentPage, lec_cd){
		
		var lec_cd = [lec_cd];
		
		var stdCurrentPage = stdCurrentPage || 1;
		
		var param = {
			stdPageSize : stdPageSize,
			stdCurrentPage : divStdList.stdCurrentPage,
			lec_cd : lec_cd[0]
		}
		
		var listcallback = function(data) {
			
			divStdList.stdList = data.stdList;
			
			divStdList.stdTotalcnt = data.stdTotalcnt;
			
			var paginationHtml = getPaginationHtml(stdCurrentPage, divStdList.stdTotalcnt, stdPageSize, stdPageBlockSize, 'fn_stdList', lec_cd);
			//console.log("paginationHtml : " + paginationHtml);
			
			divStdList.stdListPagnation = paginationHtml;
			
			// 현재 페이지 설정
			divStdList.stdCurrentPage = stdCurrentPage;
		}
		
		callAjax("/adm/stdListVue.do", "post", "json", true, param, listcallback);
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
							<span class="btn_nav bold">학습관리</span> 
							<span class="btn_nav bold">수강 목록 관리</span>
							<a href="../adm/registerListControlvue.do" class="btn_set refresh">새로고침</a>
						</p>
						
						<div id="show" class="btn_areaA mt50">
							<a class="btnType blue" id="ingLec" name="showBtn" @click="fnShow"><span>진행중 강의</span></a> 
							<a class="btnType gray" id="endLec" name="showBtn" @click="fnShow"><span>종료된 강의</span></a>
						</div>

						<p id="searchArea" class="conTitle">
							<span>강의 목록</span> 
							<span class="fr"> 
								<select id="searchSel" name="searchSel" v-model="searchSel">
							         <option value="">전체</option>
							         <option value="lectureName">강의명</option>
							         <option value="instName">담당교수</option>
							    </select>
							    <input type="text" id="searchText" name="searchText" v-model="searchText" style="width: 200px; height: 25px;" />
							    <a class="btnType blue" @click="fn_searchList" name="modal"><span>검색</span></a>
								<a class="btnType blue" @click="fn_lecRegister" name="modal"><span>강의 등록</span></a>
								<a class="btnType gray" @click="fn_lecCloseBtn" name="modal"><span>강의 종료</span></a>
							</span>
						</p>
						
						<div id= "divLecList" class="divLecList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="5%">
									<col width="20%">
									<col width="10%">
									<col width="15%">
									<col width="5%">
									<col width="5%">
									<col width="25%">
									<col width="15%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">강의번호</th>
										<th scope="col">강의명(분류)</th>
										<th scope="col">담당교수</th>
										<th scope="col">강의실</th>
										<th scope="col">정원</th>
										<th scope="col">수강인원</th>
										<th scope="col">기간</th>
										<th scope="col">수정/삭제</th>
									</tr>
								</thead>
								<tbody>
									<template v-if="totalcnt == 0">
										<tr>
											<td colspan="8">데이터가 존재하지 않습니다.</td>
										</tr>
									</template>
									<template v-else v-for="list in lecList">
										<tr>
											<td>{{ list.lec_cd }}</td>
											<td><a @click="fn_selectLec(list.lec_cd)">{{ list.lec_nm }}({{ list.lec_ctg }})</a></td>
											<td>{{ list.name }}</td>
											<td>{{ list.cls_room }}</td>
											<td>{{ list.capacity }}</td>
											<td>{{ list.app_cnt }}</td>
											<td>{{ list.lec_start_date }} <span> ~ </span> {{ list.lec_end_date }}</td>
											<td>
												<a @click="fn_selectLec(list.lec_cd)" class="btnType blue" name="btn"><span>수정/삭제</span></a>
											</td>
										</tr>
									</template>
								</tbody>
							</table>
							<div class="paging_area"  id="lecListPagnation" v-html="lecListPagnation"> </div>
						</div>
	
						<br/>
						<br/>
					<p class="conTitle">
						<span>학생 정보</span> 
					</p>

					<div id="divStdList" class="divStdList">
						<table class="col">
							<caption>caption</caption>
							<colgroup>
								<col width="25%">
								<col width="25%">
								<col width="25%">
								<col width="25%">
							</colgroup>
					
							<thead>
								<tr>
									<th scope="col">학생명</th>
									<th scope="col">강의명</th>
									<th scope="col">연락처</th>
									<th scope="col">이메일</th>
								</tr>
							</thead>
							<tbody>
								<template v-if="stdTotalcnt == 0">
									<tr>
										<td colspan="4">데이터가 존재하지 않습니다.</td>
									</tr>								
								</template>
								<template v-else v-for="list in stdList">
									<tr>
										<td>{{ list.name }}</td>
										<td>{{ list.lec_nm }}</td>
										<td>{{ list.hp }}</td>
										<td>{{ list.email }}</td>
									</tr>
								</template>
							</tbody>
						</table>
						
						<div class="paging_area" id="stdListPagnation" v-html="stdListPagnation"></div>
					</div>
					

					<h3 class="hidden">풋터 영역</h3>
					<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>
	
	<!-- 모달팝업 -->
	<div id="lecpop" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong>강의 등록</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>
					<colgroup>
						<col width="200px">
						<col width="500px">
					</colgroup>

					<tbody>
						<tr>
							<th scope="row">강의명 <span class="font_red">*</span> </th>
							<td>
								<input type="text" class="inputTxt p100" name="lec_nm" id="lec_nm" v-model="lec_nm" autocomplete="off"/>
							</td>
						</tr>
						<tr>
							<th scope="row">대상자 <span class="font_red">*</span> </th>
							<td>
								<select style=width:100%; id="lec_ctg" name="lec_ctg" v-model="lec_ctg">
									<template v-for="one in lec_ctg_opt">
										<option :value="one.value">{{one.text}}</option>
									</template>
								</select>  
							</td>
						</tr>
						<tr>
							<th scope="row">정원(최대 인원) <span class="font_red">*</span></th>
							<td>
					      		<input type="text" class="inputTxt p100" name="capacity" id="capacity" v-model="capacity" placeholder="숫자만 입력하세요." autocomplete="off"/>
							</td>
						</tr>
						<tr>
							<th scope="row">강사명 <span class="font_red">*</span></th>
							<td>
								<select style=width:100% id="loginID" name="loginID" v-model="loginID">
									<template v-for="key in loginID_opt">
										<option :value="key.loginID">{{key.name}}</option>
									</template>
								</select> 
						    </td>
						</tr>
						<tr>
							<th scope="row">강의실 <span class="font_red">*</span></th>
							<td>
								<select style=width:100% id="cls_room" name="cls_room" v-model="cls_room">
									<template v-for="key in cls_room_opt">
										<option :value=key.cls_room_nm>{{ key.cls_room_nm }}({{key.cls_room_seat}})</option>
									</template>
								</select>  
						    </td>
						</tr>
						<tr>
							<th>과정 일수 <span class="font_red">*</span></th>
							<td>
								<input type="text" class="inputTxt p100" name="lec_days" id="lec_days" v-model="lec_days" placeholder="숫자만 입력하세요." autocomplete="off"/>
							</td>
						</tr>
						<tr>
							<th>시작일자 <span class="font_red">*</span></th>
							<td>
								<input type="date" class="inputTxt p100" name="lec_start_date" id="lec_start_date" v-model="lec_start_date" style="font-size: 15px;" />
							</td>
						</tr>
						<tr>
							<th>종료일자 <span class="font_red">*</span></th>
							<td>
								<input type="date" class="inputTxt p100" name="lec_end_date" id="lec_end_date" v-model="lec_end_date" style="font-size: 15px;"/>
							</td>
						</tr>
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a class="btnType blue" id="btnSave" name="btn" @click="btnSave"><span>저장</span></a> 
					<a class="btnType blue" id="btnDelete" name="btn" @click="btnDelete" v-show="btnDeleteShow"><span>삭제</span></a> 
					<a class="btnType gray" id="btnClose" @click="btnClose"  name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a id="closePop" name="btn" class="closePop" @click="btnClose"><span class="hidden">닫기</span></a>
	</div>
	
	
	<!-- 모달팝업 -->
	<!-- 강의종료 -->
	<div id="lecClosePop" class="layerPop layerType2" style="width: 800px;">
		<dl>
			<dt>
				<strong>강의 종료</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="col">
					<caption>caption</caption>
					<colgroup>
						<col width="100px">
						<col width="300px">
						<col width="100px">
						<col width="200px">
						<col width="100px">
					</colgroup>
					
					<thead>
						<th scope="col">강의번호</th>
						<th scope="col">강의명</th>
						<th scope="col">강사</th>
						<th scope="col">기간</th>
						<th scope="col">종료</th>
					</thead>

					<tbody>
						<template v-for="key in lecList">
							<tr>
								<td>{{ key.lec_cd }}</td>
								<td>{{ key.lec_nm }}</td>
								<td>{{ key.name }}</td>
								<td>{{ key.lec_start_date }} ~ {{ key.lec_end_date }}</td>
								<td><a class="btnType gray" name="btn" @click="closeOne(key.lec_cd, key.cls_room)"><span>종료</span></a></td>
							</tr>
						</template>
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a class="btnType blue" id="endLecClose" name="closeBtn" @click="closeBtn" title="기간이 종료된 강의 모두 종료시키기"><span>기간 종료</span></a>
					<a class="btnType gray" id="btnClose" name="btn" @click="btnClose"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a class="closePop"  @click="btnClose"><span class="hidden">닫기</span></a>
	</div>

</form>

<script src="${CTX_PATH}/js/view/mngadm/mngadm.js"></script>
</body>
</html>
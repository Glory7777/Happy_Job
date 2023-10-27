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

<!-- sweet swal import -->

<script type="text/javascript">
	
	//페이징 설정
	var pageSize = 5;
	var pageBlockSize = 5;
	
	$(function() {
		
		// 공지사항 조회
		fn_searchList();
		
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
	});	
	
	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();
	
			var btnId = $(this).attr('id');
	
			switch (btnId) {
				case 'btnSave' :
					fn_Save();
					break;
				case 'btnDelete' :
					fn_Delete();
					break;
				case 'btnClose' :
					gfCloseModal();

					fn_searchList($("#currentPageLec").val());

					break;
			}
		});
		
		// show 버튼 등록
		$('a[name=showBtn]').click(function(e) {
			e.preventDefault();
	
			var showBtnId = $(this).attr('id');
	
			switch (showBtnId) {
				case 'ingLec' :
					$("#show").val("N");
					fn_searchList();
					break;
				case 'endLec' :
					$("#show").val("Y");
					fn_searchList();
					break;
			}
		});
		
		// 기간 지난 강의 종료 버튼
		$('a[name=closeBtn]').click(function(e) {
			e.preventDefault();
			
			var lec_cd = -1;
			var cls_room = '-1';
			
			fn_closeLec(lec_cd, cls_room);
	
			var showBtnId = $(this).attr('id');
		});
		
	}

	// 목록 불러오기
	function fn_searchList(currentPage) {
		
		// 학생 목록 초기화
		$("#stdList").empty();
		
		var currentPage = currentPage || 1;
		
		var param = {
				pageSize : pageSize,
				currentPage : currentPage,
				show : $("#show").val(),
				searchSel : $("#searchSel").val(),
				searchText : $("#searchText").val(),
		}
		
	   var listcallback = function(returndata) {
			
			$("#lecList").empty().append(returndata);
			
			var totalcnt = $("#totalcnt").val();
			
			var paginationHtml = getPaginationHtml(currentPage, totalcnt, pageSize, pageBlockSize, 'fn_searchList');
			console.log("paginationHtml : " + paginationHtml);
			//swal(paginationHtml);
			$("#lecListPagnation").empty().append( paginationHtml );
			
			// 현재 페이지 설정
			$("#currentPageLec").val(currentPage);
			
			// 검색창 비워주기
			$("#searchText").val("");
			
		}
		
		callAjax("/adm/lecList.do", "post", "text", true, param, listcallback);
		
	}
	
	// 강의 등록 버튼
	function fn_lecRegister(){
		
		// 팝업창 세팅
		initPop();
		
		// 달력 오늘 이전 날짜 클릭 제한
		minDate();
		
		// 강사 목록
		$("#loginID").empty();
		
		$opt = $('<option>강사를 선택해주세요</option>');
		
		$opt.attr("value", "dont");
		
		$("#loginID").append($opt);
		
		fn_insList();
		
		// 사용 가능한 강의실 목록 
		$("#cls_room").empty();
		
		$opt = $('<option>강의실을 선택해주세요</option>');
		
		$opt.attr("value", "dont");
		
		$("#cls_room").append($opt);
		
		fn_clsRoomList();
		
		
		// 팝업창 열기
		gfModalPop("#lecpop");
	}
	
	
	// 강의 종료 버튼
	function fn_lecCloseBtn(){
		
		console.log(lecListForClose);
		
		$("#lecListFolClose").empty();
		
		for(var i = 0; i < lecListForClose.length; i++){
			var $tr = $('<tr></tr>');
			var $td1 = $('<td>' + lecListForClose[i].lec_cd + '</td>');
			var $td2 = $('<td>' + lecListForClose[i].lec_nm + '</td>');
			var $td3 = $('<td>' + lecListForClose[i].name + '</td>');
			var $td4 = $('<td>' + lecListForClose[i].lec_start_date + ' ~ ' + lecListForClose[i].lec_end_date + '</td>');
			
			var $a = '<a href="javascript:fn_closeLec(' + lecListForClose[i].lec_cd +  ',' + "'" + lecListForClose[i].cls_room + "'" + ')"' + 'class="btnType blue" id="closeLec" name="closeLec"><span>종료</span></a>';
			var $td5 = $('<td></td>');
			$td5.append($a);
			
			$td1.appendTo($tr);
			$td2.appendTo($tr);
			$td3.appendTo($tr);
			$td4.appendTo($tr);
			$td5.appendTo($tr);
			
			$tr.appendTo($("#lecListFolClose"));
		}
		
		// 팝업창 열기
		gfModalPop("#lecClosePop");
		
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
			
			for(var i = 0; i < data.length; i++){
				$opt = $('<option>' + data[i].cls_room_nm + "(정원 : " + data[i].cls_room_seat + ")" + '</option>');
				
				$opt.attr("value", data[i].cls_room_nm);
				
				$("#cls_room").append($opt);
			}
			
		}
		
		callAjax("/adm/clsRoomList.do", "post", "json", true, param, listcallback);

	}
	
	// 강사 목록 조회
	function fn_insList(){
		
		var param = null;
		
		var listcallback = function(data){
			
			for(var i = 0; i < data.length; i++){
				$opt = $('<option>' + data[i].name + '</option>');
				
				$opt.attr("value", data[i].loginID);
				
				$("#loginID").append($opt);
			}
				
		}
		
		callAjax("/adm/insList.do", "post", "json", true, param, listcallback);
		
	}
	
	
	// 팝업창 열기 전 셋팅
	function initPop(data){
		
		if(data == null || data == "" || data == undefined){
			$("#action").val("I");
			$("#lec_nm").val("");
			$("#capacity").val("");
			$("#loginID").val("");
			$("#cls_room").val("");
			$("#lec_days").val("");
			$("#lec_start_date").val("");
			$("#lec_end_date").val("");
			
			$("#btnDelete").hide();
		} else{
			$("#action").val("U");
			$("#lec_nm").val(data.lecModel.lec_nm);
			$("#lec_ctg").val(data.lecModel.lec_ctg);
			$("#capacity").val(data.lecModel.capacity);
			$("#lec_days").val(data.lecModel.lec_days);
			$("#lec_start_date").val(data.lecModel.lec_start_date);
			$("#lec_end_date").val(data.lecModel.lec_end_date);
			
			$("#lec_cd").val(data.lecModel.lec_cd);
			$("#before_cls_room").val(data.lecModel.cls_room);
			
			$("#btnDelete").show();
		}
	}
	
	// 과목 하나 클릭
	function fn_selectLec(lec_cd){
	
		var param = {
			lec_cd : lec_cd
		}
		
		var listcallback = function(data){
			// 초기 세팅
			initPop(data);
			
			// 강사목록
			$("#loginID").empty();
		
			$opt = $('<option>' + data.lecModel.name + '</option>');
			
			$opt.attr("value", data.lecModel.loginID);
		
			$("#loginID").append($opt);
			
			fn_insList();

			// 강의실
			$("#cls_room").empty();
		
			$opt = $('<option>' + data.lecModel.cls_room + '</option>');
		
			$opt.attr("value", data.lecModel.cls_room);
			
			$("#cls_room").append($opt);
		
			fn_clsRoomList();
			
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
				action : $("#action").val(),
				lec_nm : $("#lec_nm").val(),
				lec_ctg : $("#lec_ctg").val(),
				capacity : $("#capacity").val(),
				loginID : $("#loginID").val(),
				cls_room : $("#cls_room").val(),
				lec_days : $("#lec_days").val(),
				lec_start_date : $("#lec_start_date").val(),
				lec_end_date : $("#lec_end_date").val(),
				lec_cd : $("#lec_cd").val(),
				before_cls_room : $("#before_cls_room").val()
		}
		
		var listcallback = function(returnData){

			swal(returnData.msg);
   			gfCloseModal();
			
			if($("#action").val() == "I"){
				fn_searchList();
			} else if($("#action").val() == "U"){
				fn_searchList($("#currentPageLec").val());
			} else if($("#action").val() == "D"){
				fn_searchList($("#currentPageLec").val());
			}
		}
		
		callAjax("/adm/saveLec.do", "post", "json", true, param, listcallback);
	}
	
	// 강의 삭제
	function fn_Delete(){
		
		
		if(confirm("정말로 삭제하시겠습니까??")){
			$("#action").val("D");
			
			fn_Save();
		}
		
		
	}
	
	// 유효성 확인
	function fValidate() {

		var chk = checkNotEmpty(
				[
						[ "lec_nm", "강의명을 입력해 주세요." ]
					,	[ "capacity", "정원을 입력해 주세요" ]				
					,	[ "lec_days", "과정 일수를 입력해 주세요" ]				
					,	[ "lec_start_date", "시작일을 입력해 주세요" ]				
					,	[ "lec_end_date", "종료일을 입력해 주세요" ]				
				]
		);
		// false가 되어야 함
		
		if($("#loginID").val() == "dont"){
			swal("강사를 선택해 주세요");
			chk = false;
		}
		
		if($("#cls_room").val() == "dont"){
			swal("강의실을 선택해 주세요");
			chk = false;
		}

		if (!chk) {
			return;
		}

		return true;
	}
	
	//------------- 학생 목록 영역 --------------------------
	
	//페이징 설정
	var stdPageSize = 5;
	var stdPageBlockSize = 5;
	
	// 학생 목록 조회
	function fn_stdList(stdCurrentPage, lec_cd){
		
		var lec_cd = [lec_cd];
		
		var stdCurrentPage = stdCurrentPage || 1;
		
		var param = {
			stdPageSize : stdPageSize,
			stdCurrentPage : stdCurrentPage,
			lec_cd : lec_cd[0]
		}
		
		var listcallback = function(returndata) {
			
			console.log(returndata);
			
			$("#stdList").empty().append(returndata);
			
			var stdTotalcnt = $("#stdTotalcnt").val();
			
			console.log("lec_cd11 ::::" + lec_cd);
			
			var paginationHtml = getPaginationHtml(stdCurrentPage, stdTotalcnt, stdPageSize, stdPageBlockSize, 'fn_stdList', lec_cd);
			console.log("paginationHtml : " + paginationHtml);
			//swal(paginationHtml);
			$("#stdListPagnation").empty().append( paginationHtml );
			
			// 현재 페이지 설정
			$("#currentPageStd").val(stdCurrentPage);
			
		}
		
		callAjax("/adm/stdList.do", "post", "text", true, param, listcallback);
	}
	
	
</script>

</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" id="currentPageLec">
	<input type="hidden" id="currentPageStd">
	<input type="hidden" name="action" id="action" value="">
	<input type="hidden" name="lec_cd" id="lec_cd" value="">
	<input type="hidden" name="before_cls_room" id="before_cls_room" value="">
	<input type="hidden" name="show" id="show" value="N">
	
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
							<a href="../adm/registerListControl.do" class="btn_set refresh">새로고침</a>
						</p>
						
						<div class="btn_areaA mt10">
							<a href="" class="btnType blue" id="ingLec" name="showBtn"><span>진행중 강의</span></a> 
							<a href="" class="btnType gray" id="endLec" name="showBtn"><span>종료된 강의</span></a>
						</div>

						<p class="conTitle">
							<span>강의 목록</span> 
							<span class="fr"> 
								<select id="searchSel" name="searchSel">
							         <option value="">전체</option>
							         <option value="lectureName">강의명</option>
							         <option value="instName">담당교수</option>
							    </select>
							    <input type="text" id="searchText" name="searchText"  style="width: 200px; height: 25px;" />
							    <a class="btnType blue" href="javascript:fn_searchList();" name="modal"><span>검색</span></a>
								<a class="btnType blue" href="javascript:fn_lecRegister();" name="modal"><span>강의 등록</span></a>
								<a class="btnType gray" href="javascript:fn_lecCloseBtn();" name="modal"><span>강의 종료</span></a>
							</span>
						</p>
						
						<div class="divLecList">
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
								<tbody id="lecList"></tbody>
							</table>
						</div>
	
						<div class="paging_area"  id="lecListPagnation"> </div>
						<br/>
						<br/>
					<p class="conTitle">
						<span>학생 정보</span> 
					</p>

					<div class="divStdList">
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
							<tbody id="stdList"></tbody>
						</table>
					</div>
					
					<div class="paging_area"  id="stdListPagnation"> </div>

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
								<input type="text" class="inputTxt p100" name="lec_nm" id="lec_nm" autocomplete="off"/>
							</td>
						</tr>
						<tr>
							<th scope="row">대상자 <span class="font_red">*</span> </th>
							<td>
								<select style=width:100%; id="lec_ctg" name="lec_ctg">
									<option value="재직자">재직자</option>
									<option value="실업자">실업자</option>
								</select>  
							</td>
						</tr>
						<tr>
							<th scope="row">정원(최대 인원) <span class="font_red">*</span></th>
							<td>
					      		<input type="text" class="inputTxt p100" name="capacity" id="capacity" placeholder="숫자만 입력하세요." autocomplete="off"/>
							</td>
						</tr>
						<tr>
							<th scope="row">강사명 <span class="font_red">*</span></th>
							<td>
								<select style=width:100% id="loginID" name="loginID">
								</select> 
						    </td>
						</tr>
						<tr>
							<th scope="row">강의실 <span class="font_red">*</span></th>
							<td>
								<select style=width:100% id="cls_room" name="cls_room">
								</select>  
						    </td>
						</tr>
						<tr>
							<th>과정 일수 <span class="font_red">*</span></th>
							<td>
								<input type="text" class="inputTxt p100" name="lec_days" id="lec_days" placeholder="숫자만 입력하세요." autocomplete="off"/>
							</td>
						</tr>
						<tr>
							<th>시작일자 <span class="font_red">*</span></th>
							<td>
								<input type="date" class="inputTxt p100" name="lec_start_date" id="lec_start_date" style="font-size: 15px;" />
							</td>
						</tr>
						<tr>
							<th>종료일자 <span class="font_red">*</span></th>
							<td>
								<input type="date" class="inputTxt p100" name="lec_end_date" id="lec_end_date" style="font-size: 15px;"/>
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

					<tbody id="lecListFolClose"></tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href=""	class="btnType blue"  id="endLecClose" name="closeBtn" title="기간이 종료된 강의 모두 종료시키기"><span>강의 종료</span></a>
					<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>

</form>

<script src="${CTX_PATH}/js/view/mngadm/mngadm.js"></script>
</body>
</html>
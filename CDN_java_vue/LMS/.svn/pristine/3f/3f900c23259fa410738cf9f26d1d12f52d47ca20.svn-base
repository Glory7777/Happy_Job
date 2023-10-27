<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Job Korea :: 강의계획서 관리</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script src="https://unpkg.com/axios@0.12.0/dist/axios.min.js"></script>
<script src="https://unpkg.com/lodash@4.13.1/lodash.min.js"></script>

<!-- sweet swal import -->

<script type="text/javascript">
	
	//페이징 설정
	var pageSize = 10;
	var pageBlockSize = 5;
	
	$(function() {
		
		// 강의 목록 조회
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
					fn_searchList();
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
				case 'setLec' : 
					$("#show").val("S");
					fn_searchList();
					break;
			}
		});
		
		// 주차 버튼 등록
		$('a[name=weekBtn]').click(function(e) {
			e.preventDefault();
	
			var weekBtnId = $(this).attr('id');
	
			switch (weekBtnId) {
				case 'weekPlus' :
					fn_weekPlus();
					break;
				case 'weekMinus' :
					fn_weekMinus();
					break;
			}
		});
	}
	
	// 강의 목록 불러오기
	function fn_searchList(currentPage) {
		
		var currentPage = currentPage || 1;
		
		var param = {
				pageSize : pageSize,
				currentPage : currentPage,
				searchText : $("#searchText").val(),
				show : $("#show").val(),
				myLec : $("#myLec").is(":checked")
		}
		
	   var listcallback = function(returndata) {
			
			$("#lecPlan").empty().append(returndata);
			
			var totalcnt = $("#totalcnt").val();
			
			var paginationHtml = getPaginationHtml(currentPage, totalcnt, pageSize, pageBlockSize, 'fn_searchList');
			console.log("paginationHtml : " + paginationHtml);
			
			$("#lecPlanPagnation").empty().append( paginationHtml );
			
			// 현재 페이지 설정
			$("#currentPage").val(currentPage);
			
			// 검색창 비워주기
			$("#searchText").val("");
			
		}
		
		callAjax("findLecList.do", "post", "text", true, param, listcallback);
		
	}
	
	
	// 강의 정보 조회
	function fn_selectLec(lec_cd){
		
		var lec_cd = lec_cd;
		
		$("#lec_cd").val(lec_cd);
		
		var param = {
			lec_cd : lec_cd	
		}
		
		var listcallback = function(data){
			
			console.log(data.correct);
			
			// 세션ID와 강의 강사ID 비교
			if(data.correct == 'Y' && $("#show").val() == 'N'){
				// 버튼 보이기
				$("a[name=weekBtn]").removeAttr("style","display:none");
				$("a[name=btn]").removeAttr("style","display:none");
				
			} else{
				// 버튼 가리기
				$("a[name=weekBtn]").attr("style","display:none");
				$("a[name=btn]").attr("style","display:none");
			}
				
				
			$("#lec_loginId").val(data.selectLec.loginID);
			
			initpop(data);
			
			console.log(data);
			
			initweek(data);
			
			gfModalPop("#lecpop");
			
		}
		
		callAjax("/tut/selectLec.do", "post", "json", true, param, listcallback);
	
	}
	
	// 팝업창 세팅
	function initpop(data){
		
		$("#lec_nm").text(data.selectLec.lec_nm);
		$("#lec_ctg").text(data.selectLec.lec_ctg);
		$("#ins_nm").text(data.selectLec.name);
		$("#cls_room").text(data.selectLec.cls_room);
		$("#ins_email").text(data.selectLec.email);
		$("#ins_hp").text(data.selectLec.hp);
		$("#lec_goal").val(data.selectLec.lec_goal);
		
	}
	
	// 주차수 세팅
	function initweek(data){
		
		var lec_cd = data.selectLec.lec_cd;
		var correct = data.correct;
		
		var param = {
				lec_cd : lec_cd
		}
		
		var listcallback = function(data){
			
			$("#weeklyList").empty().append(data);
			
			// 주차 학습목표, 학습내용 readonly
			if(correct == 'Y' && $("#show").val() == 'N'){
				// textarea 활성화
				$("textarea").css("outline","");
				$("textarea").removeAttr("readonly","");
			} else{
				// textarea 비활성화
				$("textarea").css("outline","none");
				$("textarea").attr("readonly","");
			}
			
		}
		
		callAjax("/tut/findWeeklyList.do", "post", "text", true, param, listcallback);
	}
	
	// 강의 정보 저장
	function fn_Save(){
		
    	if(!fValidate()) {
    		return;
    	}
		
		var frm = document.getElementById("myForm");
		frm.enctype = "application/x-www-form-urlcencoded";
		var fileData = new FormData(frm);
		
		var listcallback = function(data) {
			
			swal(data.msg);
			gfCloseModal();
			
			if($("#action").val() == "I"){
				fn_searchList();
			} else if($("#action").val() == "U"){
				fn_searchList($("#currentPageLec").val());
			} 
			
		}
		
		callAjaxFileUploadSetFormData("/tut/saveLecPlan.do", "post", "json", true, fileData, listcallback);
	}
	
	
	// 유효성 확인
	function fValidate() {
						
		var chk = checkNotEmptyName(
				[
						[ "lec_goal", "수업 목표를 입력해주세요" ]
					,	[ "week_goal", "학습목표를 모두 입력해주세요." ]				
					,	[ "week_ctt", "학습내용을 모두 입력해주세요." ]				
				]
		);

		if (!chk) {
			return;
		}

		return true;
	}
	
	
	// 값 공백 확인
	function checkNotEmptyName(arr) {
	    
		for(var i=0, len=arr.length; i<len; i++) {
			
			var $elem = $("textarea[name=" + arr[i][0] + "]");
			
			if($elem.length <= 0){ //not exist
				continue;
			} else{
				
				for(var j = 0; j < $elem.length; j++){
					var elemValue = $.trim( $elem.eq(j).val() );
					var alertMsg = arr[i][1];
		
					if ( elemValue == "" ) {
						swal(alertMsg);
						$elem.focus();
						return false;
					}
				}
			}
			
			
		} 
		 
	    return true;	 
	}
	
	
	// 주차 추가
	function fn_weekPlus(){
		$tr = $('<tr></tr>');
		
		$("#currentWeeklySize").val(Number($("#currentWeeklySize").val()) + 1);
		
		for(var i = 0; i < 4; i++){
			$td = $('<td></td>');
			
			// 서버로 넘길 weekly_no 값
			if(i == 0){
				$td.attr("style", "display:none;");
				$input = $('<input>');
				$input.attr({
					type : "hidden",
					name : "weekly_no",
					value : $("#currentWeeklySize").val() + "주차"
				});
				
				$td.append($input);
			
			// 주차 표시
			} else if(i == 1){
				$td = $('<td>' + $("#currentWeeklySize").val() + '주차</td>');
			
			// 주차 목표 & 내용
			} else {
				$textarea = $('<textarea>');
				$textarea.attr({
					rows : "5"
				  , cols : "30"
			 	  , style : "resize:none; border:none; background-color: transparent;"
				});
				
				if(i == 2) $textarea.attr({
					id : "week_goal",
					name : "week_goal"
					});
				else if(i == 3) $textarea.attr({
					id : "week_ctt",
					name : "week_ctt"
					});
				
				$td.append($textarea);
			}
			
			$td.appendTo($tr);
		}
		
		$("#weeklyList").append($tr);
	}
	
	// 주차 삭제
	function fn_weekMinus(){
		if($("#currentWeeklySize").val() <= 1){
			swal("1주차 밑으로는 삭제하실 수 없습니다.");
		} else{
			$("#currentWeeklySize").val(Number($("#currentWeeklySize").val()) - 1);
			
			var temp = $("#weeklyList tr");
			
			temp.eq($("#currentWeeklySize").val()).remove();
		}
		
	}
	
</script>

</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" id="currentPage">
	<input type="hidden" name="show" id="show" value="N">
	<input type="hidden" name="currentWeeklySize" id="currentWeeklySize" value="1">
	<input type="hidden" name="action" id="action" value="">
	<input type="hidden" name="lec_cd" id="lec_cd" value="">
	<input type="hidden" name="lec_loginId" id="lec_loginId" value="">

	
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
							<span class="btn_nav bold">학습 지원</span> 
							<span class="btn_nav bold">강의계획서</span>
							<a href="../tut/lecturePlan.do" class="btn_set refresh">새로고침</a>
						</p>
						
						<br/>
						
						<div class="btn_areaA mt10">
							<a href="" class="btnType blue" id="ingLec" name="showBtn"><span>진행중 강의</span></a> 
							<a href="" class="btnType gray" id="endLec" name="showBtn"><span>종료된 강의</span></a>
							<input type="checkbox" id="myLec" name="myLec" style="zoom:1.5; margin-left:10px;"/><span style="margin-left:10px; font-size:15px;">내 강의</span>
						</div>

						<p class="conTitle">
							<span>강의계획서 관리</span> 
							<span class="fr">
							    <input type="text" id="searchText" name="searchText"  style="width: 200px; height: 25px;" placeholder="강의명 검색" />
							    <a class="btnType blue" href="javascript:fn_searchList();" name="modal"><span>검색</span></a>
							</span>
						</p>
						
						<div class="divLecPlan">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="10%">
									<col width="35%">
									<col width="15%">
									<col width="20%">
									<col width="20%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">분류</th>
										<th scope="col">강의명</th>
										<th scope="col">강사명</th>
										<th scope="col">기간</th>
										<th scope="col">수강인원</th>
									</tr>
								</thead>
								<tbody id="lecPlan"></tbody>
							</table>
						</div>
	
						<div class="paging_area"  id="lecPlanPagnation"> </div>

					<h3 class="hidden">풋터 영역</h3>
					<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>
	
	<!-- 모달팝업 -->
	<div id="lecpop" class="layerPop layerType2" style="width: 1000px;">
		<dl>
			<dt>
				<strong>강의 계획서</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>
					<colgroup>
						<col width="200px">
						<col width="300px">
						<col width="200px">
						<col width="300px">
					</colgroup>

					<tbody>
						<tr>
							<th scope="row">강의명</th>
							<td id="lec_nm"></td>
							<th scope="row">분류</th>
							<td id="lec_ctg"></td>
						</tr>
						<tr>
							<th scope="row">강사명</th>
							<td id="ins_nm"></td>
							<th scope="row">강의실</th>
							<td id="cls_room"></td>
						</tr>
						<tr>
							<th scope="row">이메일</th>
							<td id="ins_email"></td>
							<th scope="row">연락처</th>
							<td id="ins_hp"></td>
						</tr>
						<tr>
							<th scope="row">수업목표</th>
							<td colspan="3">
								<textarea name="lec_goal" id="lec_goal"  rows="5" cols="30" style="resize:none; border:none; outline:none;" readonly></textarea>
						    </td>
						</tr>
					</tbody>
				</table>
				
				<br/>
				
				<div class="btn_areaA mt30">
					<a href="" class="btnType blue" id="weekPlus" name="weekBtn"><span>주차 추가</span></a> 
					<a href="" class="btnType gray" id="weekMinus" name="weekBtn"><span>주차 삭제</span></a>
				</div>
				
				<div style="width:100%; height:200px; overflow:auto; margin-top: 5px; border: solid 2px #e5e5e5;">
					<table class="col">
						<caption>caption</caption>
						<colgroup>
							<col width="200px">
							<col width="400px">
							<col width="400px">
						</colgroup>
	
						<thead>
							<tr>
								<th scope="col">주차수</th>
								<th scope="col">학습목표</th>
								<th scope="col">학습내용</th>
							</tr>
						</thead>
						
						<tbody id="weeklyList"></tbody>
					</table>
				</div>
				
				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSave" name="btn"><span>저장</span></a>
					<a href="" class="btnType gray" id="btnClose" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>

</form>

<script src="${CTX_PATH}/js/view/mngadm/mngadm.js"></script>
</body>
</html>
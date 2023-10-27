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
<!-- a태그 커서 모양 -->
<style>
	a {cursor:pointer;}
</style>

<!-- sweet swal import -->

<script type="text/javascript">
	
	//페이징 설정
	var pageSize = 10;
	var pageBlockSize = 5;
	
	var showArea;
	var searchArea;
	var divLecPlan;
	var lecpopTbody;
	var weekBtnArea;
	var popupBtn;
	var weeklyListArea;
	
	$(function() {
		
		// 뷰 등록
		vueInit();

		// 강의 목록 조회
		fn_searchList();
		
	});
	
	// 뷰 등록 ----------
	
	function vueInit(){
		
		// 진행중 여부
		showArea = new Vue({
			el : "#showArea",
			data : {
				show : "N",
				myLec : false
			},
			methods : {
				fnShow : function(event){
					eventTargetID = event.currentTarget.id;
					
					if(eventTargetID == "ingLec") this.show = "N";
					else this.show = "Y";
					
					fn_searchList();
				}
			}
		});
		
		// 검색 영역
		searchArea = new Vue({
			el : "#searchArea",
			data : {
				searchText : ""
			},
			methods : {
				searchBtn : function(){
					fn_searchList();
				}
			}
			
		});
		
		// 강의 목록
		divLecPlan = new Vue({
			el : "#divLecPlan",
			data : {
				lecList : [],
				totalcnt : 0,
				lecPlanPagnation : "",
				currentPage : 0,
			},
			methods : {
				selectLec : function(lec_cd){
					fn_selectLec(lec_cd);
				}
			}
		});
		
		// 팝업창
		lecpopTbody = new Vue({
			el : "#lecpopTbody",
			data : {
				lec_cd : 0,
				lec_nm : "",
				lec_ctg : "",
				ins_nm : "",
				cls_room : "",
				ins_email : "",
				ins_np : "",
				lec_goal : "",
				
				vStyle : "",
				readonly : true
			},
			methods : {
			}
		});
		
		
		// 주차 버튼
		weekBtnArea = new Vue({
			el : "#weekBtnArea",
			data:{
				weekBtnShow : false,
			},
			methods : {
				weekPlus : function(){
					fn_weekPlus();
				},
				
				weekMinus : function(){
					fn_weekMinus();
				}
			}
		});
		
		// 주차수 영역
		weeklyListArea = new Vue({
			el : "#weeklyListArea",
			data : {
				currentWeeklySize : 1,					// 주차 추가 혹은 제거 시 +-
				action : "",							// 주차 추가, 제거, 갱신
				preWeeklySize : 0,						// 데이터 전송 시 갱신 후 주차수와 비교하기 위한 이전 주차수 값 
				weekList : [
				            {	
				            	lec_cd : lecpopTbody.lec_cd,
				    		  	lec_goal : lecpopTbody.lec_goal,
				    			week_goal : "",
				    			week_ctt : "",
				    			lec_file_no : 1 
				    		}
				           ],
				           
				vStyle : "",
				readonly : true,
			},
			methods :{
			}
		});

		// 팝업창 버튼
		popupBtn = new Vue({
			el : "#popupBtn",
			data : {
				saveBtnShow : false,
			},
			methods : {
				btnSave : function(){
					fn_Save();
					fn_searchList();
				},
				
				btnClose : function(){
					gfCloseModal();
					fn_searchList(divLecPlan.currentPage);
				}
			}
		});
		
	}
	
	// 뷰 등록 끝--------

	
	// 강의 목록 불러오기
	function fn_searchList(currentPage) {
		
		var currentPage = currentPage || 1;
		
		var param = {
				pageSize : pageSize,
				currentPage : divLecPlan.currentPage,
				searchText : searchArea.searchText,
				show : showArea.show,
				myLec : showArea.myLec
		}
		
	   var listcallback = function(data) {
			
			divLecPlan.totalcnt = data.totalcnt;
			divLecPlan.lecList = data.lecList;
			
			var totalcnt = divLecPlan.totalcnt;
			
			var paginationHtml = getPaginationHtml(currentPage, totalcnt, pageSize, pageBlockSize, 'fn_searchList');
			//console.log("paginationHtml : " + paginationHtml);
			
			// 페이지 네이션
			lecPlanPagnation = paginationHtml;
			
			// 현재 페이지 설정
			divLecPlan.currentPage = currentPage;
			
			// 검색창 비워주기
			searchArea.searchText = "";
			
		}
		
		callAjax("findLecListVue.do", "post", "json", true, param, listcallback);
		
	}
	
	
	// 강의 정보 조회
	function fn_selectLec(lec_cd){
		
		var param = {
			lec_cd : lec_cd	
		}
		
		var listcallback = function(data){
			
			// 세션ID와 강의 강사ID 비교
			if(data.correct == 'Y' && showArea.show == 'N'){
				// 버튼 보이기
				weekBtnArea.weekBtnShow = true;
				popupBtn.saveBtnShow = true;
				
				// textarea
				lecpopTbody.readonly = false;
				lecpopTbody.vStyle = "resize:none;" + "border:none;" + "background-color:transparent;";
				
				weeklyListArea.readonly = false;
				weeklyListArea.vStyle = "resize:none;" + "border:none;" + "background-color:transparent;";
			} else{
				// 버튼 가리기
				weekBtnArea.weekBtnShow = false;
				popupBtn.saveBtnShow = false;
				
				// textarea
				lecpopTbody.readonly = true;
				lecpopTbody.vStyle = "resize:none;" + "border:none;" + "background-color:transparent;" + "outline:none;";
				
				weeklyListArea.readonly = true;
				weeklyListArea.vStyle = "resize:none;" + "border:none;" + "background-color:transparent;" + "outline:none;";
			}
			
			initpop(data);
			
			initweek(data);
			
			gfModalPop("#lecpop");
			
		}
		
		callAjax("/tut/selectLec.do", "post", "json", true, param, listcallback);
	
	}
	
	// 팝업창 세팅
	function initpop(data){
		
		var lec = data.selectLec;
		
		lecpopTbody.lec_cd = lec.lec_cd;
		lecpopTbody.lec_nm = lec.lec_nm;
		lecpopTbody.lec_ctg = lec.lec_ctg;
		lecpopTbody.ins_nm = lec.name;
		lecpopTbody.cls_room = lec.cls_room;
		lecpopTbody.ins_email = lec.email;
		lecpopTbody.ins_hp = lec.hp;
		lecpopTbody.lec_goal = lec.lec_goal;
		
	}
	
	// 주차수 세팅
	function initweek(data){
		
		var lec_cd = data.selectLec.lec_cd;
		var correct = data.correct;
		
		var param = {
				lec_cd : lec_cd
		}
		
		var listcallback = function(data){
			
			if(data.weeklyList.length == 0){
				weeklyListArea.action = "I";
			} else {
				weeklyListArea.action = "U";
			}
			
			weeklyListArea.weekList = data.weeklyList;
			weeklyListArea.preWeeklySize = data.preWeeklySize;
			weeklyListArea.currentWeeklySize = weeklyListArea.weekList.length;
			
		}
		
		callAjax("/tut/findWeeklyListVue.do", "post", "json", true, param, listcallback);
	}
	
	// 강의 정보 저장
	function fn_Save(){
		
    	if(!fValidate()) {
    		return;
    	}
    	
    	var param = {
    			lec_cd : lecpopTbody.lec_cd,
    			lec_goal : lecpopTbody.lec_goal,
    			weekly_data : JSON.stringify(weeklyListArea.weekList),
    			preWeeklySize : weeklyListArea.preWeeklySize,
    			action : weeklyListArea.action
    	}
		
		var listcallback = function(data) {
			
			swal(data.msg);
			gfCloseModal();
			
			if(weeklyListArea.action == "I"){
				fn_searchList();
			} else {
				fn_searchList(divLecPlan.currentPage);
			} 
			
		}
		
		callAjax("/tut/saveLecPlanVue.do", "post", "json", true, param, listcallback);
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
	    
		console.log(weeklyListArea.weekList);
		// 강의목표
		var lecVal = lecpopTbody.lec_goal;
		// 주차 학습목표 & 학습내용
		var weekVal = weeklyListArea.weekList;
		
		var alertMsg = "";
		
		// 강의목표 공백확인
		if(lecVal.trim() == ""){
			alertMsg = arr[0][1];
			swal(alertMsg);
			return false;
		}
		
		// 주차 학습목표 & 학습내용 공백확인
		for(var i = 0; i < weekVal.length; i++){
			
			if(weekVal[i].week_goal.trim() == ""){
				alertMsg = arr[1][1];
				swal(alertMsg);
				return false;
			}
			
			if(weekVal[i].week_ctt.trim() == ""){
				alertMsg = arr[2][1];
				swal(alertMsg);
				return false;
			}
			
		}
		 
	    return true;	 
	}
	
	
	// 주차 추가
	function fn_weekPlus(){
		
		weeklyListArea.currentWeeklySize++;
		
		var temp = {
				lec_cd : lecpopTbody.lec_cd,
				lec_file_no : 1,
				week_ctt : "",
				week_goal : "",
				weekly_no : weeklyListArea.currentWeeklySize + "주차"
					}
		
		weeklyListArea.weekList.push(temp);
		
	}
	
	// 주차 삭제
	function fn_weekMinus(){
		
		
		if(weeklyListArea.currentWeeklySize <= 1){
			swal("1주차 밑으로는 삭제하실 수 없습니다.");
		} else{
			weeklyListArea.currentWeeklySize--;
			weeklyListArea.weekList.pop();
		}
		
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
							<span class="btn_nav bold">학습 지원</span> 
							<span class="btn_nav bold">강의계획서</span>
							<a href="../tut/lecturePlanvue.do" class="btn_set refresh">새로고침</a>
						</p>
						
						<br/>
						
						<div id="showArea" class="btn_areaA mt50">
							<a class="btnType blue" id="ingLec" name="showBtn" @click="fnShow"><span>진행중 강의</span></a> 
							<a class="btnType gray" id="endLec" name="showBtn" @click="fnShow"><span>종료된 강의</span></a>
							<input type="checkbox" id="myLec" name="myLec" v-model="myLec" style="zoom:1.5; margin-left:10px;"/><span style="margin-left:10px; font-size:15px;">내 강의</span>
						</div>

						<p id="searchArea" class="conTitle">
							<span>강의계획서 관리</span> 
							<span class="fr">
							    <input type="text" id="searchText" name="searchText" v-model="searchText" style="width: 200px; height: 25px;" placeholder="강의명 검색" />
							    <a class="btnType blue" @click="searchBtn" name="modal"><span>검색</span></a>
							</span>
						</p>
						
						<div id="divLecPlan" class="divLecPlan">
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
								<tbody>
									<template v-if="totalcnt == 0">
										<tr>
											<td colspan="5">데이터가 존재하지 않습니다.</td>
										</tr>
									</template>
									<template v-else v-for="list in lecList">
										<tr>
											<td>{{ list.lec_ctg }}</td>
											<td><a @click="selectLec(list.lec_cd)">{{ list.lec_nm }}</a></td>
											<td>{{ list.name }}</td>
											<td>{{ list.lec_start_date }} ~ {{ list.lec_end_date }}</td>
											<td>{{ list.app_cnt }} / {{ list.capacity }}</td>
										</tr>
									</template>
								</tbody>
							</table>
							
							<div class="paging_area"  id="lecPlanPagnation" v-html="lecPlanPagnation"> </div>
						</div>
	

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

					<tbody id="lecpopTbody">
						<tr>
							<th scope="row">강의명</th>
							<td id="lec_nm" v-text="lec_nm"></td>
							<th scope="row">분류</th>
							<td id="lec_ctg" v-text="lec_ctg"></td>
						</tr>
						<tr>
							<th scope="row">강사명</th>
							<td id="ins_nm" v-text="ins_nm"></td>
							<th scope="row">강의실</th>
							<td id="cls_room" v-text="cls_room"></td>
						</tr>
						<tr>
							<th scope="row">이메일</th>
							<td id="ins_email" v-text="ins_email"></td>
							<th scope="row">연락처</th>
							<td id="ins_hp" v-text="ins_hp"></td>
						</tr>
						<tr>
							<th scope="row">수업목표</th>
							<td colspan="3">
								<textarea ref="lec_goal_ta" name="lec_goal" id="lec_goal" v-model="lec_goal" rows="5" cols="30" :style="vStyle" :readonly="readonly"></textarea>
						    </td>
						</tr>
					</tbody>
				</table>
				
				<br/>
				
				<div id="weekBtnArea" class="btn_areaA mt30">
					<a class="btnType blue" id="weekPlus" name="weekBtn" v-show="weekBtnShow" @click="weekPlus"><span>주차 추가</span></a> 
					<a class="btnType gray" id="weekMinus" name="weekBtn" v-show="weekBtnShow" @click="weekMinus"><span>주차 삭제</span></a>
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
						
						<tbody id="weeklyListArea">
							<template v-if="weekList.length == 0">
								<tr>
									<td>1주차</td>
									<td>
										<textarea ref="week_goal_ta" name="week_goal" v-model="weekList.week_goal" rows="5" cols="30" :style="vStyle" :readonly="readonly"></textarea>
									</td>
									<td>
										<textarea ref="week_ctt_ta" name="week_ctt" v-model="weekList.week_ctt" rows="5" cols="30" :style="vStyle" :readonly="readonly"></textarea>
									</td>
								</tr>
							</template>
							<template v-else v-for="list in weekList">
								<tr>
									<td>{{ list.weekly_no }}</td>
									<td>
										<textarea ref="week_goal_ta" name="week_goal" v-model="list.week_goal" rows="5" cols="30" :style="vStyle" :readonly="readonly"></textarea>
									</td>
									<td>
										<textarea ref="week_ctt_ta" name="week_ctt"  v-model="list.week_ctt" rows="5" cols="30" :style="vStyle" :readonly="readonly"></textarea>
									</td>
								</tr>
							</template>
						</tbody>
					</table>
				</div>
				
				<div id="popupBtn" class="btn_areaC mt30">
					<a class="btnType blue" id="btnSave" name="btn" v-show="saveBtnShow" @click="btnSave"><span>저장</span></a>
					<a class="btnType gray" id="btnClose" name="btn" @click="btnClose"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a class="closePop" href="popupBtn.btnClose()"><span class="hidden">닫기</span></a>
	</div>

</form>

<script src="${CTX_PATH}/js/view/mngadm/mngadm.js"></script>
</body>
</html>
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
	var pageSize = 10;
	var pageBlockSize = 5;
	var searcharea;
	var divAdviceMngList;
	var advicepop;
	
	
	
	$(function() {
		
		vueinit();
		
		selectComCombo("cls","cls_room","sel","", "");
		
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

					fn_searchList($("#currentPage").val());

					break;
			}
		});
	}

	

	function vueinit() {
		
		searcharea = new Vue({
			                 el: "#searcharea",
			               data: {
			            	   searchSel : "",
			            	   searchText : "",
			            	  // usertype: "${sessionScope.userType}"
			               },
			               methods:{
			                	 fn_searchList : function() {
			                		 fn_searchList();
			                	 }
			                 }
		});
		
		divAdviceMngList = new Vue({
			                el:"#divAdviceMngList",
			              data: {
			            	 datalist:[],
		                     totalcnt:0,
		                     pagingnavi: "",
		                     currentPage:0,
		                     ins_id : "",
		                    // userType: "${sessionScope.userType}"
			              } ,
			            methods : {
			            	fn_selectAdv : function(std_id) {
			            		
// 			            		divAdviceMngList.std_id = stdid;
// 			            		divAdviceMngList.cst_no = cstno;
			            		
			            		fn_selectAdv(std_id);
			            	}
			              
			            }  
			                  
		});
		
		
		advicepop = new Vue({
		                   el:"#advicepop",
		                 data: {
		                	lec_cd:"",
		                	cst_no:"",
		                	std_id:"",
		                	cst_date:"",
		                	cls_room:"",
		                	cst_ctt:"",
		                	cst_update_date:"",
		                	cst_cst_yn:"",
		                	cst_delete_yn:"",

		                	lec_nm: "",
		                	std_nm:"",
		                	ins_nm:"",
		                	ins_id:"",
		                	 
		                	action:"",
		                	 
		                	delflag : false,
		                	
		                	
		                	True : true,
							False : false,
							
			         		//userType: "${sessionScope.userType}",
			        		//loginid: "${loginid}"
		                 },

		});
		
		
		
	}
	
	
	
	
	// 목록 불러오기
	function fn_searchList(currentPage) {
		
		var currentPage = currentPage || 1;
		
		var param = {
				pageSize : pageSize,
				currentPage : currentPage,
				searchSel : searcharea.searchSel,
				searchText : searcharea.searchText,
		}
		
	   var listcallback = function(returndata) {
			console.log(JSON.stringify(returndata ));
			
			divAdviceMngList.datalist = returndata.adviceList;
			divAdviceMngList.totalcnt = returndata.totalcnt;
			divAdviceMngList.ins_id = returndata.ins_id;
			console.log(divAdviceMngList.datalist);
			console.log(divAdviceMngList.totalcnt);
			
			var paginationHtml = getPaginationHtml(currentPage, divAdviceMngList.totalcnt, pageSize, pageBlockSize, 'fn_searchList');
			console.log("paginationHtml : " + paginationHtml);
			//swal(paginationHtml);
			
			divAdviceMngList.pagingnavi = paginationHtml;
			divAdviceMngList.currentPage = currentPage;
						
		}
		
		callAjax("/tut/adviceListVue.do", "post", "json", true, param, listcallback);
		
	}
	
  	// 상세 팝업
	function fn_openpopup() {
	    	
			initPop();
	    	
			// 모달 팝업
			gfModalPop("#advicepop");
		
		
    }
	    
	// 상담 학생 하나 클릭
	function fn_selectAdv(std_id){
	
		var param = {
				std_id : std_id ,
				ins_id : divAdviceMngList.ins_id
		}
		
		var listcallback = function(data){
			// 초기 세팅
			console.log(JSON.stringify(data));  
    		console.log(data.advModel);
    		
    		initPop(data.advModel);
			
			// 모달 팝업
			gfModalPop("#advicepop");
		}
		
		callAjax("/tut/selectAdv.do", "post", "json", true, param, listcallback);
	
	}
	// 오늘 날짜 생성 함수
	function getToday(){
	    var date = new Date();
	    var year = date.getFullYear();
	    var month = ("0" + (1 + date.getMonth())).slice(-2);
	    var day = ("0" + date.getDate()).slice(-2);

	    return year + "-" + month + "-" + day;
	}
	
	// 팝업창 열기 전 셋팅
	function initPop(data){
// 		$("#lec_nm").val(data.lec_nm).attr("readonly", true).css("background-color", "#f0f0f0");
// 		$("#std_nm").val(data.std_nm).attr("readonly", true).css("background-color", "#f0f0f0");
// 		$("#lec_cd").val(data.lec_cd).attr("readonly", true).css("background-color", "#f0f0f0");
// 		$("#std_id").val(data.std_id).attr("readonly", true).css("background-color", "#f0f0f0");
// 		$("#ins_nm").val(data.ins_nm).attr("readonly", true).css("background-color", "#f0f0f0");
		advicepop.lec_nm = data.lec_nm;
		advicepop.std_nm = data.std_nm;
		advicepop.lec_cd = data.lec_cd;
		advicepop.std_id = data.std_id;
		advicepop.ins_nm = data.ins_nm;
		
		if(data.cst_no == null || data.cst_no == "" || data.cst_no == undefined){
			advicepop.action = "I";
			
			advicepop.cst_no = "";
			advicepop.cst_date = "";
			selectComCombo("cls","cls_room","sel","","");
			//$("#cst_update_date").val(getToday()).attr("readonly", true).css("background-color", "#f0f0f0");
 			advicepop.cst_update_date = getToday();
			advicepop.cst_ctt = "";
			
			advicepop.delflag = false;		
			advicepop.isreadonly = true;
			
			advicepop.btnDelete = true;
		} else{
			advicepop.action = "U"; 
			
			advicepop.cst_no = data.cst_no;
			advicepop.cst_date = data.cst_date;
			selectComCombo("cls","cls_room","sel","",data.cls_room);
// 			$("#cst_update_date").val(data.cst_update_date).attr("readonly", true).css("background-color", "#f0f0f0");
			advicepop.cst_update_date = data.cst_update_date;
			advicepop.cst_ctt = data.cst_ctt;
			
			
// 			$("#btnDelete").show();
			advicepop.btnDelete = false;
			
			advicepop.delflag = true;
		}
	}
	
	// 저장 
	function fn_Save(){
		
    	if(!fValidate()) {
    		return;
    	}
		
		var param = {
				action : advicepop.action,
				cst_date : advicepop.cst_date,
				cst_update_date : advicepop.cst_update_date,
				cst_ctt : advicepop.cst_ctt,
				cls_room : advicepop.cls_room,
				lec_cd : advicepop.lec_cd, 
				std_id : advicepop.std_id,
				cst_no : advicepop.cst_no
		}
		
		var listcallback = function(returnData){

			swal(returnData.msg);
   			gfCloseModal();
			
			if(advicepop.action == "I"){
				fn_searchList();
			} else if(advicepop.action == "U"){
				fn_searchList(divAdviceMngList.currentPage);
			} else if(advicepop.action == "D"){
				fn_searchList(divAdviceMngList.currentPage);
			}
		}
		
		callAjax("/tut/saveAdv.do", "post", "json", true, param, listcallback);
	}
	

	 
	// 유효성 확인
	function fValidate() {

		var chk = checkNotEmpty(
				[
						[ "cst_date", "상담일자를 입력해 주세요." ]
						,[ "cst_ctt", "상담내용을 입력해 주세요." ]
						,[ "cls_room", "상담장소를 입력해 주세요." ]
				]
		);
		// false가 되어야 함
		var isValidDate = compareDates();

	    if(!isValidDate) {
	        return;
		    };
		if(!chk) {
			return;
		}

		return true;
	}
	// 날자 비교 함수
	function compareDates() {
	    var cst_date_str = advicepop.cst_date; // yyyy-MM-dd 형식의 문자열
	    var cst_date = new Date(advicepop.cst_date_str); // 문자열을 Date 객체로 변환
	    var today = new Date();

        if (today < cst_date) {
    		console.log(cst_date)
    		console.log(today)
            swal("상담일이 오늘을 초과할 수 없습니다.")
            return false;
        }
        return true;
    }
	
	
	
	// 강의 삭제
	function fn_Delete(){
		
		if(confirm("정말로 삭제하시겠습니까??")){
			advicepop.action = "D";
			fn_Save();
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
							<span class="btn_nav bold">학습관리</span> 
							<span class="btn_nav bold">상담 관리</span>
							<a href="/tut/advice.do" class="btn_set refresh">새로고침</a>
						</p>

						<p id="searcharea" class="conTitle">
							<span>상담 목록</span> 
							<span class="fr"> 
								<select id="searchSel" name="searchSel" v-model="searchSel">
							         <option value="">전체</option>
							         <option value="lectureName">강의명</option>
							         <option value="stdName">학생이름</option>
							    </select>
							    <input type="text" id="searchText" name="searchText" v-model="searchText" style="width: 200px; height: 25px;" />
							    <a class="btnType blue" href="#" @click="fn_searchList"  name="modal"><span>검색</span></a>
							</span>
						</p>
						
						<div id="divAdviceMngList" class="divAdviceMngList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="10%">
									<col width="25%">
									<col width="20%">
									<col width="20%">
									<col width="10%">
									<col width="15%">
									
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">순번</th>
										<th scope="col">수강 강의</th>
										<th scope="col">학생 이름 (ID)</th>
										<th scope="col">상담일자</th>
										<th scope="col">상담 여부</th>
										<th scope="col">수정/삭제</th>
									</tr>
								</thead>
								<tbody>
									<template v-if="totalcnt == 0">
									                <tr>   <td colspan=6> 데이터가 없습니다.  </td> </tr>
									      </template> 
									      <template v-else v-for="one in datalist">
												<tr>
								                     <td>{{ one.cst_no }}</td>
						                             <td>{{ one.lec_nm }}</td>
						                             <td>{{ one.std_nm }} ({{ one.std_id }})</td>
						                             <td>{{ one.cst_date }}</td>
						                             <td>{{ one.cst_yn }}</td>
						                             <td> <a class="btnType3 color1" @click="fn_selectAdv(one.std_id)"><span>수정</span></a> </td>
								                </tr>
									      </template>
								
								
								
								
<!-- 								<template  v-if="totalcnt > 0"> -->
<!-- 								      <template  v-for="(list, index) in datalist"> -->
<!-- 								                <tr > -->
<!-- 								                     <td>{{ totalcnt - index }}</td> -->
<!-- 						                             <td>{{ list.lec_nm }}</td> -->
<!-- 						                             <td>{{ list.std_nm }} ({{ list.std_id }}) </td> -->
<!-- 						                             <td>{{ list.cst_date }}</td> -->
<!-- 						                             <td>{{ list.cst_yn }}</td> -->
<!-- 						                             <td> -->
<!-- 						                              <a @click="fn_selectAdv(list.std_id)" class="btnType blue" name="btn"><span>수정/삭제</span></a> -->
<!-- 						                             </td> -->
<!-- 								                </tr> -->
<!-- 								      </template> -->
								      
<!-- 								      <template v-else> -->
<!-- 								                <tr> -->
<!-- 											        <td colspan="6">데이터가 존재하지 않습니다.</td> -->
<!-- 											    </tr> -->
<!-- 								      </template>  -->
								
								</tbody>
							</table>
							<div class="paging_area"  id="pagingnavi" v-html="pagingnavi"> </div>
						</div>
	
						
					
					<h3 class="hidden">풋터 영역</h3>
					<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>
	<!-- 모달팝업 -->
	<div id="advicepop" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong>상담등록</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>
					<colgroup>
						<col width="200px">
						<col width="200px">
						<col width="200px">
						<col width="200px">
					</colgroup>

					<tbody>
						<tr>
							<th scope="row">강의명 </th>
							<td >
							<input type="text" class="inputTxt p100" name="lec_nm" id="lec_nm" v-model="lec_nm" :disabled="True" />
							</td>
							<th scope="row">학생명 </th>
							<td>
							<input type="text" class="inputTxt p100" name="std_nm" id="std_nm" v-model="std_nm" :disabled="True" />
							</td>
						</tr>
						<tr>
							<th scope="row">상담자 </th>
							<td >
							<input type="text" class="inputTxt p100" name="ins_nm" id="ins_nm"  v-model="ins_nm" :disabled="True" />
							</td>
							<th scope="row">상담일자<span class="font_red">*</span> </th>
							<td>
								<input type="date" class="inputTxt p100" id="cst_date" name="cst_date" v-model="cst_date"/>
							</td>
						</tr>
						<tr>
							<th scope="row">상담장소<span class="font_red">*</span> </th>
							<td>
								<select id="cls_room" name="cls_room" v-model="cls_room"></select>
							</td>
							<th scope="row">최종수정일자 </th>
							<td colspan="3">
					      		<input type="date" class="inputTxt p100" name="cst_update_date" id="cst_update_date" v-model="cst_update_date" :disabled="True"  />
							</td>
						</tr>
						<tr>
							<th colspan="4" scope="row">상담내용 <span class="font_red">*</span></th>
						</tr>
						<tr>
							<td colspan="4">
								<textarea  rows="50" cols="30" name="cst_ctt" id="cst_ctt" v-model="cst_ctt"></textarea>
						    </td>
						</tr>
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSave" name="btn"><span>저장</span></a> 
					<a href="" class="btnType blue" id="btnDelete" name="btn" v-show="delflag"><span>삭제</span></a> 
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
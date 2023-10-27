<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Job Korea :: 과제제출</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script src="https://unpkg.com/axios@0.12.0/dist/axios.min.js"></script>
<script src="https://unpkg.com/lodash@4.13.1/lodash.min.js"></script>
<!-- a태그 커서 모양 -->
<style>
	a {cursor:pointer;}
</style>

<script type="text/javascript">

	//페이징 설정
	var pageSize = 10;
	var pageBlockSize = 5;
	
	var divLecInfo;
	var divHwkList;
	var hwkSelect;
	
	$(function() {

		// 뷰세팅
		initVue();
		
		// 강의 정보 조회
		fn_findLecInfo();
		
	});
	
	// 뷰 등록 --------------------------
	function initVue(){
		
		// 수업 정보 영역
		divLecInfo = new Vue({
			el : "#divLecInfo",
			data : {
				lec_cd : 0,
				lec_nm_text : "",
				ins_nm_text : "",
				start_date_text : "",
				end_date_text : ""
			}
		});
		
		// 과제 목록 영역
		divHwkList = new Vue({
			el : "#divHwkList",
			data : {
				hwkList : [],
				totalcnt : 0,
				currentPage : null,
				hwkListPagnation : ""
			},
			methods : {
				fn_hwkSm : function(hwk_no){
					fn_hwkSm(hwk_no);
				},
				
				fn_hwkFileDown : function(hwk_file_no){
					fn_hwkFileDown(hwk_file_no);
				}
			}
		});
		
		// 과제 클릭
		hwkSelect = new Vue({
			el : "#hwkSelect",
			data : {
				hwk_no : 0,
				lec_nm : "",
				ins_nm : "",
				hwk_nm : "",
				hwk_ctt : "",
				sm_ctt : "",
				hwk_sm_file : "",
				filepreview : "",
				pre_file_no : 0,
				
				fileYN : "",
				action : "",
				
				showBtn1 : false,
				showBtn2 : true,
			},
			methods : {
				btnSave : function(){
					this.action = "I";
					fn_Save();
				},
				
				btnUpdate : function(){
					this.action = "U";
					fn_Save();
				},
				
				btnDelete : function(){
					this.action = "D";
					fn_Save();
				},
				
				btnClose : function(){
					gfCloseModal();
				},
				
				imagechage : function(event){
					imagechage(event.target);
				}
			}
		});
		
	}
	
	// 뷰 등록 끝 -----------------------
	
	// 강의 정보 조회
	function fn_findLecInfo(){
		
		var param = {
		}
		
	   var listcallback = function(data) {
			
			divLecInfo.lec_cd = data.lec_cd;
			divLecInfo.lec_nm_text = data.lec_nm;
			divLecInfo.ins_nm_text = data.name;
			divLecInfo.start_date_text = data.lec_start_date;
			divLecInfo.end_date_text  = data.lec_end_date;
			
			// 과제 목록 조회
			fn_searchList();
		}
		
		callAjax("/std/findLecInfo.do", "post", "json", true, param, listcallback);
		
	}
	
	
	// 과제 목록 조회
	function fn_searchList(currentPage){

		var currentPage = currentPage || 1;
		
		var param = {
				pageSize : pageSize,
				currentPage : currentPage,
				lec_cd : divLecInfo.lec_cd
		}
		
	   var listcallback = function(returndata) {
			
			divHwkList.hwkList = returndata.hwkList;
			divHwkList.totalcnt = returndata.totalcnt;
			
			var paginationHtml = getPaginationHtml(currentPage, divHwkList.totalcnt, pageSize, pageBlockSize, 'fn_searchList');
			//console.log("paginationHtml : " + paginationHtml);
			
			divHwkList.hwkListPagnation = paginationHtml;
			
			// 현재 페이지 설정
			divHwkList.currentPage = currentPage;
			
		}
		
		callAjax("/std/findHwkListVue.do", "post", "json", true, param, listcallback);
		
	}
	
	
	// 다운로드 클릭
	function fn_hwkFileDown(hwk_file_no){
		
		var params = ""
	    	params += "<input type='hidden' id='hwk_file_no' name='hwk_file_no' value='"+ hwk_file_no +"' />";
	    	
	    	jQuery("<form action='/std/hwkFiledownload.do' method='post'>"+params+"</form>").appendTo('body').submit().remove();
	}
	
	
	// 과제명 클릭
	function fn_hwkSm(hwk_no){
		
		// 팝업창 초기화
		initPop(hwk_no);
		
		// 제출한 과제인지 조회
		fn_findHwkSm();
		
		gfModalPop("#hwkSelect");
	}
	
	
	// 팝업창 초기화
	function initPop(hwk_no){

		hwkSelect.sm_ctt = "";
		hwkSelect.hwk_sm_file = "";
		hwkSelect.filepreview = "";
		
		hwkSelect.lec_nm = divLecInfo.lec_nm_text;
		hwkSelect.ins_nm = divLecInfo.ins_nm_text;
		
		var hwkList = divHwkList.hwkList;
		
		for(var i = 0; i < hwkList.length; i++){
			if(hwkList[i].hwk_no == hwk_no){
				hwkSelect.hwk_nm = hwkList[i].hwk_nm;
				hwkSelect.hwk_ctt = hwkList[i].hwk_ctt;
				hwkSelect.hwk_no = hwkList[i].hwk_no;
			}
		}
	}
	
	
	// 제출한 과제인지 조회
	function fn_findHwkSm(){
		
		var param = {
			lec_cd : divLecInfo.lec_cd,
			hwk_no : hwkSelect.hwk_no
		}
		
	   var listcallback = function(data) {
			
			if(data.smHwkModel == null){
				hwkSelect.showBtn1 = true;
				hwkSelect.showBtn2 = false;
			} else{
				hwkSelect.showBtn1 = false;
				hwkSelect.showBtn2 = true;
				
				// 불러온 정보 넣어주기
				hwkSelect.sm_ctt = data.smHwkModel.sm_ctt;
				
				// 파일 정보 보여주기
				var insertHtml ="";
				
        		insertHtml = "<a href='javascript:fn_smDownload(" + data.smFileInfo.sm_file_no + ")'> "
        		
         	    if(data.smFileInfo.sm_file_extend.toLowerCase() == "jpg" ||  data.smFileInfo.sm_file_extend.toLowerCase() == "png"  ||  data.smFileInfo.sm_file_extend.toLowerCase() == "gif" ) {
         	    	insertHtml += "<img src='" + data.smFileInfo.sm_file_logical + "'   style='width: 100px; height: 100px;''   />";
   		        } else {
   		        	insertHtml += data.smFileInfo.sm_file_nm;
   		        }        		
       		    
        		insertHtml += "</a>"; 
				
        		hwkSelect.filepreview = insertHtml;

        		// 파일 번호 저장(과제 갱신에 사용)
        		hwkSelect.pre_file_no = data.smFileInfo.sm_file_no;
				
			}
			
		}
		
		callAjax("/std/findHwkSm.do", "post", "json", true, param, listcallback);
		
	}
	
	
	// 저장, 수정 버튼 클릭
	function fn_Save(){
		
		if(hwkSelect.hwk_sm_file == null || hwkSelect.hwk_sm_file == ""){
			hwkSelect.fileYN = "N";
		} else{
			hwkSelect.fileYN = "Y";
		}
		
		if(hwkSelect.action == "I" || hwkSelect.action == "U"){

			// 유효성 검사
			if(!fValidatefile()) {
				return;
			}
			
		}
		
		
		var frm = document.getElementById("myForm");
		frm.enctype = 'multipart/form-data';
		var fileData = new FormData(frm);
		
		// 추가 데이터 넣기
		fileData.append("action", hwkSelect.action);
		fileData.append("fileYN", hwkSelect.fileYN);
		fileData.append("lec_cd", divLecInfo.lec_cd);
		fileData.append("hwk_no", hwkSelect.hwk_no);
		fileData.append("pre_file_no", hwkSelect.pre_file_no);
		
		
		var listcallback = function(data) {
			//console.log(JSON.stringify(data));
			
			swal(data.msg);

			gfCloseModal();
			
			fn_searchList();
		}
		
		callAjaxFileUploadSetFormData("/std/saveHwk.do", "post", "json", true, fileData, listcallback);
	}
	
	
	// 유효성 검사
	function fValidatefile() {

		if(hwkSelect.action == "I"){
			
			var chk = checkNotEmpty(
					[
							[ "sm_ctt", "내용을 입력해 주세요." ]
						,	[ "hwk_sm_file", "파일을 선택해 주세요." ]	
					]
			);
			
		} else if(hwkSelect.action == "U"){
			
			var chk = checkNotEmpty(
					[
							[ "sm_ctt", "내용을 입력해 주세요." ]
					]
			);
			
		}

		if (!chk) {
			return;
		}

		return true;
	}
	
	// 파일(이미지) 선택시 미리보기 동작
	function imagechage(event) {
    	
    	var image = event;
		  
		if(image.files[0]){
			
			var imagepath =  window.URL.createObjectURL(image.files[0])
			
			var file_info = hwkSelect.hwk_sm_file;
			var file_info_arr = file_info.split(".");
			
			var inserhtml = "";
			
		   if(file_info_arr[file_info_arr.length - 1].toLowerCase() == "jpg" ||  file_info_arr[file_info_arr.length - 1].toLowerCase() == "png"  ||  file_info_arr[file_info_arr.length - 1].toLowerCase() == "gif" ) {
			   inserhtml = "<img src='" + imagepath + "'   style='width: 100px; height: 100px;''   />";
		   } else {
			   inserhtml = "";
		   }
			
		   hwkSelect.filepreview = inserhtml;
			
		}
    	
    } 
	
	
	// 제출한 과제 파일 다운로드
	function fn_smDownload(sm_file_no){
		
		var params = ""
	    	params += "<input type='hidden' id='sm_file_no' name='sm_file_no' value='"+ sm_file_no +"' />";
	    	
	    	jQuery("<form action='/std/smFiledownload.do' method='post'>"+params+"</form>").appendTo('body').submit().remove();
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
							<span class="btn_nav bold">과제제출</span>
							<a href="../std/submittedWorkvue" class="btn_set refresh">새로고침</a>
						</p>
						
						<br/>

						<p class="conTitle">
							<span>과제제출</span>
						</p>
						
						<p class="subTitle"> 수업정보 </p>
						<div id="divLecInfo" class="divLecInfo" style="overflow:auto; height:10vh;">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="30%">
									<col width="20%">
									<col width="25%">
									<col width="25%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">강의명</th>
										<th scope="col">강사</th>
										<th scope="col">시작일</th>
										<th scope="col">종료일</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td v-text="lec_nm_text"></td>
										<td v-text="ins_nm_text"></td>
										<td v-text="start_date_text"></td>
										<td v-text="end_date_text"></td>
									</tr>
								</tbody>
							</table>
						</div>
						
						<p class="subTitle"> 과제목록 </p>
						<div id="divHwkList" class="divHwkList" style="overflow:auto; height:50vh;">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="15%">
									<col width="30%">
									<col width="30%">
									<col width="20%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">번호</th>
										<th scope="col">과제명</th>
										<th scope="col">기간</th>
										<th scope="col">첨부파일</th>
									</tr>
								</thead>
								<tbody>
									<template v-if="totalcnt == 0">
										<tr>
											<td colspan="4">과제가 없습니다.</td>
										</tr>
									</template>
									<template v-else v-for="(list, index) in hwkList">
										<tr>
											<td>{{ index }}</td>
											<td>
												<a @click="fn_hwkSm(list.hwk_no)">{{ list.hwk_nm }}</a>
											</td>
											<td>{{ list.hwk_start_date }} ~ {{ list.hwk_end_date }}</td>
											<td>
												<template v-if="list.hwk_file_no != 1">
													<a class="btnType blue" @click="fn_hwkFileDown(list.hwk_file_no)"><span>다운로드</span></a>
												</template>
											</td>
										</tr>
									</template>
								</tbody>
							</table>
							<div class="paging_area"  id="hwkListPagnation" v-html="hwkListPagnation"> </div>
						</div>
						

					<h3 class="hidden">풋터 영역</h3>
					<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>
	
	<!-- 모달팝업 -->
	<!-- 과제 클릭 -->
	<div id="hwkSelect" class="layerPop layerType2" style="width: 800px;">
		<dl>
			<dt>
				<strong>과제</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>
					<colgroup>
						<col width="100px">
						<col width="300px">
						<col width="100px">
						<col width="300px">
					</colgroup>
					
					<tr>
						<th scope="row">강의명</th>
						<td v-text="lec_nm"></td>
						<th scope="row">강사명</th>
						<td v-text="ins_nm"></td>
					</tr>
					<tr>
						<th scope="row">과제명</th>
						<td colspan="3" v-text="hwk_nm"></td>
					</tr>
					<tr>
						<th scope="row">과제내용</th>
						<td colspan="3" v-text="hwk_ctt"></td>
					</tr>
					<tr>
						<th scope="row">내용<span class="font_red">*</span></th>
						<td colspan="3">
							<input type="text" id="sm_ctt" name="sm_ctt" v-model="sm_ctt" class="inputTxt p100" style="border:none;" autocomplete="off" />
						</td>
					</tr>
					<tr>
						<th scope="row">첨부파일</th>
						<td>
							<input type="file" id="hwk_sm_file" name="hwk_sm_file" v-model="hwk_sm_file" class="inputTxt p100"  @change="imagechage"/>
						</td>
						<td colspan="2">
				      		<div v-html="filepreview"></div>
						</td>
					</tr>
				</table>
				
				<div class="btn_areaC mt30">
					<a class="btnType blue" id="btnSave" name="btn" @click="btnSave" v-show="showBtn1"><span>저장</span></a>
					<a class="btnType blue" id="btnUpdate" name="btn" @click="btnUpdate" v-show="showBtn2"><span>수정</span></a>
					<a class="btnType blue" id="btnDelete" name="btn" @click="btnDelete" v-show="showBtn2"><span>삭제</span></a> 
					<a class="btnType gray" id="btnClose" name="btn" @click="btnClose"><span>닫기</span></a>
				</div>
			</dd>
		</dl>
		<a class="closePop" @click="btnClose"><span class="hidden">닫기</span></a>
	</div>

</form>

</body>
</html>
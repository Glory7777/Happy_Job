<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Job Korea :: 과제관리</title>
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

	var divLecInfo;
	var divHwkList;
	var hwkSelect;
	var stdListPop;
	var hwkSmInfo;
	var hwkInsert;
	
	$(function() {

		// 뷰등록
		initVue();

		// 주차 목록 조회
		fn_searchList();
		
	});
	
	// 뷰 등록 ----------------------
	function initVue(){
		
		// 강사 강의 정보
		divLecInfo = new Vue({
			el : "#divLecInfo",
			data : {
				lec_cd : 0,
				LecInfo : "",
			}
		});
		
		
		// 과제 관리
		divHwkList = new Vue({
			el : "#divHwkList",
			data :{
				totalcnt : 0,
				hwkList : [],
				action : ""
			},
			methods : {
				fn_selectHwk : function(lec_cd, hwk_no){
					fn_selectHwk(lec_cd, hwk_no);
				},
				
				fn_stdList : function(lec_cd, hwk_no){
					fn_stdList(lec_cd, hwk_no);
				}
			}
		});
		
		
		// 과제 클릭
		hwkSelect = new Vue({
			el : "#hwkSelect",
			data : {
				hwk_no : 0,
				hwk_nm_text : "",
				hwk_ctt_text : "",
				hwk_start_date_text : "",
				hwk_end_date_text : "",
				hwk_file_no : 0,
				hwk_file_text : "",
			},
			methods : {
				btnUpdate : function(){
					fn_Update();
				},
				
				btnDelete : function(){
					divHwkList.action = "D";
					fn_Save();
				},
				
				btnClose : function(){
					gfCloseModal();
				}
			}
		});
		
		
		// 제출 현황
		stdListPop = new Vue({
			el : "#stdListPop",
			data : {
				appStdList : [],
				lec_cd : 0,
				hwk_no : 0
			},
			methods : {
				fn_hwkSmInfo : function(loginID){
					fn_hwkSmInfo(loginID);
				},
				
				btnClose : function(){
					hwkSelect.btnClose();
				}
			}
		});
		
		
		// 제출 정보 보기
		hwkSmInfo = new Vue({
			el : "#hwkSmInfo",
			data : {
				sm_ctt_text : "",
				sm_file_no : "",
				sm_file_nm : "",
				sm_date : ""
			},
			methods : {
				fn_smDownload : function(sm_file_no){
					fn_smDownload(sm_file_no);
				},
				
				btnClose : function(){
					hwkSelect.btnClose();
				}
			}
		});
		
		// 과제 팝업창
		hwkInsert = new Vue({
			el : "#hwkInsert",
			data : {
				hwk_nm : "",
				hwk_ctt : "",
				hwk_start_date : "",
				hwk_end_date : "",
				hwk_file : "",
				filepreview : "",
				fileYN : "",
			},
			methods : {
				btnSave : function(){
					fn_Save();
				},
				
				btnClose : function(){
					hwkSelect.btnClose();
				},
				
				imagechage : function(event){
					imagechage(event.target);
				}
			}
		});
		
	}
	
	// 뷰 등록 끝--------------------
	
	
	// 강사 과목 불러오기
	function fn_searchList(){
		
		var param = {
		}
		
	   var listcallback = function(data) {
			
			divLecInfo.lec_cd = data.lecInfo.lec_cd;
			
			var tr = "<tr>";
			var td =  "<td>" + data.lecInfo.lec_nm + "</td>"
					+ "<td>" + data.lecInfo.name + "</td>"
					+ "<td>" + data.lecInfo.lec_start_date + "</td>"
					+ "<td>" + data.lecInfo.lec_end_date + "</td>"
					+ "<td>" + data.lecInfo.cls_room + "</td>"
					+ "<td>" + data.lecInfo.app_cnt + "</td>"
					+ "<td>" + data.lecInfo.capacity + "</td>";
			tr += td + "</tr>";
			
			divLecInfo.LecInfo = tr;
			
			fn_hwkList(divLecInfo.lec_cd);
			
		}
		
		callAjax("/tut/findLecInfoVue.do", "post", "json", true, param, listcallback);
		
	}
	
	
	// 등록된 과제 목록 불러오기
	function fn_hwkList(lec_cd){
		
		var param = {
			lec_cd : lec_cd
		}
		
	   var listcallback = function(data) {
			
			divHwkList.totalcnt = data.totalcnt;
			divHwkList.hwkList = data.hwkList;
		}
		
		callAjax("/tut/findHwkListVue.do", "post", "json", true, param, listcallback);	
		
	}
	
	
	// 과제 세부 내용 보기
	function fn_selectHwk(lec_cd, hwk_no){
		
		var temp = divHwkList.hwkList;
		
		for(var i = 0; i < temp.length; i++){
			if(temp[i].hwk_no == hwk_no){
				hwkSelect.hwk_no = temp[i].hwk_no;
				hwkSelect.hwk_nm_text = temp[i].hwk_nm;
				hwkSelect.hwk_ctt_text = temp[i].hwk_ctt;
				hwkSelect.hwk_start_date_text = temp[i].hwk_start_date;
				hwkSelect.hwk_end_date_text = temp[i].hwk_end_date;
				hwkSelect.hwk_file_no = temp[i].hwk_file_no;
				
				if(temp[i].hwk_file_no == 1){
					hwkSelect.hwk_file_text = "파일 없음"
				} else{
					hwkSelect.hwk_file_text = temp[i].hwk_file_nm;
				}
			}
		}
	
		gfModalPop("#hwkSelect");
		
	}
	
	
	// 제출현황 보기
	function fn_stdList(lec_cd, hwk_no){
		
		var param = {
				lec_cd : lec_cd,
				hwk_no : hwk_no
			}
			
		   var listcallback = function(data) {
			
				stdListPop.lec_cd = lec_cd;
				stdListPop.hwk_no = hwk_no;
				stdListPop.appStdList = data.appStdList;
				
 				gfModalPop("#stdListPop");
				
			}
			
			callAjax("/tut/findHwkSmListVue.do", "post", "json", true, param, listcallback);	
		
	}
	
	
	// 이름 클릭하여 제출한 과제 정보 조회
	function fn_hwkSmInfo(loginID){
		
		var param = {
				lec_cd : stdListPop.lec_cd,
				hwk_no : stdListPop.hwk_no,
				loginID : loginID
			}
			
		 var listcallback = function(data) {
			
			hwkSmInfo.sm_ctt_text = data.hwkSmInfo.sm_ctt;
			hwkSmInfo.sm_file_no = data.hwkSmInfo.sm_file_no;
			hwkSmInfo.sm_file_nm = data.hwkSmInfo.sm_file_nm;
			
			var temp = data.hwkSmInfo.sm_date.split(" ");
			hwkSmInfo.sm_date = temp[0];
			
			gfModalPop("#hwkSmInfo");
		}
			
		callAjax("/tut/findHwkSmInfo.do", "post", "json", true, param, listcallback);
		
	}
	
	
	// 제출된 과제 파일 다운로드 
	function fn_smDownload(sm_file_no){
		
		var params = ""
	    	params += "<input type='hidden' id='sm_file_no' name='sm_file_no' value='"+ sm_file_no +"' />";
	    	
	    	jQuery("<form action='/tut/smFiledownload.do' method='post'>"+params+"</form>").appendTo('body').submit().remove();
	    	
	}
	
	
	// 과제올리기 버튼
	function fn_hwk(){
		
		divHwkList.action = "I";
		
		initPop();
		
		gfModalPop("#hwkInsert");
	}
	
	
	// 과제 세부 내용에서 수정 버튼 클릭
	function fn_Update(){
		divHwkList.action = "U";
		
		initPop();
		
		gfModalPop("#hwkInsert");
	}
	
	// 초기 팝업 세팅
	function initPop(){
		
		minDate();
		
		hwkInsert.hwk_nm = "";
		hwkInsert.hwk_ctt = "";
		hwkInsert.hwk_start_date = "";
		hwkInsert.hwk_end_date = "";
		hwkInsert.hwk_file = "";
		hwkInsert.filepreview = "";
		
		if(divHwkList.action == "U"){
			var hwk_no = hwkSelect.hwk_no;
			
			hwkInsert.hwk_nm = hwkSelect.hwk_nm_text;
			hwkInsert.hwk_ctt = hwkSelect.hwk_ctt_text;
			hwkInsert.hwk_start_date = hwkSelect.hwk_start_date_text;
			hwkInsert.hwk_end_date = hwkSelect.hwk_end_date_text;
			
			// 파일 정보 불러오기
			fn_hwkFileInfo(hwkSelect.hwk_file_no);
		} 
		
	}
	
	
	// 파일 정보 불러오기
	function fn_hwkFileInfo(hwk_file_no){
		
		var param = {
			hwk_file_no : hwk_file_no	
		}
		
		var listcallback = function(data) {
			
			var insertHtml = "<a href='javascript:fn_download(" + data.hwk_file_no + ")'> ";
		    		
			if(data.hwk_extend.toLowerCase() == "jpg" ||  data.hwk_extend.toLowerCase() == "png"  ||  data.hwk_extend.toLowerCase() == "gif" ) {
				insertHtml += "<img src='" + data.hwk_logical + "' style='width: 100px; height: 100px;' />";
			} else {
				insertHtml += data.hwk_file_nm;
			}
			
			insertHtml += "</a>"; 
			
			// 파일없음. 미리보기 지우기
			if(data.hwk_file_no == 1){
				insertHtml = "";
			}
			
			hwkInsert.filepreview = insertHtml;
		
		}
		
		callAjax("/tut/hwkFileInfo.do", "post", "json", true, param, listcallback);
	}
	
	
	// 파일 다운로드
	function fn_download(hwk_file_no){
		
		var params = ""
	    	params += "<input type='hidden' id='hwk_file_no' name='hwk_file_no' value='"+ hwk_file_no +"' />";
	    	
	    	jQuery("<form action='/tut/hwkFiledownload.do' method='post'>"+params+"</form>").appendTo('body').submit().remove();
		
	}
	
	
	// 파일(이미지) 선택시 미리보기 동작
	function imagechage(target) {
		
    	var image = target;
		  
		if(image.files[0]){
			
			var imagepath =  window.URL.createObjectURL(image.files[0]);
			
			var file_info = hwkInsert.hwk_file;
			var file_info_arr = file_info.split(".");
			
			var inserhtml = "";
			
		   if(file_info_arr[file_info_arr.length - 1].toLowerCase() == "jpg" ||  file_info_arr[file_info_arr.length - 1].toLowerCase() == "png"  ||  file_info_arr[file_info_arr.length - 1].toLowerCase() == "gif" ) {
			   inserhtml = "<img src='" + imagepath + "'   style='width: 100px; height: 100px;''   />";
		   } else {
			   inserhtml = "";
		   }

		   hwkInsert.filepreview = inserhtml;
			
		}
    	
    } 
	
	
	// 저장버튼
	function fn_Save(){
		
		if(hwkInsert.hwk_file == null || hwkInsert.hwk_file == ""){
			hwkInsert.fileYN = "N";
		} else{
			hwkInsert.fileYN = "Y";
		}
		
		if(divHwkList.action == "I" || divHwkList.action == "U"){

			// 유효성 검사
			if(!fValidate()) {
				return;
			}
			
		}
		
		var frm = document.getElementById("myForm");
		frm.enctype = 'multipart/form-data';
		var fileData = new FormData(frm);
		fileData.append("action",divHwkList.action);
		fileData.append("fileYN",hwkInsert.fileYN);
		fileData.append("hwk_no",hwkSelect.hwk_no);
		fileData.append("lec_cd",divLecInfo.lec_cd);
		
		var listcallback = function(data) {
			//console.log(JSON.stringify(data));
			
			swal(data.msg);

			gfCloseModal();
			
			fn_searchList();
			
		}
		
		callAjaxFileUploadSetFormData("/tut/saveHwkFile.do", "post", "json", true, fileData, listcallback);
		
	}
	
	
	// 유효성 확인
	function fValidate() {

		var chk = checkNotEmpty(
				[
						[ "hwk_nm", "과제 제목을 입력해 주세요" ]	
					,	[ "hwk_ctt", "과정 내용을 입력해 주세요" ]	
					,	[ "hwk_start_date", "제출일을 입력해 주세요." ]
					,	[ "hwk_end_date", "마감일을 입력해 주세요" ]				
				]
		);

		if (!chk) {
			return;
		}

		return true;
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
							<span class="btn_nav bold">과제관리</span>
							<a href="../tut/projectControlvue.do" class="btn_set refresh">새로고침</a>
						</p>
						
						<br/>

						<p class="conTitle">
							<span>과제관리</span>
							<span class="fr">
								<a class="btnType blue" href="javascript:fn_hwk();" name="modal"><span>과제 올리기</span></a>
							</span>
						</p>
						
						<div id="divLecInfo" class="divLecInfo" style="overflow:auto; height:15vh;">
							<p class="subTitle"> 수업정보 </p>
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="30%">
									<col width="16%">
									<col width="12%">
									<col width="12%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">강의명</th>
										<th scope="col">강사명</th>
										<th scope="col">개강일</th>
										<th scope="col">종강일</th>
										<th scope="col">강의실</th>
										<th scope="col">현재인원</th>
										<th scope="col">정원</th>
									</tr>
								</thead>
								<tbody v-html="LecInfo"></tbody>
							</table>
						</div>
						
						<div id="divHwkList" class="divHwkList" style="overflow:auto; height:50vh;">
							<p class="subTitle"> 과제관리 </p>
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="15%">
									<col width="40%">
									<col width="15%">
									<col width="15%">
									<col width="15%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">과제번호</th>
										<th scope="col">과제이름</th>
										<th scope="col">제출일</th>
										<th scope="col">마감일</th>
										<th scope="col">제출현황</th>
									</tr>
								</thead>
								<tbody>
									<template v-if="totalcnt == 0">
										<tr>
											<td colspan="5">데이터가 존재하지 않습니다.</td>
										</tr>
									</template>
									<template v-else v-for="list in hwkList">
										<tr>
											<td>{{ list.hwk_no }}</td>
											<td>
												<a @click="fn_selectHwk(list.lec_cd, list.hwk_no)">{{ list.hwk_nm }}</a>
											</td>
											<td>{{ list.hwk_start_date }}</td>
											<td>{{ list.hwk_end_date }}</td>
											<td>
												<a @click="fn_stdList(list.lec_cd, list.hwk_no)">자세히보기</a>
											</td>
										</tr>
									</template>
								</tbody>
							</table>
						</div>
						
						

					<h3 class="hidden">풋터 영역</h3>
					<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>
	
	<!-- 모달팝업 -->
	<!-- 과제 이름 클릭 -->
	<div id="hwkSelect" class="layerPop layerType2" style="width: 800px;">
		<dl>
			<dt>
				<strong>과제</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="col">
					<caption>caption</caption>
					<colgroup>
						<col width="200px">
						<col width="300px">
						<col width="200px">
						<col width="200px">
						<col width="200px">
					</colgroup>
					
					<thead>
						<tr>
							<th scope="col">제목</th>
							<th scope="col">내용</th>
							<th scope="col">제출일</th>
							<th scope="col">마감일</th>
							<th scope="col">파일</th>
						</tr>
					</thead>

					<tbody>
						<tr>
							<td v-text="hwk_nm_text"></td>
							<td v-text="hwk_ctt_text"></td>
							<td v-text="hwk_start_date_text"></td>
							<td v-text="hwk_end_date_text"></td>
							<td v-text="hwk_file_text"></td>
						</tr>
					</tbody>
				</table>
				
				<div class="btn_areaC mt30">
					<a class="btnType blue" id="btnUpdate" name="btn" @click="btnUpdate"><span>수정</span></a>
					<a class="btnType blue" id="btnDelete" name="btn" @click="btnDelete"><span>삭제</span></a> 
					<a class="btnType gray" id="btnClose" name="btn" @click="btnClose"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a class="closePop" @click="btnClose"><span class="hidden">닫기</span></a>
	</div>
	
	
	<!-- 모달팝업 -->
	<!-- 과제 등록 및 수정 -->
	<div id="hwkInsert" class="layerPop layerType2" style="width: 800px;">
		<dl>
			<dt>
				<strong>과제</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>
					<colgroup>
						<col width="200px">
						<col width="400px">
					</colgroup>

					<tbody>
						<tr>
							<th scope="row">제목<span class="font_red">*</span></th>
							<td>
								<input type="text" id="hwk_nm" name="hwk_nm" v-model="hwk_nm" class="inputTxt p100" style="border:none;" autocomplete="off" />
							</td>
						</tr>
						<tr>
							<th scope="row">내용<span class="font_red">*</span></th>
							<td>
								<input type="text" id="hwk_ctt" name="hwk_ctt" v-model="hwk_ctt" class="inputTxt p100" style="border:none;" autocomplete="off" />
							</td>
						</tr>
						<tr>
							<th scope="row">제출일<span class="font_red">*</span></th>
							<td>
								<input type="date" id="hwk_start_date" name="hwk_start_date" v-model="hwk_start_date" class="inputTxt p100" style="font-size: 15px;"/>
							</td>
						</tr>
						<tr>
							<th scope="row">마감일<span class="font_red">*</span></th>
							<td>
								<input type="date" id="hwk_end_date" name="hwk_end_date" v-model="hwk_end_date" class="inputTxt p100" style="font-size: 15px;" />
							</td>
						</tr>
						<tr>
							<th scope="row">파일</th>
							<td>
								<input type="file" id="hwk_file" name="hwk_file" v-model="hwk_file" class="inputTxt p100"  @change="imagechage"/>
							</td>
						</tr>
						<tr>
						<th scope="row">파일 미리보기</th>
							<td>
					      		<div id="filepreview" v-html="filepreview"></div>
							</td>
						</tr>
					</tbody>
				</table>
				
				<div class="btn_areaC mt30">
					<a class="btnType blue" id="btnSave" name="btn" @click="btnSave"><span>저장</span></a> 
					<a class="btnType gray" id="btnClose" name="btn" @click="btnClose"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a class="closePop" @click="btnClose"><span class="hidden">닫기</span></a>
	</div>
	
	
	<!-- 모달팝업 -->
	<!-- 제출 명단 -->
	<div id="stdListPop" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong>제출명단</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="col">
					<caption>caption</caption>
					<colgroup>
						<col width="200px">
						<col width="200px">
						<col width="200px">
					</colgroup>
					
					<thead>
						<tr>
							<th scope="col">아이디</th>
							<th scope="col">이름</th>
							<th scope="col">제출상태</th>
						</tr>
					</thead>

					<tbody>
						<template v-for="list in appStdList">
							<tr>
								<td>{{ list.loginID }}</td>
								<td>{{ list.name }}</td>
								<td>
									<template v-if="list.smState == '제출'">
										<a @click="fn_hwkSmInfo(list.loginID)">{{ list.smState }}</a>
									</template>
									<template v-else>
										{{ list.smState }}
									</template>
								</td>
							</tr>
						</template>
					</tbody>
				</table>
				
				<div class="btn_areaC mt30">
					<a class="btnType gray" id="btnClose" name="btn" @click="btnClose"><span>닫기</span></a>
				</div>
			</dd>
		</dl>
		<a class="closePop" @click="btnClose"><span class="hidden">닫기</span></a>
	</div>
	
	<!-- 모달팝업 -->
	<!-- 제출 과제 정보 -->
	<div id="hwkSmInfo" class="layerPop layerType2" style="width: 800px;">
		<dl>
			<dt>
				<strong>과제내용</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="col">
					<caption>caption</caption>
					<colgroup>
						<col width="300px">
						<col width="300px">
						<col width="300px">
					</colgroup>
					
					<thead>
						<tr>
							<th scope="col">내용</th>
							<th scope="col">파일</th>
							<th scope="col">제출일</th>
						</tr>
					</thead>

					<tbody>
						<tr>
							<td v-text="sm_ctt_text"></td>
							<td>
								<a @click="fn_smDownload(sm_file_no)">{{ sm_file_nm }}</a>
							</td>
							<td v-text="sm_date"></td>
						</tr>
					</tbody>
				</table>
				
				<div class="btn_areaC mt30">
					<a class="btnType gray" id="btnClose" name="btn" @click="btnClose"><span>닫기</span></a>
				</div>
			</dd>
		</dl>
		<a class="closePop" @click="btnClose"><span class="hidden">닫기</span></a>
	</div>
	

</form>

<script src="${CTX_PATH}/js/view/mngins/project.js"></script>
</body>
</html>
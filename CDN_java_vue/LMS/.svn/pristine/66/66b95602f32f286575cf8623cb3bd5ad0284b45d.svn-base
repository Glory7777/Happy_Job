<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Job Korea :: 학습자료</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script src="https://unpkg.com/axios@0.12.0/dist/axios.min.js"></script>
<script src="https://unpkg.com/lodash@4.13.1/lodash.min.js"></script>
<style>
	a {cursor:pointer;}
</style>

<!-- sweet swal import -->

<script type="text/javascript">

	var divLecPlan;
	var filepop;
	
	$(function() {
		
		// 뷰등록
		initVue();
		
		// 주차 목록 조회
		fn_searchList();
		
	});
	
	// 뷰 등록 -------------
	function initVue(){
		
		// 주차 목록 영역
		divLecPlan = new Vue({
			el : "#divLecPlan",
			data : {
				totalcnt : 0,
				weeklyList : [],
				
				lec_cd : 0,
				weekly_no : ""
			},
			methods : {
				fn_filePop : function(lec_cd, weekly_no){
					fn_filePop(lec_cd, weekly_no);
				}
			}
		});
		
		
		// 팝업창 영역 
		filepop = new Vue({
			el : "#filepop",
			data : {
				weekly : "",
				lec_file_upload_date : "",
				lec_file_ctt : "",
				file_info : "",
				filepreview : "",
				
				action : "",
				lec_file : 0,
				fileYN : "",
				
				showBtn1 : true,
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
	// 뷰 등록 끝 -------------
	
	// 주차 목록 리스트
	function fn_searchList(){
		
		var param = {
		}
		
	   var listcallback = function(returndata) {
			
			divLecPlan.totalcnt = returndata.totalcnt;
			divLecPlan.weeklyList = returndata.weeklyList;
			
		}
		
		callAjax("/tut/lmFindWeeklyListVue.do", "post", "json", true, param, listcallback);
	}
	
	
	// 파일 등록 버튼 클릭
	function fn_filePop(lec_cd, weekly_no){

		divLecPlan.lec_cd = lec_cd;
		divLecPlan.weekly_no = weekly_no;

		var param = {
				lec_cd : lec_cd,
				weekly_no : weekly_no
			}
			
		var listcallback = function(data){
			
			console.log(data);

			if(data.lec_file_upload_date == null){
				data.lec_file_upload_date = "";
			}
			
			filepop.weekly = divLecPlan.weekly_no;
			filepop.lec_file_upload_date = data.lec_file_upload_date;
			filepop.lec_file_ctt = data.lec_file_ctt;
			filepop.lec_file = data.lec_file_no;
			filepop.file_info = "";
			
			var file_extention = data.lec_file_extend;
			
			var insertHtml ="";
			
			if(data.lec_file_nm == "" || data.lec_file_nm == null) {
				insertHtml = "";
        	} else {
        		insertHtml = "<a href='javascript:fn_download()'> "
        		
         	    if(data.lec_file_extend.toLowerCase() == "jpg" ||  data.lec_file_extend.toLowerCase() == "png"  ||  data.lec_file_extend.toLowerCase() == "gif" ) {
         	    	insertHtml += "<img src='" + data.lec_file_logical + "'   style='width: 100px; height: 100px;''   />";
   		        } else {
   		        	insertHtml += data.lec_file_nm;
   		        }        		
       		    
        		insertHtml += "</a>"; 
        	}
			
			filepop.filepreview = insertHtml;
			
			// lec_file_no가 0이면 파일이 없고
			if(data.lec_file_no == 0){
				filepop.showBtn1 = true;
				filepop.showBtn2 = false;
			} else{
				filepop.showBtn1 = false;
				filepop.showBtn2 = true;
			}

			gfModalPop("#filepop");
			
		}
		
		callAjax("/tut/findFileInfo.do", "post", "json", true, param, listcallback);
			
	}
	
	
	// 파일 다운로드
	function fn_download(){
		
		var params = ""
    	params += "<input type='hidden' id='lec_file_no' name='lec_file_no' value='"+ filepop.lec_file +"' />";
    	
    	jQuery("<form action='/tut/lecFiledownload.do' method='post'>"+params+"</form>").appendTo('body').submit().remove();
		
	}
	
	
	// 파일(이미지) 선택시 미리보기 동작
	function imagechage(event) {
    	
		var image = event;
		  
		if(image.files[0]){
			
			var imagepath =  window.URL.createObjectURL(image.files[0]);
			
			var file_info = filepop.file_info;
			var file_info_arr = file_info.split(".");
			
			var insertHtml = "";
			
		   if(file_info_arr[file_info_arr.length - 1].toLowerCase() == "jpg" ||  file_info_arr[file_info_arr.length - 1].toLowerCase() == "png"  ||  file_info_arr[file_info_arr.length - 1].toLowerCase() == "gif" ) {
			   insertHtml = "<img src='" + imagepath + "'   style='width: 100px; height: 100px;''   />";
		   } else {
			   insertHtml = "";
		   }
			
		   filepop.filepreview = insertHtml;
			
		}
    	
    }
	
	
	// 파일 저장(등록, 수정, 삭제)
	function fn_Save(){
		
		if(filepop.action == "I"){

			// 유효성 검사
			if(!fValidatefile()) {
				return;
			}
			
		}
		
		// 파일 입력 유무
		if(filepop.file_info == "" || filepop.file_info == null){
			filepop.fileYN = "N";
		} else{
			filepop.fileYN = "Y";
		}
		
		var frm = document.getElementById("myForm");
		frm.enctype = 'multipart/form-data';
		var fileData = new FormData(frm);
		
		// 추가 데이터 넣기
		fileData.append("lec_cd", divLecPlan.lec_cd);
		fileData.append("weekly_no", filepop.weekly);
		fileData.append("action", filepop.action);
		fileData.append("lec_file", filepop.lec_file);
		fileData.append("fileYN", filepop.fileYN);
		
		var listcallback = function(data) {
			console.log(JSON.stringify(data));
			
			swal(data.msg);

			gfCloseModal();
			
			fn_searchList();
		}
		
		callAjaxFileUploadSetFormData("/tut/saveFile.do", "post", "json", true, fileData, listcallback);
	}
	
	
	// 유효성 검사
	/** 저장 validation */
	function fValidatefile() {

		var chk = checkNotEmpty(
				[
						[ "lec_file_ctt", "자료내용을 입력해 주세요." ]
					,	[ "file_info", "파일을 선택해 주세요." ]				]
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
							<span class="btn_nav bold">학습 지원</span> 
							<span class="btn_nav bold">학습 자료</span>
							<a href="../tut/b_learningMaterialsvue.do" class="btn_set refresh">새로고침</a>
						</p>
						
						<br/>

						<p class="conTitle">
							<span>학습자료</span> 
							<span class="fr" id="lec_nm">
							</span>
						</p>
						
						<div id="divLecPlan" class="divLecPlan" style="overflow:auto; height:50vh;">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="20%">
									<col width="40%">
									<col width="25%">
									<col width="10%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">주차수</th>
										<th scope="col">학습 목표</th>
										<th scope="col">파일 등록일</th>
										<th scope="col">등록/수정</th>
									</tr>
								</thead>
								<tbody>
									<template v-if="totalcnt == 0">
										<tr>
											<td colspan="4">주차 계획이 존재하지 않습니다.</td>
										</tr>
									</template>
									<template v-else v-for="list in weeklyList">
										<tr>
											<td>{{ list.weekly_no }}</td>
											<td>{{ list.week_goal }}</td>
											<td>
												<template v-if="list.lec_file_upload_date == 'temp'">
													<span>파일 없음</span>
												</template>
												<template v-else>
													{{ list.lec_file_upload_date.substr(0,10) }}
												</template>
											</td>
											<td>
												<a @click="fn_filePop(list.lec_cd, list.weekly_no)" class="btnType blue" id="fileBtn" name="fileBtn"><span>등록/수정</span></a> 
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
	<div id="filepop" class="layerPop layerType2" style="width: 800px;">
		<dl>
			<dt>
				<strong>학습자료</strong>
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
							<th scope="row">주차수</th>
							<td v-text="weekly"></td>
							<th scope="row">등록일자</th>
							<td v-text="lec_file_upload_date"></td>
						</tr>
						<tr>
							<th scope="row">자료내용</th>
							<td colspan="3">
								<input type="text" id="lec_file_ctt" name="lec_file_ctt" v-model="lec_file_ctt" class="inputTxt p100" style="border:none;" autocomplete="off" />
							</td>
						</tr>
						<tr>
							<th scope="row">첨부파일</th>
							<td>
								<input type="file" id=file_info name="file_info" v-model="file_info" class="inputTxt p100" @change="imagechage"/>
							</td>
							<td colspan="2">
							      <div v-html="filepreview"></div>
							 </td>
						</tr>
					</tbody>
				</table>
				
				<div class="btn_areaC mt30">
					<a class="btnType blue" id="btnSave" name="btn" @click="btnSave" v-show="showBtn1"><span>저장</span></a> 
					<a class="btnType blue" id="btnUpdate" name="btn" @click="btnUpdate" v-show="showBtn2"><span>수정</span></a> 
					<a class="btnType blue" id="btnDelete" name="btn" @click="btnDelete" v-show="showBtn2"><span>삭제</span></a> 
					<a class="btnType gray" id="btnClose" name="btn" @click="btnClose"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a class="closePop" @click="btnClose"><span class="hidden">닫기</span></a>
	</div>

</form>

<script src="${CTX_PATH}/js/view/mngadm/mngadm.js"></script>
</body>
</html>
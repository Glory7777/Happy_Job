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

<!-- sweet swal import -->

<script type="text/javascript">
	
	$(function() {
		
		// 주차 목록 조회
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
					$("#action").val("I");
					fn_Save();
					break;
				case 'btnUpdate' :
					$("#action").val("U");
					fn_Save();
					break;
				case 'btnDelete' :
					$("#action").val("D");
					fn_Save();
					break;
				case 'btnClose' :
					gfCloseModal();
					break;
			}
		});
	}
	
	
	// 주차 목록 리스트
	function fn_searchList(){
		
		var param = {
		}
		
	   var listcallback = function(returndata) {
			
			$("#weeklyList").empty().append(returndata);
			
		}
		
		callAjax("/tut/lmFindWeeklyList.do", "post", "text", true, param, listcallback);
	}
	
	
	// 파일 등록 버튼 클릭
	function fn_filePop(lec_cd, weekly_no){
		
		$("#lec_cd").val(lec_cd);
		$("#weekly_no").val(weekly_no);
		
		var param = {
				lec_cd : lec_cd,
				weekly_no : weekly_no
			}
			
		var listcallback = function(data){
			
			if(data.lec_file_upload_date == null){
				data.lec_file_upload_date = "";
			}
			
			$("#weekly").text(weekly_no);
			$("#lec_file_upload_date").text(data.lec_file_upload_date);
			$("#lec_file_ctt").val(data.lec_file_ctt);
			$("#file_info").val("");
			
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
			
			$("#filepreview").empty().append(insertHtml);
			
			// lec_file_no가 0이면 파일이 없고
			if(data.lec_file_no == 0){
				$("#btnSave").show();
				$("#btnUpdate").hide();
				$("#btnDelete").hide();
			} else{
				$("#lec_file").val(data.lec_file_no);
				$("#btnSave").hide();
				$("#btnUpdate").show();
				$("#btnDelete").show();
			}
			
			gfModalPop("#filepop");
			
		}
		
		callAjax("/tut/findFileInfo.do", "post", "json", true, param, listcallback);
			
	}
	
	
	// 파일 다운로드
	function fn_download(){
		
		var params = ""
    	params += "<input type='hidden' id='lec_file_no' name='lec_file_no' value='"+ $("#lec_file").val() +"' />";
    	
    	jQuery("<form action='/tut/lecFiledownload.do' method='post'>"+params+"</form>").appendTo('body').submit().remove();
		
	}
	
	
	// 파일(이미지) 선택시 미리보기 동작
	function imagechage(event) {
    	
    	var image = event.target;
		  
		if(image.files[0]){
			
			var imagepath =  window.URL.createObjectURL(image.files[0])
			
			var file_info = $("#file_info").val();
			var file_info_arr = file_info.split(".");
			
			var inserhtml = "";
			
		   if(file_info_arr[file_info_arr.length - 1].toLowerCase() == "jpg" ||  file_info_arr[file_info_arr.length - 1].toLowerCase() == "png"  ||  file_info_arr[file_info_arr.length - 1].toLowerCase() == "gif" ) {
			   inserhtml = "<img src='" + imagepath + "'   style='width: 100px; height: 100px;''   />";
		   } else {
			   inserhtml = "";
		   }
			
			$("#filepreview").empty().append( inserhtml );
			
		}
    	
    }
	
	
	// 파일 저장(등록, 수정, 삭제)
	function fn_Save(){
		
		if($("#action").val() == "I"){

			// 유효성 검사
			if(!fValidatefile()) {
				return;
			}
			
		}
		
		var frm = document.getElementById("myForm");
		frm.enctype = 'multipart/form-data';
		var fileData = new FormData(frm);
		
		var listcallback = function(data) {
			console.log(JSON.stringify(data));
			
			swal(data.msg);

			gfCloseModal();
			
			fn_searchList();
			
		}
		
		if($("#file_info").val() == "" || $("#file_info").val() == null){
			$("#fileYN").val("N");
		} else{
			$("#fileYN").val("Y");
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
	<input type="hidden" id="lec_cd" name="lec_cd" value="">
	<input type="hidden" id="weekly_no" name="weekly_no" value="">
	<input type="hidden" id="action" name="action" value="">
	<input type="hidden" id="lec_file" name="lec_file" value="">
	<input type="hidden" id="fileYN" name="fileYN" value="">
	
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
							<a href="../tut/b_learningMaterials.do" class="btn_set refresh">새로고침</a>
						</p>
						
						<br/>

						<p class="conTitle">
							<span>학습자료</span> 
							<span class="fr" id="lec_nm">
							</span>
						</p>
						
						<div class="divLecPlan" style="overflow:auto; height:50vh;">
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
								<tbody id="weeklyList"></tbody>
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
							<td id="weekly"></td>
							<th scope="row">등록일자</th>
							<td id="lec_file_upload_date"></td>
						</tr>
						<tr>
							<th scope="row">자료내용</th>
							<td colspan="3">
								<input type="text" id="lec_file_ctt" name="lec_file_ctt" class="inputTxt p100" style="border:none;" autocomplete="off" />
							</td>
						</tr>
						<tr>
							<th scope="row">첨부파일</th>
							<td>
								<input type="file" id=file_info name="file_info" class="inputTxt p100" onChange="javascript:imagechage(event)"/>
							</td>
							<td colspan="2">
							      <div id="filepreview"></div>
							 </td>
						</tr>
					</tbody>
				</table>
				
				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSave" name="btn"><span>저장</span></a> 
					<a href="" class="btnType blue" id="btnUpdate" name="btn"><span>수정</span></a> 
					<a href="" class="btnType blue" id="btnDelete" name="btn"><span>삭제</span></a> 
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
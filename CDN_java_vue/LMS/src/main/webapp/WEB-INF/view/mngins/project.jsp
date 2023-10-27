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
					fn_Save();
					break;
				case 'btnUpdate' :
					fn_Update();
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
	
	
	// 강사 과목 불러오기
	function fn_searchList(){
		
		var param = {
		}
		
	   var listcallback = function(returndata) {
			
			$("#LecInfo").empty().append(returndata);
			
			fn_hwkList($("#lec_cd").val());
			
		}
		
		callAjax("/tut/findLecInfo.do", "post", "text", true, param, listcallback);
		
	}
	
	
	// 등록된 과제 목록 불러오기
	function fn_hwkList(lec_cd){
		
		var param = {
			lec_cd : lec_cd
		}
		
	   var listcallback = function(returndata) {
			
			$("#HwkList").empty().append(returndata);
			
		}
		
		callAjax("/tut/findHwkList.do", "post", "text", true, param, listcallback);	
		
	}
	
	
	// 과제 세부 내용 보기
	function fn_selectHwk(lec_cd, hwk_no){
		
		// hwkList : hwkList.jsp에서 json 파일 이용하여 만든 객체
		for(let i = 0; i < hwkList.length; i++){
			if(hwkList[i].hwk_no == hwk_no){
				$("#hwk_nm_text").text(hwkList[i].hwk_nm);
				$("#hwk_ctt_text").text(hwkList[i].hwk_ctt);
				$("#hwk_start_date_text").text(hwkList[i].hwk_start_date);
				$("#hwk_end_date_text").text(hwkList[i].hwk_end_date);
				if(hwkList[i].hwk_file_no == 1){
					$("#hwk_file_text").text("파일없음");
				} else{
					$("#hwk_file_text").text(hwkList[i].hwk_file_nm);
				}
				$("#hwk_no").val(hwkList[i].hwk_no);
				$("#lec_cd").val(hwkList[i].lec_cd);
			}
		}
	
		gfModalPop("#hwkSelect");
		
	}
	
	
	// 제출현황 보기
	function fn_stdList(lec_cd, hwk_no){
		
		$("#lec_cd").val(lec_cd);
		$("#hwk_no").val(hwk_no);
		
		var param = {
				lec_cd : lec_cd,
				hwk_no : hwk_no
			}
			
		   var listcallback = function(returndata) {
				
				$("#stdList").empty().append(returndata);
				
				gfModalPop("#stdListPop");
				
			}
			
			callAjax("/tut/findHwkSmList.do", "post", "text", true, param, listcallback);	
		
	}
	
	
	// 이름 클릭하여 제출한 과제 정보 조회
	function fn_hwkSmInfo(loginID){
		
		var param = {
				lec_cd : $("#lec_cd").val(),
				hwk_no : $("#hwk_no").val(),
				loginID : loginID
			}
			
		 var listcallback = function(data) {
			
			console.log(data);
	
			$("#sm_ctt_text").text(data.hwkSmInfo.sm_ctt);
			$("#sm_date").text(data.hwkSmInfo.sm_date);
			
        	// 파일
			var insertHtml = "<a href='javascript:fn_smDownload(" + data.hwkSmInfo.sm_file_no + ")'> " + data.hwkSmInfo.sm_file_nm + "</a>";
			
			$("#sm_file_no").empty().append(insertHtml);
			
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
		
		$("#action").val("I");
		$("#hwk_no").val("");
		
		initPop();
		
		gfModalPop("#hwkInsert");
	}
	
	
	// 과제 세부 내용에서 수정 버튼 클릭
	function fn_Update(){
		$("#action").val("U");
		
		initPop();
		
		gfModalPop("#hwkInsert");
	}
	
	// 초기 팝업 세팅
	function initPop(){
		
		minDate();
		
		$("#filepreview").empty();
		$("#hwk_nm").val("");
		$("#hwk_ctt").val("");
		$("#hwk_start_date").val("");
		$("#hwk_end_date").val("");
		$("#hwk_file").val("");
		
		if($("#action").val() == "U"){
			
			let hwk_no = $("#hwk_no").val();
			
			for(let i = 0; i < hwkList.length; i++){
				if(hwkList[i].hwk_no == hwk_no){
					$("#hwk_nm").val(hwkList[i].hwk_nm);
					$("#hwk_ctt").val(hwkList[i].hwk_ctt);
					$("#hwk_start_date").val(hwkList[i].hwk_start_date);
					$("#hwk_end_date").val(hwkList[i].hwk_end_date);
					
					// 파일 정보 불러오기
					fn_hwkFileInfo(hwkList[i].hwk_file_no);
				}
			}
		} 
		
	}
	
	
	// 파일 정보 불러오기
	function fn_hwkFileInfo(hwk_file_no){
		
		var param = {
			hwk_file_no : hwk_file_no	
		}
		
	   var listcallback = function(data) {
			
			console.log(data);
			
			var insertHtml ="";
			
			if(data.hwk_file_nm == "" || data.hwk_file_nm == null || data.hwk_file_nm == 'temp') {
				insertHtml = "";
        	} else {
        		insertHtml = "<a href='javascript:fn_download(" + data.hwk_file_no + ")'> "
        		
         	    if(data.hwk_extend.toLowerCase() == "jpg" ||  data.hwk_extend.toLowerCase() == "png"  ||  data.hwk_extend.toLowerCase() == "gif" ) {
         	    	insertHtml += "<img src='" + data.hwk_logical + "'   style='width: 100px; height: 100px;''   />";
   		        } else {
   		        	insertHtml += data.hwk_file_nm;
   		        }        		
       		    
        		insertHtml += "</a>"; 
        	}
			
			$("#filepreview").empty().append(insertHtml);
			
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
	function imagechage(event) {
    	
    	var image = event.target;
		  
		if(image.files[0]){
			
			var imagepath =  window.URL.createObjectURL(image.files[0])
			
			var file_info = $("#hwk_file").val();
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
	
	
	// 저장버튼
	function fn_Save(){
		
		if($("#hwk_file").val() == null || $("#hwk_file").val() == ""){
			$("#fileYN").val("N");
		} else{
			$("#fileYN").val("Y");
		}
		
		if($("#action").val() == "I" || $("#action").val() == "U"){

			// 유효성 검사
			if(!fValidate()) {
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
	<input type="hidden" id="action" name="action" value="">
	<input type="hidden" id="fileYN" name="fileYN" value="">
	<input type="hidden" id="hwk_no" name="hwk_no" value="">
	<input type="hidden" id="lec_cd" name="lec_cd" value="">
	
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
							<a href="../tut/projectControl.do" class="btn_set refresh">새로고침</a>
						</p>
						
						<br/>

						<p class="conTitle">
							<span>과제관리</span>
							<span class="fr">
								<a class="btnType blue" href="javascript:fn_hwk();" name="modal"><span>과제 올리기</span></a>
							</span>
						</p>
						
						<div class="divLecInfo" style="overflow:auto; height:15vh;">
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
								<tbody id="LecInfo"></tbody>
							</table>
						</div>
						
						<div class="divHwkList" style="overflow:auto; height:50vh;">
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
								<tbody id="HwkList"></tbody>
							</table>
						</div>
						
						

					<h3 class="hidden">풋터 영역</h3>
					<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>
	
	<!-- 모달팝업 -->
	<!-- 제출된 과제 클릭 -->
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
							<td id="hwk_nm_text"></td>
							<td id="hwk_ctt_text"></td>
							<td id="hwk_start_date_text"></td>
							<td id="hwk_end_date_text"></td>
							<td id="hwk_file_text"></td>
						</tr>
					</tbody>
				</table>
				
				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnUpdate" name="btn"><span>수정</span></a>
					<a href="" class="btnType blue" id="btnDelete" name="btn"><span>삭제</span></a> 
					<a href="" class="btnType gray" id="btnClose" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	
	
	<!-- 모달팝업 -->
	<!-- 제출 등록 및 수정 -->
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
								<input type="text" id="hwk_nm" name="hwk_nm" class="inputTxt p100" style="border:none;" autocomplete="off" />
							</td>
						</tr>
						<tr>
							<th scope="row">내용<span class="font_red">*</span></th>
							<td>
								<input type="text" id="hwk_ctt" name="hwk_ctt" class="inputTxt p100" style="border:none;" autocomplete="off" />
							</td>
						</tr>
						<tr>
							<th scope="row">제출일<span class="font_red">*</span></th>
							<td>
								<input type="date" id="hwk_start_date" name="hwk_start_date" class="inputTxt p100" style="font-size: 15px;"/>
							</td>
						</tr>
						<tr>
							<th scope="row">마감일<span class="font_red">*</span></th>
							<td>
								<input type="date" id="hwk_end_date" name="hwk_end_date" class="inputTxt p100" style="font-size: 15px;" />
							</td>
						</tr>
						<tr>
							<th scope="row">파일</th>
							<td>
								<input type="file" id="hwk_file" name="hwk_file" class="inputTxt p100"  onChange="javascript:imagechage(event)"/>
							</td>
						</tr>
						<tr>
						<th scope="row">파일 미리보기</th>
							<td>
					      		<div id="filepreview"></div>
							</td>
						</tr>
					</tbody>
				</table>
				
				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSave" name="btn"><span>저장</span></a> 
					<a href="" class="btnType gray" id="btnClose" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
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

					<tbody id="stdList"></tbody>
				</table>
				
				<div class="btn_areaC mt30">
					<a href="" class="btnType gray" id="btnClose" name="btn"><span>닫기</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
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
							<td id="sm_ctt_text"></td>
							<td id="sm_file_no"></td>
							<td id="sm_date"></td>
						</tr>
					</tbody>
				</table>
				
				<div class="btn_areaC mt30">
					<a href="" class="btnType gray" id="btnClose" name="btn"><span>닫기</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	

</form>

<script src="${CTX_PATH}/js/view/mngins/project.js"></script>
</body>
</html>
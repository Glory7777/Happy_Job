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
				case 'btnClose' :
					gfCloseModal();
					break;
			}
		});
	}
	
	
	// 주차 목록 조회
	function fn_searchList(){
		
		var param = {
		}
		
	   var listcallback = function(returndata) {
			
			$("#weeklyList").empty().append(returndata);
			
		}
		
		callAjax("/std/lmFindWeeklyList.do", "post", "text", true, param, listcallback);
	}
	
	
	// 주차 클릭
	function fn_selectWeek(lec_file_no, weekly_no){
		
		$("#weekly").text(weekly_no);
		
		var param = {
			lec_file_no : lec_file_no
		}
		
	   var listcallback = function(returndata) {
			
			initPop(returndata);

			gfModalPop("#filepop");
			
		}
		
		callAjax("/std/selectWeek.do", "post", "json", true, param, listcallback);

		
	}
	
	
	// 팝업창 세팅
	function initPop(data){
		
		console.log(data);
		
		if(data.lec_file_no == 1){
			$("#lec_file_upload_date").text("");
			$("#lec_file_ctt").text("");
			$("#lec_file_info").val("");
			$("#filepreview").val("");
		} else {
			$("#lec_file_upload_date").text(data.lec_file_upload_date);
			$("#lec_file_ctt").text(data.lec_file_ctt);
			
			var file_extention = data.lec_file_extend;
			var insertHtml ="";
			
			if(data.lec_file_nm == "" || data.lec_file_nm == null) {
				insertHtml = "";
        	} else {
        		insertHtml = "<a href='javascript:fn_download(" + data.lec_file_no + ")'> "
        		
         	    if(data.lec_file_extend.toLowerCase() == "jpg" ||  data.lec_file_extend.toLowerCase() == "png"  ||  data.lec_file_extend.toLowerCase() == "gif" ) {
         	    	insertHtml += "<img src='" + data.lec_file_logical + "'   style='width: 100px; height: 100px;''   />";
   		        } else {
   		        	insertHtml += data.lec_file_nm;
   		        }        		
       		    
        		insertHtml += "</a>"; 
        	}
			
			$("#filepreview").empty().append(insertHtml);
			
		}
	}
	
	
	// 파일 다운로드 수정
	function fn_download(lec_file_no){
		
		var params = ""
    	params += "<input type='hidden' id='lec_file_no' name='lec_file_no' value='"+ lec_file_no +"' />";
    	
    	jQuery("<form action='/std/lecFiledownload.do' method='post'>"+params+"</form>").appendTo('body').submit().remove();
		
	}
	
</script>

</head>
<body>
<form id="myForm" action=""  method="">
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
							<span class="btn_nav bold">학습 지원</span> 
							<span class="btn_nav bold">학습 자료</span>
							<a href="../std/a_learningMaterials.do" class="btn_set refresh">새로고침</a>
						</p>
						
						<br/>

						<p class="conTitle">
							<span id="lec_nm">학습자료</span> 
						</p>
						
						<div class="divLecPlan" style="overflow:auto; height:50vh;">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="20%">
									<col width="40%">
									<col width="30%">
								</colgroup>	
	
								<thead>
									<tr>
										<th scope="col">등록번호</th>
										<th scope="col">주차수</th>
										<th scope="col">파일 등록일자</th>
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
				<strong>자료내용</strong>
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
							<td colspan="3" id="lec_file_ctt"></td>
						</tr>
						<tr>
							<th scope="row">첨부파일</th>
							<td colspan="3">
							      <div id="filepreview"></div>
							 </td>
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

<script src="${CTX_PATH}/js/view/mngadm/mngadm.js"></script>
</body>
</html>
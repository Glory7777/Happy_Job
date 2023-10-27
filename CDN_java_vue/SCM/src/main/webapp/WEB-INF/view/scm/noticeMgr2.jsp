<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>공지사항</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->
              
<script type="text/javascript">
	// 페이징 설정
	var pageSize = 10;
	var pageBlockSize = 5;
	
	$(function() {
		
		comcombo("delCD", "searchdel", "all", "");
		
		// 공지사항 조회
		fn_serachlist();
		
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
				case 'btnSavefile' :	
					fn_Savefile();
					break;					
				case 'btnDelete' :
					fn_Delete();
					break;
				case 'btnClosefile' :	
				case 'btnClose' :
					gfCloseModal();
					if($("#action").val() == "I") {
	    				fn_serachlist();
	    			} else if($("#action").val() == "U") {
	    				fn_serachlist($("#currentPagenotice").val());
	    			} else if($("#action").val() == "D") {
	    				fn_serachlist();
	    			}
					break;
				case 'btnDeletefile' :
					fn_Deletefile();
					break;
					
			}
		});
	}

    function fn_serachlist(currentPage) {
    	
    	var currentPage = currentPage || 1;
    	
    	var param = {
    			pageSize : pageSize,
    			currntPage : currentPage,
    			searchsel : $("#searchsel").val(),
    			searchtext : $("#searchtext").val(),
    			searchdel : $("#searchdel").val()
    	}
    	
       var listcallback = function(returndata) {
    		console.log(returndata);
    		
    		$("#listnotice").empty().append(returndata);
    		
    		console.log($("#totalcnt").val());
    		
    		var totalcnt = $("#totalcnt").val();
    		
    		var paginationHtml = getPaginationHtml(currentPage, totalcnt, pageSize, pageBlockSize, 'fn_serachlist');
    		console.log("paginationHtml : " + paginationHtml);
    		//swal(paginationHtml);
    		$("#noticePagination").empty().append( paginationHtml );
    		
    		// 현재 페이지 설정
    		$("#currentPagenotice").val(currentPage);
    		
    	}
    	
    	callAjax("/scm/listnotice.do", "post", "text", true, param, listcallback);
    	
    }

    function fn_openpopup() {
    	
    	fn_popupint();
    	
		// 모달 팝업
		gfModalPop("#noticepop");
		
		
		
    }
    
    function fn_selectnotice(notice_cd) {
    	
    	var param = {
    			notice_cd : notice_cd
    	}
    	
    	var selectcallback = function(returndata) {
    		console.log(JSON.stringify(returndata));  
    		fn_popupint(returndata.sectinfo);
    		
    		gfModalPop("#noticepop");
    	}
    	
    	callAjax("/scm/noticeselect.do", "post", "json", true, param, selectcallback);
    	
    }
    
    function fn_Delete() {
    	$("#action").val("D"); 
    	fn_Save();
    }
    
    function fn_popupint(data) {
    	
    	if(data == null || data == undefined || data == "") {
        	$("#notice_title").val("");
        	$("#notice_content").val("");    	
        	$("#selnoticecd").val("");
        	$("#action").val("I");  
        	
        	$("#regdate").text("");
        	$("#moddate").text("");
        	
        	$("#btnDelete").hide();   		
    	}  else {
        	$("#notice_title").val(data.notice_title);
        	$("#notice_content").val(data.notice_content);    	
        	$("#action").val("U");  
        	
        	$("#regdate").text(data.notice_reg_date);
        	$("#moddate").text(data.notice_update_date);
        	
        	
        	$("#selnoticecd").val(data.notice_cd);
        	
        	$("#btnDelete").show();
    	}   	

    }
    
    
    function fn_Save() {
    	
    	if(!fValidate()) {
    		return;
    	}
    	
    	var param = {
    			action : $("#action").val(),
    			notice_title : $("#notice_title").val(),
    			notice_content : $("#notice_content").val(),
    			notice_cd : $("#selnoticecd").val()
    	}
    	
    	var savecallback = function(returnvalue) {
    		console.log(JSON.stringify(returnvalue));
    		
    		if(returnvalue.result == "SUCCESS") {
    			alert("저장 되었습니다.");
    			gfCloseModal();
    			
    			if($("#action").val() == "I") {
    				fn_serachlist();
    			} else if($("#action").val() == "U") {
    				fn_serachlist($("#currentPagenotice").val());
    			} else if($("#action").val() == "D") {
    				fn_serachlist();
    			}
    		}
    		
    	}
    	
    	callAjax("/scm/noticesave.do", "post", "json", true, param, savecallback);
    }
    
	/** 저장 validation */
	function fValidate() {

		var chk = checkNotEmpty(
				[
						[ "notice_title", "제목를 입력해 주세요." ]
					,	[ "notice_content", "내용을 입력해 주세요" ]				]
		);

		if (!chk) {
			return;
		}

		return true;
	}
	
    /////////////////////////////// 파일 처리 ////////////////////////////////////////
    function fn_openpopupfile() {
    	
    	fn_popupintfile();
    	
    	gfModalPop("#noticepopfile");
    }
    
    function imagechage(event) {
    	
    	var image = event.target;
		  
		if(image.files[0]){
			
			var imagepath =  window.URL.createObjectURL(image.files[0])
		    // alert(window.URL.createObjectURL(image.files[0])); 
			
			//alert($("#selfile").val());   // C:\fakepath\해피잡.jpg
			var selfile = $("#selfile").val();
			var selfilearr = selfile.split(".");
			// alert(selfilearr[1]);   확장자
			
			var inserhtml = "";
			
		   if(selfilearr[1].toLowerCase() == "jpg" ||  selfilearr[1].toLowerCase() == "png"  ||  selfilearr[1].toLowerCase() == "gif" ) {
			   inserhtml = "<img src='" + imagepath + "'   style='width: 100px; height: 100px;''   />";
		   } else {
			   inserhtml = "";
		   }
		   
			// alert(inserhtml);
			
			$("#filepreview").empty().append( inserhtml );
			
		}
    	
    }
    
   function fn_popupintfile(data) {
    	
    	if(data == null || data == undefined || data == "") {
        	$("#notice_titlefile").val("");
        	$("#notice_contentfile").val("");    	
        	$("#selnoticecd").val("");
        	$("#action").val("I");  
        	
        	$("#regdatefile").text("");
        	$("#moddatefile").text("");
        	
        	$("#selfile").val("");
        	$("#filepreview").empty();
        	
        	$("#btnDeletefile").hide();   		
    	}  else {
    		//  {"sectinfo":{"notice_cd":"37"
    		//	  ,"notice_title":"filete test 1"
    		//	  ,"notice_content":"filete test 1"
    		//	  ,"notice_reg_date":"2023-09-15"
    		//	  ,"notice_update_date":""
    		//	  ,"notice_read_cnt":7
    		//	  ,"notice_delete_yn":"N"
    		//	  ,"loginid":"(주)체인메이커"
    		//	  ,"file_cd":"1"
    		//	  ,"logic_path":"/serverfile\\notice\\해피잡.jpg"
    		//	  ,"physic_path":"x:\\FileRepository\\notice\\해피잡.jpg"
    		//	  ,"file_nm":"해피잡.jpg"
    		//	  ,"file_extention":"jpg"
    		//	  ,"file_size":37658}}
    		
        	$("#notice_titlefile").val(data.notice_title);
        	$("#notice_contentfile").val(data.notice_content);    	
        	$("#action").val("U");  
        	
        	$("#regdatefile").text(data.notice_reg_date);
        	$("#moddatefile").text(data.notice_update_date);
        	
        	$("#selfile").val("");
        	
        	$("#file_cd").val(data.file_cd);
        	$("#selnoticecd").val(data.notice_cd);
        	
        	var file_extention = data.file_extention;
        	var inserhtml ="";
        	
        	if(data.file_nm == "" || data.file_nm == null) {
        		inserhtml = "";
        	} else {
        		    inserhtml = "<a href='javascript:fn_download()'> "
        		
           	         if(file_extention.toLowerCase() == "jpg" ||  file_extention.toLowerCase() == "png"  ||  file_extention.toLowerCase() == "gif" ) {
    			        inserhtml += "<img src='" + data.logic_path + "'   style='width: 100px; height: 100px;''   />";
    		         } else {
    			       inserhtml += data.file_nm;
    		         }        		
        		    
        		    inserhtml += "</a>"; 
        	}
        	// 
        	$("#filepreview").empty().append(inserhtml);
        	

        	
        	$("#btnDeletefile").show();
    	}   	

    }
   
   function fn_Savefile() {
	   
   	if(!fValidatefile()) {
		return;
	}
	
   	var frm = document.getElementById("myForm");
	frm.enctype = 'multipart/form-data';
	var fileData = new FormData(frm);
	
	var savecallback = function(returnvalue) {
		console.log(JSON.stringify(returnvalue));
		
		if(returnvalue.result == "SUCCESS") {
			alert("저장 되었습니다.");
			gfCloseModal();
			
			if($("#action").val() == "I") {
				fn_serachlist();
			} else if($("#action").val() == "U") {
				fn_serachlist($("#currentPagenotice").val());
			} else if($("#action").val() == "D") {
				fn_serachlist();
			}
		}
		
	}
	
	callAjaxFileUploadSetFormData("/scm/noticesavefile.do", "post", "json", true, fileData, savecallback);	   
	   
   }
   
   
	/** 저장 validation */
	function fValidatefile() {

		var chk = checkNotEmpty(
				[
						[ "notice_titlefile", "제목를 입력해 주세요." ]
					,	[ "notice_contentfile", "내용을 입력해 주세요" ]				]
		);

		if (!chk) {
			return;
		}

		return true;
	}
	
    function fn_selectnoticedile(notice_cd) {
    	
    	var param = {
    			notice_cd : notice_cd
    	}
    	
    	var selectcallback = function(returndata) {
    		console.log(JSON.stringify(returndata));  
    		fn_popupintfile(returndata.sectinfo);
    		
    		gfModalPop("#noticepopfile");
    	}
    	
    	callAjax("/scm/noticeselect.do", "post", "json", true, param, selectcallback);
    	
    }
    
    function fn_Deletefile() {
    	$("#action").val("D"); 
    	fn_Savefile();
    }
    
    function fn_download() {
    	
    	var params = "";
    	params += "<input type='hidden' id='notice_cd' name='notice_cd' value='"+ $("#selnoticecd").val() +"' />";
    	
    	jQuery("<form action='/scm/noticedownload.do' method='post'>"+params+"</form>").appendTo('body').submit().remove();
    }
	
</script>

</head>
<body>
<form id="myForm" action=""  method="">
	  <input type="hidden" id="currentPagenotice" />
	  <input type="hidden" id="action"  name="action" />
	  <input type="hidden" id="selnoticecd"  name="selnoticecd" />
	  <input type="hidden" id="file_cd"  name="file_cd" />
	
	
	
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
							<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a> <span
								class="btn_nav bold">기준정보</span> <span class="btn_nav bold"> 공지사항
								관리</span> <a href="/scm/noticeMgr.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>공지사항</span> 
							<span class="fr"> 
							    <select id="searchdel" name="searchdel">
							    </select>		
							    <select id="searchsel" name="searchsel">
							         <option value="">전체</option>
							         <option value="title">제목</option>
							         <option value="regname">등록자</option>
							    </select>
							    <input type="text" id="searchtext" name="searchtext"  style="width: 150px; height: 25px;" />
							    <a class="btnType blue" href="javascript:fn_serachlist();" name="modal"><span>검색</span></a>
							    <a class="btnType blue" href="javascript:fn_openpopup();" name="modal"><span>신규등록</span></a>
							    <a class="btnType blue" href="javascript:fn_openpopupfile();" name="modal"><span>신규파일</span></a>
							</span>
						</p>
						
						<div class="divComGrpCodList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="15%">
									<col width="20%">
									<col width="15%">
									<col width="15%">
									<col width="15%">
									<col width="15%">
									<col width="5%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">공지코드</th>
										<th scope="col">공지제목</th>
										<th scope="col">작성일</th>
										<th scope="col">조회수</th>
										<th scope="col">삭제여부</th>
										<th scope="col">작성자</th>
										<th scope="col"></th>
									</tr>
								</thead>
								<tbody id="listnotice"></tbody>
							</table>
						</div>
	
						<div class="paging_area"  id="noticePagination"> </div>
						
						
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>

	<!--// 모달팝업 -->
	<div id="noticepop" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong>공지사항 등록</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>
					<colgroup>
						<col width="120px">
						<col width="*">
						<col width="120px">
						<col width="*">
					</colgroup>

					<tbody>
						<tr>
							<th scope="row">등록 일자</th>
							<td id="regdate">
							 </td>
							<th scope="row">수정 일자</th>
							<td id="moddate">
							 </td>
						</tr>
						<tr>
							<th scope="row">공지 제목 <span class="font_red">*</span></th>
							<td colspan="3">
							      <input type="text" class="inputTxt p100" name="notice_title" id="notice_title" />
							 </td>
						</tr>
						<tr>
							<th scope="row">공지내용 <span class="font_red">*</span></th>
							<td colspan="3">
							     <textarea name="notice_content" id="notice_content"  rows="5" cols="30"  ></textarea>
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
	
	<!--// 모달팝업 -->
	<div id="noticepopfile" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong>공지사항 등록</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>
					<colgroup>
						<col width="120px">
						<col width="*">
						<col width="120px">
						<col width="*">
					</colgroup>

					<tbody>
						<tr>
							<th scope="row">등록 일자</th>
							<td id="regdatefile">
							 </td>
							<th scope="row">수정 일자</th>
							<td id="moddatefile">
							 </td>
						</tr>
						<tr>
							<th scope="row">공지 제목 <span class="font_red">*</span></th>
							<td colspan="3">
							      <input type="text" class="inputTxt p100" name="notice_titlefile" id="notice_titlefile" />
							 </td>
						</tr>
						<tr>
							<th scope="row">공지내용 <span class="font_red">*</span></th>
							<td colspan="3">
							     <textarea name="notice_contentfile" id="notice_contentfile"  rows="5" cols="30"  ></textarea>
						    </td>
						</tr>
						<tr>
							<th scope="row">파일 <span class="font_red">*</span></th>
							<td>
							      <input type="file"  id="selfile" name="selfile"  class="inputTxt p100"  onChange="javascript:imagechage(event)" />
							 </td>
							<td colspan="2">
							      <div id="filepreview"></div>
							 </td>
						</tr>						
						
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSavefile" name="btn"><span>저장</span></a> 
					<a href="" class="btnType blue" id="btnDeletefile" name="btn"><span>삭제</span></a> 
					<a href=""	class="btnType gray"  id="btnClosefile" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>	
	
</form>
</body>
</html>
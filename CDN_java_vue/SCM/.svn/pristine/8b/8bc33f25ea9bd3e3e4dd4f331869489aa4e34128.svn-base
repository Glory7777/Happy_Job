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
	
	var searchArea;
	var noticeList;
	var noticepopfile;
	
	
	$(function() {
		
		vueInit();
		
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
			/* 	case 'btnSave' :
					fn_Save();
					break; */
				case 'btnSavefile' :	
					fn_Savefile();
					break;					
				case 'btnDelete' :
					fn_Delete();
					break;
				case 'btnClosefile' :	
				case 'btnClose' :
					gfCloseModal();
					if(noticepopfile.action == "I") {
	    				fn_serachlist();
	    			} else if(noticepopfile.action == "U") {
	    				fn_serachlist(noticeList.currentPage);
	    			} else if(noticepopfile.action == "D") {
	    				fn_serachlist(noticeList.currentPage);
	    			}
					break;
				case 'btnDeletefile' :
					fn_Deletefile();
					break;
					
			}
		});
	}
	
	function vueInit() {
		
		searchArea = new Vue({
							
								el : "#searchArea",							
							data : {								
								searchsel : "",
				            	searchtext : "",
				            	searchdel : ""				            	            	
							},
						methods : {
							fn_serachlist : function() {			            		
								fn_serachlist();
			            	},						
			            	fn_openpopupfile : function() {			            		
								fn_openpopupfile();
			            	}
		            }		
			
		});
		
		noticeList = new Vue({
			
								el : "#noticeList",							
							data : {								
								dataList : [],
								totalCnt:0,
				                pagingNavi: "",
				                currentPage:0								
							},
						methods : {
							fn_selectnoticedile : function(notice_cd) {			            		
								fn_selectnoticedile(notice_cd);
			            	}
			            	
			            }
		
		});
		
		noticepopfile =new Vue({
								
								el : "#noticepopfile",							
								data : {	
									notice_titlefile : "",
						        	notice_contentfile : "",    	
						        	selnoticecd : "",
						        	file_cd : "",
						        	action : "I",
						        	delflag:false,
						        	
						        	regdatefile : "",
						        	moddatefile : "",
						        	
						        	selfile : "",						        	
						        	previewhtml : "",
						        	
						        	btnSavefile : "",
						        	
						        	title1 : true,
						        	title2 : false,
						        	
						        	saveNotice : true,
						        	updateNotice : false	
						        	
								},
								methods : {
									
									  selimg:function(event){
										  var image = event.target;
											 								  
										  if(image.files[0]){
											  
											  var filePath = image.value;
											  
											  //전체경로를 \ 나눔.
											  var filePathSplit = filePath.split('\\'); 									
												
											  //전체경로를 \ 나눔.
											  var filePathSplit = filePath.split('\\'); 
											  //전체경로를 \로 나눈 길이.
											  var filePathLength = filePathSplit.length;
											  //마지막 경로를 .으로 나눔.
											  var fileNameSplit = filePathSplit[filePathLength-1].split('.');
											  //파일명 : .으로 나눈 앞부분
											  var fileName = fileNameSplit[0];
											  //파일 확장자 : .으로 나눈 뒷부분
											   var fileExt = fileNameSplit[1];
											  //파일 크기
		                                      var fileSize = image.files[0].size;
													
											  console.log('파일 경로 : ' + filePath);
											  console.log('파일명 : ' + fileName);
											  console.log('파일 확장자 : ' + fileExt);
											  console.log('파일 크기 : ' + fileSize);									  
											  
											 if(fileExt == "jpg" || fileExt == "png" || fileExt == "gif" || fileExt == "jpeg") {
												 this.previewhtml = "<img src='" + window.URL.createObjectURL(image.files[0]) + "'  style='width: 100px; height: 100px;' />";
											 } else {
												 this.previewhtml = "";
											 }
												 
										  }
										  
									  }
									
								}
		});
		
		
	}

    function fn_serachlist(currentPage) {
    	
    	var currentPage = currentPage || 1;
    	
    	var param = {
    			pageSize : pageSize,
    			currntPage : currentPage,
    			searchsel : searchArea.searchsel,
    			searchtext : searchArea.searchtext,
    			searchdel : searchArea.searchdel
    	}
    	
       var listcallback = function(returnData) {
    		
			console.log(JSON.stringify(returnData));
			
			noticeList.dataList = returnData.listnotice;
			noticeList.totalCnt = returnData.totalcnt;
    		    		
    		var paginationHtml = getPaginationHtml(currentPage, noticeList.totalCnt, pageSize, pageBlockSize, 'fn_serachlist');
    		
    		console.log("paginationHtml : " + paginationHtml);
    		
    		noticeList.pagingNavi = paginationHtml;
    		
    		noticeList.currentPage = currentPage;
    		
    	}
    	
    	callAjax("/scm/listnoticevue.do", "post", "json", true, param, listcallback);
    	
    }
   /*  
    function fn_selectnotice(notice_cd) {
    	
    	var param = {
    			notice_cd : notice_cd
    	}
    	
    	var selectcallback = function(returndata) {
    		console.log(JSON.stringify(returndata));  
    		fn_popupint(returndata.sectinfo);
    		
    		gfModalPop("#noticepopfile");
    	}
    	
    	callAjax("/scm/noticeselect.do", "post", "json", true, param, selectcallback);
    	
    } */
    
    /* function fn_Delete() {
    	noticeList.action ="D"; 
    	fn_Save();
    } */
    
   /*  function fn_popupint(data) {
    	
    	if(data == null || data == undefined || data == "") {
        	$("#notice_title").val("");
        	$("#notice_content").val("");    	
        	$("#selnoticecd").val("");
        	$("#action").val("I");  
        	
        	$("#regdate").text("");
        	$("#moddate").text("");
        	
        	$("#btnDelete").hide();  
        	
        	$("#title2").hide();
        	$("#title1").show();
    	}  else {
        	$("#notice_title").val(data.notice_title);
        	$("#notice_content").val(data.notice_content);    	
        	$("#action").val("U");  
        	
        	$("#regdate").text(data.notice_reg_date);
        	$("#moddate").text(data.notice_update_date);
        	
        	
        	$("#selnoticecd").val(data.notice_cd);
        	
        	$("#btnDelete").show();
        	
        	$("#title1").hide();
        	$("#title2").show();
    	}   	

    } */
    
    
   /*  function fn_Save() {
    	
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
    				fn_serachlist($("#currentPagenotice").val());
    			}
    		}
    		
    	}
    	
    	callAjax("/scm/noticesave.do", "post", "json", true, param, savecallback);
    } */
    
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
    
/*     function imagechage(event) {
    	
    	var image = event.target;
		  
		if(image.files[0]){
			
			var imagepath =  window.URL.createObjectURL(image.files[0])
		    // alert(window.URL.createObjectURL(image.files[0])); 
			
			//alert($("#selfile").val());   // C:\fakepath\해피잡.jpg
			var selfile = $("#selfile").val();
			var selfilearr = selfile.split(".");
			// alert(selfilearr[1]);   확장자
			
			var inserhtml = "";
			
		   if(selfilearr[1].toLowerCase() == "jpg" ||  selfilearr[1].toLowerCase() == "png"  ||  selfilearr[1].toLowerCase() == "gif" || selfilearr[1].toLowerCase() == "jpeg") {
			   inserhtml = "<img src='" + imagepath + "'   style='width: 100px; height: 100px;''   />";
		   } else {
			   inserhtml = "";
		   }
		   
			// alert(inserhtml);
			
		 $("#filepreview").empty().append( inserhtml );
			
		   noticepopfile.filepreview = inserhtml;
			
		}
    	
    } */
    
   function fn_popupintfile(data) {
    	
    	if(data == null || data == undefined || data == "") {        	
        	
    		noticepopfile.notice_titlefile = "";
    		noticepopfile.notice_contentfile = "";    	
    		noticepopfile.action = "I";  
        	
    		noticepopfile.regdatefile = "";
    		noticepopfile.moddatefile = "";
    		noticepopfile.delflag = false;
        	
    		noticepopfile.selfile = "";
    		noticepopfile.previewhtml = "";
        	
    		noticepopfile.file_cd = "";
    		noticepopfile.selnoticecd = "";       
        	
    		noticepopfile.file_nm = "";
    		 
        	
        	// 공지사항 등록시, 팝업창 제목을 '공지사항 등록'이라고 함        	
        	noticepopfile.title2 = false;
        	noticepopfile.title1 = true;
        	
        	// 공지사항 등록시, 버튼 이름이 '등록'
        	noticepopfile.updateNotice = false;
        	noticepopfile.saveNotice =true;
        	
    	}  else {   		
    		
    		noticepopfile.notice_titlefile = data.notice_title;
    		noticepopfile.notice_contentfile = data.notice_content;      		
    		noticepopfile.action = "U";  
    		noticepopfile.delflag = true;
        	
    		noticepopfile.regdatefile = data.notice_reg_date;
    		noticepopfile.moddatefile = data.notice_update_date;
        	
    		noticepopfile.selfile = "";
        	
    		noticepopfile.file_cd = data.file_cd;
    		noticepopfile.selnoticecd = data.notice_cd;
        	
        	var file_extention = data.file_extention;
        	var inserhtml ="";
        	        	
        	noticepopfile.selfile = "";
    		
    		var inserhtml = "<a href='javascript:fn_download()'>";
    		
    		if(data.file_nm == "" || data.file_nm == null) {
    			inserhtml += "";
    		} else {
    			if(data.file_extention == "jpg" || data.file_extention == "png" || data.file_extention == "gif" || data.file_extention == "jpeg") {
    				inserhtml += "<img src='" + data.logic_path + "'  style='width: 100px; height: 100px;' />";
				} else {
					//console.log("이미지 파일 아님 : " + data.sm_file_nm);
					inserhtml += data.file_nm;
				}
    		}
    		
    		inserhtml += "</a>";
    		
    		noticepopfile.previewhtml = inserhtml;
    		

    		// 공지사항 수정시, 팝업창 제목을 '공지사항 수정'이라고 함        	
        	noticepopfile.title2 = true;
        	noticepopfile.title1 = false;
        	
        	// 공지사항 수정시, 버튼 이름이 '수정'
        	noticepopfile.updateNotice = true;
        	noticepopfile.saveNotice =false;
    		
        	
    	}   	

    }
   
   function fn_Savefile() {
	   
   	if(!fValidatefile()) {
		return;
	}
	
   	var frm = document.getElementById("myForm");
	frm.enctype = 'multipart/form-data';
	var fileData = new FormData(frm);
	
	fileData.append("action", noticepopfile.action);
	fileData.append("selnoticecd", noticepopfile.selnoticecd); 
	fileData.append("file_cd", noticepopfile.file_cd);
		
	var savecallback = function(returnvalue) {
		console.log(JSON.stringify(returnvalue));
		
		if(returnvalue.result == "SUCCESS") {
			
			if(noticepopfile.action == "I") {
				alert("저장 되었습니다.");
			} else if(noticepopfile.action == "U") {
				alert("수정 되었습니다.");
			} else if(noticepopfile.action == "D") {
				alert("삭제 되었습니다.");
			}		
			
			gfCloseModal();
			
			if(noticepopfile.action == "I") {
				fn_serachlist();
			} else if(noticepopfile.action == "U") {
				fn_serachlist(noticeList.currentPage);
			} else if(noticepopfile.action == "D") {
				fn_serachlist(noticeList.currentPage);
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
    	noticepopfile.action ="D"; 
    	fn_Savefile();
    }
    
    function fn_download() {
    	
    	var params = "";
    	params += "<input type='hidden' id='notice_cd' name='notice_cd' value='"+ noticepopfile.selnoticecd +"' />";
    	
    	jQuery("<form action='/scm/noticedownload.do' method='post'>"+params+"</form>").appendTo('body').submit().remove();
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
							<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a> <span
								class="btn_nav bold">기준정보</span> <span class="btn_nav bold"> 공지사항
								관리</span> <a href="/scm/noticeMgr.do" class="btn_set refresh">새로고침</a>
						</p>

						<div id="searchArea">
						<p class="conTitle">
							<span>공지사항</span> 
							<span class="fr"> 
							    <select id="searchdel" name="searchdel" v-model="searchdel" style="width:100px;">
							    </select>		
							    <select id="searchsel" name="searchsel" v-model="searchsel" style="width:100px;">
							         <option value="">전체</option>
							         <option value="title">제목</option>
							         <option value="regname">등록자</option>
							    </select>
							    <input type="text" id="searchtext" name="searchtext" v-model="searchtext" style="width: 150px; height: 25px;" />
							    <a class="btnType blue" @click="fn_serachlist();" name="modal"><span>검색</span></a>&nbsp;&nbsp;							    
							    <a class="btnType blue" @click="fn_openpopupfile();" name="modal"><span>신규등록</span></a>
							</span>
						</p>
						</div>
						
						<div id="noticeList">
						<div class="divComGrpCodList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="15%">
									<col width="25%">
									<col width="15%">
									<col width="15%">
									<col width="15%">
									<col width="15%">									
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">공지코드</th>
										<th scope="col">공지제목</th>
										<th scope="col">작성일</th>
										<th scope="col">조회수</th>
										<th scope="col">삭제여부</th>
										<th scope="col">작성자</th>										
									</tr>
								</thead>
								<tbody>
									<template v-if="totalCnt == 0">
										<tr>
											<td colspan="6">공지사항이 존재하지 않습니다.</td>
										</tr>
									</template v-else>
										<tr v-for="one in dataList">
											<td>{{ one.notice_cd }}</td>
											<td><a @click="fn_selectnoticedile(one.notice_cd)">{{ one.notice_title }}</a></td>
											<td>{{ one.notice_reg_date }}</td>
											<td>{{ one.notice_read_cnt }}</td>
											<td>{{ one.notice_delete_yn }}</td>
											<td>{{ one.loginid }}</td>
										</tr>
									<template>
									</template>
								</tbody>
							</table>
						</div>
	
						<div class="paging_area" id="pagingNavi" v-html="pagingNavi">
						</div>
						
						</div>
						
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>
	
	<!--// 모달팝업 -->
	<div id="noticepopfile" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt id="title1"  v-show="title1">
				<strong>공지사항 등록</strong>
			</dt>
			<dt id="title2" v-show="title2">
				<strong>공지사항 수정</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>
					<colgroup>
						<col width="120px">
						<col width="*">
						<col width="120px">
						<col width="100">
					</colgroup>

					<tbody>
						<tr>
							<th scope="row">등록 일자</th>
							<td id="regdatefile" v-text="regdatefile">
							 </td>
							<th scope="row">수정 일자</th>
							<td id="moddatefile" v-text="moddatefile">
							 </td>
						</tr>
						<tr>
							<th scope="row">공지 제목 <span class="font_red">*</span></th>
							<td colspan="3">
							      <input type="text" class="inputTxt p100" name="notice_titlefile" id="notice_titlefile"  v-model="notice_titlefile"/>
							 </td>
						</tr>
						<tr>
							<th scope="row">공지내용 <span class="font_red">*</span></th>
							<td colspan="3">
							     <textarea name="notice_contentfile" id="notice_contentfile"  v-model="notice_contentfile" rows="5" cols="30"  ></textarea>
						    </td>
						</tr>
						<tr>
							<th scope="row">파일 <span class="font_red">*</span></th>
							<td>
							      <input type="file"  id="selfile" name="selfile"  v-model="selfile" @change="selimg" />
							 </td>
							<td colspan="2">
							      <div id="filepreview" v-html="previewhtml"></div>
							 </td>
						</tr>						
						
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSavefile" name="btn"><span id="saveNotice" v-show="saveNotice">저장</span><span id="updateNotice" v-show="updateNotice">수정</span></a>					
					<a href="" class="btnType blue" id="btnDeletefile" name="btn" v-show="delflag"><span>삭제</span></a> 
					<a href=""	class="btnType gray"  id="btnClosefile" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>	
	
</form>
</body>
</html>
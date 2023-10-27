<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>장비관리</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->

<script type="text/javascript">
	
	// 1. 페이징 설정 
	var pageSize = 5;    	// 화면당 데이터 수 
	var pageBlock = 5;		// 하단 메뉴에 보이는 페이지 수
	
	var searchArea;
	var equList;
	var equPop;
	
	/* 2. html을 한번 읽고 함수 실행 */
	$(function(){
/* 		 콤보박스 있을 경우 사용 
		 comcombo("delCD", "searchdel", "all", ""); 콤보박스 띄우기(공통코드명, 셀렉테그ID, 전체?, 초기값) */
		vueinit();
		// 3. 장비 조회 
		fnSearchList();
		
		// 버튼 이벤트 등록 (저장, 수정, 삭제, 모달창 닫기)
		fRegisterButtonClickEvent();
	});
	function vueinit(){
		searchArea = new Vue({
			el	 : "#searchArea",
			data : {
				searchSel : "",
				searchText : "",
			},
			methodes : {
				fnSearchList : function(){
					fnSearchList();
				},
				fnOpenPopUp : function(){
					fnOpenPopUp();
				}
			}
		}),
		equList = new Vue({
			el	 : "#equList",
			data : {
				dataList : [],
				totalCnt : 0,
				currentPage : 0,
				pagingnavi : ""
			},
			methods : {
				fnSelectEqu : function(equ_cd){
				fnSelectEqu(equ_cd);
				}
			}
		}),
		equPop = new Vue({
			el	 : "#equPop",
			data : {
				selequcd : "",
				equ_nm : "",
				equ_etc : "",
				equ_total_cnt : "",
				action : "",
				equ_unable_cnt : "",
				equ_use_cnt : "",
				equ_able_cnt : "",
				Idisabled : true,
				disabled : true,
				delflag : false,
				
			},
			methods : {
				updateAbleCnt : function (){
					if (this.action == "U"){
					var totalCnt = this.equ_total_cnt || 0;
	    	        var useCnt = this.equ_use_cnt || 0;
	    	        var unableCnt = this.equ_unable_cnt || 0;
		    	        this.equ_able_cnt = totalCnt - useCnt - unableCnt;

					}
				}
			},
		}),
		//// 하단 작업
		equListDtl = new Vue({
			el 	 : "#equListDtl",
			data : {
				dataListDtl : [],
				totalCntDtl : 0,
				currentPageDtl: 0,
				pagingnaviDtl: "",
				equ_cd : "",
				equ_nm : "",
				equ_able_cnt : 0,
			    pageBlockDtl : 5,
			    pageSizeDtl : 5,
			},
		methods : {
		      fnListEquDtl: function (currentPage, equ_cd, equ_nm, equ_able_cnt) {
		        fnListEquDtl(currentPage, equ_cd, equ_nm, equ_able_cnt);
		      },
		},
		}),
		equDtlPop = new Vue({
			el	 : "#equDtlPop",
			data : {
				dtl_equ_cd : "",
				dtl_equ_nm : "",
				dtl_able_cnt : 0,
				cls_room_cd : "",
				cls_room_nm : "",
				use_cnt : 0,
				etc : "",
				delflagDtl : false,
				disabledDtl : true,
				IdisabledDtl : true,
				actionDtl : "",
				selecheck : false,
				a : "cls",
				b : "cls_room_cd",
				c : "sel",
				d : "",
			},
			methods : {
				fnSelectDtl : function(equ_cd, cls_room_cd){
					fnSelectDtl(equ_cd, cls_room_cd);
				},
				fnOpenPopUpDtl : function(){
					fnOpenPopUpDtl()
				},
				fnDupRoomCheck : function(){
					fnDupRoomCheck()
				},
				callCombo : function(){
					$('#cls_room_cd option').remove();
					selectComCombo(this.a,this.b,this.c,this.d,this.cls_room_cd);
					console.log("callCombo!!!!!!!!!!!!!1")
				}
			},
			updated : function(){
				if (this.actionDtl == 'I' && !this.selecheck) {
					console.log("update!!!!!!!!!!!!!1")
				       this.callCombo();
				} else {
					this.selecheck = false;
				};
			},
		})
	}
	
	/* 버튼 이벤트 등록 - 저장, 수정, 삭제  */
	function fRegisterButtonClickEvent(){
		$('a[name=btn]').click(function(e){ // a테그중 name에 btn들어가는 것을 클릭하였을 때
			e.preventDefault(); // 이벤트의 초기값 초기화
					
			var btnId = $(this).attr('id'); // btnId는 해당태그의 id속성의 값을 가진다
			
			//alert("btnId : " + btnId);
			
			switch(btnId){
			case 'btnSave' : fnSave(); //  저장
							if($("#action").val() == "I") {
								fnSearchList();
							} else if($("#action").val() == "U") {
								fnSearchList($("#currentPage").val());
							} else if($("#action").val() == "D") {
								fnSearchList();
							}
				break;
			case 'btnDelete' : fnDelete();	// 삭제
				break;
			case 'btnUpdate' : fnUpdate();  // 수정하기
				break;
			case 'btnSaveDtl' : fnSaveDtl();  //  내역저장
				break;
			case 'btnDeleteDtl' : fnDeleteDtl();	// 내역삭제
				break;
			case 'btnUpdateDtl' : fnUpdateDtl();  // 내역수정하기
				break;
			case 'btnCloseDtl' : 
			case 'btnClose' : gfCloseModal();  // 모달닫기 

				break;
				
			//case 'commentWrite' : fCommentInsert();   // 댓글--> 답변글로 변경 // 저장 
				//break;
			}
		});
	}
	/* 4. 장비 리스트 불러오기  */
	function fnSearchList(currentPage){
		
		currentPage = currentPage || 1;   //  || = or 현재 페이지를 1로 설정
		
	//alert("현재 페이지 : " + currentPage);
		
		
		// 4-1. 각각의 변수들을 param에 넣습니다. 변수 설명은 아래 참조
    	var param = {
    			pageSize : pageSize, // 제일 위에 1에서 설정함 1페이지에 나타내야하는 게시글 숫자
    			currntPage : currentPage, // 현재 페이지는 초기 1 Ajax 통신을 통해 페이지 변경시 변하게됨
    			searchSel : searchArea.searchSel, // searchsel id에 있는 value값
    			searchText : searchArea.searchText,
    	}

		
    	var listCallBack = function(returnData) {
    		console.log(returnData);

    		equList.totalCnt = returnData.totalCnt;
    		equList.dataList = returnData.listEqu;    		
    		var paginationHtml = getPaginationHtml(currentPage, equList.totalCnt, pageSize, pageBlock, 'fnSearchList');
    		console.log("paginationHtml : " + paginationHtml);
    		equList.pagingnavi = paginationHtml ;
    		
    		// 현재 페이지 설정
    		equList.currentPage = currentPage;
		}
		//5. param에 정보들을 모아모아 control에 있는 listequ로 보내고, listcallback으로 다시 받음
    	callAjax("/adm/listEquvue.do", "post", "json", true, param, listCallBack);
        // 비동기 작업이 완료되면 콜백 함수 호출

	}
	//
    function fnOpenPopUp() {
    	
    	fnPopUpInt();
    	
		// 모달 팝업
		gfModalPop("#equPop");
		
    }
	//셀렉트 모달 / 변수 적용
    function fnSelectEqu(equ_cd) {
    	
    	var param = {
    			equ_cd : equ_cd,
    			
    	}
    	
    	var selectCallBack = function(returnData) {
    		console.log(JSON.stringify(returnData));  
    		console.log(returnData.sectInfo);
    		
    		fnPopUpInt(returnData.sectInfo);
    		
    		gfModalPop("#equPop");
    	}
    	
    	callAjax("/adm/selectEqu.do", "post", "json", true, param, selectCallBack);
    	
    }
    
    //////셀렉트 모달의 실행함수 정의
    function fnPopUpInt(data) {

    	if(data == null || data == undefined || data == "") {
    		equPop.selequcd = ""; // 선택코드
        	
    		equPop.equ_nm = ""; // 장비명
    		equPop.equ_etc = ""; // 비고
    		equPop.equ_total_cnt = ""; // 총 개수
        	
    		equPop.action = "I"; 
        	
    		equPop.equ_unable_cnt = 0; // 사용 불가
    		equPop.equ_use_cnt = "";  // 사용 중
    		equPop.equ_able_cnt = "";  // 사용 가능
    		equPop.Idisabled = true;
    		
    		equPop.delflag = false;		
    	}  else {
    	    equPop.selequcd = data.equ_cd;  // 선택코드

    	    equPop.equ_nm = data.equ_nm; // 장비명
    	    equPop.equ_etc = data.equ_etc; // 비고
    	    equPop.equ_total_cnt = data.equ_total_cnt; // 총 개수

    	    equPop.action = "U";  
        	
    	    equPop.equ_unable_cnt = data.equ_unable_cnt; // 사용 불가
    	    equPop.equ_use_cnt = data.equ_use_cnt; // 사용 중
    	    equPop.equ_able_cnt = data.equ_able_cnt; // 사용 가능
        	equPop.Idisabled = false;
        	
        	equPop.delflag = true;
    	}   	

    }

    // 세이브 버튼을 누르면 발동! 세이브 버튼은 fnPopUpInt 모달안에 있으므로 해당 모달에 붙어있다고 보면된다.
	function fnSave() {
    	
    	if(!fnValidate()) { //값을 다 넣었는지??
    		return;
    	}
    	
    	var param = { //컨트롤로 넘길 정보 목록들
    			action : equPop.action, 
    			equ_cd : equPop.selequcd,
    			equ_nm : equPop.equ_nm,
    			equ_etc : equPop.equ_etc,
    			equ_total_cnt : equPop.equ_total_cnt,
    			equ_unable_cnt : equPop.equ_unable_cnt,
    			equ_use_cnt : equPop.equ_use_cnt,
     			equ_able_cnt : equPop.equ_able_cnt, 
    	}
    	
    	var saveCallBack = function(returnValue) {
    		console.log(JSON.stringify(returnValue));
    		
    		if(returnValue.resultMsg == "저장" || returnValue.resultMsg == "수정" || returnValue.resultMsg == "삭제") {
    			swal(returnValue.resultMsg +" 되었습니다.");
    			gfCloseModal();
    			if(equPop.action == "I") {
    				fnSearchList();
    			} else if(equPop.action == "U") {
    				fnSearchList(equPop.currentPage);
    			} else if(equPop.action == "D") {
    				fnSearchList(equPop.currentPage);
    			}
    		}
    		
    	}
    	
    	callAjax("/adm/equSave.do", "post", "json", true, param, saveCallBack);
    }
	/** 저장 validation */
	function fnValidate() {

		var chk = checkNotEmpty(
				[
						[ "equ_nm", "장비명을 입력해 주세요." ]
					,	[ "equ_total_cnt", "총 수량을 입력해 주세요" ]				]
		);

		if (!chk) {
			return;
		};
		fnChkAble();
 		var chkCnt = fnChkAble()
		if (!chkCnt){
			return;
		} 
		return true;
	}
	function fnChkAble(){
		if(equPop.equ_able_cnt < 0){
			swal("사용 가능 개수가 0보다 낮을 수 없습니다. 다시 확인해주세요");
			return false;
		}else{
			return true;
		}
	}
    function fnDelete() {
    	if(equPop.equ_use_cnt==0){ // 모든 강의실에서 해당 장비 모두 삭제해야 삭제 가능
    			equPop.action="D"; 
	    	fnSave();
    	}else{
    		swal("장비내역을 모두 삭제 후 다시 시도해주세요.")
    		return false
    	}
    } 

    
///////////////////////////////하단 모달 작업 앞에 dtl또는 Dtl넣어서 구분 ///////////////////////////////////////////////////////////////
	/** 상세코드 목록 조회 */
	var pageSizeDtl = 5;    // 내역 데이터 수
	var pageBlockDtl = 5;   // 내역 페이지 수
	 
 	function fnListEquDtl(currentPageDtl, equ_cd, equ_nm, equ_able_cnt) {
		
 		currentPageDtl = currentPageDtl || 1;

 		
		// 장비코드 정보 설정
		equListDtl.equ_cd = equ_cd;
		equListDtl.equ_nm = equ_nm;
		equListDtl.equ_able_cnt = equ_able_cnt;
		var arrData = [equListDtl.equ_cd, equListDtl.equ_nm, equListDtl.equ_able_cnt] // Html에서 페이지 잡아올때 필요함
		
		var param = {
					equ_cd : equListDtl.equ_cd
				,	currentPage : currentPageDtl
				,	pageSize : pageSizeDtl
		}
		console.log(param);
		var resultCallback = function(data) {
			console.log(data);
			
			// Vue에다가 정보 저장
			equListDtl.totalCntDtl = data.totalCntDtl;
			equListDtl.dataListDtl = data.listEquDtl;
			
			var paginationHtmlDtl = getPaginationHtml(currentPageDtl, equListDtl.totalCntDtl, pageSizeDtl, pageBlockDtl, 'fnListEquDtl', arrData);
    		console.log("paginationHtmlDtl : " + paginationHtmlDtl);
    		
			equListDtl.pagingnaviDtl = paginationHtmlDtl;
			
			equListDtl.currentPageDtl = currentPageDtl;
		};
		
		callAjax("/adm/listEquDtlvue.do", "post", "json", true, param, resultCallback);
	}
	
	
	
	
	/** 상세코드 단건 조회 */
    function fnOpenPopUpDtl() {
    	if(equListDtl.equ_cd == null || equListDtl.equ_cd == undefined || equListDtl.equ_cd == "") {
    		swal("장비를 선택해주세요")
    	}else{
    	fnPopUpInitDtl();
    	
		// 모달 팝업
		gfModalPop("#equDtlPop");
    	}
    }
	// 내역 셀리트 모달 적용
	function fnSelectDtl(equ_cd, cls_room_cd) {

		var param = {
				    equ_cd : equ_cd
				,	cls_room_cd : cls_room_cd
		};
		
		var resultCallback = function(returnData) {
    		console.log(JSON.stringify(returnData));  
    		console.log(returnData.sectInfoD);
			fnPopUpInitDtl(returnData.sectInfoD);
			
			gfModalPop("#equDtlPop")
		};
		
		callAjax("/adm/selectEquDtl.do", "post", "json", true, param, resultCallback);
	}

	

    //////셀렉트 모달의 실행함수 정의
    function fnPopUpInitDtl(data) {
    	
    	console.log(data);
    	

    	if(data == null || data == undefined || data == "") {
        	equDtlPop.actionDtl = "I";
        	
    		equDtlPop.dtl_equ_cd = equListDtl.equ_cd; // 장비코드
    		equDtlPop.dtl_equ_nm = equListDtl.equ_nm;
    		equDtlPop.dtl_able_cnt = equListDtl.equ_able_cnt;

    		equDtlPop.cls_room_cd = "";
        	equDtlPop.etc = ""; // 비고
        	equDtlPop.use_cnt = ""; // 사용 개수
        	
        	equDtlPop.delflagDtl = false;

        	
    	}  else {
    		
        	equDtlPop.actionDtl = "U";  
        	console.log("data:::::::" + data)
        	equDtlPop.dtl_equ_cd = data.equ_cd; // 장비코드
        	equDtlPop.dtl_equ_nm = data.equ_nm; // 장비명
        	equDtlPop.dtl_able_cnt = data.equ_able_cnt+data.use_cnt; // 사용가능 개수(기존 사용가능개수 + 기존 사용개수)
    		equDtlPop.cls_room_nm = data.cls_room_nm; // 사용가능 개수
    		equDtlPop.cls_room_cd = data.cls_room_cd;
    		equDtlPop.etc = data.etc; // 비고
        	equDtlPop.use_cnt = data.use_cnt; // 사용 개수
			
        	
        	equDtlPop.delflagDtl = true;
        	
    		
    	}   	

    }	
    
	function fnSaveDtl() {
    	
    	if(!fnValidateDtl()) { //값을 다 넣었는지??
    		return;
    	}

    	var param = { //컨트롤로 넘길 정보 목록들
    			action : equDtlPop.actionDtl, 
    			equ_cd : equDtlPop.dtl_equ_cd,
    			equ_nm : equDtlPop.dtl_equ_nm,
    			cls_room_nm : equDtlPop.cls_room_nm,
    			cls_room_cd : equDtlPop.cls_room_cd,
    			etc : equDtlPop.etc,
    			use_cnt : equDtlPop.use_cnt,
    			equ_able_cnt : equDtlPop.dtl_able_cnt,
    	};
    	
    	var saveCallBack = function(returnValue) {
    		console.log(JSON.stringify(returnValue));
    		
    		
    		if(returnValue.resultMsg == "저장" || returnValue.resultMsg == "수정" || returnValue.resultMsg == "삭제") {
    			alert(returnValue.resultMsg +" 되었습니다.");
    			gfCloseModal();
    				fnSearchList(equList.currentPage);
    				fnListEquDtl(equListDtl.currentPageDtl,equListDtl.equ_cd, equListDtl.equ_nm, equListDtl.equ_able_cnt);
    		}
    	}
    	
    	callAjax("/adm/equDtlSave.do", "post", "json", true, param, saveCallBack);
    }
	/** 저장 validation */
	function fnValidateDtl() {

		var chk = checkNotEmpty(
				[
						[ "cls_room_cd", "강의실을 선택해 주세요." ]
					,	[ "use_cnt", "사용 수량을 입력해 주세요" ]				]
		);

		if (!chk) {
			return;
		}
		var useChk = fnChkUse()
		if(!useChk){
			return;
		}
		return true;
	}
	
    function fnDeleteDtl() {
    	equDtlPop.actionDtl = "D"; 
    	fnSaveDtl();
    } 
    
    function fnChkUse(){
    	if(equDtlPop.dtl_able_cnt < equDtlPop.use_cnt){
    		swal("사용가능 개수보다 많이 입력하였습니다. 다시 확인해주세요");
    		return false;
    	}else{
    		return true;
    	}
    };
    
    function fnDupRoomCheck() {
    	
    	var param = {
    			cls_room_cd : equDtlPop.cls_room_cd,
    			equ_cd : equDtlPop.dtl_equ_cd,
    	}
		var resultCallback = function(returnData) {
    		console.log(JSON.stringify(returnData));  
    		console.log(returnData.dupYN);
			if(returnData.dupYN == '1') {
				swal("이미 강의실에 장비가 있습니다. 확인 후 수정해주세요.");
				equDtlPop.cls_room_cd = "";
				equDtlPop.selecheck = true;
				
			}
		};
		
		callAjax("/adm/dupRoomCheck.do", "post", "json", true, param, resultCallback);
    }
</script>


</head>
<body>
	<!-- ///////////////////// html 페이지  ///////////////////////////// -->

<form id="myForm" action="" method="">
	
	<input type="hidden" id="currentPage" value="1">  <!-- 현재페이지는 처음에 항상 1로 설정하여 넘김  -->
	<input type="hidden" id="currentPageDtl" value="1">  <!-- 내역 현재페이지는 처음에 항상 1로 설정하여 넘김  -->
	  <input type="hidden" id="selequcd"  name="selequcd" /> <!-- 선택글의 코드 -->
	<input type="hidden" name="userType" id="usetType" value=""> <!-- 유저 권한 -->
	<input type="hidden" id="swriter" value="${loginId}"> <!-- 작성자 session에서 java에서 넘어온값 -->
	
	<input type="hidden" id="tmpEquCd" value=""> <!-- 장비코드 -->
	<input type="hidden" id="tmpEquNm" value=""> <!-- 장비명-->
	<input type="hidden" id="tmpAbleCnt" value=""> <!-- 장비사용 가능 갯수-->
	<input type="hidden" id="originUse" value=""> <!-- 장비사용 원래 갯수 -->

	<div id="wrap_area">

		<h2 class="hidden">header 영역</h2>
		<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>

		<h2 class="hidden">컨텐츠 영역</h2>
		<div id="container">
			<ul>
				<li class="lnb">
					<!-- lnb 영역 --> 
					<jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
				</li>
				<li class="contents">
					<!-- contents -->
					<h3 class="hidden">contents 영역</h3> <!-- content -->
					<div class="content">

						<p class="Location">
							<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a>
							<span class="btn_nav bold"> 시설 관리 </span> 
							<span class="btn_nav bold"> 장비 관리 Vue </span> 
							<a href="/adm/equipmentControlvue.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle" id="searchArea">
							<span>장비 관리 Vue</span> 
							<span class="fr"> 	
							    <select id="searchSel" name="searchSel" v-model="searchSel">
							         <option value="">전체</option>
							         <option value="title">장비명</option>
							    </select>
							    <input type="text" id="searchText" name="searchText" v-model="searchText" style="width: 150px; height: 25px;" />
							    <a class="btnType blue" href="#" @click="fnSearchList" name="modal"><span>검색</span></a>
						    	<a class="btnType blue" href="#" @click="fnOpenPopUp" name="modal"><span>신규등록</span></a>
							</span>
						</p>

						
						<div class="divEquList" id="equList">
							<table class="col">
								<caption>caption</caption>
	
		                            <colgroup>
						                   <col width="10%">
						                   <col width="20%">
						                    <col width="10%">
						                    <col width="10%">
						                    <col width="10%">
						                    <col width="10%">
						                   <col width="25%">
						                   <col width="5%">
					                 </colgroup>
								<thead>
									<tr>
							              <th scope="col">장비 코드</th>
							              <th scope="col">장비 명</th>
							              <th scope="col">총 갯수</th>
							              <th scope="col">사용 중</th>
							              <th scope="col">사용불가</th>
							              <th scope="col">사용가능</th>
							              <th scope="col">비고</th>
							              <th scope="col">수정</th>
							              
									</tr>
								</thead>
								<tbody>
								<template v-if="totalCnt ==0">
									<tr><td colspan = "20"> 등록된 장비가 없습니다.</td></tr>
								</template>
								<template v-else v-for="list in dataList">
									<tr>
									<td>{{list.equ_cd}}</td>
									<td><a href="#" @click="fnListEquDtl(1, list.equ_cd, list.equ_nm, list.equ_able_cnt)" >{{list.equ_nm}}</a></td>
									<td>{{list.equ_total_cnt }}</td>
									<td>{{list.equ_use_cnt }}</td>
									<td>{{list.equ_unable_cnt }}</td>
									<td>{{list.equ_able_cnt }}</td>
									<td style="white-space: nowrap; overflow: hidden; text-overflow: ellipsis; max-width: 30%;">
									    {{list.equ_etc}}
									</td>
									<td>
										<a class="btnType3 color1" href="#" @click="fnSelectEqu(list.equ_cd)"><span>수정</span></a>
									</td>
									</tr>
								</template>
								</tbody>
							</table>
							
							<!-- 페이징 처리  -->
							<div class="paging_area" id="pagingnavi" v-html="pagingnavi">
							</div>
											
						</div>
					

		<div class="divComDtlCodList" id="equListDtl">
			<p class="conTitle mt50">
				<span>장비 배치 내역 Vue</span> 
				<span class="fr">
					<a class="btnType blue"  href="#" @click="fnOpenPopUpDtl" name="modal"><span>신규등록</span></a>
				</span>
			</p>

			<table class="col">
				<caption>caption</caption>
				<colgroup>
					<col width="5%">
					<col width="10%">
					<col width="15%">
					<col width="10%">
					<col width="10%">
					<col width="20%">
					<col width="10%">
				</colgroup>

				<thead>
					<tr>
						<th scope="col">순번</th>
						<th scope="col">강의실</th>
						<th scope="col">장비코드</th>
						<th scope="col">장비명</th>
						<th scope="col">사용갯수</th>
						<th scope="col">비고</th>
						<th scope="col">수정</th>
					</tr>
				</thead>
				<tbody>
					<template v-if="totalCntDtl == 0">
						<tr>
							<td colspan="20">데이터가 존재하지 않습니다.</td>
						</tr>
					</template>
					<template v-else v-for="(list, i) in dataListDtl">
						<tr>
							<td>{{ totalCntDtl - (currentPageDtl -1)*pageSizeDtl -i}}</td>
							<td>{{list.cls_room_nm}}</td>
							<td>{{list.equ_cd}}</td>
							<td>{{list.equ_nm}}</td>
							<td>{{list.use_cnt}}</td>
							<td>{{list.etc}}</td>
							<td><a class="btnType3 color1" href="#" @click="fnSelectDtl(list.equ_cd, list.cls_room_cd)"><span>수정</span></a></td><%--  --%>
						</tr>
					</template>
				</tbody>
			</table>
		
			<div class="paging_area"  id="pagingnaviDtl" v-html="pagingnaviDtl"> </div>
		</div>
		</div>
					<h3 class="hidden">풋터 영역</h3>
				<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>	
	
	</div>


	<!--// 모달팝업 -->
	<div id="equPop" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong>장비 등록</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>
					<colgroup>
						<col width="120px">
						<col width="120px">
						<col width="120px">
						<col width="120px">
					</colgroup>

					<tbody>
						<tr>
							<th scope="row">총 갯수<span class="font_red">*</span></th>
							<td id="">
								<input type="text" class="inputTxt p100" @change="updateAbleCnt" name="equ_total_cnt" id="equ_total_cnt" v-model="equ_total_cnt" />
							 </td>
 							<th scope="row">사용 가능</th>
							<td>
								<input type="text" class="inputTxt p100" @change="updateAbleCnt" name="equ_able_cnt" id="equ_able_cnt" v-model="equ_able_cnt" :disabled="disabled"/>
							 </td>
						</tr>
						<tr>
							<th scope="row">사용 중</th>
							<td>
								<input type="text" class="inputTxt p100" name="equ_use_cnt" id="equ_use_cnt" v-model="equ_use_cnt" :disabled="disabled"/>
							 </td>
							<th scope="row">사용 불가</th>
							<td>
								<input type="text" class="inputTxt p100" @change="updateAbleCnt" name="equ_unable_cnt" id="equ_unable_cnt" v-model="equ_unable_cnt" :disabled="Idisabled"/>
							 </td>
						</tr>	
						<tr>
							<th scope="row">장비 명 <span class="font_red">*</span></th>
							<td colspan="3">
							      <input type="text" class="inputTxt p100" name="equ_nm" id="equ_nm" v-model="equ_nm"/>
							 </td>
						</tr>
						<tr>
							<th scope="row">비고내용 <span class="font_red">*</span></th>
							<td colspan="3">
							     <textarea name="equ_etc" id="equ_etc" v-model="equ_etc" rows="5" cols="30"  ></textarea>
						    </td>
						</tr>
					</tbody>
				</table>
	
				<!-- e : 여기에 내용입력 -->
	
				<div class="btn_areaC mt30">
						<a href="" class="btnType blue" id="btnSave" name="btn"><span>저장</span></a> 
						<a href="" class="btnType blue" v-show="delflag" id="btnDelete" name="btn"><span>삭제</span></a> 
						<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop" id="btnClose" name="btn"><span class="hidden">닫기</span></a>
	</div>
	<div id="equDtlPop" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong>장비 내역 관리</strong>
			</dt>
			<dd class="content">

				<!-- s : 여기에 내용입력 -->

				<table class="row">
					<caption>caption</caption>
					<colgroup>
						<col width="120px">
						<col width="120px">
						<col width="120px">
						<col width="120px">
					</colgroup>

					<tbody>
						<tr>
							<th scope="row">장비 코드 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" id="dtl_equ_cd" name="dtl_equ_cd" :disabled="disabledDtl" v-model="dtl_equ_cd"/></td>
							<th scope="row">장비 명 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" id="dtl_equ_nm" name="dtl_equ_nm" :disabled="disabledDtl" v-model="dtl_equ_nm"/></td>
						</tr>
						<tr>
							<th scope="row">사용가능 갯수 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" id=dtl_able_cnt name="dtl_able_cnt" :disabled="disabledDtl" v-model="dtl_able_cnt"/></td>
							<th scope="row">강의실 명 <span class="font_red">*</span></th>
							<td>  
								<template v-if="actionDtl == 'I'">
									<select id='cls_room_cd' name='cls_room_cd' v-model='cls_room_cd' @change='fnDupRoomCheck'></select>
								</template>
								<template v-else>
									<input type='text' class='inputTxt p100' id='cls_room_nm' name='cls_room_nm' :disabled="disabledDtl" v-model="cls_room_nm"/>
								</template>
							</td>
						</tr>
						<tr>
							<th scope="row">사용 갯수 <span class="font_red">*</span></th>
							<td colspan="3">
							<input type="text" class="inputTxt p100" id="use_cnt" name="use_cnt" v-model="use_cnt" />
							</td>
						</tr>
						<tr>
							<th scope="row">비고</th>
							<td colspan="3">
								<input type="text" class="inputTxt p100" id="etc" name="etc" v-model="etc"/>
							</td>
						</tr>
					
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSaveDtl" name="btn"><span>저장</span></a>
					<a href="" class="btnType blue"  id="btnDeleteDtl" name="btn" v-show="delflagDtl"><span>삭제</span></a>  
					<a href="" class="btnType gray" id="btnCloseDtl" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	


</form>

</body>
</html>

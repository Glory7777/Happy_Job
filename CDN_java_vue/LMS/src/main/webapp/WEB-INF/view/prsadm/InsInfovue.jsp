<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>강사 관리 Vue</title>
<script
	src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" charset="utf-8"
	src="${CTX_PATH}/js/popFindZipCode.js"></script>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->

<script type="text/javascript">
	
	// 1. 페이징 설정 
	var pageSize = 10;    	// 화면당 데이터 수 
	var pageBlock = 5;		// 하단 메뉴에 보이는 페이지 수
	var selStatus = $("#selStatus").val()

	var searchArea;
	var insList;
	var InsRegPop;
	/* 2. html을 한번 읽고 함수 실행 $(document).ready*/
	$(function(){
		 
		vueinit();
		// 3. 장비 조회 
		fnSearchList();
		
		// 버튼 이벤트 등록 (저장, 수정, 삭제, 모달창 닫기)
		fRegisterButtonClickEvent();
	});
	
	function vueinit(){
		searchArea = new Vue({
			el		: "#searchArea",
			data	: {
				searchSel	: "",
				searchText	: "", 
				searchStatus : "",
				
			},
			methods	: {
				fnSearchList : function(){
					fnSearchList();
				},
				fnOpenPopUp : function(){
					fnOpenPopUp();
				},
				fnSelStatus	: function(){
					fnSelStatus();
				},
			}
		}),
		insList = new Vue({
			el		: "#insList",
			data	: {
				totalCnt : 0,
				pageSize : 0,
				currentPage : 0,
				dataList : [],
				pagingnavi : "",
			},
			methods : {
				fnSelectId	: function(LoginID){
					fnSelectId(LoginID);
				},
				fnStatus : function(LoginID, status_yn){
					fnStatus(LoginID, status_yn);
				}
			}
		}),
		InsRegPop = new Vue({
			el		: "#InsRegPop",
			data	: {
				name		: "",
				sel_loginID	: "",
				password	: "",
				passwordChk	: "",
				addr1		: "",
				addr2		: "",
				addr3		: "",
				selSex		: "",
				hp1			: "",
				hp2			: "",
				hp3			: "",
				birthday	: "",
				email		: "",
				
				delflag		: false,
			}
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

				break;
			case 'btnDelete' : fnDelete();	// 삭제
				break;
			case 'btnUpdate' : fnUpdate();  // 수정하기
				break;
			case 'btnClose' : gfCloseModal();  // 모달닫기 
				break;
				
			}
		});
	}
	// 우편번호 api
	function execDaumPostcode(q) {
		new daum.Postcode({
			oncomplete : function(data) {
				// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

				// 각 주소의 노출 규칙에 따라 주소를 조합한다.
				// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
				var addr = ''; // 주소 변수
				var extraAddr = ''; // 참고항목 변수

				//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
				if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
					addr = data.roadAddress;
				} else { // 사용자가 지번 주소를 선택했을 경우(J)
					addr = data.jibunAddress;
				}

				// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
				if (data.userSelectedType === 'R') {
					// 법정동명이 있을 경우 추가한다. (법정리는 제외)
					// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
					if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
						extraAddr += data.bname;
					}
					// 건물명이 있고, 공동주택일 경우 추가한다.
					if (data.buildingName !== '' && data.apartment === 'Y') {
						extraAddr += (extraAddr !== '' ? ', '
								+ data.buildingName : data.buildingName);
					}
				}

				// 우편번호와 주소 정보를 해당 필드에 넣는다.
				//document.getElementById('addr1').value = data.zonecode; //우편번호
				//document.getElementById("addr2").value = addr; //주소
				InsRegPop.addr1 = data.zonecode;
				InsRegPop.addr2 = addr;
				// 커서를 상세주소 필드로 이동한다.
				document.getElementById("addr3").focus(); //상세 주소
			}
		}).open({
			q : q
		});
	}

	/* 4. 공지사항 리스트 불러오기  */
	function fnSearchList(currentPage){
		
		currentPage = currentPage || 1;   //  || = or 현재 페이지를 1로 설정
		
	//alert("현재 페이지 : " + currentPage);
		
		
		// 4-1. 각각의 변수들을 param에 넣습니다. 변수 설명은 아래 참조
    	var param = {
    			pageSize : pageSize, // 제일 위에 1에서 설정함 1페이지에 나타내야하는 게시글 숫자
    			currentPage : currentPage, // 현재 페이지는 초기 1 Ajax 통신을 통해 페이지 변경시 변하게됨
    			searchSel : searchArea.searchSel, // searchsel id에 있는 value값
    			searchText : searchArea.searchText,
    			selStatus : searchArea.selStatus
    	}

		
    	var listCallBack = function(returnData) {
    		console.log(returnData);
    		insList.dataList = returnData.listIns;
    		insList.totalCnt = returnData.totalCnt;
    		insList.pagingnavi = getPaginationHtml(currentPage, insList.totalCnt, pageSize, pageBlock, 'fnSearchList');
    		console.log("paginationHtml : " + insList.pagingnavi);
    		//swal(paginationHtml);
    		
    		// 현재 페이지 설정
    		insList.currentPage = currentPage;
		}
		//5. param에 정보들을 모아모아 control에 있는 listIns으로 보내고, listcallback으로 다시 받음
    	callAjax("/adm/listInsvue.do", "post", "json", true, param, listCallBack);
		
	}
  	// 상세 팝업
    function fnOpenPopUp() {
    	
    	fnPopUpInt();
    	
		// 모달 팝업
		gfModalPop("#InsRegPop");
		
    }
	//셀렉트 모달 / 변수 적용
    function fnSelectId(LoginID) {
    	
    	var param = {
    			loginID : LoginID,
    			
    	}
    	
    	var selectCallBack = function(returnData) {
    		console.log(JSON.stringify(returnData));  
    		console.log(returnData.sectInfo);
    		
    		fnPopUpInt(returnData.sectInfo);
    		
    		gfModalPop("#InsRegPop");
    	}
    	
    	callAjax("/adm/selectIns.do", "post", "json", true, param, selectCallBack);
    	
    }
    
    //////셀렉트 모달의 실행함수 정의
    function fnPopUpInt(data) {

    	if(data == null || data == undefined || data == "") {
        	InsRegPop.name = ""; // 이름
        	InsRegPop.sel_loginID = ""; // 등록 ID
        	InsRegPop.password = ""; // 비밀번호
        	InsRegPop.passwordChk = ""; // 비밀번호 확인
        	
        	InsRegPop.addr1 = ""; // 우편번호
        	InsRegPop.addr2 = ""; // 주소
        	InsRegPop.addr3 = ""; // 상세주소
        	
        	InsRegPop.sex = ""; // 성별
        	
        	InsRegPop.hp1 = ""; // 연락처 1
        	InsRegPop.hp2 = ""; // 연락처 2
        	InsRegPop.hp3 = ""; // 연락처 3
        	
        	InsRegPop.birthday = ""; // 생일 입력
        	
        	InsRegPop.email = ""; // 이메일
        	
        	InsRegPop.action = "I"; //액션 
        	
        	InsRegPop.btnDelete = false;   		
    	}  else {
        	InsRegPop.name = data.name; // 이름
        	InsRegPop.sel_loginID = data.loginID; // 등록 ID
        	InsRegPop.password = data.password; // 비밀번호
        	InsRegPop.passwordChk = ""; // 비밀번호 확인
        	
        	InsRegPop.addr1 = data.addr.split(',')[2]; // 우편번호
        	InsRegPop.addr2 = data.addr.split(',')[0]; // 주소
        	InsRegPop.addr3 = data.addr.split(',')[1]; // 상세주소
        	
        	InsRegPop.sex = data.sex; // 성별
        	
        	InsRegPop.hp1 = data.hp.split('-')[0]; // 연락처 1
        	InsRegPop.hp2 = data.hp.split('-')[1]; // 연락처 2
        	InsRegPop.hp3 = data.hp.split('-')[2]; // 연락처 3
        	
        	InsRegPop.birthday = data.birthday; // 생일 입력
        	
        	InsRegPop.email = data.email; // 이메일
        	
    		InsRegPop.action = "U";  
        	
        	InsRegPop.btnDelete = true;
    	}   	

    }

    // 세이브 버튼을 누르면 발동! 세이브 버튼은 fnPopUpInt 모달안에 있으므로 해당 모달에 붙어있다고 보면된다.
	function fnSave() {
    	
    	if(!fnValidate()) { //값을 다 넣었는지??
    		return;
    	}
    	
    	var param = { //컨트롤로 넘길 정보 목록들
    			action : InsRegPop.action, 
    			name : InsRegPop.name,
    			loginID : InsRegPop.sel_loginID,
    			password : InsRegPop.password,
    			addr : InsRegPop.addr2 +","+ InsRegPop.addr3 +"," + InsRegPop.addr1,
    			hp : InsRegPop.hp1+"-"+InsRegPop.hp2+"-"+InsRegPop.hp3,
    			birthday : InsRegPop.birthday,
    			email : InsRegPop.email,    			
    			sex : InsRegPop.selSex,    			
    	}
    	
    	var saveCallBack = function(returnValue) {
    		console.log(JSON.stringify(returnValue));
    		
    		if(returnValue.resultMsg == "저장" || returnValue.resultMsg == "수정" || returnValue.resultMsg == "삭제") {
    			swal(returnValue.resultMsg +" 되었습니다.");
    			gfCloseModal();
    			if(InsRegPop.action == "I") {
    				fnSearchList();
    			} else if(InsRegPop.action == "U") {
    				fnSearchList(insList.currentPage);
    			} else if(InsRegPop.action == "D") {
    				fnSearchList(insList.currentPage);
    			}
    		}
    		
    	}
    	
    	callAjax("/adm/insSave.do", "post", "json", true, param, saveCallBack);
    }
	// 저장 validation 
	function fnValidate() {

		var chk = checkNotEmpty(
				[
						[ "name", "이름을 입력해 주세요." ]
					,	[ "sel_loginID", "ID를 입력해 주세요" ]				
					,	[ "password", "비밀번호를 입력해 주세요" ]				
					,	[ "passwordChk", "비밀번호 확인을 입력해 주세요" ]				
					,	[ "addr1", "우편번호를 입력해 주세요" ]				
					,	[ "addr2", "주소를 입력해 주세요" ]				
					,	[ "hp1" || "hp2" || "hp3", "연락처를 모두 입력해 주세요" ]				
					,	[ "birthday", "생년월일을 입력해 주세요" ]				
					,	[ "email", "이메일을 입력해 주세요" ]				
					,	[ "sex", "성별을 입력해 주세요" ]				
						]
		);

		if (!chk) {
			return;
		};
		
		if(InsRegPop.password != InsRegPop.passwordChk){     // 비밀번호 & 비밀번호 확인
			swal("비밀번호가 맞지 않습니다.").then(function() {
				document.getElementById('#passwordChk').focus();
			  });
			return false;
		};
		//패스워드 정규식
		var passwordRules = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
	 	if(!passwordRules.test(InsRegPop.password)){
			swal('비밀 번호는 숫자,영문자,특수문자 조합으로 8~15자리를 사용해야 합니다.').then(function() {
				document.getElementById("#password").focus();
			  });
			return false;
		}
	 	//이메일 정규식
		var emailRules = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
		if(!emailRules.test(InsRegPop.email)){
			swal("이메일 형식을 확인해주세요.").then(function() {
				document.getElementById("#email").focus();
			  });
			return false
		}
		//전화번호 정규식
		var tel1Rules = /^\d{2,3}$/;
		var tel2Rules = /^\d{3,4}$/;
		var tel3Rules = /^\d{4}$/;
		
		if(!tel1Rules.test(InsRegPop.hp1)){
			swal("연락처를 확인해주세요.").then(function() {
				document.getElementById("#hp1").focus();
			  });
			return false
		}
		if(!tel2Rules.test(InsRegPop.hp2)){
			swal("연락처를 확인해주세요.").then(function() {
				document.getElementById("#hp2").focus();
			  });
			return false
		}
		if(!tel3Rules.test(InsRegPop.hp3)){
			swal("연락처를 확인해주세요.").then(function() {
				document.getElementById("#hp3").focus();
			  });
			return false
		}

		return true;
	}
	
    function fnDelete() {
    	InsRegPop.action = "D"; 
    	fnSave();
    } 
// 승인여부 바꾸기
	function fnStatus(LoginID, status_yn){
		var param = {
    			loginID : LoginID,
    			status_yn : status_yn
    			
    	}
    	
    	var selectCallBack = function(returnData) {
    		console.log(JSON.stringify(returnData));  
    		console.log(returnData.resultMsg);
    		
    		swal(returnData.resultMsg + "되었습니다.");
    		fnSearchList();
    	}
    	
    	callAjax("/adm/changeStatus.do", "post", "json", true, param, selectCallBack);
	}
// 승인여부 검색 바꾸기
	function fnSelStatus(){
	if(searchArea.selStatus == null || searchArea.selStatus == '' || searchArea.selStatus == undefined){
		searchArea.selStatus = 'Y';
		//document.getElementById("searchStatus").text("전체조회").removeClass("color2").addClass("color1");
		document.getElementById("searchStatus").textContent ="전체조회";
		document.getElementById("searchStatus").classList.remove("color2");
		document.getElementById("searchStatus").classList.add("color1");
		fnSearchList();
	}else{
		searchArea.selStatus = '';
		//document.getElementById("searchStatus").text("미승인 조회").removeClass("color1").addClass("color2");
		document.getElementById("searchStatus").textContent = "미승인 조회";
		document.getElementById("searchStatus").classList.remove("color1");
		document.getElementById("searchStatus").classList.add("color2");
		console.log(selStatus);
		fnSearchList();
	}
}
    
</script>


</head>
<body>
	<!-- ///////////////////// html 페이지  ///////////////////////////// -->

<form id="myForm" action="" method="">
	
	<input type="hidden" id="currentPage" value="1">  <!-- 현재페이지는 처음에 항상 1로 설정하여 넘김  -->
	<input type="hidden" id="currentPageDtl" value="1">  <!-- 내역 현재페이지는 처음에 항상 1로 설정하여 넘김  -->
	<input type="hidden" name="action" id="action" value=""> <!-- 뭘 할건지? -->
	<input type="hidden" name="userType" id="usetType" value=""> <!-- 유저 권한 -->
	<input type="hidden" id="swriter" value="${loginId}"> <!-- 작성자 session에서 java에서 넘어온값 -->
	<input type="hidden" id="selStatus" value=""> <!-- 승인 여부  -->
	

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
							<span class="btn_nav bold"> 인원 관리 </span> 
							<span class="btn_nav bold"> 강사 관리 Vue </span> 
							<a href="/adm/tutorControlvue.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle" id="searchArea">
							<span>강사 관리 Vue</span> 
							<span class="fr"> 	
							    <select id="searchSel" name="searchSel" v-model="searchSel">
							         <option value="">전체</option>
							         <option value="title">강사명</option>
							         <option value="ID">강사ID</option>
							    </select>
							    <input type="text" id="searchText" name="searchText" v-model="searchText" style="width: 150px; height: 25px;" />
							    <a class="btnType blue" href="#" @click="fnSearchList" name="modal"><span>검색</span></a>
						    	<a class="btnType blue" href="#" @click="fnOpenPopUp" name="modal"><span>신규등록</span></a>
							</span>
					            <span><a id=searchStatus class="btnType3 color2" href="#" @click="fnSelStatus"><span>미승인 조회</span></a></span>
						</p>
						
						<div class="divInsList" id="insList">
							<table class="col">
								<caption>caption</caption>
	
		                            <colgroup>
						                   <col width="30%">
						                   <col width="25%">
						                    <col width="25%">
						                    <col width="15%">
					                 </colgroup>
								<thead>
									<tr>
							              <th scope="col">강사명 (ID)</th>
							              <th scope="col">휴대전화</th>
							              <th scope="col">가입일자</th>
							              <th scope="col">승인여부</th>
									</tr>
								</thead>
								<tbody>
								<template v-if="totalCnt == 0">
									<tr>
										<td colspan="15">해당하는 강사 데이터가 없습니다.</td>
									</tr>
								</template>
								<template v-else v-for="list in dataList">
									<tr>
										<td><a href="#" @click="fnSelectId(list.loginID)">{{list.name}} ({{list.loginID}})</a></td>
										<td>{{list.hp}}</td>
										<td>{{list.regdate.split(' ')[0]}}</td>
										<template v-if="list.status_yn == 'Y'">
											<td><a class="btnType3 color1" href="#" @click="fnStatus(list.loginID, list.status_yn)">승인취소</a></td>
										</template>
										<template v-else="list.status_yn == 'N'">
											<td><a class="btnType3 color2" href="#" @click="fnStatus(list.loginID, list.status_yn)">승인</a></td>
										</template>
									</tr>
								</template>
								</tbody>
							</table>
							
							<!-- 페이징 처리  -->
							<div class="paging_area" id="pagingnavi" v-html="pagingnavi">
							</div>
						</div>
					</div>
					<h3 class="hidden">풋터 영역</h3>
				<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>	
	
	</div>


	<!--// 모달팝업 -->
	<div id="InsRegPop" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong>강사 회원가입</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>
					<colgroup>
						<col width="150px">
						<col width="180px">
						<col width="150px">
						<col width="180px">
					</colgroup>

					<tbody>
						<tr>
							<th scope="row">이름<span class="font_red">*</span></th>
							<td>
								<input type="text" class="inputTxt p100" name="name" id="name" v-model="name" />
							 </td>
							<th scope="row">아이디<span class="font_red">*</span></th>
							<td>
								<input type="text" class="inputTxt p100" name="sel_loginID" id="sel_loginID" v-model="sel_loginID" />
							</td>
						</tr>
						<tr>
							<th scope="row">비밀번호 <span class="font_red">*</span></th>
							<td colspan="3">
						    	<input type="text" class="inputTxt p100" name="password" id="password" v-model="password"/>
						    </td>
						</tr>
						<tr>
							<th scope="row">비밀번호 확인 <span class="font_red">*</span></th>
							<td colspan="3">
								<input type="text" class="inputTxt p100" name="passwordChk" id="passwordChk" v-model="passwordChk"/>
						    </td>
						</tr>
						<tr>
							<th scope="row">우편번호<span class="font_red">*</span></th>
							<td colspan="2">
								<input type="text" class="inputTxt p100" name="addr1" id="addr1" v-model="addr1" />
							 </td>
							<td><input type="button" value="우편번호 찾기"
									onclick="execDaumPostcode()"
									style="width: 130px; height: 20px;" /></td>
						</tr>
						<tr>
							<th scope="row">주소 <span class="font_red">*</span></th>
							<td colspan="3">
							     <input type="text" class="inputTxt p100" name="addr2" id="addr2" v-model="addr2"/>
						    </td>
						</tr>
						<tr>
							<th scope="row">상세주소<span class="font_red">*</span></th>
							<td colspan="3">
							     <input type="text" class="inputTxt p100" name="addr3" id="addr3" v-model="addr3"/>
						    </td>
						</tr>
						<tr>
							<th scope="row">성별<span class="font_red">*</span></th>
							<td colspan="3" id="selSex" name="selSex" value>
								<label><input type="radio" v-model="selSex" name="sex" id="male" value="M" checked="true"> 남자 </label>
								<label><input type="radio" v-model="selSex" name="sex" id="female" value="F"> 여자 </label>
							</td>
						</tr>
						<tr>
							<th scope="row">연락처<span class="font_red">*</span></th>
							<td colspan = "3">
							     <input class="inputTxt" style="width: 118px" maxlength="3" type="text" name="hp1" id="hp1" v-model="hp1"/>
							    - <input class="inputTxt" style="width: 118px" maxlength="4" type="text" name="hp2" id="hp2" v-model="hp2"/>
							    - <input class="inputTxt" style="width: 118px" maxlength="4" type="text" name="hp3" id="hp3" v-model="hp3"/>
						    </td>
						</tr>
						<tr>
							<th scope="row">생년월일<span class="font_red">*</span></th>
							<td>
							     <input type="date" class="inputTxt p100" name="birthday" v-model="birthday" id="birthday" style="font-size: 15px" />
						    </td>
						</tr>
						<tr>
							<th scope="row">이메일<span class="font_red">*</span></th>
							<td colspan = "3">
							     <input type="text" class="inputTxt p100" name="email" id="email" v-model="email" />
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
		<a href="" class="closePop" id="btnClose" name="btn"><span class="hidden">닫기</span></a>
	</div>


</form>

</body>
</html>

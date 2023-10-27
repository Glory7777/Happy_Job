<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>이력서 관리</title>
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

	var searchArea;
	var stuList;
	var ResRegPop;
	
	/* 2. html을 한번 읽고 함수 실행 $(document).ready*/
	$(function(){
		//vue초기화
		vueinit();
		// 3. 학생 조회 
		fnSearchList();
		
		// 버튼 이벤트 등록 (저장, 수정, 삭제, 모달창 닫기)
		fRegisterButtonClickEvent();
	});
	function vueinit(){
		searchArea = new Vue({
				el : "#searchArea",
			data   : {
				searchSel : "",
				searchText : "",
			},
			methods : {
				fnSearchList : function(){
					fnSearchList();
				}
			}
		}),
		stuList = new Vue({
			el : "#stuList",
		data   : {
			dataList : [],
			totalCnt : 0,
			pagingnavi : "",
			currentPage : 0,
		}
		}),
		ResRegPop = new Vue({
			el : "#ResRegPop",
		data   : {
			name : "",
			sel_loginID : "",
			selCtg : "",
			sex : "",
			addr : "",
			hp : "",
			birthday : "",
			email : "",
			portfolio : "",
			skills : "",
			introduce : "",
			action : "",
		}
		})
	}
	/* 버튼 이벤트 등록 - 저장, 수정, 삭제  */
	function fRegisterButtonClickEvent(){
		$('a[name=btn]').click(function(e){ // a테그중 name에 btn들어가는 것을 클릭하였을 때
			e.preventDefault(); // 이벤트의 초기값 초기화
					
			var btnId = $(this).attr('id'); // btnId는 해당태그의 id속성의 값을 가진다
			
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

	/* 4. 학생 리스트 불러오기  */
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

    		stuList.totalCnt = returnData.totalCnt;
    		console.log(stuList.totalCnt);
    		stuList.dataList = returnData.listRes;
    		
    		var paginationHtml = getPaginationHtml(currentPage, stuList.totalCnt, pageSize, pageBlock, 'fnSearchList');
    		console.log("paginationHtml : " + paginationHtml);
    		//swal(paginationHtml);
    		stuList.pagingnavi = paginationHtml;
    		
    		// 현재 페이지 설정
    		stuList.currentPage = currentPage;
		}
		//5. param에 정보들을 모아모아 control에 있는 listRes으로 보내고, listcallback으로 다시 받음
    	callAjax("/adm/listResvue.do", "post", "json", true, param, listCallBack);
		
	}
   	// 상세 팝업
    function fnOpenPopUp() {
    	
    	fnPopUpInt();
    	
		// 모달 팝업
		gfModalPop("#ResRegPop");
		
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
    		
    		gfModalPop("#ResRegPop");
    	}
    	
    	callAjax("/adm/selectRes.do", "post", "json", true, param, selectCallBack);
    	
    }
    
    //////셀렉트 모달의 실행함수 정의
     function fnPopUpInt(data) {
    	
    	 ResRegPop.name = data.name; // 이름
    	 ResRegPop.sel_loginID = data.loginID; // 등록 ID 값저장
    	 ResRegPop.selCtg = data.ctg_nm;
    	 ResRegPop.sex = data.sex;
    	
    	 ResRegPop.addr = data.addr; // 거주지
    	
    	 ResRegPop.hp = data.hp; // 연락처 
    	 ResRegPop.birthday = data.birthday.split(" ")[0]; // 생일 입력
    	
    	 ResRegPop.email = data.email; // 이메일
    	
    	 ResRegPop.portfolio = data.portfolio; // 포트폴리오
    	 ResRegPop.skills = data.skills; // 기술스택
    	 ResRegPop.introduce = data.introduce; // 자기소개
     	if(data.skills == null || data.skills == undefined) {
     		ResRegPop.action = "I"; //액션 
    	}  else {
    		ResRegPop.action = "U";  
    	}  
    	 
    	
    }

    // 세이브 버튼을 누르면 발동! 세이브 버튼은 fnPopUpInt 모달안에 있으므로 해당 모달에 붙어있다고 보면된다.
	function fnSave() {
    	
    	if(!fnValidate()) { //값을 다 넣었는지??
    		return;
    	}
    	
    	var param = { //컨트롤로 넘길 정보 목록들
    			action : ResRegPop.action, 
    			portfolio : ResRegPop.portfolio,
    			skills : ResRegPop.skills,
    			introduce : ResRegPop.introduce,
    			loginID : ResRegPop.sel_loginID,
    	}
    	
    	var saveCallBack = function(returnValue) {
    		console.log(JSON.stringify(returnValue));
    		
    		if(returnValue.resultMsg == "저장" || returnValue.resultMsg == "수정" || returnValue.resultMsg == "삭제") {
    			swal(returnValue.resultMsg +" 되었습니다.");
    			gfCloseModal();
    			if(ResRegPop.action == "I") {
					fnSearchList();
			  	 } else if(ResRegPop.action == "U") {
					fnSearchList(stuList.currentPage);
				 } else if(ResRegPop.action == "D") {
					fnSearchList(stuList.currentPage);
				 }
    		};
    		
    	};
    	
    	callAjax("/adm/resSave.do", "post", "json", true, param, saveCallBack);
    }
	// 저장 validation 
	function fnValidate() {

		var chk = checkNotEmpty(
				[
						[ "portfolio", "포트폴리오 주소를 입력해 주세요." ]
					,	[ "skills", "기술스택을 입력해 주세요" ]				
					,	[ "introduce", "자기소개를 작성해 주세요" ]				
						]
		);

		if (!chk) {
			return;
		}

		return true;
	}
	
    function fnDelete() {
    	ResRegPop.action = "D"; 
    	fnSave();
    }  
    
</script>


</head>
<body>
	<!-- ///////////////////// html 페이지  ///////////////////////////// -->

<form id="myForm" action="" method="">
	
	<input type="hidden" id="currentPage" value="1">  <!-- 현재페이지는 처음에 항상 1로 설정하여 넘김  -->
	<input type="hidden" name="action" id="action" value=""> <!-- 뭘 할건지? type="hidden" -->
	<input type="hidden" name="userType" id="usetType" value=""> <!-- 유저 권한 -->
	<input type="hidden" id="swriter" value="${loginId}"> <!-- 작성자 session에서 java에서 넘어온값 type="hidden"-->
	<input type="hidden" id="userType" value="${userType}"> <!-- 작성자 session에서 java에서 넘어온값 type="hidden"-->
	<input type="hidden" id="selStatus" value=""> <!-- 승인 여부  -->
	<input type="hidden" id="selRes" value=""> <!-- 선택된 학생 이력서  --> 

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
							<span class="btn_nav bold"> 취업 관리 </span> 
							<span class="btn_nav bold"> 이력서 관리 Vue </span> 
							<a href="/adm/c_resumeControlvue.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle" id="searchArea">
							<span>이력서 관리 Vue</span> 
							<span class="fr"> 	
							    <select id="searchSel" name="searchSel" v-model="searchSel">
							         <option value="">전체</option>
							         <option value="title">학생명</option>
							         <option value="ID">학생ID</option>
							         <option value="skill">보유 스킬</option>
							    </select>
							    <input type="text" id="searchText" name="searchText" v-model="searchText" style="width: 150px; height: 25px;" />
							    <a class="btnType blue" href="#" @click="fnSearchList" name="modal"><span>검색</span></a>
							</span>
						</p>
						<div class="divStuList" id="stuList">
							<table class="col" style="table-layout: fixed;">
								<caption>caption</caption>
	
		                            <colgroup>
						                   <col width="20%">
						                   <col width="10%">
						                   <col width="15%">
						                   <col width="35%">
						                   <col width="10%">
						                   <col width="10%">
					                 </colgroup>
								<thead>
									<tr>
							              <th scope="col">학생명 (ID)</th>
							              <th scope="col">재직상태</th>
							              <th scope="col">휴대전화</th>
							              <th scope="col">기술스택</th>
							              <th scope="col">입력 상태</th>
							              <th scope="col">수정</th>
									</tr>
								</thead>
								<tbody>
								    <template v-if="totalCnt === 0">
								      <tr>
								        <td colspan="12">데이터가 존재하지 않습니다.</td>
								      </tr>
								    </template>
								
								    <template v-else-if="totalCnt > 0">
								      <tr v-for="list in dataList" >
								        <td><a href="#" @click="fnSelectId(list.loginID)">{{ list.name }}({{ list.loginID }})</a></td>
								        
								        <td v-if="!list.ctg_nm">미입력</td>
								        <td v-else>{{ list.ctg_nm }}</td>
								        
								        <td>{{ list.hp }}</td>
								        
								        <td v-if="!list.skills">미입력</td>
								        <td v-else style="max-width: 15%; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">{{ list.skills }}</td>
								        
								        <td>{{ list.res_status }}</td>
								        
								        <td><a href="#" class="btnType3 color1" @click="fnSelectId(list.loginID)"><span>수정</span></a></td>
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
	<div id="ResRegPop" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong>학생 정보조회</strong>
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
							<td id="name">
							{{name}}
							 </td>
							<th scope="row">아이디<span class="font_red">*</span></th>
							<td id="sel_loginID">
							{{sel_loginID}}
							</td>
						</tr>
						<tr>
							<th scope="row">학생 상태<span class="font_red">*</span></th>
							<td id="selCtg">
								<template v-if="selCtg == null || selCtg ==undefined">
								미입력
								</template>
								<template v-else>
								{{selCtg}}
								</template>
							 </td>
							<th scope="row">성별</th>
							<td id="sex" >
								<template v-if="sex == 'M'">
									남자
								</template>
								<template v-if="sex == 'F'">
									여자
								</template>
							</td>
						</tr>
						<tr>
							<th scope="row">거주지</th>
							<td colspan="3" id="addr">
							{{addr}}
						    </td>
						</tr>
						<tr>
							<th scope="row">연락처</th>
							<td id="hp" >
							{{hp}}
						    </td>
							<th scope="row">생년월일</th>
							<td id="birthday" >
							{{birthday}}
						    </td>
						</tr>
						<tr>
							<th scope="row">이메일</th>
							<td colspan = "3" id="email" >
							{{email}}
						    </td>
						</tr>
						<tr>
							<th scope="row">포트폴리오 주소<span class="font_red">*</span></th>
							<td colspan = "3">
							     <input type="text" class="inputTxt p100" name="portfolio" id="portfolio" v-model="portfolio"/>
						    </td>
						</tr>
						<tr>
							<th scope="row">기술스택<span class="font_red">*</span></th>
							<td colspan = "3">
							     <input type="text" class="inputTxt p100" name="skills" id="skills" v-model="skills"/>
						    </td>
						</tr>
						<tr>
							<th colspan="4" scope="row">자기소개 (최대 4000자)<span class="font_red">*</span></th>
						</tr>
						<tr>
							<td colspan="4">
							<textarea name="introduce" id="introduce" v-model="introduce" rows="50" cols="30"  ></textarea>
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

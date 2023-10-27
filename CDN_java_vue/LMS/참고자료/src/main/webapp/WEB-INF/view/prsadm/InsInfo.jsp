<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>강사 관리</title>
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

	
	/* 2. html을 한번 읽고 함수 실행 $(document).ready*/
	$(function(){
		 
		// 3. 장비 조회 
		fnSearchList();
		
		// 버튼 이벤트 등록 (저장, 수정, 삭제, 모달창 닫기)
		fRegisterButtonClickEvent();
	});
	
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
				document.getElementById('addr1').value = data.zonecode; //우편번호
				document.getElementById("addr2").value = addr; //주소
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
    			currntPage : currentPage, // 현재 페이지는 초기 1 Ajax 통신을 통해 페이지 변경시 변하게됨
    			searchSel : $("#searchSel").val(), // searchsel id에 있는 value값
    			searchText : $("#searchText").val(),
    			selStatus : $("#selStatus").val()
    	}

		
    	var listCallBack = function(returnData) {
    		console.log(returnData);

    		$("#insList").empty().append(returnData);
    		
    		console.log($("#totalCnt").val());

    		var totalCnt = $("#totalCnt").val();
    		
    		var paginationHtml = getPaginationHtml(currentPage, totalCnt, pageSize, pageBlock, 'fnSearchList');
    		console.log("paginationHtml : " + paginationHtml);
    		//swal(paginationHtml);
    		$("#pagingnavi").empty().append( paginationHtml );
    		
    		// 현재 페이지 설정
    		$("#currentPage").val(currentPage);
		}
		//5. param에 정보들을 모아모아 control에 있는 listIns으로 보내고, listcallback으로 다시 받음
    	callAjax("/adm/listIns.do", "post", "text", true, param, listCallBack);
		
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
        	$("#name").val(""); // 이름
        	$("#sel_loginID").val(""); // 등록 ID
        	$("#password").val(""); // 비밀번호
        	$("#passwordChk").val(""); // 비밀번호 확인
        	
        	$("#addr1").val(""); // 우편번호
        	$("#addr2").val(""); // 주소
        	$("#addr3").val(""); // 상세주소
        	
        	$("#sex").val(""); // 성별
        	
        	$("#hp1").val(""); // 연락처 1
        	$("#hp2").val(""); // 연락처 2
        	$("#hp3").val(""); // 연락처 3
        	
        	$("#birthday").val(""); // 생일 입력
        	
        	$("#email").val(""); // 이메일
        	
        	$("#action").val("I"); //액션 
        	
        	$("#btnDelete").hide();   		
    	}  else {
        	$("#name").val(data.name); // 이름
        	$("#sel_loginID").val(data.loginID); // 등록 ID
        	$("#password").val(data.password); // 비밀번호
        	$("#passwordChk").val(""); // 비밀번호 확인
        	
        	$("#addr1").val(data.addr.split(',')[2]); // 우편번호
        	$("#addr2").val(data.addr.split(',')[0]); // 주소
        	$("#addr3").val(data.addr.split(',')[1]); // 상세주소
        	
        	$("#sex").val(data.sex); // 성별
        	
        	$("#hp1").val(data.hp.split('-')[0]); // 연락처 1
        	$("#hp2").val(data.hp.split('-')[1]); // 연락처 2
        	$("#hp3").val(data.hp.split('-')[2]); // 연락처 3
        	
        	$("#birthday").val(data.birthday); // 생일 입력
        	
        	$("#email").val(data.email); // 이메일
        	
    		$("#action").val("U");  
        	
        	$("#btnDelete").show();
    	}   	

    }

    // 세이브 버튼을 누르면 발동! 세이브 버튼은 fnPopUpInt 모달안에 있으므로 해당 모달에 붙어있다고 보면된다.
	function fnSave() {
    	
    	if(!fnValidate()) { //값을 다 넣었는지??
    		return;
    	}
    	
    	var param = { //컨트롤로 넘길 정보 목록들
    			action : $("#action").val(), 
    			name : $("#name").val(),
    			loginID : $("#sel_loginID").val(),
    			password : $("#password").val(),
    			addr : $("#addr2").val() +","+ $("#addr3").val() +"," + $("#addr1").val(),
    			hp : $("#hp1").val()+"-"+$("#hp2").val()+"-"+$("#hp3").val(),
    			birthday : $("#birthday").val(),
    			email : $("#email").val(),    			
    			sex : $("input[name='sex']:checked").val(),    			
    	}
    	
    	var saveCallBack = function(returnValue) {
    		console.log(JSON.stringify(returnValue));
    		
    		if(returnValue.resultMsg == "저장" || returnValue.resultMsg == "수정" || returnValue.resultMsg == "삭제") {
    			swal(returnValue.resultMsg +" 되었습니다.");
    			gfCloseModal();
    			if($("#action").val() == "I") {
    				fnSearchList();
    			} else if($("#action").val() == "U") {
    				fnSearchList($("#currentPage").val());
    			} else if($("#action").val() == "D") {
    				fnSearchList($("#currentPage").val());
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
		}

		return true;
	}
	
    function fnDelete() {
    	$("#action").val("D"); 
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
	if($("#selStatus").val() == null || $("#selStatus").val() == ''){
		$("#selStatus").val('Y');
		$("#searchStatus").text("전체조회").removeClass("color2").addClass("color1")
		fnSearchList();
	}else{
		$("#selStatus").val('');
		selStatus = $("#selStatus").val();
		$("#searchStatus").text("미승인 조회").removeClass("color1").addClass("color2")
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
							<span class="btn_nav bold"> 강사 관리 </span> 
							<a href="/adm/tutorControl.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>강사 관리</span> 
							<span class="fr"> 	
							    <select id="searchSel" name="searchSel">
							         <option value="">전체</option>
							         <option value="title">강사명</option>
							         <option value="ID">강사ID</option>
							    </select>
							    <input type="text" id="searchText" name="searchText"  style="width: 150px; height: 25px;" />
							    <a class="btnType blue" href="javascript:fnSearchList();" name="modal"><span>검색</span></a>
							    <c:if test="${userType eq 'B' || userType eq 'C'}" >
							    	<a class="btnType blue" href="javascript:fnOpenPopUp();" name="modal"><span>신규등록</span></a>
							    </c:if>
							</span>
						</p>
						<p>
				            <span><a id=searchStatus class="btnType3 color2" href="javascript:fnSelStatus()"><span>미승인 조회</span></a></span>
						</p>
						<div class="divInsList">
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
								<tbody id="insList"></tbody>
							</table>
							
							<!-- 페이징 처리  -->
							<div class="paging_area" id="pagingnavi">
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
								<input type="text" class="inputTxt p100" name="name" id="name" />
							 </td>
							<th scope="row">아이디<span class="font_red">*</span></th>
							<td>
								<input type="text" class="inputTxt p100" name="sel_loginID" id="sel_loginID" />
							</td>
						</tr>
						<tr>
							<th scope="row">비밀번호 <span class="font_red">*</span></th>
							<td colspan="3">
						    	<input type="text" class="inputTxt p100" name="password" id="password" />
						    </td>
						</tr>
						<tr>
							<th scope="row">비밀번호 확인 <span class="font_red">*</span></th>
							<td colspan="3">
								<input type="text" class="inputTxt p100" name="passwordChk" id="passwordChk" />
						    </td>
						</tr>
						<tr>
							<th scope="row">우편번호<span class="font_red">*</span></th>
							<td colspan="2">
								<input type="text" class="inputTxt p100" name="addr1" id="addr1" />
							 </td>
							<td><input type="button" value="우편번호 찾기"
									onclick="execDaumPostcode()"
									style="width: 130px; height: 20px;" /></td>
						</tr>
						<tr>
							<th scope="row">주소 <span class="font_red">*</span></th>
							<td colspan="3">
							     <input type="text" class="inputTxt p100" name="addr2" id="addr2" />
						    </td>
						</tr>
						<tr>
							<th scope="row">상세주소<span class="font_red">*</span></th>
							<td colspan="3">
							     <input type="text" class="inputTxt p100" name="addr3" id="addr3" />
						    </td>
						</tr>
						<tr>
							<th scope="row">성별<span class="font_red">*</span></th>
							<td colspan="3" id="selSex" name="selSex" value>
								<label><input type="radio" name="sex" id="male" value="M" checked="true"> 남자 </label>
								<label><input type="radio" name="sex" id="female" value="F"> 여자 </label>
							</td>
						</tr>
						<tr>
							<th scope="row">연락처<span class="font_red">*</span></th>
							<td colspan = "3">
							     <input class="inputTxt" style="width: 118px" maxlength="3" type="text" name="hp1" id="hp1" />
							    - <input class="inputTxt" style="width: 118px" maxlength="4" type="text" name="hp2" id="hp2" />
							    - <input class="inputTxt" style="width: 118px" maxlength="4" type="text" name="hp3" id="hp3" />
						    </td>
						</tr>
						<tr>
							<th scope="row">생년월일<span class="font_red">*</span></th>
							<td>
							     <input type="date" class="inputTxt p100" name="birthday" id="birthday" style="font-size: 15px" />
						    </td>
						</tr>
						<tr>
							<th scope="row">이메일<span class="font_red">*</span></th>
							<td colspan = "3">
							     <input type="text" class="inputTxt p100" name="email" id="email" />
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

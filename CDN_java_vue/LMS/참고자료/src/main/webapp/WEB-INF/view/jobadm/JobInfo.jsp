<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>취업 정보</title>
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
	//var selStatus = $("#selStatus").val()

	
	/* 2. html을 한번 읽고 함수 실행 $(document).ready*/
	$(function(){
		 
		// 3. 학생 조회 
		fnSearchList();
		
		// 버튼 이벤트 등록 (저장, 수정, 삭제, 모달창 닫기)
		fRegisterButtonClickEvent();
	});
	
	/* 버튼 이벤트 등록 - 저장, 수정, 삭제  */
	function fRegisterButtonClickEvent(){
		$('a[name=btn]').click(function(e){ // a테그중 name에 btn들어가는 것을 클릭하였을 때
			e.preventDefault(); // 이벤트의 초기값 초기화
					
			var btnId = $(this).attr('id'); // btnId는 해당태그의 id속성의 값을 가진다
			
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

	/* 4. 학생 리스트 불러오기  */
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

    		$("#stuList").empty().append(returnData);
    		
    		console.log($("#totalCnt").val());

    		var totalCnt = $("#totalCnt").val();
    		
    		var paginationHtml = getPaginationHtml(currentPage, totalCnt, pageSize, pageBlock, 'fnSearchList');
    		console.log("paginationHtml : " + paginationHtml);
    		//swal(paginationHtml);
    		$("#pagingnavi").empty().append( paginationHtml );
    		
    		// 현재 페이지 설정
    		$("#currentPage").val(currentPage);
		}
		//5. param에 정보들을 모아모아 control에 있는 listJob으로 보내고, listcallback으로 다시 받음
    	callAjax("/adm/listJob.do", "post", "text", true, param, listCallBack);
		
	}
   	// 상세 팝업
    function fnOpenPopUp() {
    	
    	fnPopUpInt();
    	
		// 모달 팝업
		gfModalPop("#JobRegPop");
		
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
    		
    		gfModalPop("#JobRegPop");
    	}
    	
    	callAjax("/adm/selectJob.do", "post", "json", true, param, selectCallBack);
    	
    }
    
    //////셀렉트 모달의 실행함수 정의
     function fnPopUpInt(data) {
    	
    	$("#name").text(data.name); // 이름
    	$("#sel_loginIDTx").text(data.loginID); // 등록 ID 표현
    	$("#sel_loginID").val(data.loginID); // 등록 ID 값저장
    	if (data.ctg_nm == null) {
    		$("#selCtg").text("미입력"); // 재직여부
    	} else {
    		$("#selCtg").text(data.ctg_nm); // 재직여부
    	}
    	if (data.sex == "F") {
    		$("#sex").text("여자"); // 성별
    	} else if(data.sex == "M") {
    		$("#sex").text("남자"); // 성별
    	} else {
    		$("#sex").text("미입력"); // 성별
    	}
    	
    	$("#addr").text(data.addr.split(',')[0]); // 거주지
    	
    	$("#hp").text(data.hp); // 연락처 
    	$("#birthday").text(data.birthday.split(" ")[0]); // 생일 입력
    	
    	$("#email").text(data.email); // 이메일
    	
    	$("#join_date").val(data.join_date); // 입사일
    	$("#leave_date").val(data.leave_date); // 퇴사일
    	$("#com_nm").val(data.com_nm); // 회사명
    	$("#job_ctg").val(data.job_ctg).attr("selected", "selected"); // 취업 상태
    	
    	$("#btnDelete").hide();
    	$("#btnSave").hide();
			// 관리자랑 자신만 수정 및 저장 할 수 있음
    	if($("#userType").val() == "C" || $("#swriter").val() == data.loginID){
    		$("#btnSave").show();
    	}else {
        	$("#join_date").attr("readonly", true).css("background-color", "#f0f0f0");; // 입사일
        	$("#leave_date").attr("readonly", true).css("background-color", "#f0f0f0");; // 퇴사일
        	$("#com_nm").attr("readonly", true).css("background-color", "#f0f0f0");; // 회사명
        	$("#job_ctg").attr("readonly", true).css("background-color", "#f0f0f0");;// 취업 상태
    	}
    		// 취업정보를 작성했었으면 액션이 I, 아니면 U
    	if(data.job_ctg == null || data.job_ctg == undefined || data.job_ctg == "") {
        	$("#action").val("I"); //액션 
    	}  else {
    		$("#action").val("U");  
    	}   	

    }

      // 세이브 버튼을 누르면 발동! 세이브 버튼은 fnPopUpInt 모달안에 있으므로 해당 모달에 붙어있다고 보면된다.
	function fnSave() {
    	
    	if(!fnValidate()) { //값을 다 넣었는지??
    		return;
    	}
    	
    	var param = { //컨트롤로 넘길 정보 목록들
    			action : $("#action").val(), 
    			join_date : $("#join_date").val(),
    			leave_date : $("#leave_date").val(),
    			com_nm : $("#com_nm").val(),
    			job_ctg : $("#job_ctg").val(),
    			loginID : $("#sel_loginID").val(),
    	}
    	
    	var saveCallBack = function(returnValue) {
    		console.log(JSON.stringify(returnValue));
    		
    		if(returnValue.resultMsg == "저장" || returnValue.resultMsg == "수정" || returnValue.resultMsg == "삭제") {
    			swal(returnValue.resultMsg +" 되었습니다.");
    			gfCloseModal();
    			fnSearchList($("#currentPage").val())
    		};
    		
    	};
    	
    	callAjax("/adm/jobSave.do", "post", "json", true, param, saveCallBack);
    }
	// 저장 validation 
	function fnValidate() {

		var status = $("#job_ctg").val()
		if(status==null || status =="" || status == undefined || status == "무직"){
			var chk = checkNotEmpty(
					[
							[ "job_ctg", "취업여부를 작성해 주세요" ]				
							]
			);
		}else if(status == "퇴직"){
		    var isValidDate = compareDates();/////////////입사일 퇴사일 비교

		    if (!isValidDate) {
		        return;
		    };
			var chk = checkNotEmpty(
					[
							[ "join_date", "입사일을 입력해 주세요." ]
						,	[ "leave_date", "퇴사일을 입력해 주세요" ]				
						,	[ "com_nm", "퇴사한 회사명을 작성해 주세요" ]				
						,	[ "job_ctg", "취업여부를 작성해 주세요" ]				
							]
			);
		}else if(status == "재직" || status == "신규입사"){
			var chk = checkNotEmpty(
					[
							[ "join_date", "입사일을 입력해 주세요." ]
						,	[ "com_nm", "회사명을 작성해 주세요" ]				
						,	[ "job_ctg", "취업여부를 작성해 주세요" ]				
							]
			);
		}

		if (!chk) {
			return;
		}
		

		return true;
	}
	/////입사일 퇴사일 비교 함수
	function compareDates() {
        var joinDate = $("#join_date").val();
        var leaveDate = $("#leave_date").val();

        if (leaveDate < joinDate) {
            swal("퇴사일이 입사일보다 빠를 수 없습니다.");
            return false;
        }
        return;
    }
	
	
    function fnDelete() {
    	$("#action").val("D"); 
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
	<input type="hidden" id="userType" value="${userType}"> <!-- 작성자 session에서 java에서 넘어온값 -->
	<input type="hidden" id="selStatus" value=""> <!-- 승인 여부  -->
	<input type="hidden" id="selJob" value=""> <!-- 선택된 학생 이력서  --> 

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
							<span class="btn_nav bold"> 취업 정보 </span> 
							<a href="/adm/c_resumeControl.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>취업 정보</span> 
							<span class="fr"> 	
							    <select id="searchSel" name="searchSel">
							         <option value="">전체</option>
							         <option value="title">학생명</option>
							         <option value="ID">학생ID</option>
							         <option value="company">회사명</option>
							    </select>
							    <input type="text" id="searchText" name="searchText"  style="width: 150px; height: 25px;" />
							    <a class="btnType blue" href="javascript:fnSearchList();" name="modal"><span>검색</span></a>
							</span>
						</p>
						<div class="divStuList">
							<table class="col" style="table-layout: fixed;">
								<caption>caption</caption>
	
		                            <colgroup>
						                   <col width="20%">
						                   <col width="15%">
						                   <col width="15%">
						                   <col width="15%">
						                   <col width="15%">
						                   <col width="10%">
						                   <col width="10%">
					                 </colgroup>
								<thead>
									<tr>
							              <th scope="col">학생명 (ID)</th>
							              <th scope="col">회사명</th>
							              <th scope="col">전화번호</th>
							              <th scope="col">입사일</th>
							              <th scope="col">퇴사일</th>
							              <th scope="col">취직 상태</th>
							              <th scope="col">수정</th>
									</tr>
								</thead>
								<tbody id="stuList"></tbody>
							</table>
							</div>
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
	<div id="JobRegPop" class="layerPop layerType2" style="width: 600px;">
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
							<th scope="row">이름</th>
							<td id="name">
							 </td>
							<th scope="row">아이디</th>
							<td id="sel_loginIDTx">
							</td>
							<input type="hidden" class="inputTxt p100" name="sel_loginID" id="sel_loginID" />
						</tr>
						<tr>
							<th scope="row">학생 종류</th>
							<td id="selCtg">
							 </td>
							<th scope="row">성별</th>
							<td id="sex" >
							</td>
						</tr>
						<tr>
							<th scope="row">거주지</th>
							<td colspan="3" id="addr">
						    </td>
						</tr>
						<tr>
							<th scope="row">연락처</th>
							<td id="hp">
						    </td>
							<th scope="row">생년월일</th>
							<td id="birthday">
						    </td>
						</tr>
						<tr>
							<th scope="row">이메일</th>
							<td colspan = "3" id="email">
						    </td>
						</tr>
						<tr>
							<th scope="row">입사일<span class="font_red">*</span></th>
							<td colspan = "3">
							     <input type="date" class="inputTxt p100" name="join_date" id="join_date" />
						    </td>
						</tr>
						<tr>
							<th scope="row">퇴사일<span class="font_red">*</span></th>
							<td colspan = "3">
							     <input type="date" class="inputTxt p100" name="leave_date" id="leave_date" />
						    </td>
						</tr>
						<tr>
							<th scope="row">회사명<span class="font_red">*</span></th>
							<td>
							     <input type="text" class="inputTxt p100" name="com_nm" id="com_nm" />
						    </td>
							<th scope="row">취업상태<span class="font_red">*</span></th>
							<td>
							     <!-- <input type="text" class="inputTxt p100" name="job_ctg" id="job_ctg" /> -->
							     <select id=job_ctg name="job_ctg">
							     	<option value="" selected disabled hidden>선택</option>
							     	<option value="무직">무직</option>
							     	<option value="재직">재직</option>
							     	<option value="신규입사">신규입사</option>
							     	<option value="퇴직">퇴직</option>
							     </select>
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

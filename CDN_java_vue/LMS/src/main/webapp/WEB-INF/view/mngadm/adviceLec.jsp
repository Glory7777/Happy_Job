<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Job Korea :: 상담 관리</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script src="https://unpkg.com/axios@0.12.0/dist/axios.min.js"></script>
<script src="https://unpkg.com/lodash@4.13.1/lodash.min.js"></script>

<!-- sweet swal import -->

<script type="text/javascript">
	
	//페이징 설정
	var pageSize = 10;
	var pageBlockSize = 5;
	
	$(function() {
		
		
		
		// 공지사항 조회
		fnSearchList();
		
		userCombo("usr","std_nm","all","A","");
		
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
	});	
	
	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();
	
			var btnId = $(this).attr('id'); // btnId는 해당태그의 id속성의 값을 가진다
			
			//alert("btnId : " + btnId);
			
			switch(btnId){
			case 'btnSave' : 
				console.log("Save 버튼 클릭");
				fnSave(); //  저장
				//alert("저장버튼 클릭!!!이벤트!!");
				break;
			case 'btnDelete' : 
				console.log("Delete 버튼 클릭");
				fnDelete();	// 삭제
				//alert("삭제버튼 클릭!!!이벤트!!");		
				break;
			case 'btnUpdate' : fnUpdate();  // 수정하기
				break;
			case 'searchBtn' : selectAdviceList();  // 검색하기
				break;
			case 'btnClose' : gfCloseModal();  // 모달닫기 
							if($("#action").val() == "I") {
								fnSearchList();
							} else if($("#action").val() == "U") {
								fnSearchList($("#currentPage").val());
							} else if($("#action").val() == "D") {
								fnSearchList();
							}
				break;
				
			//case 'commentWrite' : fCommentInsert();   // 댓글--> 답변글로 변경 // 저장 
				//break;
			}
		});
			
	}

	
	
	// 목록 불러오기
	function fnSearchList(currentPage) {
		
		var currentPage = currentPage || 1;
		
		var param = {
				pageSize : pageSize,
				currentPage : currentPage,
				searchSel : $("#searchSel").val(),
				searchText : $("#searchText").val(),
		}
		
	   var listcallback = function(returndata) {
			
			$("#lectureAdviceList").empty().append(returndata);
			
			var totalcnt = $("#totalcnt").val();
			
			var paginationHtml = getPaginationHtml(currentPage, totalcnt, pageSize, pageBlockSize, 'fnSearchList');
			console.log("paginationHtml : " + paginationHtml);
			//swal(paginationHtml);
			$("#advListPagnation").empty().append( paginationHtml );
			
			// 현재 페이지 설정
			$("#currentPage").val(currentPage);
			
			// 검색창 비워주기
			$("#searchText").val("");
			
		}
		
		callAjax("/adm/lectureAdviceList.do", "post", "text", true, param, listcallback);
		
	}
	

	//------------- 강의 눌렀을 때 학생 목록 조회 --------------------------
	
	//페이징 설정
	var advPageSize = 10;
	var stuPageBlockSize = 10;
	
	function fn_findLec(stdCurrentPage, lec_cd ,lec_nm, ins_id, ins_nm) {
		
		$("#blec_cd").val(lec_cd);
		$("#blec_nm").val(lec_nm);
		$("#bins_id").val(ins_id);
		$("#bins_nm").val(ins_nm);
		
		console.log("blec_cd : " + $("#blec_cd").val());
		console.log("blec_nm : " + $("#blec_nm").val());
		
		fn_findLecList(stdCurrentPage);
	}
	
	
	// 학생 목록 조회
	function fn_findLecList(stdCurrentPage) {
		
		stdCurrentPage = stdCurrentPage || 1;
		
		//var lec_cd = [lec_cd]
		
		var param = {
				lec_cd : $("#blec_cd").val()
			,	advCurrentPage : stdCurrentPage
			,	advPageSize : advPageSize
			,	dsearchText : $("#dsearchText").val()
			,   dsearchSel : $("#dsearchSel").val()
			
		}
		
		//  ,	searchDel : $("#searchDel").val()
		// ,	searchSel : $("#searchSel").val()
	
		
		var resultCallback = function(data) {
			//fn_StdListSet(data, currentPage);
			
			console.log("data : !!!!!!!!!!!" + data);
			console.log($("#advStuList").val());
			
			$('#advStuList').empty().append(data);
			
			var advTotalcnt = $("#advTotalcnt").val();
			
			var paginationHtml = getPaginationHtml(stdCurrentPage, advTotalcnt, advPageSize, stuPageBlockSize, 'fn_findLecList');
			console.log("paginationHtml : " + paginationHtml);
			//swal(paginationHtml);
			
			$("#stuPagination").empty().append( paginationHtml );
			
			$("#stdCurrentPage").val(stdCurrentPage);
			
		};
		
		callAjax("/adm/advStuList.do", "post", "text", true, param, resultCallback);
	}
	

  	// 상세 팝업
	function fn_openpopup() {
	    	
			initPop();
	    	
			// 모달 팝업
			gfModalPop("#advicepop");
		
		
    }
	    
	
	// 상담 학생 하나 클릭
	function fnSelect(cst_no){
	
		var param = {
				cst_no : cst_no,
			   
		}
		
		var listcallback = function(data){
			// 초기 세팅
			console.log(JSON.stringify(data));  
    		//console.log(data.sectInfo);
    		
    		
     		initPop(data.sectInfo);
			
			
			// 모달 팝업
			gfModalPop("#advicepop");
		}
		
		callAjax("/adm/selectAdv.do", "post", "json", true, param, listcallback);
	
	}
	// 오늘 날짜 생성 함수
	function getToday(){
	    var date = new Date();
	    var year = date.getFullYear();
	    var month = ("0" + (1 + date.getMonth())).slice(-2);
	    var day = ("0" + date.getDate()).slice(-2);

	    return year + "-" + month + "-" + day;
	}
	
	// 팝업창 열기 전 셋팅
	function initPop(data){
		
		
		if(data == null || data == undefined || data == "") {
			
	        $("#cst_no").val();  //$("#bcst_no").val()
			$("#lec_nm").val($("#blec_nm").val()).attr("disabled", true);
			$("#std_nm").val("");
			$("#ins_nm").val($("#bins_nm").val() + "(" + $("#bins_id").val()+ ")").attr("disabled", true);
			$("#std_id").val("").attr("readonly", false).css("background-color", "#ffffff");
			$("#ins_id").val("");
			$("#cst_date").val("");
	        $("#cls_room").val("");
	        $("#cst_update_date").val("");
	        $("#cst_ctt").val("");  
	        
			$("#action").val("I");  	
        	
        	$("#btnDelete").hide();  
        	
	        selectComCombo("cls","cls_room","sel","","");
    	}  else {
			
			console.log(data.std_id+ data.std_nm); 
			
			$("#cst_no").val(data.cst_no);  
    		$("#lec_nm").val(data.lec_nm).attr("readonly", true).css("background-color", "#f0f0f0");
			$("#std_nm").val(data.std_id);
			$("#ins_nm").val($("#bins_nm").val() + "(" + $("#bins_id").val()+ ")").attr("disabled", true);
			$("#std_id").val(data.std_nm+"("+(data.std_id) + ")" ).attr("readonly", true).css("background-color", "#f0f0f0");
			$("#ins_id").val(data.ins_id);
			$("#cst_date").val(data.cst_date);
			
			$("#cls_room").val(data.cls_room);
			selectComCombo("cls","cls_room","sel","",data.cls_room);
			$("#cst_update_date").val(data.cst_update_date);
			$("#cst_ctt").val(data.cst_ctt);
			
			
			$("#action").val("U");
			
			$("#btnDelete").show();
    	} 
		
	}
	
	// 저장
	function fnSave(){
		
    	if(!fValidate()) {
    		return;
    	}
		
		var param = {
				action : $("#action").val(),
				lec_cd : $("#blec_cd").val(),
				cst_no : $("#cst_no").val(),
				std_id : $("#std_id").val(),
				cst_date : $("#cst_date").val(),
				cls_room : $("#cls_room").val(),
				cst_ctt : $("#cst_ctt").val(),
				cst_update_date : $("#cst_update_date").val(),
				/* lec_nm : $("#lec_nm").val(),
				std_nm : $("#std_nm").val(),
				ins_nm : $("#ins_nm").val(),
				ins_id : $("#ins_id").val(), */
		};
		
		
		
		var listcallback = function(returnData){
			console.log(JSON.stringify(returnData));
			
// 			swal(returnData.resultMsg);
//    		gfCloseModal();

    		if(returnData.resultMsg == "저장" || returnData.resultMsg == "수정" || returnData.resultMsg == "삭제") {
    			alert(returnData.resultMsg +" 되었습니다.");
    			gfCloseModal();
    		}
    		
			if($("#action").val() == "I"){
				fn_findLecList();
			} else if($("#action").val() == "U"){
				fn_findLecList($("#currentPageAdvice").val());
			} else if($("#action").val() == "D"){
				fn_findLecList($("#currentPageAdvice").val());
			}
		}
		
		callAjax("/adm/saveAdv.do", "post", "json", true, param, listcallback);
	}
	

	 
	// 유효성 확인
	function fValidate() {

		var chk = checkNotEmpty(
				[
						[ "cst_date", "상담일자를 입력해 주세요." ]
						,[ "cst_ctt", "상담내용을 입력해 주세요." ]
						,[ "cls_room", "상담장소를 입력해 주세요." ]
				]
		);
		// false가 되어야 함
		var isValidDate = compareDates();

	    if(!isValidDate) {
	        return;
		    };
		if(!chk) {
			return;
		}

		return true;
	}
	// 날자 비교 함수
	function compareDates() {
	    var cst_date_str = $("#cst_date").val(); // yyyy-MM-dd 형식의 문자열
	    var cst_date = new Date(cst_date_str); // 문자열을 Date 객체로 변환
	    var today = new Date();

        if (today < cst_date) {
    		console.log(cst_date)
    		console.log(today)
            swal("상담일이 오늘을 초과할 수 없습니다.")
            return false;
        }
        return true;
    }
	
	
	
	// 강의 삭제
	function fnDelete(){
		
		if(confirm("정말로 삭제하시겠습니까??")){
			$("#action").val("D");
			fnSave();
	    }
	}
	
</script>

</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" id="currentPageAdvice">
	<input type="hidden" id="currentPageStd">
	<input type="hidden" name="action" id="action" value="">
	<input type="hidden" name="bins_id" id="bins_id" value="">
	<input type="hidden" name="bins_nm" id="bins_nm" value="">
	<input type="hidden" name="blec_cd" id="blec_cd" value="">
	<input type="hidden" name="blec_nm" id="blec_nm" value="">
	<input type="hidden" name="cst_no" id="cst_no" value="">
	<input type="hidden" name="loginID" id="loginID" value="">
	
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
							<span class="btn_nav bold">상담 관리</span>
							<a href="/tut/advice.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>상담 관리</span> 
							<span class="fr"> 
								<a>강의명:</a>
							    <input type="text" id="searchText" name="searchText"  style="width: 200px; height: 25px;" />
							    <a class="btnType blue" href="javascript:fnSearchList();" name="modal"><span>검색</span></a>
							</span>
						</p>
						
						<div class="lectureAdviceList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="15%">
									<col width="40%">
									<col width="30%">
									<col width="15%">
									
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">강의번호</th>
										<th scope="col">강의명</th>
										<th scope="col">기간</th>
										<th scope="col">강사명</th>
										
									</tr>
								</thead>
								<tbody id="lectureAdviceList"></tbody>
							</table>
						</div>
	
						<div class="paging_area"  id="advListPagnation"> </div>
						
					
					<h3 class="hidden">풋터 영역</h3>
					<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				
				
					<p class="conTitle">
							<span>상담 목록</span> 
							<span class="fr"> 	
							    
								    <span>
									   학생명: <input type="text" id="dsearchText" name="dsearchText"  style="width: 150px; height: 25px;" />
								    </span>
							    <a class="btnType blue" href="javascript:fn_findLecList();" name="modal"><span>검색</span></a>
							    <c:if test="${userType eq 'B' || userType eq 'C'}" >
							    	<a class="btnType blue" href="javascript:fn_openpopup();" name="modal"><span>상담등록</span></a>
							    </c:if>
							</span>
						</p>
		
				<div class="advStuList">
					<table class="col">
						<caption>caption</caption>
						<colgroup>
							<col width="10%">
							<col width="20%">
							<col width="25%">
							<col width="15%">
							<col width="20%">
							<col width="10%">
						</colgroup>
		
						<thead>
							<tr>      
								<th scope="col">상담번호</th>
								<th scope="col">수강 강의</th>
								<th scope="col">학생 명(ID)</th>
								<th scope="col">상담일자</th>
								<th scope="col">강사 (ID)</th>
								<th scope="col">수정</th>
							</tr>
						</thead>
						<tbody id="advStuList"></tbody>
					</table>
				</div>
				
				<div class="paging_area"  id="stuPagination"> </div>
				</div>
							<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
						
				
				</li>
			</ul>
		</div>
	</div>
	

	<!-- 모달팝업 -->
	<div id="advicepop" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong>상담등록</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
        <caption>상담 정보 입력</caption>
        <colgroup>
            <col width="15%">
            <col width="35%">
            <col width="15%">
            <col width="35%">
        </colgroup>
        <tbody>
            <tr>
                <th scope="row">과정명</th>
                <td>
                    <input type="text" class="inputTxt p100" name="lec_nm" id="lec_nm" />
                </td>
                <th scope="row">학생ID</th>
                <td>
                    <input type="text" class="inputTxt p100" name="std_id" id="std_id" />
                </td>
            </tr>
            <tr>
                <th scope="row">상담일자<span class="font_red">*</span></th>
                <td>
                    <input type="date" class="inputTxt p100" id="cst_date" name="cst_date" />
                </td>
                <th scope="row">상담자</th>
                <td>
                    <input type="text" class="inputTxt p100" name="ins_nm" id="ins_nm" />
                </td>
            </tr>
            <tr>
                <th scope="row">최종 수정일자<span class="font_red">*</span></th>
                <td>
                    <input type="date" class="inputTxt p100" id="cst_update_date" name="cst_update_date" />
                </td>
                <th scope="row">상담장소<span class="font_red">*</span></th>
                <td>
                    <select id="cls_room" name="cls_room"></select>
                </td>
            </tr>
            <tr>
                <th colspan="4" scope="row">상담내용<span class="font_red">*</span></th>
            </tr>
            <tr>
                <td colspan="4">
                    <textarea rows="10" cols="50" name="cst_ctt" id="cst_ctt"></textarea>
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

<script src="${CTX_PATH}/js/view/mngadm/mngadm.js"></script>
</body>
</html>
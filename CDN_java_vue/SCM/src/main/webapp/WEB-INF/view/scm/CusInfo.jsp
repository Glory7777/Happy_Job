<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>공지사항</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!--추가 스크립트  -->
<script
	src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- sweet swal import -->

<script type="text/javascript">
	
	// 페이징 설정
	var pageSize = 10;
	var pageBlockSize = 5;
	
	// 페이지가 로드될 때, 초기화 작업
	$(function() {
		
		// 은행명 콤보 박스
		comcombo("bankCD", "bank_select", "all", "");
		
	    // 체크박스의 변경 이벤트에 대한 핸들러를 추가
	    $("input:checkbox[name=searchDel]").on("change", function() {
	        // 체크박스의 상태가 변경될 때마다 검색을 실행
	        fn_searchlist();
	    });
		
		// 내부직원 목록 조회 초기 화면
		fn_searchlist();
		
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
	
	}); 
	
	
	/** 버튼 이벤트 등록 */
 	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();
	
			var btnId = $(this).attr('id');
	
			switch (btnId) {
				case 'btnInsert' :
				case 'btnSave' :
					fn_Save();
					break;			
				case 'btnDelete' :
					fn_Delete();
					break;
				case 'btnClose' :
					gfCloseModal();
					if($("#action").val() == "I") {
						fn_searchlist();
	    			} else if($("#action").val() == "U") {
	    				fn_searchlist($("#currentPageCusInfo").val());
	    			} else if($("#action").val() == "D") {
	    				fn_searchlist();
	    			}
					break;
					
			}
		});
	} 
    
	/** 내부직원 목록 조회 화면 */
    function fn_searchlist(currentPage) {
    	
    	var currentPage = currentPage || 1;
    	
    	// 삭제된 정보 표시 체크박스 (공통코드:deleteCD) 1:삭제유저(체크시), 0:미삭제유저(미체크시)
    	var searchDel = $("input:checkbox[name=searchDel]").is(":checked") ? "1" : "0";
    	
    	var param = {
    			pageSize : pageSize,
    			currntPage : currentPage,
    			searchtext : $("#searchtext").val(),
    			searchDel : searchDel
    	}
    	
       var listcallback = function(returndata) {
    		console.log(returndata);
    		
    		$("#cusInfoList").empty().append(returndata);
    		
    		var totalcnt = $("#totalcnt").val();
    		
    		var paginationHtml = getPaginationHtml(currentPage, totalcnt, pageSize, pageBlockSize, 'fn_searchlist');
    		console.log("paginationHtml : " + paginationHtml);
    		//swal(paginationHtml);
    		$("#cusInfoPagination").empty().append( paginationHtml );
    		
    		// 현재 페이지 설정
    		$("#currentPageCusInfo").val(currentPage);
    		
    	}
    	
    	callAjax("/scm/cusInfoList.do", "post", "text", true, param, listcallback);
	}
	
	/** 신규직원 등록 모달 창 */
    function fn_openpopup() {
    	
    	// 모달 팝업 내용
    	fn_popupint();
		// 모달 팝업 틀
		gfModalPop("#cusInfoPop");
    }
	
	/** 내부직원 상세 모달 창 */
    function fn_selectCusInfo(loginid) {

    	var param = {
    			loginid : loginid
    	}
    	
    	var selectcallback = function(returndata) {
    		console.log(JSON.stringify(returndata));  
    		fn_popupint(returndata.sectinfo);
    		
    		gfModalPop("#cusInfoPop");
    	}
    	
    	callAjax("/scm/cusInfoSelect.do", "post", "json", true, param, selectcallback);
    }
 
	/** 내부직원 상세 모달 창 양식 */
    function fn_popupint(data) {
    	if(data == null || data == undefined || data == "") {
        	$("#loginid").val("");
        	$("#password").val("");
        	$("#user_hp").val("");
        	$("#user_email").val("");
        	$("#name").val("");
        	$("#DregisterComp_addr2").val("");
        	$("#DregisterComp_addr").val("");
        	$("#DregisterComp_addr1").val("");
        	$("#account_num").val("");
        	$("#bank_select").val("");
        	
        	$("#action").val("I");
        	
        	$("#btnInsert").show();
        	$("#btnSave").hide();
        	$("#btnDelete").hide();
    	} else {
        	$("#loginid").val(data.loginid);
        	$("#password").val(data.password);
        	$("#user_hp").val(data.user_hp);
        	$("#user_email").val(data.user_email);
        	$("#name").val(data.name);
        	$("#DregisterComp_addr2").val(data.zip_cd);
        	$("#DregisterComp_addr").val(data.addr);
        	$("#DregisterComp_addr1").val(data.addr_dt);
        	$("#account_num").val(data.account_num);
        	$("#bank_select").val(data.bank_cd);
        	
        	$("#action").val("U");
        	
        	$("#btnInsert").hide();
        	$("#btnSave").show();
        	$("#btnDelete").show();
        	$("#btnClose").show();
    	}
	}
	
    /** 내부직원 신규 등록 */
    function fn_Save() {
    	
     	if(!fValidate()) {
    		return;
    	} 
    	
     	var param = {
    			action : $("#action").val(),
    			
    			loginid : $("#loginid").val(),
    			password : $("#password").val(),
    			user_hp : $("#user_hp").val(),
    			user_email : $("#user_email").val(),
    			name : $("#name").val(),
    			user_type : $("#user_type").val(),
    			zip_cd : $("#DregisterComp_addr2").val(),
    			addr : $("#DregisterComp_addr").val(),
    			addr_dt : $("#DregisterComp_addr1").val(),
    			account_num : $("#account_num").val(),
    			bank_cd : $("#bank_select").val()
    	}
    	
    	var savecallback = function(returnvalue) {
    		console.log(JSON.stringify(returnvalue));
    		
    		if(returnvalue.result == "SUCCESS") {
    			alert("저장 되었습니다.");
    			gfCloseModal();
    			
    			if($("#action").val() == "I") {
    				fn_searchlist();
    			} else if($("#action").val() == "U") {
    				fn_searchlist($("#currentPageCusInfo").val());
    			} else if($("#action").val() == "D") {
    				fn_searchlist();
    			}
    		}
    		
    	}
    	callAjax("/scm/cusInfoSave.do", "post", "json", true, param, savecallback);
    }
    
	/** 저장 validation */
	function fValidate() {

		var chk = checkNotEmpty(
				[ 
				  [ "loginid", "아이디를 입력해 주세요." ]
				 ,[ "password", "비밀번호를 입력해 주세요." ]
				 ,[ "user_hp", "연락처를 입력해 주세요." ]
				 ,[ "name", "직원명을 입력해 주세요." ]
				 ,[ "user_type", "담당업무를 선택해 주세요." ]
				 ,[ "zip_cd", "우편 번호를 입력해 주세요." ]
				 ,[ "addr", "주소를 입력해 주세요." ]
				 ,[ "account_num", "계좌번호를 입력해 주세요." ]
				 ,[ "bank_select", "은행명을 선택해 주세요." ]	
			]
		);

		if (!chk) {
			return;
		}

		return true;
	}
	
	/** 내부직원 삭제 */
    function fn_Delete() {
    	$("#action").val("D"); 
    	fn_Save();
    }
	
	// 우편번호 api
	function execDaumPostcode(loginaddr, loginaddr1, detailaddr) {
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
				document.getElementById(detailaddr).value = data.zonecode;
				document.getElementById(loginaddr).value = addr;
				
				// 커서를 상세주소 필드로 이동한다.
				document.getElementById(loginaddr1).focus();
			}
		}).open({});
	}
        
</script>
</head>

<body>
	<form id="myForm" action="" method="">
		<input type="hidden" id="currentPageCusInfo" /> <input type="hidden"
			id="action" name="action" />

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
								<span class="btn_nav bold">시스템 관리</span> <span
									class="btn_nav bold">기업고객 관리</span> <a
									href="/scm/cusInfoList.do" class="btn_set refresh">새로고침</a>
							</p>

							<p class="conTitle">
								<span>직원정보 관리</span> <span class="fr"> <input
									type="checkbox" id="searchDel" name="searchDel" /> <label
									for="searchDel">삭제된 정보만 표시</label> <input type="text"
									id="searchtext" name="searchtext"
									style="width: 200px; height: 28px;" placeholder="고객명을 입력해주세요" />
									<a class="btnType blue" href="javascript:fn_searchlist();"
									name="modal"><span>검색</span></a>
								</span>
							</p>
							<div class="divComGrpCodList">
								<table class="col">
									<caption>caption</caption>
									<colgroup>
										<col width="20%">
										<col width="20%">
										<col width="25%">
										<col width="25%">
										<col width="10%">
									</colgroup>

									<thead>
										<tr>
											<th scope="col">고객분류</th>
											<th scope="col">아이디</th>
											<th scope="col">고객명</th>
											<th scope="col">연락처</th>
											<th scope="col">삭제여부</th>
										</tr>
									</thead>
									<tbody id="cusInfoList"></tbody>
								</table>
							</div>

							<div class="paging_area" id="cusInfoPagination"></div>

							<!-- 신규등록 -->
							<div style="margin-top: 30px; text-align: center;">
								<a href="javascript:fn_openpopup();" class="btn_set plue"
									id="userInsert" name="modal"></a><span><b>&nbsp;&nbsp;&nbsp;신규
										고객 등록</b></span>
							</div>
							<!--// 신규등록 -->
						</div> <!--// content -->

						<h3 class="hidden">풋터 영역</h3> <jsp:include
							page="/WEB-INF/view/common/footer.jsp"></jsp:include>
					</li>
				</ul>
			</div>
		</div>

		<!--// 모달팝업 -->
		<div id="cusInfoPop" class="layerPop layerType2" style="width: 70%;">
			<dl>
				<dt>
					<strong>회원관리(기업고객)</strong>
				</dt>
				<dd class="content">

					<!-- s : 문의 내용 -->

					<table class="row">
						<caption>caption</caption>
						<colgroup>
							<col width="20%">
							<col width="15%">
							<col width="25%">
							<col width="15%">
							<col width="25%">
						</colgroup>

						<tbody>
							<tr>
								<th scope="row" rowspan="3">고객정보</th>
								<th scope="row">아이디 <span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt" name="loginid"
									id="loginid" /></td>
								<th scope="row">비밀번호 <span class="font_red">*</span></th>
								<td><input type="password" class="inputTxt" name="password"
									id="password" /></td>
							</tr>
							<tr>
								<th scope="row">연락처 <span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt" name="user_hp"
									id="user_hp" placeholder="000-0000-0000"/></td>
								<th scope="row">이메일</th>
								<td><input type="text" class="inputTxt" name="user_email"
									id="user_email" /></td>
							</tr>
							<tr>
								<th scope="row">고객명 <span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt" name="name"
									id="name" /></td>
								<th scope="row">고객분류 <span class="font_red">*</span></th>
								<td><input id="user_type" name="user_type" value="기업고객"
									style="width: 100px; margin-left: 10px;" readonly /></td>
							</tr>
							<tr>
								<th scope="row">우편번호 <span class="font_red">*</span></th>
								<td colspan="3"><input type="text" class="inputTxt"
									name="comp_addr2" id="DregisterComp_addr2" /></td>
								<td style="border-left-style: hidden;"><input type="button"
									value="우편번호 찾기"
									onclick="execDaumPostcode('DregisterComp_addr','DregisterComp_addr1','DregisterComp_addr2')"
									class="address_search" style="width: 100px; margin-left: 10px;" />
								</td>
							</tr>
							<tr>
								<th scope="row">주소 <span class="font_red">*</span></th>
								<td colspan="4"><input type="text" class="inputTxt"
									name="comp_addr" id="DregisterComp_addr" style="width: 80%;" />
								</td>
							</tr>
							<tr>
								<th scope="row">상세주소</th>
								<td colspan="4"><input type="text" class="inputTxt"
									name="comp_addr1" id="DregisterComp_addr1" style="width: 80%;" />
								</td>
							</tr>
							<tr>
								<th scope="row">계좌번호 <span class="font_red">*</span></th>
								<td colspan="2"><input type="text" class="inputTxt"
									name="account_num" id="account_num" /></td>
								<th scope="row">은행명 <span class="font_red">*</span></th>
								<td><select id="bank_select" name="bank_select"></select></td>
							</tr>
						</tbody>
					</table>

					<!-- e : 저장, 삭제, 취소 버튼-->

					<div class="btn_areaC mt10 mb30">
						<a href="" class="btnType blue" id="btnInsert" name="btn"><span>저장</span></a>
						<a href="" class="btnType blue" id="btnSave" name="btn"><span>수정</span></a>
						<a href="" class="btnType blue" id="btnDelete" name="btn"><span>삭제</span></a>
						<a href="" class="btnType gray" id="btnClose" name="btn"><span>취소</span></a>
					</div>
				</dd>
			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div>

	</form>
</body>
</html>
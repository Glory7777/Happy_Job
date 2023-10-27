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
	
	/** 변수 선언 */
	var pageSize = 10;
	var pageBlockSize = 5;
	
	/**  new Vue el */
	
	/** onload */
	$(function() {
		
		// Vue
		vueInit()
		
		// 은행명 콤보 박스
		comcombo("bankCD", "bank_select", "all", "");
		
		// 내부직원 목록 조회 초기 화면
		fn_searchlist();
	}); 
	
	function vueInit() {
		
		topDiv = new Vue({
						el: "#topDiv",
					  data: {
						  //style
						  searchSt: {
							  width: "200px",
							  height: "28px", 
						  },
						  //v-model
						  searchtext: "",
						  searchDel: "0",
						  searchUserType: "",
					  },
				   methods: {
							fn_searchlist: function(event) {
								console.log("직원정보 관리페이지에서 검색 버튼이 클릭되었습니다!");
								return fn_searchlist();
							},
							toggleSearchDel: function(event) {
								this.searchDel = this.searchDel == "0" ? "1" : "0";
								console.log("체크박스가 클릭되었습니다! searchDel의 변수값은: "+this.searchDel);
								return fn_searchlist();
							},
				   },
		});
					  
		contentDiv = new Vue({
							el: "#contentDiv",
						  data: {
							  //style
							  newIcon: {
								  "margin-top": "30px",
								  "text-align": "center",
							  },
							  //v-model
							  allEmInfoList: [],
							  totalcnt: 0,
							  Pagination: "",
							  currentPage: 0,
						  },
					   methods: {
								fn_selectEmInfo: function(loginid) {
						 			console.log("직원정보 관리페이지에서 직원 정보 상세보기 팝업이 뜹니다!");
						 			return fn_selectEmInfo(loginid);
						 		}
						  
					   },
		});
		
		emInfoPop = new Vue({
							el: "#emInfoPop",
						  data: {
							  //readonly
							  isreadonly: true,
							  //style
							  userTypeText: {
								  width: "270px",
								  height: "24px",
							  },
							  postBtn: {
								  width: "100px",
								  "margin-left": "10px",
							  },
							  lineHide: {
								  "border-left-style": "hidden",
								  "border-right-style": "hidden",
							  },
							  wd1: "width: 70%",
							  wd2: "width: 80%",
							  //v-model
							  loginid: "",
							  password: "",
							  user_hp: "",
							  user_email: "",
							  name: "",
							  user_type:  "기업고객",
							  compAddr2: "",
							  compAddr: "",
							  compAddr1: "",
							  account_num: "",
							  bank_select: "",
							  action: "",
							  btnInsert: true,
							  btnSave: true,
							  btnDelete: true,
						  },
					   methods: {
						  fn_ButtonClickEvent: function(event){
							  event.preventDefault();
							  // 클릭이벤트 실행되는 요소의 id값 가져오기
							  var btnId = event.currentTarget.id;
							  console.log(btnId);
							  if(btnId === 'btnInsert' || btnId === 'btnSave') {
								  return fn_Save();
							  } else if(btnId === 'btnDelete') {
								  return fn_Delete();
							  } else {
								  gfCloseModal();
								  if(btnId == "btnInsert") {
									  return fn_searchlist();
								  } else if(btnId == "btnSave") {
									  return fn_searchlist();										  
								  } else {
									  return fn_searchlist();
								  }
								  
							  }
						  },
						  execDaumPostcodeSet: function(event){
							  console.log("기업고객의 회원 정보 변경 페이지에서 우편번호 찾기 버튼이 클릭되었습니다!");
							  return execDaumPostcode();
						  },
					 },
		});
	}
    
	/** 내부직원 목록 조회 화면 */
    function fn_searchlist(currentPage) {
    	
    	var currentPage = currentPage || 1;
    	
    	var param = {
    			pageSize: pageSize,
    			currntPage: currentPage,
    			searchtext: topDiv.searchtext,
    			searchDel: topDiv.searchDel,
    			searchUserType: topDiv.searchUserType,
    	}
    	
       var listcallback = function(returndata) {
    		console.log(returndata);
    		
    		contentDiv.allEmInfoList = returndata.emInfoList;
    		contentDiv.totalcnt = returndata.totalcnt;
    		
    		var paginationHtml = getPaginationHtml(currentPage, contentDiv.totalcnt, pageSize, pageBlockSize, 'fn_searchlist');
    		console.log("paginationHtml : " + paginationHtml);
    		
    		contentDiv.Pagination = paginationHtml;
    		contentDiv.currentPage = currentPage;
    	}
    	callAjax("/scm/emInfoListvue.do", "post", "json", true, param, listcallback);
	}
	
	/** 신규직원 등록 모달 창 */
    function fn_openpopup() {
    	
    	// 모달 팝업 내용
    	fn_popupint();
		// 모달 팝업 틀
		gfModalPop("#emInfoPop");
    }
	
	/** 직원 상세 모달 창 */
    function fn_selectEmInfo(loginid) {

    	var param = {
    			loginid: loginid
    	}
    	
    	var selectcallback = function(returndata) {
    		console.log(JSON.stringify(returndata));  
    		fn_popupint(returndata.sectinfo);
    		
    		gfModalPop("#emInfoPop");
    	}
    	callAjax("/scm/emInfoSelect.do", "post", "json", true, param, selectcallback);
    }
 
	/** 직원 상세 모달 창 양식 */
    function fn_popupint(data) {
		
    	if(data == null || data == undefined || data == "") {
    		emInfoPop.loginid = "";
    		emInfoPop.password = "";
    		emInfoPop.user_hp = "";
    		emInfoPop.user_email = "";
    		emInfoPop.name = "";
    		emInfoPop.user_type = "";
    		emInfoPop.compAddr2 = "";
    		emInfoPop.compAddr = "";
    		emInfoPop.compAddr1 = "";
    		emInfoPop.account_num = "";
    		emInfoPop.bank_select = "";
    		
    		emInfoPop.action = "I";
        	
    		emInfoPop.btnInsert = true;
    		emInfoPop.btnSave = false;
    		emInfoPop.btnDelete = false;
    	} else {
    		emInfoPop.loginid = data.loginid;
    		emInfoPop.password = data.password;
    		emInfoPop.user_hp = data.user_hp;
    		emInfoPop.user_email = data.user_email;
    		emInfoPop.name = data.name;
    		emInfoPop.user_type = data.user_type;
    		emInfoPop.compAddr2 = data.zip_cd;
    		emInfoPop.compAddr = data.addr;
    		emInfoPop.compAddr1 = data.addr_dt;
    		emInfoPop.account_num = data.account_num;
    		emInfoPop.bank_select = data.bank_cd;
    		
    		emInfoPop.action="U";
        	
    		emInfoPop.btnInsert = false;
    		emInfoPop.btnSave = true;
    		emInfoPop.btnDelete = true;
    	}
	}
	
    /** 직원 정보 저장 */
    function fn_Save() {
    	
     	if(!fValidate()) {
    		return;
    	} 
    	
     	var param = {
    			action: emInfoPop.action,
    			
    			loginid: emInfoPop.loginid,
    			password: emInfoPop.password,
    			user_hp: emInfoPop.user_hp,
    			user_email: emInfoPop.user_email,
    			name: emInfoPop.name,
    			user_type: emInfoPop.user_type,
    			zip_cd: emInfoPop.compAddr2,
    			addr: emInfoPop.compAddr,
    			addr_dt: emInfoPop.compAddr1,
    			account_num: emInfoPop.account_num,
    			bank_cd: emInfoPop.bank_select,
    	}
    	
    	var savecallback = function(returnvalue) {
    		console.log(JSON.stringify(returnvalue));
    		
    		if(returnvalue.result == "SUCCESS") {
    			alert("저장 되었습니다.");
    			gfCloseModal();
    			
    			if(emInfoPop.action == "I") {
    				fn_searchlist();
    			} else if(emInfoPop.action == "U") {
    				fn_searchlist(contentDiv.currentPage);
    			} else if(emInfoPop.action == "D") {
    				fn_searchlist(contentDiv.currentPage);
    			}
    		}
    	}
    	callAjax("/scm/emInfoSave.do", "post", "json", true, param, savecallback);
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
    	emInfoPop.action = "D"; 
    	fn_Save();
    }

	// 우편번호 api
	function execDaumPostcode() {
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
				//document.getElementById(detailaddr).value = data.zonecode;
				//document.getElementById(loginaddr).value = addr;
				
				// (vue변수에 정보 추가)
				emInfoPop.compAddr2 = data.zonecode;
				emInfoPop.compAddr = addr;
				
				// 커서를 상세주소 필드로 이동한다.
				//document.getElementById(loginaddr1).focus();
			}
		}).open({});
	}
        
</script>
</head>

<body>
	<form id="myForm" action="" method="">
	
		<!-- 모달 배경 -->
		<div id="mask"></div>
		<div id="wrap_area">
			<h2 class="hidden">header 영역</h2>
			<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>

			<h2 class="hidden">컨텐츠 영역</h2>
			<div id="container">
				<ul>
					<li class="lnb">
						<!-- lnb 영역 -->
						<jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include>
						<!--// lnb 영역 -->
					</li>
					<li class="contents">
						<!-- contents -->
						<h3 class="hidden">contents 영역</h3>
						<!-- content -->
						<div class="content">
							<p class="Location">
								<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a>
								<span class="btn_nav bold">시스템 관리</span>
								<span class="btn_nav bold">직원정보 관리</span>
								<a href="/scm/emInfoListvue.do" class="btn_set refresh">새로고침</a>
							</p>

							<p class="conTitle" id="topDiv">
								<span>직원정보 관리</span>
								<span class="fr">
									<input type="checkbox" id="searchDel" @click="toggleSearchDel" />
										<label for="searchDel">삭제된 정보만 표시</label>
									<select id="searchUserType" name="searchUserType" v-model="searchUserType" >
										<option value="">전체</option>
										<option value="배송담당자">배송담당자</option>
										<option value="임원">임원</option>
										<option value="구매담당자">구매담당자</option>
										<option value="담당자">SCM담당자</option>
									</select>
									<input type="text" name="searchtext" id="searchtext" v-model="searchtext" :style="searchSt" placeholder="직원명을 입력해주세요" />
									<a class="btnType blue" name="modal" @click="fn_searchlist"><span>검색</span></a>
								</span>
							</p>
							<div class="divComGrpCodList" id="contentDiv">
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
											<th scope="col">담당업무</th>
											<th scope="col">아이디</th>
											<th scope="col">직원명</th>
											<th scope="col">연락처</th>
											<th scope="col">삭제여부</th>
										</tr>
									</thead>
									<tbody>
										<template v-if="totalcnt == 0")>
											<tr><td colspan="5">데이터가 존재하지 않습니다!</td></tr>
										</template>
										<template v-else v-for="em in allEmInfoList">
											<tr @click="fn_selectEmInfo(em.loginid)">
												<td>{{em.user_type}}</td>
												<td>{{em.loginid}}</td>
												<td>{{em.name}}</td>
												<td>{{em.user_hp}}</td>
												<td>{{em.user_yn}}</td>
											</tr>
										</template>
									</tbody>
								</table>
							<div class="paging_area" id="Pagination" v-html="Pagination"></div>
							<!-- 신규등록 -->
							<div :style="newIcon">
								<a class="btn_set plue" name="modal" id="userInsert" @click="fn_openpopup" ></a>
								<span><b>&nbsp;&nbsp;&nbsp;신규 직원 등록</b></span>
							</div>
							<!--// 신규등록 -->
							</div>
						</div> <!--// content -->

						<h3 class="hidden">풋터 영역</h3> <jsp:include
							page="/WEB-INF/view/common/footer.jsp"></jsp:include>
					</li>
				</ul>
			</div>
		</div>

		<!--// 모달팝업 -->
		<div id="emInfoPop" class="layerPop layerType2" :style="wd1">
			<dl>
				<dt>
					<strong>회원관리(직원)</strong>
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
								<th scope="row" rowspan="3">직원정보</th>
								<th scope="row">아이디 <span class="font_red">*</span></th>
								<td>
									<input type="text" class="inputTxt" name="loginid" id="loginid" v-model="loginid" />
								</td>
								<th scope="row">비밀번호 <span class="font_red">*</span></th>
								<td>
									<input type="password" class="inputTxt" name="password" id="password" v-model="password" />
								</td>
							</tr>
							<tr>
								<th scope="row">연락처 <span class="font_red">*</span></th>
								<td>
									<input type="text" class="inputTxt" name="user_hp" id="user_hp" v-model="user_hp" placeholder="000-0000-0000"/>
								</td>
								<th scope="row">이메일</th>
								<td>
									<input type="text" class="inputTxt" name="user_email" id="user_email" v-model="user_email" />
								</td>
							</tr>
							<tr>
								<th scope="row">직원명 <span class="font_red">*</span></th>
								<td>
									<input type="text" class="inputTxt" name="name" id="name" v-model="name" />
								</td>
								<th scope="row">담당업무 <span class="font_red">*</span></th>
								<td>
									<select id="user_type" name="user_type" v-model="user_type" >
										<option value="">전체</option>
										<option value="배송담당자">배송담당자</option>
										<option value="임원">임원</option>
										<option value="구매담당자">구매담당자</option>
										<option value="SCM담당자">SCM담당자</option>
									</select>
								</td>
							</tr>
							<tr>
								<th scope="row">우편번호 <span class="font_red">*</span></th>
								<td colspan="2">
									<input type="text" class="inputTxt" name="compAddr2" id="compAddr2" v-model="loginid" />
								</td>
								<td :style="lineHide">
									<input type="button" value="우편번호 찾기" @click="execDaumPostcode" class="address_search" />
								</td>
							</tr>
							<tr>
								<th scope="row">주소 <span class="font_red">*</span></th>
								<td colspan="4"><input type="text" class="inputTxt" name="compAddr" id="compAddr" v-model="compAddr" :style="wd2" />
								</td>
							</tr>
							<tr>
								<th scope="row">상세주소 </th>
								<td colspan="4">
									<input type="text" class="inputTxt" name="compAddr1" id="compAddr1" v-model="compAddr" :style="wd2" />
								</td>
							</tr>
							<tr>
								<th scope="row">계좌번호 <span class="font_red">*</span></th>
								<td colspan="2">
									<input type="text" class="inputTxt" name="account_num" id="account_num" v-model="account_num" />
								</td>
								<th scope="row">은행명 <span class="font_red">*</span></th>
								<td>
									<select id="bank_select" name="bank_select" v-model="bank_select" ></select>
								</td>
							</tr>
						</tbody>
					</table>

					<!-- e : 저장, 삭제, 취소 버튼-->

					<div class="btn_areaC mt10 mb30">
						<a class="btnType blue" id="btnInsert" name="btn" v-show="btnInsert" @click="fn_ButtonClickEvent"><span>저장</span></a>
						<a class="btnType blue" id="btnSave" name="btn" v-show="btnSave" @click="fn_ButtonClickEvent"><span>수정</span></a>
						<a class="btnType blue" id="btnDelete" name="btn" v-show="btnDelete" @click="fn_ButtonClickEvent"><span>삭제</span></a>
						<a class="btnType gray" id="btnClose" name="btn" @click="fn_ButtonClickEvent"><span>취소</span></a>
					</div>
				</dd>
			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div>

	</form>
</body>
</html>
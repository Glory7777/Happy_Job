<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>회원 정보 변경</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- 추가 스크립트(우편번호) -->
<script
	src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- sweet swal import -->

<script type="text/javascript">

	/** initMypage 로그인 세션 정보로 설정 */		
	$(document).ready(function() {
		
		var loginId = '${sectinfo.loginid}';
		var name = '${sectinfo.name}';
		var password = '${sectinfo.password}';
		var user_hp = '${sectinfo.user_hp}';
		var user_email = '${sectinfo.user_email}';
		var addr = '${sectinfo.addr}';
		var addr_dt = '${sectinfo.addr_dt}';
		var zip_cd = '${sectinfo.zip_cd}';
		var account_num = '${sectinfo.account_num}';
		var bank_cd = '${sectinfo.bank_cd}';
		
		// 은행명 정보는 셀렉트 태그 
		comcombo("bankCD", "bank_select", "all", bank_cd);
		
		document.getElementsByName('loginid')[0].value = loginId;
		document.getElementsByName('name')[0].value = name;
		document.getElementsByName('password')[0].value = password;
		document.getElementsByName('re_password')[0].value = password;
		document.getElementsByName('user_hp')[0].value = user_hp;
		document.getElementsByName('user_email')[0].value = user_email;
		document.getElementsByName('comp_addr')[0].value = addr;
		document.getElementsByName('comp_addr1')[0].value = addr_dt;
		document.getElementsByName('comp_addr2')[0].value = zip_cd;
		document.getElementsByName('account_num')[0].value = account_num;
		
		console.log(bank_cd);
	});
	
	function fn_Save(){
		
     	if(!fValidate()) {
    		return;
    	} 
     	
     	var param = {
     			
    			loginid : $("#loginid").val(),
    			password : $("#password").val(),
    			user_hp : $("#user_hp").val(),
    			user_email : $("#user_email").val(),
    			name : $("#name").val(),
    			zip_cd : $("#DregisterComp_addr2").val(),
    			addr : $("#DregisterComp_addr").val(),
    			addr_dt : $("#DregisterComp_addr1").val(),
    			account_num : $("#account_num").val(),
    			bank_cd : $("#bank_select").val()
    	}
        var savecallback = function (returnvalue) {
    		
    		if(returnvalue.result == "SUCCESS") {
    			alert("저장 되었습니다.");
    			
    		}
     	}
    	callAjax("/cus/updateMypage.do", "post", "json", true, param, savecallback);
	}
	
	/** 저장 validation */
	function fValidate() {
		
		var password = $('#password').val();
		var re_password = $('#re_password').val();

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
		}else {
			if(password != re_password){
				swal("비밀번호가 맞지 않습니다.").then(function() {
				  });
				return false;
			}
			return true;
		}

		return true;
	}
	
	/** 내부직원 삭제 */
	function fn_Delete(){
		
     	var param = {
     			
    			loginid : $("#loginid").val()
    	}
     	
        var savecallback = function (returnvalue) {
     		console.log(JSON.stringify(returnvalue));
    		if(returnvalue.result == "탈퇴 SUCCESS") {
    			alert("탈퇴 되었습니다.");
    			window.location.href = '/loginOut.do';
    		}
     	}
    	callAjax("/cus/delMember.do", "post", "json", true, param, savecallback);
	}
	
	/** 우편번호 api */
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
		<input type="hidden" id="loginId" />

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
						<!-- 시작 contents -->
						<h3 class="hidden">contents 영역</h3> <!-- 끝 contents --> <!-- 시작 content -->
						<div class="content">

							<p class="Location">
								<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a>
								<span class="btn_nav bold">마이페이지</span> <span
									class="btn_nav bold"> 회원 정보 변경</span> <a href="/cus/mypage.do"
									class="btn_set refresh">새로고침</a>
							</p>

							<p class="conTitle" style="margin-bottom: 40px;">
								<span>회원 정보 변경</span> <span class="fr"> <a
									class="btnType blue" href="javascript:fn_Delete();" name="btn"><span>회원
											탈퇴</span></a>
								</span>
							</p>

							<div class="divComGrpCodList">
								<table class="row">
									<caption>caption</caption>
									<colgroup>
										<col width="20%">
										<col width="30%">
										<col width="25%">
										<col width="25%">
									</colgroup>

									<tbody>
										<tr>
											<th scope="row">아이디(ID) <span class="font_red">*</span></th>
											<td><input type="text" class="inputTxt" name="loginid"
												id="loginid" style="width: 84%;" readonly/></td>
											<th scope="row">비밀번호(Password) <span class="font_red">*</span></th>
											<td><input type="password" class="inputTxt" name="password"
												id="password" style="width: 80%;" /></td>
										</tr>
										<tr>
											<th scope="row">연락처(Phone Number) <span class="font_red">*</span></th>
											<td><input type="text" class="inputTxt" name="user_hp"
												id="user_hp" style="width: 84%;" placeholder="000-0000-0000"/></td>
											<th scope="row">비밀번호 확인(Password Verify) <span
												class="font_red">*</span></th>
											<td><input type="password" class="inputTxt"
												name="re_password" id="re_password" style="width: 80%;" /></td>
										</tr>
										<tr>
											<th scope="row">이름(Name) <span class="font_red">*</span></th>
											<td><input type="text" class="inputTxt" name="name"
												id="name" style="width: 84%;" /></td>
											<th scope="row">이메일(Email)</th>
											<td><input type="text" class="inputTxt"
												name="user_email" id="user_email" style="width: 80%;" /></td>
										</tr>
										<tr>
											<th scope="row">은행명(Bank Code) <span class="font_red">*</span></th>
											<td colspan="3"><select id="bank_select"
												name="bank_select" style="width: 31%;">
											</select></td>
										</tr>
										<tr>
											<th scope="row">우편번호(Postal Number) <span
												class="font_red">*</span></th>
											<td colspan="2"><input type="text" class="inputTxt"
												name="comp_addr2" id="DregisterComp_addr2" /></td>
											<td style="border-left-style: hidden;"><input
												type="button" value="우편번호 찾기"
												onclick="execDaumPostcode('DregisterComp_addr','DregisterComp_addr1','DregisterComp_addr2')"
												class="address_search" /></td>
										</tr>
										<tr>
											<th scope="row">주소(Address) <span class="font_red">*</span></th>
											<td colspan="3"><input type="text" class="inputTxt"
												name="comp_addr" id="DregisterComp_addr" style="width: 94%;" />
											</td>
										</tr>
										<tr>
											<th scope="row">상세주소(Detail Address)</th>
											<td colspan="3"><input type="text" class="inputTxt"
												name="comp_addr1" id="DregisterComp_addr1"
												style="width: 94%;" /></td>
										</tr>
										<tr>
											<th scope="row">계좌번호(Account Number) <span
												class="font_red">*</span></th>
											<td colspan="3"><input type="text" class="inputTxt"
												name="account_num" id="account_num" style="width: 30%;" /></td>
										</tr>

									</tbody>
								</table>
							</div>

							<div style="margin-top: 30px; text-align: center;">
								<a href="javascript:fn_Save();" class="btnType blue"
									id="btnSave" name="btn"><span>정보 수정</span></a>
							</div>

						</div> <!-- 끝 content -->

						<h3 class="hidden">풋터 영역</h3> <jsp:include
							page="/WEB-INF/view/common/footer.jsp"></jsp:include>
					</li>
				</ul>
			</div>
		</div>

	</form>
</body>
</html>
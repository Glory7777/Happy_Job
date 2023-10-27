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
	
	var searcharea;
	var divAdviceList;
	var divStuList;
	var advicepop;
	
	$(function() {
		
		
		
		 vueinit();
		
		 userCombo("usr","std_nm","all","A","");
		 
		// 공지사항 조회
		fnSearchList();
		
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
			case 'btnSave' : fnSave(); //  저장
				//alert("저장버튼 클릭!!!이벤트!!");
				break;
			case 'btnDelete' : fnDelete();	// 삭제
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

	
	function vueinit() {
		
		searcharea = new Vue({
			                   el: "#searcharea",
			               data: {
			            	   searchSel : "",
			            	   searchText : "",
// 			            	   dsearchSel : "",
// 			            	   dsearchText : "",
			               }     
		});
		
		divAdviceList = new Vue({
			                  el:"#divAdviceList",
			              data: {
			            	 datalist:[],
		                     totalcnt:0,
		                     pagingnavi: "",
		                     currentPage:0,
			              } ,
			            methods : {
			            	fn_findLecList : function(lecno,lecnm,insid, insnm) {
			            		
			            		divStuList.blec_cd = lecno;
			            		divStuList.blec_nm = lecnm;
			            		divStuList.bins_id = insid;
			            		divStuList.bins_nm = insnm;
			            		
				        		fn_findLecList();
			            	}
			              
			            }  
			                  
		});
		
		divStuList = new Vue({
				            el:"#divStuList",
				        data: {
				      	  Sdatalist:[],
				  		  blec_cd : "",
				  		  blec_nm : "",			      	  
				      	  
				           advpagingnavi: "",
				           advCurrentPage:0,
				           totalcnt:0,
		                    pagingnavi: "",
				        } ,
				        methods : {
				        	fnSelect : function(cst_no){
				        		fnSelect(cst_no);
				        	}
				        }
				
			            	
			            
 
        });
		
		advicepop = new Vue({
		                    el:"#advicepop",
		                 data: {
		                	 lec_nm: "",
		                	 std_nm:"",
		                	 std_id:"",
		                	 ins_nm:"",
		                	 ins_id:"",
		                	 cst_date:"",
		                	 cls_room:"",
		                	 cst_update_date:"",
		                	 cst_ctt:"",
		                	 
		                	 lec_cd:"",
		                	 cst_no:"",
		                	 action:"",
		                	 
		                	 delflag:false,
		                	 isreadonly:false,
		                 },
		                 methods:{
		                	 
		                 }
		});
		
		
		
	}
	
	

	// 목록 불러오기
	function fnSearchList(currentPage) {
		
		var currentPage = currentPage || 1;
		
		var param = {
				pageSize : pageSize,
				currentPage : currentPage,
				searchSel : searcharea.searchSel,
				searchText : searcharea.searchText,
		}
		
	   var listcallback = function(returndata) {
			console.log(JSON.stringify(returndata ));
			
			divAdviceList.datalist = returndata.lectureAdviceList;
			divAdviceList.totalcnt = returndata.totalcnt;
			

			var paginationHtml = getPaginationHtml(currentPage, divAdviceList.totalcnt, pageSize, pageBlockSize, 'fnSearchList');
			console.log("paginationHtml : " + paginationHtml);
			//swal(paginationHtml);
			
			divAdviceList.pagingnavi = paginationHtml;
			divAdviceList.currentPage = currentPage;
		}
		
		callAjax("/adm/lectureAdviceListvue.do", "post", "json", true, param, listcallback);
	}
		

	//------------- 강의 눌렀을 때 학생 목록 조회 --------------------------
	
	//페이징 설정
	var advPageSize = 10;
	var stuPageBlockSize = 10;
	
	function fn_findLec(lec_cd ,lec_nm, ins_id, ins_nm) {
		
		//$("#blec_cd").val(lec_cd);
		//$("#blec_nm").val(lec_nm);
		
		divStuList.blec_cd = lec_cd;
		divStuList.blec_nm = lec_nm;
		divStuList.bins_id = ins_id;
		divStuList.bins_nm = ins_nm;
		
		console.log("blec_cd : " + $("#blec_cd").val());
		console.log("blec_nm : " + $("#blec_nm").val());
		
		fn_findLecList();
	}
	
	
	// 학생 목록 조회
	function fn_findLecList(stdCurrentPage) {
		
		stdCurrentPage = stdCurrentPage || 1;
		
		console.log("divStuList.blec_cd : " + divStuList.blec_cd);
		
		//var lec_cd = [lec_cd]
		
		var param = {
				lec_cd : divStuList.blec_cd
			,	advCurrentPage : stdCurrentPage
			,	advPageSize : advPageSize
			,	dsearchText : $("#dsearchText").val()
			,   dsearchSel : $("#dsearchSel").val()
			
		}
		
		var resultCallback = function(data) {
			//fn_StdListSet(data, currentPage);
			
			console.log(JSON.stringify(data ));
			//console.log($("#advStuList").val());
			
					

			
			divStuList.Sdatalist = data.advStuList;
			divStuList.totalcnt = data.advTotalcnt;
			
			
			var paginationHtml = getPaginationHtml(stdCurrentPage, divStuList.totalcnt, advPageSize, stuPageBlockSize, 'fn_findLecList');
			console.log("paginationHtml : " + paginationHtml);
			//swal(paginationHtml);
			
// 			$("#stuPagination").empty().append( paginationHtml );
			
// 			$("#stdCurrentPage").val(stdCurrentPage);
			
			divStuList.advpagingnavi = paginationHtml;
    		
			divStuList.stdCurrentPage = stdCurrentPage;
			
		};
		
		callAjax("/adm/advStuListvue.do", "post", "json", true, param, resultCallback);
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
				cst_no : cst_no
			   
		}
		
		var listcallback = function(data){
			// 초기 세팅
			console.log(JSON.stringify(data));  
    		//console.log(data.sectInfo);
    		 
    		console.log(data);
    		
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
			console.log("---");  
			
			//divStuList.blec_cd = lec_cd;
			//divStuList.blec_nm = lec_nm;
			//divStuList.bins_id = ins_id;
			//divStuList.bins_nm = ins_nm;
			
			advicepop.cst_no = "";
			advicepop.lec_nm = divStuList.blec_nm;
			advicepop.std_nm = "";  
// 			advicepop.std_id = "";
			advicepop.ins_nm = divStuList.bins_nm;
// 			advicepop.ins_id = "";
			advicepop.cst_date = "";
			
// 			advicepop.cls_room = "";
			advicepop.cst_update_date = "";
			advicepop.cst_ctt = "";
			
			advicepop.action = "I";
			
			advicepop.delflag = false;		
			advicepop.isreadonly = true;
			selectComCombo("cls","cls_room","sel","", "");
			  		
    	}  else {
    		
    		advicepop.lec_nm = data.lec_nm;
    		//advicepop.std_nm = data.std_nm +" ("+ data.std_id +")";    
    		advicepop.std_nm = data.std_id;  
    		advicepop.ins_nm = data.ins_nm +" ("+ data.ins_id +")";
    		
    		advicepop.cst_date = data.cst_date;
//     		advicepop.cls_room = data.cls_room;
    		
    		advicepop.cst_update_date = data.cst_update_date;

    		advicepop.action = "U";  
        	
    		advicepop.cst_ctt = data.cst_ctt;
    		
    		
    		selectComCombo("cls","cls_room","sel","",data.cls_room);
    		
    		advicepop.cst_no = data.cst_no;
        	
    		advicepop.delflag = true;
    	}	
	}
	
	// 저장
	function fnSave(){
		
    	if(!fValidate()) {
    		return;
    	}
		
		var param = {
				action : advicepop.action,
				lec_cd : divStuList.blec_cd,
				cst_no : advicepop.cst_no,
				std_id : advicepop.std_nm,
				cst_date : advicepop.cst_date,
				cls_room : advicepop.cls_room,
				cst_update_date : advicepop.cst_update_date,
				cst_ctt : advicepop.cst_ctt,
				
// 				std_nm : $("#std_nm").val(),
// 				lec_nm : $("#lec_nm").val(),
// 				ins_nm : $("#ins_nm").val(),
// 				ins_id : $("#ins_id").val(),
// 				score : $("#score").val(),
		}
		
		
		
		var listcallback = function(returnData){
			console.log(JSON.stringify(returnData));
			
			if(returnData.resultMsg == "저장" || returnData.resultMsg == "수정" || returnData.resultMsg == "삭제") {
    			alert(returnData.resultMsg +" 되었습니다.");
    			gfCloseModal();
			
				if(advicepop.action == "I"){
					fn_findLecList();
				} else if(advicepop.action == "U"){
					fn_findLecList(divStuList.stdCurrentPage);
				} else if(advicepop.action == "D"){
					fn_findLecList(divStuList.stdCurrentPage);
				}
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
		
		advicepop.action = "D"; 
			fnSave();
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
							<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a>
							<span class="btn_nav bold">학습관리</span> 
							<span class="btn_nav bold">상담 관리</span>
							<a href="/tut/advice.do" class="btn_set refresh">새로고침</a>
						</p>

						<p id="searcharea" class="conTitle">
							<span>상담 관리</span> 
							<span class="fr"> 
								<a>강의명:</a>
							    <input type="text" id="searchText" name="searchText" v-model="searchText" style="width: 200px; height: 25px;" />
							    <a class="btnType blue" href="javascript:fnSearchList();" name="modal"><span>검색</span></a>
							</span>
						</p>
						
						<div id="divAdviceList"  class="divAdviceList">
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
								<tbody>
								<template v-if="totalcnt == 0">
								                <tr>   <td colspan=4> 데이터가 없습니다.  </td> </tr>
								      </template> 
								      <template v-else v-for="one in datalist">
								                <tr @click="fn_findLecList(one.lec_cd,one.lec_nm,one.ins_id,one.ins_nm)">
								                     <td>{{ one.lec_cd }}</td>
						                             <td>{{ one.lec_nm }}</td>
						                             <td>{{ one.lec_start_date }} ~ {{ one.lec_end_date }}</td>
						                             <td>{{ one.ins_nm }}</td>
								                </tr>
								      </template>
								
								</tbody>
							
							</table>
							<div class="paging_area"  id="pagingnavi" v-html="pagingnavi"> </div>
						</div>
	
						
						
					
					<h3 class="hidden">풋터 영역</h3>
					<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				
				
					<p  class="conTitle">
							<span>상담 목록</span> 
							<span class="fr"> 	
							    
								    <span>
									   학생명: <input type="text" id="dsearchText" name="dsearchText" v-model="dsearchText" style="width: 150px; height: 25px;" />
								    </span>
							    <a class="btnType blue" href="javascript:fn_findLecList();" name="modal"><span>검색</span></a>
							    <c:if test="${userType eq 'B' || userType eq 'C'}" >
							    	<a class="btnType blue" href="javascript:fn_openpopup();" name="modal"><span>상담등록</span></a>
							    </c:if>
							</span>
						</p>
		
				<div id="divStuList" class="divStuList">
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
						<tbody>
						  <template v-if="totalcnt == 0">
					                <tr>   <td colspan=6> 데이터가 없습니다.  </td> </tr>
					      </template> 
					      <template v-else v-for="one in Sdatalist">
					                <tr>
					                     <td>{{ one.cst_no }}</td>
			                             <td>{{ one.lec_nm }}</td>
			                             <td>{{ one.std_nm }} ({{ one.std_id }})</td>
			                             <td>{{ one.cst_date }}</td>
			                             <td>{{ one.ins_nm }} ({{ one.ins_id }})</td>
			                             <td> <a class="btnType3 color1" @click="fnSelect(one.cst_no)"><span>수정</span></a> </td>
					                </tr>
					      </template>
						</tbody>
					</table>
					<div class="paging_area"   id="advpagingnavi" v-html="advpagingnavi"> </div>
				</div>
				
				
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
                    <input type="text" class="inputTxt p100" name="lec_nm" id="lec_nm"  v-model="lec_nm" disabled/>
                </td>
                <th scope="row">학생명</th>
                <td>
                                        
                             <select name="std_nm" id="std_nm"  v-model="std_nm"> </select>
                         
<!--                             <input type="text" class="inputTxt p100" name="std_nm" id="std_nm"  v-model="std_nm" />  -->
             
                </td>
            </tr>
            <tr>
                <th scope="row">상담일자<span class="font_red">*</span></th>
                <td>
                    <input type="date" class="inputTxt p100" id="cst_date" name="cst_date"  v-model="cst_date"/>
                </td>
                <th scope="row">상담자</th>
                <td>
                    <input type="text" class="inputTxt p100" name="ins_nm" id="ins_nm"  v-model="ins_nm" readonly />
                </td>
            </tr>
            <tr>
                <th scope="row">최종 수정일자<span class="font_red">*</span></th>
                <td>
                    <input type="date" class="inputTxt p100" id="cst_update_date" name="cst_update_date"  v-model="cst_update_date" />
                </td>
                <th scope="row">상담장소<span class="font_red">*</span></th>
                <td>
                    <select id="cls_room" name="cls_room"  v-model="cls_room"></select>
                </td>
            </tr>
            <tr>
                <th colspan="4" scope="row">상담내용<span class="font_red">*</span></th>
            </tr>
            <tr>
                <td colspan="4">
                    <textarea rows="10" cols="50" name="cst_ctt" id="cst_ctt"  v-model="cst_ctt"></textarea>
                </td>
            </tr>
        </tbody>
    </table>

 
				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSave" name="btn"><span>저장</span></a> 
					<a href="" class="btnType blue" id="btnDelete" name="btn" v-show="delflag"><span>삭제</span></a> 
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
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>성적조회</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- a태그 커서 모양 -->
<style>
	a {cursor:pointer;}
</style>
              
<script type="text/javascript">
	// 페이징 설정
	var pageSize = 5;
	var pageBlockSize = 5;
	
	$(function() {
		
		// 뷰등록
		initVue();

		// 성적 조회
		fn_searchList();
	});
	
	var lecYN;
	var conTitle;
	var divComGrpCodList;
	var divComGrpCoddetail;
	
	// 뷰 등록 -------------
	function initVue(){
		
		// 강의 진행 여부
		lecYN = new Vue({
			el : "#lecYN",
			data : {
				show : "N"
			},
			methods : {
				showBtn : function(event){
					
					var targetID = event.currentTarget.id;
					
					if(targetID == 'ingLec') this.show = "N";
					else this.show = "Y";
					
					fn_searchList();
					divComGrpCoddetail.stuTotalcnt = 0;
				}
			}
		});
		
		
		// 검색 영역
		conTitle = new Vue({
			el : "#conTitle",
			data : {
				searchtext : ""
			},
			methods : {
				fn_searchList : function(){
					fn_searchList();
				}
			}
		});
		
		
		// 시험 목록 영역
		divComGrpCodList = new Vue({
			el : "#divComGrpCodList",
			data : {
				totalcnt : 0,
				gradeList : [],
				gradesPagination : "",
				currentPage : 0,
			},
			methods : {
				fn_findStdList : function(test_cd){
					fn_findStdList(test_cd);
				}
			}
		});
		
		
		// 시험명 클릭하여 성적보기
		divComGrpCoddetail = new Vue({
			el : "#divComGrpCoddetail",
			data : {
				stuTotalcnt : "",
				stuList : [],
				stuPagination : ""
			}
		});
		
	}
	// 뷰 등록 끝 ----------

	//------------- 성적조회 --------------------------
	
	
    function fn_searchList(currentPage) {
    	
    	var currentPage = currentPage || 1;
    	
    	var param = {
    			pageSize : pageSize,
    			currntPage : currentPage,
	   			searchtext : conTitle.searchtext,
	   			show : lecYN.show
    	}
    	
       var listcallback = function(returndata) {
    		
			divComGrpCodList.totalcnt = returndata.totalcnt;
			divComGrpCodList.gradeList = returndata.gradeList;
    		
    		var totalcnt = divComGrpCodList.totalcnt;
    		
    		var paginationHtml = getPaginationHtml(currentPage, totalcnt, pageSize, pageBlockSize, 'fn_searchList');
    		//console.log("paginationHtml : " + paginationHtml);
    		
			divComGrpCodList.gradesPagination = paginationHtml;

			// 현재 페이지 설정
			divComGrpCodList.currentPage = currentPage;
			
			
    	}
    	
    	callAjax("/tut/gradesListVue.do", "post", "json", true, param, listcallback);
    	
    }
	 
	 
	//------------- 강의 눌렀을 때 학생 목록 조회 --------------------------
	
	//페이징 설정
	var stuPageSize = 5;
	var stuPageBlockSize = 5;
	
	// 학생 목록 조회
	function fn_findStdList(test_cd){
		
		var test_cd = test_cd;
		
		var stuCurrentPage = null;
		
		fn_StdListSet(stuCurrentPage, test_cd);
		
	} 
	
	function fn_StdListSet(stuCurrentPage, test_cd){
		
		var test_cd = [test_cd];
		
		var stuCurrentPage = stuCurrentPage || 1; 
		
		var param = {
			stuPageSize : stuPageSize,
			stuCurrentPage : stuCurrentPage,
			test_cd : test_cd[0]
		}
		
		var listcallback = function(returndata) {
			
			divComGrpCoddetail.stuTotalcnt = returndata.stuTotalcnt;
			divComGrpCoddetail.stuList = returndata.stuList;
			
			var stuTotalcnt = divComGrpCoddetail.stuTotalcnt;
			
			var paginationHtml = getPaginationHtml(stuCurrentPage, stuTotalcnt, stuPageSize, stuPageBlockSize, 'fn_StdListSet', test_cd);
			
			divComGrpCoddetail.stuPagination = paginationHtml;
		}
		
		callAjax("/tut/stuListVue.do", "post", "json", true, param, listcallback);
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
							<span class="btn_nav bold">성적조회 </span> 
							<a href="/tut/checkGradesvue.do" class="btn_set refresh">새로고침</a>
						</p>
						
						<div id="lecYN" class="btn_areaA mt50">
							<a class="btnType blue" id="ingLec" name="showBtn" @click="showBtn"><span>진행중 강의</span></a> 
							<a class="btnType gray" id="endLec" name="showBtn" @click="showBtn"><span>종료된 강의</span></a>
						</div>

						<p id="conTitle" class="conTitle">
							<span>성적조회</span> 
							<span class="fr"> 
							    <input type="text" id="searchtext" name="searchtext" v-model="searchtext" style="width: 150px; height: 25px;" placeholder="강의명을 입력하세요" />
							    <a class="btnType blue" @click="fn_searchList" name="modal"><span>검색</span></a>
							</span>
						</p>
						
						<div id="divComGrpCodList" class="divComGrpCodList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="10%">
									<col width="35%">
									<col width="15%">
									<col width="20%">
									<col width="20%">
								</colgroup>
	
								<thead>
									<tr>
										<th colspan="5">성적 조회</th>
									</tr>
									<tr>
										<th scope="col">시험번호</th>
										<th scope="col">시험명</th>
										<th scope="col">시험 시작일</th>
										<th scope="col">시험 종료일</th>
										<th scope="col">강의명</th>
									</tr>
								</thead>
								<tbody>
									<template v-if="totalcnt == 0">
										<tr>
											<td colspan="5">데이터가 존재하지 않습니다.</td>
										</tr>
									</template>
									<template v-else v-for="list in gradeList">
										<tr>
											<td>{{ list.test_cd }}</td>
											<td><a @click="fn_findStdList(list.test_cd)">{{ list.test_nm }}</a></td>
											<td>{{ list.test_start_date }}</td>
											<td>{{ list.test_end_date }}</td>
											<td>{{ list.lec_nm }}</td>
										</tr>
									</template>
								</tbody>
							</table>
							
							<div class="paging_area"  id="gradesPagination" v-html="gradesPagination"> </div>
						</div>
	
						
						<div>  &nbsp;</div>
						
						<div id="divComGrpCoddetail" class="divComGrpCoddetail">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="20%">
									<col width="20%">
									<col width="20%">
									<col width="20%">
									<col width="20%">
								</colgroup>
	
								<thead>
									<tr>
										<th colspan="5">시험 응시 상황</th>
									</tr>
									<tr>
										<th scope="col">학생 ID</th>
										<th scope="col">학생이름</th>
										<th scope="col">점수</th>
										<th scope="col">합격여부</th>
										<th scope="col">응시일</th>
									</tr>
								</thead>
								<tbody>
									<template v-if="stuTotalcnt == 0">
										<tr>
											<td colspan="5">데이터가 존재하지 않습니다.</td>
										</tr>
									</template>
									<template v-else v-for="list in stuList">
										<tr>
											<td>{{ list.loginId }}</td>
											<td>{{ list.name }}</td>
											<td>{{ list.score }}</td>
											<td>
												<template v-if="list.test_state == 'Y'">
													합격
												</template>
												<template v-else>
													불합격
												</template>
											</td>
											<td>{{ list.test_sm_date }}</td>
										</tr>
									</template>
								</tbody>
							</table>
							
							<div class="paging_area"  id="stuPagination" v-html="stuPagination"> </div>
						</div>
						
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>
	
</form>
</body>
</html>
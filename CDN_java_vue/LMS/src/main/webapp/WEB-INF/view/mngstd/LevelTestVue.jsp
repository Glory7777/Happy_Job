<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>시험응시</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

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
                     <a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a> <span class="btn_nav bold">학습관리</span> 
                     <span class="btn_nav bold">수강목록</span> <a href="/std/registerList.do" class="btn_set refresh">새로고침</a>
                  </p>

                  <p class="conTitle">
                     <span>시험 응시</span> <span class="fr">
                     </span>
                  </p>
                  
                  <div class="divComGrpCodList" id="testAllList">    
                     <table class="col">
                        <caption>caption</caption>
                        <colgroup>
                           <col width="15%">
                           <col width="10%">
                           <col width="25%">
                           <col width="15%">
                           <col width="15%">
                           <col width="15%">
                        </colgroup>
   
                        <thead>
                           <tr>
                              <th scope="col">강의명</th>
                              <th scope="col">시험명</th>
                              <th scope="col">시험응시기간</th>
                              <th scope="col">강사명</th>
                              <th scope="col">시험응시상태</th>
                              <th scope="col">비고</th>
                           </tr>
                        </thead>
                        <tbody>
                        	<tr v-if="testList.length == 0"><td colspan=6>조회된 내용이 없습니다.</td></tr>
	                       	<tr v-else v-for="list in testList">
		                   		<td>{{list.lec_nm}}</td>
		                   		<td>{{list.test_nm}}</td>
		                   		<td>{{list.test_start_date}} ~ {{list.test_end_date}}</td>
		                   		<td>{{list.loginID}}</td>
		                   		<template v-if="list.test_state == 'Y'">
		                    		<td>응시완료</td>
		                   		</template>
		                   		<template v-else>
		                    		<td>미응시</td>
		                   		</template>
		                   		<template v-if="list.test_state == 'Y'">
		                   			<td><a @click="confirm(list.test_cd, list.lec_cd)" class="btnType blue" id="btntest" name="btn"><span>결과보기</span></a></td>
		                  			</template>
		                   		<template v-else>
		                   			<td><a @click="fn_start(list.test_cd)" class="btnType blue" id="btntest" name="btn"><span>응시하기</span></a></td>
		                  		</template>
	                       	</tr>
                        </tbody>
                     </table>
                  </div>

               </div> <!--// content -->
               <h3 class="hidden">풋터 영역</h3>
                  <jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
            </li>
         </ul>
      </div>
   </div>


      <!--시험풀기 모달  -->
      <div id="testfighting" class="layerPop layerType2" style="width: 1000px;">
         <dl>
            <dt>
               <strong>시험응시</strong>
            </dt>
            <dd class="content">
               <!-- s : 여기에 내용입력 -->
               <table class="row">
                  <caption>caption</caption>
                  <colgroup>
                     <col width="120px">
                     <col width="*">
                     <col width="120px">
                     <col width="*">
                  </colgroup>

                  <tbody>
                     <tr id ="Hide">
                              <th scope="row">시험명</th>
                              <td id="test_date" v-text="test_date"></td>
                     </tr>
                      <tr id ="Hide">
                              <th scope="row">배점</th>
                              <td id="score" v-text="score"></td>
                     </tr>                                                           
                     <tr>
                        <th scope="row">문제<span class="font_red"></span></th>
                           <td colspan="3">
                              <div class="divComGrpCodList">    
                              <table class="col">
                                 <caption>caption</caption>
                                 <colgroup>
                                    <col width="5%">
                                    <col width="20%">
                                    <col width="15%">
                                    <col width="15%">
                                    <col width="15%">
                                    <col width="15%">
                                    <col width="5%">
                                 </colgroup>
            
                                 <thead>
                                    <tr>
                                       <th scope="col">번호</th>
                                       <th scope="col">문제</th>
                                       <th scope="col">보기1</th>
                                       <th scope="col">보기2</th>
                                       <th scope="col">보기3</th>
                                       <th scope="col">보기4</th>
                                       <th scope="col">정답</th>
                                    </tr>
                                 </thead>
                                 <tbody>
                                 <template v-if="detailtest.length === 0">
                                 	<tr><td>조회된 내용이 없습니다.</td></tr>
                                 </template>
                                 <template v-else v-for="(list, i) in detailtest">
                                 	<tr>
                                 		<td>{{list.test_que_cd}}</td>
                                 		<td>{{list.test_que_ctt}}</td>
                                 		<td>{{list.test_opt_1}}</td>
                                 		<td>{{list.test_opt_2}}</td>
                                 		<td>{{list.test_opt_3}}</td>
                                 		<td>{{list.test_opt_4}}</td>
                                 		<td><input type="text" v-model="testfighting.answer[i]" style="width: 20px;" maxlength="1" @keypress="isNumber()"></td>
                               		</tr>
	                              </template>
                                 </tbody>
                              </table>
                              </div>
                           </td>
                     </tr>                        
                  </tbody>
               </table>


               <!-- e : 여기에 내용입력 -->

               <div class="btn_areaC mt30">
                  <a @click="fn_submit();" class="btnType blue" id="btnSave" name="btn"><span>제출</span></a>
                  <a href="" class="btnType gray" id="btnClose" name="btn"><span>닫기</span></a>
               </div>
            </dd>
         </dl>
         <a href="" class="closePop"><span class="hidden">닫기</span></a>
      </div>



      <!--시험결과확인 모달  -->
      <div id="resultfighting" class="layerPop layerType2" style="width: 1000px;">
         <dl>
            <dt>
               <strong>시험응시</strong>
            </dt>
            <dd class="content">
               <!-- s : 여기에 내용입력 -->
               <table class="row">
                  <caption>caption</caption>
                  <colgroup>
                     <col width="120px">
                     <col width="*">
                     <col width="120px">
                     <col width="*">
                  </colgroup>

                  <tbody>
                     <tr id ="Hide">
                              <th scope="row">응시일</th>
                              <td id="test_date2" v-text="test_date2"></td>
                     </tr>
                      <tr id ="Hide">
	                      <th scope="row">총점</th>
	                      <td id="totalscore" v-text="totalscore"></td>
                     </tr>  
                     <tr id ="Hide">
	                     <th scope="row">합격여부</th>
	                     <td id="tststate" v-text="tststate"></td>
                     </tr>     
                     <tr>
                         <th scope="row">문제<span class="font_red"></span></th>
                             <td colspan="3" style="overflow: auto;">
                                 <div class="divComGrpCodList">    
                                 <table class="col">
                                 <caption>caption</caption>
                                 <colgroup>
                                     <col width="5%">
	                                 <col width="20%">
	                                 <col width="15%">
	                                 <col width="15%">
	                                 <col width="15%">
	                                 <col width="15%">
	                                 <col width="5%">
	                                 <col width="5%">
	                                 <col width="5%">
                                 </colgroup>
                                 <thead>
                                     <tr>
                                         <th scope="col">번호</th>
                                         <th scope="col">문제</th>
                                         <th scope="col">보기1</th>
                                         <th scope="col">보기2</th>
                                         <th scope="col">보기3</th>
                                         <th scope="col">보기4</th>
                                         <th scope="col">정답</th>
                                         <th scope="col">내정답</th>
                                         <th scope="col">맞음유무</th>
                                    </tr>
                                 </thead>
                                 <tbody>
                                     <tr v-for="list in resultList2">
		                                 <td>{{list.test_que_cd}}</td>
		                                 <td>{{list.test_que_ctt}}</td>
		                                 <td>{{list.test_opt_1}}</td>
		                                 <td>{{list.test_opt_2}}</td>
		                                 <td>{{list.test_opt_3}}</td>
		                                 <td>{{list.test_opt_4}}</td>
		                                 <td>{{list.test_cor_ans}}</td>
		                                 <td>{{list.sm_ans}}</td>
		                                 <td>{{list.cor_yn}}</td>
                                 	</tr>
                                 </tbody>
                              </table>
                              </div>
                           </td>
                     </tr>                        
                  </tbody>
               </table>


               <!-- e : 여기에 내용입력 -->

               <div class="btn_areaC mt30">
                  <a href="" class="btnType gray" id="btnClose" name="btn"><span>닫기</span></a>
               </div>
            </dd>
         </dl>
         <a href="" class="closePop"><span class="hidden">닫기</span></a>
      </div>





</form>
</body>
</html>


<script type="text/javascript">

   //그룹코드 페이징 설정
/*    var pageSize = 1;
   var pageBlockSize = 5; */

   
   /* 
   
         [2023-10-05 백한결작업 ]
         아직못한 부분 + 아쉬운부분 
         1) 답안 input 유효성검사 => 숫자만 가능하도록 + 1~4까지만 가능하도록 
         2) 페이징처리 시간없어서 걍 버렸음  => 안할거임 ㅠㅠ 
         3) score 를 testManage 쪽과 testbank 쪽에서 다양하게 설정을 안한 부분 => 추 후 진행예정 
		 4) 모달 안가져온 부분 [데이터는 가져옴]
         
   */
   
   var testAllList;
   var testfighting;
   var resultfighting;
   
   $(function() {
      
	  vueinit();
	  
      // 강의 목록 조회
      fn_searchlist();

   });
		 
   function	vueinit(){
	   
	   // 응시 가능한 시험 목록 Vue 선언
	   testAllList = new Vue({
		   el: "#testAllList",
		   data: {
			   testList : [],
			   lec_cd : "",
			   test_cd : "",
			   loginID : "",
			   
		   },
		   methods: {
			   confirm: function(test_cd, lec_cd){
				   confirm(test_cd, lec_cd);
			   },
			   fn_start : function(test_cd){
				   fn_start(test_cd);
			   }
		   }
	   });
	   
	   // 시험 응시 Vue 선언
	   testfighting = new Vue({
		   el: "#testfighting",
		   data: {
			   detailtest: [],
			   test_date: "",
			   score: "",
			   loginID : "",
			   answer: [],
			   // tb_test_submit
			   lec_cd : "",      // 과목번호
			   total_Score : 0, 
	  		   test_state : "",  // 시험응시여부
	  		   test_sm_date : "", // 시험응시날짜
			   test_cd : "",      // 시험번호
			   //tb_sm_ans
			   test_que_cd : "",  // 시험문제번호
			   sm_ans : "",       // 나의 답
			   cor_yn : "",       // 정답
			   score : "",        // 배점
		   },
		   methods: {
			   isNumber : function(){
				   isNumber();
			   },
			   fn_submit : function() {
				   fn_submit();
			   }			
		   }
	   });
	   
	   // 시험 결과 Vue 선언
	   resultfighting = new Vue({
		   el : "#resultfighting",
		   data : {
			   resultList : [],
			   resultList2 : [],
			   test_date2 : "",
			   tststate: "",
			   totalscore : ""
			   /* test_que_cd : [],
			   test_que_ctt : [],
			   test_opt_1 : [],
			   test_opt_2 : [],
			   test_opt_3 : [],
			   test_opt_4 : [],
			   test_cor_ans : [],
			   sm_ans : [],
			   cor_yn : [] */
		   }   
	   });
   }	
   
   function isNumber(){
	   if(event.keyCode < 49 || event.keyCode > 52){
       	   event.returnValue = false;
	   }
   }

   /* 초기페이지 */
   function fn_searchlist(){
      
      var listcallback = function(returndata){
         console.log(returndata);
          
         testAllList.test_cd = returndata.testList[0].test_cd;
         testAllList.lec_cd = returndata.testList[0].lec_cd;
         testAllList.testList = returndata.testList;
      }
       callAjax("/std/testList.do", "post", "json", true, "", listcallback); 
      
   }
   
  	   /* 응시하기 눌렀을 때 모달 띄우기 */
       function fn_start(test_cd) {
          console.log(test_cd);
          
          var param={
          	test_cd : test_cd
          }
          
          var listcallback = function(returndata){
	          console.log(returndata);
	          //answerLists = returndata;
			  
	          testfighting.detailtest = returndata.detailview;
	          
	          testfighting.test_date = returndata.detailview[0].test_nm;
	          console.log("시험명:"+returndata.detailview[0].test_nm);
	          testfighting.score = returndata.detailview[0].score;
	          
	          testfighting.lec_cd = returndata.detailview[0].lec_cd;
	          testfighting.test_cd = returndata.detailview[0].test_cd;
	          
	          gfModalPop("#testfighting");
          }
          callAjax("/tut/detailview.do", "post", "json", true, param, listcallback); 
       }
   
   /* 오늘날짜구하기[시험응시일] */
   var today = new Date();
   
   var year = today.getFullYear();
   var month = ('0' + (today.getMonth() + 1)).slice(-2);
   var day = ('0' + today.getDate()).slice(-2);
   
   var dateString = year + '-' + month  + '-' + day;


    /* 시험제출하기 */            
    function fn_submit() {
        testfighting.lec_cd = testAllList.lec_cd;
        
        testfighting.loginID = testAllList.loginID;
        testfighting.test_cd = testAllList.test_cd;
        
        console.log(testfighting.answer);
         
         // null 값 체크
         for(var i = 0; i < testfighting.answer.length; i++) {
        	 if(testfighting.answer[i] == null || testfighting.answer[i] == '') {
        		 return alert("값을 모든 항목에 맞추어서 입력해주시길 바랍니다.");
        	 }
         }
         
         for(var i = 0; i < testfighting.answer.length; i++) { 
                 if(testfighting.detailtest[i].test_cor_ans == testfighting.answer[i]) {
                     testfighting.test_que_cd = testfighting.detailtest[i].test_que_cd;
                	 testfighting.sm_ans = testfighting.answer[i];
                	 testfighting.cor_yn = 'Y';
                	 testfighting.score = 20;
                    
                	 testfighting.total_Score += 20;
                     
                 } else {
                     testfighting.test_que_cd = testfighting.detailtest[i].test_que_cd;
                	 testfighting.sm_ans = testfighting.answer[i];
                	 testfighting.cor_yn = 'N';
                	 testfighting.score = 0;
                 }
                 console.log(testAllList.lec_cd);
                 var param={
                       lec_cd : testAllList.lec_cd,
                       test_cd : testAllList.test_cd,
                       test_que_cd : testfighting.test_que_cd,
                       sm_ans : testfighting.sm_ans,
                       cor_yn : testfighting.cor_yn,
                       score : testfighting.score
                 }

           var listcallback = function(returndata){
              console.log(testfighting.total_Score);
           }
           callAjax("/std/TestSubmit.do", "post", "json", false, param, listcallback); 
         }
         console.log(testfighting.total_Score);
         
         /* 추가 -- 안쓰는데 param2에 보내야하기 때문에 걍 활성화함 */ 
         
          if(testfighting.sm_ans != null || testfighting.sm_ans != "" ){ 
        	  testfighting.test_state ='Y';
         }else{ 
        	 testfighting.test_state ='N';
         } 
         console.log(testfighting.test_state);
    
         var param2 ={
               lec_cd : testAllList.lec_cd,
               test_cd : testAllList.test_cd,
               total_Score : testfighting.total_Score,
               test_state: testfighting.test_state,
               test_sm_date : dateString
         }
         console.log("param:::" + param2.test_state); //총점수 + test_state + test_sm_date 
         
          var listcallback = function(returndata){
             console.log(returndata);
             
             if(returndata.TestResult ==1){
            	 swal("답안제출이 완료되었습니다");
				
                //confirm();
                  gfCloseModal();
                  
                  fn_searchlist();
                  
             }else{
                swal("답안제출이 실패되었습니다");
             }
         }
        callAjax("/std/TestSubmit2.do", "post", "json", true, param2, listcallback); 
  } 
    

         
    /*시험결과조회 */     
    function confirm(test_cd, lec_cd) {

	    /* 2차작업 */	
	       var param ={
	            test_cd : test_cd,
	    		lec_cd : lec_cd
	       }
       	   console.log("시험결과 구하기위해 넘긴 값 : " + param);
	    
           var listcallback = function(returndata){
		       //resultfighting.resultList2 = returndata.resultList2;
           	   
	           resultfighting.test_date2 = returndata.resultList[0].test_sm_date;
	           resultfighting.totalscore = returndata.resultList[0].score;
	           
	           if(returndata.resultList[0].score >= 60){
	               resultfighting.tststate = "합격" 
	           }
	           else {
	               resultfighting.tststate = "불합격" 
	           }
	           
	           resultfighting.resultList2 = returndata.resultList2;
	           console.log("시험결과 문제 : " + resultfighting.resultList2);

               gfModalPop("#resultfighting");
      	   }
      	   callAjax("/std/Testconfirm.do", "post", "json", true, param, listcallback);
  	}     
</script>
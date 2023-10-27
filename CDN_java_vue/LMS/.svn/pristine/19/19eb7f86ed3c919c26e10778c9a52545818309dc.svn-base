<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>수강 목록</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<body>
<form id="myForm" action=""  method="">

   <input type="hidden" name="name" id="loginId" value="${loginId}">
   <input type="hidden" id="action" />

    
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
                     <span class="btn_nav bold">시험문제관리</span> <a href="/tut/testControlvue.do" class= "btn_set refresh">새로고침</a>
                  </p>

                  <p class="conTitle" id="button">
                     <span>시험문제관리</span>
                     <span class="fr" id="main">
                         <a class="btnType blue" @click="fn_paperMade();" name="modal" id="mkTestPaper"><span>시험지만들기</span></a>
                         <a class="btnType blue" @click="fn_openpopup()" name="modal" id="mkProblem" v-show="signflag"><span>문제등록</span></a>
                     </span>
                  
                   <span>
                         <a @click="fn_paperDate()" class="btnType blue" id="btnSavetest" v-show="saveflag" style="display:none;"><span>문항선택완료</span></a>              
                     </span>
                  </p>
                  
                  <div class="divComGrpCodList" id="question">  
                     <table class="col">
                        <caption>caption</caption>
                        <colgroup>
                           <col width="5%">
                           <col width="10%">
                           <col width="10%">
                           <col width="10%">
                           <col width="10%">
                           <col width="10%">
                           <col width="10%">
                           <col width="10%">
                           <col width="10%">
                        </colgroup>
   
                        <thead>
                      <tr>
                          <th colspan="10" scope="col">문제목록</th>
                      </tr>
                           <tr>
                              <th scope="col">선택</th>
                              <th scope="col">문제번호</th>
                              <th scope="col">문제</th>
                              <th scope="col">정답</th>
                              <th scope="col">보기1</th>
                              <th scope="col">보기2</th>
                              <th scope="col">보기3</th>
                              <th scope="col">보기4</th>
                          <th colspan="2" scope="col">비고</th>
                           </tr>

                        </thead>
                        <tbody>
                        	<tr v-if="questionList.length === 0"><td colspan=9>조회된 내용이 없습니다.</td></tr>
                        	<tr v-else v-for="list in questionList">
                        		<td><input type="checkbox" name="radiobox(list.test_que_cd)" :value="list.test_que_cd" v-model="questionCheck" @click="handleRadioClick(list.test_que_cd)"></td>
                        		<td>{{list.test_que_cd}}</td>
                        		<td>{{list.test_que_ctt}}</td>
                        		<td>{{list.test_cor_ans}}</td>
                        		<td>{{list.test_opt_1}}</td>
                        		<td>{{list.test_opt_2}}</td>
                        		<td>{{list.test_opt_3}}</td>
                        		<td>{{list.test_opt_4}}</td>
                        		<td><a class="btnType blue" @click="fn_modify(list.test_que_cd)" name="modal"><span>수정</span></a></td>
                        		<td><a class="btnType blue" @click="fn_delete(list.test_que_cd)" name="modal"><span>삭제</span></a></td>
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
   
      <!-- 시험문제 등록 모달팝업  -->
      <div id="testBankpop" class="layerPop layerType2" style="width: 600px;">
         <dl>
            <dt>
               <strong>시험문제 등록</strong>
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
                              <th scope="row">문제번호</th>
                              <td>
                                 <input type="text" class="inputTxt p50" name="test_que_cd" id="test_que_cd" v-model="test_que_cd" :readonly="!isreadonly" disabled placeholder="랜덤생성됩니다.">
                              </td>
                              <th scope="row">정답</th>
                              <td>
                                 <input type="text" class="inputTxt p50" name="test_cor_ans" id="test_cor_ans" v-model="test_cor_ans" />
                              </td>
                     </tr>
                     <tr>
                        <th scope="row">문제<span class="font_red">*</span></th>
                        <td colspan="3"><input type="text" class="inputTxt p100" name="test_que_ctt" id="test_que_ctt" v-model="test_que_ctt" /></td>
                     </tr>
                     <tr>
                        <th scope="row">보기1 <span class="font_red"></span></th>
                        <td colspan="3"><input type="text" class="inputTxt p100"name="test_opt_1" id="test_opt_1" v-model="test_opt_1" /></td>
                     </tr>
                     <tr>
                        <th scope="row">보기2 <span class="font_red"></span></th>
                        <td colspan="3"><input type="text" class="inputTxt p100"name="test_opt_2" id="test_opt_2" v-model="test_opt_2" /></td>
                     </tr>
                     <tr>
                        <th scope="row">보기3 <span class="font_red"></span></th>
                        <td colspan="3"><input type="text" class="inputTxt p100"name="test_opt_3" id="test_opt_3" v-model="test_opt_3" /></td>
                     </tr>
                     <tr>
                        <th scope="row">보기4 <span class="font_red"></span></th>
                        <td colspan="3"><input type="text" class="inputTxt p100"name="test_opt_4" id="test_opt_4" v-model="test_opt_4" /></td>
                     </tr>                                         
                  </tbody>
               </table>

               <!-- e : 여기에 내용입력 -->

               <div class="btn_areaC mt30">
                  <a @click="fn_save()" class="btnType blue" id="btnSave" name="btn" v-html="btnSave"><span></span></a>
                  <a @click="fn_reset()" class="btnType blue" id="btnDelete" name="btn" v-html="btnDelete"><span></span></a>
                  <a href="" class="btnType gray" id="btnClose" name="btn"><span>취소</span></a>
               </div>
            </dd>
         </dl>
         <a href="" class="closePop"><span class="hidden">닫기</span></a>
      </div>
      
      
        <!-- 시험지 만들기 모달팝업 -->
        <div id="TestPaper" class="layerPop layerType2" style="width: 600px;">
         <dl>
            <dt>
               <strong>시험문제 등록</strong>
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
	                     <td>
	                        <input type="text" class="inputTxt p100" name="test_name" id="test_name" v-model="test_name"/>
	                     </td>
                     </tr>
                     <tr>
	                     <th scope="row">시험차수<span class="font_red"></span></th>
	                     <td colspan="3"><input type="text" class="inputTxt p100" name="test_cd" id="test_cd" v-model="test_cd" style="width: 50%;"/></td>
                     </tr> 
                     <tr>
	                     <th scope="row">강의선택<span class="font_red">*</span></th>
	                     <td colspan="3">
	                         <select id="selectBox" @change="selectBoxChg">
	                            <option :value="empty">선택해주세요</option>
	                            <template v-for="list in selectList">
	                            	<option :value="list.lec_cd" >{{list.lec_nm}}</option>
	                            </template>
	                         </select>
	                     </td>
                     </tr>
                     <tr>
                         <th scope="row">시험시작일<span class="font_red"></span></th>
                     	 <td colspan="3"><input type="date" class="inputTxt p100" name="test_start_date" id="test_start_date" v-model="test_start_date" /></td>
                     </tr>
                     <tr>
	                     <th scope="row">시험종료일<span class="font_red"></span></th>
	                     <td colspan="3"><input type="date" class="inputTxt p100"name="test_end_date" id="test_end_date" v-model="test_end_date" style="width: 50%;"/></td>
                     </tr>                                         
                  </tbody>
               </table>

               <!-- e : 여기에 내용입력 -->

               <div class="btn_areaC mt30">
                  <a @click="fn_regi();" class="btnType blue" id="btnSave" name="btn"><span>시험둥록</span></a>
                  <a @click="fn_reset2()" class="btnType blue" id="btnDelete" name="btn"><span>모든내용삭제</span></a>
                  <a href="" class="btnType gray" id="btnClose" name="btn"><span>취소</span></a>
               </div>
            </dd>
         </dl>
         <a href="" class="closePop"><span class="hidden">닫기</span></a>
      </div>
      
</form>
</body>
</html>


<script type="text/javascript">

   var button;	
   var question;	
   var TestPaper;	
   var testBankpop;	

   $(function() {
	  
	  vueinit(); 
	   
      fn_searchlist();
      
      selectlist(); // 시험등록버튼 누를 시 모달의 selectBOX
   });
   
   function vueinit(){
	   
	   button = new Vue({
		   el : "#button",
		   data : {
			   //makeflag : true,
			   signflag : true,
			   saveflag : false
		   },
		   methods : {
			  /*  fn_paperMade : function(){
				   fn_paperMade();
			   }, */
			   fn_openpopup : function(){
				   fn_openpopup();
			   }
		   }
	   });
	   
	   question = new Vue({
		   el : "#question",
		   data : {
			   questionList : [],
			   test_que_cd : "",
			   test_cor_ans : "",
			   questionCheck : []
		   },
		   methods : {
			   fn_modify : function(test_que_cd){
				   fn_modify(test_que_cd);
			   },
			   fn_delete : function(test_que_cd){
				   fn_delete(test_que_cd);
			   }
		   }
	   });
	   
	   TestPaper = new Vue({
		   el: "#TestPaper",
		   data: {
			   selectList : [],
			   selectBox : "",
			   test_name : "",
			   test_cd : "",
			   test_start_date : "",
 			   test_end_date : "",
 			   empty : "",
		   },
		   methods : {
			   fn_regi : function(){
				   fn_regi();
			   },
			   fn_reset2 : function(){
				   fn_reset2();
			   },
			   selectBoxChg : function(event){
				   this.selectBox = event.target.value;
				   console.log(this.selectBox);
			   }
		   }
	   });
	   
	   testBankpop = new Vue({
		   el : "#testBankpop",
		   data : {
			   selectview : [],
			   action : "",
			   test_que_cd : "",
			   isreadonly : false,
			   test_cor_ans : "",
			   test_que_ctt : "",
			   test_opt_1 : "",
			   test_opt_2 : "",
			   test_opt_3 : "",
			   test_opt_4 : "",
			   btnSave : "",
			   btnDelete : ""
		   }
	   });
   }

   /*selectBox*/
   function selectlist(){
     
     var listcallback = function(returndata){
        console.log(returndata);
        
        TestPaper.selectList =  returndata.selectlist;
        TestPaper.selectBox =  returndata.selectlist.lec_cd;
     }
     callAjax("/tut/selectlist.do", "post", "json", true, "", listcallback); 
  } 

   
   /*초기페이지 */
   function fn_searchlist(){
      
      var listcallback = function(returndata){
            
//          console.log(returndata);
         
         question.questionList = returndata.testBankList;
      }
      callAjax("/tut/testBankALLList.do", "post", "json", true, "", listcallback);  
   }
   
   /* 단건조회 */
   function fn_modify(data){

       var param={
           test_que_cd : data
       }
         
       var listcallback = function(returndata){
    	testBankpop.selectview = returndata.selectview;
       	fn_popupint(returndata.selectview); 
       	console.log("문제수정 ::::::" + JSON.stringify(returndata.selectview));
         
        gfModalPop("#testBankpop");
      }
      callAjax("/tut/selectview.do", "post", "json", true, param, listcallback);  
   }
   
   /* 모달데이터작업 */
   function fn_popupint(data) {
      
      //console.log("data[0].test_cor_ans:::::::"+ data[0].test_cor_ans);

   	  var htmlSave = "<span>신규등록</span>";
   	  var htmlDel = "<span>내용전부삭제</span>";
      
      if(data == null || data== undefined || data ==""){ //신규등록시
         
    	  testBankpop.action ="I";
    	  testBankpop.test_que_cd = "";
    	  testBankpop.isreadonly = true;
          
    	  testBankpop.test_cor_ans = "";
    	  testBankpop.test_que_ctt = "";
    	  testBankpop.test_opt_1 = "";
    	  testBankpop.test_opt_2 = "";
    	  testBankpop.test_opt_3 = "";
    	  testBankpop.test_opt_4 = "";
          
    	  testBankpop.btnSave = htmlSave;
    	  testBankpop.btnDelete = htmlDel;
          
      }else{ //수정시
    	  console.log("data:::::::::::" + data);
    	  console.log("test_que_cd:::::::::::" + data[0].test_que_cd);
          testBankpop.action ="U";
    	  testBankpop.test_que_cd = data[0].test_que_cd;
    	  testBankpop.isreadonly = true;
          
    	  testBankpop.test_cor_ans = data[0].test_cor_ans;
    	  testBankpop.test_que_ctt = data[0].test_que_ctt;
    	  testBankpop.test_opt_1 = data[0].test_opt_1;
    	  testBankpop.test_opt_2 = data[0].test_opt_2;
    	  testBankpop.test_opt_3 = data[0].test_opt_3;
    	  testBankpop.test_opt_4 = data[0].test_opt_4;
         
    	  testBankpop.btnSave = htmlSave;
    	  testBankpop.btnDelete = htmlDel;
      }
   }
   
  
   //데이터신규등록시
   function fn_openpopup() {
	   
      //데이터작업
      fn_popupint();
      
      // 모달 팝업
      gfModalPop("#testBankpop");
   
   } 


   
   
   /* 저장하기, 수정하기 */
   function fn_save() {
      console.log(testBankpop.action);
      
      if( testBankpop.action == "D" ){
         var param={
               action : testBankpop.action,
               test_que_cd : testBankpop.test_que_cd
         }
      }

      if( testBankpop.action =="U" || testBankpop.action =="I" ){
         
               if(testBankpop.test_cor_ans == ""){
                  swal("정답을 입력하세요");
                  return false
               
               }else if(isNaN(testBankpop.test_cor_ans)){
                  swal("숫자로 정답을 입력하세요");
                  return 
                  
               }else if(testBankpop.test_que_ctt == ""){
                  swal("문제를 입력하세요");
                  return      
                  
               }else if(testBankpop.test_opt_1 == ""){
                  swal("보기1을 입력하세요");
                  return  
                  
               }else if(testBankpop.test_opt_2 == ""){
                  swal("보기2을 입력하세요");
                  return    
                  
               }else if(testBankpop.test_opt_3 == ""){
                  swal("보기3을 입력하세요");
                  return   
                  
               }else if(testBankpop.test_opt_4 == ""){
                  swal("보기4을 입력하세요");
                  return            
               }
      
            var param={
                  action : testBankpop.action,
                  test_que_cd : testBankpop.test_que_cd,
                  test_cor_ans : testBankpop.test_cor_ans,
                  test_que_ctt : testBankpop.test_que_ctt,
                  test_opt_1 : testBankpop.test_opt_1,
                  test_opt_2 : testBankpop.test_opt_2,
                  test_opt_3 : testBankpop.test_opt_3,
                  test_opt_4 : testBankpop.test_opt_4,
                  test_que_type : testBankpop.test_que_type
            }
      }
      console.log(param);
      
      var listcallback = function(returndata){
         console.log(returndata);
         
         if(returndata > 0){
            swal("저장되었습니다");
            gfCloseModal();
            fn_searchlist();
            
         }else if(returndata == 0){
            swal("실패하였습니다");
            gfCloseModal();
            fn_searchlist();            
         }
      }
      callAjax("/tut/testsave.do", "post", "json", true, param, listcallback);  
   }
   
   
   /* 삭제 */
   function fn_delete(data){
      
	  testBankpop.test_que_cd = data;
      testBankpop.action ="D";
      
      removeCheck();
      
      function removeCheck() {

          if (confirm("정말 삭제하시겠습니까??") == true){  
              fn_save();
          }else{   //취소
              return false;
          }
      }
   }
   
   /* 내용리셋 */
   function fn_reset() {
 
	   testBankpop.test_cor_ans = "";
	   testBankpop.test_que_ctt = "";
	   testBankpop.test_opt_1 = "";
	   testBankpop.test_opt_2 = "";
	   testBankpop.test_opt_3 = "";
	   testBankpop.test_opt_4 = "";
   }

   
   /* 시험지등록부분의 내용리셋  */
   function fn_reset2(){
      
	   TestPaper.test_name = "";
	   TestPaper.test_cd = "";
	   TestPaper.selectBox = "";
	   TestPaper.test_start_date = "";
	   TestPaper.test_end_date = "";
   }
   
   /* 데이터 들어오는지 확인 ㄱ*/
   function handleRadioClick(data) {
      
	  question.test_que_cd = data;
      console.log(question.test_que_cd);
   }
   
   /* 시험지만들기*/
   function fn_paperMade(){
      
      gfModalPop("#TestPaper"); //모달열린 후 시험지 main정보 작성

      //fn_paperDate();

   }

//    /* 시험등록버튼 */
   function fn_regi() {
      
            if( TestPaper.test_name == null || TestPaper.test_name == "" ){
                  alert("시험명을 입력하세요!");
                  return false
               }
           
            if( TestPaper.test_cd == null || TestPaper.test_cd == "" ){
               alert("시험차수를 입력하세요!");
               return
            }
         
            if( TestPaper.selectBox == null || TestPaper.selectBox == "" ){
               alert("강의를 선택하세요!");
               return
            }
            
            /* 시험지 등록 날짜 유효성*/
            var today = new Date();
      
            var year = today.getFullYear();
            var month = ('0' + (today.getMonth() + 1)).slice(-2);
            var day = ('0' + today.getDate()).slice(-2);
      
            var dateString = year + '-' + month  + '-' + day;
            
      
            if( TestPaper.test_start_date == null || TestPaper.test_start_date == "" ){
               alert("시험 시작일을 입력하세요!");
               return
            }
            
            
            if( TestPaper.test_start_date < dateString ){
               alert("시험 시작일자가 잘못 선택되었습니다. 확인해주세요!");
               return
            }
            
            
            if( TestPaper.test_end_date == null || TestPaper.test_end_date == "" ){
               alert("시험종료일을 입력하세요!");
               return
            }
            
            if( TestPaper.test_end_date <  TestPaper.test_start_date ){
               alert("시험종료일자 선택이 잘못되었습니다. 확인해주세요!");
               return
            }
            
            
            var param = {
            		test_cd : TestPaper.test_cd
            }
            
            var listcallback = function(returndata) {
            	console.log(returndata);
            	
            	if (returndata.checkTestIdYn == "N") {
            		swal("해당 차수는 이미 생성된 차수입니다. 다른 차수로 입력해주시길 바랍니다.");
            	} else {
                	swal("시험등록이 완료되었습니다! 문항 5개를 선택 후 문항선택완료 버튼을 눌러주세요.");
                	
                	gfCloseModal();
                    
                	button.saveflag = true;
                	button.makeflag = false;
                	button.signflag = false;
            	}
            }
            callAjax("/tut/checkTestId.do", "post", "json", true, param, listcallback);
   }
   
   function fn_makeTestPaper() {
	   var param ={
               test_nm : TestPaper.test_name,
               lec_cd : TestPaper.selectBox,
               test_start_date : TestPaper.test_start_date,
               test_end_date : TestPaper.test_end_date,
               test_cd : TestPaper.test_cd
         }
	   
	   var listcallback = function(returndata){
           console.log(returndata);
           
           if(returndata > 0){
              
              /* swal("시험등록이 완료되었습니다 문항수 5개를 선택후 문항선택완료 버튼을 눌러주세요");
  
  
              gfCloseModal();
              
              $("btnSavetest").show(); */
              
           }else{
              
              swal("시험지 등록 중 오류가 발생했습니다.");
           }
        }
	   callAjax("/tut/testregi.do", "post", "json", true, param, listcallback);
   }

   
   /* 시험지만들기 작업 5문항선택 1) ~~   */
   function fn_paperDate(){
	   
       if(question.questionCheck.length == 5){ // 문제문항 5개 선택해야 시험지 만들어지도록
    	  
       	   fn_makeTestPaper();
         
           $.ajax({
               url : "/tut/insertTestCdPaper",
               type : "post",
               data : {
                   paperList : question.questionCheck
               },
               success : function(result){
                   console.log(result);
                  
                   if(result > 0){
                     
                       alert("문항선택이 완료되었습니다");
                     
                       location.href = "/tut/testControl.do";
                  }
               }
            });
         
      }else{
         swal("5개문항을 선택하세요");
      }
   }

</script>
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
                     <span class="btn_nav bold">시험문제관리</span> <a href="/tut/testControl.do class="btn_set refresh">새로고침</a>
                  </p>

                  <p class="conTitle">
                     <span>시험문제관리</span>
                     <span class="fr" id="main">
                         <a class="btnType blue" href="javascript:fn_paperMade();" name="modal" id="mkTestPaper"><span>시험지만들기</span></a>
                         <a class="btnType blue" href="javascript:fn_openpopup();" name="modal" id="mkProblem"><span>문제등록</span></a>
                     </span>
                  
                   <span>
                         <a href="javascript:fn_paperDate()" class="btnType blue" id="btnSavetest" style="display:none;"><span>문항선택완료</span></a>              
                     </span>
                  </p>
                  
                  <div class="divComGrpCodList">    
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
                        <tbody id="testbank"></tbody>
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
                                 <input type="text" class="inputTxt p50"name="test_que_cd" id="test_que_cd" disabled placeholder="랜덤생성됩니다.">
                              </td>
                              <th scope="row">정답</th>
                              <td>
                                 <input type="text" class="inputTxt p50"name="test_cor_ans" id="test_cor_ans" />
                              </td>
                     </tr>
                     <tr>
                        <th scope="row">문제<span class="font_red">*</span></th>
                        <td colspan="3"><input type="text" class="inputTxt p100"name="test_que_ctt" id="test_que_ctt" /></td>
                     </tr>
                     <tr>
                        <th scope="row">보기1 <span class="font_red"></span></th>
                        <td colspan="3"><input type="text" class="inputTxt p100"name="test_opt_1" id="test_opt_1" /></td>
                     </tr>
                     <tr>
                        <th scope="row">보기2 <span class="font_red"></span></th>
                        <td colspan="3"><input type="text" class="inputTxt p100"name="test_opt_2" id="test_opt_2" /></td>
                     </tr>
                     <tr>
                        <th scope="row">보기3 <span class="font_red"></span></th>
                        <td colspan="3"><input type="text" class="inputTxt p100"name="test_opt_3" id="test_opt_3" /></td>
                     </tr>
                     <tr>
                        <th scope="row">보기4 <span class="font_red"></span></th>
                        <td colspan="3"><input type="text" class="inputTxt p100"name="test_opt_4" id="test_opt_4" /></td>
                     </tr>                                         
                  </tbody>
               </table>

               <!-- e : 여기에 내용입력 -->

               <div class="btn_areaC mt30">
                  <a href="javascript:fn_save();" class="btnType blue" id="btnSave" name="btn"><span></span></a>
                  <a href="javascript:fn_reset()" class="btnType blue" id="btnDelete" name="btn"><span></span></a>
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
                                 <input type="text" class="inputTxt p100"name="test_name" id="test_name" />
                              </td>
                     </tr>
                     <tr>
                        <th scope="row">시험차수<span class="font_red"></span></th>
                        <td colspan="3"><input type="text" class="inputTxt p100"name="test_cd" id="test_cd" style="width: 50%;"/></td>
                     </tr> 
                     <tr>
                        <th scope="row">강의선택<span class="font_red">*</span></th>
                        <td colspan="3">
                            <select id="selectBox">
                               <option value="">선택해주세요</option>
                            </select>
                        </td>
                        
                     </tr>
                     <tr>
                        <th scope="row">시험시작일<span class="font_red"></span></th>
                        <td colspan="3"><input type="date" class="inputTxt p100"name="test_start_date" id="test_start_date" /></td>
                     </tr>
                     <tr>
                        <th scope="row">시험종료일<span class="font_red"></span></th>
                        <td colspan="3"><input type="date" class="inputTxt p100"name="test_end_date" id="test_end_date" style="width: 50%;"/></td>
                     </tr>                                         
                  </tbody>
               </table>

               <!-- e : 여기에 내용입력 -->

               <div class="btn_areaC mt30">
                  <a href="javascript:fn_regi();" class="btnType blue" id="btnSave" name="btn"><span>시험둥록</span></a>
                  <a href="javascript:fn_reset2()" class="btnType blue" id="btnDelete" name="btn"><span>모든내용삭제</span></a>
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


   $(function() {
      fn_searchlist();
      
      selectlist(); // 시험등록버튼 누를 시 모달의 selectBOX
      

      
   });
   

   /*selectBox*/
   function selectlist(){

     var param = {
         loginId:   $("#loginId").val()
     }
     
     
     var listcallback = function(returndata){
        console.log(returndata);
      
       for(var i=0; i< returndata.selectlist.length; i++){
          
          $("#selectBox").append("<option value=" + returndata.selectlist[i].lec_cd + ">"+ returndata.selectlist[i].lec_nm + "</option>")
          
       }

       
     }
        
     
      callAjax("/tut/selectlist.do", "post", "json", true, param, listcallback); 
     
  } 
   

   /*초기페이지 */
   function fn_searchlist(){
      
      var param={
                loginId: $("#loginId").val()
      }
   
      var listcallback = function(returndata){
            
         console.log(returndata);

          var html="";

            for(var i=0; i<returndata.testBankList.length; i++){
               
               var test_que_cd = returndata.testBankList[i].test_que_cd;

               
               html+="<tr>";
               	  html += "<td><input type='checkbox' name='radiobox_" + test_que_cd + "' value='" + test_que_cd + "' onclick='handleRadioClick(" + test_que_cd + ")'></td>";
                  html+="<td>"+ returndata.testBankList[i].test_que_cd+"</td>";
                  html+="<td>"+ returndata.testBankList[i].test_que_ctt+"</td>";
                  html+="<td>"+ returndata.testBankList[i].test_cor_ans+"</td>";
                  html+="<td>"+ returndata.testBankList[i].test_opt_1+"</td>";
                  html+="<td>"+ returndata.testBankList[i].test_opt_2+"</td>";
                  html+="<td>"+ returndata.testBankList[i].test_opt_3+"</td>";
                  html+="<td>"+ returndata.testBankList[i].test_opt_4+"</td>";
                  html+='<td><a class="btnType blue" href="javascript:fn_modify(\'' + test_que_cd + '\');" name="modal"><span>수정</span></a></td>';
                  html+='<td><a class="btnType blue" href="javascript:fn_delete(\'' + test_que_cd + '\');" name="modal"><span>삭제</span></a></td>';
                  html+="</tr>";
               
            }            
         

          $("#testbank").html(html);
      }
      
      callAjax("/tut/testBankALLList.do", "post", "json", false, param, listcallback);  
      
      
   }
   /* 모달데이터작업 */
   function fn_popupint(data) {
      
      console.log(data);

      
      if(data == null || data== undefined || data ==""){ //신규등록시
         
          $("#action").val("I");
          $("#test_que_cd").val("");
          $("#test_que_cd").attr("readonly","readonly");
          
          $("#test_cor_ans").val("");
          $("#test_que_ctt").val("");
          $("#test_opt_1").val("");
          $("#test_opt_2").val("");
          $("#test_opt_3").val("");
          $("#test_opt_4").val("");
          
          $("#btnSave").html("<span>신규등록</span>");
          $("#btnDelete").html("<span>내용전부삭제</span>");
          
          
      }else{ //수정시
         $("#action").val("U");
         $("#test_que_cd").val(data[0].test_que_cd);
         $("#test_que_cd").attr("readonly","readonly");
         
         $("#test_cor_ans").val(data[0].test_cor_ans);
         $("#test_que_ctt").val(data[0].test_que_ctt);
         $("#test_opt_1").val(data[0].test_opt_1);
         $("#test_opt_2").val(data[0].test_opt_2);
         $("#test_opt_3").val(data[0].test_opt_3);
         $("#test_opt_4").val(data[0].test_opt_4);
         
         $("#btnSave").html("<span>수정하기</span>");
         $("#btnDelete").html("<span>내용전부삭제</span>");
      }
      
   }
   
  
   //데이터신규등록시
   function fn_openpopup() {
      //데이터작업
      fn_popupint();
      // 모달 팝업
      gfModalPop("#testBankpop");
   
   } 




   /* 단건조회 */
   function fn_modify(data){

      
         var param={
               test_que_cd : data
         }
         
      var listcallback = function(returndata){
         
         fn_popupint(returndata.selectview); 
         
         console.log($("#test_cor_ans").val());
         
          gfModalPop("#testBankpop");
          
          
      }
         
      
      callAjax("/tut/selectview.do", "post", "json", false, param, listcallback);  
      
   }
   
   
   /* 저장하기, 수정하기 */
   function fn_save() {
      console.log($("#action").val());
      
      if( $("#action").val() =="D" ){
         var param={
               action:   $("#action").val(),
               test_que_cd: $("#test_que_cd").val()
         }

      }

      if( $("#action").val() =="U" || $("#action").val() =="I" ){
         
               var answer =  $("#test_cor_ans").val();
               
               if($("#test_cor_ans").val() == ""){
                  
                  swal("정답을 입력하세요");
                  return
               
               }else if(isNaN(answer)){
                  
                  swal("숫자로 정답을 입력하세요");
                  return            
               }else if($("#test_que_ctt").val()==""){
                  
                  swal("문제를 입력하세요");
                  return      
                  
               }else if($("#test_opt_1").val()==""){
                  
                  swal("보기1을 입력하세요");
                  return            
               }else if($("#test_opt_2").val()==""){
                  
                  swal("보기2을 입력하세요");
                  return            
               }else if($("#test_opt_3").val()==""){
                  
                  swal("보기3을 입력하세요");
                  return            
               }else if($("#test_opt_4").val()==""){
                  
                  swal("보기4을 입력하세요");
                  return            
               }
      
         
         
            var param={
                  action: $("#action").val(),
                  test_que_cd: $("#test_que_cd").val(),
                  test_cor_ans: $("#test_cor_ans").val(),
                  test_que_ctt: $("#test_que_ctt").val(),
                  test_opt_1: $("#test_opt_1").val(),
                  test_opt_2: $("#test_opt_2").val(),
                  test_opt_3: $("#test_opt_3").val(),
                  test_opt_4:    $("#test_opt_4").val(),
                  test_que_type:$("#test_que_type").val()
                  
            }
      }
      
      console.log(param);
      
      var listcallback = function(returndata){
         console.log(returndata);
         
         if(returndata > 0){
            
            swal("저장되었습니다");
            gfCloseModal();
            fn_searchlist();
            
         }else if(returndata ==0){
            
            swal("실패하였습니다");
            gfCloseModal();
            fn_searchlist();            
         }
      }
      
      callAjax("/tut/testsave.do", "post", "json", false, param, listcallback);  
   }
   
   
   /* 삭제 */
   function fn_delete(data){
      
      $("#test_que_cd").val(data);
      $("#action").val('D');
      
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
 
       $("#test_cor_ans").val("");
       $("#test_que_ctt").val("");
       $("#test_opt_1").val("");
       $("#test_opt_2").val("");
       $("#test_opt_3").val("");
       $("#test_opt_4").val("");
       
   }

   
   /* 시험지등록부분의 내용리셋  */
   function fn_reset2(){
      
       $("#test_name").val("");
       $("#test_cd").val("");
       $("#selectBox").val("");
       $("#test_start_date").val("");
       $("#test_end_date").val("");
       
   }

   
   /* 데이터 들어오는지 확인 ㄱ*/
   function handleRadioClick(data) {
      
      $("#test_que_cd").val(data);
      console.log($("#test_que_cd").val());
         
   }
   
   
   
   /* 시험지만들기*/
   function fn_paperMade(){
      
      gfModalPop("#TestPaper"); //모달열린 후 시험지 main정보 작성

      //fn_paperDate();

   }


   
   /* 시험등록버튼 */
   function fn_regi() {
      
            if( $("#test_name").val()==null || $("#test_name").val() =="" ){
                  alert("시험명 입력하세여");
                  return
               }
      
            if( $("#test_cd").val()==null ||$("#test_cd").val()=="" ){
               alert("시험차수 입력하세여");
               return
            }
      
         
            if( $("#selectBox").val()==null ||$("#selectBox").val()=="" ){
               alert("강의선택 해주세여");
               return
            }
            
            /* 시험지 등록 날짜 유효성*/
            var today = new Date();
      
            var year = today.getFullYear();
            var month = ('0' + (today.getMonth() + 1)).slice(-2);
            var day = ('0' + today.getDate()).slice(-2);
      
            var dateString = year + '-' + month  + '-' + day;
            
      
            if( $("#test_start_date").val()==null ||$("#test_start_date").val()=="" ){
               alert("시험시작일을 정해주세여");
               return
            }
            
            
            if( $("#test_start_date").val() < dateString ){
               alert("시험시작일자 선택이 잘못되었습니다 확인해주세요");
               return
            }
            
            
            if( $("#test_end_date").val()==null ||$("#test_end_date").val()=="" ){
               alert("시험종료을 정해주세여");
               return
            }
            
            if( $("#test_end_date").val() <  $("#test_start_date").val()){
               alert("시험종료일자 선택이 잘못되었습니다 확인해주세요");
               return
            }
            
            
            var param = {
            		test_cd:$("#test_cd").val()
            }
            
            var listcallback = function(returndata) {
            	console.log(returndata);
            	
            	if (returndata.checkTestIdYn == "N") {
            		swal("해당 차수는 있는 차수입니다. 다른 차수로 입력해주시길 바랍니다.");
            	} else {
                	swal("시험등록이 완료되었습니다 문항수 5개를 선택후 문항선택완료 버튼을 눌러주세요");
                	
                	gfCloseModal();
                    
                    $("#btnSavetest").show();
                    $("#mkTestPaper").hide();
            		$("#mkProblem").hide();
            	}
            }
      
            
            callAjax("/tut/checkTestId.do", "post", "json", false, param, listcallback);
        
      
   }
   
   function fn_makeTestPaper() {
	   var param ={
               test_nm:$("#test_name").val(),
               lec_cd: $("#selectBox").val(),
               test_start_date:$("#test_start_date").val(),
               test_end_date:$("#test_end_date").val(),
               test_cd:$("#test_cd").val()
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
	   
	   callAjax("/tut/testregi.do", "post", "json", false, param, listcallback);
   }

   
   /* 시험지만들기 작업 5문항선택 1) ~~   */
   function fn_paperDate(){
	   
      
      var paperList  = []; 
      

         var CheckBoxes =  document.querySelectorAll('input[type="checkbox"]');
         
         CheckBoxes.forEach(function(CheckBox) {
            
            if(CheckBox.checked){
               paperList.push(CheckBox.value);
            }
         });
      
      
         
      if(paperList.length == 5){ // 문제문항 5개 선택해야 시험지 만들어지도록
    	  
    	  fn_makeTestPaper();
         
         $.ajax({
              url : "/tut/insertTestCdPaper",
              type : "post",
              data : {
                 paperList : paperList
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
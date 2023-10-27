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

   <input type="hidden" name="name" id="loginId" value="${loginId}">
    <input type="hidden" name="lec_cd" id="lec_cd"/>


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
                  
                  <div class="divComGrpCodList">    
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
                        <tbody id="Leveltest"></tbody>
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
                              <td id="test_date"></td>
                     </tr>
                      <tr id ="Hide">
                              <th scope="row">배점</th>
                              <td id="score"></td>
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
                                 <tbody id="testcontents"></tbody>
                              </table>
                              </div>
                           </td>
                     </tr>                        
                  </tbody>
               </table>


               <!-- e : 여기에 내용입력 -->

               <div class="btn_areaC mt30">
                  <a href="javascript:fn_submit();" class="btnType blue" id="btnSave" name="btn"><span>제출</span></a>
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
                              <td id="test_date2"></td>
                     </tr>
                      <tr id ="Hide">
                              <th scope="row">총점</th>
                              <td id="totalscore"></td>
                     </tr>   
                      <tr id ="Hide">
                              <th scope="row">합격여부</th>
                              <td id="tststate"></td>
                     </tr>                                                           
                     <tr>
                        <th scope="row">문제<span class="font_red"></span></th>
                           <td colspan="3" overflow: "auto">
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
                                 <tbody id="resultcontent"></tbody>
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
   
   $(function() {
      
      // 강의 목록 조회
      fn_searchlist();

   });

   /* 초기페이지 */
   function fn_searchlist(){

      var param = {//pageSize(컨트롤러단에서 받을때 변수이름) : pageSize
          loginId:   $("#loginId").val()
      }
      
      
      var listcallback = function(returndata){
         
         console.log(returndata);

         
         var html="";
         
       if(returndata.testList.length ==0 ){
          html += "<td colspa='4'>조회된 내용이 없습니다</td>"
          
       }else{
          for(var i=0; i<returndata.testList.length; i++){
             
             var test_cd = returndata.testList[i].test_cd;
             var lec_cd = returndata.testList[i].lec_cd;
             var test_state_word;
             if(returndata.testList[i].test_state != null) {
                test_state_word = "응시완료";   
             } else {
                test_state_word = "미응시";
             }
             
             html+="<tr>"
             html+="<td>"+returndata.testList[i].lec_nm+"</td>";
             html+="<td>"+returndata.testList[i].test_nm+"</td>";
             html+="<td>"+returndata.testList[i].test_start_date+"~"+returndata.testList[i].test_end_date +"</td>";
             html+="<td>"+returndata.testList[i].loginID+"</td>";
             html+="<td>" +test_state_word+ "</td>";
             if(test_state_word == "응시완료") {
                html+= '<td><a href="javascript:confirm(' + test_cd + ',' + lec_cd + ');" class="btnType blue" id="btntest" name="btn"><span>결과보기</span></a></td>';    
             } else {
                html+= '<td><a href="javascript:fn_start(\'' + test_cd + '\');" class="btnType blue" id="btntest" name="btn"><span>응시하기</span></a></td>';
             }
             
             html+="</tr>"             

      
          }
          
         $("#Leveltest").html(html);

       }

      }
         
      
       callAjax("/std/testList.do", "post", "json", true, param, listcallback); 
      
   }

   
   /* 시험응시하기 전 시험지 상세보기 */
       function fn_start(data) {
          console.log(data);
          
          var param={
                test_cd: data
          }
          
           var listcallback = function(returndata){
                console.log(returndata);
                //answerList = returndata;
                answerLists= returndata;
                console.log(returndata.detailview[0].test_nm);
                
                 $("#test_date").html(returndata.detailview[0].test_nm);
                 $("#score").html(returndata.detailview[0].score);  
                 $("#lec_cd").val(returndata.detailview[0].lec_cd);
                 
                   var html="";
                   
                   if(returndata.detailview.length ==0){
                      
                      html+="<td colspan='6'>조회된 내용이 없습니다</td>";
                   }else{
                      
                      for(var i=0; i< returndata.detailview.length; i++){
	                         html+="<tr>";
	                         html+="<td>"+returndata.detailview[i].test_que_cd+"</td>";
	                         html+="<td>"+returndata.detailview[i].test_que_ctt+"</td>";
	                         html+="<td>"+returndata.detailview[i].test_opt_1+"</td>";
	                         html+="<td>"+returndata.detailview[i].test_opt_2+"</td>";
	                         html+="<td>"+returndata.detailview[i].test_opt_3+"</td>";
	                         html+="<td>"+returndata.detailview[i].test_opt_4+"</td>";
	                         html+="<td><input type='text' id='answer"+ i +"' style='width: 20px;' maxlength='1' onkeypress='isNumber();'></td>"
	                         html+="</tr>";
                        
                      }
     
                   }
                   
                   $("#testcontents").html(html);

                   
                   gfModalPop("#testfighting");
                   
          }
          
          callAjax("/tut/detailview.do", "post", "json", true, param, listcallback); 
       }
   
   
    function isNumber() {
	   if(event.keyCode<48 || event.keyCode>57){
           event.returnValue=false;
        }
   }
       
   
   /* 오늘날짜구하기[시험응시일] */
   var today = new Date();
   
   var year = today.getFullYear();
   var month = ('0' + (today.getMonth() + 1)).slice(-2);
   var day = ('0' + today.getDate()).slice(-2);
   
   var dateString = year + '-' + month  + '-' + day;


         /* 시험제출하기 */            
       function fn_submit() {
            /* tb_test_submit*/
            var lec_cd = answerLists.detailview[0].lec_cd;
            //$("#lec_cd").val(answerLists.detailview[0].lec_cd);
            
            var loginID = $("#loginId").val();
            var total_Score = 0;
            var test_state;
            var test_sm_date;
            var test_cd = answerLists.detailview[0].test_cd; 
            
            /* tb_sm_ans*/
            var test_que_cd;
            var sm_ans;
            var cor_yn;
            var score;
                  
             //console.log(answerLists);
             
             // null 값 체크
             for(var i = 0; i < answerLists.detailview.length; i++) {
            	 if($("#answer"+i).val() == null || $("#answer"+i).val() == '') {
            		 return alert("값을 모든 항목에 맞추어서 입력해주시길 바랍니다.");
            	 }
             }
             
             for(var i = 0; i < answerLists.detailview.length; i++) { 
                     if(answerLists.detailview[i].test_cor_ans == $("#answer"+i).val()) {
                        test_que_cd = answerLists.detailview[i].test_que_cd;
                        sm_ans = $("#answer"+i).val();
                        cor_yn = 'Y';
                        score = 20;
                        
                        total_Score += 20;
                         
                     } else {
                        test_que_cd = answerLists.detailview[i].test_que_cd;
                        sm_ans = $("#answer"+i).val();
                        cor_yn = 'N';
                        score = 0;
                     }
                     
                     var param={
                           lec_cd: lec_cd,
                           loginID:loginID,
                           test_cd :test_cd,
                           test_que_cd :test_que_cd,
                           sm_ans :  sm_ans,
                           cor_yn : cor_yn,
                           score : score
                           
                     }

               var listcallback = function(returndata){
                  console.log(returndata);
                  
               }
                     
               callAjax("/std/TestSubmit.do", "post", "json", false, param, listcallback); 
               
             }
             
             console.log(total_Score);
             
             /* 추가 */
             
              if(total_Score >= 60){ 
            	  test_state ='Y';
             }else{ 
            	  test_state ='N';
             } 
             
             console.log(test_state);
             
             var param2 ={
                   lec_cd :lec_cd,
                   test_cd: test_cd,
                   loginID:loginID,
                   total_Score : total_Score,
                   test_state: test_state,
                   test_sm_date : dateString
             }
             
             console.log(param2); //총점수 + test_state + test_sm_date 
             
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
	            loginID: $("#loginId").val(),
	            lec_cd : lec_cd,
	            test_cd :test_cd
	      }
      
       console.log(param);
       

       
        var listcallback = function(returndata){
             console.log("총점수같은데이터");
             console.log(returndata);
			 console.log( returndata.resultList[0].test_sm_date );

			 $("#tststate").val(returndata.resultList[0].test_sm_date );
			 
			 $("#test_date2").val(returndata.resultList[0].test_sm_date );
			 $("#test_date2").html(returndata.resultList[0].test_sm_date );
	
			 
          	var html="";

          	
                 $("#test_date").html(returndata.resultList[0].test_sm_date);

                  $("#totalscore").html(returndata.resultList[0].score);
					
                  $("#tststate").val(returndata.resultList[0].test_state);
                 // $("#tststate").html(returndata.resultList[0].test_state);
                 
                  
                  if($("#tststate").val() == 'Y'){
                	  $("#tststate").html("<span>합격</span>");
                	  
                  }else{
                	  $("#tststate").html("<span>불합격</span>");
                  }
                  
                  
            	 for(var i=0;  i< returndata.resultList2.length; i++){
						console.log(returndata.resultList2[i].cor_yn);
            		   html+="<tr>";
            		   html+="<td>"+returndata.resultList2[i].test_que_cd+"</td>";
            		   html+="<td>"+returndata.resultList2[i].test_que_ctt+"</td>";
            		   html+="<td>"+returndata.resultList2[i].test_opt_1+"</td>";
            		   html+="<td>"+returndata.resultList2[i].test_opt_2+"</td>";
            		   html+="<td>"+returndata.resultList2[i].test_opt_3+"</td>";
            		   html+="<td>"+returndata.resultList2[i].test_opt_4+"</td>";
            		   html+="<td>"+returndata.resultList2[i].test_cor_ans+"</td>"; 
            		   html+="<td>"+returndata.resultList2[i].sm_ans+"</td>"; 
            		   html+="<td>"+returndata.resultList2[i].cor_yn+"</td>"; 
            		   html+="</tr>";
            	  }
             
             console.log(html);

             $("#resultcontent").html(html);     
             
             gfModalPop("#resultfighting");


       }
       
       callAjax("/std/Testconfirm.do", "post", "json", false, param, listcallback); 
   }     
	

    
    
    
</script>
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
   <input type="hidden" name="name" id="userNm" value="${userNm}">
   <input type="hidden" name="name" id="lec_cd"  name="lec_cd"/>

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
                     <span class="btn_nav bold">시험등록</span> <a href="/tut/testControl.do class="btn_set refresh">새로고침</a>
                  </p>

                  <p class="conTitle">
                     <span>시험등록</span>
                     <span class="fr">
                         <select id="selectBox">
                            <option value="">선택해주세요</option>
                         </select>
                         <a class="btnType blue" href="javascript:fn_searchlist();" name="modal"><span>검색</span></a>
                         <a class="btnType blue" href="/tut/testBankList.do" name="modal"><span>시험문제관리</span></a>
                     </span>
                  </p>
                  
                  <div class="divComGrpCodList">    
                     <table class="col">
                        <caption>caption</caption>
                        <colgroup>
                           <col width="10%">
                           <col width="20%">
                           <col width="20%">
                           <col width="25%">
                           <col width="30%">
                        </colgroup>
   
                        <thead>
                      <tr>
                          <th colspan="6" scope="col">시험목록</th>
                      </tr>
                           <tr>
                              <th scope="col">번호</th>
                              <th scope="col">시험이름</th>
                              <th scope="col">시험구분</th>
                              <th scope="col">시험시작일</th>
                              <th scope="col">시험종료일</th>
                           </tr>

                        </thead>
                        <tbody id="testList"></tbody>
                     </table>
                  </div>

               </div> <!--// content -->
               <h3 class="hidden">풋터 영역</h3>
                  <jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
            </li>
         </ul>
      </div>
   </div>


      <div id="selectviewpop" class="layerPop layerType2" style="width: 1000px;">
         <dl>
            <dt>
               <strong>강의명</strong>
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
                              <th scope="row">테스트명</th>
                              <td id="test_name"></td>
                     </tr>
                       <tr id ="Hide">
                              <th scope="row">배점</th>
                              <td id="score"></td>
                     </tr>                                                           
                     <tr>
                        <th scope="row">문제<span class="font_red"></span></th>
                           <td colspan="3" overflow: auto">
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


/*   
 꼭 읽어주세요~!!!! 시험부분은 페이지가 두개가 있습니다 1) "/tut/mngwin/TestManage"  2) "/tut/mngwin/TestBank"  얘는 TestBank.jsp 에 있음
   두번째 페이지는 상단의 시험문제관리 버튼을 눌렀을때 넘어가는 페이지로 controller 은 TestManageController 하나로 함께 사용하였습니다   */



   //그룹코드 페이징 설정
   var pageSize = 1;//한페이지에 몇건 보여줄래?
   var pageBlockSize = 5;

   $(function() {
      //셀렉트박스
     selectlist();

      // 강의 목록 조회
      fn_searchlist();


   });
   


   
   /*selectBox*/
    function selectlist(){

      var param = {//pageSize(컨트롤러단에서 받을때 변수이름) : pageSize
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
                selectBox : $("#selectBox").val(),
                loginId: $("#loginId").val()
      }
   
      var listcallback = function(returndata){
            
         console.log(returndata);
         console.log(JSON.stringify(returndata));
         
         var html="";
         
         if(returndata.testAllList.length ==0){
            
            html+="<td colspan='6'>조회된 내용이 없습니다</td>";
         }else{
            
            for(var i=0; i< returndata.testAllList.length; i++){
            
               var test_cd = returndata.testAllList[i].test_cd;
               
               html+="<tr>";
               html+="<td>"+returndata.testAllList[i].lec_nm+"</td>";
               html += "<td onclick='detailview(\"" + test_cd + "\")'>" + returndata.testAllList[i].test_nm + "</td>";
               html+="<td>"+returndata.testAllList[i].test_cd+"</td>";
               html+="<td>"+returndata.testAllList[i].test_start_date+"</td>";
               html+="<td>"+returndata.testAllList[i].test_end_date+"</td>";
               html+="</tr>";
              
            }            
         }
         

      
            $("#testList").html(html);
                

      }
      
      callAjax("/tut/testAllList.do", "post", "json", true, param, listcallback);  
      
      
   }
 

   
   //클릭한 시험지의 상세정보보기::::: + 아까 5개 넣은 문제들 조회 가능 
   function detailview(data) {
      console.log(data);
      
      var param={
            test_cd: data
      }
      
       var listcallback = function(returndata){
            console.log(returndata);
            console.log(returndata.detailview[0].test_nm);
            
             $("#test_name").html(returndata.detailview[0].test_nm);
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
                     html+="<td>"+returndata.detailview[i].test_cor_ans+"</td>";
                     html+="</tr>";
                    
                  }
 
               }
               
               $("#testcontents").html(html);

               
               gfModalPop("#selectviewpop");
               
      }
      
      callAjax("/tut/detailview.do", "post", "json", true, param, listcallback); 
   }
   


   
   
   
</script>
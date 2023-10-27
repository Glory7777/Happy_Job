<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>수업정보</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>


<body>
<form id="myForm" action=""  method="">
    <input type="hidden" id="currentPageLecture" />
    <input type="hidden" name="name" id="loginId" value="${loginId}">
   <input type="hidden" name="name" id="lec_cd" value="lec_cd" />
   <input type="hidden" name="name" id="lec_nm" value="lec_nm" />
   <input type="hidden" name="name" id="loginnm" value="loginnm" /> <!--수강듣는 학생 로그인 id  -->

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
                     <span class="btn_nav bold"> 강의목록</span> <a href="/std/lectureList.do" class="btn_set refresh">수강생정보</a>
                  </p>

                  <p class="conTitle">
                     <span>수업정보</span> <span class="fr"> 
                    <label for="assNumber">강의목록</label>
                         <select id="selectBox">
                     <option value="">선택해주세요.</option>
                   </select>
<!--                         <select id ="searchsel" name="searchsel">
                              <option value="">전체</option>
                              <option value="title">과목명</option>
                              <option value="writer">강사명</option>
                        </select> -->
                        <a class="btnType blue" href="javascript:fn_searchlist();" name="modal"><span>검색</span></a>
                     </span>
                  </p>
                  
                  <div class="divComGrpCodList">    
                     <table class="col">
                        <caption>caption</caption>
                        <colgroup>
                           <col width="25%">
                           <col width="10%">
                           <col width="15%">
                           <col width="15%">
                           <col width="15%">
                           <col width="15%">
                        </colgroup>
   
                        <thead>
                           <tr>
                              <th scope="col">강의명</th>
                              <th scope="col">강사명</th>
                              <th scope="col">개강일</th>
                              <th scope="col">종강일</th>
                              <th scope="col">현재인원</th>
                              <th scope="col">정원</th>
                           </tr>
                        </thead>
                        <tbody id="listLecture"></tbody>
                     </table>
                  </div>
   
                  <div class="paging_area"  id="lecPagination"> </div>
                  
                <h3 class="hidden">contents 영역</h3> <!-- content -->
               <div class="content" id="subtable" style="display: none">

         <!-- 수강생명단 상세조회 -->
              <div >  
                  <p class="conTitle">
                     <span>수강생 명단</span> <span class="fr"></span>
                  </p>
                  
                   <div class="divComGrpCodList">    
                     <table class="col">
                        <caption>caption</caption>
                        <colgroup>
                           <col width="15%">
                           <col width="15%">
                           <col width="20%">
                           <col width="15%">
                           <col width="15%">
                           <col width="20%">
                        </colgroup>
   
                        <thead>
                           <tr>
                              <th scope="col">강의명</th>
                              <th scope="col">이름</th>
                              <th scope="col">생년월일</th>
                              <th scope="col">연락처</th>
                              <th scope="col">승인여부</th>
                              <th scope="col">승인/취소 </th>
                           </tr>
                        </thead>
                        <tbody id="studentList"></tbody>
                     </table>
                  </div>
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

<script type="text/javascript">

   //그룹코드 페이징 설정
   var pageSize = 3;//한페이지에 몇건 보여줄래?
   var pageBlockSize = 2;

   $(function() {
      
      //select 박스
      leclist();
      
      
      // 공지사항 조회
      fn_searchlist();

      
   });
   

   
   /*select박스  */
      function leclist() {
      
      var param={
            loginId: $("#loginId").val()
      }
      
      var listcallback = function(returndata){
         console.log("강의명 select박스확인");
         console.log(returndata);
         
         for(var i=0; i < returndata.leclist.length; i++) {
            // console.log(i + "번째 데이터 집어넣는 중");
            $("#selectBox").append("<option value=" + returndata.leclist[i].lec_nm + ">" + returndata.leclist[i].lec_nm + "</option>");
         }
         
         
      }
      
      callAjax("/tut/leclist.do", "post", "json", true, param, listcallback);
   } 
   
   
   
   /* 초기페이지 */
   function fn_searchlist(currentPage){
      console.log("초기페이지열림");
      var currentPage = currentPage || 1; 
      
      var param = {//pageSize(컨트롤러단에서 받을때 변수이름) : pageSize
          pageSize : pageSize,
            currentPage : currentPage,
            searchtext : $("#searchtext").val(),
            selectBox : $("#selectBox").val(),
            loginId: $("#loginId").val()
      }
      
      console.log(param);
      
       var listcallback = function(returndata){

         console.log(returndata);
         $("#listLecture").empty().append(returndata);
         
         console.log(JSON.stringify(returndata));

         console.log("총 건수::::바로 밑을봐!! ")
         console.log($("#totalcnt").val());
         
         var totalcnt = $("#totalcnt").val();

         
         var paginationHtml = getPaginationHtml(currentPage, totalcnt, pageSize, pageBlockSize,'fn_searchlist');
         console.log("paginationHtml : " + paginationHtml);

         $("#lecPagination").empty().append(paginationHtml);

         $("#currentPageLecture").val(currentPage);  
         
         
      }
       callAjax("/tut/LectureStudentAllList.do", "post", "text", true, param, listcallback); 
      
       
   }

   
   /*수강생명단 조회  */
   function fn_studentSelect(data){
            
      $("#lec_cd").val(data); 
      
            var param={
                  lec_cd: data
            }
            
                  console.log(param);
         
          var listcallback = function(returndata){
                   console.log(returndata.studentlist);   
               
                   
                   var html="";
                
                   if(returndata.studentlist.length ==0){
                         html+="<td colspan='6'>조회된 내용이 없습니다.</td>";
                   
                   }else{
                      for(var i=0; i<returndata.studentlist.length; i++){
                        
                         var   app_yn = returndata.studentlist[i].app_yn;
                         
                          html+="<tr></tr>";
                          html+="<td>"+returndata.studentlist[i].lec_nm+"</td>";
                          html+="<td>"+returndata.studentlist[i].name+"</td>";
                          html+="<td>"+returndata.studentlist[i].birthday+"</td>";
                          html+="<td>"+returndata.studentlist[i].hp+"</td>";
                          html+="<td>"+returndata.studentlist[i].app_yn+"</td>";
                          
                          if(app_yn =='Y'){
                             
                             html+='<td><a class="btnType blue" href="javascript:fn_app_No(\'' + returndata.studentlist[i].loginID + '\');" name="modal"><span>취소</span></a></td>';
                            
                          }else if(app_yn =='N'){
                             
                             html+='<td><a class="btnType blue" href="javascript:memberCheck(\'' + returndata.studentlist[i].loginID + '\');" name="modal"><span>승인</span></a></td>';
                             
                          }
                          
                      }
                   }
                   
                 $("#studentList").html(html);
                 
                      
          }
          
          callAjax("/tut/studentlist.do", "post", "json", true, param, listcallback);
          
          
          $('#subtable').show();
         
   }
   

   
   /*수강신청 수락  */
   function fn_app_yes(data){

         
      var param={
            lec_cd: $("#lec_cd").val(),
            loginID: data,
            approval: 'Y'
      }
      

      var listcallback = function(returndata){
         
         if(returndata > 0){
            
            swal(" "+ data + "학생의 수강신청이 수락되었습니다");

            fn_studentSelect($("#lec_cd").val());
            
            fn_searchlist();

         }
      }
      
       callAjax("/tut/studentYes.do", "post", "json", true, param, listcallback); 
    }
   
         
   
   
     /* 수강신청 취소 */    
     function   fn_app_No(data){
        
         var param={
                 lec_cd: $("#lec_cd").val(),
                 loginID: data,
                 approval: 'N'
           } 
         
         console.log(param);
         
         var listcallback = function(returndata){
             
             if(returndata > 0){
                
                swal(" "+ data + "학생의 수강신청이 거절되었습니다");
                
                fn_studentSelect($("#lec_cd").val());
                
                fn_searchlist();
                
             }
          }     
         
         callAjax("/tut/studentNO.do", "post", "json", true, param, listcallback); 
     }  
         
     
     
     /* 수강인원 체크하기 */
     function memberCheck(data){
        var data =  data;
        
         var param={
                 lec_cd: $("#lec_cd").val(),
           
         } 
         
         var listcallback = function(returndata){

            console.log(returndata);
           
            if(returndata ==1){
               //alert("유효성검사통과");
               fn_app_yes(data);
               
            }else if(returndata ==0){
               
               swal("수강인원이 다 참");
               
            }
            
         }
        
         callAjax("/tut/memberCheck.do", "post", "json", true, param, listcallback); 
         
     }
     
     
     
     
</script>
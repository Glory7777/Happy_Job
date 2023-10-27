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
                     <span>수강 목록</span> <span class="fr">
                     </span>
                  </p>
                  
                  <div class="divComGrpCodList" id="lecList">    
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
                              <th scope="col">강사</th>
                              <th scope="col">강의시작일</th>
                              <th scope="col">강의종료일</th>
                              <th scope="col">강의실</th>
                              <th scope="col">비고</th>
                           </tr>
                        </thead>
                        <template v-for="list in MylecList">
                        <tbody>
                        	<tr>
                           		<td>{{list.lec_nm}}</td>
                           	  	<td>{{list.name}}</td>
                           	  	<td>{{list.lec_start_date}}</td>
                           	  	<td>{{list.lec_end_date}}</td>
                           	  	<td>{{list.cls_room}}</td>
                           	  	<td><a href="" class="btnType blue" id="btnsurvey" name="btn"><span>설문조사</span></a></td>
                           	</tr>
                        </tbody>
                        </template>
                     </table>
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

   /* 그룹코드 페이징 설정
   var pageSize = 1;//한페이지에 몇건 보여줄래?
   var pageBlockSize = 5; */

   var lecList;
   
   
   $(function() {
      
	  vueinit();
	   
      // 강의 목록 조회
      fn_searchlist();


   });
   
	
   function vueinit(){
	   lecList = new Vue({
		 el: "#lecList",
		 data: {
			 MylecList: [],
		 }
	   })
   }

   
   /* 초기페이지 */
   function fn_searchlist(){
      
      var listcallback = function(returndata){
         console.log(returndata);
         console.log(JSON.stringify(returndata));

         // 값 받아와서 변수에 저장
         lecList.MylecList = returndata.MylecList 
         
	  }
      callAjax("/std/MylecList.do", "post", "json", true, "", listcallback); 
   }
   
</script>
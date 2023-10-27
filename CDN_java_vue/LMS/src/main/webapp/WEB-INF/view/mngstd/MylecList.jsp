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
                              <th scope="col">강사</th>
                              <th scope="col">강의시작일</th>
                              <th scope="col">강의종료일</th>
                              <th scope="col">강의실</th>
                              <th scope="col">비고</th>
                           </tr>
                        </thead>
                        <tbody id="listLecture"></tbody>
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

   //그룹코드 페이징 설정
   var pageSize = 1;//한페이지에 몇건 보여줄래?
   var pageBlockSize = 5;

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
         //console.log(JSON.stringify(returndata));
		 
         var html="";
		
		 
		 if(returndata.MylecList.length ==0 ){
			 html += "<td colspa='4'>조회된 내용이 없습니다</td>"
		 }else{
			 for(var i=0; i<returndata.MylecList.length; i++){
				 
				 html+="<tr>"
				 html+="<td>"+returndata.MylecList[i].lec_nm+"</td>";
				 html+="<td>"+returndata.MylecList[i].name+"</td>";
				 html+="<td>"+returndata.MylecList[i].lec_start_date+"</td>";
				 html+="<td>"+returndata.MylecList[i].lec_end_date+"</td>";
				 html+="<td>"+returndata.MylecList[i].cls_room+"</td>";
				 html+= '<td><a href="" class="btnType blue" id="btnsurvey" name="btn"><span>설문조사</span></a></td>';
				 html+="</tr>"				 

		
			 }
			 
			$("#listLecture").html(html);

		 }

      }
         
      
       callAjax("/std/MylecList.do", "post", "json", true, param, listcallback); 
      
   }

 
   
</script>
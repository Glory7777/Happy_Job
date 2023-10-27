<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>강의 목록</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<body>
<form id="myForm" action=""  method="">

   <input type="hidden" id="currentPageLecture" />
   <input type="hidden" name="name" id="loginId" value="${loginId}">
   <input type="hidden" name="lecturePlan" id="lecturePlan"/>
   <input type="hidden" name="lec_cd" id="lec_cd"/>
   <input type="hidden" name="lec_end_date" id="lec_end_date"/>
   <input type="hidden" name="lec_start_date" id="lec_start_date"/>
   <input type="hidden" name="lec_yn" id="lec_yn"/>
   <input type="hidden" name="app_yn" id="app_yn"/>
   
    
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
                     <a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a> <span class="btn_nav bold">학습지원</span> 
                     <span class="btn_nav bold"> 강의목록</span> <a href="/std/lectureList.do" class="btn_set refresh">새로고침</a>
                  </p>

                  <p class="conTitle" id="conTitle">
                     <span>강의 목록</span> <span class="fr">
                        <select id ="searchsel" name="searchsel" v-model="searchsel">
                              <option value="">전체</option>
                              <option value="title">과목명</option>
                              <option value="writer">강사명</option>
                        </select>
                        <input type="text" id="searchtext" name="searchtext" v-model="searchtext" style="width: 150px; height: 25px;" />
                        <a class="btnType blue" href="javascript:fn_searchlist();" name="modal"><span>검색</span></a>
                     </span>
                  </p>
                  
                  <div class="divComGrpCodList" id="divComGrpCodList">    
                     <table class="col">
                        <caption>caption</caption>
                        <colgroup>
                           <col width="25%">
                           <col width="10%">
                           <col width="10%">
                           <col width="15%">
                           <col width="15%">
                           <col width="15%">
                           <col width="15%">
                        </colgroup>
   
                        <thead>
                           <tr>
                              <th scope="col">과목</th>
                              <th scope="col">분류</th>
                              <th scope="col">강사명</th>
                              <th scope="col">강의시작일</th>
                              <th scope="col">강의종료일</th>
                              <th scope="col">신청인원</th>
                              <th scope="col">정원</th>
                           </tr>
                        </thead>
                        <template v-if="totalcnt == 0">
                        	<tr><td>현재 신청 가능한 강의가 없습니다.</td></tr>
                        </template>
                        <template v-else v-for="list in listLecture">
                        	<tr>
                        		<td>{{list.lec_nm}}</td>
                        		<td>{{list.lec_ctg}}</td>
                        		<td>{{list.name}}</td>
                        		<td>{{list.lec_start_date}}</td>
                        		<td>{{list.lec_end_date}}</td>
                        		<td>{{list.app_cnt}}</td>
                        		<td>{{list.capacity}}</td>
                        	</tr>
                        </template>
                     </table>
                  </div>
   				  
   				  <!-- 페이징 처리 -->
                  <div class="paging_area"  id="lecPagination" v-model="lecPagination"> </div>
                  
                  
               </div> <!--// content -->

               <h3 class="hidden">풋터 영역</h3>
                  <jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
            </li>
         </ul>
      </div>
   </div>

     <!--// 모달팝업 -->
      <div id="leclistpop" class="layerPop layerType2" style="width: 1000px;">
         <dl>
            <dt>
               <strong>강의계획서</strong>
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
                              <th scope="row">과목</th>
                              <td name="lec_nm" id="lec_nm" v-model="lec_nm"></td>
                              <th scope="row">분류</th>
                              <td id="lec_ctg" v-model="lec_ctg"></td>
                     </tr>
                     <tr id ="Hide">
                              <th scope="row">강사명</th>
                              <td id="name" v-model="name"></td>
                              <th scope="row">연락처</th>
                              <td id="hp" v-model="hp"></td>
                     </tr>
                     <tr id ="Hide">
                              <th scope="row">이메일</th>
                              <td id="email" v-model="email"></td>
                              <th scope="row">강의실</th>
                              <td id="cls_room" v-model="cls_room"></td>
                     </tr>
                     <tr>
                        <th scope="row">수업목표 <span class="font_red"></span></th>
                        <td id="lec_goal" v-model="lec_goal"></td>
                     </tr>                                                               
                     <tr>
                        <th scope="row">강의계획<span class="font_red"></span></th>
                           <td colspan="3" overflow: auto">
                              <div class="divComGrpCodList">    
                              <table class="col">
                                 <caption>caption</caption>
                                 <colgroup>
                                    <col width="10%">
                                    <col width="15%">
                                    <col width="20%">
                                 </colgroup>
            
                                 <thead>
                                    <tr>
                                       <th scope="col">주차수</th>
                                       <th scope="col">학습목표</th>
                                       <th scope="col">학습내용</th>
                                    </tr>
                                 </thead>
                                 <template v-for="plan in LecturePlan">
                                 	<tr>
                                 		<td>{{plan.weekly_no}}</td>
                                 		<td>{{plan.week_goal}}</td>
                                 		<td>{{plan.week_ctt}}</td>
                                 	</tr>
                                 </template>
                              </table>
                              </div>
                           </td>
                     </tr>                        
                  </tbody>
               </table>

               <!-- e : 여기에 내용입력 -->

               <div class="btn_areaC mt30">
                  <a href="" class="btnType blue" id="btnSave" name="btn" v-show="btnSave"><span>신청</span></a>
                  <a href="" class="btnType blue" id="btnDelete" name="btn" v-show="btnDelete"><span>신청취소</span></a>
                  <a href="" class="btnType gray" id="btnClose" name="btn"><span>닫기</span></a>
               </div>
            </dd>
         </dl>
         <a href="" class="closePop"><span class="hidden">닫기</span></a>
      </div>
      
      <!-- jstl foreach 작업하다가 만 것 (참고용)
         
                           <c:forEach items="${lecturePlan}" var="list">
                           <tr>
                                 <td>${lecturePlan.weekly_no}</td>
                                 <td>${lecturePlan.week_goal}</td>
                                 <td>${lecturePlan.week_ctt }</td>
                           </tr>
                        </c:forEach>
       -->

         

</form>
</body>
</html>


<script type="text/javascript">

   //그룹코드 페이징 설정
   var pageSize = 5;//한페이지에 몇건 보여줄래?
   var pageBlockSize = 3;
   
   var conTitle;

   $(function() {
      
	  vueinit(); 
	   
      // 공지사항 조회
      fn_searchlist();

      // 버튼 이벤트 등록
      fRegisterButtonClickEvent();
   });
   
   function vueinit(){
	   
	   conTitle = new Vue({
		   el : "#conTitle",
		   data : {
			   searchsel: "",
			   searchtext: "",
			   loginId: "${loginId}"
		   }
	   });
	   
	   divComGrpCodList = new Vue({
		   el : "#divComGrpCodList",
		   data: {
		   	   listLecture: [],
			   totalcnt: 0,
			   lecPagination: "",
			   currentPage: 0,
			   loginId: "${loginId}"
		   }
	   });
	   
	   leclistpop = new Vue({
		   el : "#leclistpop",
		   data : {
			   lecturemodel: [], // 강의 상세
			   LecturePlan: [], // 주차 계획
			   lec_cd: "",
			   lec_nm: "",
			   lec_ctg: "",
			   name: "",
			   hp: "",
			   email: "",
			   cls_room: "",
			   lec_goal: "",
			   app_yn: "",
			   lec_start_date: "",
			   lec_end_date: "",
			   btnDelete: false,
			   btnSave : false,
			   loginId: "${loginId}"
		   }
	   });
	   
   }
   
   
   /** 버튼 이벤트 등록 */
   function fRegisterButtonClickEvent() {
      $('a[name=btn]').click(function(e) {
         e.preventDefault();

         var btnId = $(this).attr('id');

         switch (btnId) {
            case 'btnSave' :
               //fn_save();
               CheckDay();
               break;
            case 'btnDelete' :
            	DeletePossible();
               break;
            case 'btnClose':
               gfCloseModal();
               break;
         }
      });
   }

   
   /* if($("#lec_yn").val() ==0 ){ 
      $('#btnSave').hide();
      $('#btnDelete').show();
   }else{
      
      $('#btnDelete').hide();
      $('#btnSave').show();
   } */

   
   /* 초기페이지 */
   function fn_searchlist(currentPage){
      
      var currentPage = currentPage || 1; 
      
      var param = {//pageSize(컨트롤러단에서 받을때 변수이름) : pageSize
            pageSize : pageSize,
            currentPage : divComGrpCodList.currentPage,
            searchtext : conTitle.searchtext,
            searchsel : conTitle.searchsel
      }
      
      
      var listcallback = function(returndata){
         console.log(returndata);
         console.log(JSON.stringify(returndata));
         
         console.log("총 건수::::바로 밑을봐!! ")
         console.log($("#totalcnt").val());

         divComGrpCodList.listLecture = returndata.listLecture;
         
         var totalcnt = divComGrpCodList.totalcnt;
         
         var paginationHtml = getPaginationHtml(currentPage, totalcnt, pageSize, pageBlockSize,'fn_searchlist');
         console.log("paginationHtml : " + paginationHtml);

         divComGrpCodList.lecPagination = paginationHtml;
         divNoticeList.currentPage = currentPage;
      }
      callAjax("/std/lectureListAllVue.do", "post", "json", true, param, listcallback); //text , JSON 두가지있는데 CONTROLLER 의 타입이 뭐냐할때~!!!!! 목록 뿌려줄때만 TEXT 로 지정
      
   }

   /* 강의목록 상세모달 */
   function fn_lecSelect(lec_cd){

	   
      var param={
            lec_cd: leclistpop.lec_cd,
            loginId: leclistpop.loginId
      }
      
      var selectcallback = function(returndata) {
         
	      console.log("통신성공");         
          console.log(returndata.lecturemodel);
          console.log(returndata.LecturePlan);
          
          var app_yn = returndata.lecturemodel.app_yn;
          
          leclistpop.app_yn = app_yn;
          leclistpop.lecturemodel = returndata.lecturemodel;
          leclistpop.LecturePlan = returndata.LecturePlan;

          fn_popupint(returndata.lecturemodel);
          
          gfModalPop("#leclistpop");

              lec_yn();
      }

      callAjax("/std/LectureSelect.do", "post", "json", true, param, selectcallback);
   }
   
   
   /* 모달데이터작업 */
   function fn_popupint(data){

	  leclistpop.lec_cd = data.lec_cd;

	  leclistpop.lec_nm = data.lec_nm;

	  leclistpop.lec_ctg = data.lec_ctg;
	  
	  leclistpop.name = data.name;
	  
	  leclistpop.hp = data.hp;
	  
	  leclistpop.email = data.email;
	  
	  leclistpop.cls_room = data.cls_room;
	  
	  leclistpop.lec_goal = data.lec_goal;
   }
   
   /*내가 신청할 강의 시작일과 종료일 뽑아내기  */
   function CheckDay(){

      var param= {
            lec_cd: $("#lec_cd").val()
      }
      
      var listcallback = function(response){
         //console.log(response);
         leclistpop.lec_start_date = response.lec_start_date;
         leclistpop.lec_end_date = response.lec_end_date;
         PossibleSave(response);
      }
      callAjax("/std/checkdaty.do", "post", "JSON", false, param, listcallback);
   }
   
   
   // 버튼 누르고 CheckDay로 내가 신청할 강의의 날짜 뽑아내고 >  유효성검사 > 신청완료
   /*강의 신청전 유효성검사  */
   function PossibleSave(data){
      //console.log("PossibleSave:: data");
      //console.log(data);
      
          var param ={
        	   leclistpop.lec_cd: data.lec_cd,
        	   leclistpop.lec_start_date: data.lec_start_date,
        	   leclistpop.lec_end_date: data.lec_end_date,
        	   leclistpop.loginId:$("#loginId").val()
         }
         console.log(param);

          
        var listcallback = function(response){
            console.log(response);
            
            if( response > 0 ){
               alert("이미 수강신청중인 강의가있습니다");
               
            }else{
               //alert("유효성검사통과");
               
               fn_save();
            }

          }
         
         callAjax("/std/PossibleSave.do", "post", "JSON", false, param, listcallback);          
         
   }
   
   
   
   /* 강의신청하기  */
   function fn_save(){

       var param={
    		    lec_cd :leclistpop.lec_cd,
                lec_start_date : leclistpop.lec_start_date,
                lec_end_date : leclistpop.lec_end_date,
                loginId : leclistpop.loginId
       }

        var listcallback = function(response){
         console.log(response);
         
         if(response > 0){
            alert("강의가신청되었습니다 수강허가가 떨어지면 수강신청 완료됩니다");
            lec_yn();
            gfCloseModal();
            fn_searchlist();
            
         }else{
            alert("강의 신청 실패!");
            gfCloseModal();
            fn_searchlist();
         }    
       } 
       callAjax("/std/InsetLec.do", "post", "JSON", false, param, listcallback);
   }
   
   

   
   
   
   /* 오늘날짜구하기[시험응시일] */
   var today = new Date();
   
   var year = today.getFullYear();
   var month = ('0' + (today.getMonth() + 1)).slice(-2);
   var day = ('0' + today.getDate()).slice(-2);
   
   var dateString = year + '-' + month  + '-' + day;
   
 
   
   /*2023-10-09백한결 수정 */
   /* 신청취소 유효성추가  */
   function DeletePossible(){
	   
	   var param={
			   lec_cd : leclistpop.lec_cd,
			   dateString: dateString
	   }
	   console.log(param);
 	   
	   var listcallback = function(response){
		   console.log(response);
		   
		   if(response > 0 ){
			   fn_Delete();
			   
		   }else{
			   swal("이미 강의시작일자가 지난 강의는 수강 취소할 수 없습니다");
		   }
		  
	   }
	   
	   callAjax("/std/DeletePossible.do", "post", "JSON", false, param, listcallback);
   }
   
   
   
   
   /*강의 취소하기 */
   function fn_Delete(){
	   
       var param={
                lec_cd : leclistpop.lec_cd,
                loginId : leclistpop.loginId,
                app_yn : leclistpop.app_yn
       }

       console.log(param);
       
       var listcallback = function(response){
          console.log(response);
          
          if(response > 0){
        	  
             alert("수강 취소되었습니다");
             lec_yn(); 
             gfCloseModal();
             fn_searchlist();
             
          }else{
             alert("수강 신청되지 않은 강의입니다");
             gfCloseModal();
          }
          
       }
       callAjax("/std/deleteLec.do", "post", "JSON", false, param, listcallback);
       
   }
   
   
   
   /*강의신청여부조회  */
   function lec_yn(){
      
       var param={
                lec_cd : leclistpop.lec_cd,
                loginId : leclistpop.loginId
       } 
       
       var listcallback = function(response){
         console.log("lec_yn ::: ");
         console.log(response); //0 이면 DB에 값 없는것임 , 1이면 DB에 값 있는것임 
         
         leclistpop.lec_yn = response;
         
         
         if (leclistpop.lec_yn == 0){ //신청가능 수강취소는 불가능
        	 
        	leclistpop.btnDelete = false;
        	leclistpop.btnSave = true;
            
         }else{ //신청불가능 수강취소만 가능
            
        	leclistpop.btnDelete = true;
        	leclistpop.btnSave = false;
         }
       }
       
       callAjax("/std/lec_yn.do", "post", "JSON", false, param, listcallback);
   }
 
   
   
   
   /*강의 수락여부 조회하기[ 학생 본인이 강의 취소시, 이미 강사가 허가를 내준 상태였다면 정원이+1 되었을테니 만약 얘가 취소하면 강의정원(capacity) 값에 영향을 줘야하므로 기능추가]  */
   function app_yn(){
	   
       var param={
               lec_cd : leclistpop.lec_cd,
               loginId : leclistpop.loginId
      } 
       
      
      var listcallback = function(response){
    	   console.log("강의수락여부response ::: ");
    	   
    	   console.log(response);
      }
       
       callAjax("/std/app_yn.do", "post", "JSON", false, param, listcallback);
   }
   
   
</script>
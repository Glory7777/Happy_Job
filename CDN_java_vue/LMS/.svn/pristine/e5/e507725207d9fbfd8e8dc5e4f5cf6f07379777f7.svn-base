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

                  <p class="conTitle" id="conTitlediv" >
                  	<span>수업정보</span> <span class="fr"> 
                    <label for="assNumber">강의목록</label>
                    	<select id="selectBox" v-model="conTitle">
                    		<option value="">선택하세요</option>
                    		<option v-for="list in leclist" :value="list.lec_cd">{{list.lec_nm}}</option>
                   		</select>
                        <a class="btnType blue" @click="fn_searchlist()" name="modal"><span>검색</span></a>
                    </span>
                  </p>
                  
                  <div id="divList">    
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
                        <tbody>
                        <template v-if="totalcnt == 0">
                      		<tr><td>데이터가 존재하지 않습니다.</td></tr>
                        </template>
                        <template v-else v-for="lecture in listLecture">
	               			<tr>
	               				<td><a @click="fn_studentSelect(lecture.lec_cd)">{{lecture.lec_nm}}</td>
	               				<td>{{lecture.name}}</td>
	               				<td>{{lecture.lec_start_date}}</td>
	               				<td>{{lecture.lec_end_date}}</td>
	               				<td>{{lecture.app_cnt}}</td>
	               				<td>{{lecture.capacity}}</td>
	           				</tr>
                        </template>
                        </tbody>
                     </table>
                     <div class="paging_area"  id="lecPagination" v-html="lecPagination"> </div>
                  </div>
   
                  
                  
                <h3 class="hidden">contents 영역</h3> <!-- content -->
               <div class="content" id="studentList" v-show="subtable" style="display: none">

         <!-- 수강생명단 상세조회 -->
              <div>  
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
                        <tbody>
                        <template v-if="studentlist.length === 0">
                        	<tr><td colspan=6>조회된 데이터가 없습니다.</td></tr>
                        </template>
                        <template v-else v-for="student in studentlist">
                        	<tr>
                        		<td>{{student.lec_nm}}</td>
                        		<td>{{student.name}}</td>
                        		<td>{{student.birthday}}</td>
                        		<td>{{student.hp}}</td>
                        		<td>{{student.app_yn}}</td>
                        		<template v-if="student.app_yn == 'Y'">
                        			<td><a class="btnType blue" @click="possibleYN(student.loginID);" name="modal"><span>취소</span></a></td>
                        		</template>
                        		<template v-else>
                        			<td><a class="btnType blue" @click="memberCheck(student.loginID);" name="modal"><span>승인</span></a></td>
                        		</template>
                      		</tr>
                        </template>
                        </tbody>
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

    var conTitlevar;
    var divList;
    var studentList;
    
   $(function() {
      
	vueinit();
	
    //select 박스
    leclist();
    
    // 공지사항 조회
    fn_searchlist();
      
   });
   
	function vueinit() {
		conTitlevar = new Vue({
			el: "#conTitlediv",
			data: {
				leclist: [], 
    			conTitle : "",
			},
			methods : {
				fn_searchlist : function() {
					fn_searchlist();
				}
				
				
			}
		});
		
		divList = new Vue({
			el: "#divList",
			data: {
				listLecture: [],
    			currentPage: 1,
    			totalcnt: 0,
    			lecPagination: "",
    			lec_cd: "",
			},
			mehtods: {
				fn_studentSelect : function() {
					fn_studentSelect();
				}
			}
		});
		
		studentList = new Vue({
			el: "#studentList",
			data: {
				studentlist: [],
				subtable: false
			},
			methods : {
				memberCheck : function(loginid) {
					//alert(loginid);
					memberCheck(loginid);
				}
			}
		});
	}
   
   /*select박스  */
      function leclist() {
      
      /*
      var param={
            loginId: conTitlevar.loginId
      }*/
      
      var listcallback = function(returndata){
         console.log("강의명 select박스확인");
         console.log(returndata);
         
         conTitlevar.leclist = returndata.leclist;
      }
      
      callAjax("/tut/leclist.do", "post", "json", true, "", listcallback);
   } 
   
   
   
   /* 초기페이지 */
   function fn_searchlist(currentPage){
      console.log("초기페이지열림");
      divList.currentPage = currentPage || 1; 
      
      var param = {//pageSize(컨트롤러단에서 받을때 변수이름) : pageSize
          	pageSize : pageSize,
          	currentPage : divList.currentPage,
            conTitle : conTitlevar.conTitle
      }
      console.log(param);
      
       var listcallback = function(returndata){

         console.log("리턴값 : " + returndata);
         console.log(JSON.stringify(returndata));

         
         
         divList.listLecture = returndata.LectureStudentAllList;
         divList.totalcnt = returndata.totalcnt;
         
         console.log("총 건수::::바로 밑을봐!! ")
         console.log(divList.totalcnt);
         
         var paginationHtml = getPaginationHtml(divList.currentPage, divList.totalcnt, pageSize, pageBlockSize,'fn_searchlist');
         console.log("paginationHtml : " + paginationHtml);

         divList.lecPagination = paginationHtml;
         divList.currentPage = returndata.currentPage;  
      }
                     
       callAjax("/tut/LectureStudentAllListvue.do", "post", "json", true, param, listcallback); 
      
       
   }

   
   /*수강생명단 조회  */
   function fn_studentSelect(data){
            
	   divList.lec_cd = data; 
      
            var param={
            		lec_cd : divList.lec_cd
            }
            
                  console.log(param);
         
          var listcallback = function(returndata){
                   console.log(returndata.studentlist);   
               		
                   studentList.studentlist = returndata.studentlist;
          }
          callAjax("/tut/studentlist.do", "post", "json", true, param, listcallback);
          
          studentList.subtable = true;
         
   }
   
   
   
   /* 오늘날짜구하기[시험응시일] */
   var today = new Date();
   
   var year = today.getFullYear();
   var month = ('0' + (today.getMonth() + 1)).slice(-2);
   var day = ('0' + today.getDate()).slice(-2);
   
   var dateString = year + '-' + month  + '-' + day;
   
   /* 수강 취소 유효성검사 [2023-10-09 백한결 추가] */
   function possibleYN(liginID){
	   
	   var param={
			   lec_cd: divList.lec_cd,
			   dateString:dateString
	   }
	   
		
	   var listcallback = function(returndata){
		   console.log(returndata);
		   
		   if(returndata > 0){
			   console.log(" 시작한 강의 아니다 즉 유효성통과");
			   fn_app_No(liginID);  
		   
		   }else{
			   swal("이미 수강이 시작된 강의입니다. 수강취소가 불가합니다!")
		   }
		   
	   }
	   callAjax("/std/DeletePossible.do", "post", "JSON", false, param, listcallback);
   }


   
   /* 수강 신청 유효성검사 [2023-10-09 백한결 추가] */
   function possibleYN2(loginID){
	   
	   var param={
			   lec_cd : divList.lec_cd,
			   dateString : dateString
	   }
	   console.log(param);
		
	   var listcallback = function(returndata){
		   console.log(returndata);
		   
		   if(returndata > 0){
			   console.log(" 시작한 강의 아니다 즉 유효성통과");
			   fn_app_yes(loginID);
		   
		   }else{
			   swal("이미 수강이 시작된 강의입니다. 수강신청 할 수 없습니다")
		   }
		   
	   }
	   callAjax("/std/DeletePossible.do", "post", "JSON", false, param, listcallback);
   }
   
   
   

   
   /*수강신청 수락  */
   function fn_app_yes(loginID){

         
      var param={
            lec_cd: divList.lec_cd,
            approval: 'Y',
            loginId : loginID
      }
      

      var listcallback = function(returndata){
         if(returndata >= 0){
            
            swal("${sessionScope.loginId} 학생의  "+ returndata + "수강신청이 수락되었습니다");

            fn_studentSelect(divList.lec_cd);
            
            fn_searchlist();

         }
      }
      
       callAjax("/tut/studentYes.do", "post", "json", true, param, listcallback); 
    }
   
         
   
   
     /* 수강신청 취소 */    
     function   fn_app_No(loginID){ //data 뺌
        
         var param={
                 lec_cd: divList.lec_cd,
                 approval: 'N',
                 loginId : loginID
                 
         } 
         console.log("여기확인");
         console.log(param);
         
         var listcallback = function(returndata){
        	 
             if(returndata > 0){
                
                swal(" "+ data + "학생의 수강신청이 거절되었습니다");
                
                fn_studentSelect(divList.lec_cd);
                
                fn_searchlist();
                
             }
          }     
         
         callAjax("/tut/studentNO.do", "post", "json", true, param, listcallback); 
     }  
         
     
     
     /* 수강인원 체크하기 */
     function memberCheck(loginID){
    	 
         var param={
        	lec_cd : divList.lec_cd,
         } 
         
         var listcallback = function(returndata){

            console.log(returndata);
             
            if(returndata == 1){
               //alert("유효성검사통과");
               possibleYN2(loginID);
               //fn_app_yes(data);
               
            }else if(returndata ==0){
               
               swal("수강인원이 다 참");
               
            }
            
         }
        
         callAjax("/tut/memberCheck.do", "post", "json", true, param, listcallback); 
         
     }
     
     
     
     
</script>
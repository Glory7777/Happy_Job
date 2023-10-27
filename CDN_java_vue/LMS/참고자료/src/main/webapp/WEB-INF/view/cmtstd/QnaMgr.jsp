<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>QNA</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>


<script type="text/javascript">
   //그룹코드 페이징 설정
   var pageSize = 5;//한페이지에 몇건 보여줄래?
   var pageBlockSize = 5;

   $(function() {

      // qns 조회
      fn_searchlist();

      // 버튼 이벤트 등록
      fRegisterButtonClickEvent();
   });

   /** 버튼 이벤트 등록 */
   function fRegisterButtonClickEvent() {
      $('a[name=btn]').click(function(e) {
         e.preventDefault();

         var btnId = $(this).attr('id');

         switch (btnId) {
         case 'btnSave':
            fn_Save();
            break;
         case 'btnDelete':
            fn_Delete();
            break;
         case 'btnClose':
            gfCloseModal();
            fn_searchlist();
            break;
         }
      });
   }

  //신규등록버튼 강사는 못보도록
   if ($("#userType").val() === 'B') {
       $('#newRegistrationButton').hide();
   }
   
   //전체조회함수
   function fn_searchlist(currentPage) {

      var currentPage = currentPage || 1;

      var param = {
         pageSize : pageSize,
         currentPage : currentPage,
         searchtext : $("#searchtext").val(),
         searchsel : $("#searchsel").val()
      }

      var listcallback = function(returndata) {
         console.log(returndata);
         $("#listqna").empty().append(returndata);

         console.log($("#totalcnt").val());

         var totalcnt = $("#totalcnt").val();

         var paginationHtml = getPaginationHtml(currentPage, totalcnt, pageSize, pageBlockSize, 'fn_searchlist');
         console.log("paginationHtml : " + paginationHtml);

         $("#qnaPagination").empty().append(paginationHtml);

         $("#currentPagenotice").val(currentPage);

      }

      callAjax("/qanda/listqna.do", "post", "text", true, param, listcallback); //text , JSON 두가지있는데 CONTROLLER 의 타입이 뭐냐할때~!!!!! 목록 뿌려줄때만 TEXT 로 지정

   }

   
   //데이터작업
   function fn_popupint(data) {

      if (data == null || data == undefined || data == "") {
         
         $("#brd_no").val("");
         $("#reply_no").val("");
         $("#qna_title").val("");
         $("#qna_content").val("");
         $("#qnacomment").text("");      // span 태그 전용 (값을 초기화 하여도 text 값을 가지고 있음)
         $("#commentDate").text("");   // span 태그 전용 (값을 초기화 하여도 text 값을 가지고 있음)
         $("#qnacomment").val("");      // span 태그 값만 초기화
         $("#commentDate").val("");      // span 태그 값만 초기화
         $("#qna_content").removeAttr("readonly");
         $("#qna_title").removeAttr("readonly");
         $("#btnSave").show();
         $("#action").val("I");

         $("#regdate").text("");
         $("#qna_view").text("");

         $("#btnDelete").hide();

      } else {
      
         if($("#userType").val() === 'A'){
                $("#qna_content").removeAttr("readonly");
                $("#qna_title").removeAttr("readonly");
         }else{
            $("#qna_content").attr("readonly","readonly");
            $("#qna_title").attr("readonly","readonly");
         }

         $("#qnacomment").removeAttr("readonly");
         $("#qna_title").val(data.brd_title);
         $("#qna_content").val(data.brd_ctt);
         $("#brd_no").val(data.brd_no);
         $("#reply_no").val(data.reply_no);
         $("#ans_yn").val(data.ans_yn);
         
         $("#action").val("U");
         $("#qnacomment").val(data.reply_ctt);
         $("#regdate").text(data.brd_reg_date);
         $("#qna_view").text(data.brd_veiws_cnt);

         $("#btnDelete").show();
      }
   }
   
   
   
   /** 저장 validation */
   function fValidate() {

      var chk = checkNotEmpty(
            [
                  [ "qna_title", "제목를 입력해 주세요." ]
               ,   [ "qna_content", "내용을 입력해 주세요" ]            ]
      );

      if (!chk) {
         return;
      }

      return true;
   }
   
   //신규등록시
   function fn_openpopup() {
      //데이터작업
      fn_popupint();

      // 모달 팝업
      gfModalPop("#qnapop");

   }


   
   //제목 클릭시 단건조회
   function fn_titleSelectqna(brd_no) {
         console.log(brd_no);
   
         var param = {
            brd_no : brd_no
         }
   
         var selectcallback = function(returndata) {
                  console.log(JSON.stringify(returndata));
                  
                  fn_popupint(returndata.sectinfo);
                  $("#qnacomment").text(returndata.sectinfo.reply_ctt);
                  $("#commentDate").text(returndata.sectinfo.reg_date);
               
                  if(returndata.sectinfo.reply_ctt==null || returndata.sectinfo.reply_ctt == undefined){
                     $("#qnacomment").text("대기중");
                     $("#commentDate").text("");
                  }
      
      
               if( $("#loginid").val() == returndata.sectinfo.loginID ){
                     $("#btnSave").show();
                     alert("너가쓴거다! 수정 가능해 ㄱ");
                     $("#qnacomment").attr("readonly","readonly");
                     $("#btnDelete").show();
                     $("#qna_content").removeAttr("readonly");
                     $("#qna_title").removeAttr("readonly");

                   
               }else if( $("#loginid").val() != returndata.sectinfo.loginID){
                     $("#btnSave").hide();
                     alert("너가쓴글 아냐 수정못해ㅋㅋ ");
                     $("#btnDelete").hide();
                     $("#qnacomment").attr("readonly","readonly");
                     $("#qna_content").attr("readonly","readonly");
                     $("#qna_title").attr("readonly","readonly");
                   
               } 
               
      
               gfModalPop("#qnapop");
   
         }
   
         callAjax("/qanda/qnaselect.do", "post", "json", true, param, selectcallback);

   }
   

   
   //저장하기
   function fn_Save(){
         //답글이 없을경우
         
         if($("#action").val() == 'D') {
            console.log("삭제합니다.");
         } else if( $("#userType").val() ==='B'){
               if($("#reply_no").val() ==0){
                  console.log("답변없다 그래서 답글쓰고 저장해줌");
                  $("#action").val('I'); 

               
               }else if(($("#reply_no").val() !=0)){
                   console.log("답변있다");
                   $("#action").val('U'); 

               }
         }
         
         // alert($("#action").val());

   
          var param = {
                qna_title : $("#qna_title").val() ,
                qna_content : $("#qna_content").val() ,
                action : $("#action").val() ,
                brd_no:  $("#brd_no").val(),
                userType:  $("#userType").val(),
                reply_no:  $("#reply_no").val(),
                qnacomment : $("#qnacomment").val(),

          }
         
          console.log(param);
         
            var savecallback = function(returnvalue) {
             console.log(JSON.stringify(returnvalue));
             
             if(returnvalue.result == "SUCCESS") {
                alert("저장 되었습니다.");
                gfCloseModal();
                
                if($("#action").val() == "I") {
                   fn_searchlist($("#currentPagenotice").val());
                } else if($("#action").val() == "U") {
                   fn_searchlist($("#currentPagenotice").val());
                } else if($("#action").val() == "D") {
                   fn_searchlist($("#currentPagenotice").val());
                }
             }
         }   
          
         callAjax("/qanda/qnasave.do", "post", "json", true, param, savecallback);
   }
   
   //수정하기 
   function fn_updateSelectqna(brd_no) {
         console.log(brd_no);
   
         var param={
               brd_no: brd_no,
               userType: $("#userType").val()
         }
         
         console.log(param);
         
         var selectcallback = function(returndata) {
           console.log(JSON.stringify(returndata));
            
            fn_popupint(returndata.sectinfo);
            
            $("#btnDelete").show();
            $("#btnSave").show();

            gfModalPop("#qnapop");
   
         }
   
         callAjax("/qanda/qnaselect.do", "post", "json", true, param, selectcallback);

   }

   
   //삭제하기
   function fn_Delete(){
      
         $("#action").val("D");
         fn_Save();
      
   }
   
   
</script>
<body>
   <form id="myForm" action="" method="">
      <input type="hidden" id="currentPagenotice" />
      <input type="hidden" id="action" />
      <input type="hidden" name="name" id="userType" value="${userType}">
      <input type="hidden" name="name" id="loginid" value="${loginid}">
      <input type="hidden" id="brd_no"  name="brd_no" />
      <input type="hidden" id="reply_no"  name="reply_no" />


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
                        <a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a>
                        <span class="btn_nav bold">기준정보</span> <span
                           class="btn_nav bold"> Q&A관리</span> <a href="/qanda/a_qanda.do"
                           class="btn_set refresh">새로고침</a>
                     </p>

                     <p class="conTitle">
                        <span>Q&A</span> <span class="fr"> <span class="fr">
                              <select id="searchsel" name="searchsel">
                                 <option value="">전체</option>
                                 <option value="title">제목</option>
                                 <option value="content">내용</option>
                                 <option value="regname">등록자</option>
                           </select>
                            <input type="text" id="searchtext" name="searchtext" style="width: 150px; height: 25px;" />
                             <a class="btnType blue" href="javascript:fn_searchlist();" name="modal"><span>검색</span></a>
                              <c:if test="${sessionScope.userType eq 'A'}">
                                <a class="btnType blue" href="javascript:fn_openpopup();" name="modal" id="newRegistrationButton"><span >신규등록</span></a>
                             </c:if>
                             
                        </span>
                     </p>

                     <div class="divComGrpCodList">
                        <table class="col">
                           <caption>caption</caption>
                           <colgroup>
                              <col width="10%">
                              <col width="20%">
                              <col width="20%">
                              <col width="10%">
                              <col width="10%">
                              <col width="5%">
                              <c:if test="${sessionScope.userType eq 'B'}">
                                 <col width="5%">
                              </c:if>   
                           </colgroup>

                           <thead>
                              <tr>
                                 <th scope="col">번호</th>
                                 <th scope="col">제목</th>
                                 <th scope="col">내용</th>
                                 <th scope="col">작성자</th>
                                 <th scope="col">조회수</th>
                                 <th scope="col">답변여부</th>
                                 <c:if test="${sessionScope.userType eq 'B'}">
                                    <th scope="col">수정</th>
                                 </c:if>      
                              </tr>
                           </thead>
                           <tbody id="listqna"></tbody>
                        </table>
                     </div>

                     <div class="paging_area" id="qnaPagination"></div>


                  </div> <!--// content -->

                  <h3 class="hidden">풋터 영역</h3> <jsp:include
                     page="/WEB-INF/view/common/footer.jsp"></jsp:include>
               </li>
            </ul>
         </div>
      </div>

      <!--// 모달팝업 -->

      <!--// 모달팝업 -->
      <div id="qnapop" class="layerPop layerType2" style="width: 600px;">
         <dl>
            <dt>
               <strong>QNA 등록</strong>
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
                              <th scope="row">등록 일자</th>
                              <td id="regdate"></td>
                              <th scope="row">조회수</th>
                              <td id="qna_view"></td>
                     </tr>
                     <tr>
                        <th scope="row">QNA 제목 <span class="font_red">*</span></th>
                        <td colspan="3"><input type="text" class="inputTxt p100"name="qna_title" id="qna_title" /></td>
                     </tr>
                     <tr>
                        <th scope="row">QNA 내용 <span class="font_red">*</span></th>
                        <td colspan="3"><textarea name="notice_content" id="qna_content" rows="5" cols="30"></textarea></td>
                     </tr>
                     <tr id="commentHide">
                        <th>답변</th>
                        <td colspan="3">
                           <c:choose>
                              <c:when test="${sessionScope.userType eq 'B'}">
                                 <textarea name="qnacomment" class="inputTxt p100"  id="qnacomment"></textarea>
                              </c:when>
                              <c:otherwise>
                                 <span id="commentDate"></span>
                                 <br />
                                 <span id="qnacomment"></span>
                              </c:otherwise>
                           </c:choose></td>
                     </tr>
                  </tbody>
               </table>

               <!-- e : 여기에 내용입력 -->

               <div class="btn_areaC mt30">
                  <a href="" class="btnType blue" id="btnSave" name="btn"><span>저장</span></a>
                  <a href="" class="btnType blue" id="btnDelete" name="btn"><span>삭제</span></a>
                  <a href="" class="btnType gray" id="btnClose" name="btn"><span>취소</span></a>
               </div>
            </dd>
         </dl>
         <a href="" class="closePop"><span class="hidden">닫기</span></a>
      </div>


   </form>
</body>
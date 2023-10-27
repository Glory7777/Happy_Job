<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


            
      <!-- 갯수가 0인 경우  -->
      <c:if test="${totalcnt eq 0 }">
         <tr>
            <td colspan="7">데이터가 존재하지 않습니다.</td>
         </tr>
      </c:if>

      <!-- 갯수가 있는 경우  -->
      <c:if test="${totalcnt > 0 }">
         <c:forEach items="${listqna}" var="list">
            <tr>
                   <td>${list.brd_no}</a></td>
                  <td><a href="javascript:fn_titleSelectqna(${list.brd_no});">${list.brd_title}</a></td>
                  <td>${list.brd_ctt}</td>
                  <td>${list.name}</td>
                  <td>${list.brd_veiws_cnt}</td>
                  <td>  
					  <c:choose>
					    <c:when test="${list.ans_yn == 'Y'}">답변</c:when>
					    <c:otherwise>미답변</c:otherwise>
					  </c:choose>
  				</td>
                   <c:if test="${sessionScope.userType eq 'B'}">
	                  <td>
	                     <a class="btnType3 color1" href="javascript:fn_updateSelectqna(${list.brd_no});"><span>수정</span></a>
	                  </td>
	               </c:if>   
               <!-- List에 있는 js 함수 호출가능 이거 그대로 가지고 가기 때문에 !!  -->
            </tr>
         </c:forEach>
      </c:if>
      
      <!-- 이거 중간에 있으면 table 안먹힘  -->

        <input type="hidden" id="totalcnt" name="totalcnt" value="${totalcnt}"/>
        <input type="hidden" id="ans_yn" name="ans_yn" value="${ans_yn}"/>
        
        <script>
        	console.log("미답답 확인");
        	console.log($("#ans_yn").val());
        </script>
        

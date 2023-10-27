<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


            
      <!-- 갯수가 0인 경우  ㅋㅋ-->
      <c:if test="${totalcnt eq 0 }">
         <tr>
            <td colspan="7">데이터가 존재하지 않습니다.</td>
         </tr>
      </c:if>

      <!-- 갯수가 있는 경우  -->
      <c:if test="${totalcnt > 0 }">
         <c:forEach items="${LectureStudentAllList}" var="list">
            <tr>
                   <td><a href="javascript:fn_studentSelect(${list.lec_cd});">${list.lec_nm}</a></td>
                  <td>${list.name}</td>
                  <td>${list.lec_start_date}</td>
                  <td>${list.lec_end_date}</td>
                  <td>${list.app_cnt}</td>
                  <td>${list.capacity}</td>
            </tr>
         </c:forEach>
      </c:if>


        <input type="hidden" id="totalcnt" name="totalcnt" value="${totalcnt}"/>

        
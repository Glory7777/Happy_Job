<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
		<c:if test="${totalcnt eq 0 }">
			<tr>
				<td colspan="5">데이터가 존재하지 않습니다.</td>
			</tr>
		</c:if>
		
		<c:if test="${totalcnt > 0 }">
			<c:forEach items="${gradeList}" var="list">
				<tr>
					<td>${list.test_cd}</td>
					<td><a href="javascript:fn_findStdList('${list.test_cd}')">${list.test_nm}</a></td>
					<td>${list.test_start_date}</td>
					<td>${list.test_end_date}</td>
					<td>${list.lec_nm}</td>
				</tr>
			</c:forEach>
		</c:if>
		
		<input type="hidden" id="totalcnt" name="totalcnt" value ="${totalcnt}"/>
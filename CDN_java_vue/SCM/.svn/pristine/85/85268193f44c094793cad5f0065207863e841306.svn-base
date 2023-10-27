<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


				
		<!-- 갯수가 0인 경우  -->
		<c:if test="${totalCnt eq 0 }">
			<tr>
				<td colspan="6">데이터가 존재하지 않습니다.</td>
			</tr>
		</c:if>
		

		<!-- 갯수가 있는 경우  -->
		<c:if test="${totalCnt > 0 }">
			<c:forEach items="${supList}" var="list">
				<tr>
						<td>${list.sup_cd}</td>						
					    <td>${list.sup_nm}</td>
						<td>${list.sup_manager}</td>
						<td>${list.sup_hp}</td>
						<td>${list.sup_email}</td>
						<td>${list.sup_addr}</td>
				</tr>
			</c:forEach>
		</c:if>
		
		<input type="hidden" id="totalCnt"  value="${totalCnt}">

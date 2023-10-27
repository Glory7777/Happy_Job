<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


				
		<!-- 갯수가 0인 경우  -->
		<c:if test="${dtTotalCnt eq 0 }">
			<tr>
				<td colspan="5">데이터가 존재하지 않습니다.</td>
			</tr>
		</c:if>
		

		<!-- 갯수가 있는 경우  -->
		<c:if test="${dtTotalCnt > 0 }">
			<c:forEach items="${dtList}" var="list">
				<tr >
					<td>${list.order_cd}</td>				
					<td>${list.name}</td>						
					<td>${list.order_cnt}</td>
				    <td>${list.order_date}</td>
					<td class="cash">${list.order_price}</td>
				</tr>
			</c:forEach>
		</c:if>
		
		<input type="hidden" id="dtTotalCnt"  value="${dtTotalCnt}">

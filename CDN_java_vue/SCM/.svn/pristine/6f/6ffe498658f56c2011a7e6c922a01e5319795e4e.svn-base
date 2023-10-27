<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


				
		<!-- 갯수가 0인 경우  -->
		<c:if test="${totalCnt eq 0 }">
			<tr>
				<td colspan="4">데이터가 존재하지 않습니다.</td>
			</tr>
		</c:if>
		

		<!-- 갯수가 있는 경우  -->
		<c:if test="${totalCnt > 0 }">
			<c:forEach items="${productList}" var="list">
				<tr onclick="fn_detail(${list.pro_cd}); ">
					<td>${list.pro_nm}</td>						
				    <td>${list.pro_stock}</td>
					<td>${list.total_sales_cnt}</td>
					<td class="cash">${list.total_sales}</td>
				</tr>
			</c:forEach>
		</c:if>
		
		<input type="hidden" id="totalCnt"  value="${totalCnt}">

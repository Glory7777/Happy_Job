<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


				
		<!-- 갯수가 0인 경우  -->
		<c:if test="${productTotalCnt eq 0 }">
			<tr>
				<td colspan="7">데이터가 존재하지 않습니다.</td>
			</tr>
		</c:if>
		

		<!-- 갯수가 있는 경우  -->
		<c:if test="${productTotalCnt > 0 }">
			<c:forEach items="${productList}" var="list">
				<tr>
						<td>${list.pro_cd}</td>						
					    <td>${list.pro_nm}</td>
						<td>${list.pro_stock}</td>
						<td class="cash">${list.pro_sup_price}</td>
						<td class="cash">${list.pro_unit_price}</td>
				</tr>
			</c:forEach>
		</c:if>
		
		<input type="hidden" id="productTotalCnt"  value="${productTotalCnt}">

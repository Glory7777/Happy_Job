<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


				
		<!-- 갯수가 0인 경우  -->
		<c:if test="${totalCnt eq 0 }">
			<tr>
				<td colspan="8">데이터가 존재하지 않습니다.</td>
			</tr>
		</c:if>
		

		<!-- 갯수가 있는 경우  -->
		<c:if test="${totalCnt > 0 }">
			<c:forEach items="${productList}" var="list">
				<c:if test="${list.pro_cd != 0}">
					<tr onclick="fn_selectProduct(${list.pro_cd}); ">
							<td>${list.pro_cd}</td>						
						    <td>${list.pro_nm}</td>
							<td>${list.pro_model_nm}</td>
							<td>${list.pro_mfc}</td>
							<td>${list.pro_stock}</td>
							<td>${list.pro_unit_price}</td>
							<td>${list.pro_sup_price}</td>
					</tr>				
				</c:if>
			</c:forEach>
		</c:if>
		
		<input type="hidden" id="totalCnt"  value="${totalCnt}">

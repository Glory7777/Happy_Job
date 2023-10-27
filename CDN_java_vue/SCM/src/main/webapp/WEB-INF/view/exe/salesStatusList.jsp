<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


				
		<!-- 갯수가 0인 경우  -->
		<c:if test="${totalCnt eq 0 }">
			<tr>
				<td colspan="7">데이터가 존재하지 않습니다.</td>
			</tr>
		</c:if>
		

		<!-- 갯수가 있는 경우  -->
		<c:if test="${totalCnt > 0 }">
			<c:forEach items="${ssList}" var="list">
				<tr>
					<td>${list.order_cd}</td>						
				    <td>${list.pro_nm}</td>
					<td>${list.name}</td>
					<td>
						<c:if test="${list.refund_yn eq 1}">
						  o
						</c:if>
					</td>
					<td>${list.order_date}</td>
					<td>${list.order_cnt}</td>
					<td> <span class="cash">${list.order_price}</span></td>
					<td> <span class="cash">${list.net_profit}</span></td>
				</tr>
			</c:forEach>
		</c:if>
		
		<input type="hidden" id="totalCnt"  value="${totalCnt}">

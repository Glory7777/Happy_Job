<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
	<c:if test="${totalcnt eq 0 }">
		<tr>
			<td colspan="7">데이터가 존재하지 않습니다.</td>
		</tr>
	</c:if>
	
	<c:if test="${totalcnt > 0 }">
		<c:forEach items="${orderList}" var="list">
			<tr>
				<td>${list.order_cd}</td>
				<td style="cursor: pointer;">
					<c:choose>
						<c:when test="${list.deli_st == '2' and list.order_st == '1'}">
							<a href="javascript:fn_selectOrderDetail('${list.order_cd}')">${list.pro_nm}</a>
						</c:when>
						<c:otherwise>
							<a href="javascript:fn_OrderDetail('${list.order_cd}')">${list.pro_nm}</a>
						</c:otherwise>
					</c:choose>
				</td>
				<td>${list.order_cnt}</td>
				<td>
					<fmt:formatNumber type="number" maxFractionDigits="3" value="${list.order_price}" /> 원
				</td>
				<td>${list.order_date}</td>
				<td>${list.order_hope_date}</td>
				<td>
					<c:choose>
						<c:when test="${list.deli_st == null or list.order_st == '0'}">
							<span style="color:black; font-weight: bold;">주문 완료</span> 
					    </c:when>
					    <c:when test="${list.deli_st == '0'}">
							<span style="color:blue; font-weight: bold;">배송준비중</span> 
					    </c:when>
					    <c:when test="${list.deli_st == '1'}">
							<span style="color:green; font-weight: bold;">배송중</span>
					    </c:when>
					    <c:when test="${list.deli_st == '2'}">
							<span style="color:#9c3b3b; font-weight: bold;">배송완료</span>
					    </c:when>
					</c:choose>
				</td>
			</tr>
		</c:forEach>
	</c:if>
	
	<input type="hidden" id="totalcnt" name="totalcnt" value ="${totalcnt}"/>

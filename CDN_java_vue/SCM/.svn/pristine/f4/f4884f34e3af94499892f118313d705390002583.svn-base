<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

	<c:forEach items="${notDeliveryOrderDetailList}" var="list">
		<tr>
			<td>${ list.order_cd }</td>
			<td>${ list.ct_nm }</td>
			<td>${ list.pro_model_nm }</td>
			<td>${ list.pro_nm }</td>
			<td>${ list.pro_mfc }</td>
			<td>${ list.order_cnt }</td>
			<td>
				<fmt:formatNumber type="number" maxFractionDigits="3" value="${ list.order_price }"/> 원
			</td>
		</tr>
	</c:forEach>

	<input type="hidden" id="totalcnt" name="totalcnt" value ="${totalcnt}"/>

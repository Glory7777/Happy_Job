<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
	<c:forEach items="${orderDetailList}" var="list">
		<tr>
			<c:if test="${ list.refund_yn eq 0 }">
				<td>
					<input type="radio" id="${ list.pro_cd }Select" name="select" class="select" value="${ list.pro_cd }"/>
				</td>
			</c:if>
			<c:if test="${ list.refund_yn eq 1 }">
				<td style="font-size: 11px; color: tomato;">
					<input type="radio" name="select" disabled/>
				</td>
			</c:if>
			<td><label for="${ list.pro_cd }Select">${ list.order_cd }</label></td>
			<td><label for="${ list.pro_cd }Select">${ list.ct_nm }</label></td>
			<td><label for="${ list.pro_cd }Select">${ list.pro_model_nm }</label></td>
			<td><label for="${ list.pro_cd }Select">${ list.pro_nm }</label></td>
			<td><label for="${ list.pro_cd }Select">${ list.pro_mfc }</label></td>
			<td><label for="${ list.pro_cd }Select">${ list.order_cnt }</label></td>
			<td>
				<label for="${ list.pro_cd }Select"><fmt:formatNumber type="number" maxFractionDigits="3" value="${ list.order_price }"/> 원</label>
			</td>
			<c:if test="${ list.refund_yn eq 0 }">
				<td>
					<input type="number" style="height:25px; width: 50px;" max="${ list.order_cnt }" min="0" value="0" onchange="fn_refundCnt(${ list.order_price }, ${ list.order_cnt }, ${ list.pro_cd })" id="${ list.pro_cd }refundCnt">
				</td>
				<td>
					<span id="${ list.pro_cd }refundPrice" class="refundPrice">-</span>
				</td>
			</c:if>
			<c:if test="${ list.refund_yn eq 1 }">
				<td style="font-weight: bold; color: darkgray;">${ list.refund_cnt }</td>
				<td style="font-weight: bold; color: darkgray;">
					<fmt:formatNumber type="number" maxFractionDigits="3" value="${ list.refund_price }"/> 원
				</td>
			</c:if>
		</tr>
		
		<input type="hidden" id="proCd" value="${ list.pro_cd }"/>
	</c:forEach>
	
	
	
	<input type="hidden" id="totalcnt" name="totalcnt" value ="${totalcnt}"/>

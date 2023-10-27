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
		<c:forEach items="${refundHistoryList}" var="list">
			<tr style="cursor: pointer;" onclick="fn_refundHistoryDetail('${list.refund_cd}', '${list.order_cd}', '${list.pro_nm}', '${list.pro_model_nm}', '${list.refund_cnt}', '${list.refund_date}'
																			, '${list.refund_text}', '${list.refund_st}', '${list.refund_price}' )">
				<td>${list.refund_cd}</td>
				<td>${list.order_cd}</td>
				<td>${list.pro_nm}</td>
				<td>${list.refund_date}</td>
				<c:if test="${list.refund_st eq 0}"><td style="color: tomato; font-weight: bold;">반품 신청</td></c:if>
				<c:if test="${list.refund_st eq 1}"><td style="color: #4ea5d9; font-weight: bold;">반품 승인</td></c:if>
				<c:if test="${list.refund_st eq 2}"><td style="color: darkgray; font-weight: bold;">수거 완료</td></c:if>
				<c:if test="${list.refund_st eq 3}"><td style="color: darkgray; font-weight: bold;">반품 완료</td></c:if>
			</tr>
		</c:forEach>
	</c:if>
	
	<input type="hidden" id="totalcnt" name="totalcnt" value ="${totalcnt}"/>

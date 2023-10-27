<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
							<c:if test="${totalcnt eq 0 }">
								<tr>
									<td colspan="9">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							
							<c:if test="${totalcnt > 0 }">
								<c:forEach items="${ pcmRefundDirectionList }" var="list">
									<tr onclick="fn_refundDirectionDetail(${ list.order_cd }, '${ list.loginid }', '${ list.pro_nm }', '${ list.bank_cd }', ${ list.account_num }, ${ list.refund_cnt }
																			, ${ list.refund_price }, '${ list.refund_text }')" style="cursor: pointer;">
										<td>${ list.refund_cd }</td>
										<td>${ list.loginid }</td>
										<td>${ list.pro_nm }</td>
										<td>${ list.refund_date }</td>
										<c:if test="${ list.refund_st eq 0}"><td style="color: tomato; font-weight: bold;">미승인</td></c:if>
										<c:if test="${ list.refund_st eq 1}"><td style="color: #4ea5d9; font-weight: bold;">반품 승인</td></c:if>
										<c:if test="${ list.refund_st eq 2}"><td style="color: darkgray; font-weight: bold;">입고처리</td></c:if>
									</tr>
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="totalcnt" name="totalcnt" value ="${totalcnt}"/>
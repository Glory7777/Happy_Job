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
								<c:forEach items="${ refundDirectionList }" var="list">
									<tr>
										<td>${ list.refund_cd }</td>
										<td>${ list.pro_nm }</td>
										<td>${ list.order_date }</td>
										<td>${ list.refund_cnt }</td>
										<td>
											<fmt:formatNumber type="number" maxFractionDigits="3" value="${ list.refund_price }" /><span> 원</span>
										</td>
										<c:if test="${ list.refund_st eq 0}"><td style="color: tomato; font-weight: bold;">미승인</td></c:if>
										<c:if test="${ list.refund_st ne 0}"><td style="color: #4ea5d9; font-weight: bold;">승인</td></c:if>
									</tr>
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="totalcnt" name="totalcnt" value ="${totalcnt}"/>
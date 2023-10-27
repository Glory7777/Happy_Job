<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

							<c:if test="${totalCnt eq 0}">
								<tr>
									<td colspan="12">주문이 존재하지 않습니다.</td>
								</tr>
							</c:if>
							
							<c:if test="${totalCnt > 0}">
								<c:forEach items="${orderList}" var="list">
									<tr>
										<td>${list.order_cd}</td>
										<td>${list.order_date}</td>
										<td>${list.name}</td>
										<td>${list.pro_nm}</td>										
										<td>${list.order_cnt}</td>
										<td>${list.pro_stock}</td>
										<td>${list.order_price}</td>
										<td>${list.pro_unit_price}</td>
										<td>${list.order_hope_date}</td>
										<td>입금</td>
										<td>
											<c:choose>
											    <c:when test="${list.order_st == '0'}">
											        <a class="btnType3 color2" href="javascript:fn_selectDelivery('${list.order_cd}', '${list.pro_cd}')">
														<span>배송</span>
													</a>
											    </c:when>
											    <c:otherwise>
											       	 배송지지서 작성 완료
											    </c:otherwise>
											</c:choose>
										</td>
										<td>
											<c:if test="${list.order_pur == '1'}">										
												<span>발주 지시서 작성 완료</span>											
											</c:if>
											<c:if test="${list.order_pur != '1'}">
												<a class="btnType3 color1" href="javascript:fn_selectOrder('${list.order_cd}', '${list.pro_cd}')">
													<span>발주</span>
												</a>	
											</c:if>											
										</td>
									</tr>
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="totalCnt" name="totalCnt" value="${totalCnt}" />							
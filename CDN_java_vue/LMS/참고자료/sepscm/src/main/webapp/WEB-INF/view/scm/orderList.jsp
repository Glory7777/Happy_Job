<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	

							<c:if test="${totalCnt eq 0}">
								<tr>
									<td colspan="13">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							
							<c:if test="${totalCnt > 0}">
								<c:forEach items="${orderList}" var="list">
									<tr>
										<td>${list.order_cd}</td>
										<td>${list.order_date}</td>
										<td>${list.name}</td>
										<td>${list.pro_nm}</td>
										<td>${list.pro_sup_price}</td>
										<td>${list.order_cnt}</td>
										<td>${list.pro_stock}</td>
										<td>${list.order_price}</td>
										<td>${list.pro_unit_price}</td>
										<td>${list.order_hope_date}</td>
										<td>입금</td>
										<td>
											<a class="btnType3 color2" href="">
												<span>배송</span>
											</a>
										</td>
										<td>																	
											<a class="btnType3 color1" href="javascript:fn_selectOrder('${list.order_cd}', '${list.pro_cd}')">
												<span>발주</span>
											</a>												
										</td>
									</tr>
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="totalCnt" name="totalCnt" value="${totalCnt}" />							
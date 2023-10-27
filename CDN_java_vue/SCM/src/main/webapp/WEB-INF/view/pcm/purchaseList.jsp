<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
							
							<c:if test="${totalCnt eq 0}">
								<tr>
									<td colspan="14">발주 지시서가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							
							<c:if test="${totalCnt > 0}">								
								<c:forEach items="${purchaseList}" var="list">
									<tr>
										<td>${list.pur_cd}</td>
										<td>${list.pur_date}</td>										
										<td>${list.pro_nm}</td>
										<td>	${list.pro_stock}</td>
										<td>	${list.pur_cnt}</td>
										<td>${list.pro_unit_price}</td>										
										<td>
										    ${list.pur_total_unit_price}
										</td>
										<td>											
											<a href="javascript:fn_selectSup('${list.sup_cd}')">${list.sup_nm}</a>										
										</td>
										<td>${list.pur_nm}</td>										
										<td>
											<c:if test="${list.pur_appr eq '1'}">
												승인 완료
											</c:if>
											<c:if test="${list.pur_appr eq '2'}">
												입금 완료
											</c:if>
											<c:if test="${list.pur_appr eq '3'}">
												입고 완료
											</c:if>													
										</td>																
										<td>											
											<c:if test="${list.pur_appr eq '1'}">
												<a class="btnType3 color2" href="javascript:fn_Update('${list.pur_cd}','${list.pur_total_unit_price}')" id="btnUpdate" name="btn">
													<span>입금</span>
												</a>
											</c:if>
											<c:if test="${list.pur_appr eq '2'}">
												입금 완료
											</c:if>
											<c:if test="${list.pur_appr eq '3'}">
												입고 완료
											</c:if>	
										</td>																			
									</tr>									
								</c:forEach>
							</c:if>																		
							
							<input type="hidden" id="totalCnt" name="totalCnt" value="${totalCnt}" />							
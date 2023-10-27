<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

							<c:if test="${totalCnt eq 0}">
								<tr>
									<td colspan="10">상품이 존재하지 않습니다.</td>
								</tr>
							</c:if>
							
							<c:if test="${totalCnt > 0}">
								<c:forEach items="${scmPurchaseList}" var="list">
									<tr>
										<td>${list.pur_cd}</td>
										<td>${list.pro_nm}</td>
										<td>${list.pro_unit_price}</td>
										<td>${list.pur_cnt}</td>
										<td>${list.pur_total_unit_price}</td>
										<td>${list.sup_nm}</td>	
										<td>${list.pur_nm1}</td>	
										<td>${list.pur_date}</td>
										<td>
											<c:if test="${list.pur_appr == '0'}">
												미승인
											</c:if>
											<c:if test="${list.pur_appr == '1'}">
												승인
											</c:if>
											<c:if test="${list.pur_appr == '2'}">
												입금 완료
											</c:if>
											<c:if test="${list.pur_appr == '3'}">
												입고 완료
											</c:if>											
										</td>
										<td>
											<a class="btnType3 color1" href="javascript:fn_selectPurchase('${list.pur_cd}')">
												<span>보기</span>
											</a>											
										</td>
									</tr>								
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="totalCnt" name="totalCnt" value="${totalCnt}" />	
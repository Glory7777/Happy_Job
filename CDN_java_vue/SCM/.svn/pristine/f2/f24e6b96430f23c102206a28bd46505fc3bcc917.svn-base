<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
					

						    
						
							<c:if test="${totalcnt eq 0 }">
								<tr>
									<td colspan="7">배송지시서가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							
							<c:if test="${totalcnt > 0 }">
								<c:forEach items="${listDeliveryDirection}" var="list">
									<tr>
										<td>${list.order_cd}</td>
										<td>${list.pro_nm}</td>
										<td>${list.order_date}</td>
										<td>${list.loginid}</td>
										<td>${list.order_cnt}</td>
										<td>${list.order_hope_date}</td>
										<td>
											<c:choose>
											    <c:when test="${list.deli_st == '0'}">
											        <a class="btnType3 color1" href="javascript:fn_selectDelivery('${list.direc_cd}','${list.deli_st}','${list.deli_cd}')">
														<span style="color:blue; font-weight: bold;">배송준비중</span> 
													</a>
											    </c:when>
											    <c:when test="${list.deli_st == '1'}">
											        <a class="btnType3 color1" href="javascript:fn_selectDelivery('${list.direc_cd}','${list.deli_st}','${list.deli_cd}')">
														<span style="color:green; font-weight: bold;">배송중</span>
													</a> 
											    </c:when>
											    <c:when test="${list.deli_st == '2'}">
											        <a class="btnType3 color1" href="javascript:fn_selectDelivery('${list.direc_cd}','${list.deli_st}','${list.deli_cd}')">
														<span style="color:#9c3b3b; font-weight: bold;">배송완료</span>
													</a>
											    </c:when>
											</c:choose>
										</td>
										
									</tr>
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="totalcnt" name="totalcnt" value="${totalcnt}"/>
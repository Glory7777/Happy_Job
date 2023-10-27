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
										<td>${ list.direc_cd }</td>
										<td>${ list.refund_cd }</td>
										<td>${ list.loginid }</td>
										<td>${ list.pro_nm }</td>
										<td>${ list.order_date}</td>
										<td>${ list.refund_date}</td>
										<td>${ list.order_cnt}</td>
										<td>${ list.refund_cnt }</td>
										<td>
											<fmt:formatNumber type="number" maxFractionDigits="3" value="${ list.refund_price }" /><span> 원</span>
										</td>
										<td>
											<c:choose>
												<c:when test="${empty confirmCompleteList}">
													<a href="javascript:fn_refundConfirm('${list.refund_cd}')" class="btnType blue">
														<span>열기</span>
													</a>
												</c:when>
												<c:otherwise>
													<c:set var="found" value="false" />
													<c:forEach items="${confirmCompleteList}" var="cList">
														<c:if test="${list.refund_cd eq cList.refund_cd}">
															<span style="color: darkgray; font-weight: bold;">승인 완료</span>
															<c:set var="found" value="true" />
														</c:if>
													</c:forEach>
													<c:if test="${found eq false}">
														<a href="javascript:fn_refundConfirm('${list.refund_cd}')" class="btnType blue">
															<span>승인</span>
														</a>
													</c:if>
												</c:otherwise>
											</c:choose>
										</td>
									</tr>
									<input type="hidden" id="refundText" name="refundText" value="${ list.refund_text }"/>
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="totalcnt" name="totalcnt" value ="${totalcnt}"/>
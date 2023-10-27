<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

							<c:if test="${totalCnt eq 0}">
								<tr>
									<td colspan="12">입고 처리할 내역이 존재하지 않습니다.</td>
								</tr>
							</c:if>		
							
							<c:if test="${totalCnt > 0}">
							    <c:set var="nRow" value="0" />
								<c:forEach items="${stockedList}" var="list">
									<tr>
										<td>${list.pur_cd}</td>
										<td>${list.pro_cd}</td>
										<td>${list.pro_nm}</td>
										<td>${list.pro_mfc}</td>
										<td>
											<a href="javascript:fn_selectSup('${list.sup_cd}')">${list.sup_nm}</a>
										</td>									
										<td>${list.pro_stock}</td>
										<td id="pur_cnt${nRow}">${list.pur_cnt}</td>
										<td>
											<c:if test="${list.pur_stk_cnt ==null}">
												<input type="number" id="pur_stk_cnt${nRow}" name="pur_stk_cnt${nRow}" style="width:70px;">
											</c:if>
											<c:if test="${list.pur_stk_cnt !=null}">
												<input type="number" id="pur_stk_cnt${nRow}" name="pur_stk_cnt${nRow}" value="${list.pur_stk_cnt}" style="width:70px;" readonly>
											</c:if>
										</td>										
										<td>											
											<c:if test="${list.pur_appr eq '2'}">
												입금 완료
											</c:if>
											<c:if test="${list.pur_appr eq '3'}">
												입고 완료
											</c:if>										
										</td>
										<td>${list.del_nm}</td>
										<td>${list.pur_stk_date}</td>
										<td>	
											<c:if test="${list.pur_appr == '2'}">																
											<a class="btnType3 color1" href="javascript:fn_Update('${nRow}', '${list.pur_cd}', '${list.pro_cd}')">
												<span>입고</span>
											</a>	
											</c:if>	
											<c:if test="${list.pur_appr == '3'}">																
												입고 완료
											</c:if>																						
										</td>
									</tr>
									<c:set var="nRow" value="${nRow + 1}" />
								</c:forEach>
							</c:if>									
							
							<input type="hidden" id="totalCnt" name="totalCnt" value="${totalCnt}" />		
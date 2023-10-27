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
								<c:forEach items="${listProduct}" var="list">
									<tr>
										<td>${list.pro_cd}</td>
										<td>${list.ct_cd}</td>
										<td><a href="javascript:fn_selectProduct('${list.pro_cd}')">${list.pro_nm}</a></td>
										<td>${list.pro_mfc}</td>
										<td><fmt:formatNumber value="${list.pro_sup_price}" type="currency"/></td>
										
									</tr>
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="totalcnt" name="totalcnt" value ="${totalcnt}"/>
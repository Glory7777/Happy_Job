<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

							<c:if test="${totalCnt eq 0}">
								<tr>
									<td colspan="6">상품이 존재하지 않습니다.</td>
								</tr>
							</c:if>
							
							<c:if test="${totalCnt > 0}">
								<c:forEach items="${stockedProductList}" var="list">
									<tr>
										<td>${list.ct_cd}</td>
										<td>${list.pro_cd}</td>
										<td>${list.ct_nm}</td>
										<td>${list.pro_nm}</td>
										<td>${list.pro_model_nm}</td>
										<td>${list.pro_stock}</td>										
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="totalCnt" name="totalCnt" value="${totalCnt}" />	
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
							<c:if test="${stdTotalcnt eq 0 }">
								<tr>
									<td colspan="4">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							
							<c:if test="${stdTotalcnt > 0 }">
								<c:forEach items="${stdList}" var="list">
									<tr>
										<td>${list.name}</td>
										<td>${list.lec_nm}</td>
										<td>${list.hp}</td>
										<td>${list.email}</td>
									</tr>
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="stdTotalcnt" name="stdTotalcnt" value ="${stdTotalcnt}"/>
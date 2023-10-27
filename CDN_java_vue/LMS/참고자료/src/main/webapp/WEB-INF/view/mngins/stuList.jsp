<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
							<c:if test="${stuTotalcnt eq 0 }">
								<tr>
									<td colspan="5">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							
							
							<c:if test="${stuTotalcnt > 0 }">
								<c:forEach items="${stuList}" var="list">
									<tr>
										<td>${list.loginId}</td>
										<td>${list.name}</td>
										<td>${list.score}</td>
										<td>${list.test_state}</td>
										<td>${list.test_sm_date}</td>
									</tr>
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="stuTotalcnt" name="stuTotalcnt" value ="${stuTotalcnt}"/>
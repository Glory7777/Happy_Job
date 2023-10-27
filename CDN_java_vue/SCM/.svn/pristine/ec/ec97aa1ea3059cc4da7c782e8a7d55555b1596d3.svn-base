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
								<c:forEach items="${listnotice}" var="list">
									<tr>
										<td>${list.notice_cd}</td>
										<td><a href="javascript:fn_selectnoticedile('${list.notice_cd}')">${list.notice_title}</a></td>
										<td>${list.notice_reg_date}</td>
										<td>${list.notice_read_cnt}</td>
										<td>${list.notice_delete_yn}</td>
										<td>${list.loginid}</td>										
									</tr>
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="totalcnt" name="totalcnt" value ="${totalcnt}"/>
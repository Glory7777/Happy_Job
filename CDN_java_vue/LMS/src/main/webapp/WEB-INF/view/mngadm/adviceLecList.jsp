<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
							<c:if test="${totalcnt eq 0 }">
								<tr>
									<td colspan="4">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							
							<c:if test="${totalcnt > 0 }">
								<c:forEach items="${lectureAdviceList}" var="list">
									<tr>
										<td>${list.lec_cd}</td>
										<td><a href="javascript:fn_findLec(1, ${list.lec_cd}, '${list.lec_nm}', '${list.ins_id}','${list.ins_nm}')">${list.lec_nm}</a></td>
										<td>${list.lec_start_date} ~ ${list.lec_end_date}</td>
										<td>${list.ins_nm}</td>
									</tr>
									<c:set var="nRow" value="${nRow + 1}" />
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="totalcnt" name="totalcnt" value ="${totalcnt}"/>
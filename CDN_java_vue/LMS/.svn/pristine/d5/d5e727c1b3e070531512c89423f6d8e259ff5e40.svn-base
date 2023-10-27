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
								<c:forEach items="${adviceList}" var="list">
									<tr>
										<td>${totalcnt - nRow}</td>
										<td>${list.lec_nm}</td>
										<td>${list.std_nm} (${list.std_id})</td>
										<td>${list.cst_date}</td>
										<td>${list.cst_yn}</td>
										<td>
											<a href="javascript:fn_selectAdv('${list.std_id}')" class="btnType blue" name="btn"><span>수정/삭제</span></a>
											
										</td>
									</tr>
									<c:set var="nRow" value="${nRow + 1}" />
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="totalcnt" name="totalcnt" value ="${totalcnt}"/>
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
								<c:forEach items="${ dlmRefundList }" var="list">
									<tr onclick="fn_dlmRefundDetail(${ list.refund_cd }, '${ list.ct_nm }', '${ list.pro_model_nm }', '${ list.pro_nm }', '${ list.pro_mfc }', ${ list.refund_cnt}, '${ list.refund_text }', ${ list.pro_cd })" style="cursor: pointer;" >
										<td>${ list.refund_cd }</td>
										<td>${ list.pro_model_nm }</td>
										<td>${ list.pro_nm }</td>
										<td>${ list.refund_cnt}</td>
										<td>${ list.refund_appr_date}</td>
									</tr>
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="totalcnt" name="totalcnt" value ="${totalcnt}"/>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
							<c:if test="${advTotalcnt eq 0 }">
								<tr>
									<td colspan="6">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							
							<c:if test="${advTotalcnt > 0 }">
								<c:forEach items="${advStuList}" var="list">
									<tr>
										<td>${list.cst_no}</td>
										<td>${list.lec_nm}</td>
										<td>${list.std_nm}(${list.std_id}) </td>
										<td>${list.cst_date}</td>
										<td>${list.ins_nm}(${list.ins_id}) </td>
										<td><a class="btnType3 color1" href="javascript:fnSelect('${list.cst_no}');"><span>수정</span></a></td>
									</tr>
									<c:set var="nRow" value="${nRow + 1}" />
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="advTotalcnt" name="advTotalcnt" value ="${advTotalcnt}"/>
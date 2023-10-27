<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
							<c:if test="${totalcnt eq 0 }">
								<tr>
									<td colspan="6">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							
							<c:if test="${totalcnt > 0 }">
								<c:forEach items="${advStuList}" var="list">
									<tr>
										<td>${list.lec_cd}</td>
										<td>${list.lec_nm}</td>
										<td>${list.std_id} (${list.std_nm}) </td>
										<td>${list.std_nm}</td>
										<td>${list.cst_date} </td>
										<td>${list.ins_nm} (${list.ins_id})</td>
										<td><a class="btnType3 color1" href="javascript:fnSelectDtl('${list.lec_cd}','${list.std_id}');"><span>수정</span></a></td>
										<td><a href="javascript:fn_selectStu('${list.lec_cd}')">${list.lec_nm}</a></td>
									</tr>
									<c:set var="nRow" value="${nRow + 1}" />
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="totalcnt" name="totalcnt" value ="${totalcnt}"/>
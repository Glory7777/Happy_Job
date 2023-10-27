<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
							<c:if test="${totalcnt eq 0 }">
								<tr>
									<td colspan="8">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							
							<c:if test="${totalcnt > 0 }">
								<c:forEach items="${lecList}" var="list">
									<tr>
										<td>${list.lec_cd}</td>
										<td><a href="javascript:fn_selectLec('${list.lec_cd}')">${list.lec_nm} (대상 : ${list.lec_ctg})</a></td>
										<td>${list.name}</td>
										<td>${list.cls_room}</td>
										<td>${list.capacity}</td>
										<td>${list.app_cnt}</td>
										<td>${list.lec_start_date} <span> ~ </span> ${list.lec_end_date}</td>
										<td>
											<a href="javascript:fn_selectLec('${list.lec_cd}')" class="btnType blue" name="btn"><span>수정/삭제</span></a>
										</td>
									</tr>
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="totalcnt" name="totalcnt" value ="${totalcnt}"/>
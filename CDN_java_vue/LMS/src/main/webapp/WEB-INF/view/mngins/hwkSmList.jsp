<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
	
	<c:forEach items="${appStdList}" var="list">
		<tr>
			<td>${list.loginID}</td>
			<td>${list.name}</td>
			<td>
				<c:if test="${list.smState == '제출'}">
					<a href="javascript:fn_hwkSmInfo('${list.loginID}')">${list.smState}</a>
				</c:if>
				<c:if test="${list.smState == '미제출'}">
					${list.smState}
				</c:if>
			</td>
		</tr>
	</c:forEach>

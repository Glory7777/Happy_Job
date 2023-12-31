<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:if test="${totalcnt eq 0 }">
	<tr>
		<td colspan="6">데이터가 존재하지 않습니다.</td>
	</tr>
</c:if>

<c:if test="${totalcnt > 0 }">
	<c:forEach items="${cusInfoList}" var="list">
		<tr>
			<td>${list.user_type}</td>
			<td>${list.loginid}</td>
			<td><a href="javascript:fn_selectCusInfo('${list.loginid}')">${list.name}</a></td>
			<td>${list.user_hp}</td>
			<td>${list.user_yn}</td>
		</tr>
	</c:forEach>
</c:if>

<input type="hidden" id="totalcnt" name="totalcnt" value="${totalcnt}" />
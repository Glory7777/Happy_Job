<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
	<c:if test="${empty lecInfo}">
		<tr>
			<td colspan="7">데이터가 존재하지 않습니다.</td>
		</tr>
	</c:if>
	
	<c:if test="${not empty lecInfo}">
		<tr>
			<td>${lecInfo.lec_nm}</td>
			<td>${lecInfo.name}</td>
			<td>${lecInfo.lec_start_date}</td>
			<td>${lecInfo.lec_end_date}</td>
			<td>${lecInfo.cls_room}</td>
			<td>${lecInfo.app_cnt}</td>
			<td>${lecInfo.capacity}</td>
		</tr>
	</c:if>

	<script>
		$("#lec_cd").val('${lecInfo.lec_cd}');
	</script>

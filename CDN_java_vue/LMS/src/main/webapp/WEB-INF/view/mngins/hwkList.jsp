<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
	<c:if test="${totalcnt == 0}">
		<tr>
			<td colspan="5">데이터가 존재하지 않습니다.</td>
		</tr>
	</c:if>
	
	<c:if test="${totalcnt != 0}">
		<c:forEach items="${hwkList}" var="list">
			<tr>
				<td>${list.hwk_no}</td>
				<td>
					<a href="javascript:fn_selectHwk('${list.lec_cd}', '${list.hwk_no}')">${list.hwk_nm}</a>
				</td>
				<td>${list.hwk_start_date}</td>
				<td>${list.hwk_end_date}</td>
				<td>
					<a href="javascript:fn_stdList('${list.lec_cd}', '${list.hwk_no}')">자세히보기</a>
				</td>
			</tr>
		</c:forEach>
	</c:if>
	
	<script>
		var temp = '${hwkListJS}';
		var hwkList = JSON.parse(temp);
	</script>
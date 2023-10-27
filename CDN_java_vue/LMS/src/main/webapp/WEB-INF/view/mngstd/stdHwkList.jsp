<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
	<c:if test="${totalcnt == 0}">
		<tr>
			<td colspan="4">과제가 없습니다.</td>
		</tr>
	</c:if>
	
	<c:if test="${totalcnt != 0}">
		<c:forEach items="${hwkList}" var="list" varStatus="status">
			<tr>
				<td>${status.count}</td>
				<td>
					<a href="javascript:fn_hwkSm(${list.hwk_no})">${list.hwk_nm}</a>
				</td>
				<td>${list.hwk_start_date} ~ ${list.hwk_end_date}</td>
				<td>
					<c:if test="${list.hwk_file_no != 1}">
						<a class="btnType blue" href="javascript:fn_hwkFileDown('${list.hwk_file_no}')"><span>다운로드</span></a>
					</c:if>
				</td>
			</tr>
		</c:forEach>
	</c:if>
	
	<input type="hidden" id="totalcnt" name="totalcnt" value ="${totalcnt}"/>
	
	<script>
		var temp = '${hwkListJS}';
		var hwkList = JSON.parse(temp);
	</script>
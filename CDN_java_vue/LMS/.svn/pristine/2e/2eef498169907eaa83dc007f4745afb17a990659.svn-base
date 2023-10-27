<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
	<c:if test="${totalcnt eq 0 }">
		<tr>
			<td colspan="3">주차 계획이 존재하지 않습니다.</td>
		</tr>
	</c:if>
	
	
	<c:if test="${totalcnt > 0 }">
		<c:forEach items="${aLMList}" var="list" varStatus="status">
			<tr>
				<td>${status.count}</td>
				<td><a href="javascript:fn_selectWeek('${list.lec_file_no}', '${list.weekly_no}')">${list.weekly_no}</a></td>
				<td>
					<c:choose>
						<c:when test="${list.lec_file_upload_date == 'temp'}">
							<span>파일 없음</span>
						</c:when>
						<c:otherwise>
							${list.lec_file_upload_date}
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
		</c:forEach>
	</c:if>
							
	<input type="hidden" id="sel_lec_nm" value="${lec_nm}"/>				
	<script>
		$("#lec_nm").html($("#sel_lec_nm").val() + "&nbsp&nbsp" + "학습자료");
	</script>						

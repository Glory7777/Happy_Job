<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
	<c:if test="${totalcnt eq 0 }">
		<tr>
			<td colspan="4">주차 계획이 존재하지 않습니다.</td>
		</tr>
	</c:if>
	
	
	<c:if test="${totalcnt > 0 }">
		<c:forEach items="${weeklyList}" var="list">
			<tr>
				<td>${list.weekly_no}</td>
				<td>${list.week_goal}</td>
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
				<td>
					<a href="javascript:fn_filePop('${list.lec_cd}', '${list.weekly_no}')" class="btnType blue" id="fileBtn" name="fileBtn"><span>등록/수정</span></a> 
				</td>
			</tr>
		</c:forEach>
	</c:if>
							

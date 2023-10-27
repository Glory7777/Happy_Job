<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


				
		<!-- 갯수가 0인 경우  -->
		<c:if test="${totalCnt eq 0 }">
			<tr>
				<td colspan="7">데이터가 존재하지 않습니다.</td>
			</tr>
		</c:if>
		

		<!-- 갯수가 있는 경우  -->
		<c:if test="${totalCnt > 0 }">
			<c:forEach items="${supList}" var="list">
				<tr onclick="fn_selectSupplier(${list.sup_cd}); ">
						<td>${list.sup_cd}</td>						
					    <td>${list.sup_nm}</td>
						<td>${list.sup_manager}</td>
						<td>${list.sup_hp}</td>
						<td>${list.sup_email}</td>
						<td>${list.sup_addr}</td>
						<td>
							<a href="javascript:fn_updateSupplier('${list.sup_cd}');" class="btnType3 color1"><span>수정</span></a>
						</td>
				</tr>
			</c:forEach>
		</c:if>
		
		<input type="hidden" id="totalCnt"  value="${totalCnt}">

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


				
		<!-- 갯수가 0인 경우  -->
		<c:if test="${totalCnt eq 0 }">
			<tr>
				<td colspan="8">데이터가 존재하지 않습니다.</td>
			</tr>
		</c:if>
		

		<!-- 갯수가 있는 경우  -->
		<c:if test="${totalCnt > 0 }">
			<c:set var="nRow" value="${pageSize*(currentPage-1)}" /> 
			<c:forEach items="${listJob}" var="list">
				<tr>
						<td><a href="javascript:fnSelectId('${list.loginID}')">${list.name}(${list.loginID})</a></td> 
						<!--  -->
			            <c:choose>
			                <c:when test="${list.com_nm eq null}">
			                    <td>미입력</td>
			                </c:when>
			                <c:otherwise>
			                    <td>${list.com_nm}</td>
			                </c:otherwise>
			            </c:choose>
					    <td>${list.hp}</td>
			            <c:choose>
			                <c:when test="${list.join_date eq null}">
			                    <td>미입력</td>
			                </c:when>
			                <c:otherwise>
			                    <td>${list.join_date}</td>
			                </c:otherwise>
			            </c:choose>
			            <c:choose>
			                <c:when test="${list.leave_date eq null}">
			                    <td>미입력</td>
			                </c:when>
			                <c:otherwise>
			                    <td>${list.leave_date}</td>
			                </c:otherwise>
			            </c:choose>
			            <c:choose>
			                <c:when test="${empty list.reg_yn || list.reg_yn eq 'N'}">
			                    <td>미입력</td>
			                </c:when>
			                <c:otherwise>
			                    <td>${list.job_ctg}</td>
			                </c:otherwise>
			            </c:choose>
						<td><a class="btnType3 color1" href="javascript:fnSelectId('${list.loginID}')"><span>수정</span></a></td>
					<!-- List에 있는 js 함수 호출가능 이거 그대로 가지고 가기 때문에 !!  -->
				</tr>
				 <c:set var="nRow" value="${nRow + 1}" /> 
			</c:forEach>
		</c:if> <!-- 12. 이미 데이터 처리는 xml에서 되있고 여긴 그냥 for each로 뽑기만 합시다. 끝나면 다시 메인 jsp로 ㄱㄱ -->
		
		<!-- 이거 중간에 있으면 table 안먹힘  -->

        <input type="hidden" id="totalCnt" name="totalCnt" value="${totalCnt}"/>












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
			<c:forEach items="${listRoom}" var="list">
				<tr>
					    <td>${list.cls_room_cd}</td>
						<td><a href="javascript:fnListRoomDtl(1, ${list.cls_room_cd}, '${list.cls_room_nm}')">${list.cls_room_nm}</a></td>
						<%-- ; --%>
						<td>${list.cls_room_size}</td>
						<td>${list.cls_room_seat}</td>
						<td>${list.cls_room_use_yn}</td>
						<td style="white-space: nowrap; overflow: hidden; text-overflow: ellipsis; max-width: 30%;">
						    ${list.cls_room_etc}
						</td>
						<td>
							<a class="btnType3 color1" href="javascript:fnSelectRoom(${list.cls_room_cd})"><span>수정</span></a>
						</td>
					<!-- List에 있는 js 함수 호출가능 이거 그대로 가지고 가기 때문에 !!  -->
				</tr>
				 <c:set var="nRow" value="${nRow + 1}" /> 
			</c:forEach>
		</c:if> <!-- 12. 이미 데이터 처리는 xml에서 되있고 여긴 그냥 for each로 뽑기만 합시다. 끝나면 다시 메인 jsp로 ㄱㄱ -->
		
		<!-- 이거 중간에 있으면 table 안먹힘  -->

        <input type="hidden" id="totalCnt" name="totalCnt" value="${totalCnt}"/>












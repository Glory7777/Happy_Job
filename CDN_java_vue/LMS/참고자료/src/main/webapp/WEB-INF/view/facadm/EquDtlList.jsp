<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
					<div class="divEmpty">
						<div class="hiddenData">
							  <span id="totalCntEquDtl">${totalCntEquDtl}</span>
						</div>
						<table class="col">
							<thead>
								<tr>
									<th scope="col">순번</th>
									<th scope="col">장비코드</th>
									<th scope="col">장비명</th>
									<th scope="col">강의실</th>
									<th scope="col">사용개수</th>
									<th scope="col">비고</th>
									<th scope="col">수정</th>
								</tr>
							</thead>
							<tbody id="listEquDtl">
							<c:if test="${totalCntEquDtl eq 0 }">
								<tr>
									<td colspan="7">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							<c:set var="nRow" value="${pageSize*(currentPageDtl-1)}" />
							<c:forEach items="${listEquDtlModel}" var="list">
								<tr>
									<td>${totalCntEquDtl - nRow}</td>
									<td>${list.equ_cd}</td>
									<td>${list.equ_nm}</td>
									<td>${list.cls_room_nm}</td>
									<td>${list.use_cnt}</td>
									<td>${list.etc}</td>
									
									<td><a class="btnType3 color1" href="javascript:fnSelectDtl('${list.equ_cd}','${list.cls_room_cd}');"><span>수정</span></a></td><%--  --%>
								</tr>
								<c:set var="nRow" value="${nRow + 1}" />
							</c:forEach>
							</tbody>
						</table>
					</div>
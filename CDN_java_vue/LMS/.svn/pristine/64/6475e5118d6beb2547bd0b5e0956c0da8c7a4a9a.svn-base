<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
					<div class="divEmpty">
						<div class="hiddenData">
							  <span id="totalCntStdLec">${totalCntStdLec}</span>
						</div>
						<table class="col">
							<thead>
								<tr>
									<th scope="col">강의코드</th>
									<th scope="col">강의명</th>
									<th scope="col">강사명</th>
									<th scope="col">강의실</th>
									<th scope="col">강의시작일</th>
									<th scope="col">강의종료일</th>
									<th scope="col">승인여부</th>
									<th scope="col">종강여부</th>
									<th scope="col">상태</th>
								</tr>
							</thead>
							<tbody id="listStdLec">
							<c:if test="${totalCntStdLec eq 0 }">
								<tr>
									<td colspan="7">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							<c:set var="nRow" value="${pageSize*(currentPageDtl-1)}" />
							<c:forEach items="${listStdLecModel}" var="list">
								<tr>
									<%-- <td>${totalCntEquDtl - nRow}</td> --%>
									<td>${list.lec_cd}</td>
									<td><a href="javascript:fnSelectLec('${list.lec_cd}','${list.loginID}')">${list.lec_nm}</a></td>
									<td>${list.ins_nm}</td>
									<td>${list.cls_room}</td>
									<td>${list.lec_start_date}</td>
									<td>${list.lec_end_date}</td>
									<td>${list.app_yn}</td>
									<td>${list.end_yn}</td>
									<td>${list.lec_status}</td>
									
								</tr>
								<c:set var="nRow" value="${nRow + 1}" />
							</c:forEach>
							</tbody>
						</table>
					</div>
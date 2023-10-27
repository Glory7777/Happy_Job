<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

							<c:if test="${totalcnt eq 0 }">
								<tr>
									<td colspan="9">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							
							<c:if test="${totalcnt > 0 }">
								<c:forEach items="${listCart}" var="list">
									<tr>
										<td><input type="checkbox" name="selectedItems" id="selectedItems" class="selectedItems" value="${list.pro_cd}"></td>
										<td>${list.pro_cd}</td>
										<td>
											<img alt="제품 이미지" src="${list.logic_path}" width="100" height="100">
										</td>
										<td>${list.pro_nm}</td>
										<td>${list.pro_sup_price}</td>
										<td><input type="number" name="cart_cnt" id="cart_cnt" value="${list.cart_cnt}" onchange="javascript:fn_changeCartCnt(this)"></td>
										<td>${list.pro_sup_price * list.cart_cnt}</td>
										<td><input type="date" name="order_hope_date" id="order_hope_date" value="${list.order_hope_date}"></td>
										<td><a href="javascript:fn_deleteCart('${list.pro_cd}')"	class="btnType gray"  id="deleteCart" name="btn"><span>취소</span></a></td>
									</tr>
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="totalcnt" name="totalcnt" value ="${totalcnt}"/>
							<input type="hidden" id="totalcnt" name="totalcnt" value ="${list.logic_path}"/>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

		
		<c:if test="${totalcnt eq 0 }">
			<div style="text-align: center; margin-top: 25%; color:darkgray; font-weight: bold;">데이터가 존재하지 않습니다.</div>
		</c:if>
		
		<c:if test="${totalcnt > 0 }">
		
			<div class="slideshow-container" style="margin-top: 50px;">
				<c:set var="slideCount" value="${fn:length(productList) / 3}" />
				<c:forEach var="slideNum" begin="0" end="${slideCount - 1}">
					<div style="display: flex; justify-content: center;" class="slideDiv fade${slideNum == 0 ? ' active' : ''}"> <!-- 첫번째 슬라이드일때만 class에 active 추가 -->
						<c:forEach items="${productList}" var="list" begin="${slideNum * 3}" end="${(slideNum + 1) * 3 - 1}">
						
							<!-- 슬라이드 안에 출력되는 내용 -->
							<div style="width: 280px; margin: 10px;" onclick="javascript:fn_selectProduct('${list.pro_cd}')">
								<c:set var="found" value="false" />
								<c:forEach items="${ fileList }" var="fList">
									<c:if test="${ list.pro_cd eq fList.pro_cd }">
										<div style="overflow: hidden; width: 278px; height: 200px; border: 1px solid black;">
											<img src="${ fList.logic_path }" style="width: 100%; height: 100%; object-fit: cover; object-position: center;">
										</div>
										<c:set var="found" value="true" />
									</c:if>
								</c:forEach>
								<c:if test="${found eq false}">
									<div style="overflow: hidden; width: 278px; height: 200px; border: 1px solid black; background: lightgray;">
										<p style="text-align: center; margin-top: 30%; color: darkgray;">No Image</p>
									</div>
								</c:if>
								
								<div style="padding: 10px;">
									<div style="white-space:nowrap; text-overflow: ellipsis; overflow: hidden; font-weight: bold;">상품 명 : ${ list.pro_nm }</div>
									<div style="font-weight: bold;">가격 : <fmt:formatNumber type="number" maxFractionDigits="3" value="${ list.pro_sup_price }"/> 원</div>
									<textarea readonly="readonly" style="resize:none; margin-top: 10px; height:150px; border: 1px solid lightgray;">${ list.pro_dt }</textarea>
								</div>
							</div>
						
						</c:forEach>
					</div>
				</c:forEach>
				
				<a class="slidePrev" onclick="fn_prevSlide()">&#10094;</a>
				<a class="slideNext" onclick="fn_nextSlide()">&#10095;</a>	
			
			</div>
		</c:if>

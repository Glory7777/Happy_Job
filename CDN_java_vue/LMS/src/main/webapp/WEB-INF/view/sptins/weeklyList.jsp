<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

							
						   
	<c:if test="${empty weeklyList}">
		<tr>
			<script>
				$("#currentWeeklySize").val("1");
				$("input[name=weekly_no]").attr("value", $("#currentWeeklySize").val() + "주차");
				$("#weekly_no_show").text($("#currentWeeklySize").val() + "주차");
				$("#action").val("I");
				$("#DBweeklySize").val();
			</script>
			<td style="display: none;">
				<input type="hidden" name="weekly_no" />
			</td>
			<td id="weekly_no_show"></td>
			<td>
				<textarea id="week_goal" name="week_goal" rows="5" cols="30" style="resize:none; border:none; outline:none;" readonly></textarea>
			</td>
			<td>
				<textarea id="week_ctt" name="week_ctt" rows="5" cols="30" style="resize:none; border:none; outline:none;" readonly></textarea>
			</td>
		</tr>
		<script></script>
	</c:if>
	
	<c:if test="${not empty weeklyList}" >
		<c:forEach items="${weeklyList}" var="list">
			<tr>
				<td style="display: none;">
					<input type="hidden" name="weekly_no" value="${list.weekly_no}"/>
				</td>
				<td>${list.weekly_no}</td>
				<td>
					<textarea id="week_goal" name="week_goal" rows="5" cols="30" style="resize:none; border:none; background-color: transparent; outline:none;" readonly>${list.week_goal}</textarea>
				</td>
				<td>
					<textarea id="week_ctt" name="week_ctt" rows="5" cols="30" style="resize:none; border:none; background-color:transparent; outline:none;" readonly>${list.week_ctt}</textarea>
				</td>
			</tr>
		</c:forEach>
		<script>
			$("#currentWeeklySize").val($("input[name=weekly_no]").length);
			$("#action").val("U");
		</script>
	</c:if>
	
	<input type="hidden" id="preWeeklySize" name="preWeeklySize" value="${preWeeklySize}" />

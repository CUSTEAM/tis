<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<select name="cno" class="form-control">
	<c:forEach items="${allCampus}" var="c">
	<option <c:if test="${c.idno eq cno}">selected</c:if> value="${c.idno}">${c.name}</option>
	</c:forEach>
</select>
<select name="stno" class="form-control">
	<option value="">選擇部制</option>
	<c:forEach items="${allSchoolType}" var="c">
	<option <c:if test="${c.idno eq stno}">selected</c:if> value="${c.idno}">${c.name}</option>
	</c:forEach>
</select>
<select name="sno" class="form-control">
	<option value="">選擇學制</option>
	<c:forEach items="${allSchool}" var="c">
	<option <c:if test="${c.idno eq sno}">selected</c:if> value="${c.idno}">${c.name}</option>
	</c:forEach>
</select>

<select name="cono" class="form-control">
	<option value="">選擇學院</option>
	<c:forEach items="${college}" var="c">
	<option <c:if test="${c.idno eq cono}">selected</c:if> value="${c.idno}">${c.name}</option>
	</c:forEach>
</select>
<select name="dno" class="form-control">
	<option value="">選擇科系</option>
	<c:forEach items="${allDept}" var="c">
	<option <c:if test="${c.idno eq dno}">selected</c:if> value="${c.idno}">${c.name}</option>
	</c:forEach>
</select>
<select name="gno" class="form-control">
	<option value="">選擇年級</option>
	<c:forEach var="g" begin="1" end="6">
	<option <c:if test="${gno eq g}">selected</c:if> value="${g}">${g}年級</option>
	</c:forEach>
</select>
<select name="zno" class="form-control">
	<option value="">選擇班級</option>
	<option <c:if test="${zno eq '1'}">selected</c:if> value="1">甲班</option>
	<option <c:if test="${zno eq '2'}">selected</c:if> value="2">乙班</option>
	<option <c:if test="${zno eq '3'}">selected</c:if> value="3">丙班</option>
</select>
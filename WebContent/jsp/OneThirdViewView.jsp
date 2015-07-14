<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>班級曠缺紀錄</title>
<script src="/eis/inc/js/develop/stdinfo.js"></script>
<script src="/eis/inc/js/develop/timeInfo.js"></script>
<script>  
$(document).ready(function() {	
	$("input[name='beginDate']").change(function(){
		//alert($("#beginDate").val());
		$("#endDate").val($("#beginDate").val());
	});	
});
</script>
</head>
<body>
<form action="OneThirdView" method="post">
<div class="alert">
	<button type="button" class="close" data-dismiss="alert">&times;</button>
	
	<strong>課程曠缺預警</strong>查詢, 
	
	
	<c:if test="${!empty myStds}">
	<button name="method:creatSearch" type="submit" class="btn">改變查詢條件</button>
	<a href="OneThirdView"class="btn btn-danger">返回班級列表</a>
	
	</c:if>
	預設顯示導師班級,「缺課⅓差距3節內」包含達到缺課⅓的同學	
</div>




<c:if test="${empty myStds}">
<table class="table">
	<tr>
		<td class="text-info" nowrap>查詢範圍</td>
		<td class="control-group info" width="100%">
		
		<select name="cno">
			<c:forEach items="${allCampus}" var="c">
			<option <c:if test="${c.idno eq cno}">selected</c:if> value="${c.idno}">${c.name}</option>
			</c:forEach>
		</select>
		
		<select name="sno">
			<option value="">選擇學制</option>
			<c:forEach items="${allSchool}" var="c">
			<option <c:if test="${c.idno eq sno}">selected</c:if> value="${c.idno}">${c.name}</option>
			</c:forEach>
		</select>
		
		<select name="dno">
			<option value="">選擇科系</option>
			<c:forEach items="${allDept}" var="c">
			<option <c:if test="${c.idno eq dno}">selected</c:if> value="${c.idno}">${c.name}</option>
			</c:forEach>
		</select>
		
		<select name="gno">
			<option value="">選擇年級</option>
			<c:forEach var="g" begin="1" end="6">
			<option <c:if test="${gno eq g}">selected</c:if> value="${g}">${g}年級</option>
			</c:forEach>
		</select>
		
		<select name="zno">
			<option value="">選擇班級</option>
			<option <c:if test="${zno eq '1'}">selected</c:if> value="1">甲班</option>
			<option <c:if test="${zno eq '2'}">selected</c:if> value="2">乙班</option>
			<option <c:if test="${zno eq '3'}">selected</c:if> value="3">丙班</option>
		</select>
		</td>
	</tr>
	<tr>
		<td></td>
		<td>
		<div class="input-append control-group info">
		<select name="range">
			<option value="2">警戒範圍</option>
			<option value="2">2節</option>
			<option value="4">4節</option>
			<option value="6">6節</option>
		</select>
		<button class="btn btn-info" name="method:search" type="submit">依範圍查詢</button>
		</div>
		</td>
	</tr>
</table>
</c:if>
<c:if test="${empty myStds}">
<div class="alert alert-info">
	<button type="button" class="close" data-dismiss="alert">&times;</button>	
	班級範圍內無符合條件的同學，請改變警戒條件
</div>
</c:if>
<c:if test="${!empty myStds}">
<!-- Modal -->
<div id="stdInfo" class="modal hide fade" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal"
			aria-hidden="true">×</button>
		<h3 id="stdNameNo"></h3>
	</div>
	<div class="modal-body" id="info"></div>
	<div class="modal-footer">
		<button class="btn" data-dismiss="modal" aria-hidden="true">關閉</button>
	</div>
</div>
<display:table name="${myStds}" id="row" class="table" sort="list" excludedParams="*" >
  	<display:column title="班級" property="ClassName" sortable="true" />
  	<display:column title="學號" property="student_no" sortable="true"/>  	
  	<display:column title="姓名" property="student_name" sortable="true" />
  	<display:column>
  	<div class="btn-group">
		<a class="btn btn-mini dropdown-toggle" data-toggle="dropdown"
			href="#"><i class="icon-list" style="margin-top: 1px;"></i></a>
		<ul class="dropdown-menu">
    	<li><a href="#stdInfo" data-toggle="modal" onClick="getStudentTime('${row.student_no}', '${row.student_name}')">本學期課表</a></li>
    	<li><a href="#stdInfo" data-toggle="modal" onClick="getDilgInfo('${row.student_no}', '${row.student_name}', '')">程缺課記錄</a></li>
    	<li><a href="#stdInfo" data-toggle="modal" onClick="getStdContectInfo('${row.student_no}', '${row.student_name}')">連絡資訊</a></li>
    	<li><a href="#stdInfo" data-toggle="modal" onClick="getStdScoreInfo('${row.student_no}', '${row.student_name}')">歷年成績</a></li>
    	<li><a href="/CIS/Portfolio/ListMyStudents.do" target="_blank">學習歷程檔案</a></li>
    </ul>
	</div>
  	</display:column>
  	
  	
  	
  	<display:column title="課程" property="chi_name" sortable="true" />
  	<display:column title="時數" property="thour" sortable="true" />
  	<display:column title="上限" property="max" sortable="true" />
  	<display:column title="缺課" property="cnt" sortable="true" />
</display:table>
</c:if>
</form>
</body>
</html>
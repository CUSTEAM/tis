<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>重大集會日期設定</title>
<script src="/eis/inc/js/plugin/bootstrap-typeahead.js"></script>
<script src="/eis/inc/js/plugin/json2.js"></script>
<script src="/eis/inc/js/plugin/jquery-ui.js"></script>
<script src="/eis/inc/js/plugin/bootstrap-tooltip.js"></script>
<script src="/eis/inc/js/plugin/jquery-ui-timepicker-addon.js"></script>
<link href="/eis/inc/css/jquery-ui.css" rel="stylesheet"/>
<script>  
$(document).ready(function() {	
	
});
</script>  
</head>
<body> 
    
<div class="bs-callout bs-callout-info" id="callout-helper-pull-navbar">
<button type="button" class="close" data-dismiss="alert">&times;</button>
<strong>重大集會日期設定</strong>
</div>

<form action="DilgImpDateManager" method="post" class="form-inline">
<input type="hidden" name="Oid" value="${Oid}"/>
<div class="panel panel-primary">
  
	<div class="panel-heading">建立集會範圍</div>  	
	<table class="table">
		<tr>
			<td nowrap>
			<%@ include file="/inc/jsp-kit/classSelectorFull.jsp"%>
			</td>
			<td width="100%">			
			<div class="btn-group">
			<button name="method:addClass" class="btn btn-primary">增加班級</button>
			<a class="btn btn-default" href="DilgImpDateManager">返回</a>
			</div>
			</td>
			<td width="100%"></td>
		</tr>
	</table>
</div>
	
<c:if test="${!empty cls}">
<div class="panel panel-primary">
  
	<div class="panel-heading">建立集會範圍</div>  	
	<table class="table">
		<tr>
			<td nowrap>刪除</td>
			<td nowrap>班級名稱</td>
			<td nowrap>班級人數</td>
			<td>導師</td>
			<td>輸入時間</td>
		</tr>		
		
		<c:forEach items="${cls}" var="c">
		<tr>
			<td><input type="checkbox" value="${c.impOid}" name="impOid" /></td>
			<td nowrap>${c.ClassName}</td>
			<td nowrap>${c.cnt}</td>
			<td nowrap>${c.cname}</td>
			<td width="100%">${c.edit}</td>
		</tr>
		</c:forEach>
		<tr>
			<td colspan="4">
			<div class="btn-group" role="group" aria-label="...">
			<button class="btn btn-danger" name="method:delClass">刪除勾選班級</button>
			<a class="btn btn-default" href="DilgImpDateManager">返回</a>
			</div>
			</td>
		</tr>
	</table>
</div>


</c:if>


</form>

</body>
</html>
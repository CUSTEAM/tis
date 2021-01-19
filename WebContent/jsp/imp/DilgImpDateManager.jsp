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
<div class="panel panel-primary">
  
	<div class="panel-heading">建立新集會</div>
  	
	<table class="table">
		<tr>
			<td>			
			<div class="input-group">
			  <span class="input-group-addon">集會日期</span>
			  <input type="text" class="form-control" id="date" name="date">
			</div>
			</td>
		</tr>
		<tr>
			<td>
			<div class="input-group">
			  <span class="input-group-addon">開始時間</span>
			  <input type="text" class="form-control" id="begin" name="begin">
			</div>
			
			<div class="input-group">
			  <span class="input-group-addon">結束時間</span>
			  <input type="text" class="form-control" id="end" name="end">
			</div>
			
			</td>
		</tr>
		<tr>
			<td>
			<div class="input-group">
			  <span class="input-group-addon" >集會名稱</span>
			  <input type="text" class="form-control" name="name"  />
			</div>
			<div class="input-group">
			  <span class="input-group-addon">點名次數</span>
			  <select class="form-control" name="cls">
			  	<option value="1">1</option>
			  	<option value="2">2</option>
			  	<option value="3">3</option>
			  	<option value="4">4</option>
			  	<option value="5">5</option>
			  	<option value="6">6</option>
			  </select>
			</div>
			</td>
		</tr>
		
		<tr>
			<td>
			<button class="form-control btn btn-primary" name="method:create">建立集會</button>
			</td>
		</tr>
	</table>
	</div>
	
	
	<c:if test="${!empty alldate}">
	<div class="panel panel-primary">
  
	<div class="panel-heading">集會列表</div>
  	
	<table class="table">
		<thead>
		<tr>
			<th nowrap>集會名稱</th>
			<th nowrap>集會日期</th>
			<th nowrap>時間</th>
			<th nowrap>點名次數</th>
			<th nowrap>班級數</th>
			<th nowrap>建立者</th>
			<th nowrap>
			<input type="hidden" id="Oid" name="Oid"/>
			</th>
		</tr>
		</thead>
		<tbody>
		<c:forEach items="${alldate}" var="d">
		<tr>
			<td nowrap>${d.name}</td>
			<td nowrap>${d.date}</td>
			<td nowrap>${d.begin}~${d.end}</td>
			<td>${d.cls}</td>
			<td nowrap>${d.cnt}</td>
			<td nowrap>${d.cname}</td>
			<td width="100%">
			<div class="btn-group" role="group" aria-label="...">
			<button class="btn btn-default btn-sm" onClick="$('#Oid').val('${d.Oid}')" name="method:edit">設定班級範圍</button>
			<button class="btn btn-default btn-sm" onClick="$('#Oid').val('${d.Oid}')" name="method:printStat">列印點名狀況</button>
			<button class="btn btn-default btn-sm" onClick="$('#Oid').val('${d.Oid}')" name="method:printNote">列印獎懲建議名單</button>
			</div>
			<button class="btn btn-danger btn-sm" onClick="$('#Oid').val('${d.Oid}')" name="method:delete">刪除集會</button>
			</td>
		</tr>
		</c:forEach>
		</tbody>
	</table>
	</div>
	</c:if>
</form>
<script>
$("#date").datepicker({
	changeMonth: true,
	changeYear: true
});
$("#begin").timepicker();
$("#end").timepicker();
</script>
</body>
</html>
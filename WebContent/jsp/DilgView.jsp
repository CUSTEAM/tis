<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>班級曠缺紀錄</title>
<script>  
$(document).ready(function() {	
	$('.help').popover("show");
	setTimeout(function() {
		$('.help').popover("hide");
	}, 3000);	
	$("input[name='beginDate']").change(function(){
		$("#endDate").val($("#beginDate").val());
	});	
});
</script>
</head>
<body>
<form action="DilgView" method="post" class="form-inline">
<div class="bs-callout bs-callout-info" id="callout-helper-pull-navbar">
	<button type="button" class="close" data-dismiss="alert">&times;</button>
	<h3>學生缺曠記錄<small>查詢</small></h3>
	<div class="btn-group" role="group" aria-label="...">
	<button name="method:creatSearch" type="submit" class="btn btn-default">查看其他班級狀況</button>
	<c:if test="${empty myClass}">
	<a href="DilgView"class="btn btn-danger">返回班級列表</a>
	</c:if>
	<c:if test="${!empty myClass}">
	<a href="/eis/Calendar"class="btn btn-danger">返回</a>
	</c:if>	
	</div>
	<div rel="popover" title="說明" data-content="預設顯示導師班級,「個別缺曠資料」顯示每一位學生缺曠細節,查詢結果過多可利用每個欄位進行排序" data-placement="right" class="btn btn-warning help">?</div>
</div>
<table class="table">
	<tr>
		<td class="text-info" nowrap>查詢範圍</td>
		<td width="100%">
		<%@ include file="/inc/jsp-kit/classSelectorFull.jsp"%>
		
		</td>
	</tr>
	<tr>
		<td></td>
		<td>
		<input type="hidden" name="printType" id="printType"/>
		<button class="btn btn-danger" name="method:search" type="submit">依範圍查詢</button>
		<div class="btn-group">
		<button class="btn btn-default" name="method:print" type="submit">缺曠趨勢</button>
		<button class="btn btn-default" name="method:scorePrint" type="submit">成績趨勢</button>
		<button class="btn btn-default" name="method:nonexamPrint" type="submit">期中考無成績</button>
		<button class="btn btn-default" name="method:exScorePrint" onClick="$('#printType').val('score2');" type="submit">期中成績關係表</button>
		<button class="btn btn-default" name="method:exScorePrint" onClick="$('#printType').val('dtime');"type="submit">科目期中成績關係表</button>
		</div>
		</td>
	</tr>
</table>
<c:if test="${!empty myClass && param.ClassNo==null}">     

<div class="panel panel-primary">
  
	<div class="panel-heading">查詢結果</div>
  	<div class="panel-body">
    <p>可點選欄位名稱排序</p>
  </div>
	<display:table name="${myClass}" id="row" class="table" sort="list" requestURI="DilgView?method=search">
  	<display:column title="班級名稱" property="ClassName" sortable="true" />
  	<display:column title="學生人數" property="sts" sortable="true"/>  	
  	<display:column title="已審核假單" property="dis" sortable="true" />
  	<display:column title="未審核假單" property="undis" sortable="true" />
  	<display:column title="已請假節數" property="ds" sortable="true" />
  	<display:column title="未請假節數" property="uds" sortable="true" />
  	<display:column title="缺曠資料"><a href="DilgView?ClassNo=${row.ClassNo}">班級缺曠</a></display:column>
	</display:table>
</div>
</c:if>	
</form>
</body>
</html>
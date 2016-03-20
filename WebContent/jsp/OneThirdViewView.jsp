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
<form action="OneThirdView" method="post" class="form-inline">
<div class="bs-callout bs-callout-info" id="callout-helper-pull-navbar">	
	<strong>課程曠缺預警</strong>查詢, 	
	<c:if test="${!empty myStds}">
	<button name="method:creatSearch" type="submit" class="btn btn-default">改變查詢條件</button>
	<a href="OneThirdView"class="btn btn-danger">返回班級列表</a>	
	</c:if>
	預設顯示導師班級,「缺課⅓差距3節內」包含達到缺課⅓的同學	
</div>




<c:if test="${empty myStds}">
<div class="panel panel-primary">
	<div class="panel-heading">查詢範圍</div>
  	<table class="table">
		<tr>		
			<td><%@ include file="/inc/jsp-kit/classSelectorFull.jsp"%></td>
		</tr>
		<tr>
			<td>
			<select name="range" class="form-control">
				<option value="2">警戒範圍</option>
				<option value="2">單一科目差2節達⅓缺課</option>
				<option value="4">單一科目差4節達⅓缺課</option>
				<option value="6">單一科目差6節達⅓缺課</option>
			</select>
			<button class="btn btn-danger" name="method:search" type="submit">依範圍查詢</button>
			
			</td>
		</tr>
	</table>
</div>
</c:if>
<c:if test="${empty myStds}">
<div class="alert alert-info">
	<button type="button" class="close" data-dismiss="alert">&times;</button>	
	班級範圍內無符合條件的同學，請改變警戒條件
</div>
</c:if>
<c:if test="${!empty myStds}">
<!-- Modal -->
<div class="modal fade" id="stdInfo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"
			aria-hidden="true">×</button>
		<h3 id="stdNameNo"></h3>
      </div>
      <div class="modal-body" id="info"></div>
	<div class="modal-footer">
		<button class="btn btn-primary" data-dismiss="modal" aria-hidden="true">關閉</button>
	</div>
    </div>
  </div>
</div>
<div class="panel panel-primary">
	<div class="panel-heading">查詢結果</div>  	
	<display:table name="${myStds}" id="row" class="table" sort="list" requestURI="OneThirdView?method=search">
	  	<display:column title="班級" property="ClassName" sortable="true" />
	  	<display:column title="學號" property="student_no" sortable="true"/>  	
	  	<display:column title="姓名" property="student_name" sortable="true" />
	  	<display:column title="學生資料">  	
	  	<div class="btn-group">
	    <a class="btn btn-mini dropdown-toggle" data-toggle="dropdown" href="#"><i class="icon-list" style="margin-top:1px;"></i></a>
	    
	    <div class="btn-group btn-default">
			<button type="button" class="btn btn-default btn-xs dropdown-toggle" data-toggle="dropdown" aria-haspopup="true"><i class="glyphicon glyphicon-align-justify" style="margin-top: 1px;"></i></button>
			<ul class="dropdown-menu">
				<li><a href="#stdInfo" data-toggle="modal" onClick="getStudentTime('${row.student_no}', '${row.student_name}')">本學期課表</a></li>
				<li><a href="#stdInfo" data-toggle="modal" onClick="getDilgInfo('${row.student_no}', '${row.student_name}', '${Oid}')">本課程缺課記錄</a></li>
				<li><a href="#stdInfo" data-toggle="modal" onClick="getDilgInfo('${row.student_no}', '${row.student_name}', '')">所有課程缺課記錄</a></li>
				<li><a href="#stdInfo" data-toggle="modal" onClick="getStdContectInfo('${row.student_no}', '${row.student_name}')">連絡資訊</a></li>
				<li><a href="#stdInfo" data-toggle="modal" onClick="getStdScoreInfo('${row.student_no}', '${row.student_name}')">歷年成績</a></li>
				<li><a href="/CIS/Portfolio/ListMyStudents.do" target="_blank">學習歷程檔案</a></li>									
			</ul>
		</div>    
	    </div>
	  	</display:column>
	  	
	  	
	  	
	  	<display:column title="課程" property="chi_name" sortable="true" />
	  	<display:column title="時數" property="thour" sortable="true" />
	  	<display:column title="上限" property="max" sortable="true" />
	  	<display:column title="缺課" property="cnt" sortable="true" />
	</display:table>
</div>
</c:if>
</form>
</body>
</html>
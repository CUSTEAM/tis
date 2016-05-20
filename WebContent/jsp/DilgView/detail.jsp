<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="/eis/inc/js/develop/stdinfo.js"></script>
<script src="/eis/inc/js/develop/timeInfo.js"></script>
<script src="/eis/inc/js/plugin/jquery.tinyMap.min.js"></script>
<script>  
$(document).ready(function() {
	
	$('#funbtn').popover("show");
	setTimeout(function() {
		$('#funbtn').popover("hide");
	}, 3000);
	
	$("input[name='beginDate']").change(function(){
		//alert($("#beginDate").val());
		$("#endDate").val($("#beginDate").val());
	});	
});
</script>
</head>
<body>

     
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
      <center><div class="modal-body" style="width:80%; height:400px;" id="stdMap"></div></center>
	<div class="modal-footer">
		<button class="btn btn-primary" data-dismiss="modal" aria-hidden="true">關閉</button>
	</div>
    </div>
  </div>
</div>

<form action="DilgView" method="post">
<div class="bs-callout bs-callout-info" id="callout-helper-pull-navbar">
	<h3>學生缺曠記錄</h3>
	<p><button type="button" class="close" data-dismiss="alert">&times;</button>
	
	<div class="btn-group" role="group" aria-label="...">
	<button name="method:creatSearch" type="submit" class="btn btn-default">查看其他班級狀況</button>
	<a href="DilgView"class="btn btn-danger">返回班級列表</a>
		
	</div>
	<div id="funbtn" rel="popover" title="說明" data-content="每個欄位均可排序" data-placement="right" class="btn btn-info">?</div>
</div>
<div class="panel panel-primary">
  <!-- Default panel contents -->
  <div class="panel-heading">${myStudents[0].depart_class}</div>
  
    <display:table name="${myStudents}" id="row" class="table table-condensed" sort="list" excludedParams="*" requestURI="DilgView?ClassNo=${myStudents[0].depart_class}">
  	<display:column title="學號" property="student_no" sortable="true" />
  	<display:column title="姓名" property="student_name" sortable="true"/> 
  	<display:column title="">
    <div class="btn-group btn-default">
		<button type="button" class="btn btn-default btn-xs dropdown-toggle" data-toggle="dropdown" aria-haspopup="true"><i class="glyphicon glyphicon-align-justify" style="margin-top: 1px;"></i> 學生資訊</button>
		<ul class="dropdown-menu">
			<li><a href="#stdInfo" data-toggle="modal" onClick="getStudentTime('${row.student_no}', '${row.student_name}')">本學期課表</a></li>
			<li><a href="#stdInfo" data-toggle="modal" onClick="getDilgInfo('${row.student_no}', '${row.student_name}', '${Oid}')">本課程缺課記錄</a></li>
			<li><a href="#stdInfo" data-toggle="modal" onClick="getDilgInfo('${row.student_no}', '${row.student_name}', '')">所有課程缺課記錄</a></li>
			<li><a href="#stdInfo" data-toggle="modal" onClick="getStdContectInfo('${row.student_no}', '${row.student_name}')">連絡資訊</a></li>
			<li><a href="#stdInfo" data-toggle="modal" onClick="getStdScoreInfo('${row.student_no}', '${row.student_name}')">歷年成績</a></li>
			<li><a href="/CIS/Portfolio/ListMyStudents.do" target="_blank">學習歷程檔案</a></li>									
		</ul>
	</div>
  	</display:column> 	  	
  	<display:column title="遲到" property="abs5" sortable="true" />  	
  	<display:column title="曠課" property="abs2" sortable="true" />
  	<display:column title="病假" property="abs3" sortable="true" />
  	<display:column title="事假" property="abs4" sortable="true" />
  	<display:column title="公假" property="abs6" sortable="true" />
  	<display:column title="喪假" property="abs7" sortable="true" />
  	<display:column title="婚假" property="abs8" sortable="true" />
  	<display:column title="產假" property="abs9" sortable="true" />
  	<display:column title="住院" property="abs1" sortable="true" />
  	<display:column title="總計" property="total" sortable="true" />
  	
</display:table>
</div>
</form>
</body>
</html>
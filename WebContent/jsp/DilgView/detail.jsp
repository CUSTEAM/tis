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
<div id="stdInfo" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
<div class="modal-header">
<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
<h3 id="stdNameNo"></h3>
</div>
<div class="modal-body" id="info">
</div>
<div class="modal-footer">
<button class="btn" data-dismiss="modal" aria-hidden="true">關閉</button>
</div>
</div>

<form action="DilgView" method="post">
<div class="alert">
	<button type="button" class="close" data-dismiss="alert">&times;</button>	
	<strong>學生缺曠記錄</strong>列表, 
	<button name="method:creatSearch" type="submit" class="btn">查看其他班級狀況</button>
	<a href="DilgView"class="btn btn-danger">返回班級列表</a>
	<div id="funbtn" rel="popover" title="說明" data-content="每個欄位均可排序" data-placement="right" class="btn btn-info">?</div>	
</div>     
    <display:table name="${myStudents}" id="row" class="table table-condensed" sort="list" excludedParams="*" >
  	<display:column title="學號" property="student_no" sortable="true" />
  	<display:column title="姓名" property="student_name" sortable="true"/> 
  	<display:column title="">  	
  	<div class="btn-group">
    <a class="btn btn-mini dropdown-toggle" data-toggle="dropdown" href="#"><i class="icon-list" style="margin-top:1px;"></i></a>
    <ul class="dropdown-menu">
    	<li><a href="#stdInfo" data-toggle="modal" onClick="getStudentTime('${row.student_no}', '${row.student_name}')">本學期課表</a></li>
    	<li><a href="#stdInfo" data-toggle="modal" onClick="getDilgInfo('${row.student_no}', '${row.student_name}', '')">課程缺課記錄</a></li>
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
	
</form>
</body>
</html>
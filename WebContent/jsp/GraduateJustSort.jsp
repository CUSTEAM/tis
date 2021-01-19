<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>學生畢業資格管理</title>
<script src="/eis/inc/js/develop/stdinfo.js"></script>
<script src="/eis/inc/js/develop/timeInfo.js"></script>
<script src="/eis/inc/js/plugin/jquery.tinyMap.min.js"></script>
<style>

.material-switch > input[type="checkbox"] {
    display: none;   
}

.material-switch > label {
    cursor: pointer;
    height: 0px;
    position: relative; 
    width: 40px;  
}

.material-switch > label::before {
    background: rgb(0, 0, 0);
    box-shadow: inset 0px 0px 10px rgba(0, 0, 0, 0.5);
    border-radius: 8px;
    content: '';
    height: 16px;
    margin-top: -8px;
    position:absolute;
    opacity: 0.3;
    transition: all 0.4s ease-in-out;
    width: 40px;
}
.material-switch > label::after {
    background: rgb(255, 255, 255);
    border-radius: 16px;
    box-shadow: 0px 0px 5px rgba(0, 0, 0, 0.3);
    content: '';
    height: 24px;
    left: -4px;
    margin-top: -8px;
    position: absolute;
    top: -4px;
    transition: all 0.3s ease-in-out;
    width: 24px;
}
.material-switch > input[type="checkbox"]:checked + label::before {
    background: inherit;
    opacity: 0.5;
}
.material-switch > input[type="checkbox"]:checked + label::after {
    background: inherit;
    left: 20px;
}
</style>
<script>  
$(document).ready(function() {	
	
	$("input[name='beginDate']").change(function(){
		$("#endDate").val($("#beginDate").val());
	});	
	
	$("#opRes").click(function(){		
		if($("#opRes").prop("checked")){
			$(".filter").show("slow");
		}else{
			$(".filter").hide("slow");
		}
	});
	
	$(".filter").hide("slow");
});
</script>
</head>
<body>
<form action="GraduateJustSort" method="post" class="form-inline">
<div class="bs-callout bs-callout-info" id="callout-helper-pull-navbar">
	<button type="button" class="close" data-dismiss="alert">&times;</button>
	<h4>畢業資格管理</h4>
	<p>點選 <button class="btn btn-danger btn-xs" name="method:search" type="submit">依範圍查詢</button> 顯示未設定助理的科系或臨時職務代理的科系</p>
	
	<c:if test="${!empty myClass}">
	<a href="DilgView"class="btn btn-danger">返回班級列表</a>
	</c:if>
	
	</div>
	


<div class="panel panel-primary">
	<div class="panel-heading">查詢範圍</div>	  	
		<table class="table">
			<tr>
				
				<td width="100%">
				<%@ include file="/inc/jsp-kit/classSelectorFull.jsp"%>
				<button name="method:creatSearch" type="submit" class="btn btn-danger">依範圍查詢</button>
				</td>
			</tr>
			
		</table>
</div>
<input type="hidden" id="clsNo" name="clsNo" value="${clsNo}"/>
<c:if test="${!empty cls}">     

<div class="panel panel-primary">
  
	<div class="panel-heading">查詢結果</div>
  	
	<display:table name="${cls}" id="row" class="table" sort="list" requestURI="DilgView?method=search">
  	<display:column title="學制" property="csName" sortable="false" />
  	<display:column title="系所" property="cdName" sortable="false"/>  	
  	<display:column title="班級名稱" property="ClassName" sortable="false" />
  	<display:column title="班級人數" property="stds" sortable="false" />
  	<display:column title="證照">${row.certificate}</display:column>
  	<display:column title="實習">${row.practice}</display:column>
  	<display:column title="語言">${row.language}</display:column>
  	<display:column title="畢業">${row.pass}</display:column>
  	<display:column title="">
  	<button class="btn btn-primary" type="submit" name="method:edit" onMouseOver="$('#clsNo').val('${row.ClassNo}')">建立資格</button>
  	<button name="method:print" type="submit" class="btn btn-default" onMouseOver="$('#clsNo').val('${row.ClassNo}')">列印</button>
  	</display:column>
	</display:table>
</div>
</c:if>	

<c:set var="now" value="<%=new java.util.Date()%>" />
<fmt:parseDate value="${GradCheckD}" var="date" pattern="yyyy-MM-dd HH:mm"/>

<c:set var="over"><fmt:formatDate value="${date}" pattern="yyyy-MM-dd HH:mm" /></c:set>
<c:if test="${now<=over}">                    
<div class="bs-callout bs-callout-danger" id="callout-helper-pull-navbar">
    <h4>畢業資格審查結束日期:${GradCheckD}</h4>
</div>
</c:if>

<c:if test="${!empty stds}">     
<div class="panel panel-primary">
  
	<div class="panel-heading">查詢結果</div>
  	
	<display:table name="${stds}" id="row" class="table" sort="list" requestURI="DilgView?method=search">
  	<display:column title="學號" property="stdNo" sortable="false" />
  	<display:column title="姓名" property="student_name" sortable="false"/>  	
  	<display:column title="基本資料">
 			<div class="btn-group btn-default">
				<button type="button" class="btn btn-default btn-xs dropdown-toggle" data-toggle="dropdown" aria-haspopup="true"><i class="glyphicon glyphicon-align-justify" style="margin-top: 1px;"></i> 查看基本資料</button>
				<ul class="dropdown-menu">
					<li><a href="#stdInfo" data-toggle="modal" onClick="getStudentTime('${row.stdNo}', '${row.student_name}')">本學期課表</a></li>
					<li><a href="#stdInfo" data-toggle="modal" onClick="getDilgInfo('${row.stdNo}', '${row.student_name}', '')">所有課程缺課記錄</a></li>
					<li><a href="#stdInfo" data-toggle="modal" onClick="getStdContectInfo('${row.stdNo}', '${row.student_name}')">連絡資訊</a></li>
					<li><a href="#stdInfo" data-toggle="modal" onClick="getStdScoreInfo('${row.stdNo}', '${row.student_name}')">歷年成績</a></li>
					<li><a href="/CIS/Portfolio/ListMyStudents.do" target="_blank">學習歷程檔案</a></li>									
				</ul>
			</div>
  	</display:column>
  	<display:column title="證照">	  	
	  	<select class="form-control" name="certificate" onChange="$('#check${row.stdNo}').val('Y')">
	  		<option value="N"></option>
	  		<option <c:if test="${row.certificate eq'Y'}">selected</c:if> value="Y">已審核</option>
	  	</select>
  	</display:column>
  	<display:column title="實習">
  		<input type="hidden" name="check" id="check${row.stdNo}" />
	  	<input type="hidden" name="stdNo" id="stdNo" value="${row.stdNo}" />
	  	<select class="form-control" name="practice" onChange="$('#check${row.stdNo}').val('Y')">
	  		<option value="N"></option>
	  		<option <c:if test="${row.practice eq'Y'}">selected</c:if> value="Y">已審核</option>
	  	</select>
  	</display:column>
  	<display:column title="語言">
  		<select disabled class="form-control">
	  		<option value="N"></option>
	  		<option <c:if test="${row.language eq'Y'}">selected</c:if> value="Y">已審核</option>
	  	</select>
  	</display:column>
  	<display:column title="畢業審核">
  		<select disabled class="form-control">
	  		<option value="N"></option>
	  		<option <c:if test="${row.pass eq'Y'}">selected</c:if> value="Y">已審核</option>
	  	</select>
  	</display:column>  	
  	<display:column title="建立者">
  	${row.editor}, ${row.editime}
  	</display:column>
  	<display:column title=""><button name="method:save" <c:if test="${now<=over}">disabled</c:if> type="submit" class="btn btn-primary">個別儲存</button></display:column>
	</display:table>
	<div class="panel-body">
    <p>
	    <button <c:if test="${now<=over}">disabled</c:if> name="method:save" type="submit" class="btn btn-danger">全部儲存</button> 
	    <button name="method:print" type="submit" class="btn btn-default">列印</button> 
	    <a href="GraduateJustSort" class="btn btn-default">離開</a>
    </p>
  </div>
</div>
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
</c:if>	

</form>
</body>
</html>
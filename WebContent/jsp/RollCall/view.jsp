<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${info.date} 星期${info.week},${info.ClassName} - ${info.chi_name}出席記錄</title>
<script src="/eis/inc/js/develop/stdinfo.js"></script>
<script src="/eis/inc/js/develop/timeInfo.js"></script>
<script src="/eis/inc/js/plugin/jquery.tinyMap.min.js"></script>
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

<div class="bs-callout bs-callout-info" id="callout-helper-pull-navbar">
	<h4>點名記錄</h4>
	<p><button type="button" class="close" data-dismiss="alert">&times;</button>
	<font size="+1">您正在檢視<b> ${info.date} 星期${info.week}, ${info.ClassName} - ${info.chi_name}</b>出席記錄</font> 
	<a href="RollCall" class="btn btn-default">返回</a></p>		
</div>

<c:if test="${empty students}">
<div class="alert alert-danger">
	<button type="button" class="close" data-dismiss="alert">&times;</button>
	無選課學生或<strong>未填報分組名單</strong>
</div>
</c:if>
<c:if test="${!empty students}">
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
<form class="form-inline">

<div class="row">
	<div class="col-xs-12 col-md-6">
	  	<div class="panel panel-primary">  
	  	<div class="panel-heading">學號排序前<fmt:formatNumber value="${(fn:length(students)/2)+1}" maxFractionDigits="0" />名</div>
		
			
		<table class="table table-condensed table-bordered table-hover table-striped">
			<tr>
				<td>學號</td>
				<td>姓名</td>
				<td nowrap>缺課</td>
				<c:forEach items="${dclass}" varStatus="loop">
				<td>第${dclass[loop.index]}節</td>
				</c:forEach>
			</tr>
			<c:forEach items="${students}" var="s" begin="0" end="${fn:length(students)/2}">
			<tr>
				<td nowrap>${s.student_no}</td>
				<td nowrap>${s.student_name}
				<div class="btn-group btn-default">
					<button type="button" class="btn btn-default btn-xs dropdown-toggle" data-toggle="dropdown" aria-haspopup="true"><i class="glyphicon glyphicon-align-justify" style="margin-top: 1px;"></i></button>
					<ul class="dropdown-menu">
						<li><a href="#stdInfo" data-toggle="modal" onClick="getStudentTime('${s.student_no}', '${s.student_name}')">本學期課表</a></li>
						<li><a href="#stdInfo" data-toggle="modal" onClick="getDilgInfo('${s.student_no}', '${s.student_name}', '${Oid}')">本課程缺課記錄</a></li>
						<li><a href="#stdInfo" data-toggle="modal" onClick="getDilgInfo('${s.student_no}', '${s.student_name}', '')">所有課程缺課記錄</a></li>
						<li><a href="#stdInfo" data-toggle="modal" onClick="getStdContectInfo('${s.student_no}', '${s.student_name}')">連絡資訊</a></li>
						<li><a href="#stdInfo" data-toggle="modal" onClick="getStdScoreInfo('${s.student_no}', '${s.student_name}')">歷年成績</a></li>
						<li><a href="/CIS/Portfolio/ListMyStudents.do" target="_blank">學習歷程檔案</a></li>									
					</ul>
				</div>
				</td>
				<td nowrap><div rel="popover" title="已儲存" data-placement="bottom" id="${s.student_no}">${s.dilg_period}</div></td>
				
				<c:forEach items="${s.dilgs}" var="d">
				<td id="c${s.student_no}${d.cls}"
				<c:if test="${d.abs eq ''||d.abs eq'6'||d.abs eq'7'}">class="control-group has-success"</c:if>
				<c:if test="${d.abs eq '1'||d.abs eq '2'||d.abs eq'3'||d.abs eq'4'||d.abs eq'8'||d.abs eq'9'}">class="control-group danger"</c:if>
				<c:if test="${d.abs eq '5'}">class="control-group warning"</c:if> 
				nowrap>
				
				
				<c:if test="${d.abs!='5'&&d.abs!='2'&&d.abs!=''}">
				<select disabled onChange="editDilg('${s.student_no}', ${d.cls}, this.value);" class="form-control" style="width:auto;">
					<option value="">到課</option>
					<c:if test="${d.abs eq '1'}"><option selected value="1">住院</option></c:if>
					<c:if test="${d.abs eq '3'}"><option selected value="3">病假</option></c:if>
					<c:if test="${d.abs eq '4'}"><option selected value="4">事假</option></c:if>
					<c:if test="${d.abs eq '6'}"><option selected value="6">公假</option></c:if>
					<c:if test="${d.abs eq '7'}"><option selected value="7">喪假</option></c:if>
					<c:if test="${d.abs eq '8'}"><option selected value="8">婚假</option></c:if>
					<c:if test="${d.abs eq '9'}"><option selected value="9">產假</option></c:if>
					<c:if test="${d.abs eq '0'}"><option selected value="9">生理</option></c:if>
				</select>
				</c:if> 
				
				<c:if test="${d.abs=='5'||d.abs=='2'||d.abs==''}">				
				<select disabled onChange="editDilg('${s.student_no}', ${d.cls}, this.value);" class="form-control" style="width:auto;">
					<option value=""></option>
					<option <c:if test="${d.abs=='2'}">selected="selected"</c:if>value="2">未到</option>
					<option <c:if test="${d.abs=='5'}">selected="selected"</c:if>value="5">遲到</option>
				</select>
				</c:if>
				<c:if test="${!empty d.earlier}">
				<span class="label label-success">預</span>
				</c:if>				
				</td>
				
				</c:forEach>
			</tr>
			</c:forEach>
		</table>
		</div>
  
  
  	</div>
  	
  	
  	<div class="col-xs-12 col-md-6">
	  	<div class="panel panel-primary">  
	  	<div class="panel-heading">學號排序<fmt:formatNumber value="${(fn:length(students)/2)+2}" maxFractionDigits="0" />至<fmt:formatNumber value="${fn:length(students)}" maxFractionDigits="0" />名</div>
		
			
		<table class="table table-condensed table-bordered table-hover table-striped">
			<tr>
				<td>學號</td>
				<td>姓名</td>
				<td nowrap>缺課</td>
				<c:forEach items="${dclass}" varStatus="loop">
				<td>第${dclass[loop.index]}節</td>
				</c:forEach>
			</tr>
			<c:forEach items="${students}" var="s" begin="${(fn:length(students)/2)+1}" end="${fn:length(students)}">
			<tr>
				<td nowrap>${s.student_no}</td>
				<td nowrap>${s.student_name}
				<div class="btn-group btn-default">
					<button type="button" class="btn btn-default btn-xs dropdown-toggle" data-toggle="dropdown" aria-haspopup="true"><i class="glyphicon glyphicon-align-justify" style="margin-top: 1px;"></i></button>
					<ul class="dropdown-menu">
						<li><a href="#stdInfo" data-toggle="modal" onClick="getStudentTime('${s.student_no}', '${s.student_name}')">本學期課表</a></li>
						<li><a href="#stdInfo" data-toggle="modal" onClick="getDilgInfo('${s.student_no}', '${s.student_name}', '${Oid}')">本課程缺課記錄</a></li>
						<li><a href="#stdInfo" data-toggle="modal" onClick="getDilgInfo('${s.student_no}', '${s.student_name}', '')">所有課程缺課記錄</a></li>
						<li><a href="#stdInfo" data-toggle="modal" onClick="getStdContectInfo('${s.student_no}', '${s.student_name}')">連絡資訊</a></li>
						<li><a href="#stdInfo" data-toggle="modal" onClick="getStdScoreInfo('${s.student_no}', '${s.student_name}')">歷年成績</a></li>
						<li><a href="/CIS/Portfolio/ListMyStudents.do" target="_blank">學習歷程檔案</a></li>									
					</ul>
				</div>
				</td>
				<td nowrap><div rel="popover" title="已儲存" data-placement="bottom" id="${s.student_no}">${s.dilg_period}</div></td>
				
				<c:forEach items="${s.dilgs}" var="d">
				<td id="c${s.student_no}${d.cls}"
				<c:if test="${d.abs eq ''||d.abs eq'6'||d.abs eq'7'}">class="control-group has-success"</c:if>
				<c:if test="${d.abs eq '1'||d.abs eq '2'||d.abs eq'3'||d.abs eq'4'||d.abs eq'8'||d.abs eq'9'}">class="control-group danger"</c:if>
				<c:if test="${d.abs eq '5'}">class="control-group warning"</c:if> 
				nowrap>
				
				
				<c:if test="${d.abs!='5'&&d.abs!='2'&&d.abs!=''}">
				<select disabled onChange="editDilg('${s.student_no}', ${d.cls}, this.value);" class="form-control" style="width:auto;">
					<option value="">到課</option>
					<c:if test="${d.abs eq '1'}"><option selected value="1">住院</option></c:if>
					<c:if test="${d.abs eq '3'}"><option selected value="3">病假</option></c:if>
					<c:if test="${d.abs eq '4'}"><option selected value="4">事假</option></c:if>
					<c:if test="${d.abs eq '6'}"><option selected value="6">公假</option></c:if>
					<c:if test="${d.abs eq '7'}"><option selected value="7">喪假</option></c:if>
					<c:if test="${d.abs eq '8'}"><option selected value="8">婚假</option></c:if>
					<c:if test="${d.abs eq '9'}"><option selected value="9">產假</option></c:if>
					<c:if test="${d.abs eq '0'}"><option selected value="9">生理</option></c:if>
				</select>
				</c:if> 
				
				<c:if test="${d.abs=='5'||d.abs=='2'||d.abs==''}">				
				<select disabled onChange="editDilg('${s.student_no}', ${d.cls}, this.value);" class="form-control" style="width:auto;">
					<option value=""></option>
					<option <c:if test="${d.abs=='2'}">selected="selected"</c:if>value="2">未到</option>
					<option <c:if test="${d.abs=='5'}">selected="selected"</c:if>value="5">遲到</option>
				</select>
				</c:if>
				<c:if test="${!empty d.earlier}">
				<span class="label label-success">預</span>
				</c:if>
				</td>				
				</c:forEach>
			</tr>
			</c:forEach>
		</table>
		</div>
  
  
  	</div>
</div>






		




</div>
</form>
</c:if>
    
    
	    
   		
	    	
	    	


</body>

</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${info.date} 星期${info.week}, ${info.ClassName} - ${info.chi_name}</title>
<script src="/eis/inc/js/develop/stdinfo.js"></script>
<script src="/eis/inc/js/develop/timeInfo.js"></script>
<script>
$(document).ready(function() {	
	$('.elary').popover("show");
	setTimeout(function() {		
		$('.elary').popover("hide");
	}, 0);
});
</script>
</head>
<body>
<div class="bs-callout bs-callout-warning">
	<button type="button" class="close" data-dismiss="alert">&times;</button>
	${info.date}${info.name}${info.ClassName} 出席記錄
	<a href="RollCall" class="btn btn-default">返回</a>
	<a id="funbtn" rel="popover" title="說明"
	data-content="1.將選項恢復空白即取消已記缺曠 , 2.預先請假卻到課請恢復空白銷假, 3.按下「返回」按鈕即可離開編輯, 4.僅統計扣考規定的假別"
	data-placement="right" class="elary btn btn-warning">?</a>
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
				<td nowrap></td>				
			</tr>
			<c:forEach items="${students}" var="s" begin="0" end="${fn:length(students)/2}">
			<tr>
				<td nowrap style="padding:10px 15px 0px 15px;">${s.student_no}</td>
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
				<td width="100%">
				
				<div class="input-group">
				
      			<div class="input-group-addon" rel="popover" title="已儲存" data-placement="bottom" id="${s.student_no}">點名未到次數</div>
				
				<select name="cls" class="form-control" onChange="editDilg('${s.student_no}', this.value)">
					<option></option>
					<c:forEach begin="1" end="${info.cls}" varStatus="i">
					<option <c:if test="${s.cls eq i.index}">selected</c:if> value="${i.index}">${i.index}</option>
					</c:forEach>
				</select>
				</div>
				</td>
				
				
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
				<td nowrap></td>				
			</tr>
			<c:forEach items="${students}" var="s" begin="${(fn:length(students)/2)+1}" end="${fn:length(students)}">
			<tr>
				<td nowrap style="padding:10px 15px 0px 15px;">${s.student_no}</td>
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
				<td width="100%">
				
				<div class="input-group">
				
      			<div class="input-group-addon" rel="popover" title="已儲存" data-placement="bottom" id="${s.student_no}">點名未到次數</div>
				
				<select name="cls" class="form-control" onChange="editDilg('${s.student_no}', this.value)">
					<option></option>
					<c:forEach begin="1" end="${info.cls}" varStatus="i">
					<option <c:if test="${s.cls eq i.index}">selected</c:if> value="${i.index}">${i.index}</option>
					</c:forEach>
				</select>
				</div>
				</td>
				
				
			</tr>
			</c:forEach>
		</table>
		
		</div>
  
  
  	</div>
</div>






		




</div>
</form>
<script>
function editDilg(no, cls){
	//if(abs=='')$("#c"+no+cls).attr("class", "control-group success");
	//if(abs!='' && abs!='5' && abs!='6' && abs!='7')$("#c"+no+cls).attr("class", "control-group danger");
	//if(abs=='5')$("#c"+no+cls).attr("class", "control-group warning");	
	//var date="${info.date}";	
	//$.blockUI({message:"儲存中", css:{padding:"20px"}});	
	$.get("/eis/editImpDilg", {radom:Math.round(Math.random()*10),no:no, cls:cls, Oid:${info.Oid}},
		function(data){
			//callback
			//$.unblockUI();
			//$("#"+no).html(data.total);
			$('#'+no).tooltip("show");			
			setTimeout(function() {
				$('#'+no).tooltip("hide");
			}, 1000);
	});	
	
	
}
</script>
</c:if>

</body>

</html>
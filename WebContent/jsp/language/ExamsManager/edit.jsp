<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">


<title>Insert title here</title>
<script src="/eis/inc/js/plugin/bootstrap-typeahead.js"></script>
<script src="/eis/inc/js/plugin/bootstrap-fileupload.js"></script>
<script src="/eis/inc/js/plugin/json2.js"></script>
<script src="/eis/inc/js/plugin/jquery-ui.js"></script>
<script src="/eis/inc/js/plugin/jquery-ui-timepicker-addon.js"></script>
<link href="/eis/inc/css/jquery-ui.css" rel="stylesheet"/>
<link href="/eis/inc/css/wizard-step.css" rel="stylesheet"/>
<link href="/eis/inc/css/bootstrap-fileupload.css" rel="stylesheet">
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
<div class="alert">
    <button type="button" class="close" data-dismiss="alert">&times;</button>
    <strong>考試管理</strong> 請依欄位輸入資料建立考試
    <a href="/eis/Calendar"class="btn">返回</a>
    <div id="funbtn" rel="popover" title="說明" 
    data-content="點選「建立公假」後，畫面上輸入的資料仍保留，輸入完成後轉呈導師→學務單位→學務單位主管,過程顯示於下方列表" 
    data-placement="right" class="btn btn-warning">?</div>
    </div>

<form action="ExamsManager" method="post" class="form-horizontal">
<input type="hidden" name="Oid" value="${exam.Oid}">
<div class="wizard-steps">
  	<div><a href="#"><span>1</span> 建立考試</a></div>
  	<div><a href="#"><span>2</span> 修正考試</a></div>
  	<div><a href="#"><span>3</span> 列印考試資料</a></div>
</div>

    



<div class="panel panel-primary">
	<div class="panel-heading">建立活動</div>
	<ul class="list-group">
	  <li class="list-group-item"><span class="label label-as-badge label-warning">1</span> 同梯次同場次不可重複報名。</li>
	  <li class="list-group-item"><span class="label label-as-badge label-danger">2</span> 請慎選梯次、場次和時間，以防止重複報名。</li>
	  
	</ul>
	
<table class="table">
	<tr>
		<td>
			<div class="input-group">
			  <span class="input-group-addon">梯次</span>
			  <input class="form-control" id="level" placeholder="梯次" name="level" value="${exam.level}" type="text" style="ime-mode:disabled" onkeyup="return ValidateNumber($(this),value)"/>
			</div>	
		</td>
	</tr>
	<tr>
		<td>
			<div class="input-group">
				<span class="input-group-addon">場次</span>
				<input class="form-control" id="no" placeholder="場次" name="no" value="${exam.no}" type="text" style="ime-mode:disabled" onkeyup="return ValidateNumber($(this),value)"/>
			</div>
		</td>
	</tr>
	<tr>
		<td>	
			<div class="input-group">
				<span class="input-group-addon">說明</span>
				<input class="form-control" id="note" placeholder="說明" name="note" value="${exam.note}" type="text" style="ime-mode:disabled"/>
			</div>
		</td>
	</tr>
		
	<tr>
		<td>			
			<div class="input-group">
			<span class="input-group-addon">報名開始</span>
			<input class="form-control pick" type="text" id="sign_begin" placeholder="報名開始時間" name="sign_begin" value="${exam.sign_begin}"/>
			</div>
		</td>
	</tr>
	<tr>
		<td>	
			<div class="input-group">
			<span class="input-group-addon">報名截止</span>
			<input class="form-control pick" id="sign_end" placeholder="報名截止時間" name="sign_end" type="text" value="${exam.sign_end}"/>
			</div>
			
		</td>		
	</tr>
	<tr>
		<td>
			<div class="input-group">
			<span class="input-group-addon">活動開始</span>
			<input class="form-control pick" type="text" id="exam_begin" placeholder="考試開始時間" name="exam_begin" value="${exam.exam_begin}"/>
			</div>
		</td>
	</tr>
	<tr>
		<td>	
			<div class="input-group">
			<span class="input-group-addon">活動結束</span>
			<input class="form-control pick" id="exam_end" placeholder="考試結束時間" name="exam_end" type="text" value="${exam.exam_end}"/>
			</div>			
		</td>		
	</tr>
	<tr>
		<td>		
			<div class="input-group">
			<span class="input-group-addon">1年級</span>
			<input class="form-control" name="grad1" id="grad1" value="${exam.grad1}" type="text" placeholder="0" onkeyup="return ValidateNumber($(this),value)"/>
			</div>
		</td>
	</tr>
	<tr>
		<td>
			<div class="input-group">
			<span class="input-group-addon">2年級</span>
			<input class="form-control" name="grad2" id="grad2" value="${exam.grad2}" type="text" placeholder="0" onkeyup="return ValidateNumber($(this),value)"/>
			</div>
		</td>
	</tr>
	<tr>
		<td>
			<div class="input-group">
			<span class="input-group-addon">3年級</span>
			<input class="form-control" name="grad3" id="grad3" value="${exam.grad3}" type="text" placeholder="0" onkeyup="return ValidateNumber($(this),value)"/>
			</div>
		</td>
	</tr>
	<tr>
		<td>
			<div class="input-group">
			<span class="input-group-addon">4年級</span>
			<input class="form-control" name="grad4" id="grad4" value="${exam.grad4}" type="text" placeholder="0" onkeyup="return ValidateNumber($(this),value)"/>
			</div>
		</td>
	</tr>
	<tr>
		<td>
			<div class="input-group">
			<span class="input-group-addon">教職員</span>
			<input class="form-control" name="empls" id="empls" value="${exam.empls}" type="text" placeholder="0" onkeyup="return ValidateNumber($(this),value)"/>
			</div>
		</td>
	</tr>
	<tr>
		<td>
			<button class="btn btn-danger" name="method:save" type="submit">修改活動</button>
			
		</td>
	</tr>
</table>
</div>
</form>  

<script>
$(".pick" ).datetimepicker({
	changeMonth: true,
	changeYear: true
});
$(".uneditable-input").css("border-color", "#049cdb");
</script>
</body>
</html>
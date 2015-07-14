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
<table class="table">
	<tr>
		<td class="control-group info">			
			<div class="input-prepend">
				<span class="add-on">梯次</span>
				<input class="span1" id="level" name="level" value="${exam.level}" type="text" placeholder="ex.第1梯 or 加開梯">
			</div>
			&nbsp;
			<div class="input-prepend">
				<span class="add-on">場次</span>
				<input class="span1" id="no" name="no" value="${exam.no}" placeholder="ex.第12場 or 上午場" type="text">
			</div>
			&nbsp;
			<div class="input-prepend">
				<span class="add-on">說明</span>
				<input class="span4" id="note" name="note" value="${exam.note}" placeholder="ex.台北 or 新竹" type="text">
			</div>
		</td>
	</tr>
	<tr>
		<td class="control-group info" nowrap>		
			<div class="input-prepend" style="float:left;">
			<span class="add-on">1年級</span>
			<input class="span1" name="grad1" id="grad1" value="${exam.grad1}" type="text" placeholder="上限">
			</div>
			&nbsp;
			<div class="input-prepend">
			<span class="add-on">2年級</span>
			<input class="span1" name="grad2" id="grad2" value="${exam.grad2}" type="text" placeholder="上限">
			</div>
			&nbsp;
			<div class="input-prepend">
			<span class="add-on">3年級</span>
			<input class="span1" name="grad3" id="grad3" value="${exam.grad3}" type="text" placeholder="上限">
			</div>
			&nbsp;
			<div class="input-prepend" >
			<span class="add-on">4年級</span>
			<input class="span1" name="grad4" id="grad4" value="${exam.grad4}" type="text" placeholder="上限">
			</div>
		</td>		
		
	</tr>	
	<tr>
		<td class="control-group info">
			<div class="input-prepend">
			<span class="add-on">報名開始</span>
			<input type="text" id="sign_begin" placeholder="點一下輸入日期時間" name="sign_begin" value="${exam.sign_begin}"/>
			</div>
			&nbsp;
			<div class="input-prepend" >
			<span class="add-on">報名截止</span>
			<input class="span2" id="sign_end" placeholder="點一下輸入日期時間" name="sign_end" type="text" value="${exam.sign_end}"/>
			</div>
			
		</td>		
	</tr>
	<tr>
		<td class="control-group info">
			<div class="input-prepend">
			<span class="add-on">考試開始</span>
			<input type="text" id="exam_begin" placeholder="點一下輸入日期時間" name="exam_begin" value="${exam.exam_begin}"/>
			</div>
			&nbsp;
			<div class="input-prepend" >
			<span class="add-on">考試結束</span>
			<input class="span2" id="exam_end" placeholder="點一下輸入日期時間" name="exam_end" type="text" value="${exam.exam_end}"/>
			</div>&nbsp;
			<button class="btn btn-danger" name="method:save" type="submit">儲存變更</button>
			<a href="ExamsManager"class="btn">返回</a>
			
		</td>		
	</tr>
</table>
    




</form>  

<script>
$("input[name='sign_begin'], input[name='sign_end'], input[name='exam_begin'], input[name='exam_end']" ).datetimepicker();
$(".uneditable-input").css("border-color", "#049cdb");
</script>
</body>
</html>
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
	$('#addinfo').popover("show");
	$('#fileinfo').popover("show");
	
	setTimeout(function() {
		$('#funbtn').popover("hide");
		$('#addinfo').popover("hide");
		$('#fileinfo').popover("hide");
	}, 5000);
	
	$("input[name='beginDate']").change(function(){
		//alert($("#beginDate").val());
		$("#endDate").val($("#beginDate").val());
	});	
});

function ValidateNumber(e, pnumber){
	if (!/^\d+$/.test(pnumber)){
		$(e).val(/^\d+/.exec($(e).val()));
	}
	return false;
}

function refla(){
	$("input[name='Oids']").val("");
}
</script>  
</head>
<body>
<div class="alert">
	<button type="button" class="close" data-dismiss="alert">&times;</button>
	<strong>考試管理</strong> 請依欄位輸入資料建立考試
	<a href="/eis/Calendar"class="btn">返回</a>
	<div id="funbtn" rel="popover" title="說明" data-content="請依欄位名稱建立資料" data-placement="right" class="btn btn-warning">?</div>
</div>

<form action="ExamsManager" method="post" class="form-horizontal" enctype="multipart/form-data">

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
				<input class="span1" id="level" placeholder="梯次" name="level" value="${level}" type="text" style="ime-mode:disabled" onkeyup="return ValidateNumber($(this),value)"/>
			</div>
			<div class="input-prepend">
				<span class="add-on">場次</span>
				<input class="span1" id="no" placeholder="場次" name="no" value="${no}" type="text" style="ime-mode:disabled" onkeyup="return ValidateNumber($(this),value)"/>
			</div>
			<div class="input-prepend">
				<span class="add-on">說明</span>
				<input class="span4" id="note" placeholder="說明" name="note" value="${note}" type="text" style="ime-mode:disabled"/>
			</div>
		</td>
	</tr>
		
	<tr>
		<td class="control-group info">
			<div class="input-prepend">
			<span class="add-on">報名開始</span>
			<input type="text" id="sign_begin" placeholder="報名開始時間" name="sign_begin" value="${sign_begin}"/>
			</div>
			<div class="input-prepend" >
			<span class="add-on">報名截止</span>
			<input class="span2" id="sign_end" placeholder="報名截止時間" name="sign_end" type="text" value="${sign_end}"/>
			</div>
			
		</td>		
	</tr>
	<tr>
		<td class="control-group info">
			<div class="input-prepend">
			<span class="add-on">考試開始</span>
			<input type="text" id="exam_begin" placeholder="考試開始時間" name="exam_begin" value="${exam_begin}"/>
			</div>
			<div class="input-prepend" >
			<span class="add-on">考試結束</span>
			<input class="span2" id="exam_end" placeholder="考試結束時間" name="exam_end" type="text" value="${exam_end}"/>
			</div>			
		</td>		
	</tr>
	<tr>
		<td class="control-group info" nowrap>		
			<div class="input-prepend">
			<span class="add-on">1年級</span>
			<input class="span1" name="grad1" id="grad1" value="${grad1}" type="text" placeholder="上限" onkeyup="return ValidateNumber($(this),value)"/>
			</div>
			<div class="input-prepend">
			<span class="add-on">2年級</span>
			<input class="span1" name="grad2" id="grad2" value="${grad2}" type="text" placeholder="上限" onkeyup="return ValidateNumber($(this),value)"/>
			</div>
			<div class="input-prepend">
			<span class="add-on">3年級</span>
			<input class="span1" name="grad3" id="grad3" value="${grad3}" type="text" placeholder="上限" onkeyup="return ValidateNumber($(this),value)"/>
			</div>
			<div class="input-prepend" >
			<span class="add-on">4年級</span>
			<input class="span1" name="grad4" id="grad4" value="${grad4}" type="text" placeholder="上限" onkeyup="return ValidateNumber($(this),value)"/>
			</div>
			<button class="btn btn-danger" name="method:create" type="submit">建立考試</button>
			<div id="addinfo" rel="popover" title="說明" data-content="同梯次同場次學生不可重複報名，但學生可在不同梯次重複報名。請慎選報名期間防止學生任意報名" data-placement="top" class="btn btn-warning">?</div>
		</td>
	</tr>
</table>
    

<div class="wizard-steps">
	<div><a href="#"><span>1</span> 建立學生名單</a></div>
	<div><a href="#"><span>2</span> 追加學生名單</a></div>
	<div><a href="#"><span>3</span> 列印報名資料</a></div>
</div>
<table class="table">
	<tr>
		<td>
		<div class="fileupload fileupload-new" data-provides="fileupload" style="float:left;">    		    
			<div class="input-append">			
				<div class="uneditable-input">
					<i class="icon-file fileupload-exists"></i> 
					<span class="fileupload-preview"></span>
				</div>	
				<span class="btn btn-file btn-info">					
					<span class="fileupload-new">選擇檔案</span>
					<span class="fileupload-exists">重選檔案 </span>
					<input type="file" name="upload"/>
				</span>				
				<a href="#" class="btn fileupload-exists btn-info" data-dismiss="fileupload">取消</a>
			</div>
		</div>
		&nbsp;
		<div class="btn-group">		
		<button class="btn" name="method:addStds" type="submit" onClick="javascript: return(confirm('接續原有學生名單加入學生名單\n確定嗎？')); void('')">追加學生名單</button>
		<button class="btn" name="method:printStd" type="submit">列印學生名單</button>
		<button class="btn btn-danger" name="method:updateStds" onClick="javascript: return(confirm('刪除原有學生名單建立新的學生名單\n確定嗎？')); void('')" type="submit">建立學生名單</button>
		</div>
		<div id="fileinfo" rel="popover" title="說明" data-content="建立學生名單將清除所有學生重新建立，追加學生名單依原有名單增加學生，檔案中有重複資料不受影響。文字檔名不限，內容無符號請以換行分隔" data-placement="right" class="btn btn-warning">?</div>	
		</td>
	</tr>
</table>

<c:if test="${!empty exames}">
<table class="table table-hover table-bordered">
	<thead>
    	<tr class="success">
	        <th nowrap>梯次</th>
	        <th nowrap>場次</th>
	        <th nowrap>說明</th>
	        <th nowrap>報名期間</th>
	        <th nowrap>考試期間</th>
	        <th nowrap>1年級</th>
	        <th nowrap>2年級</th>
	        <th nowrap>3年級</th>
	        <th nowrap>4年級</th>
	        <th></th>
      	</tr>
    </thead>
    <tbody class="control-group info">
	<c:forEach items="${exames}" var="e">
		<tr>
	        <td nowrap>${e.level}</td>
	        <td nowrap>${e.no}</td>
	        <td nowrap>${e.note}</td>
	        <td nowrap><span class="label label-info">${fn:substring(e.sign_begin, 5, 16)}</span> <span class="label label-info">${fn:substring(e.sign_end, 5, 16)}</span></td>	        
	        <td nowrap><span class="label label-info">${fn:substring(e.exam_begin, 5, 16)}</span> <span class="label label-info">${fn:substring(e.exam_end, 5, 16)}</span></td>
	        <td nowrap>${e.cnt1} / ${e.grad1}</td>
	        <td nowrap>${e.cnt2} / ${e.grad2}</td>
	        <td nowrap>${e.cnt3} / ${e.grad3}</td>
	        <td nowrap>${e.cnt4} / ${e.grad4}</td>
	        <td width="100%" nowrap><input type="hidden" id="Oid${e.Oid}" name="Oids" />
	        <div class="btn-group">
	        <button class="btn btn-small" name="method:edit" onClick="refla(),$('#Oid${e.Oid}').val('${e.Oid}')" type="submit">編輯考試資訊</button>
	        <button class="btn btn-small" name="method:printExam" onClick="refla(),$('#Oid${e.Oid}').val('${e.Oid}')" type="submit">列印學生名單</button>
	        <button class="btn btn-danger btn-small" name="method:delete" onClick="refla(),$('#Oid${e.Oid}').val('${e.Oid}')" type="submit">刪除考試</button>
	        </div>
	        </td>
      	</tr>     
	</c:forEach>
	</tbody>
</table>
</c:if>
</form>
<script>
$("input[name='sign_begin'], input[name='sign_end'], input[name='exam_begin'], input[name='exam_end']" ).datetimepicker();
$(".uneditable-input").css("border-color", "#049cdb");
</script>
</body>
</html>
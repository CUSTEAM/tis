<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">


<title>活動管理</title>
<script src="/eis/inc/js/plugin/jquery-ui.js"></script>
<script src="/eis/inc/js/plugin/jquery-ui-timepicker-addon.js"></script>
<link href="/eis/inc/css/jquery-ui.css" rel="stylesheet"/>
<script src="/eis/inc/js/plugin/bootstrap-tooltip.js"></script>
<script type="text/javascript" src="/eis/inc/js/plugin/jquery-ui-timepicker-addon.js"></script>
<link href="/eis/inc/bootstrap/plugin/bootstrap-fileinput/css/fileinput.min.css" rel="stylesheet">
<script src="/eis/inc/bootstrap/plugin/bootstrap-fileinput/js/fileinput.min.js"></script>
<script src="/eis/inc/bootstrap/plugin/bootstrap-fileinput/js/fileinput_locale_zh-TW.js"></script>
<link href="/eis/inc/css/wizard-step.css" rel="stylesheet"/>

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
<div class="bs-callout bs-callout-info" id="callout-helper-pull-navbar">
	<button type="button" class="close" data-dismiss="alert">&times;</button>
	<strong>活動管理</strong> 請依欄位輸入資料建立活動
	<a href="/eis/Calendar"class="btn">返回</a>
</div>
<div class="wizard-steps">
  	<div><a href="#"><span>1</span> 建立活動</a></div>
  	<div><a href="#"><span>2</span> 修正活動</a></div>
  	<div><a href="#"><span>3</span> 列印活動資料</a></div>
</div><br><br>
<form action="ExamsManager" method="post" class="form-horizontal" enctype="multipart/form-data">




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
			  <input class="form-control" id="level" placeholder="梯次" name="level" value="${level}" type="text" style="ime-mode:disabled" onkeyup="return ValidateNumber($(this),value)"/>
			</div>	
		</td>
	</tr>
	<tr>
		<td>
			<div class="input-group">
				<span class="input-group-addon">場次</span>
				<input class="form-control" id="no" placeholder="場次" name="no" value="${no}" type="text" style="ime-mode:disabled" onkeyup="return ValidateNumber($(this),value)"/>
			</div>
		</td>
	</tr>
	<tr>
		<td>	
			<div class="input-group">
				<span class="input-group-addon">說明</span>
				<input class="form-control" id="note" placeholder="說明" name="note" value="${note}" type="text" style="ime-mode:disabled"/>
			</div>
		</td>
	</tr>
		
	<tr>
		<td>			
			<div class="input-group">
			<span class="input-group-addon">報名開始</span>
			<input readonly class="form-control pick" type="text" id="sign_begin" placeholder="報名開始時間" name="sign_begin" value="${sign_begin}"/>
			</div>
		</td>
	</tr>
	<tr>
		<td>	
			<div class="input-group">
			<span class="input-group-addon">報名截止</span>
			<input readonly class="form-control pick" id="sign_end" placeholder="報名截止時間" name="sign_end" type="text" value="${sign_end}"/>
			</div>
			
		</td>		
	</tr>
	<tr>
		<td>
			<div class="input-group">
			<span class="input-group-addon">活動開始</span>
			<input readonly class="form-control pick" type="text" id="exam_begin" placeholder="活動開始時間" name="exam_begin" value="${exam_begin}"/>
			</div>
		</td>
	</tr>
	<tr>
		<td>	
			<div class="input-group">
			<span class="input-group-addon">活動結束</span>
			<input readonly class="form-control pick" id="exam_end" placeholder="活動結束時間" name="exam_end" type="text" value="${exam_end}"/>
			</div>			
		</td>		
	</tr>
	<tr>
		<td>		
			<div class="input-group">
			<span class="input-group-addon">1年級</span>
			<input class="form-control" name="grad1" id="grad1" value="${grad1}" type="text" placeholder="0" onkeyup="return ValidateNumber($(this),value)"/>
			</div>
		</td>
	</tr>
	<tr>
		<td>
			<div class="input-group">
			<span class="input-group-addon">2年級</span>
			<input class="form-control" name="grad2" id="grad2" value="${grad2}" type="text" placeholder="0" onkeyup="return ValidateNumber($(this),value)"/>
			</div>
		</td>
	</tr>
	<tr>
		<td>
			<div class="input-group">
			<span class="input-group-addon">3年級</span>
			<input class="form-control" name="grad3" id="grad3" value="${grad3}" type="text" placeholder="0" onkeyup="return ValidateNumber($(this),value)"/>
			</div>
		</td>
	</tr>
	<tr>
		<td>
			<div class="input-group">
			<span class="input-group-addon">4年級</span>
			<input class="form-control" name="grad4" id="grad4" value="${grad4}" type="text" placeholder="0" onkeyup="return ValidateNumber($(this),value)"/>
			</div>
		</td>
	</tr>
	<tr>
		<td>
			<div class="input-group">
			<span class="input-group-addon">教職員</span>
			<input class="form-control" name="empls" id="empls" value="${empls}" type="text" placeholder="0" onkeyup="return ValidateNumber($(this),value)"/>
			</div>
		</td>
	</tr>
	<tr>
		<td>
			<button class="btn btn-danger" name="method:create" type="submit">建立活動</button>
			
		</td>
	</tr>
</table>
</div>

<c:if test="${!empty exames}">
<div class="panel panel-primary">
<div class="panel-heading">活動列表</div>
<table class="table table-hover">
	<thead>
    	<tr>
	        <th nowrap>梯次</th>
	        <th nowrap>場次</th>
	        <th>說明</th>
	        <th nowrap>報名期間</th>
	        <th nowrap>活動期間</th>
	        <th nowrap>1年級</th>
	        <th nowrap>2年級</th>
	        <th nowrap>3年級</th>
	        <th nowrap>4年級</th>
	        <th nowrap>教職員</th>
      	</tr>
    </thead>
    <tbody>
	<c:forEach items="${exames}" var="e">
		<tr>
	        <td nowrap>${e.level}</td>
	        <td nowrap>${e.no}</td>
	        <td>${e.note}<br>
	        <input type="hidden" id="Oid${e.Oid}" name="Oids" />
	        <div class="btn-group">
	        <button class="btn btn-default btn-xs" name="method:edit" onClick="refla(),$('#Oid${e.Oid}').val('${e.Oid}')" type="submit">編輯</button>
	        <button class="btn btn-default btn-xs" name="method:printExam" onClick="refla(),$('#Oid${e.Oid}').val('${e.Oid}')" type="submit">列印</button>
	        <button class="btn btn-default btn-danger btn-xs" name="method:delete" onClick="refla(),$('#Oid${e.Oid}').val('${e.Oid}')" type="submit">刪除</button>
	        </div>
	        </td>
	        <td nowrap><span class="label label-primary">${fn:substring(e.sign_begin, 5, 16)}</span> <span class="label label-primary">${fn:substring(e.sign_end, 5, 16)}</span></td>	        
	        <td nowrap><span class="label label-primary">${fn:substring(e.exam_begin, 5, 16)}</span> <span class="label label-primary">${fn:substring(e.exam_end, 5, 16)}</span></td>
	        <td nowrap>${e.cnt1}/${e.grad1}</td>
	        <td nowrap>${e.cnt2}/${e.grad2}</td>
	        <td nowrap>${e.cnt3}/${e.grad3}</td>
	        <td nowrap>${e.cnt4}/${e.grad4}</td>
	        <td nowrap>${e.ecnt}/${e.empls}</td>
      	</tr>	   
	</c:forEach>
	</tbody>
</table>
</div>
</c:if>


    
<c:if test="${!empty exames}">
<div class="wizard-steps">
	<div><a href="#"><span>1</span> 建立學生名單</a></div>
	<div><a href="#"><span>2</span> 追加學生名單</a></div>
	<div><a href="#"><span>3</span> 列印報名資料</a></div>
</div><br><br>

<div class="panel panel-primary">
	<div class="panel-heading">匯入學生名單</div>
	<ul class="list-group">
	  <li class="list-group-item"><span class="label label-as-badge label-warning">1</span> 建立學生名單將清除所有學生重新建立，檔案中有重複資料不受影響。</li>
	  <li class="list-group-item"><span class="label label-as-badge label-warning">2</span> 追加學生名單依原有名單增加學生，檔案中有重複資料不受影響。</li>
	  <li class="list-group-item"><span class="label label-as-badge label-danger">3</span> 文字檔名不限，內容無符號請以換行分隔。</li>
	</ul>
	

<table class="table">
	<tr>
		<td>
		<div class="input-group">
		<input id="upload" name="upload" multiple type="file" class="file-loading" style="width:auto;">
		
		<span class="input-group-btn">		
		<button class="btn btn-default" name="method:addStds" type="submit" onClick="javascript: return(confirm('接續原有學生名單加入學生名單\n確定嗎？')); void('')">追加學生名單</button>
		<button class="btn btn-default" name="method:printStd" type="submit">列印學生名單</button>
		<button class="btn btn-danger" name="method:updateStds" onClick="javascript: return(confirm('刪除原有學生名單建立新的學生名單\n確定嗎？')); void('')" type="submit">建立學生名單</button>
		</span>
		</div>
		</td>
	</tr>
</table>
</div>
</c:if>


</form>
<script>
$(".pick" ).datetimepicker();
$(".uneditable-input").css("border-color", "#049cdb");

$("#upload").fileinput({
	//uploadUrl: "#",
	multiple: true,
	uploadAsync: false,
	//previewFileIcon: '<i class="fa fa-file"></i>',
	allowedPreviewTypes: null,
	language: "zh-TW",
	layoutTemplates: {
	    main1: "{preview}\n" +
	    "<div class=\'input-group {class}\'>\n" +
	    "   <div class=\'input-group-btn\'>\n" +
	    "       {browse}\n" +
	    //"       {upload}\n" +
	    "       {remove}\n" +
	    "   </div>\n" +
	    "   {caption}\n" +
	    "</div>"
	}
	//allowedFileExtensions: ["csv", "txt"]
});
</script>
</body>
</html>
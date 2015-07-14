<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>公假管理</title>
<script src="/eis/inc/js/plugin/bootstrap-typeahead.js"></script>
<script src="/eis/inc/js/plugin/jquery-ui.js"></script>
<script type="text/javascript" src="/eis/inc/js/plugin/jquery-ui-timepicker-addon.js"></script>
<link rel="stylesheet" href="/eis/inc/css/jquery-ui.css" />
<script>  
$(document).ready(function() {
	<c:if test="${!empty exp}">
	$.blockUI({ message: null }); 
	</c:if>
	$("input[id='nameno']").typeahead({
		remote:"#student_no",
		source : [],
		items : 10,
		updateSource:function(inputVal, callback){			
			$.ajax({
				type:"POST",
				url:"/eis/autoCompleteStmd",
				dataType:"json",
				data:{length:10, nameno:inputVal},
				success:function(d){
					//$("#tmp").html(JSON.stringify(d));
					callback(d.list);
				}
			});
		}		
	});
	
	
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
    <strong>建立公假</strong> 程式會判斷學生<strong>「輸入期間內是否有課並建立公假」</strong>，刪除請按「刪除」結束請按「返回」每個欄位均可排序&nbsp;
    <a href="/eis/Calendar"class="btn">返回</a>
    <div id="funbtn" rel="popover" title="說明" 
    data-content="點選「建立公假」後，畫面上輸入的資料仍保留，輸入完成後轉呈導師→學務單位→學務單位主管,過程顯示於下方列表" 
    data-placement="bottom" class="btn btn-warning">?</div>
    </div>

<form action="AddPubLeave" method="post" class="form-horizontal">
<table class="table">
	<tr>
		<td class="text-info" nowrap>開始日期</td>
		<td class="control-group info" width="1">
			<input type="text" id="beginDate" placeholder="點一下輸入日期" name="beginDate" value="${beginDate}"/>
		</td>		
		<td class="control-group info" width="100%">
		<select name="begin">
			<option value="0">開始節次</option>		
			<c:forEach begin="1" end="14" var="b">
			<option <c:if test="${b eq begin}">selected</c:if> value="${b}">第${b}節</option>
			</c:forEach>
		</select>
		</td>
	</tr>
	<tr>
		<td class="text-info" nowrap>結束日期</td>
		<td class="control-group info"><input type="text" id="endDate" placeholder="點一下輸入日期" name="endDate" value="${endDate}"/></td>		
		<td class="control-group info">
		<select name="end">
			<option value="0">結束節次</option>		
			<c:forEach begin="1" end="14" var="b">
			<option <c:if test="${b eq end}">selected</c:if> value="${b}">第${b}節</option>
			</c:forEach>
		</select>
		</td>
	</tr>
	<tr>		
		<td class="text-info">事由</td>
		<td class="control-group info text-left" colspan="2">
		<input type="text" class="span4" placeholder="事由30字以內" name="reason" value="${reason}"/>
		</td>		
	</tr>
	<tr>
		<td class="text-info">學號姓名</td>
		<td colspan="2">
		<div class="input-append control-group info"">
			<input class="span4" autocomplete="off" type="text" id="nameno" name="nameno"
			onClick="this.value='', $('#student_no').val('');"
			data-provide="typeahead" value="${nameno}" placeholder="輸入學號或姓名再點選列表中的學生" />
			<input type="hidden" id="student_no" name="student_no" value="${student_no}"/>
		    <button class="btn btn-info" name="method:add" type="submit">建立公假</button>
		</div>	
		</td>
	</tr>
</table>
    



</form>  
<display:table export="true" pagesize="10" name="${myapps}" id="m" class="table" sort="list" excludedParams="*" >
	<display:column style="white-space:nowrap;"><a href="AddPubLeave?dOid=${m.Oid}" <c:if test="${m.result!=null}">disabled</c:if> class="btn btn-small btn-danger">刪除</a></display:column>
  	<display:column style="white-space:nowrap;" title="班級" property="ClassName" sortable="true"/>  	
  	<display:column style="white-space:nowrap;" title="學號" property="student_no" sortable="true" />
  	<display:column style="white-space:nowrap;" title="姓名" property="student_name" sortable="true" />
  	<display:column title="狀態" sortable="true">
  	<c:if test="${m.result==null}"><span class="label label-warning">${m.cname}:審核中</span></c:if>
		<c:if test="${m.result eq '1'}"><span class="label label-success">${m.cname}:已核准</span></c:if>
		<c:if test="${m.result eq '2'}"><span class="label label-important">${m.cname}:不核准</span></c:if>
  	</display:column>
  	<display:column>
  	<c:forEach items="${m.dilgs}" var="d">
		<c:if test="${m.result==null}"><span class="label label-inverse">${d.date}, 第${d.cls}節, ${d.chi_name}</span></c:if>
		<c:if test="${m.result!=null}"><span class="label label-label">${d.date}, 第${d.cls}節, ${d.chi_name}</span></c:if>	
		</c:forEach>
  	</display:column>
</display:table>    
<script>
var today=new Date();//86400000
var end = today.valueOf()+(86400000*7);
var begin=today.valueOf()-(86400000*7);



$("input[name='beginDate'], input[name='endDate']" ).datepicker({
	minDate: new Date(begin),
	maxDate: new Date(end)
});


</script>
</body>
</html>
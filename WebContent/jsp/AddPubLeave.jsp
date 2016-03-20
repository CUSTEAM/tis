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
<div class="bs-callout bs-callout-warning" id="callout-helper-pull-navbar">
    <strong>建立公假</strong> 時會判斷學生<strong>「輸入期間內是否有課並建立公假」</strong>
</div>  
    

<form action="AddPubLeave" method="post" class="form-inline">


<div class="panel panel-primary">
  
	<div class="panel-heading">建立公假</div>
  	<div class="panel-body">
    <p>點選「建立公假」後，畫面上輸入的資料仍保留，可連續輸入多位學生</p>
    <p>建立公假時會判斷學生「輸入期間內是否有課並建立公假」</p>
    
  	</div>
	<table class="table has-info">		
		<tr>
			<td class="text-info" nowrap>開始日期</td>
			<td width="1">
				<input class="form-control" type="text" id="beginDate" placeholder="點一下輸入日期" name="beginDate" value="${beginDate}"/>
			</td>		
			<td width="100%">
			<select name="begin" class="form-control">
				<option value="0">開始節次</option>		
				<c:forEach begin="1" end="14" var="b">
				<option <c:if test="${b eq begin}">selected</c:if> value="${b}">第${b}節</option>
				</c:forEach>
			</select>
			</td>
		</tr>
		<tr>
			<td class="text-info" nowrap>結束日期</td>
			<td><input type="text" class="form-control" id="endDate" placeholder="點一下輸入日期" name="endDate" value="${endDate}"/></td>		
			<td>
			<select name="end" class="form-control">
				<option value="0">結束節次</option>		
				<c:forEach begin="1" end="14" var="b">
				<option <c:if test="${b eq end}">selected</c:if> value="${b}">第${b}節</option>
				</c:forEach>
			</select>
			</td>
		</tr>
		<tr>		
			<td class="text-info">事由</td>
			<td colspan="2">
			<input type="text" class="form-control" placeholder="事由30字以內" name="reason" value="${reason}"/>
			</td>		
		</tr>
		<tr>
			<td class="text-info">學號姓名</td>
			<td>
			<input type="hidden" id="student_no" name="student_no" value="${student_no}"/>
			
				<input class="form-control" autocomplete="off" type="text" id="nameno" name="nameno"
				onClick="this.value='', $('#student_no').val('');"
				data-provide="typeahead" value="${nameno}" placeholder="輸入學號或姓名再點選列表中的學生" />
			</td>
			<td>	
			    <button class="btn btn-primary" name="method:add" type="submit">建立公假</button>
			</td>
		</tr>
		
	</table>
</div>



</form>  

<c:if test="${!empty myapps}">
<div class="panel panel-primary">
  
	<div class="panel-heading">建立公假</div>
  	<div class="panel-body">
    <p>輸入完成後轉呈導師→學務單位→學務單位主管,過程顯示於下方列表</p>
  	</div>

	<display:table pagesize="10" name="${myapps}" id="m" class="table" sort="list">
	<display:column style="white-space:nowrap;"><a href="AddPubLeave?dOid=${m.Oid}" <c:if test="${m.result!=null}">disabled</c:if> class="btn btn-small btn-danger">刪除</a></display:column>
  	<display:column style="white-space:nowrap;" title="班級" property="ClassName" sortable="true"/>  	
  	<display:column style="white-space:nowrap;" title="學號" property="student_no" sortable="true" />
  	<display:column style="white-space:nowrap;" title="姓名" property="student_name" sortable="true" />
  	<display:column title="狀態" sortable="true">
  	<c:if test="${m.result==null}"><span class="label label-warning">${m.cname}:審核中</span></c:if>
		<c:if test="${m.result eq '1'}"><span class="label label-success">${m.cname}:已核准</span></c:if>
		<c:if test="${m.result eq '2'}"><span class="label label-important">${m.cname}:不核准</span></c:if>
  	</display:column>
  	<display:column style="width:100%;">  	
  	<a class="btn btn-default" role="button" data-toggle="collapse" href="#collapse${m.Oid}" aria-expanded="false" aria-controls="collapse${m.Oid}">
  	查看內容
	</a>
  	<div class="collapse" id="collapse${m.Oid}">
  	<display:table name="${m.dilgs}" class="table table-striped table-condensed">  	
		<display:column property="chi_name" style="width:150px;" title="課程名稱" />
		<display:column property="date" style="width:100px;" title="日期" />
		<display:column property="cls" style="text-align:right; width:80px;" title="節次"/>
	</display:table>
  	</div>
  	
  	</display:column>
</display:table>
</div>    
</c:if>
<script>
var today=new Date();//86400000
var end = today.valueOf()+(86400000*60);
var begin=today.valueOf()-(86400000*7);



$("input[name='beginDate'], input[name='endDate']" ).datepicker({
	minDate: new Date(begin),
	maxDate: new Date(end)
});


</script>
</body>
</html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/eis/inc/js/advance-form-check-leave.js"></script>
<script src="/eis/inc/js/develop/adv_math.js"></script>
<script src="/eis/inc/js/plugin/jquery-ui.js"></script>
<script src="/eis/inc/js/plugin/jquery-ui-timepicker-addon.js"></script>
<link href="/eis/inc/css/jquery-ui.css" rel="stylesheet"/>
<script>
$(document).ready(function() {	
	$('.help').popover("show");
	$('.help1').popover("show");
	setTimeout(function() {
		$('.help').popover("hide");
	}, 5000);
	setTimeout(function() {
		$('.help1').popover("hide");
	}, 0);
	
});
</script>
<title>數位教材規劃</title>

</head>
<body>
<form action="ElearningReserve" method="post" class="form-inline">
<div class="bs-callout bs-callout-warning">
<button type="button" class="close" data-dismiss="alert">&times;</button>
<strong>數位課程規劃</strong>
</div>



<div class="panel panel-primary">
  
	<div class="panel-heading">課程規劃</div>
  	<div class="panel-body">
    <p>3學分課程依規定需規劃18小時,2學分為12小時</p>
    <p>錄製完成後請通知遠距組確認教材。</p>
	</div>
	<table class="table">
		<tr>
			<td>學年</td>
			<td>學期</td>
			<td>課程名稱</td>
			<td>學分</td>
			<td nowrap>已錄製時數</td>
			<td width="100%"></td>
		</tr>
		<tr>
			<td>
			<input type="hidden" name="Oid" value="" />
			<select class="form-control" name="year" style="width:auto;">
				<c:forEach varStatus="i" begin="${school_year-5}" end="${school_year+5}">
				<option <c:if test="${i.index eq school_year}">selected</c:if> value="${i.index}">${i.index}學年</option>
				</c:forEach>
			</select>
			</td>
			<td>
			<select name="term" class="form-control" style="width:auto;">
				<option value="1">第1學期</option>
				<option value="2">第2學期</option>
			</select>
			</td>
			<td><input class="form-control" placeholder="請輸入課程預訂名稱" name="chi_name" value="" type="text" autocomplete="Off"/></td>
			<td nowrap>
			
			<select name="credit" class="form-control" style="width:auto;">
				<option></option>
				<option value="0">0</option>
				<option value="1">1</option>
				<option value="2">2</option>
				<option value="3">3</option>
			</select>			
			<div rel="popover" title="說明" 
		    data-content="3學分課程至少18小時,2學分至少12小時,錄製完成後請通知遠距組確認教材。" 
		    data-placement="left" class="btn btn-warning help">?</div>
		    </div>
			</td>
			<td nowrap>
				<input class="form-control" style="width:100px" placeholder="已錄製時數" name="thour" id="thour" value="0" type="text" style="ime-mode:disabled" autocomplete="Off"/>
				<button rel="popover" title="說明" type="button"
			    data-content="3學分至少18小時,2學分至少12小時" 
			    data-placement="right" class="btn btn-warning btn-mini">?</div>
			    </button>
			</td>
			<td><button name="method:add" class="btn btn-danger">規劃課程</button></td>
		</tr>
			
		
		<c:forEach items="${cs}" var="c">
		<tr>
			<td>
			<input type="hidden" name="Oid" id="Oid${c.Oid}" value="" />
			<select class="form-control" style="width:auto" name="year">
				<c:forEach varStatus="i" begin="${school_year-5}" end="${school_year+5}">
				<option <c:if test="${c.school_year eq i.index}">selected</c:if> value="${i.index}">${i.index}學年</option>
				</c:forEach>
			</select>
			</td>
			<td>
			<select class="form-control" style="width:auto;" name="term">
				<option <c:if test="${c.school_term eq '1'}">selected</c:if> value="1">第1學期</option>
				<option <c:if test="${c.school_term eq '2'}">selected</c:if> value="2">第2學期</option>
			</select>
			</td>
			<td><input class="form-control" name="chi_name" value="${c.chi_name}" type="text" autocomplete="Off"/></td>
			<td>
			<select name="credit" class="form-control" style="width:auto;">
				<option value="0">0</option>
				<option <c:if test="${c.credit==1}">selected</c:if> value="1">1</option>
				<option <c:if test="${c.credit==2}">selected</c:if> value="2">2</option>
				<option <c:if test="${c.credit==3}">selected</c:if> value="3">3</option>
			</select>
			
			
			<td>			
				<fmt:parseNumber var="hours" integerOnly="false" type="number" value="${c.thour}" />			
				<input class="form-control" style="width:100px;" name="thour" 
				value="<fmt:formatNumber type="number" minIntegerDigits="2" value="${fn:substringBefore(hours div 60, '.')}" />:<fmt:formatNumber type="number" minIntegerDigits="2" value="${c.thour%60}" />" type="text" style="ime-mode:disabled" autocomplete="Off"/>
				<button rel="popover" title="時間" type="button"
			    data-content="${c.thour}分鐘" 
			    data-placement="right" class="btn btn-info btn-mini help1">?</div>
			    </button>
			</td>
			<td>
			<c:if test="${empty c.checked}">
			<div class="btn-group" onClick="$('#Oid${c.Oid}').val(${c.Oid})">
		    	<button name="method:edit" onClick="javascript: return(confirm('確定修改課程規劃?')); void('')"  class="btn btn-default">修改</button>
				<button name="method:del" onClick="javascript: return(confirm('確定刪除課程規劃?')); void('')"  class="btn btn-danger">刪除</button>
		    </div>
		    </c:if>
		    <c:if test="${!empty c.checked}"><span class="label label-info">已審核</span></c:if>
		    
			</td>
		</tr>	
	</c:forEach>	
	</table>
</div>
</form>
<script>
$("input[name='thour']" ).timepicker({
	stepMinute: 10,
	hourMin: 0,
	hourMax: 99
});

</script>
</body>
</html>
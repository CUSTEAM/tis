<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/eis/inc/js/advance-form-check-leave.js"></script>
<script>
$(document).ready(function() {
	$('.q').popover("show");
	setTimeout(function() {
		$('.q').popover("hide");
	}, 0);
});
</script>
<title>留校時間管理</title>
</head>
<body>
	<form action="StayTimeManager" method="post">
		<div class="alert">
			<button type="button" class="close" data-dismiss="alert">&times;</button>
			<b>留校時間管理</b><br>
			${school_year}學年第${school_term}學期留校時間應設時數<c:if test="${rule.time_cut>0}">(已扣除${rule.time_cut}時數)</c:if>為 ${rule.thour-rule.time_cut}, 已設時數 ${rule.tech_stay}
			<c:if test="${rule.tutor>0}">, 生活輔導應設時數為 ${rule.tutor}, 生活輔導已設時數 ${rule.tutor_stay}</c:if>
			<c:if test="${rule.tutor<1}">, 無導師班級</c:if>
			<div class="btn btn-mini btn-warning q" rel="popover" title="說明" 
		    data-content="留校時間為人事單位核定;生活輔導時數為導師班級數,依規定分別指定,不可相互衝突或與排課衝突" 
		    data-placement="right" class="btn btn-warning">?</div><br>
			編輯期間自 ${staytime_begin}至 ${staytime_end}
			<div class="btn btn-mini btn-warning q" rel="popover" title="說明" 
		    data-content="編輯期間由人事單位指定" 
		    data-placement="bottom" class="btn btn-warning">?</div>
			<c:if test="${rule.cnt>0}">, 截止後共修改 ${rule.cnt}次
			<div class="btn btn-mini btn-warning q" rel="popover" title="說明" 
		    data-content="修改次數上限由人事單位核定" 
		    data-placement="bottom" class="btn btn-warning">?</div>
			</c:if>
		</div>		
		<table class="table table-condensed">
			<tr>
				<td>
				<div class="input-prepend">
				    <span class="add-on">地點</span>
				    <input type="text" name="place" value="${place.place}"/>
			    </div>			
				</td>
				<td>
				<div class="input-prepend">
				    <span class="add-on">校內分機</span>
				    <input type="text" name="contact" value="${place.contact}"/>
			    </div>						
				</td>
				<td>
				<div class="input-prepend">
				    <span class="add-on">備註</span>
				    <input type="text" name="remark" value="${place.remark}"/>
			    </div>	
				</td>
				<td width="100%"><div class="btn-group">
				<button class="btn btn-danger" type="submit" name="method:save">儲存時間地點</button>
				<a class="btn" href="StayTimeManager">取消</a>
				</div>
				<a class="btn" href="/eis/Calendar">離開</a></td>
			</tr>			
		</table>
		<table class="table table-bordered table-condensed">
			<tr>
				<td></td>
				<td width="14%" align="center">星期一</td>
				<td width="14%" align="center">星期二</td>
				<td width="14%" align="center">星期三</td>
				<td width="14%" align="center">星期四</td>
				<td width="14%" align="center">星期五</td>
				<td width="14%" align="center">星期六</td>
				<td width="14%" align="center">星期日</td>
			</tr>
			<c:forEach begin="1" end="14" var="c">
				<tr>
					<td>${c}</td>
					<c:forEach begin="1" end="7" var="w">
						<td valign="middle">
						<input type="hidden" name="week" value="${w}" />
						<input type="hidden" name="period" value="${c}"/>						
						
						<c:set var="fk" value="true" />
						<c:set var="ck" value="true" />
						<c:forEach items="${cs}" var="a">
							<c:if test="${a.week==w && (c>=a.begin && c<=a.end)}">
							<c:set var="ck" value="false" />
							${a.chi_name}<br>
							</c:if>
						</c:forEach>
						<c:forEach items="${st}" var="a">								
							<c:if test="${a.week==w && (c>=a.begin && c<=a.end)}">
							<c:set var="fk" value="false" />	
							<c:if test="${a.kind eq'1'}"><span class="control-group warning"></c:if>
							<c:if test="${a.kind eq'2'}"><span class="control-group error"></c:if>
							<select name="kind">
								<option value=""></option>
								<option <c:if test="${a.kind eq'1'}">selected</c:if> value="1">留校時間</option>
								<c:if test="${rule.tutor>0}"><option <c:if test="${a.kind eq'2'}">selected</c:if> value="2">生活輔導</option></c:if>
							</select></span>
							</c:if>
						</c:forEach>
						<c:if test="${fk && ck}">
						<span class="control-group success"><select name="kind">
							<option value=""></option>
							<option value="1">留校時間</option>
							<c:if test="${rule.tutor>0}"><option value="2">生活輔導</option></c:if>
						</select></span>
						</c:if>						
						<c:if test="${fk && !ck}">
						<input type="hidden" name="kind" >
							<option value=""></option>
						</input>
						</c:if>
						<c:if test="${!fk && !ck}">
						<i class="icon-exclamation-sign"></i> 注意衝堂
						</c:if>
						</td>
					</c:forEach>
				</tr>
			</c:forEach>
		</table>
	</form>
</body>
</html>
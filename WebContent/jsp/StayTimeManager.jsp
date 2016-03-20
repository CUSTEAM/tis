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
	<form action="StayTimeManager" method="post" class="form-inline">
		<div class="bs-callout bs-callout-warning" id="callout-helper-pull-navbar">
			<h4>留校時間管理</h4>
			<p>編輯期間自 ${staytime_begin}至 ${staytime_end}, 編輯期間由人事單位指定</p>
			
			<c:if test="${rule.cnt>0}"><p>截止後共修改 <span class="badge">${rule.cnt}</span>次,修改次數上限由人事單位核定</p></c:if>
		</div>		
		<table class="table table-condensed">
			<tr>
				<td>
				<div class="input-group">
      				<div class="input-group-addon">地點</div>
				    <input class="form-control" type="text" name="place" value="${place.place}"/>
			    </div>
				<div class="input-group">
      				<div class="input-group-addon">校內分機</div>
				    <input class="form-control" type="text" name="contact" value="${place.contact}"/>
			    </div>
			    
				<div class="input-group">
      				<div class="input-group-addon">備註</div>
				    <input class="form-control" type="text" name="remark" value="${place.remark}"/>
			    </div>
			    
			    <div class="btn-group">
				<button class="btn btn-danger" type="submit" name="method:save">儲存時間地點</button>
				<a class="btn btn-default" href="StayTimeManager">取消</a>
				</div>
				</td>
			</tr>			
		</table>
		<div class="panel panel-primary">
		<div class="panel-heading">建立公假</div>
	  	<div class="panel-body">
	    <p>${school_year}學年第${school_term}學期留校時間應設時數<c:if test="${rule.time_cut>0}">(已扣除${rule.time_cut}時數)</c:if>為 ${rule.thour-rule.time_cut}, 已設時數 ${rule.tech_stay}
			<c:if test="${rule.tutor>0}">, 生活輔導應設時數為 ${rule.tutor}, 生活輔導已設時數 ${rule.tutor_stay}</c:if>
			<c:if test="${rule.tutor<1}">, 無導師班級</c:if>
		</p>
	    
	  	</div>
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
							<select name="kind" class="form-control">
								<option value=""></option>
								<option <c:if test="${a.kind eq'1'}">selected</c:if> value="1">留校時間</option>
								<c:if test="${rule.tutor>0}"><option <c:if test="${a.kind eq'2'}">selected</c:if> value="2">生活輔導</option></c:if>
							</select></span>
							</c:if>
						</c:forEach>
						<c:if test="${fk && ck}">
						<span class="control-group success"><select name="kind" class="form-control">
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
		</div>
	</form>
</body>
</html>
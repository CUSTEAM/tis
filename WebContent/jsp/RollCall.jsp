<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>點名</title>
<script src="/eis/inc/js/plugin/bootstrap-tooltip.js"></script>
<script src="/eis/inc/js/plugin/bootstrap-popover.js"></script>
<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script>
$(document).ready(function() {
	$('#funbtn').popover("show");
	$('#funInfo').popover("show");
	setTimeout(function() {
		$('#funInfo').popover("hide");
		$('#funbtn').popover("hide");
	}, 0);
});
</script>
<script type="text/javascript">
  google.load("visualization", "1", {packages:["corechart"]});
  google.setOnLoadCallback(drawChart);
  function drawChart() {
    var data = google.visualization.arrayToDataTable([
     
     <%Map map=(Map)request.getAttribute("chart");         
      String dilgs[]=(String[])map.get("dilgs");%>         
      <%=map.get("dtimes")%>         
      <%for(int i=1; i<dilgs.length; i++){%>         	
      <%=dilgs[i]%>          
      <%}%>          
    ]);
    var options = {
      title: '到課率統計',
      chartArea:{left:50, top:10, height:"85%", width:"85%"},
      vAxis: {minValue:50, format:'#'},
      fontSize:12          
    };

    var chart = new google.visualization.LineChart(document.getElementById('chart_div'));        
    chart.draw(data, options);
  }
</script>

</head>
<body>
&nbsp;
<div class="panel panel-primary">
	<div class="panel-heading">出席狀況</div>  	
	<table class="table table-bordered">
		<tr>
			<td>
			
			<div id="chart_div" style="width:auto; height:150px;"></div>
			</td>
		</tr>
	</table>
</div>

<form action="RollCall" method="post">
	<input type="hidden" name="Oid" id="Oid"/>
	<input type="hidden" name="date" id="date"/>
	<input type="hidden" name="week" id="week"/>
	
	<div class="panel panel-primary">
	<div class="panel-heading">點名狀況</div>
  	<div class="panel-body">
    	<p><strong>${school_year}學年第${school_term}學期上課期間:</strong> <small class="text-warning">${fn:substring(school_term_begin, 0, 10)} 至 ${fn:substring(school_term_end, 0, 10)}</small>
		<strong>點名期間:</strong> <small class="text-warning">${fn:substring(rollcall_begin, 0, 10)} 至 ${fn:substring(rollcall_end, 0, 10)}</small></p>
  	</div>
	
	<table class="table table-bordered table-striped">
		<tr>
			<td>日期</td>
			<td nowrap>星期</td>
			<td>節次</td>
			<td>班級</td>
			<td>課程名稱</td>
			<td nowrap>				
				<div class="btn-group">
                <button class="btn btn-default dropdown-toggle" data-toggle="dropdown">點名單列印 <span class="icon-user"></span></button>
                <ul class="dropdown-menu">
                <c:forEach items="${myCs}" var="ms">
                  <li><a href="Print/RoolCallTable?Oid=${ms.Oid}">${ms.ClassName}-${ms.chi_name}</a></li>
                </c:forEach>
                </ul>
              </div><!-- /btn-group -->
			</td>
			<td>節次,實到/應到</td>
		</tr>
		<c:if test="${empty weeks}">
			<tr>
				<td colspan="7"><p class="text-error">新學期尚未開始</p></td>
			</tr>
		</c:if>
		<c:forEach items="${weeks}" var="w">
			<tr>
				<td nowrap>${w.date}</td>
				<td >${w.week}</td>
				<td nowrap>${w.begin}至${w.end}節</td>
				<td nowrap>${w.ClassName}</td>
				<td>${w.chi_name}</td>
				<td>	
				<div class="btn-group" role="group" aria-label="...">			
				<input type="submit" onClick="$('#Oid').val('${w.dOid}'),$('#date').val('${w.date}'),$('#week').val('${w.week}')" id="ActLink" name="method:callOne" value="點名" class="btn btn-default"/>
				<input type="submit" onClick="$('#Oid').val('${w.dOid}'),$('#date').val('${w.date}'),$('#week').val('${w.week}')"id="ActLink" name="method:callAll" value="到齊" class="btn btn-success"/>
				</div>
				</td>
				<td>
				<c:if test="${!w.log}"><span class="label label-important">尚未編輯..</span></c:if> 
				<c:if test="${w.log && empty w.info}"><span class="label label-success">全班到齊!</span></c:if> 
				<c:if test="${w.log &&!empty w.info}">
				<c:forEach items="${w.info}" var="f">
					<span class="label label-primary">第${f.cls}節${f.cnt}/${w.select}</span>
				</c:forEach>
				</c:if>
				</td>
			</tr>
		</c:forEach>
		<c:forEach items="${oldweeks}" var="w">
			<tr>
				<td>${w.date}</td>
				<td>${w.week}</td>
				<td>${w.begin}至${w.end}節</td>
				<td>${w.ClassName}</td>
				<td>${w.chi_name}</td>
				<td>
					<div class="btn-group" role="group" aria-label="...">
					<input type="submit" name="method:viewOne" onClick="$('#Oid').val('${w.dOid}'),$('#date').val('${w.date}'),$('#week').val('${w.week}')" class="btn btn-default" value="檢視">
					<input type="button" class="btn btn-success" value="到齊" disabled>
					</div>
				</td>
				<td>
				<c:if test="${!w.log}"><span class="label label-important">尚未編輯..</span></c:if> 
					<c:if test="${w.log && empty w.info}"><span class="label label-success">全班到齊!</span></c:if> 
					<c:if test="${w.log &&!empty w.info}">
						<c:forEach items="${w.info}" var="f">
							<span class="label label-info">第${f.cls}節 ${f.cnt}/${w.select}</span>
						</c:forEach>
					</c:if>
				</td>
			</tr>
		</c:forEach>
	</table>
	<div class="panel-body">
    	<p></p>
  	</div>
	
	</div>
</form>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>成績輸入與列印</title>
	<script type="text/javascript" src="https://www.google.com/jsapi"></script>
	<script src="/eis/inc/js/plugin/bootstrap-tooltip.js"></script>
	<script src="/eis/inc/js/plugin/bootstrap-popover.js"></script>
	<script>
	$(document).ready(function() {
		$('.help').popover("show");
		setTimeout(function() {
			$('.help').popover("hide");
		}, 5000);
	});
	
	//列印選項
	function chosRt(level, type, Oid){
		//alert(level+", "+type+", "+Oid);
		if(level=="m"){
			//期中
			if(type==""){window.location.href ="/CIS/Print/teacher/NorRat.do?level=m&dtimeOid="+Oid;}
			if(type=="e"){window.location.href ="/CIS/Print/teacher/EngRat.do?level=m&dtimeOid="+Oid;}
			if(type=="s"){window.location.href ="/CIS/Print/teacher/SpoRat.do?level=m&dtimeOid="+Oid;}
		}else{
			if(type==""){window.location.href ="/CIS/Print/teacher/NorRat.do?level=f&dtimeOid="+Oid;}
			if(type=="e"){window.location.href ="/CIS/Print/teacher/EngRat.do?level=f&dtimeOid="+Oid;}
			if(type=="s"){window.location.href ="/CIS/Print/teacher/SpoRat.do?level=f&dtimeOid="+Oid;}
		}
	}
	
	function cho(Oid, type){
		$("#Dtime_oid").val(Oid);
		$("#type").val(type);
	}
	
	
	
	google.load("visualization", "1", {packages:["corechart"]});
	google.setOnLoadCallback(drawVisualization);

	function drawVisualization() {
	  var data = google.visualization.arrayToDataTable([
	    ['班級',  '期中考', '期末考','第1次平時', '第2次平時', '第3次平時', '第4次平時', '第5次平時', '第6次平時', '第7次平時', '第8次', '第9次', '第10次']
	    <c:forEach items="${myClass}" var="c">
	    ,['${c.ClassName}${c.chi_name}',
	      ${c.score2}, ${c.score3}, 
	      ${c.score01}, ${c.score02}, 
	      ${c.score03}, ${c.score04}, 
	      ${c.score05}, ${c.score06}, 
	      ${c.score07}, ${c.score08}, 
	      ${c.score09}, ${c.score10}]
	    </c:forEach>
	  ]);

	  var options = {
		title: '成績趨勢',
		chartArea:{left:50, top:10, height:"85%", width:"85%"},
		vAxis: {minValue:30, format:'#'},
		fontSize:10,
	    //vAxis: {title: "Cups"},
	    //hAxis: {title: "Month"},
	    seriesType: "bars",
	    series: {0: {type: "line"}, 1: {type: "line"}}
	  };

	  var chart = new google.visualization.ComboChart(document.getElementById('chart_div'));
	  chart.draw(data, options);
	}
	</script>
</head>
<body>
<div class="alert">
編輯期間自開學起, <b>期中考</b>至<fmt:formatDate pattern="M月d日H時m分" value="${date_exam_mid}"/>前, <b>期末考</b>至<fmt:formatDate pattern="M月d日H時m分" value="${date_exam_fin}"/>前<c:if test="${school_term eq'2'}">, <b>畢業考</b>至<fmt:formatDate pattern="M月d日H時m分" value="${date_exam_grad}"/>前</c:if>
</div>
<c:if test="${showChart}">
<table class="table table-bordered">
	<tr>
		<td>
		<p><span class="label label-inverse">成績趨勢</span>&nbsp;<button rel="popover" title="說明" data-content="曲線圖為期中期末考試, 長條圖為平時考試" data-placement="right" class="btn btn-warning btn-mini help" type="button">?</button></p>
		<div id="chart_div" style="width:100%; height:200px;"></div>
		</td>
	</tr>
</table>
</c:if>
<form action="ScoreManager" method="post" class="form-horizontal" >
<table class="table">
	<tr>
		<td nowrap>開課班級</td>
		<td nowrap>課程名稱</td>
		<td>星期節次地點</td>
		<td width="100%">編輯與列印
		<input type="hidden" name="Dtime_oid" id="Dtime_oid" />
		<input type="hidden" name="type" id="type" />
		</td>		
	</tr>
	<c:forEach items="${myClass}" var="m">	
	<tr>
		<td nowrap>${m.ClassName}<br><font size="-1">${m.dtimeClass}</font></td>
		<td nowrap>${m.chi_name}</td>
		<td nowrap>
		<c:forEach items="${m.time}" var="t">
		<span class="label label-important">
	  	<c:choose>
	    <c:when test="${t.week==7}">週日</c:when>
	    <c:when test="${t.week==1}">週一</c:when>
	    <c:when test="${t.week==2}">週二</c:when>
	    <c:when test="${t.week==3}">週三</c:when>
	    <c:when test="${t.week==4}">週四</c:when>
	    <c:when test="${t.week==5}">週五</c:when>
	    <c:when test="${t.week==6}">週六</c:when>
	    <c:otherwise>週${t.week},</c:otherwise>
		</c:choose>
		</span>
	  	<span class="label label-info">${t.begin}~${t.end}節</span>
	  	<span class="label label-warning">${t.place}</span>
	  	<br>
	  	</c:forEach>
		</td>
		<td nowrap>		
		<select id="type${m.Oid}" class="upInput">
			<option <c:if test="${m.type==''}">selected</c:if> value="">一般格式</option>
			<option <c:if test="${m.type=='e'}">selected</c:if> value="e">語言中心格式</option>
			<option <c:if test="${m.type=='s'}">selected</c:if> value="s">體育室格式</option>
		</select>		
		<button type="submit" class="btn btn-success" name="method:edit" onClick="cho('${m.Oid}', $('#type${m.Oid}').val());">編輯</button>
		<button type="button" class="btn" onClick="chosRt('m', $('#type${m.Oid}').val(), '${m.Oid}');" >期中列印</button>
		<button type="button" class="btn" onClick="chosRt('f', $('#type${m.Oid}').val(), '${m.Oid}');">期末列印</button>
		</td>
	</tr>
	</c:forEach>
</table>	
</form>	
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:useBean id="now" class="java.util.Date"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>教學評量</title>
<script src="/eis/inc/js/plugin/ChartJS/ChartJS.min.js"></script>
<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<link rel="stylesheet" href="/eis/inc/css/advance/autoscale_1152.css" />
<script> 

$(document).ready(function() {		
	$('.help').popover("show");
	setTimeout(function() {
		$('.help').popover("hide");
	}, 0);
	$(".collapse").collapse();	
});

google.load("visualization", "1", {packages:["corechart"]});
google.setOnLoadCallback(drawChart);

function drawChart() {	
	var data = google.visualization.arrayToDataTable([
	    ['課程', '50為基準', '0為基準'],
	    
	    <c:forEach items="${lineData}" var="l">
	    ['${l.ClassName}${l.chi_name}', ${l.score},${l.score1}],
	    </c:forEach>
  	]);

  	var options = {
  		colors: ['#51a1c4','#dddddd'],
	    //title: 'Company Performance',
	    //hAxis: {title: '課程', titleTextStyle: {color: '#cccccc'}}
  		vAxis: {
  	        //title: 'temps (ms)',
  	        viewWindowMode: 'explicit',
  	        viewWindow: {
  	          max: 100,
  	          min: 50
  	        },
  	        gridlines: {
  	          count: 10,
  	          
  	        }
  	      }
  	};

  	var chart = new google.visualization.ColumnChart(document.getElementById('lineChart'));
  	chart.draw(data, options);
  
  //餅
  data = google.visualization.arrayToDataTable([
    ['類型', '百分比'],
    ['有效問卷${eff}份',     ${eff}],
    ['無效問卷${sam}份',      ${sam}],
    ['未填寫${cnt}份',  ${cnt}]
  ]);

  var options = {
	colors: ['#51a1c4', '#dddddd', '#ec8f6e'],
    //title: 'My Daily Activities'
  };

  chart = new google.visualization.PieChart(document.getElementById('pieChart'));
  chart.draw(data, options);
}





</script>  
</head>
<body>
<div class="bs-callout bs-callout-info" id="callout-helper-pull-navbar">
<strong>${school_year}學年第${school_term}學期</strong>教學評量期間: <small class="text-warning">${fn:substring(coansw_begin, 0, 10)} 至 ${fn:substring(coansw_end, 0, 10)}</small>

</div>

<!--div class="panel-group" id="accordion2" role="tablist" aria-multiselectable="true">
	<div class="panel panel-primary">
		<div class="panel-heading" role="tab" id="headingOne">
			<a data-toggle="collapse" style="color:#ffffff;" data-parent="#accordion2" href="#coll">點選檢視歷年資料</a>
		</div>
		<div id="coll" class="accordion-body collapse in">
			<div class="accordion-inner">			
			<table class="table">
			<tr>
				<td>學年</td>
				<td>學期</td>
				<td>開課班級</td>
				<td>科目名稱</td>
				<td>選課人數</td>
				<td>樣本數</td>
				<td>有效樣本數</td>
				<td>平均值</td>
			</tr>
			<c:forEach items="${years}" var="y">
			
			<c:forEach items="${y.coansw}" var="c">			
			<tr>
				<td>${y.school_year}</td>
				<td>${c.school_term}</td>
				<td>${c.ClassName}</td>
				<td>${c.chi_name}</td>
				<td>${c.stu_select}</td>
				<td>${c.samples}</td>
				<td>${c.effsamples}</td>
				<td>${c.avg}</td>
			</tr>
			</c:forEach>
			</c:forEach>
			</table>			
			</div>
		</div>
	</div>	
</div-->

<div class="row">
<div class="col-xs-12 col-md-4">

<div class="panel panel-primary">
  	<div class="panel-heading">問卷結果統計</div>
  	<div class="panel-body">
    	<p>藍色區塊以50為基準, 由1至5分對應60至100分</p>
    	<p>灰色區塊以0為基準, 由1至5分對應20至100分</p>
  	</div>
	<table class="table table-bordered">
		<tr>
			<td>
	
			<div id="lineChart" style="height:340px;"></div>
			
			</td>
		</tr>
	</table>
</div>

<div class="panel panel-primary">
  	<div class="panel-heading">課程列表</div>
	<table class="table">
		<tr>
			<td>開課班級</td>
			<td>課程名稱</td>
			<td>平均值</td>
		</tr>
		<c:forEach items="${lineData}" var="l">
		<tr>
			<td>${l.ClassName}</td>
			<td>${l.chi_name}</td>
			<td>${l.score}</td>
		</tr>
		</c:forEach>
	</table>
</div>


</div>

<div class="col-xs-12 col-md-4">
<div class="panel panel-primary">
  	<div class="panel-heading">問卷題目作答分析</div>
  	<div class="panel-body">
    	<p>圖表已排除無效問卷, 僅顯示有效問卷</p>
    	<p>圖表中反向延伸處代表偵錯題</p>
  	</div>
	<table class="table table-bordered" style="position: relative;">
		<tr>
			<td>
			<div class="input-group">
    		<span class="input-group-addon">選擇班級</span>
			<select class="form-control"onChange="changeData4Radar(this.value)">
					<c:forEach  items="${coansw}" var="c" varStatus="s">
					<option value="${s.index}">${c.ClassName}${c.chi_name}</option>
					</c:forEach>
				</select>
			</div>
			<center><canvas id="radarChart" height="300"></canvas></center>
					
			
				
					
			
			</td>
		</tr>
	</table>
</div>

<div class="panel panel-primary">
  	<div class="panel-heading">問卷題目列表</div>
	<table class="table">
		<c:forEach items="${labels}" var="l">
		<tr>
			<td nowrap><small>第${l.sequence}題</small></td>
			<td width="100%"><small>${l.question}<c:if test="${!empty l.debug}">
			<span class="label label-info">偵錯題</span></c:if></small></td>
		</tr>
		</c:forEach>
	</table>
</div>
</div>
<div class="col-xs-12 col-md-4">
<div class="panel panel-primary">
  	<div class="panel-heading">作答人數統計</div>
  	<div class="panel-body">
    	<p>藍色區塊以50為基準, 由1至5分對應60至100分</p>
    	<p>灰色區塊以0為基準, 由1至5分對應20至100分</p>
  	</div>
	<table class="table table-bordered">
		<tr>
			<td>
			<div id="pieChart" style="height:310px;"></div>
			<span class="label label-important">樣本數統計</span>
			</td>
		</tr>
	</table>
</div>

<div class="panel panel-primary">
  	<div class="panel-heading">作答人數列表</div>
  	<div class="panel-body">
    	<p>藍色區塊以50為基準, 由1至5分對應60至100分</p>
    	<p>灰色區塊以0為基準, 由1至5分對應20至100分</p>
  	</div>
	<table class="table">
		<tr>
			<td nowrap>班級</td>
			<td nowrap>課程</td>
			<td nowrap>選課</td>
			<td nowrap>樣本</td>
			<td nowrap>有效</td>
			<td nowrap>答案</td>
		</tr>
		<c:forEach items="${coansw}" var="c">
		<tr>
			<td><small>${c.ClassName}</small></td>
			<td><small>${c.chi_name}</small></td>
			<td>${c.stu_select}</td>
			<td>${c.samples}</td>
			<td>${c.effsamples}</td>
			<td nowrap><a href="/tis/Print/CoanswPrint?Oid=${c.Oid}">檢視</a></td>
		</tr>
		</c:forEach>
	</table>
</div>
</div>



</div>

<script>




var chartData= {
	labels : [<c:forEach items="${labels}" var="q">"第${q.sequence}題",</c:forEach>],
	datasets : [	            
		{
			fillColor : "rgba(220,220,220,0.2)",
			strokeColor : "${coansw[0].color}",
			pointColor : "${coansw[0].color}",
			pointStrokeColor : "${coansw[0].color}",
			data : [${coansw[0].coansw}]
		}
	]
}

var chart = new Chart(document.getElementById("radarChart").getContext("2d")).Radar(chartData,{
	scaleShowLabels:true, 
	pointLabelFontSize:12, 
	//angleLineWidth:1, 
	//pointDotRadius:1, 
	//datasetStrokeWidth:1
});



var ds=[
<c:forEach  items="${coansw}" var="c" varStatus="s">
 	{
		labels : [<c:forEach items="${labels}" var="q">"第${q.sequence}題",</c:forEach>],		
		datasets : [			            
			{
				fillColor : "rgba(220,220,220,0.2)",
				strokeColor : "${c.color}",
				pointColor : "${c.color}",
				pointStrokeColor : "${c.color}",
				data : [${c.coansw}]
			}				
		]
	},
</c:forEach>
]

function changeData4Radar(i){	
	chart = new Chart(document.getElementById("radarChart").getContext("2d")).Radar(ds[i],{
		//scaleOverlay : true,
		//scaleOverride : true,
		//animation : false,
		scaleShowLabels:true, 
		pointLabelFontSize:12, 
		//angleLineWidth:2, 
		//pointDotRadius:2, 
		//datasetStrokeWidth:2
	});
}
</script>
</body>
</html>
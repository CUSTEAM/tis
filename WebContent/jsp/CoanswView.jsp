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
<script src="/eis/inc/js/plugin/ChartJS/Chart2.6.min.js"></script>
<script src="/eis/inc/js/plugin/ChartJS/Chart2.6.BgColor.js"></script>
<script src="/eis/inc/js/plugin/ChartJS/Chart2.6.LnColor.js"></script>
<link rel="stylesheet" href="/eis/inc/css/advance/autoscale_1152.css" />
<script> 

$(document).ready(function() {		
	$('.help').popover("show");
	setTimeout(function() {
		$('.help').popover("hide");
	}, 0);
	$(".collapse").collapse();	
});



</script>  
</head>
<body>
<div class="bs-callout bs-callout-info" id="callout-helper-pull-navbar">
<strong>${school_year}學年第${school_term}學期</strong>教學評量期間: <small class="text-warning">${fn:substring(coansw_begin, 0, 10)} 至 ${fn:substring(coansw_end, 0, 10)}</small>

</div>

<div class="panel-group" id="accordion2" role="tablist" aria-multiselectable="true">
	<div class="panel panel-primary">
		<div class="panel-heading" role="tab" id="headingOne">
			<a data-toggle="collapse" style="color:#ffffff;" data-parent="#accordion2" href="#coll">點選檢視歷年資料</a>
		</div>
		
		<table class="table">
			<tr><td><span class="label label-as-badge label-warning">1</span> 僅採用有效問卷統計</td></tr>
			<tr><td><span class="label label-as-badge label-danger">2</span> 將各科目原始平均值1至5分對應20至100分</td></tr>
			<tr><td><span class="label label-as-badge label-danger">3</span> 作答人數列表提供問卷原始資料下載</td></tr>
		</table>
		
		
		<div id="coll" class="accordion-body collapse in">
			<div class="accordion-inner">
			
						
			<table class="table">
			<tr>
				<td>學年</td>
				<td>學期</td>
				<td>開課班級</td>
				<td>科目名稱</td>
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
				<td>${c.samples}</td>
				<td>${c.effsamples}</td>
				<td>${c.avg0}</td>
			</tr>
			</c:forEach>
			</c:forEach>
			</table>			
			</div>
		</div>
	</div>	
</div>

<div class="row">
<div class="col-xs-12 col-md-4">

<div class="panel panel-primary">
  	<div class="panel-heading">問卷結果統計</div>
  	<div class="panel-body">    	
  		<p>點選與藍色區塊顯示班級課程名稱</p>
  	</div>
	<table class="table table-bordered">
		<tr>
			<td>
			<canvas id="lineChart" height="150"></canvas>			
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
    	<div class="input-group">
    		<span class="input-group-addon">選擇班級</span>
			<select class="form-control"onChange="changeData4Radar(this.value)">
				<c:forEach  items="${coansw}" var="c" varStatus="s">
				<option value="${s.index}">${c.ClassName}${c.chi_name}</option>
				</c:forEach>
			</select>
		</div>
  	</div>
  	<table class="table table-bordered"><tr><td><canvas id="radarChart" height="150"></canvas></td></tr></table>
</div>
	


<div class="panel panel-primary">
  	<div class="panel-heading">問卷題目列表</div>
	<table class="table">
		<c:forEach items="${labels}" var="l">
		<tr>
			<td nowrap><small>第${l.sequence}題</small></td>
			<td width="100%"><small>${l.question}<c:if test="${!empty l.debug}">
			<span class="label label-danger">偵錯題</span></c:if></small></td>
		</tr>
		</c:forEach>
	</table>
</div>
</div>
<div class="col-xs-12 col-md-4">
<div class="panel panel-primary">
  	<div class="panel-heading">作答人數統計</div>
  	<div class="panel-body">
    	<p>有效問卷: ${eff}, 無效: ${sam}, 未作答: ${cnt}</p>
  	</div>
	<table class="table table-bordered">
		<tr>
			<td>
			
			<canvas id="pieChart" height="150"></canvas>
			</td>
		</tr>
	</table>
</div>

<div class="panel panel-primary">
  	<div class="panel-heading">作答人數列表</div>
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
//bar
var ctx = document.getElementById("lineChart");
var chart = new Chart(ctx, {
    //type: 'horizontalBar',    
    type: 'bar',
    data: { 
    	labels: [
    	<c:forEach items="${lineData}" var="l">
    	"${l.ClassName},${l.chi_name}",
    	</c:forEach>],        
        datasets: [{
            label: '平均值',            
            backgroundColor:[<c:forEach items="${lineData}">"rgba(46,109,164, 0.7)",</c:forEach>],
            borderColor:[<c:forEach items="${lineData}">"rgba(46,109,164, 1)",</c:forEach>],
            data: [<c:forEach items="${lineData}" var="l">${l.score},</c:forEach>],               
            borderWidth: 1
        }]
    },
    options: {
    	//responsive: true,
    	scales: {
            yAxes: [{
                ticks: {
                    beginAtZero:false,
                    //display: false,
                    //mirror:false,
                    stepSize: 5,
                    suggestedMin: 50,
                    suggestedMax: 100,
                }
            }],
    
            xAxes: [{
                display: false,
                //barPercentage: 0.4,
                //barThickness : 73,
            }],
            
        },
    
        legend: { 
            display: false 
        },
        responsive: true,
      
    }
});

//radar
ctx = document.getElementById("radarChart");
chart = new Chart(ctx, { 
    type: 'radar',
    data: { 
    	labels: [<c:forEach items="${labels}" var="q">"第${q.sequence}題",</c:forEach>],
        datasets: [{
            label: '平均值',            
            backgroundColor:["rgba(46,109,164, 0.7)",],
            borderColor:["rgba(46,109,164, 1)",],
            data: [${coansw[0].coansw}],
            borderWidth: 1
        }]
    },
    options: {    
        legend: { 
            display: false 
        },      
    }
});
var ds=[
<c:forEach items="${coansw}" var="c" varStatus="s">
 	{ 	
	 	labels: [<c:forEach items="${labels}" var="q">"第${q.sequence}題",</c:forEach>],
	    datasets: [{
	        label: '平均值',            
	        backgroundColor:["rgba(46,109,164, 0.7)",],
	        borderColor:["rgba(46,109,164, 1)",],
	        data: [${c.coansw}],
	        borderWidth: 1
	    }]
	},
</c:forEach>
]

function changeData4Radar(i){	
	ctx = document.getElementById("radarChart");
	chart = new Chart(ctx, { 
	    type: 'radar',
	    data: ds[i],
	    options: {    
	        legend: { 
	            display: false 
	        },      
	    }
	});
}

//pie
ctx = document.getElementById("pieChart");
chart = new Chart(ctx, { 
    type: 'polarArea',    
    data:{ 
    	datasets: [{
            data: [${eff}, ${sam}, ${cnt}],
            //backgroundColor:BgColors,
            //borderColor:LnColors,
            //backgroundColor:LnColors,
            //backgroundColor:['#51a1c4', '#ec8f6e', '#dddddd']
    		backgroundColor:["rgba(81,161,196, 0.7)","rgba(236,143,110, 0.7)","rgba(221,221,221, 0.7)",],
        }],        
        labels: [
            '有效問卷',
            '無效問卷',
            '未作答'
        ]
    },
    options: {    
        legend: { 
            display: false 
        },      
    }
});
</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.util.*" %>
<c:set var="now" value="<%=new java.util.Date()%>" />
<!DOCTYPE html>
<html>
<head>
<title>點名</title>
<script src="/eis/inc/js/plugin/bootstrap-tooltip.js"></script>
<script src="/eis/inc/js/plugin/bootstrap-popover.js"></script>
</head>
<body>
&nbsp;
<div class="panel panel-primary">
	<div class="panel-heading">出席狀況</div>  	
	<table class="table table-bordered">
		<tr>
			<td>			
			<canvas id="canvas" height="40"></canvas>
			</td>
		</tr>
	</table>
</div>
<form action="RollCall" method="post">
	<input type="hidden" name="Oid" id="Oid"/>
	<input type="hidden" name="date" id="date"/>
	<input type="hidden" name="week" id="week"/>	
	<input type="hidden" id="impOid" name="impOid" />
	<input type="hidden" id="impClass" name="impClass" />		
	<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
  		<div class="panel panel-primary">
    		<div class="panel-heading" role="tab" id="headingOne">
      			<h4 class="panel-title"><a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">${fn:substring(oldweeks[0].date, 5, 10)} 至今</a></h4>
    		</div>
		    <div id="collapseOne" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
		      	<div class="panel-body">
			    	<p><strong>${school_year}學年第${school_term}學期上課期間:</strong> <small class="text-warning">${fn:substring(school_term_begin, 0, 10)} 至 ${fn:substring(school_term_end, 0, 10)}</small>
					<strong>點名期間:</strong> <small class="text-warning">${fn:substring(rollcall_begin, 0, 10)} 至 ${fn:substring(rollcall_end, 0, 10)}</small></p>
			  	</div>
			  	
		      	<table class="table table-bordered table-striped">
					<tr>
						<th>日期</th>						
						<th>班級/節次</th>
						<th nowrap>課程編號/名稱</th>
						<th nowrap>				
							<div class="btn-group">
			                <button class="btn btn-default dropdown-toggle" data-toggle="dropdown">點名單列印 <span class="icon-user"></span></button>
			                <ul class="dropdown-menu">
			                <c:forEach items="${myCs}" var="ms">
			                  <li><a href="Print/RoolCallTable?Oid=${ms.Oid}">${ms.ClassName}-${ms.chi_name}</a></li>
			                </c:forEach>
			                </ul>
			              </div><!-- /btn-group -->
						</th>
						<th><a class="quick-btn"><small>應到</small><span class="label label-default"><small>未到</small></span></a></th>
					</tr>
					
					
					<c:if test="${empty weeks}">
						<tr>
							<td colspan="6"><p class="text-error">新學期尚未開始</p></td>
						</tr>
					</c:if>
					
					<c:forEach items="${weeks}" var="w" varStatus="i">
					
					<c:if test="${!empty w.week}">
					<c:if test="${empty w.Oid}">					
						<tr>
							<td nowrap>${fn:substring(w.date, 5, 10)}</td>							
							<td nowrap>${w.ClassName}</td>
							<td>${w.chi_name}</td>
							<td>	
							<div class="btn-group" role="group" aria-label="...">			
							<input type="submit" onClick="$('#Oid').val('${w.dOid}'),$('#date').val('${w.date}'),$('#week').val('${w.week}')" name="method:callOne" value="點名" class="btn btn-default"/>
							<input type="submit" onClick="$('#Oid').val('${w.dOid}'),$('#date').val('${w.date}'),$('#week').val('${w.week}')" name="method:callAll" value="到齊" class="btn btn-success"/>
							</div>
							</td>
							<td>
							<c:if test="${!w.log}">
							<button class="btn btn-danger" onClick="$('#Oid').val('${w.dOid}'),$('#date').val('${w.date}'),$('#week').val('${w.week}')" name="method:callOne">尚未編輯 <span class="badge">${w.select}</span></button>
							</c:if> 
							<c:if test="${w.log && empty w.info}"><span class="label label-success">全班到齊!</span></c:if> 
							<c:if test="${w.log &&!empty w.info}">
							<c:forEach items="${w.info}" var="f">
								<span class="label label-primary">第${f.cls}節${f.cnt}/${w.select}</span>
							</c:forEach>
							</c:if>
							</td>
						</tr>	
								
					</c:if>
					
					
					<c:if test="${!empty w.Oid}">
						<tr>
							<td nowrap width="1">										
							<div class="mydate-icon">
								<span class="binds"></span>
								<span class="month"><fmt:formatDate value="${w.showDate}" pattern="M" />月</span>
								<div class="box">
								<div class="monthday"><fmt:formatDate value="${w.showDate}" pattern="d" /></div>
								<div class="weekday">${w.shoWeek}</div>
								</div>
								
							</div>							
							</td>
							<td width="200"><small>${w.begin}至${w.end}節</small><br>${w.ClassName}</td>
							<td><small>${w.dOid}</small><br>${w.chi_name}</td>
							<td nowrap width="250">	
							<div class="btn-group" role="group" aria-label="...">			
							<input type="submit" <c:if test="${now>date_rollcall_end}">disabled</c:if> onClick="$('#Oid').val('${w.dOid}'),$('#date').val('${w.date}'),$('#week').val('${w.week}')" name="method:callOne" value="點名" class="btn btn-default"/>
							<input type="submit" onClick="$('#Oid').val('${w.dOid}'),$('#date').val('${w.date}'),$('#week').val('${w.week}')" name="method:callAll" value="到齊" class="btn btn-success"/>
							</div>
							<c:if test="${!empty w.weather}">
							<button type="button" id="w${i.index}" class="winfo btn btn-default" data-toggle="popover" 
							title="${w.weather.ftime}" data-placement="left" data-content="${w.weather.text}, 氣溫${w.weather.temp_c}°, 體感${w.weather.feelslike_c}°, 溼度${w.weather.humidity}%, 風向${w.weather.wind_dir}, 風速${w.weather.wind_kph}kph, 雲量${w.weather.cloud}%, 降雨量 ${w.weather.precip_mm}mm">
							<img height="22" src="/eis/img/icon/weather/${w.weather.icon}"/>
							</button>
							</c:if>
							
							<c:if test="${!empty w.nextw}">
							<button type="button" class="winfo btn btn-default" data-toggle="popover" 
							title="${w.nextw.ftime}" data-placement="right" data-content="${w.nextw.text}, 氣溫${w.nextw.temp_c}°, 體感${w.nextw.feelslike_c}°">
							<img height="22" src="/eis/img/icon/weather/${w.nextw.icon}"/>
							</button>
							</c:if>
							
							</td>
							<td nowrap>
							
							<c:if test="${!w.log}">
							<button class="btn btn-danger btn-lg" onClick="$('#Oid').val('${w.dOid}'),$('#date').val('${w.date}'),$('#week').val('${w.week}')" name="method:callOne">尚未編輯 <span class="badge">${w.select}</span></button>
							</c:if> 
							<c:if test="${w.log && empty w.info}"><a class="quick-btn">${w.select}<span class="label label-primary">0</span></a></c:if> 
							<c:if test="${w.log &&!empty w.info}">
							<c:forEach items="${w.info}" var="f">
								<!--span class="label label-primary">第${f.cls}節${f.cnt}/${w.select}</span-->
							<a class="quick-btn">${w.select}<span class="label label-danger">${f.cnt}</span></a>
							</c:forEach>
							</c:if>
							</td>
						</tr>
					</c:if>
					</c:if>
					
					
					
					
					<c:if test="${empty w.week}">
					<!-- 重大集會 -->	
						<tr>
							<td nowrap>${fn:substring(w.date, 5, 10)}</td>
							
							<td nowrap>${w.ClassName}</td>
							<td>${w.chi_name}</td>
							<td>	
							<button name="method:impCall" onClick="$('#impOid').val('${w.Oid}'),$('#impClass').val('${w.ClassNo}')" class="btn btn-warning">重大集會點名</button>
							</td>
							<td>
							<c:if test="${!empty w.edit}"><span class="glyphicon glyphicon-cloud-upload" aria-hidden="true"></span> ${w.edit}</c:if>
							
							</td>
						</tr>
						</c:if>
					</c:forEach>
					
				</table>
		    </div>
  		</div>
  		
  		<div class="panel panel-primary">
    		<div class="panel-heading" role="tab" id="headingTwo">
      			<h4 class="panel-title">
        			<a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
        			${fn:substring(school_term_begin, 5, 10)} 至 ${fn:substring(oldweeks[0].date, 5, 10)}
        			<button class="btn btn-default btn-xs"><span class="glyphicon glyphicon-hand-down" aria-hidden="true"></span> 請點選查看全部記錄</button></a>
      			</h4>
    		</div>
    		<div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
      			
      			<table class="table table-bordered table-striped">
					<tr>
						<th>日期</th>						
						<th>班級</th>
						<th nowrap>課程名稱</th>
						<th nowrap>				
							<div class="btn-group">
			                <button class="btn btn-default dropdown-toggle" data-toggle="dropdown">點名單列印 <span class="icon-user"></span></button>
			                <ul class="dropdown-menu">
			                <c:forEach items="${myCs}" var="ms">
			                  <li><a href="Print/RoolCallTable?Oid=${ms.Oid}">${ms.ClassName}-${ms.chi_name}</a></li>
			                </c:forEach>
			                </ul>
			              </div><!-- /btn-group -->
						</th>
						<th><a class="quick-btn"><small>應到</small><span class="label label-default"><small>未到</small></span></a></th>
					</tr>
					
					
					
					
					<c:forEach items="${oldweeks}" var="w">
						<tr>
							<td>${fn:substring(w.date, 5, 10)}</td>
							<td><small>${w.begin}至${w.end}節</small><br>${w.ClassName}</td>
							<td>${w.dOid}<br>${w.chi_name}</td>
							<td>
								<div class="btn-group" role="group" aria-label="...">
								<input type="submit" name="method:viewOne" onClick="$('#Oid').val('${w.dOid}'),$('#date').val('${w.date}'),$('#week').val('${w.week}')" class="btn btn-default" value="檢視">
								<input type="button" class="btn btn-success" value="到齊" disabled>
								</div>
								<c:if test="${!empty w.weather}">
								<button type="button" class="winfo btn btn-default" data-toggle="popover" 
								title="${w.weather.ftime}" data-placement="left" data-content="${w.weather.text}, 氣溫${w.weather.temp_c}°, 體感${w.weather.feelslike_c}°, 溼度${w.weather.humidity}%, 風向${w.weather.wind_dir}, 風速${w.weather.wind_kph}kph, 雲量${w.weather.cloud}%, 降雨量 ${w.weather.precip_mm}mm">
								<img height="22" src="/eis/img/icon/weather/${w.weather.icon}"/>
								</button>
								</c:if>
							</td>
							<td>
							<c:if test="${!w.log}"><button class="btn btn-link" type="button">尚未編輯 <span class="badge">${w.select}</span></button></c:if> 
								<c:if test="${w.log && empty w.info}"><a class="quick-btn">${w.select}<span class="label label-primary">0</span></a></c:if> 
								<c:if test="${w.log &&!empty w.info}">
									<c:forEach items="${w.info}" var="f">
										<a class="quick-btn">${w.select}<span class="label label-default">${f.cnt}</span></a>
									</c:forEach>
								</c:if>
							</td>
						</tr>
					</c:forEach>
				</table>
    		</div>
  		</div>
  
	</div>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
</form>
<script src="/eis/inc/js/plugin/ChartJS/Chart2.6.min.js"></script>
<script src="/eis/inc/js/plugin/ChartJS/Chart2.6.BgColor.js"></script>
<script src="/eis/inc/js/plugin/ChartJS/Chart2.6.LnColor.js"></script>
<script>
$(document).ready(function() {
	
	$('.winfo').popover("show");
	//$('#funInfo').popover("show");
	setTimeout(function() {
		$('.winfo').popover("hide");
		//$('#funbtn').popover("hide");
	}, 0);
	
	
	var ctx = document.getElementById("canvas").getContext("2d");
    ctx.height = 150;
       //ctx.canvas.parentNode.style.height = '128px';
       
	window.myLine = Chart.Line(ctx, {
    	data: lineChartData,
    	options: {
    		responsive: true,
    		hoverMode: 'index',
    		stacked: false,	
    		
            /*title:{
                display: true,
                text:'出席率'
            },*/
            /*scales: {
                yAxes: [{
                    type: "linear", // only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
                    display: true,
                    position: "left",
                    id: "y-axis-1",
                }, {
                    type: "linear", // only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
                    display: true,
                    position: "right",
                    id: "y-axis-2",

                    // grid line settings
                    gridLines: {
                        drawOnChartArea: false, // only want the grid lines for one axis to show up
                    },
                }],
            }*/
    	}
	});
	
});
 
var lineChartData={ 
labels:[<c:forEach begin="1" end="18" var="w">"第${w}週", </c:forEach>],		  
     datasets: [
     	<c:forEach items="${chart}" var="c" varStatus="i">
     	{
         label: "${c.ClassName}-${c.chi_name}",
         	borderColor: LnColors[${i.index}],
         	backgroundColor: BgColors[${i.index}],
         	borderWidth : 1,
         	fill: false,
         	data: [<c:forEach items="${c.hist}" var="h">${h.par}, </c:forEach>],
         	//yAxisID: "y-axis-1",
     	}, 
     	</c:forEach> 
]};
</script>
</body>
</html>
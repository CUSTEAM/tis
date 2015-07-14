<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="/eis/inc/css/advance/time.css" />
<script src="/eis/inc/js/develop/stdinfo.js"></script>
<script src="/eis/inc/js/develop/timeInfo.js"></script>
<!-- script src="/eis/inc/js/advance-form-check-leave.js"></script-->
<script src="/eis/inc/js/plugin/holder/holder.min.js"></script>
<script>
$(document).ready(function() {
	/*$('.q').popover("show");
	setTimeout(function() {
		$('.q').popover("hide");
	}, 0);*/
	<c:if test="${fn:length(tu)>0}">
	
	showInfo('${tu[0].ClassNo}', '${tu[0].ClassNo}');
	//alert('#profile${tu[0].ClassNo}');
	//$("#profile${tu[0].ClassNo}").show();	
	//$("#profile${tu[0].ClassNo}").html("<tr><td>hello</td></tr>");	
	//alert($("#profile${tu[0].ClassNo}").html());
	//$("#myTab a[href='#profile${tu[0].ClassNo}']").tab('show'); 
	$('#myTab a:first').tab('show');
	//$('#myTab li:eq(0) a').tab('show'); 
	</c:if>
	<c:if test="${fn:length(cs)>0}">
	
	showInfo('${cs[0].Oid}', '${cs[0].ClassNo}');
	$('#myTab a:first').tab('show');
	</c:if>
	
	
});



function showInfo(id, ClassNo){
	$.ajax({
		url:"/pis/getClsEvent",
	    dataType: 'jsonp',
	    jsonp:'back',          //jsonp請求方法
	    data:{ClassNo:ClassNo},
	    cache:false,
	    type:'POST',
	    success: function(d) {
	    	callback(id, d);
	    }
	});
	
}

function callback(id, data){
	info="";
	if(data.list.length<1){
		info="<tr><td><h2>班級無曠課記錄</h2></td></tr>";
	}else{
		for(i=0; i<data.list.length; i++){
			info+="<tr><td><img width='75' src='/eis/getStdimage?myStdNo="+data.list[i].student_no+"'></td>"+
			
			"<td nowrap>"+
			data.list[i].student_no+"<br>"+
			data.list[i].student_name+
			" <div class='btn-group'> <a class='btn btn-mini dropdown-toggle' data-toggle='dropdown' href='#'><i class='icon-list' style='margin-top: 1px;'></i></a><ul class='dropdown-menu'> <li><a href='#stdInfo' data-toggle='modal' onClick=\"getStudentTime('"+data.list[i].student_no+"', '"+data.list[i].student_name+"')\">本學期課表</a></li> <li><a href='#stdInfo' data-toggle='modal' onClick=\"getDilgInfo('"+data.list[i].student_no+"', '"+data.list[i].student_name+"', '')\">所有課程缺課記錄</a></li> <li><a href='#stdInfo' data-toggle='modal' onClick=\"getStdContectInfo('"+data.list[i].student_no+"', '"+data.list[i].student_name+"')\">連絡資訊</a></li> <li><a href='#stdInfo' data-toggle='modal' onClick=\"getStdScoreInfo('"+data.list[i].student_no+"', '"+data.list[i].student_name+"')\">歷年成績</a></li> <li><a href='/CIS/Portfolio/ListMyStudents.do' target='_blank'>學習歷程檔案</a></li></ul></div><br><small>"+data.list[i].date+
			"</small></td><td width='100%'>增加<span class='label label-warning'>"+data.list[i].cnt+"</span> <span class='label label-important'>="+data.list[i].tot+"</span></h2></td></tr>";
			
					
		
		
		
		}
	}
	
	$("#t"+id).html(info);
}


</script>
<title>班級缺曠動態</title>
</head>
<body>

	<form action="CareForStudents" method="post">
		<ul id="myTab" class="nav nav-tabs">
			
			<c:if test="${fn:length(tu)>0}">
			<c:forEach items="${tu}" var="t">
			<li>
				<a href="#profile${t.ClassNo}" data-toggle="tab" 
				onClick="showInfo('${t.ClassNo}', '${t.ClassNo}')">
				${t.ClassName}				
				</a>
			</li>
			</c:forEach>			
			<li class="dropdown"><a href="#" class="dropdown-toggle"
				data-toggle="dropdown">任課班級 <b class="caret"></b></a>
				<ul class="dropdown-menu">
					<c:forEach items="${cs}" var="c">
					<li><a href="#profile${c.Oid}" data-toggle="tab" 
					onClick="showInfo('${c.Oid}', '${c.ClassNo}')">${c.ClassName}, ${c.chi_name}</a>
					</li>
					</c:forEach>
				</ul>
			</li>
			</c:if>
			
			<c:if test="${fn:length(tu)<1}">
			<c:forEach items="${cs}" var="c">
					<li><a href="#profile${c.Oid}" data-toggle="tab" 
					onClick="showInfo('${c.Oid}', '${c.ClassNo}')">${c.ClassName}, ${c.chi_name}</a>
					</li>
			</c:forEach>
			</c:if>
		</ul>		
		
		
		
		<div id="myTabContent" class="tab-content">			
			<c:forEach items="${tu}" var="t" varStatus="i">
				<div class="tab-pane <c:if test="${i.index==0}">active</c:if>" id="profile${t.ClassNo}">
				<div>
					<h1>${t.ClassName} <small>導師班級</small></h1>
				</div>
				<table id="t${t.ClassNo}" class="table"></table>
				</div>
			</c:forEach>
			<c:forEach items="${cs}" var="c">
				<div class="tab-pane" id="profile${c.Oid}">
				    <div>
				      <h1>${c.ClassName} <small>${c.chi_name}</small></h1>
				    </div>				
					<table id="t${c.Oid}" class="table"></table>
				</div>
			</c:forEach>
		</div>
	</form>
	<!-- Modal -->
	<div id="stdInfo" class="modal hide fade" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal"
				aria-hidden="true">×</button>
			<h3 id="stdNameNo"></h3>
		</div>
		<div class="modal-body" id="info"></div>
		<div class="modal-footer">
			<button class="btn" data-dismiss="modal" aria-hidden="true">關閉</button>
		</div>
	</div>
</body>
</html>
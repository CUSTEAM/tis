<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/eis/inc/js/plugin/bootstrap-typeahead.js"></script>
<script src="/eis/inc/js/plugin/json2.js"></script>
<script src="/eis/inc/js/plugin/jquery-ui.js"></script>
<script src="/eis/inc/js/plugin/bootstrap-tooltip.js"></script>
<script type="text/javascript" src="/eis/inc/js/plugin/jquery-ui-timepicker-addon.js"></script>
<link rel="stylesheet" href="/eis/inc/css/jquery-ui.css" />
<title>Insert title here</title>
<script src="/eis/inc/js/develop/stdinfo.js"></script>
<script src="/eis/inc/js/develop/timeInfo.js"></script>
<script>  
$(document).ready(function() {
	$("input[id='nameno']").typeahead({
		remote:"#stdNo",
		source : [],
		items : 10,
		updateSource:function(inputVal, callback){			
			$.ajax({
				type:"POST",
				url:"/eis/autoCompleteStmd",
				dataType:"json",
				data:{length:10, nameno:inputVal},
				success:function(d){
					callback(d.list);
				}
			});
		}		
	});	
	
	$('#funbtn').popover("show");
	setTimeout(function() {
		$('#funbtn').popover("hide");
	}, 8000);
});

function showApp(filename){
    $.blockUI({ 
    	onOverlayClick: $.unblockUI,
        message: "<a href='/eis/getFtpFile?path=DilgImage&file="+filename+"'><img src='/eis/getFtpFile?path=DilgImage&file="+filename+"'/></a>", 
        css: { 
        	top:  '100px',
        } 
    });
}
</script>  
</head>
<body>
<form action="DilgApp" method="post">
	<div class="alert">
		<button type="button" class="close" data-dismiss="alert">&times;</button>
		<strong>請選擇假單列表</strong>&nbsp;
		<a href="DilgApp" class="btn">未審核假單</a>
		<a href="DilgApp?type=pass" class="btn">已審核假單</a>
		<a href="DilgApp?type=redirect" class="btn">已轉呈假單</a>
		<a href="/eis/Calendar"class="btn btn-danger">返回</a>
		<div id="funbtn" rel="popover" title="說明" data-content="已處理假單過多影響列表效能時，可利用查詢欄位尋找假單" data-placement="right" class="btn btn-warning">?</div>
	</div>
	
	<div class="alert alert-error">
	<table class="control-group error">
		<tr>
			<td>
			查詢
			<input type="text" id="begin" onClick="this.value='';" placeholder="查詢開始範圍" name="begin" value="${begin}"/>
			至
			<input type="text" id="end" onClick="this.value='';" placeholder="查詢結束範圍" name="end" value="${end}"/>
			或
			</td>
			<td>
			<div class="input-append">
				<input class="span4" onClick="$('#nameno').val(''), $('#stdNo').val('');" autocomplete="off" type="text" id="nameno" value="${nameno}" name="nameno"
				 data-provide="typeahead" onClick="addStd()" placeholder="學號姓名文字片段" />
				<input type="hidden" id="stdNo" value="${stdNo}" name="stdNo"/>
			    <button class="btn btn-danger" name="method:search" type="submit">尋找已審核假單</button>
			</div>
			</td>
		</tr>
	</table>
	</div>
	
	
	<!-- Modal -->
	<div id="stdInfo" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-header">
	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	<h3 id="stdNameNo"></h3>
	</div>
	<div class="modal-body" id="info">
	</div>
	<div class="modal-footer">
	<button class="btn" data-dismiss="modal" aria-hidden="true">關閉</button>
	</div>
	</div>
	
    <display:table pagesize="10" name="${dilgs}" id="row" class="table" sort="list" excludedParams="*" >
  	<display:column title="學生資訊"  sortable="true">
  	${row.ClassName}<br>${row.student_no}<br>${row.student_name}
  	</display:column>
  	<display:column>
  	<div class="btn-group">
    <a class="btn btn-mini dropdown-toggle" data-toggle="dropdown" href="#"><i class="icon-list" style="margin-top:1px;"></i></a>
    <ul class="dropdown-menu">
    	<li><a href="#stdInfo" data-toggle="modal" onClick="getStudentTime('${row.student_no}', '${row.student_name}')">本學期課表</a></li>
    	<li><a href="#stdInfo" data-toggle="modal" onClick="getDilgInfo('${row.student_no}', '${row.student_name}', '')">課程缺課記錄</a></li>
    	<li><a href="#stdInfo" data-toggle="modal" onClick="getStdContectInfo('${row.student_no}', '${row.student_name}')">連絡資訊</a></li>
    	<li><a href="#stdInfo" data-toggle="modal" onClick="getStdScoreInfo('${row.student_no}', '${row.student_name}')">歷年成績</a></li>
    	<li><a href="/CIS/Portfolio/ListMyStudents.do" target="_blank">學習歷程檔案</a></li>
    </ul>
    </div>
  	</display:column>
  	<display:column title="假別" property="name" sortable="true" />
	<display:column title="細節">
		<display:table name="${row.abss}">
			<display:column property="chi_name" title="課程名稱" />
			<display:column property="date" title="日期" />
			<display:column property="cls" title="節次"/>
		</display:table>
	</display:column>
	<display:column title="附件">
	<c:if test="${!empty row.file}">
	<button type="button" class="btn btn-info" onClick="showApp('${row.file}')">附件</button>
	
	</c:if>
	
	</display:column>
  	<display:column title="審核">
  	<p>原因: ${row.reason}, ${row.note}</p>
  	<input type="hidden" value="${row.Oid}" name="Oid"/>
	<select <c:if test="${param.type eq 'redirect'}">disabled</c:if> name="result" style="float:left; margin-right:5px;">
			<option value="">是否核准</option>
			<option <c:if test="${row.result eq'1'}">selected</c:if> value="1">核准</option>
			<option <c:if test="${row.result eq'2'}">selected</c:if> value="2">不核准</option>
		</select>
  	<div class="input-append">
  		
    	<input class="span3" name="reply" value="${row.reply}" type="text">    
	    <c:if test="${param.type eq 'redirect'}">
	    	<button disabled class="btn btn btn-info">已轉呈:${row.cname}</button>
	    </c:if>    
	    <c:if test="${param.type eq 'pass'}">
	    	<button name="method:checkout" type="submit" class="btn btn-info">修改審核</button>
	    </c:if>
    
	    <c:if test="${param.type==null}">
	    	<button name="method:checkout" type="submit" class="btn btn-info">評語並送出審核</button>
	    </c:if>
    </div>
  	</display:column>
</display:table>



</form>

<script>
$("input[name='begin'], input[name='end']" ).datepicker();
</script>
</body>
</html>
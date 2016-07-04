<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<style>input{ime-mode:disabled;}</style>
	<script src="/eis/inc/js/develop/stdinfo.js"></script>
	<script src="/eis/inc/js/develop/timeInfo.js"></script>
	<script src="/eis/inc/js/advance-form-check-leave.js"></script>
	<title>體育課程成績輸入</title>
</head>
<body>
<form action="ScoreManager" method="post" class="form-inline" >
<div class="bs-callout bs-callout-warning" id="callout-helper-pull-navbar">
<h4> ${csinfo.ClassName}, ${csinfo.chi_name}</h4>
輸入完成請先點選<button type="submit" class="btn btn-xs btn-danger save" name="method:save">儲存</button> 確認後再點選 <a class="btn btn-default btn-xs" href="ScoreManager">離開</a>
1.方向鍵  ↑ ↓ 能使游標垂直移動 2.計算功能為輔助,欄位可自由修改3.依各欄位顯示資料為儲存依據
</div>
<br><br><br>
<input type="hidden" name="Dtime_oid" id="Dtime_oid" value="${Dtime_oid}"/>
<input type="hidden" name="type" id="type" value="${type}"/>		
			
<table class="table">				
	<tr>
		<td>學號</td>
		<td>姓名</td>
		<td>術科成績(50%)</td>
		<td>平時成績(40%)</td>
		<td>學科成績(10%)</td>
		<td>學期成績(100%)</td>
	</tr>
	<c:forEach items="${students}" var="s" varStatus="c">
	<c:if test="${c.index%5==0&&c.index!=0}">	
	<tr >
		<td>學號</td>
		<td>姓名</td>
		<td nowrap>術科成績(50%)</td>
		<td nowrap>平時成績(40%)</td>
		<td nowrap>學科成績(10%)</td>
		<td nowrap width="100%">學期成績(100%)</td>
	</tr>	
	</c:if>
	<tr>
		<td nowrap>
		<input type="hidden" name="seldOid" value="${s.Oid}"/>
		<input type="hidden" value="${s.student_no}" name="studentNo"/>
		<input type="hidden" value="${s.student_no}" name="${m.dtimeOid}studentNo" />${s.student_no}</td>		
		<td nowrap>${s.student_name}
		<div class="btn-group btn-default">
			<button type="button" class="btn btn-xs btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true"><i class="glyphicon glyphicon-align-justify"></i></button>
			<ul class="dropdown-menu">
				<li><a href="#stdInfo" data-toggle="modal" onClick="getStudentTime('${s.student_no}', '${s.student_name}')">本學期課表</a></li>
				<li><a href="#stdInfo" data-toggle="modal" onClick="getDilgInfo('${s.student_no}', '${s.student_name}', '${Oid}')">本課程缺課記錄</a></li>
				<li><a href="#stdInfo" data-toggle="modal" onClick="getDilgInfo('${s.student_no}', '${s.student_name}', '')">所有課程缺課記錄</a></li>
				<li><a href="#stdInfo" data-toggle="modal" onClick="getStdContectInfo('${s.student_no}', '${s.student_name}')">連絡資訊</a></li>
				<li><a href="#stdInfo" data-toggle="modal" onClick="getStdScoreInfo('${s.student_no}', '${s.student_name}')">歷年成績</a></li>
				<li><a href="/CIS/Portfolio/ListMyStudents.do" target="_blank">學習歷程檔案</a></li>									
			</ul>
		</div>
		</td>
		<td>
		<input type="text" class="form-control" size="2" name="score1" value="${s.score1}" id="${s.Oid}score1" class="span1"
		onKeyUp="if(ck(this)){ck(this); km(event, '${students[c.index+1].Oid}score1', '${students[c.index-1].Oid}score1'); 
		sum('${s.Oid}score1', '${s.Oid}score2', '${s.Oid}score3', '${s.Oid}score')}"/>
		</td>
		
		<td >
		<input type="text" class="form-control" size="2" name="score2" value="${s.score2}" id="${s.Oid}score2" class="span1"
		onKeyUp="if(ck(this)){km(event, '${students[c.index+1].Oid}score2', '${students[c.index-1].Oid}score2'); sum('${s.Oid}score1', '${s.Oid}score2', '${s.Oid}score3', '${s.Oid}score')}"/>
		</td>
		
		<td >
		<input type="text" class="form-control" size="2" name="score3" value="${s.score3}" id="${s.Oid}score3" class="span1"
		onKeyUp="if(ck(this)){km(event, '${students[c.index+1].Oid}score3', '${students[c.index-1].Oid}score3'); sum('${s.Oid}score1', '${s.Oid}score2', '${s.Oid}score3', '${s.Oid}score')}"/>
		</td>
		
		<td >
		<input type="text" class="form-control" size="2" name="score" value="${s.score}" id="${s.Oid}score" class="span1"
		onKeyUp="if(ck(this)){km(event, '${students[c.index+1].Oid}score', '${students[c.index-1].Oid}score');}" />
		</td>
	</tr>
	</c:forEach>
	<tr class="hairLineTdF" align="center">
		<td class="hairLineTdF" colspan="100">
		<button type="submit" class="btn btn-danger save" name="method:save">儲存</button>
		<a class="btn btn-default" href="ScoreManager">離開</a>
		</td>
	</tr>
</table>
</form>
<!-- Modal -->
<div class="modal fade" id="stdInfo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"
			aria-hidden="true">×</button>
		<h3 id="stdNameNo"></h3>
      </div>
      <div class="modal-body" id="info"></div>
	<div class="modal-footer">
		<button class="btn btn-primary" data-dismiss="modal" aria-hidden="true">關閉</button>
	</div>
    </div>
  </div>
</div>
<script>
$(document).ready(function() {
	<c:if test="${!empty date2}">$("input").prop("disabled", true);$(".save").prop("disabled", true);</c:if>
	$('input').attr('autocomplete','off');
	$('.elary').popover("show");	
	setTimeout(function() {		
		$('.elary').popover("hide");
	}, 5000);		
});

//補捉方向鍵和enter鍵
function km(e, nextObj, precObj){
	if(e.keyCode==38){document.getElementById(precObj).focus();}
	if(e.keyCode==40){document.getElementById(nextObj).focus();}
}

var re = /^[0-9]+$/;
function ck(obj){
	if(obj.value=="")return true;
 	if (!re.test(obj.value)){obj.value=""; return false;}
 	if (parseInt(obj.value)>100){obj.value=""; return false;}
 	return true;
}

function sum(score1, score2, score3, score){
	score1=document.getElementById(score1);
	score2=document.getElementById(score2);
	score3=document.getElementById(score3);
	score=document.getElementById(score);
	score.value=Math.round((score1.value*0.5)+(score2.value*0.4)+(score3.value*0.1));
}
</script>
</body>
</html>
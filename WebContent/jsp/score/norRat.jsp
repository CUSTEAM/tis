<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>一般課程成績輸入</title>
	<style>input{ime-mode:disabled;}</style>
	<script src="/eis/inc/js/develop/stdinfo.js"></script>
	<script src="/eis/inc/js/develop/timeInfo.js"></script>
	<script src="/eis/inc/js/advance-form-check-leave.js"></script>
</head>
<body>
<form action="ScoreManager" method="post" class="form-inline">
<div class="bs-callout bs-callout-warning" id="callout-helper-pull-navbar">
<h4> ${csinfo.ClassName}, ${csinfo.chi_name}</h4>
輸入完成請先點選<button type="submit" class="btn btn-xs btn-danger" name="method:save">儲存</button> 確認後再點選 <a class="btn btn-default btn-xs" href="ScoreManager">離開</a>
1.方向鍵  ↑ ↓ 能使游標垂直移動 2.計算功能為輔助,欄位可自由修改3.依各欄位顯示資料為儲存依據
</div>
<input type="hidden" name="Dtime_oid" id="Dtime_oid" value="${Dtime_oid}"/>
<input type="hidden" name="type" id="type" value="${type}"/>
<table class="table table-striped table-hover" id="class${e.Oid}">
	<tr>
		<td></td>
		<td></td>
		<td align="right"><span class="label label-warning">成績比例</span></td>
		<td><div class="input-group"><input type="text" size="2" class="form-control" id="p1" name="p1" class="span1 editPro" <c:if test="${!empty edper}">readonly</c:if> value="${seldpro.score1}"/><span class="input-group-addon" id="basic-addon2">%</span></div></td>
		<td><div class="input-group"><input type="text" size="2" class="form-control" id="p2" name="p2" class="span1 editPro" <c:if test="${!empty edper}">readonly</c:if> value="${seldpro.score2}"/><span class="input-group-addon" id="basic-addon2">%</span></div></td>
		<td><div class="input-group"><input type="text" size="2" class="form-control" id="p3" name="p3" class="span1 editPro" <c:if test="${!empty edper}">readonly</c:if> value="${seldpro.score3}"/><span class="input-group-addon" id="basic-addon2">%</span></div>	
		</td>
		<td>
		<c:if test="${empty edper}">		
		<button type="submit" id="editPro" class="btn btn-success" name="method:editPro">儲存</button>
		</c:if>
		<c:if test="${!empty edper}"><p class="text-error"><small>${edper}<br>截止變更比例</small></p></c:if>
		</td>
	</tr>
	<tr>
		<td nowrap>學號</td>
		<td nowrap>姓名</td>
		<td nowrap>平時考  <button type="button" class="btn btn-sm btn-success" onClick="showall();">其餘5次</button></td>
		<td nowrap>平時成績</td>
		<td nowrap>期中考</td>
		<td nowrap>期末考</td>
		<td nowrap>總成績</td>
	</tr>	
	<c:forEach items="${students}" var="s" varStatus="c">
	<c:if test="${c.index%5==0&&c.index!=0}">	
	<tr>		
		<td nowrap>學號</td>
		<td nowrap>姓名</td>
		<td nowrap>平時考</td>
		<td nowrap>平時成績</td>		
		<td nowrap>期中考</td>
		<td nowrap>期末考</td>
		<td nowrap>總成績</td>
	</tr>	
	</c:if>				
	<tr class="hairLineTdF">
		<td id="stImage${s.student_no}" nowrap>${s.student_no}</td>
		<td id="stImage${s.student_no}" nowrap>${s.student_name}
		<div class="btn-group btn-default">
			<button type="button" class="btn btn-default btn-xs dropdown-toggle" data-toggle="dropdown" aria-haspopup="true"><i class="glyphicon glyphicon-align-justify" style="margin-top: 1px;"></i></button>
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
		<td nowrap>
		<input type="hidden" name="seldOid" value="${s.Oid}" />		
		<input type="text" class="form-control" size="2" name="score01"  id="score01${s.Oid}" value="${s.score01}" class="span1" onKeyUp="if(ck(this)){ck(this); km(event, 'score01${students[c.index+1].Oid}', 'score01${students[c.index-1].Oid}'); countScore('${s.Oid}')}"/>
		<input type="text" class="form-control" size="2" name="score02"  id="score02${s.Oid}" value="${s.score02}" class="span1" onKeyUp="if(ck(this)){km(event, 'score02${students[c.index+1].Oid}', 'score02${students[c.index-1].Oid}'); countScore('${s.Oid}')}"/>
		<input type="text" class="form-control" size="2" name="score03"  id="score03${s.Oid}" value="${s.score03}" class="span1" onKeyUp="if(ck(this)){km(event, 'score03${students[c.index+1].Oid}', 'score03${students[c.index-1].Oid}'); countScore('${s.Oid}')}"/>
		<input type="text" class="form-control" size="2" name="score04"  id="score04${s.Oid}" value="${s.score04}" class="span1" onKeyUp="if(ck(this)){km(event, 'score04${students[c.index+1].Oid}', 'score04${students[c.index-1].Oid}'); countScore('${s.Oid}')}"/>
		<input type="text" class="form-control" size="2" name="score05"  id="score05${s.Oid}" value="${s.score05}" class="span1" onKeyUp="if(ck(this)){km(event, 'score05${students[c.index+1].Oid}', 'score05${students[c.index-1].Oid}');countScore('${s.Oid}')}"/>
		<span class="next5">
		<input type="text" class="form-control" size="2" class="form-control" name="score06"  id="score06${s.Oid}" value="${s.score06}" class="span1" onKeyUp="if(ck(this)){km(event, 'score06${students[c.index+1].Oid}', 'score06${students[c.index-1].Oid}'); countScore('${s.Oid}')}"/>
		<input type="text" class="form-control" size="2" name="score07"  id="score07${s.Oid}" value="${s.score07}" class="span1" onKeyUp="if(ck(this)){km(event, 'score07${students[c.index+1].Oid}', 'score07${students[c.index-1].Oid}'); countScore('${s.Oid}')}"/>
		<input type="text" class="form-control" size="2" name="score08"  id="score08${s.Oid}" value="${s.score08}" class="span1" onKeyUp="if(ck(this)){km(event, 'score08${students[c.index+1].Oid}', 'score08${students[c.index-1].Oid}'); countScore('${s.Oid}')}"/>
		<input type="text" class="form-control" size="2" name="score09"  id="score09${s.Oid}" value="${s.score09}" class="span1" onKeyUp="if(ck(this)){km(event, 'score09${students[c.index+1].Oid}', 'score09${students[c.index-1].Oid}'); countScore('${s.Oid}')}"/>
		<input type="text" class="form-control" size="2" name="score10"  id="score10${s.Oid}" value="${s.score10}" class="span1" onKeyUp="if(ck(this)){km(event, 'score10${students[c.index+1].Oid}', 'score10${students[c.index-1].Oid}'); countScore('${s.Oid}')}"/>
		</span>
		</td>		
		<td><input type="text" class="form-control" size="2" name="score1"  id="score1${s.Oid}" value="${s.score1}" class="span1" onKeyUp="km(event, 'score1${students[c.index+1].Oid}', 'score1${students[c.index-1].Oid}'); if(ck(this)){finScore('${s.Oid}');}"/></td>
		<td><input type="text" class="form-control" size="2" name="score2" <c:if test="${!empty date1}">readonly</c:if> id="score2${s.Oid}" value="${s.score2}" class="span1"  <c:if test="${date1==null}"> onKeyUp="km(event, 'score2${students[c.index+1].Oid}', 'score2${students[c.index-1].Oid}'); if(ck(this)){finScore('${s.Oid}');}"</c:if>/></td>		
		<td><input type="text" class="form-control" size="2" name="score3"  <c:if test="${!empty date2}">readonly</c:if> id="score3${s.Oid}" value="${s.score3}" class="span1"  <c:if test="${date2==null}"> onKeyUp="km(event, 'score3${students[c.index+1].Oid}', 'score3${students[c.index-1].Oid}'); if(ck(this)){finScore('${s.Oid}');}"</c:if>/></td>		
		<td><input type="text" class="form-control" size="2" name="score"  <c:if test="${!empty date2}">readonly</c:if> id="score${s.Oid}" value="${s.score}" class="span1"  <c:if test="${date2==null}"> onKeyUp="ck(this),km(event, 'score${students[c.index+1].Oid}', 'score${students[c.index-1].Oid}');"</c:if> /></td>
	</tr>	
	</c:forEach>	
	<tr>
		<td colspan="100">
		<center>
		<button type="submit" class="btn btn-danger btn-large" name="method:save">儲存</button>
		<a class="btn btn-default btn-large" onClick="javascript: return(confirm('離開前請確認已點選儲存按鈕')); void('')" href="ScoreManager">離開</a>
		</center>
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




var p1=parseInt($("#p1").val());
var p2=parseInt($("#p2").val());
var p3=parseInt($("#p3").val());

$(document).ready(function() {
	$('input').attr('autocomplete','off');
	$('.elary').popover("show");	
	setTimeout(function() {		
		$('.elary').popover("hide");
	}, 5000);	
	$(".next5").hide("slow");	
	
	
	$(".editPro").keyup(function() {
		p1=parseInt($("#p1").val());
		p2=parseInt($("#p2").val());
		p3=parseInt($("#p3").val());
		if((p1+p2+p3)!=100){
			$("#editPro").attr("disabled", true);
		}else{
			$("#editPro").attr("disabled", false);
		}
	});	
});



//顯示或關閉多餘平時考
function showall(){
	$(".next5").show("slow");
}

//補捉方向鍵和enter鍵
function km(e, nextObj, precObj){
	if(e.keyCode==38){$("#"+precObj).focus();}
	if(e.keyCode==40){$("#"+nextObj).focus();}
}

var re = /^[0-9]+$/;
function ck(obj){
	if(obj.value=="")return true;
 	if (!re.test(obj.value)){obj.value=""; return false;}
 	if (parseInt(obj.value)>100){obj.value=""; return false;}
 	return true;
}

function countScore(Oid){
	
	score01=$("#score01"+Oid).val();	
	score02=$("#score02"+Oid).val();
	score03=$("#score03"+Oid).val();
	score04=$("#score04"+Oid).val();
	score05=$("#score05"+Oid).val();
	score06=$("#score06"+Oid).val();	
	score07=$("#score07"+Oid).val();
	score08=$("#score08"+Oid).val();
	score09=$("#score09"+Oid).val();
	score10=$("#score10"+Oid).val();
	
	counTmp=0;
	score1=0;
	
	if(score01!=""){counTmp=counTmp+1; score1=parseInt(score1)+parseInt(score01)}
	if(score02!=""){counTmp=counTmp+1; score1=parseInt(score1)+parseInt(score02)}
	if(score03!=""){counTmp=counTmp+1; score1=parseInt(score1)+parseInt(score03)}
	if(score04!=""){counTmp=counTmp+1; score1=parseInt(score1)+parseInt(score04)}
	if(score05!=""){counTmp=counTmp+1; score1=parseInt(score1)+parseInt(score05)}
	if(score06!=""){counTmp=counTmp+1; score1=parseInt(score1)+parseInt(score06)}
	
	if(score07!=""){counTmp=counTmp+1; score1=parseInt(score1)+parseInt(score07)}
	if(score08!=""){counTmp=counTmp+1; score1=parseInt(score1)+parseInt(score08)}
	if(score09!=""){counTmp=counTmp+1; score1=parseInt(score1)+parseInt(score09)}
	if(score10!=""){counTmp=counTmp+1; score1=parseInt(score1)+parseInt(score10)}
	
	if(counTmp>0){
		score1=Math.round(score1/counTmp);
		$("#score1"+Oid).val(score1)//寫入平時成績
		
		finScore(Oid);
	}else{
		$("#score1"+Oid).val();
	}	
}

function finScore(Oid){
	score=0;	
	//alert($("#score1"+Oid).val()+","+$("#score2"+Oid).val()+","+$("#score3"+Oid).val());
	score1=$("#score1"+Oid).val();
	score2=$("#score2"+Oid).val();
	score3=$("#score3"+Oid).val();
	
	if(score1!=""){score+=parseInt(score1)*(p1/100)}
	if(score2!=""){score+=parseInt(score2)*(p2/100)}
	if(score3!=""){score+=parseInt(score3)*(p3/100)}
	
	//if(score1!=""&&score2!=""&&score3!=""){
	if(score3!=""){
		$("#score"+Oid).val(   Math.round(score)    );
	}else{
		$("#score"+Oid).val();
	}

}
</script>
</body>
</html>
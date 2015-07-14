<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<style>input{ime-mode:disabled;}</style>
	<script src="/eis/inc/js/develop/stdinfo.js"></script>
	<title>英文課程成績輸入</title>
</head>
<body>
<form action="ScoreManager" method="post" class="form-horizontal" >
<div class="alert" style="position: fixed; width:96%; z-index:20;">
<b>${csinfo.ClassName}, ${csinfo.chi_name}</b>,
輸入完成請先點選 <button type="submit" class="btn btn-danger btn-small" <c:if test="${!empty date2}">disabled</c:if> name="method:save">儲存</button> 確認後再點選 <a class="btn btn-small" href="ScoreManager">離開</a>
<div rel="popover" title="說明"
data-content="1.方向鍵  ↑ ↓ 能使游標垂直移動 2.計算功能為輔助,欄位可自由修改3.依各欄位顯示資料為儲存依據"
data-placement="right" class="elary btn btn-warning btn-small">?</div>
</div>
<br><br><br>
<div class="alert alert-danger">
平時考共6個欄位, 輸入任一欄立即計算<b>平時成績</b>，佔總成績30%<br>
補救教學佔<b>平時考平均</b> 30%, 若無補救教學請留空白<br>
期中考佔總成績 30%, 期末考佔總成績 40%<br>
英檢成績佔<b>期末成績</b> 50%, 若沒有英檢成績請留空白<br>
活動欄位會直接影響 總成績
</div>

<input type="hidden" name="Dtime_oid" id="Dtime_oid" value="${Dtime_oid}"/>
<input type="hidden" name="type" id="type" value="${type}"/>

<table class="table" id="class${e.Oid}">
	<tr>
		<td>學號</td>
		<td>姓名</td>
		<td>平時考</td>
		<td>平時</td>
		<td>補救</td>		
		<td nowrap>期中考</td>
		<td style="font-size:16;">英檢</td>
		<td style="font-size:16;" nowrap>期末考</td>
		<td>活動</td>
		<td style="font-size:16;" nowrap>總成績</td>
	</tr>
	
	
	<c:forEach items="${students}" var="s" varStatus="c">				
	
	<c:if test="${c.index%5==0&&c.index!=0}">	
	<tr >
		<td>學號</td><td>姓名</td>
		<td>平時考</td><td>平時</td>
		<td>補救</td><td>期中考</td>
		<td>英檢</td><td>期末考</td>
		<td>活動</td><td>總成績</td>
	</tr>	
	</c:if>	
	<tr>
		<td id="stImage${s.student_no}" nowrap>${s.student_no}</td>
		<td id="stImage${s.student_no}" nowrap>${s.student_name}
		<div class="btn-group">
			<a class="btn btn-mini dropdown-toggle" data-toggle="dropdown"
				href="#"><i class="icon-list" style="margin-top: 1px;"></i></a>
			<ul class="dropdown-menu">
				<li><a href="#stdInfo" data-toggle="modal"
					onClick="getDilgInfo('${s.student_no}', '${s.student_name}', '${Dtime_oid}')">本課程缺課記錄</a></li>
				<li><a href="#stdInfo" data-toggle="modal"
					onClick="getDilgInfo('${s.student_no}', '${s.student_name}', '')">所有課程缺課記錄</a></li>
				<li><a href="#stdInfo" data-toggle="modal"
					onClick="getStdContectInfo('${s.student_no}', '${s.student_name}')">連絡資訊</a></li>
				<li><a href="#stdInfo" data-toggle="modal"
					onClick="getStdScoreInfo('${s.student_no}', '${s.student_name}')">歷年成績</a></li>
				<li><a href="/CIS/Portfolio/ListMyStudents.do"
					target="_blank">學習歷程檔案</a></li>
			</ul>
		</div></td>
		<td nowrap>
		<input type="hidden" name="seldOid" value="${s.Oid}" />
		<input type="text" name="score01" id="score01${s.Oid}" value="${s.score01}" class="span1" onKeyUp="if(ck(this)){km(event, 'score01${students[c.index+1].Oid}', 'score01${students[c.index-1].Oid}'); countScore('${s.Oid}')}"/>
		<input type="text" name="score02" id="score02${s.Oid}" value="${s.score02}" class="span1" onKeyUp="if(ck(this)){km(event, 'score02${students[c.index+1].Oid}', 'score02${students[c.index-1].Oid}'); countScore('${s.Oid}')}"/>
		<input type="text" name="score03" id="score03${s.Oid}" value="${s.score03}" class="span1" onKeyUp="if(ck(this)){km(event, 'score03${students[c.index+1].Oid}', 'score03${students[c.index-1].Oid}'); countScore('${s.Oid}')}"/>
		<input type="text" name="score04" id="score04${s.Oid}" value="${s.score04}" class="span1" onKeyUp="if(ck(this)){km(event, 'score04${students[c.index+1].Oid}', 'score04${students[c.index-1].Oid}'); countScore('${s.Oid}')}"/>
		<input type="text" name="score05" id="score05${s.Oid}" value="${s.score05}" class="span1" onKeyUp="if(ck(this)){km(event, 'score05${students[c.index+1].Oid}', 'score05${students[c.index-1].Oid}'); countScore('${s.Oid}')}"/>
		<input type="text" name="score06" id="score06${s.Oid}" value="${s.score06}" class="span1" onKeyUp="if(ck(this)){km(event, 'score06${students[c.index+1].Oid}', 'score06${students[c.index-1].Oid}'); countScore('${s.Oid}')}"/>
		
		</td>
		
		<td  style="font-size:16;" nowrap>
		<input type="text" name="score1" id="score1${s.Oid}" value="${s.score1}" class="span1" onKeyUp="if(ck(this)){km(event, 'score1${students[c.index+1].Oid}', 'score1${students[c.index-1].Oid}'); countScore('${s.Oid}')}"/>
		</td>
		
		<td nowrap>
		<input type="text" name="score08" id="score08${s.Oid}" value="${s.score08}" class="span1" onKeyUp="if(ck(this)){km(event, 'score08${students[c.index+1].Oid}', 'score08${students[c.index-1].Oid}'); countScore('${s.Oid}')}"/>
		</td>
		
		
		
		<td nowrap>
		<input type="text" name="score2" id="score2${s.Oid}" value="${s.score2}" <c:if test="${date1!=null}">readonly</c:if>  class="span1" <c:if test="${date1==null}">onKeyUp="if(ck(this)){km(event, 'score2${students[c.index+1].Oid}', 'score2${students[c.index-1].Oid}'); countScore('${s.Oid}')}"</c:if> />
		</td>
		
		
		<td nowrap>
		<input type="text" name="score16" id="score16${s.Oid}" value="${s.score16}" class="span1" onKeyUp="if(ck(this)){km(event, 'score16${students[c.index+1].Oid}', 'score16${students[c.index-1].Oid}'); countScore('${s.Oid}')}"/>
		</td>
		
		<td nowrap>
		<input type="text" name="score3" id="score3${s.Oid}" value="${s.score3}" <c:if test="${date2!=null}">readonly</c:if> class="span1" <c:if test="${date2==null}">onKeyUp="if(ck(this)){km(event, 'score3${students[c.index+1].Oid}', 'score3${students[c.index-1].Oid}'); countScore('${s.Oid}')}"</c:if>/>
		</td>
		
		<td nowrap>
		<input type="text" name="score09" id="score09${s.Oid}" value="${s.score09}" class="span1" onKeyUp="if(ck(this)){km(event, 'score09${students[c.index+1].Oid}', 'score09${students[c.index-1].Oid}'); countScore('${s.Oid}')}"/>
		</td>
		
		<td nowrap>
		<input type="text" name="score" id="score${s.Oid}" value="${s.score}" <c:if test="${date2!=null}">readonly</c:if> class="span1" <c:if test="${date2==null}">onKeyUp="if(ck(this)){km(event, 'score${students[c.index+1].Oid}', 'score${students[c.index-1].Oid}'); countScore('${s.Oid}')}"</c:if>/>
		</td>
	</tr>	
	</c:forEach>	
	<tr  align="center">
		<td  colspan="100">
		<button type="submit" class="btn btn-danger" <c:if test="${!empty date2}">disabled</c:if> name="method:save">儲存</button>
		<a class="btn" href="ScoreManager">離開</a>
		</td>
	</tr>
</table>
</form>
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
<script>
$(document).ready(function() {
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

function countScore(Oid){	
	score01=$("#score01"+Oid).val();	
	score02=$("#score02"+Oid).val();
	score03=$("#score03"+Oid).val();
	score04=$("#score04"+Oid).val();
	score05=$("#score05"+Oid).val();
	score06=$("#score06"+Oid).val();
	
	counTmp=0;
	
	score08=$("#score08"+Oid).val();
	score09=$("#score09"+Oid).val();
	
	//score1=document.getElementById("score1"+Oid).value;
	score1=0;
	score2=$("#score2"+Oid).val();
	score3=$("#score3"+Oid).val();
	
	score16=$("#score16"+Oid).val();
	
	score=$("#score"+Oid).val();
	
	//平時考
	if(score01!=""){counTmp=counTmp+1; score1=parseInt(score1)+parseInt(score01)}
	if(score02!=""){counTmp=counTmp+1; score1=parseInt(score1)+parseInt(score02)}
	if(score03!=""){counTmp=counTmp+1; score1=parseInt(score1)+parseInt(score03)}
	if(score04!=""){counTmp=counTmp+1; score1=parseInt(score1)+parseInt(score04)}
	if(score05!=""){counTmp=counTmp+1; score1=parseInt(score1)+parseInt(score05)}
	if(score06!=""){counTmp=counTmp+1; score1=parseInt(score1)+parseInt(score06)}	
	
	score08=document.getElementById("score08"+Oid).value;
	if(counTmp>0){
		score1=score1/counTmp;
		$("#score1"+Oid).val(Math.round(score1));//寫入平時成績		
		//補救教學
		if(score08!=""){
			//score1=(parseInt(score1)+parseInt(score08))/2;
			score1=(((parseInt(score1)*0.7)+(parseInt(score08)*0.3)));			
			$("#score1"+Oid).val(Math.round(score1));//重寫平時成績
		}		
	}else{
		if(document.getElementById("score1"+Oid).value==""){
			score1=0;
		}else{
			score1=parseInt(  Math.round($("#score1"+Oid).val())  );
		}		
	}	
	//第二階段
	if(score2!=""&&score3!=""){
		//期末
		if(score3!=""){
			score3=parseInt(score3);
		}else{
			score3=0;
		}
		
		if(score16!=""){
			score3=(score3+parseInt(score16))/2;
		}
		
		//活動
		if(score09!=""){score09=parseInt(score09)}else{score09=0}
		
		score1=score1*0.3;
		score2=parseInt(score2)*0.3;
		score3=score3*0.4;		
		score=score1+score2+score3+score09;
		
		if(score>100){score=100}
		$("#score"+Oid).val(Math.round(score));//寫入總成績		
	}
}
</script>
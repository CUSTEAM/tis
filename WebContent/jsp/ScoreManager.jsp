<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>成績輸入與列印</title>
	
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
	
	
	
	
	

	
	
	</script>
</head>
<body>

<form action="ScoreManager" method="post" class="form-horizontal" >
<div class="bs-callout bs-callout-warning" id="callout-helper-pull-navbar">
	<h4>成績開放設定</h4>
	編輯期間自開學起, <b>期中考</b>至<fmt:formatDate pattern="M月d日H時m分" value="${date_exam_mid}"/>前, <b>期末考</b>至<fmt:formatDate pattern="M月d日H時m分" value="${date_exam_fin}"/>前<c:if test="${school_term eq'2'}">, <b>畢業考</b>至<fmt:formatDate pattern="M月d日H時m分" value="${date_exam_grad}"/>前</c:if>
	
</div> 
<div class = "panel panel-primary">
	<div class = "panel-heading">課程列表</div>
<table class="table ">
	<tr>
		<td nowrap>開課班級</td>
		<td nowrap>課程名稱</td>
		<td nowrap>星期/節次/地點</td>
		<td>編輯與列印
		<input type="hidden" name="Dtime_oid" id="Dtime_oid" />
		<input type="hidden" name="type" id="type" />
		</td>		
	</tr>
	<c:forEach items="${myClass}" var="m">	
	<tr>
		<td nowrap>${m.ClassName}<br><small>${m.fname}${m.credit}學分</small></td>
		<td nowrap>${m.chi_name}<br><small>選課${m.st}, 期中評分${m.s2f}, 期末評分${m.sf}</small>
		</td>
		<td nowrap>
		
		<c:forEach items="${m.time}" var="t">
		<p>
		
		
		
		<span class="label label-danger"><c:choose><c:when test="${t.week==7}">週日</c:when><c:otherwise>週${t.week}</c:otherwise></c:choose></span>		
	  	<span class="label label-primary">${t.begin}~${t.end}節</span>
	  	<span class="label label-warning">${t.place}</span>
	  	</p>
	  	</c:forEach>
		</td>
		<td nowrap>					
		
		<select id="type${m.Oid}" class="selectpicker upInput">
		  <optgroup label="提供標準成績計算欄位">
		    <option <c:if test="${m.type==''}">selected</c:if> value="">一般格式</option>		    
		  </optgroup>
		  <optgroup label="提供英文證照計算欄位">
		    <option <c:if test="${m.type=='e'}">selected</c:if> value="e">語言中心格式</option>
		  </optgroup>
		  <optgroup label="提供簡化的成績計算欄位">
		    <option <c:if test="${m.type=='s'}">selected</c:if> value="s">體育室格式</option>
		  </optgroup>
		</select>			
		
		
		<div class="btn-group" role="group" aria-label="...">
		<button type="submit" class="btn btn-primary" name="method:edit" onClick="cho('${m.Oid}', $('#type${m.Oid}').val());">編輯各項成績</button>
		<button <c:if test="${m.s2f ne m.st}">disabled</c:if> type="button" class="btn btn-default" onClick="chosRt('m', $('#type${m.Oid}').val(), '${m.Oid}');" >期中列印</button>
		<button <c:if test="${m.sf ne m.st}">disabled</c:if> type="button" class="btn btn-default" onClick="chosRt('f', $('#type${m.Oid}').val(), '${m.Oid}');">期末列印</button>
		</div>
		</td>
	</tr>
	</c:forEach>
</table>	
</form>	
</body>
</html>
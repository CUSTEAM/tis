<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>班級曠缺紀錄</title>
<style>

.material-switch > input[type="checkbox"] {
    display: none;   
}

.material-switch > label {
    cursor: pointer;
    height: 0px;
    position: relative; 
    width: 40px;  
}

.material-switch > label::before {
    background: rgb(0, 0, 0);
    box-shadow: inset 0px 0px 10px rgba(0, 0, 0, 0.5);
    border-radius: 8px;
    content: '';
    height: 16px;
    margin-top: -8px;
    position:absolute;
    opacity: 0.3;
    transition: all 0.4s ease-in-out;
    width: 40px;
}
.material-switch > label::after {
    background: rgb(255, 255, 255);
    border-radius: 16px;
    box-shadow: 0px 0px 5px rgba(0, 0, 0, 0.3);
    content: '';
    height: 24px;
    left: -4px;
    margin-top: -8px;
    position: absolute;
    top: -4px;
    transition: all 0.3s ease-in-out;
    width: 24px;
}
.material-switch > input[type="checkbox"]:checked + label::before {
    background: inherit;
    opacity: 0.5;
}
.material-switch > input[type="checkbox"]:checked + label::after {
    background: inherit;
    left: 20px;
}
</style>
<script>  
$(document).ready(function() {	
	
	$("input[name='beginDate']").change(function(){
		$("#endDate").val($("#beginDate").val());
	});	
	
	$("#opRes").click(function(){		
		if($("#opRes").prop("checked")){
			$(".filter").show("slow");
		}else{
			$(".filter").hide("slow");
		}
	});
	
	$(".filter").hide("slow");
});
</script>
</head>
<body>
<form action="DilgView" method="post" class="form-inline">
<div class="bs-callout bs-callout-info" id="callout-helper-pull-navbar">
	<button type="button" class="close" data-dismiss="alert">&times;</button>
	<h4>學生缺曠記錄</h4>
	<p><button class="btn btn-danger btn-xs" name="method:search" type="submit">依範圍查詢</button> 可顯示各班統計至任何一位學生缺曠細節, 查詢結果過多請以欄位進行排序</p>
	<button name="method:creatSearch" type="submit" class="btn btn-default">查看其他班級狀況</button>
	<c:if test="${!empty myClass}">
	<a href="DilgView"class="btn btn-danger">返回班級列表</a>
	</c:if>
	
	</div>
	


<div class="panel panel-primary">
	<div class="panel-heading">查詢範圍</div>	  	
		<table class="table">
			<tr>
				
				<td width="100%">
				<%@ include file="/inc/jsp-kit/classSelectorFull.jsp"%>
				
				</td>
			</tr>
			<tr>
				
				<td>
				<input type="hidden" name="printType" id="printType"/>
				<button class="btn btn-danger" name="method:search" type="submit">依範圍查詢</button>
				<div class="btn-group">
				
				<button class="btn btn-default" name="method:scorePrint" type="submit">成績趨勢</button>
				<button class="btn btn-default" name="method:nonexamPrint" type="submit">期中考無成績</button>
				<button class="btn btn-default" name="method:exScorePrint" onClick="$('#printType').val('score2');" type="submit">期中成績關係表</button>
				<button class="btn btn-default" name="method:exScorePrint" onClick="$('#printType').val('dtime');"type="submit">科目期中成績關係表</button>
				</div>
				<button class="btn btn-primary" name="method:print" type="submit">缺曠趨勢</button>				
				<div class="btn-group">				
				<div class="material-switch">
				<span class="glyphicon glyphicon-filter" aria-hidden="true"></span>選取假別&nbsp; 
			        <input id="opRes" name="opRes" value="" type="checkbox"/>
			        <label for="opRes" class="label-primary"></label>
			    </div>
				</div>
				</td>
			</tr>
			<tr class="filter">
				<td>
				<div class="row">
				  	
				  	<div class="col-md-3">
				  	<ul class="list-group">                    
			            
			            <c:forEach items="${CODE_DILG_RULES}" var="c">
			            <li class="list-group-item">${c.name}
			                <div class="material-switch pull-right">
			                    <input id="${c.name}" value="${c.id}" name="filter" type="checkbox" <c:if test="${c.id eq '2'||c.id eq '3'||c.id eq '4'}">checked</c:if>/>
			                    <label for="${c.name}" class="label-primary"></label>
			                </div>
			            </li>
			            </c:forEach>
			            
			                           
		            </ul>
				  	</div>
				  	
				  	
				  	
				  	
				</div>
				
				
		                
				
				
				
				
				
		
		
				
				
				
				
				
				</td>
			</tr>
		</table>
</div>
<c:if test="${!empty myClass && param.ClassNo==null}">     

<div class="panel panel-primary">
  
	<div class="panel-heading">查詢結果</div>
  	<div class="panel-body">
    <p>可點選欄位名稱排序</p>
  </div>
	<display:table name="${myClass}" id="row" class="table" sort="list" requestURI="DilgView?method=search">
  	<display:column title="班級名稱" property="ClassName" sortable="true" />
  	<display:column title="學生人數" property="sts" sortable="true"/>  	
  	<display:column title="已審核假單" property="dis" sortable="true" />
  	<display:column title="未審核假單" property="undis" sortable="true" />
  	<display:column title="已請假節數" property="ds" sortable="true" />
  	<display:column title="未請假節數" property="uds" sortable="true" />
  	<display:column title="缺曠資料"><a href="DilgView?ClassNo=${row.ClassNo}">班級缺曠</a></display:column>
	</display:table>
</div>
</c:if>	
</form>
</body>
</html>
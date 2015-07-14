<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="/eis/inc/js/develop/stdinfo.js"></script>
	<script src="/eis/inc/js/develop/timeInfo.js"></script>
</head>
<body>
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
	<div class="alert alert-block">
    <button type="button" class="close" data-dismiss="alert">&times;</button>
	<font size="+1">您正在檢視<b> ${info.date} 星期${info.week}, ${info.ClassName} - ${info.chi_name}</b>出席記錄</font> 
	<a href="RollCall" class="btn">返回</a>
    </div>
	    <div class="row-fluid form-horizontal">
	    	<div class="span6">
	    		<table class="table table-condensed table-bordered table-hover table-striped">
					<tr>
						<td>學號</td>
						<td>姓名</td>
						<td nowrap>個人缺曠</td>
						<td nowrap>缺課</td>
						
						<c:forEach items="${dclass}" varStatus="loop">  
			        	<td>第${dclass[loop.index]}節</td>
			      		</c:forEach>
					</tr>
					<c:forEach items="${students}" var="s" begin="0" end="${fn:length(students)/2}">
					<tr>
						<td nowrap>${s.student_no}</td>
						<td nowrap>${s.student_name}</td>
						<td nowrap>
						<div class="btn-group">
					    <a class="btn btn-mini dropdown-toggle" data-toggle="dropdown" href="#"><i class="icon-list" style="margin-top:1px;"></i></a>
					    <ul class="dropdown-menu">
							<li><a href="#stdInfo" data-toggle="modal"
								onClick="getStudentTime('${s.student_no}', '${s.student_name}')">本學期課表</a></li>
							<li><a href="#stdInfo" data-toggle="modal"
								onClick="getDilgInfo('${s.student_no}', '${s.student_name}', '${Oid}')">本課程缺課記錄</a></li>
							<li><a href="#stdInfo" data-toggle="modal"
								onClick="getDilgInfo('${s.student_no}', '${s.student_name}', '')">所有課程缺課記錄</a></li>
							<li><a href="#stdInfo" data-toggle="modal"
								onClick="getStdContectInfo('${s.student_no}', '${s.student_name}')">連絡資訊</a></li>
							<li><a href="#stdInfo" data-toggle="modal"
								onClick="getStdScoreInfo('${s.student_no}', '${s.student_name}')">歷年成績</a></li>
							<li><a href="/CIS/Portfolio/ListMyStudents.do"
								target="_blank">學習歷程檔案</a></li>									
						</ul>
					    </div>
						</td>
						<td nowrap><div rel="popover" title="已儲存" data-placement="left" id="${s.student_no}">${s.dilg_period}</div></td>						
						<c:forEach items="${s.dilgs}" var="d">  
			        	<td id="c${s.student_no}${d.cls}" 
			        	<c:if test="${d.abs eq ''||d.abs eq'6'||d.abs eq'7'}">class="control-group success"</c:if>
			        	<c:if test="${d.abs eq '1'||d.abs eq '2'||d.abs eq'3'||d.abs eq'4'||d.abs eq'8'||d.abs eq'9'}">class="control-group error"</c:if>
			        	<c:if test="${d.abs eq '5'}">class="control-group warning"</c:if>>
			        	<c:if test="${d.abs!='5'&&d.abs!='2'&&d.abs!=''}">
			        	<select disabled>
			        		<option value="">到課</option>
			        		<c:if test="${d.abs eq '1'}"><option selected value="1"> 住院</option></c:if>
				   			<c:if test="${d.abs eq '3'}"><option selected value="3"> 病假</option></c:if>
				   			<c:if test="${d.abs eq '4'}"><option selected value="4"> 事假</option></c:if>
				   			<c:if test="${d.abs eq '6'}"><option selected value="6"> 公假</option></c:if>
				   			<c:if test="${d.abs eq '7'}"><option selected value="7"> 喪假</option></c:if>
				   			<c:if test="${d.abs eq '8'}"><option selected value="8"> 婚假</option></c:if>
				   			<c:if test="${d.abs eq '9'}"><option selected value="9"> 產假</option></c:if>
			        	</select>
			        	</c:if>			        	
			        	<c:if test="${d.abs=='5'||d.abs=='2'||d.abs==''}">
			        	<select disabled>
			        		<option value=""></option>
			        		<option <c:if test="${d.abs=='2'}">selected="selected"</c:if> value="2"> 未到</option>
			        		<option <c:if test="${d.abs=='5'}">selected="selected"</c:if> value="5"> 遲到</option>			        		
			        	</select>
			        	</c:if>	
			        		
			        	</td>
			      		</c:forEach>			      		
					</tr>
					</c:forEach>
				</table>
	    	</div>
	    	<div class="span6">
	    		<table class="table table-condensed table-bordered table-hover table-striped">
					<tr>
						<td>學號</td>
						<td>姓名</td>
						<td>個人缺曠</td>
						<td>缺課</td>
						<c:forEach items="${dclass}" varStatus="loop">  
			        	<td>第${dclass[loop.index]}節</td>
			      		</c:forEach>
					</tr>
					<c:forEach items="${students}" var="s" begin="${(fn:length(students)/2)+1}">
					<tr>
						<td nowrap>${s.student_no}</td>
						<td nowrap>${s.student_name}</td>
						<td nowrap>
						<div class="btn-group">
					    <a class="btn btn-mini dropdown-toggle" data-toggle="dropdown" href="#"><i class="icon-list" style="margin-top:1px;"></i></a>
					    <ul class="dropdown-menu">
					    	<li><a href="#stdInfo" data-toggle="modal" onClick="getDilgInfo('${s.student_no}', '${s.student_name}', '${Oid}')">本課程缺課記錄</a></li>
					    	<li><a href="#stdInfo" data-toggle="modal" onClick="getDilgInfo('${s.student_no}', '${s.student_name}', '')">所有課程缺課記錄</a></li>
					    	<li><a href="#stdInfo" data-toggle="modal" onClick="getStdContectInfo('${s.student_no}', '${s.student_name}')">連絡資訊</a></li>
					    	<li><a href="#stdInfo" data-toggle="modal" onClick="getStdScoreInfo('${s.student_no}', '${s.student_name}')">歷年成績</a></li>
					    	<li><a href="/CIS/Portfolio/ListMyStudents.do" target="_blank">學習歷程檔案</a></li>
					    </ul>
					    </div>
						</td>
						<td nowrap><div rel="popover" title="已儲存" data-placement="left" id="${s.student_no}">${s.dilg_period}</div></td>						
						<c:forEach items="${s.dilgs}" var="d">  
			        	<td id="c${s.student_no}${d.cls}" 
			        	<c:if test="${d.abs eq ''||d.abs eq'6'||d.abs eq'7'}">class="control-group success"</c:if>
			        	<c:if test="${d.abs eq '1'||d.abs eq '2'||d.abs eq'3'||d.abs eq'4'||d.abs eq'8'||d.abs eq'9'}">class="control-group error"</c:if>
			        	<c:if test="${d.abs eq '5'}">class="control-group warning"</c:if>>
			        	<c:if test="${d.abs!='5'&&d.abs!='2'&&d.abs!=''}">
			        	<select disabled>
			        		<option value="">到課</option>
			        		<c:if test="${d.abs eq '1'}"><option selected value="1"> 住院</option></c:if>
				   			<c:if test="${d.abs eq '3'}"><option selected value="3"> 病假</option></c:if>
				   			<c:if test="${d.abs eq '4'}"><option selected value="4"> 事假</option></c:if>
				   			<c:if test="${d.abs eq '6'}"><option selected value="6"> 公假</option></c:if>
				   			<c:if test="${d.abs eq '7'}"><option selected value="7"> 喪假</option></c:if>
				   			<c:if test="${d.abs eq '8'}"><option selected value="8"> 婚假</option></c:if>
				   			<c:if test="${d.abs eq '9'}"><option selected value="9"> 產假</option></c:if>
			        	</select>
			        	</c:if>			        	
			        	<c:if test="${d.abs=='5'||d.abs=='2'||d.abs==''}">
			        	<select disabled>
			        		<option value=""></option>
			        		<option <c:if test="${d.abs=='2'}">selected="selected"</c:if> value="2"> 未到</option>
			        		<option <c:if test="${d.abs=='5'}">selected="selected"</c:if> value="5"> 遲到</option>			        		
			        	</select>
			        	</c:if>	    	
			        	</td>
			      		</c:forEach>			      		
					</tr>
					</c:forEach>
				</table>	    	
	    	</div>
    	</div>


</body>

</html>
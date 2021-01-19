package print;

import java.io.PrintWriter;
import java.util.Date;
import java.util.List;
import java.util.Map;

import action.BasePrintXmlAction;

public class RoolCallTable extends BasePrintXmlAction{
	//TODO 沒空
	public String execute()throws Exception {
		xml2ods(response, getRequest(), new Date());
		PrintWriter out = response.getWriter();		
		String Oid=request.getParameter("Oid");
		Map map=df.sqlGetMap("SELECT cl.ClassName, cs.chi_name FROM Class cl, Csno cs, Dtime d WHERE d.depart_class=cl.ClassNo AND d.cscode=cs.cscode AND d.Oid="+Oid);
		String dtimeOid = request.getParameter("dtimeOid");
		List<Map>list = df.sqlGet("SELECT st.sex, st.student_no, st.student_name FROM Seld s, stmd st WHERE s.student_no=st.student_no AND s.Dtime_oid="+Oid+" ORDER BY st.student_no");
		
		out.println("<html>");

		out.println("<head><meta http-equiv='Content-Type' content='text/html; charset=UTF-8'><style>td{font-size:18px;}</style>");
		out.println("<style>");
		out.println("<!--table");
		out.println("@page");
		out.println("	{margin:.0in .2in .5in .2in;");
		out.println("	mso-header-margin:.51in;");
		out.println("	mso-footer-margin:.51in;}");
		out.println("-->");
		out.println("</style></head><body>");
		
		out.println("<table border='1'>  ");
		out.println("  <tr>");
		out.println("		<td align='left' colspan='15'>" + map.get("ClassName")+ "-"+ map.get("chi_name")+"</td>");
		out.println("		<td align='right' colspan='5'>(學號/姓名/週次)</td>");
		out.println("  </tr>");
		out.println("  <tr>");
		out.println("		<td align='center'>學號</td>");
		out.println("		<td align='center'>姓名</td>");
		out.println("		<td align='center'>性別</td>");
		out.println("		<td align='center'>&nbsp; 1</td>");
		out.println("		<td align='center'>&nbsp; 2</td>");
		out.println("		<td align='center'>&nbsp; 3</td>");
		out.println("		<td align='center'>&nbsp; 4</td>");
		out.println("		<td align='center'>&nbsp; 5</td>");
		out.println("		<td align='center'>&nbsp; 6</td>");
		out.println("		<td align='center'>&nbsp; 7</td>");
		out.println("		<td align='center'>&nbsp; 8</td>");
		out.println("		<td align='center'>&nbsp; 9</td>");
		out.println("		<td align='center'>10</td>");
		out.println("		<td align='center'>11</td>");
		out.println("		<td align='center'>12</td>");
		out.println("		<td align='center'>13</td>");
		out.println("		<td align='center'>14</td>");
		out.println("		<td align='center'>15</td>");
		out.println("		<td align='center'>16</td>");
		out.println("		<td align='center'>17</td>");
		out.println("		<td align='center'>18</td>");
		out.println("	</tr>");
		if(list.size()<=40){			
			for (int i = 0; i < list.size(); i++) {
				if (i % 2 == 1) {
					out.println("  <tr>");
				} else {
					out.println("  <tr bgcolor='#eeeeee'>");
				}					
				out.println("		<td align='left' style='mso-number-format:\\@'>"+list.get(i).get("student_no")+"</td>");
				out.println("		<td align='left'>"+list.get(i).get("student_name")+"</td>");
				
				if(list.get(i).get("sex").equals("1")) {
					out.println("		<td align='center'>男</td>");
				}else {
					out.println("		<td align='center'>女</td>");
				}
				
				
				
				out.println("		<td align='center'></td>");
				out.println("		<td align='center'></td>");
				out.println("		<td align='center'></td>");
				out.println("		<td align='center'></td>");
				out.println("		<td align='center'></td>");
				out.println("		<td align='center'></td>");
				out.println("		<td align='center'></td>");
				out.println("		<td align='center'></td>");
				out.println("		<td align='center'></td>");
				out.println("		<td align='center'></td>");
				out.println("		<td align='center'></td>");
				out.println("		<td align='center'></td>");
				out.println("		<td align='center'></td>");
				out.println("		<td align='center'></td>");
				out.println("		<td align='center'></td>");
				out.println("		<td align='center'></td>");
				out.println("		<td align='center'></td>");
				out.println("		<td align='center'></td>");
				out.println("		</tr>");
			}
			out.println("</table>");
		}
		
		//40人以上分2頁
		if(list.size()>40){
			for (int i = 0; i < 40; i++) {
				if (i % 2 == 1) {
					out.println("  <tr>");
				} else {
					out.println("  <tr bgcolor='#eeeeee'>");
				}				
				out.println("		<td align='left' style='mso-number-format:\\@'>"+((Map)list.get(i)).get("student_no")+"</td>");
				out.println("		<td align='left'>"+((Map)list.get(i)).get("student_name")+"</td>");
				out.println("		<td align='center'></td>");
				out.println("		<td align='center'></td>");
				out.println("		<td align='center'></td>");
				out.println("		<td align='center'></td>");
				out.println("		<td align='center'></td>");
				out.println("		<td align='center'></td>");
				out.println("		<td align='center'></td>");
				out.println("		<td align='center'></td>");
				out.println("		<td align='center'></td>");
				out.println("		<td align='center'></td>");
				out.println("		<td align='center'></td>");
				out.println("		<td align='center'></td>");
				out.println("		<td align='center'></td>");
				out.println("		<td align='center'></td>");
				out.println("		<td align='center'></td>");
				out.println("		<td align='center'></td>");
				out.println("		<td align='center'></td>");
				out.println("		<td align='center'></td>");
				out.println("		</tr>");
			}
			
			
			
			out.println("<table border='1'>  ");
			out.println("  <tr>");
			out.println("		<td align='left' colspan='15'>" + map.get("ClassName")+ "-"+ map.get("chi_name")+"</td>");
			out.println("		<td align='right' colspan='5'>(學號/姓名/週次)</td>");
			out.println("  </tr>");
			out.println("  <tr>");
			out.println("		<td align='center'>學號</td>");
			out.println("		<td align='center'>姓名</td>");
			out.println("		<td align='center'>&nbsp; 1</td>");
			out.println("		<td align='center'>&nbsp; 2</td>");
			out.println("		<td align='center'>&nbsp; 3</td>");
			out.println("		<td align='center'>&nbsp; 4</td>");
			out.println("		<td align='center'>&nbsp; 5</td>");
			out.println("		<td align='center'>&nbsp; 6</td>");
			out.println("		<td align='center'>&nbsp; 7</td>");
			out.println("		<td align='center'>&nbsp; 8</td>");
			out.println("		<td align='center'>&nbsp; 9</td>");
			out.println("		<td align='center'>10</td>");
			out.println("		<td align='center'>11</td>");
			out.println("		<td align='center'>12</td>");
			out.println("		<td align='center'>13</td>");
			out.println("		<td align='center'>14</td>");
			out.println("		<td align='center'>15</td>");
			out.println("		<td align='center'>16</td>");
			out.println("		<td align='center'>17</td>");
			out.println("		<td align='center'>18</td>");
			out.println("	</tr>");		

			for (int i = 40; i < list.size(); i++) {

				if (i % 2 == 1) {
					out.println("  <tr>");
				} else {
					out.println("  <tr bgcolor='#eeeeee'>");
				}
				
				out.println("		<td align='left' style='mso-number-format:\\@'>"+((Map)list.get(i)).get("student_no")+"</td>");
				out.println("		<td align='left'>"+((Map)list.get(i)).get("student_name")+"</td>");
				out.println("		<td align='center'></td>");
				out.println("		<td align='center'></td>");
				out.println("		<td align='center'></td>");
				out.println("		<td align='center'></td>");
				out.println("		<td align='center'></td>");
				out.println("		<td align='center'></td>");
				out.println("		<td align='center'></td>");
				out.println("		<td align='center'></td>");
				out.println("		<td align='center'></td>");
				out.println("		<td align='center'></td>");
				out.println("		<td align='center'></td>");
				out.println("		<td align='center'></td>");
				out.println("		<td align='center'></td>");
				out.println("		<td align='center'></td>");
				out.println("		<td align='center'></td>");
				out.println("		<td align='center'></td>");
				out.println("		<td align='center'></td>");
				out.println("		<td align='center'></td>");
				out.println("		</tr>");
			}
			
			
			
		
		
		}
		
			
			
		out.println("</body>");
		out.println("</html>");
		out.close();
		return null;
	}

}

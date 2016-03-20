package action.rollCall;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import action.BaseAction;

public class DilgViewAction extends BaseAction{
	
	public String execute() throws Exception {
		
		if(request.getParameter("ClassNo")==null){
			request.setAttribute("myClass", df.sqlGet("SELECT ClassNo, ClassName, " +
			"(SELECT COUNT(*)FROM stmd WHERE depart_class=Class.ClassNo)as sts, " +
			"(SELECT COUNT(*)FROM Dilg_apply, stmd WHERE Dilg_apply.student_no=stmd.student_no AND " +
			"stmd.depart_class=Class.ClassNo AND result IS NOT NULL)as dis, " +
			"(SELECT COUNT(*)FROM Dilg_apply, stmd WHERE Dilg_apply.student_no=stmd.student_no AND " +
			"stmd.depart_class=Class.ClassNo AND result IS NULL)as undis, " +
			"(SELECT COUNT(*)FROM Dilg, stmd WHERE Dilg.student_no=stmd.student_no AND " +
			"stmd.depart_class=Class.ClassNo AND abs!='2' AND abs !='5')as ds," +
			"(SELECT COUNT(*)FROM Dilg, stmd WHERE Dilg.student_no=stmd.student_no AND " +
			"stmd.depart_class=Class.ClassNo AND abs='2')as uds " +
			"FROM Class WHERE Type='P' AND tutor='"+getSession().getAttribute("userid")+"'"));
			return this.SUCCESS;
		}else{	
			request.setAttribute("myStudents", df.sqlGet("SELECT s.depart_class, s.student_no, s.student_name, s.CellPhone, s.telephone, " +
			"(SELECT COUNT(*)FROM Dilg WHERE abs='1' AND Dilg.student_no=s.student_no)as abs1," +
					"(SELECT COUNT(*)FROM Dilg WHERE abs='2' AND Dilg.student_no=s.student_no)as abs2," +
					"(SELECT COUNT(*)FROM Dilg WHERE abs='3' AND Dilg.student_no=s.student_no)as abs3," +
					"(SELECT COUNT(*)FROM Dilg WHERE abs='4' AND Dilg.student_no=s.student_no)as abs4," +
					"(SELECT COUNT(*)FROM Dilg WHERE abs='5' AND Dilg.student_no=s.student_no)as abs5," +
					"(SELECT COUNT(*)FROM Dilg WHERE abs='6' AND Dilg.student_no=s.student_no)as abs6," +
					"(SELECT COUNT(*)FROM Dilg WHERE abs='7' AND Dilg.student_no=s.student_no)as abs7," +
					"(SELECT COUNT(*)FROM Dilg WHERE abs='8' AND Dilg.student_no=s.student_no)as abs8," +
					"(SELECT COUNT(*)FROM Dilg WHERE abs='9' AND Dilg.student_no=s.student_no)as abs9," +
					"(SELECT COUNT(*)FROM Dilg WHERE abs!='5' AND Dilg.student_no=s.student_no)as total " +
					"FROM stmd s WHERE s.depart_class='"+request.getParameter("ClassNo")+"' ORDER BY s.student_no"));
			
			return "detail";
		}		
	}
	
	
	public String creatSearch(){
		
		//session.remove("myClass");
		
		return this.SUCCESS;
	}
	
	public String search(){
		request.setAttribute("myClass", this.getData());		
		return SUCCESS;
	}
	
	public String scorePrint(){
		Date date=new Date();
		List<Map>list;
		
		StringBuilder sql=new StringBuilder("SELECT c.DeptNo, c.InstNo, IFNULL(bss.e21,0)as e21, IFNULL(bss.e32,0)as e32, IFNULL(bss.m21,0)as m21, IFNULL(bss.m32,0)as m32,IFNULL((SELECT cname FROM empl WHERE idno=c.tutor),'')as tutor,"
		+ "IFNULL((SELECT cname FROM empl WHERE idno=d.director),'')as director,(SELECT COUNT(*)FROM Gstmd WHERE occur_status IN('1', '2', '5')AND depart_class=c.ClassNo AND occur_year='"+getContext().getAttribute("school_year")+"'AND occur_term='"+getContext().getAttribute("school_term")+"')as gstmd,"
		+ "(SELECT COUNT(*)FROM stmd, Seld WHERE Seld.status='1' AND Seld.student_no=stmd.student_no AND stmd.depart_class=c.ClassNo)as block,"
		+ "c.ClassNo, c.ClassName, IFNULL(score.score1,0)as score1, IFNULL(score.score2,0)as score2, IFNULL(score.score,0)as score, IFNULL(score.score2d,0)as score2d, IFNULL(score.scored,0)as scored,"
		+ "(SELECT COUNT(*) FROM stmd WHERE depart_class=c.ClassNo)as cnt, IFNULL((SELECT COUNT(*) FROM Dilg d, stmd s, Class cl "
		+ "WHERE (d.abs!='6'AND d.abs!='5') AND d.student_no=s.student_no AND cl.ClassNo=s.depart_class AND cl.ClassNo=c.ClassNo GROUP BY cl.ClassNo),0)"
		+ "as dilg ");
		
		sql.append("FROM CODE_DEPT d, (Class c LEFT OUTER JOIN(SELECT cl1.ClassNo, COUNT(CASE WHEN h.score<60 THEN 1 ELSE NULL END)as scored, "
		+ "COUNT(CASE WHEN h.score2<60 THEN 1 ELSE NULL END)as score2d, AVG(h.score1)as score1, AVG(h.score2)as score2, "
		+ "AVG(h.score)as score FROM Seld h, stmd s1, Class cl1 WHERE h.student_no=s1.student_no AND s1.depart_class=cl1.ClassNo "
		+ "GROUP BY cl1.ClassNo)AS score ON(score.ClassNo=c.ClassNo))");
		
		sql.append("LEFT OUTER JOIN(SELECT (SELECT COUNT(CASE WHEN (bs.failed_credit/bs.credit)>0.5 THEN 1 ELSE NULL END))as e21,"
		+ "COUNT(CASE WHEN (bs.failed_credit2/bs.credit)>0.5 THEN 1 ELSE NULL END)as m21,"
		+ "COUNT(CASE WHEN (bs.failed_credit/bs.credit)>0.66 THEN 1 ELSE NULL END)as e32,"
		+ "COUNT(CASE WHEN (bs.failed_credit2/bs.credit)>0.66 THEN 1 ELSE NULL END)as m32,"
		+ "st3.depart_class FROM stmd st3, Class cla, BATCH_SELD_STAT bs WHERE "
		+ "st3.depart_class=cla.ClassNo AND bs.student_no=st3.student_no GROUP BY "
		+ "cla.ClassNo)as bss ON(bss.depart_class=c.ClassNo)");
		
		sql.append("WHERE d.id=c.DeptNo AND c.Type='P'");
		if(!cno.equals(""))sql.append("AND c.CampusNo='"+cno+"'");
		if(!cono.equals(""))sql.append("AND d.college='"+cono+"'");
		if(!stno.equals(""))sql.append("AND c.SchoolType='"+stno+"'");
		if(!sno.equals(""))sql.append("AND c.SchoolNo='"+sno+"'");
		if(!dno.equals(""))sql.append("AND c.DeptNo='"+dno+"'");
		if(!gno.equals(""))sql.append("AND c.Grade='"+gno+"'");
		if(!zno.equals(""))sql.append("AND c.SeqNo='"+zno+"'");			
		sql.append("ORDER BY c.ClassNo");
		list=df.sqlGet(sql.toString());		
		request.setAttribute("cls", list);
		List<Map>dept=df.sqlGet("SELECT cd.id, cd.Name, IFNULL((SELECT cname FROM empl WHERE idno=cd.director),'')as director,"
		+ "IFNULL((SELECT empl.cname FROM empl, CODE_COLLEGE WHERE empl.idno=CODE_COLLEGE.leader AND CODE_COLLEGE.id=cd.college),'')as leader"
		+ " FROM CODE_DEPT cd WHERE cd.id!='0'");
		int tot, cnt, dilg,score2d,m21,m32,scored,e21,e32,block,gstmd;
		float score1,score2,score;
		for(int i=0; i<dept.size(); i++){
			tot=0;cnt=0;dilg=0;score1=0;score2=0;score=0;
			score2d=0;m21=0;m32=0;scored=0;e21=0;e32=0;block=0;gstmd=0;
			for(int j=0; j<list.size(); j++){
				if(list.get(j).get("DeptNo").equals(dept.get(i).get("id"))){
					tot++;
					cnt+=Integer.parseInt(list.get(j).get("cnt").toString());
					dilg+=Integer.parseInt(list.get(j).get("dilg").toString());
					score1+=Float.parseFloat(list.get(j).get("score1").toString());
					score2+=Float.parseFloat(list.get(j).get("score2").toString());
					score+=Float.parseFloat(list.get(j).get("score").toString());					
					score2d+=Integer.parseInt(list.get(j).get("score2d").toString());
					m21+=Integer.parseInt(list.get(j).get("m21").toString());
					m32+=Integer.parseInt(list.get(j).get("m32").toString());
					scored+=Integer.parseInt(list.get(j).get("scored").toString());
					e21+=Integer.parseInt(list.get(j).get("e21").toString());
					e32+=Integer.parseInt(list.get(j).get("e32").toString());
					block+=Integer.parseInt(list.get(j).get("block").toString());
					gstmd+=Integer.parseInt(list.get(j).get("gstmd").toString());
				}
				
				//if(tot<1)continue;
				dept.get(i).put("total", tot);
				dept.get(i).put("cnt", cnt);
				dept.get(i).put("dilg", dilg);
				dept.get(i).put("score1", score1);
				dept.get(i).put("score2", score2);
				dept.get(i).put("score", score);				
				dept.get(i).put("score2d", score2d);
				dept.get(i).put("m21", m21);
				dept.get(i).put("m32", m32);
				dept.get(i).put("scored", scored);
				dept.get(i).put("e21", e21);
				dept.get(i).put("e32", e32);
				dept.get(i).put("block", block);
				dept.get(i).put("gstmd", gstmd);
			}
		}		
		request.setAttribute("dept", dept);
		
		List<Map>col=df.sqlGet("SELECT cc.id,cc.name, (SELECT cname FROM empl WHERE idno=cc.id)as leader FROM CODE_COLLEGE cc");
		for(int i=0; i<col.size(); i++){
			tot=0;cnt=0;dilg=0;score1=0;score2=0;score=0;
			score2d=0;m21=0;m32=0;scored=0;e21=0;e32=0;block=0;gstmd=0;
			for(int j=0; j<list.size(); j++){
				if(list.get(j).get("InstNo").equals(col.get(i).get("id"))){
					tot++;
					cnt+=Integer.parseInt(list.get(j).get("cnt").toString());
					dilg+=Integer.parseInt(list.get(j).get("dilg").toString());
					score1+=Float.parseFloat(list.get(j).get("score1").toString());
					score2+=Float.parseFloat(list.get(j).get("score2").toString());
					score+=Float.parseFloat(list.get(j).get("score").toString());					
					score2d+=Integer.parseInt(list.get(j).get("score2d").toString());
					m21+=Integer.parseInt(list.get(j).get("m21").toString());
					m32+=Integer.parseInt(list.get(j).get("m32").toString());
					scored+=Integer.parseInt(list.get(j).get("scored").toString());
					e21+=Integer.parseInt(list.get(j).get("e21").toString());
					e32+=Integer.parseInt(list.get(j).get("e32").toString());
					block+=Integer.parseInt(list.get(j).get("block").toString());
					gstmd+=Integer.parseInt(list.get(j).get("gstmd").toString());
				}
				
				if(tot<1)continue;
				col.get(i).put("total", tot);
				col.get(i).put("cnt", cnt);
				col.get(i).put("dilg", dilg);
				col.get(i).put("score1", score1);
				col.get(i).put("score2", score2);
				col.get(i).put("score", score);				
				col.get(i).put("score2d", score2d);
				col.get(i).put("m21", m21);
				col.get(i).put("m32", m32);
				col.get(i).put("scored", scored);
				col.get(i).put("e21", e21);
				col.get(i).put("e32", e32);
				col.get(i).put("block", block);
				col.get(i).put("gstmd", gstmd);
			}
		}		
		request.setAttribute("col", col);
		return "score";
	}
	
	public String exDtimePrint(){
		
		
		return "";
	}
	
	/**
	 * 期中成績關係表
	 * @return
	 */
	public String exScorePrint(){		
		/*int cnt;
		List<Map>list;
		String school_term=(String) getContext().getAttribute("school_term");
		Date school_term_begin=(Date) getContext().getAttribute("date_school_term_begin");
		SimpleDateFormat sf=new SimpleDateFormat("yyyy-MM-dd HH:mm");
		*/
		
		StringBuilder sql=new StringBuilder();
		if(printType.equals("score2"))
		sql.append("SELECT (SELECT COUNT(*)FROM Seld, stmd, Dtime WHERE Seld.Dtime_oid=Dtime.Oid AND Dtime.Sterm='"+getContext().getAttribute("school_term")+"'AND "
		+ "Seld.student_no=stmd.student_no AND stmd.depart_class=c.ClassNo AND (score2=0 OR score2 IS NULL))as zero, IFNULL(e.cname,'')as cname,"
		+ "(SELECT COUNT(*)FROM stmd WHERE stmd.depart_class=c.ClassNo) as cnt,c.ClassName as name,c.DeptNo,c.ClassNo,"
		+ "(SELECT ROUND(IFNULL(AVG(s.score2),0),0)FROM BATCH_SELD_DILG_STAT s, "
		+ "stmd st WHERE s.student_no=st.student_no AND st.depart_class=c.ClassNo)as score,"
		+ "ROUND(IFNULL((SELECT ROUND(SUM(s.dilg8)/cnt,0) FROM BATCH_SELD_DILG_STAT s, stmd st WHERE "
		+ "s.student_no=st.student_no AND st.depart_class=c.ClassNo),0),0)as dilg,"
		+ "(SELECT ROUND(IFNULL(AVG(CASE WHEN dilg8>=d1.dilg_avg8 then s1.score2 else null end),0),0)"
		+ "FROM BATCH_DTIME_DILG_STAT d1,BATCH_SELD_DILG_STAT s1, stmd st1 WHERE d1.Dtime_oid=s1.Dtime_oid AND "
		+ "s1.student_no=st1.student_no AND st1.depart_class=c.ClassNo)as scoreb,"
		+ "(SELECT ROUND(IFNULL(AVG(CASE WHEN dilg8<=d1.dilg_avg8 then s1.score2 else null end),0),0)FROM BATCH_DTIME_DILG_STAT d1,BATCH_SELD_DILG_STAT s1, "
		+ "stmd st1 WHERE d1.Dtime_oid=s1.Dtime_oid AND s1.student_no=st1.student_no AND st1.depart_class=c.ClassNo)as scoreg "
		+ "FROM Class c LEFT OUTER JOIN empl e ON c.tutor=e.idno WHERE c.Type='P'");
		
		if(printType.equals("dtime"))
			sql.append("SELECT (SELECT COUNT(*)FROM Seld WHERE Dtime_oid=d.Oid AND(score2=0 OR score2 IS NULL))as zero,d.Oid,IFNULL(e.cname,'')as cname,(SELECT COUNT(*)FROM Seld WHERE Seld.Dtime_oid=d.Oid) as cnt,"
			+ "CONCAT(c.ClassName, cs.chi_name)as name,c.DeptNo,c.ClassNo,(SELECT ROUND(IFNULL(AVG(s.score2),0),0)FROM BATCH_SELD_DILG_STAT s WHERE s.Dtime_oid=d.Oid)as score,"
			+ "ROUND(IFNULL((SELECT ROUND(SUM(s.dilg8)/cnt,0) FROM BATCH_SELD_DILG_STAT s WHERE s.Dtime_oid=d.Oid),0),0)as dilg,"
			+ "(SELECT ROUND(IFNULL(AVG(CASE WHEN dilg8>=d1.dilg_avg8 then s1.score2 else null end),0),0)FROM BATCH_DTIME_DILG_STAT d1,"
			+ "BATCH_SELD_DILG_STAT s1 WHERE d1.Dtime_oid=s1.Dtime_oid AND d1.Dtime_oid=d.Oid)as scoreb,(SELECT ROUND(IFNULL(AVG(CASE WHEN "
			+ "dilg8<=d1.dilg_avg8 then s1.score2 else null end),0),0)FROM BATCH_DTIME_DILG_STAT d1,BATCH_SELD_DILG_STAT s1 WHERE "
			+ "d1.Dtime_oid=s1.Dtime_oid AND d1.Dtime_oid=d.Oid)as scoreg FROM Dtime d LEFT OUTER JOIN empl e ON d.techid=e.idno, "
			+ "Csno cs,Class c  WHERE d.Sterm='"+getContext().getAttribute("school_term")+"'AND d.cscode=cs.cscode AND d.depart_class=c.ClassNo AND c.Type='P'");
		
		
		if(!cno.equals(""))sql.append("AND c.CampusNo='"+cno+"'");
		if(!cono.equals(""))sql.append("AND c.InstNo='"+cono+"'");
		if(!stno.equals(""))sql.append("AND c.SchoolType='"+stno+"'");
		if(!sno.equals(""))sql.append("AND c.SchoolNo='"+sno+"'");
		if(!dno.equals(""))sql.append("AND c.DeptNo='"+dno+"'");
		if(!gno.equals(""))sql.append("AND c.Grade='"+gno+"'");
		if(!zno.equals(""))sql.append("AND c.SeqNo='"+zno+"'");			
		sql.append("ORDER BY c.ClassNo");
		//System.out.println(sql);
		List<Map>cls=df.sqlGet(sql.toString());
		
		List<Map>tmp=null;
		int avg,g, b;
		for(int i=0; i<cls.size(); i++){
			g=0;b=0;
			avg=Integer.parseInt(cls.get(i).get("dilg").toString());
			
			if(printType.equals("score2")){
				tmp=df.sqlGet("SELECT IFNULL(SUM(sd.dilg8),0)as d FROM BATCH_SELD_STAT s, stmd st, BATCH_SELD_DILG_STAT sd WHERE "
				+ "sd.student_no=s.student_no AND (s.failed_credit2/s.credit)>0.66 AND s.student_no=st.student_no AND "
				+ "st.depart_class='"+cls.get(i).get("ClassNo")+"' GROUP BY s.student_no");
			}
			
			if(printType.equals("dtime")){
				tmp=df.sqlGet("SELECT d.Oid, IFNULL(SUM(sd.dilg8),0)as d FROM BATCH_SELD_STAT s, Dtime d, BATCH_SELD_DILG_STAT sd WHERE "
						+ "sd.Dtime_oid=d.Oid AND (s.failed_credit2/s.credit)>0.66 AND d.Oid="+cls.get(i).get("Oid")+" AND s.student_no=sd.student_no "
						+ "GROUP BY s.student_no");
			}
			
			for(int j=0; j<tmp.size();j++){
				if(Integer.parseInt(tmp.get(j).get("d").toString())>=avg){					
					b++;
				}else{
					g++;
				}
			}
			cls.get(i).put("g", g);
			cls.get(i).put("b", b);
		}		
		request.setAttribute("cls", cls);
		List<Map>dept=df.sqlGet("SELECT d.id, d.name, e.cname FROM CODE_DEPT d LEFT OUTER JOIN empl e ON d.director=e.idno");
		
		int tot,cnt,score,dilg,scoreb,scoreg;	
		//int tot,score,dilg,scoreb,scoreg;	
		for(int i=0; i<dept.size(); i++){
			
			tot=0;cnt=0;score=0;dilg=0;scoreb=0;scoreg=0;b=0;g=0;
			for(int j=0; j<cls.size(); j++){
				if(Integer.parseInt(cls.get(j).get("score").toString())<1)continue;
				if(cls.get(j).get("DeptNo").equals(dept.get(i).get("id"))){		
					tot++;
					cnt+=Integer.parseInt(cls.get(j).get("cnt").toString());
					//if(cnt<1)continue;
					score+=Integer.parseInt(cls.get(j).get("score").toString());					
					dilg+=Integer.parseInt(cls.get(j).get("dilg").toString());					
					scoreb+=Integer.parseInt(cls.get(j).get("scoreb").toString());
					scoreg+=Integer.parseInt(cls.get(j).get("scoreg").toString());
					b+=Integer.parseInt(cls.get(j).get("b").toString());
					g+=Integer.parseInt(cls.get(j).get("g").toString());
				}
			}
			
			if(tot<1||cnt<1)continue;
			dept.get(i).put("cnt", cnt);
			dept.get(i).put("score", score/tot);
			dept.get(i).put("dilg", dilg/tot);
			dept.get(i).put("scoreb", scoreb/tot);
			dept.get(i).put("scoreg", scoreg/tot);			
			dept.get(i).put("b", b);
			dept.get(i).put("g", g);
			
		}
		request.setAttribute("dept", dept);
		return "exScore";
	}
	
	public String print() throws IOException{
		Date date=new Date();
		response.setContentType("application/vnd.ms-excel; charset=UTF-8");
		response.setHeader("Content-disposition","attachment;filename="+date.getTime()+".xls");				
		PrintWriter out=response.getWriter();
		out.println ("<?xml version='1.0'?>");
		out.println ("<?mso-application progid='Excel.Sheet'?>");
		out.println ("<Workbook xmlns='urn:schemas-microsoft-com:office:spreadsheet'");
		out.println (" xmlns:o='urn:schemas-microsoft-com:office:office'");
		out.println (" xmlns:x='urn:schemas-microsoft-com:office:excel'");
		out.println (" xmlns:ss='urn:schemas-microsoft-com:office:spreadsheet'");
		out.println (" xmlns:html='http://www.w3.org/TR/REC-html40'>");
		out.println (" <DocumentProperties xmlns='urn:schemas-microsoft-com:office:office'>");
		out.println ("  <Author>shawn</Author>");
		out.println ("  <LastAuthor>shawn</LastAuthor>");
		out.println ("  <LastPrinted>2014-11-17T07:34:06Z</LastPrinted>");
		out.println ("  <Created>2014-11-17T06:31:14Z</Created>");
		out.println ("  <LastSaved>2014-11-17T07:40:28Z</LastSaved>");
		out.println ("  <Version>15.00</Version>");
		out.println (" </DocumentProperties>");
		out.println (" <OfficeDocumentSettings xmlns='urn:schemas-microsoft-com:office:office'>");
		out.println ("  <AllowPNG/>");
		out.println (" </OfficeDocumentSettings>");
		out.println (" <ExcelWorkbook xmlns='urn:schemas-microsoft-com:office:excel'>");
		out.println ("  <WindowHeight>11880</WindowHeight>");
		out.println ("  <WindowWidth>28800</WindowWidth>");
		out.println ("  <WindowTopX>0</WindowTopX>");
		out.println ("  <WindowTopY>0</WindowTopY>");
		out.println ("  <ProtectStructure>False</ProtectStructure>");
		out.println ("  <ProtectWindows>False</ProtectWindows>");
		out.println (" </ExcelWorkbook>");
		out.println (" <Styles>");
		out.println ("  <Style ss:ID='Default' ss:Name='Normal'>");
		out.println ("   <Alignment ss:Vertical='Center'/>");
		out.println ("   <Borders/>");
		out.println ("   <Font ss:FontName='新細明體' x:CharSet='136' x:Family='Roman' ss:Size='12'");
		out.println ("    ss:Color='#000000'/>");
		out.println ("   <Interior/>");
		out.println ("   <NumberFormat/>");
		out.println ("   <Protection/>");
		out.println ("  </Style>");
		out.println ("  <Style ss:ID='s62'>");
		out.println ("   <Font ss:FontName='新細明體' x:CharSet='136' x:Family='Roman' ss:Size='12'");
		out.println ("    ss:Color='#000000'/>");
		out.println ("  </Style>");
		out.println ("  <Style ss:ID='s63'>");
		out.println ("   <Borders>");
		out.println ("    <Border ss:Position='Bottom' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Left' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Right' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Top' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("   </Borders>");
		out.println ("   <Font ss:FontName='新細明體' x:CharSet='136' x:Family='Roman' ss:Size='12'");
		out.println ("    ss:Color='#000000'/>");
		out.println ("  </Style>");
		out.println (" </Styles>");
		out.println (" <Worksheet ss:Name='班級'>");
		out.println ("  <Names>");
		out.println ("   <NamedRange ss:Name='Print_Titles' ss:RefersTo='=班級!R1'/>");
		out.println ("  </Names>");
		out.println ("  <Table ss:ExpandedColumnCount='24' ss:ExpandedRowCount='9999' x:FullColumns='1'");
		out.println ("   x:FullRows='1' ss:StyleID='s62' ss:DefaultColumnWidth='54'");
		out.println ("   ss:DefaultRowHeight='16.5'>");
		out.println ("   <Column ss:StyleID='s63' ss:AutoFitWidth='0' ss:Width='108'/>");
		out.println ("   <Column ss:StyleID='s63' ss:Width='30.75'/>");
		out.println ("   <Column ss:StyleID='s63' ss:Width='29.25'/>");
		out.println ("   <Column ss:StyleID='s63' ss:Width='27' ss:Span='7'/>");
		out.println ("   <Column ss:Index='12' ss:StyleID='s63' ss:Width='30' ss:Span='8'/>");
		out.println ("   <Column ss:Index='21' ss:StyleID='s63' ss:Width='30.75'/>");
		out.println ("   <Column ss:StyleID='s63' ss:AutoFitWidth='0' ss:Width='48'/>");
		out.println ("   <Column ss:StyleID='s63' ss:AutoFitWidth='0' ss:Width='52.5'/>");
		out.println ("   <Column ss:StyleID='s63' ss:AutoFitWidth='0' ss:Width='55.5'/>");
		out.println ("   <Row ss:AutoFitHeight='0'>");
		out.println ("    <Cell><Data ss:Type='String'>班級</Data><NamedCell ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>人數</Data><NamedCell ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>1週</Data><NamedCell ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>2週</Data><NamedCell ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>3週</Data><NamedCell ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>4週</Data><NamedCell ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>5週</Data><NamedCell ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>6週</Data><NamedCell ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>7週</Data><NamedCell ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>8週</Data><NamedCell ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>9週</Data><NamedCell ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>10週</Data><NamedCell ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>11週</Data><NamedCell ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>12週</Data><NamedCell ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>13週</Data><NamedCell ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>14週</Data><NamedCell ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>15週</Data><NamedCell ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>16週</Data><NamedCell ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>17週</Data><NamedCell ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>週均</Data><NamedCell ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>人均</Data><NamedCell ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>流失</Data><NamedCell ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>導師</Data><NamedCell ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>系主任</Data><NamedCell ss:Name='Print_Titles'/></Cell>");
		//out.println ("    <Cell><Data ss:Type='String'>院長</Data><NamedCell ss:Name='Print_Titles'/></Cell>");
		out.println ("   </Row>");
		DecimalFormat d=new DecimalFormat("#.##");
		SimpleDateFormat sf=new SimpleDateFormat("yyyy-MM-dd HH:mm");
		int sts;
		Calendar begin=Calendar.getInstance();
		begin.setTime((Date) getContext().getAttribute("date_rollcall_begin"));
		StringBuilder sql=new StringBuilder("SELECT c.ClassName, "
				+ "(SELECT COUNT(*)FROM Gstmd WHERE occur_status IN('1', '2', '5')AND depart_class=c.ClassNo AND occur_year='"+getContext().getAttribute("school_year")+"'AND occur_term='"+getContext().getAttribute("school_term")+"')as gstmds,");
		for(int i=1; i<=17; i++){			
			sql.append("(SELECT COUNT(*)FROM Dilg di, stmd st WHERE di.date>='"+sf.format(begin.getTime())+"'");
			begin.add(Calendar.DAY_OF_YEAR, 7);
			sql.append("AND di.date<'"+sf.format(begin.getTime())+"'AND di.student_no=st.student_no AND st.depart_class=c.ClassNo)as cnt"+i+",");
		}

		sql.append("(SELECT COUNT(*)FROM stmd WHERE depart_class=c.ClassNo)as sts,IFNULL((SELECT cname FROM empl WHERE idno=c.tutor),'')as tutor, "
		+ "IFNULL((SELECT cname FROM empl WHERE idno=d.director),'')as director FROM Class c, CODE_DEPT d WHERE "
		+ "c.Type='p' AND c.DeptNo=d.id ");		
		if(!cno.equals(""))sql.append("AND c.CampusNo='"+cno+"'");
		if(!cono.equals(""))sql.append("AND d.college='"+cono+"'");
		if(!stno.equals(""))sql.append("AND c.SchoolType='"+stno+"'");
		if(!sno.equals(""))sql.append("AND c.SchoolNo='"+sno+"'");
		if(!dno.equals(""))sql.append("AND c.DeptNo='"+dno+"'");
		if(!gno.equals(""))sql.append("AND c.Grade='"+gno+"'");
		if(!zno.equals(""))sql.append("AND c.SeqNo='"+zno+"'");		
		sql.append("ORDER BY c.ClassNo");
		
		List<Map>list=df.sqlGet(sql.toString());
		
		float total, avg;
		for(int i=0; i<list.size(); i++){
			sts=Integer.parseInt(list.get(i).get("sts").toString());
			if(sts<1)continue;
			if(list.get(i).get("sts").equals("0"))continue;
			out.println ("   <Row ss:AutoFitHeight='0'>");
			out.println ("    <Cell><Data ss:Type='String'>"+list.get(i).get("ClassName")+"</Data></Cell>");
			out.println ("    <Cell><Data ss:Type='Number'>"+list.get(i).get("sts")+"</Data></Cell>");			
			total=0;
			for(int j=1; j<=17; j++){
				avg=Float.parseFloat(list.get(i).get("cnt"+j).toString())/sts;
				total+=avg;
				out.println ("<Cell><Data ss:Type='Number'>"+avg+"</Data></Cell>");
			}			
			out.println ("    <Cell><Data ss:Type='Number'>"+d.format(total/17)+"</Data></Cell>");
			out.println ("    <Cell><Data ss:Type='Number'>"+d.format(total)+"</Data></Cell>");
			out.println ("    <Cell><Data ss:Type='Number'>"+list.get(i).get("gstmds")+"</Data></Cell>");
			out.println ("    <Cell><Data ss:Type='String'>"+list.get(i).get("tutor")+"</Data></Cell>");
			out.println ("    <Cell><Data ss:Type='String'>"+list.get(i).get("director")+"</Data></Cell>");
			out.println ("   </Row>");
		}
		
		
		
		
		out.println ("  </Table>");
		out.println ("  <WorksheetOptions xmlns='urn:schemas-microsoft-com:office:excel'>");
		out.println ("   <PageSetup>");
		out.println ("    <Layout x:Orientation='Landscape'/>");
		out.println ("    <Header x:Margin='0.31496062992125984' x:Data='&amp;C&amp;&quot;微軟正黑體,粗體&quot;&amp;24班級缺課趨勢表'/>");
		out.println ("    <Footer x:Margin='0.31496062992125984' x:Data='&amp;L列印時間 "+sf.format(date)+"&amp;R&amp;P/&amp;N'/>");
		out.println ("    <PageMargins x:Bottom='0.74803149606299213' x:Left='0.23622047244094491'");
		out.println ("     x:Right='0.23622047244094491' x:Top='0.74803149606299213'/>");
		out.println ("   </PageSetup>");
		out.println ("   <Unsynced/>");
		out.println ("   <Print>");
		out.println ("    <ValidPrinterInfo/>");
		out.println ("    <PaperSizeIndex>9</PaperSizeIndex>");
		out.println ("    <HorizontalResolution>-1</HorizontalResolution>");
		out.println ("    <VerticalResolution>-1</VerticalResolution>");
		out.println ("   </Print>");
		out.println ("   <Selected/>");
		out.println ("   <ProtectObjects>False</ProtectObjects>");
		out.println ("   <ProtectScenarios>False</ProtectScenarios>");
		out.println ("  </WorksheetOptions>");
		out.println (" </Worksheet>");
		out.println (" <Worksheet ss:Name='系'>");
		out.println ("  <Names>");
		out.println ("   <NamedRange ss:Name='Print_Titles' ss:RefersTo='=系!R1'/>");
		out.println ("  </Names>");
		out.println ("  <Table ss:ExpandedColumnCount='24' ss:ExpandedRowCount='9999' x:FullColumns='1'");
		out.println ("   x:FullRows='1' ss:StyleID='s62' ss:DefaultColumnWidth='54'");
		out.println ("   ss:DefaultRowHeight='16.5'>");
		out.println ("   <Column ss:StyleID='s63' ss:AutoFitWidth='0' ss:Width='108'/>");
		out.println ("   <Column ss:StyleID='s63' ss:Width='30.75'/>");
		out.println ("   <Column ss:StyleID='s63' ss:Width='29.25'/>");
		out.println ("   <Column ss:StyleID='s63' ss:Width='27' ss:Span='7'/>");
		out.println ("   <Column ss:Index='12' ss:StyleID='s63' ss:Width='30' ss:Span='8'/>");
		out.println ("   <Column ss:Index='21' ss:StyleID='s63' ss:Width='30.75'/>");
		out.println ("   <Column ss:StyleID='s63' ss:AutoFitWidth='0' ss:Width='48'/>");
		out.println ("   <Column ss:StyleID='s63' ss:AutoFitWidth='0' ss:Width='52.5'/>");
		out.println ("   <Column ss:StyleID='s63' ss:AutoFitWidth='0' ss:Width='55.5'/>");		
		out.println ("   <Row ss:AutoFitHeight='0'>");
		out.println ("    <Cell><Data ss:Type='String'>名稱</Data><NamedCell ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>人數</Data><NamedCell ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>1週</Data><NamedCell ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>2週</Data><NamedCell ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>3週</Data><NamedCell ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>4週</Data><NamedCell ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>5週</Data><NamedCell ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>6週</Data><NamedCell ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>7週</Data><NamedCell ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>8週</Data><NamedCell ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>9週</Data><NamedCell ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>10週</Data><NamedCell ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>11週</Data><NamedCell ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>12週</Data><NamedCell ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>13週</Data><NamedCell ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>14週</Data><NamedCell ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>15週</Data><NamedCell ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>16週</Data><NamedCell ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>17週</Data><NamedCell ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>週均</Data><NamedCell ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>人均</Data><NamedCell ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>流失</Data><NamedCell ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>系主任</Data><NamedCell ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>院長</Data><NamedCell ss:Name='Print_Titles'/></Cell>");
		out.println ("   </Row>");		
		begin.setTime((Date) getContext().getAttribute("date_rollcall_begin"));
		sql=new StringBuilder("SELECT d.name,");
		for(int i=1; i<=17; i++){			
			sql.append("SUM((SELECT COUNT(*)FROM Dilg di, stmd st WHERE (abs!='5'&&abs!='6')AND di.date>='"+sf.format(begin.getTime())+"'");
			begin.add(Calendar.DAY_OF_YEAR, 7);
			sql.append("AND di.date<'"+sf.format(begin.getTime())+"'AND di.student_no=st.student_no AND st.depart_class=c.ClassNo))as cnt"+i+",");
		}
		sql.append("SUM((SELECT COUNT(*)FROM Gstmd WHERE occur_status IN('1', '2', '5')AND depart_class=c.ClassNo AND occur_year='"+getContext().getAttribute("school_year")+"'AND occur_term='"+getContext().getAttribute("school_term")+"'))as gstmds,SUM((SELECT COUNT(*)FROM stmd WHERE depart_class=c.ClassNo))as sts,IFNULL((SELECT cname FROM empl WHERE idno=c.tutor),'')as tutor, "
		+ "IFNULL((SELECT cname FROM empl WHERE idno=d.director),'')as director, IFNULL((SELECT cname FROM empl WHERE idno=cc.leader),'')as leader FROM Class c, CODE_DEPT d, CODE_COLLEGE cc WHERE "
		+ "c.Type='p' AND c.DeptNo=d.id AND d.college=cc.id ");		
		if(!cno.equals(""))sql.append("AND c.CampusNo='"+cno+"'");
		if(!cono.equals(""))sql.append("AND d.college='"+cono+"'");
		if(!stno.equals(""))sql.append("AND c.SchoolType='"+stno+"'");
		if(!sno.equals(""))sql.append("AND c.SchoolNo='"+sno+"'");
		if(!dno.equals(""))sql.append("AND c.DeptNo='"+dno+"'");
		//if(!gno.equals(""))sql.append("AND c.Grade='"+gno+"'");
		//if(!zno.equals(""))sql.append("AND c.SeqNo='"+zno+"'");		
		sql.append("GROUP BY c.DeptNo");	
		list=df.sqlGet(sql.toString());
		sts=0;
		for(int i=0; i<list.size(); i++){	
			sts=Integer.parseInt(list.get(i).get("sts").toString());
			if(sts<1)continue;
			out.println ("   <Row ss:AutoFitHeight='0'>");
			out.println ("    <Cell><Data ss:Type='String'>"+list.get(i).get("name")+"</Data></Cell>");
			out.println ("    <Cell><Data ss:Type='Number'>"+list.get(i).get("sts")+"</Data></Cell>");			
			total=0;
			for(int j=1; j<=17; j++){
				avg=Float.parseFloat(list.get(i).get("cnt"+j).toString())/sts;
				total+=avg;
				out.println ("<Cell><Data ss:Type='Number'>"+avg+"</Data></Cell>");
			}			
			
			out.println ("    <Cell><Data ss:Type='Number'>"+total/17+"</Data></Cell>");
			out.println ("    <Cell><Data ss:Type='Number'>"+total+"</Data></Cell>");
			out.println ("    <Cell><Data ss:Type='Number'>"+list.get(i).get("gstmds")+"</Data></Cell>");
			out.println ("    <Cell><Data ss:Type='String'>"+list.get(i).get("director")+"</Data></Cell>");
			out.println ("    <Cell><Data ss:Type='String'>"+list.get(i).get("leader")+"</Data></Cell>");
			out.println ("   </Row>");
		}
		out.println ("  </Table>");
		out.println ("  <WorksheetOptions xmlns='urn:schemas-microsoft-com:office:excel'>");
		out.println ("   <PageSetup>");
		out.println ("    <Layout x:Orientation='Landscape'/>");
		out.println ("    <Header x:Margin='0.31496062992125984' x:Data='&amp;C&amp;&quot;微軟正黑體,粗體&quot;&amp;24系缺課趨勢表'/>");
		out.println ("    <Footer x:Margin='0.31496062992125984' x:Data='&amp;L列印時間 "+sf.format(date)+"&amp;R&amp;P/&amp;N'/>");
		out.println ("    <PageMargins x:Bottom='0.74803149606299213' x:Left='0.23622047244094491'");
		out.println ("     x:Right='0.23622047244094491' x:Top='0.74803149606299213'/>");
		out.println ("   </PageSetup>");
		out.println ("   <Unsynced/>");
		out.println ("   <Print>");
		out.println ("    <ValidPrinterInfo/>");
		out.println ("    <PaperSizeIndex>9</PaperSizeIndex>");
		out.println ("    <HorizontalResolution>-1</HorizontalResolution>");
		out.println ("    <VerticalResolution>-1</VerticalResolution>");
		out.println ("   </Print>");
		out.println ("   <ProtectObjects>False</ProtectObjects>");
		out.println ("   <ProtectScenarios>False</ProtectScenarios>");
		out.println ("  </WorksheetOptions>");
		out.println (" </Worksheet>");
		out.println (" <Worksheet ss:Name='院'>");
		out.println ("  <Names>");
		out.println ("   <NamedRange ss:Name='Print_Titles' ss:RefersTo='=院!R1'/>");
		out.println ("  </Names>");
		out.println ("  <Table ss:ExpandedColumnCount='24' ss:ExpandedRowCount='99' x:FullColumns='1'");
		out.println ("   x:FullRows='1' ss:StyleID='s62' ss:DefaultColumnWidth='54'");
		out.println ("   ss:DefaultRowHeight='16.5'>");
		out.println ("   <Column ss:StyleID='s63' ss:AutoFitWidth='0' ss:Width='108'/>");
		out.println ("   <Column ss:StyleID='s63' ss:Width='30.75'/>");
		out.println ("   <Column ss:StyleID='s63' ss:Width='29.25'/>");
		out.println ("   <Column ss:StyleID='s63' ss:Width='27' ss:Span='7'/>");
		out.println ("   <Column ss:Index='12' ss:StyleID='s63' ss:Width='30' ss:Span='8'/>");
		out.println ("   <Column ss:Index='21' ss:StyleID='s63' ss:Width='30.75'/>");
		out.println ("   <Column ss:StyleID='s63' ss:AutoFitWidth='0' ss:Width='48'/>");
		out.println ("   <Column ss:StyleID='s63' ss:AutoFitWidth='0' ss:Width='52.5'/>");
		out.println ("   <Column ss:StyleID='s63' ss:AutoFitWidth='0' ss:Width='55.5'/>");
		out.println ("   <Row ss:AutoFitHeight='0'>");
		out.println ("    <Cell><Data ss:Type='String'>名稱</Data><NamedCell ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>人數</Data><NamedCell ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>1週</Data><NamedCell ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>2週</Data><NamedCell ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>3週</Data><NamedCell ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>4週</Data><NamedCell ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>5週</Data><NamedCell ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>6週</Data><NamedCell ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>7週</Data><NamedCell ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>8週</Data><NamedCell ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>9週</Data><NamedCell ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>10週</Data><NamedCell ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>11週</Data><NamedCell ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>12週</Data><NamedCell ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>13週</Data><NamedCell ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>14週</Data><NamedCell ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>15週</Data><NamedCell ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>16週</Data><NamedCell ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>17週</Data><NamedCell ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>週均</Data><NamedCell ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>人均</Data><NamedCell ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>流失</Data><NamedCell ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>系主任</Data><NamedCell ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>院長</Data><NamedCell ss:Name='Print_Titles'/></Cell>");
		out.println ("   </Row>");
		begin.setTime((Date) getContext().getAttribute("date_rollcall_begin"));
		sql=new StringBuilder("SELECT cc.name,");
		for(int i=1; i<=17; i++){			
			sql.append("SUM((SELECT COUNT(*)FROM Gstmd WHERE occur_status IN('1', '2', '5')AND depart_class=c.ClassNo AND occur_year='"+getContext().getAttribute("school_year")+
			"'AND occur_term='"+getContext().getAttribute("school_term")+"'))as gstmds, SUM((SELECT COUNT(*)FROM Dilg di, stmd st WHERE "
			+ "di.date>='"+sf.format(begin.getTime())+"'");
			begin.add(Calendar.DAY_OF_YEAR, 7);
			sql.append("AND (di.abs!='6'AND di.abs!='5')AND di.date<'"+sf.format(begin.getTime())+"'AND di.student_no=st.student_no AND st.depart_class=c.ClassNo))as cnt"+i+",");			
		}
		sql.append("SUM((SELECT COUNT(*)FROM stmd WHERE depart_class=c.ClassNo))as sts,IFNULL((SELECT cname FROM empl WHERE idno=c.tutor),'')as tutor, "
		+ "IFNULL((SELECT cname FROM empl WHERE idno=d.director),'')as director, IFNULL((SELECT cname FROM empl WHERE idno=cc.leader),'')as leader FROM Class c, CODE_DEPT d, CODE_COLLEGE cc WHERE "
		+ "c.Type='p' AND c.DeptNo=d.id AND d.college=cc.id ");		
		if(!cno.equals(""))sql.append("AND c.CampusNo='"+cno+"'");
		if(!cono.equals(""))sql.append("AND d.college='"+cono+"'");
		if(!stno.equals(""))sql.append("AND c.SchoolType='"+stno+"'");
		if(!sno.equals(""))sql.append("AND c.SchoolNo='"+sno+"'");
		if(!dno.equals(""))sql.append("AND c.DeptNo='"+dno+"'");	
		sql.append("GROUP BY d.college");
		list=df.sqlGet(sql.toString());
		sts=0;
		for(int i=0; i<list.size(); i++){	
			sts=Integer.parseInt(list.get(i).get("sts").toString());
			if(sts<1)continue;
			out.println ("   <Row ss:AutoFitHeight='0'>");
			out.println ("    <Cell><Data ss:Type='String'>"+list.get(i).get("name")+"</Data></Cell>");
			out.println ("    <Cell><Data ss:Type='Number'>"+list.get(i).get("sts")+"</Data></Cell>");			
			total=0;
			for(int j=1; j<=17; j++){
				avg=Float.parseFloat(list.get(i).get("cnt"+j).toString())/sts;
				total+=avg;
				out.println ("<Cell><Data ss:Type='Number'>"+avg+"</Data></Cell>");
			}			
			
			out.println ("    <Cell><Data ss:Type='Number'>"+total/17+"</Data></Cell>");
			out.println ("    <Cell><Data ss:Type='Number'>"+total+"</Data></Cell>");
			out.println ("    <Cell><Data ss:Type='Number'>"+list.get(i).get("gstmds")+"</Data></Cell>");
			out.println ("    <Cell><Data ss:Type='String'></Data></Cell>");
			out.println ("    <Cell><Data ss:Type='String'>"+list.get(i).get("leader")+"</Data></Cell>");
			out.println ("   </Row>");
		}		
		out.println ("  </Table>");
		out.println ("  <WorksheetOptions xmlns='urn:schemas-microsoft-com:office:excel'>");
		out.println ("   <PageSetup>");
		out.println ("    <Layout x:Orientation='Landscape'/>");
		out.println ("    <Header x:Margin='0.31496062992125984' x:Data='&amp;C&amp;&quot;微軟正黑體,粗體&quot;&amp;24院缺課趨勢表'/>");
		out.println ("    <Footer x:Margin='0.31496062992125984' x:Data='&amp;L列印時間 "+sf.format(date)+"&amp;R&amp;P/&amp;N'/>");
		out.println ("    <PageMargins x:Bottom='0.74803149606299213' x:Left='0.23622047244094491'");
		out.println ("     x:Right='0.23622047244094491' x:Top='0.74803149606299213'/>");
		out.println ("   </PageSetup>");
		out.println ("   <Unsynced/>");
		out.println ("   <Print>");
		out.println ("    <ValidPrinterInfo/>");
		out.println ("    <PaperSizeIndex>9</PaperSizeIndex>");
		out.println ("    <HorizontalResolution>-1</HorizontalResolution>");
		out.println ("    <VerticalResolution>-1</VerticalResolution>");
		out.println ("   </Print>");
		out.println ("   <ProtectObjects>False</ProtectObjects>");
		out.println ("   <ProtectScenarios>False</ProtectScenarios>");
		out.println ("  </WorksheetOptions>");
		out.println (" </Worksheet>");
		out.println ("</Workbook>");
		out.close();		
		return null;
	}
	
	
	public String nonexamPrint(){
		StringBuilder sql=new StringBuilder("SELECT c.ClassNo, c.ClassName, e.cname FROM "
		+ "Class c LEFT OUTER JOIN empl e ON c.tutor=e.idno WHERE c.Type='P'");
		if(!cno.equals(""))sql.append("AND c.CampusNo='"+cno+"'");
		if(!cono.equals(""))sql.append("AND d.college='"+cono+"'");
		if(!stno.equals(""))sql.append("AND c.SchoolType='"+stno+"'");
		if(!sno.equals(""))sql.append("AND c.SchoolNo='"+sno+"'");
		if(!dno.equals(""))sql.append("AND c.DeptNo='"+dno+"'");
		if(!gno.equals(""))sql.append("AND c.Grade='"+gno+"'");
		if(!zno.equals(""))sql.append("AND c.SeqNo='"+zno+"'");		
		sql.append("");
		List<Map>cls=df.sqlGet(sql.toString());
		int cnt=0;
		List<Map>stds,zeros;
		for(int i=0; i<cls.size(); i++){				
			zeros=new ArrayList();
			stds=df.sqlGet("SELECT s.score2,c.ClassName, st.student_no, st.student_name,"
			+ "c1.ClassName as csClassName, cs.chi_name, cd.name as opt, d.thour, d.credit, s.score2,"
			+ "(SELECT COUNT(*)FROM Seld WHERE Dtime_oid=d.Oid)as cnt,(SELECT COUNT(*)FROM "
			+ "Seld WHERE Dtime_oid=d.Oid AND (score2=0 OR score2 IS NULL))as zero FROM Seld s,CODE_DTIME_OPT cd,"
			+ "stmd st, Class c, Class c1, Dtime d, Csno cs WHERE d.opt=cd.id AND c1.ClassNo=d.depart_class AND "
			+ "cs.cscode=d.cscode AND s.Dtime_oid=d.Oid AND s.student_no=st.student_no AND "
			+ "st.depart_class=c.ClassNo AND (s.score2=0 OR s.score2 IS NULL)AND "
			+ "d.Sterm='"+getContext().getAttribute("school_term")+"' AND c.ClassNo='"+
			cls.get(i).get("ClassNo")+"'ORDER BY s.student_no");
			
			
			for(int j=0; j<stds.size(); j++){
				if(!stds.get(j).get("cnt").equals(stds.get(j).get("zero"))){
					zeros.add(stds.get(j));
				}
			}
			
			
			
			cnt+=zeros.size();		
			cls.get(i).put("stds", zeros);
			
			
		}
		
		
		
		request.setAttribute("cnt", cnt);
		request.setAttribute("cls", cls);
		return "nonexam";
	}
	
	/**
	 * 取期間缺課數
	 * @param ClassNo
	 * @param DeptNo
	 * @param CollegeNo
	 * @param begin
	 * @param end
	 * @return
	 */
	private int getCount(String ClassNo, String DeptNo, String CollegeNo, String begin, String end){
		
		StringBuilder sql=new StringBuilder("SELECT COUNT(*) FROM CODE_DEPT cd, Dilg d, stmd s, Class c WHERE (d.abs!='6'AND d.abs!='5') AND "
		+ "cd.id=c.DeptNo AND d.student_no=s.student_no AND s.depart_class=c.ClassNo AND d.date>='"+begin+"' AND d.date<='"+end+"'");
		//if(!cno.equals(""))sql.append("AND c.Campus='"+cno+"'");
		if(ClassNo!=null)sql.append("AND c.ClassNo='"+ClassNo+"'");
		if(DeptNo!=null)sql.append("AND c.DeptNo='"+DeptNo+"'");
		if(CollegeNo!=null)sql.append("AND cd.college='"+CollegeNo+"'");
		return 0;
	}
	
	private List getData(){
		StringBuilder sql=new StringBuilder("SELECT c.ClassNo, c.ClassName, " +
		"(SELECT COUNT(*)FROM stmd WHERE depart_class=c.ClassNo)as sts, " +
		"(SELECT COUNT(*)FROM Dilg_apply, stmd WHERE Dilg_apply.student_no=stmd.student_no AND " +
		"stmd.depart_class=c.ClassNo AND result IS NOT NULL)as dis, " +
		"(SELECT COUNT(*)FROM Dilg_apply, stmd WHERE Dilg_apply.student_no=stmd.student_no AND " +
		"stmd.depart_class=c.ClassNo AND result IS NULL)as undis, " +
		"(SELECT COUNT(*)FROM Dilg, stmd WHERE Dilg.student_no=stmd.student_no AND " +
		"stmd.depart_class=c.ClassNo AND abs!='2' AND abs !='5')as ds," +
		"(SELECT COUNT(*)FROM Dilg, stmd WHERE Dilg.student_no=stmd.student_no AND " +
		"stmd.depart_class=c.ClassNo AND abs='2')as uds " +
		"FROM Class c, CODE_DEPT d WHERE c.DeptNo=d.id AND c.Type='P'");
		if(!cno.equals(""))sql.append("AND c.CampusNo='"+cno+"'");
		if(!cono.equals(""))sql.append("AND d.college='"+cono+"'");
		if(!stno.equals(""))sql.append("AND c.SchoolType='"+stno+"'");
		if(!sno.equals(""))sql.append("AND c.SchoolNo='"+sno+"'");
		if(!dno.equals(""))sql.append("AND c.DeptNo='"+dno+"'");
		if(!gno.equals(""))sql.append("AND c.Grade='"+gno+"'");
		if(!zno.equals(""))sql.append("AND c.SeqNo='"+zno+"'");	
		
		return df.sqlGet(sql.toString());
	}
	
	public String cono;
	public String stno;
	public String cno;
	public String sno;
	public String dno;
	public String gno;
	public String zno;
	public String printType;
}

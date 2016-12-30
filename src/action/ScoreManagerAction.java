package action;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import model.Message;
import model.Seld;

public class ScoreManagerAction extends BaseAction{
	
	public String Dtime_oid,type,p1,p2,p3;
	
	public String execute(){		
		String term=(String)getContext().getAttribute("school_term");		
		//get single teacher list
		List<Map>myClass=df.sqlGet("SELECT cdo.fname, d.credit,cl.className, (SELECT COUNT(*)FROM Seld WHERE Dtime_oid=d.Oid AND score IS NOT NULL)as sf, (SELECT COUNT(*)FROM Seld WHERE Dtime_oid=d.Oid)as st,"
		+ "(SELECT COUNT(*)FROM Seld WHERE Dtime_oid=d.Oid AND score2 IS NOT NULL)as s2f,"
		+ "cs.chi_name, d.Oid, cs.cscode, cl.classNo, d.Sterm FROM CODE_DTIME_OPT cdo, Dtime d, Csno cs, Class cl "+ 
		"WHERE cdo.id=d.opt AND d.cscode=cs.cscode AND d.depart_class=cl.classNo AND d.Sterm='"+term+"' AND d.techid='"+getSession().getAttribute("userid")+
		"' AND d.cscode!='50000'ORDER BY d.depart_class");
		//get mult-teachers list		
		myClass.addAll(df.sqlGet("SELECT d.opt,d.credit, cl.className, cs.chi_name, d.Oid, cs.cscode, cl.classNo, d.Sterm,"
				+ "(SELECT COUNT(*)FROM Seld WHERE Dtime_teacher=dt.Oid AND score2 IS NOT NULL)as s2f,"
				+ "(SELECT COUNT(*)FROM Seld WHERE Dtime_teacher=dt.Oid AND score IS NOT NULL)as sf,"
				+ "(SELECT COUNT(*)FROM Seld WHERE Dtime_teacher=dt.Oid)as st FROM "
		+ "Dtime d, Csno cs, Class cl,Dtime_teacher dt WHERE "
		+ "d.Oid=dt.Dtime_oid AND (d.techid IS NULL OR d.techid='')AND cs.cscode!='50000'AND "
		+ "d.cscode=cs.cscode AND d.depart_class=cl.classNo AND d.Sterm='"+term+"' AND "
		+ "dt.teach_id='"+getSession().getAttribute("userid")+"' ORDER BY d.depart_class"));
		
		for(int i=0; i<myClass.size(); i++){
			myClass.get(i).put("type", "");
			if(myClass.get(i).get("chi_name").toString().indexOf("英文")>=0){
				myClass.get(i).put("type", "e");
				//continue;
			}
			if(myClass.get(i).get("chi_name").toString().indexOf("體育")>=0){
				myClass.get(i).put("type", "s");
			}			
		}		
		
		for(int i=0; i<myClass.size(); i++){
			myClass.get(i).put("time", df.sqlGet("SELECT * FROM Dtime_class WHERE Dtime_oid="+myClass.get(i).get("Oid")));			
		}
		request.setAttribute("myClass", myClass);			
		
		return SUCCESS;
	}
	
	private List<Map>students;
	
	private void getStds(){		
		if(df.sqlGetInt("SELECT COUNT(*) FROM Dtime_teacher dt, Dtime d WHERE dt.Dtime_oid=d.Oid AND (d.techid='' OR d.techid IS NULL)AND " +
			"dt.Dtime_oid="+Dtime_oid+" AND dt.teach_id='"+getSession().getAttribute("userid")+"'")>0){
			//取分組
			students=df.sqlGet("SELECT st.student_name, s.*,c.ClassName FROM Dtime d, stmd st, Seld s, Class c WHERE c.ClassNo=st.depart_class AND st.student_no=s.student_no AND "
			+"s.Dtime_oid=d.Oid AND d.Oid="+Dtime_oid+" AND s.Dtime_teacher=(SELECT Oid FROM Dtime_teacher WHERE "
			+"Dtime_oid="+Dtime_oid+" AND teach_id='"+getSession().getAttribute("userid")+"')ORDER BY st.student_no");
		}else{
			//取全班
			students=df.sqlGet("SELECT st.student_name, s.*, c.ClassName FROM Seld s, stmd st, Class c WHERE c.ClassNo=st.depart_class AND "
			+"s.student_no=st.student_no AND s.Dtime_oid='"+Dtime_oid+"' ORDER BY st.student_no");
		}		
	}
	
	/**
	 * get students
	 * @return
	 * @throws ParseException 
	 */
	public String edit() throws ParseException{
		getStds();	
		request.setAttribute("students", students);
		request.setAttribute("csinfo", df.sqlGetMap("SELECT c.ClassName, cs.chi_name FROM Dtime d, Class c, Csno cs WHERE d.depart_class=c.ClassNo AND d.cscode=cs.cscode AND d.Oid="+Dtime_oid));
		request.setAttribute("Dtime_oid", Dtime_oid);		
		//expire date for input percentage of score
		Date now=new Date();
		Date edper; //成績比例參考時間
		SimpleDateFormat sf=new SimpleDateFormat("yyyy-MM-dd HH:mm");
		try{			
			edper=(Date)getContext().getAttribute("date_school_term_begin");				
			Calendar c=Calendar.getInstance();
			c.setTime(edper);
			c.add(Calendar.DAY_OF_YEAR, 14);//開學14天
			edper=c.getTime();
			if(now.getTime()>edper.getTime()){
				request.setAttribute("edper", sf.format(edper));
			}
		}catch(Exception e){
			Message msg=new Message();
			msg.setError("開學日期無法辨識");
			savMessage(msg);
		}
		
		//get score percentage
		Map map=df.sqlGetMap("SELECT * FROM SeldPro WHERE Dtime_oid="+Dtime_oid);
		if(map==null){
			map=new HashMap();
			map.put("score1", 30);
			map.put("score2", 30);
			map.put("score3", 40);
		}
		request.setAttribute("seldpro", map);//成績比例
		
		//參考個別設定時間
		map=df.sqlGetMap("SELECT * FROM ScoreOdDate WHERE DtimeOid="+Dtime_oid);
		if(map!=null){			
			edper=sf.parse(map.get("exam_mid").toString());//期中
			if(now.getTime()>edper.getTime()){request.setAttribute("date1", "expiry");}
			edper=sf.parse(map.get("exam_fin").toString());//期末
			if(now.getTime()>edper.getTime()){request.setAttribute("date2", "expiry");}
			Message msg=new Message();
			msg.setInfo("本課程的編輯期間由教務單位變更為<br>期中: "+map.get("exam_mid")+"<br>期末: "+map.get("exam_fin"));
			this.savMessage(msg);
		}else{
			//期中
			edper=(Date)getContext().getAttribute("date_exam_mid");//期中
			if(now.getTime()>edper.getTime()){request.setAttribute("date1", "expiry");}
			//期末	
			if(getContext().getAttribute("school_term").equals("2")){//若為第二學期
				//畢業班參考畢業考時間
				if(!df.sqlGetStr("SELECT c.graduate FROM Dtime d, Class c WHERE d.depart_class=c.ClassNo AND d.Oid="+Dtime_oid).equals("0")){
					edper=(Date)getContext().getAttribute("date_exam_grad");
					if(now.getTime()>edper.getTime()){request.setAttribute("date2", "expiry");}
				}else{
					//非畢業班參考期末時間
					edper=(Date)getContext().getAttribute("date_exam_fin");
					if(now.getTime()>edper.getTime()){request.setAttribute("date2", "expiry");}
				}
			}else{
				//非第二學期只參考期末時間
				edper=(Date)getContext().getAttribute("date_exam_fin");
				if(now.getTime()>edper.getTime()){request.setAttribute("date2", getContext().getAttribute("exam_fin"));}
			}
					
			if(getContext().getAttribute("school_term").equals("2")){
				request.setAttribute("sdate3", getContext().getAttribute("exam_grad"));
			}
			request.setAttribute("sdate2", getContext().getAttribute("exam_fin"));	
		}
		
		switch(type){
			case"":return "norRat";
			case"e":return "engRat";
			case"s":return "spoRat";
			default:return"norrat";
		}
	}
	
	public String seldOid[];
	public Integer score[], score1[], score2[], score3[],
	score01[],score02[],score03[],score04[],score05[],
	score06[],score07[],score08[],score09[],score10[],
	score11[],score12[],score13[],score14[],score15[],
	score16[],score17[],score18[];
	
	public String save() throws ParseException{
		Message msg=new Message();
		Seld seld;
		for(int i=0; i<seldOid.length; i++){			
			try{
				seld=(Seld) df.hqlGetListBy("FROM Seld WHERE Oid="+seldOid[i]).get(0);				
				if(score[i]!=null)seld.setScore(score[i]);				
				if(score1!=null)seld.setScore1(score1[i]);				
				if(score2!=null)seld.setScore2(score2[i]);				
				if(score3!=null)seld.setScore3(score3[i]);				
				if(score01!=null)seld.setScore01(score01[i]);				
				if(score02!=null)seld.setScore02(score02[i]);				
				if(score03!=null)seld.setScore03(score03[i]);				
				if(score04!=null)seld.setScore04(score04[i]);				
				if(score05!=null)seld.setScore05(score05[i]);				
				if(score06!=null)seld.setScore06(score06[i]);				
				if(score07!=null)seld.setScore07(score07[i]);
				if(score08!=null)seld.setScore08(score08[i]);				
				if(score09!=null)seld.setScore09(score09[i]);				
				if(score10!=null)seld.setScore10(score10[i]);				
				if(score16!=null)seld.setScore16(score16[i]);				
				df.update(seld);
			}catch(Exception e){
				e.printStackTrace();
				msg.setError("儲存中發現問題");
				savMessage(msg);
				return edit();
			}
		}
		
		msg.setSuccess("已儲存");
		savMessage(msg);
		return edit();
	}
	
	/**
	 * save score proportion
	 * @return
	 * @throws ParseException 
	 */
	public String editPro() throws ParseException{
		Message msg=new Message();
		if(!p1.trim().equals("")&&!p2.trim().equals("")&&!p3.trim().equals("")){
			if(Integer.parseInt(p1)+Integer.parseInt(p2)+Integer.parseInt(p3)==100){
				df.exSql("DELETE FROM SeldPro WHERE Dtime_oid="+Dtime_oid);
				df.exSql("INSERT INTO SeldPro(Dtime_oid, score1, score2, score3)VALUES('"+Dtime_oid+"', '"+p1+"', '"+p2+"', '"+p3+"')");
			}else{				
				msg.setError("百分比欄位相加結果不滿足100");
				savMessage(msg);
				return edit();
			}
		}else{
			msg.setError("百分比欄位空白不利於辨識，請填入數字並令相加結果為100");
			savMessage(msg);
			return edit();
		}	
		msg.setSuccess("已儲存成績比例");
		savMessage(msg);
		return edit();
	}
	
	public String printScore1() throws IOException{		
		getStds();		
		Date date=new Date();
		response.setContentType("text/html; charset=UTF-8");
		response.setContentType("application/vnd.ms-excel");
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
		out.println ("  <Author>John</Author>");
		out.println ("  <LastAuthor>John</LastAuthor>");
		out.println ("  <LastPrinted>2016-12-13T07:47:08Z</LastPrinted>");
		out.println ("  <Created>2016-12-13T02:18:56Z</Created>");
		out.println ("  <LastSaved>2016-12-13T02:29:03Z</LastSaved>");
		out.println ("  <Version>15.00</Version>");
		out.println (" </DocumentProperties>");
		out.println (" <OfficeDocumentSettings xmlns='urn:schemas-microsoft-com:office:office'>");
		out.println ("  <AllowPNG/>");
		out.println (" </OfficeDocumentSettings>");
		out.println (" <ExcelWorkbook xmlns='urn:schemas-microsoft-com:office:excel'>");
		out.println ("  <WindowHeight>12390</WindowHeight>");
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
		out.println ("   <Font ss:FontName='微軟正黑體' x:CharSet='136' x:Family='Swiss' ss:Size='12'");
		out.println ("    ss:Color='#000000'/>");
		out.println ("  </Style>");
		out.println ("  <Style ss:ID='s63'>");
		out.println ("   <Borders>");
		out.println ("    <Border ss:Position='Bottom' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Left' ss:LineStyle='Continuous' ss:Weight='2'/>");
		out.println ("    <Border ss:Position='Right' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Top' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("   </Borders>");
		out.println ("   <Font ss:FontName='微軟正黑體' x:CharSet='136' x:Family='Swiss' ss:Size='12'");
		out.println ("    ss:Color='#000000'/>");
		out.println ("  </Style>");
		out.println ("  <Style ss:ID='s64'>");
		out.println ("   <Borders>");
		out.println ("    <Border ss:Position='Bottom' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Left' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Right' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Top' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("   </Borders>");
		out.println ("   <Font ss:FontName='微軟正黑體' x:CharSet='136' x:Family='Swiss' ss:Size='12'");
		out.println ("    ss:Color='#000000'/>");
		out.println ("  </Style>");
		out.println ("  <Style ss:ID='s65'>");
		out.println ("   <Borders>");
		out.println ("    <Border ss:Position='Bottom' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Left' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Right' ss:LineStyle='Continuous' ss:Weight='2'/>");
		out.println ("    <Border ss:Position='Top' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("   </Borders>");
		out.println ("   <Font ss:FontName='微軟正黑體' x:CharSet='136' x:Family='Swiss' ss:Size='12'");
		out.println ("    ss:Color='#000000'/>");
		out.println ("  </Style>");
		out.println ("  <Style ss:ID='s69'>");
		out.println ("   <Alignment ss:Horizontal='Center' ss:Vertical='Center'/>");
		out.println ("   <Font ss:FontName='微軟正黑體' x:CharSet='136' x:Family='Swiss' ss:Size='12'");
		out.println ("    ss:Color='#000000'/>");
		out.println ("  </Style>");
		out.println ("  <Style ss:ID='s70'>");
		out.println ("   <Alignment ss:Horizontal='Center' ss:Vertical='Center'/>");
		out.println ("   <Borders>");
		out.println ("    <Border ss:Position='Bottom' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Left' ss:LineStyle='Continuous' ss:Weight='2'/>");
		out.println ("    <Border ss:Position='Right' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Top' ss:LineStyle='Continuous' ss:Weight='2'/>");
		out.println ("   </Borders>");
		out.println ("   <Font ss:FontName='微軟正黑體' x:CharSet='136' x:Family='Swiss' ss:Size='12'");
		out.println ("    ss:Color='#000000'/>");
		out.println ("  </Style>");
		out.println ("  <Style ss:ID='s71'>");
		out.println ("   <Alignment ss:Horizontal='Center' ss:Vertical='Center'/>");
		out.println ("   <Borders>");
		out.println ("    <Border ss:Position='Bottom' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Left' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Right' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Top' ss:LineStyle='Continuous' ss:Weight='2'/>");
		out.println ("   </Borders>");
		out.println ("   <Font ss:FontName='微軟正黑體' x:CharSet='136' x:Family='Swiss' ss:Size='12'");
		out.println ("    ss:Color='#000000'/>");
		out.println ("  </Style>");
		out.println ("  <Style ss:ID='s72'>");
		out.println ("   <Alignment ss:Horizontal='Center' ss:Vertical='Center'/>");
		out.println ("   <Borders>");
		out.println ("    <Border ss:Position='Bottom' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Left' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Right' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Top' ss:LineStyle='Continuous' ss:Weight='2'/>");
		out.println ("   </Borders>");
		out.println ("   <Font ss:FontName='微軟正黑體' x:CharSet='136' x:Family='Swiss' ss:Color='#000000'/>");
		out.println ("  </Style>");
		out.println ("  <Style ss:ID='s73'>");
		out.println ("   <Alignment ss:Horizontal='Center' ss:Vertical='Center'/>");
		out.println ("   <Borders>");
		out.println ("    <Border ss:Position='Bottom' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Left' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Right' ss:LineStyle='Continuous' ss:Weight='2'/>");
		out.println ("    <Border ss:Position='Top' ss:LineStyle='Continuous' ss:Weight='2'/>");
		out.println ("   </Borders>");
		out.println ("   <Font ss:FontName='微軟正黑體' x:CharSet='136' x:Family='Swiss' ss:Color='#000000'/>");
		out.println ("  </Style>");
		out.println (" </Styles>");
		out.println (" <Worksheet ss:Name='工作表1'>");
		out.println ("  <Names>");
		out.println ("   <NamedRange ss:Name='Print_Titles' ss:RefersTo='=工作表1!R1'/>");
		out.println ("  </Names>");
		out.println ("  <Table ss:ExpandedColumnCount='14' ss:ExpandedRowCount='"+(students.size()+999)+"' x:FullColumns='1'");
		out.println ("   x:FullRows='1' ss:StyleID='s62' ss:DefaultColumnWidth='54'");
		out.println ("   ss:DefaultRowHeight='15.75'>");
		out.println ("   <Column ss:StyleID='s63' ss:AutoFitWidth='0' ss:Width='87.75'/>");
		out.println ("   <Column ss:StyleID='s64' ss:AutoFitWidth='0' ss:Width='75.75'/>");
		out.println ("   <Column ss:StyleID='s64' ss:AutoFitWidth='0' ss:Width='48'/>");
		out.println ("   <Column ss:StyleID='s64' ss:AutoFitWidth='0' ss:Width='34.5' ss:Span='9'/>");
		out.println ("   <Column ss:Index='14' ss:StyleID='s65' ss:AutoFitWidth='0' ss:Width='34.5'/>");
		out.println ("   <Row ss:AutoFitHeight='0' ss:StyleID='s69'>");
		out.println ("    <Cell ss:StyleID='s70'><Data ss:Type='String'>班級</Data><NamedCell");
		out.println ("      ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell ss:StyleID='s71'><Data ss:Type='String'>學號</Data><NamedCell");
		out.println ("      ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell ss:StyleID='s71'><Data ss:Type='String'>姓名</Data><NamedCell");
		out.println ("      ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell ss:StyleID='s72'><Data ss:Type='String'>第1次</Data><NamedCell");
		out.println ("      ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell ss:StyleID='s72'><Data ss:Type='String'>第2次</Data><NamedCell");
		out.println ("      ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell ss:StyleID='s72'><Data ss:Type='String'>第3次</Data><NamedCell");
		out.println ("      ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell ss:StyleID='s72'><Data ss:Type='String'>第4次</Data><NamedCell");
		out.println ("      ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell ss:StyleID='s72'><Data ss:Type='String'>第5次</Data><NamedCell");
		out.println ("      ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell ss:StyleID='s72'><Data ss:Type='String'>第6次</Data><NamedCell");
		out.println ("      ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell ss:StyleID='s72'><Data ss:Type='String'>第7次</Data><NamedCell");
		out.println ("      ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell ss:StyleID='s72'><Data ss:Type='String'>第8次</Data><NamedCell");
		out.println ("      ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell ss:StyleID='s72'><Data ss:Type='String'>第9次</Data><NamedCell");
		out.println ("      ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell ss:StyleID='s72'><Data ss:Type='String'>第10次</Data><NamedCell");
		out.println ("      ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell ss:StyleID='s73'><Data ss:Type='String'>平均</Data><NamedCell");
		out.println ("      ss:Name='Print_Titles'/></Cell>");
		out.println ("   </Row>");
		
		//int tot, cnt;
		for(int i=0; i<students.size(); i++){
			out.println ("   <Row ss:AutoFitHeight='0'>");
			out.println ("    <Cell><Data ss:Type='String'>"+students.get(i).get("ClassName")+"</Data></Cell>");
			out.println ("    <Cell><Data ss:Type='String'>"+students.get(i).get("student_no")+"</Data></Cell>");
			out.println ("    <Cell><Data ss:Type='String'>"+students.get(i).get("student_name")+"</Data></Cell>");			
			for(int j=1; j<=9; j++){
				if(students.get(i).get("score0"+j)==null){
					out.println ("    <Cell><Data ss:Type='String'></Data></Cell>");
				}else{
					out.println ("    <Cell><Data ss:Type='Number'>"+students.get(i).get("score0"+j)+"</Data></Cell>");
				}				
			}
			if(students.get(i).get("score10")==null){
				out.println ("    <Cell><Data ss:Type='String'></Data></Cell>");
			}else{
				out.println ("    <Cell><Data ss:Type='Number'>"+students.get(i).get("score10")+"</Data></Cell>");
			}
			
			
			if(students.get(i).get("score1")==null){
				out.println ("    <Cell><Data ss:Type='String'></Data></Cell>");
			}else{
				out.println ("    <Cell><Data ss:Type='Number'>"+students.get(i).get("score1")+"</Data></Cell>");
			}
				
			
			out.println ("   </Row>");
		}
		
		Map info=df.sqlGetMap("SELECT e.cname, cs.chi_name,  cdo.name as opt, d.thour, d.credit, (SELECT COUNT(*)FROM Seld WHERE Dtime_oid=d.Oid)as cnt FROM "
				+ "Dtime d, Csno cs, CODE_DTIME_OPT cdo, empl e WHERE e.idno=d.techid AND d.opt=cdo.id AND d.cscode=cs.cscode AND d.Oid="+Dtime_oid);
		out.println ("  </Table>");
		out.println ("  <WorksheetOptions xmlns='urn:schemas-microsoft-com:office:excel'>");
		out.println ("   <PageSetup>");
		out.println ("    <Header x:Margin='0.31496062992125984'");
		out.println ("     x:Data='&amp;L&amp;8"+info.get("opt")+", "+info.get("credit")+"學分, "+info.get("thour")+"小時, &#10;學生"+info.get("cnt")+"人&#10;授課教師 "+info.get("cname")+"&amp;C&amp;&quot;微軟正黑體,標準&quot;中華科技大學 105學年第 1學期四技資管三乙成績冊&#10;資料庫程式設計'/>");
		out.println ("    <Footer x:Margin='0.31496062992125984' x:Data='&amp;L&amp;D&amp;R&amp;P/&amp;N'/>");
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
		out.println ("   <PageBreakZoom>60</PageBreakZoom>");
		out.println ("   <Selected/>");
		out.println ("   <FreezePanes/>");
		out.println ("   <FrozenNoSplit/>");
		out.println ("   <SplitHorizontal>1</SplitHorizontal>");
		out.println ("   <TopRowBottomPane>1</TopRowBottomPane>");
		out.println ("   <ActivePane>2</ActivePane>");
		out.println ("   <Panes>");
		out.println ("    <Pane>");
		out.println ("     <Number>3</Number>");
		out.println ("    </Pane>");
		out.println ("    <Pane>");
		out.println ("     <Number>2</Number>");
		out.println ("     <ActiveRow>13</ActiveRow>");
		out.println ("     <ActiveCol>17</ActiveCol>");
		out.println ("    </Pane>");
		out.println ("   </Panes>");
		out.println ("   <ProtectObjects>False</ProtectObjects>");
		out.println ("   <ProtectScenarios>False</ProtectScenarios>");
		out.println ("  </WorksheetOptions>");
		out.println (" </Worksheet>");
		out.println ("</Workbook>");
		
		out.close();
		out.flush();
		return null;
	}

}

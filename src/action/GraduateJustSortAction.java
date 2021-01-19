package action;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import model.Message;

public class GraduateJustSortAction extends BasePrintXmlAction{
	
	public String cono;
	public String stno;
	public String cno;
	public String sno;
	public String dno;
	public String gno;
	public String zno;
	public String clsNo;
	public String stdNo[];
	public String certificate[];
	public String practice[];
	public String check[];
	public String execute() {
		
		search();
		
		
		return SUCCESS;
	}
	
	public String creatSearch() {
		
		search();
		return SUCCESS;
	}
	
	private void search() {	
		
		List<Map>cls=df.sqlGet("SELECT (SELECT COUNT(*)FROM gradresu, stmd, Class WHERE gradresu.student_no=stmd.student_no AND stmd.depart_class=Class.ClassNo AND ClassNo=c.ClassNo AND certificate='Y')as certificate, "
				+ "(SELECT COUNT(*)FROM gradresu, stmd, Class WHERE gradresu.student_no=stmd.student_no AND stmd.depart_class=Class.ClassNo AND ClassNo=c.ClassNo AND practice='Y')as practice,"
				+ "(SELECT COUNT(*)FROM gradresu, stmd, Class WHERE gradresu.student_no=stmd.student_no AND stmd.depart_class=Class.ClassNo AND ClassNo=c.ClassNo AND pass='Y')as pass,"
				+ "(SELECT COUNT(*)FROM gradresu, stmd, Class WHERE gradresu.student_no=stmd.student_no AND stmd.depart_class=Class.ClassNo AND ClassNo=c.ClassNo AND language='Y')as language,"
				+ "c.ClassNo, cs.name as csName, cd.name as cdName, c.ClassName, c.stds FROM CODE_SCHOOL cs, CODE_DEPT cd, Class c WHERE cs.id=c.SchoolNo AND cd.id=c.DeptNo AND c.stds>0 AND cd.assistant='"+getSession().getAttribute("userid")+"'ORDER BY c.ClassNo, c.Grade DESC");
		try {
			StringBuilder sql=new StringBuilder("SELECT (SELECT COUNT(*)FROM gradresu, stmd, Class WHERE gradresu.student_no=stmd.student_no AND stmd.depart_class=Class.ClassNo AND ClassNo=c.ClassNo AND certificate='Y')as certificate, "
				+ "(SELECT COUNT(*)FROM gradresu, stmd, Class WHERE gradresu.student_no=stmd.student_no AND stmd.depart_class=Class.ClassNo AND ClassNo=c.ClassNo AND practice='Y')as practice,"
				+ "(SELECT COUNT(*)FROM gradresu, stmd, Class WHERE gradresu.student_no=stmd.student_no AND stmd.depart_class=Class.ClassNo AND ClassNo=c.ClassNo AND pass='Y')as pass,"
				+ "(SELECT COUNT(*)FROM gradresu, stmd, Class WHERE gradresu.student_no=stmd.student_no AND stmd.depart_class=Class.ClassNo AND ClassNo=c.ClassNo AND language='Y')as language,"
				+ "c.ClassNo, cs.name as csName, cd.name as cdName, c.ClassName, c.stds FROM CODE_SCHOOL cs, CODE_DEPT cd, Class c WHERE cs.id=c.SchoolNo AND cd.id=c.DeptNo AND c.stds>0 ");
			if(!cno.equals(""))sql.append("AND c.CampusNo='"+cno+"'");
			if(!cono.equals(""))sql.append("AND d.college='"+cono+"'");
			if(!stno.equals(""))sql.append("AND c.SchoolType='"+stno+"'");
			if(!sno.equals(""))sql.append("AND c.SchoolNo='"+sno+"'");
			if(!dno.equals(""))sql.append("AND c.DeptNo='"+dno+"'");
			if(!gno.equals(""))sql.append("AND c.Grade='"+gno+"'");
			if(!zno.equals(""))sql.append("AND c.SeqNo='"+zno+"'");	
			sql.append("ORDER BY c.ClassNo, c.Grade DESC");
			cls.addAll(df.sqlGet(sql.toString()));
			
			
			
		}catch(Exception e) {
			//e.printStackTrace();
			
			
		}
		
		request.setAttribute("cls", cls);
	}

	public String edit() {
		
		request.setAttribute("stds", df.sqlGet("SELECT s.student_no as stdNo, s.student_name, g.* "
				+ "FROM stmd s LEFT OUTER JOIN gradresu g ON s.student_no=g.student_no WHERE "
				+ "s.depart_class='"+clsNo+"'ORDER BY s.student_no"));
		
		return SUCCESS;
	}
	
	public String save() {
		Message msg=new Message();
		String u=df.sqlGetStr("SELECT cname FROM empl WHERE idno='"+getSession().getAttribute("userid")+"'");
		//SimpleDateFormat sf=new SimpleDateFormat("yyyy-MM-dd HH:mm");
		//String now=sf.format(new Date());
		for(int i=0; i<stdNo.length; i++) {
			if(!check[i].equals(""))
			try {
				
				df.exSql("INSERT INTO gradresu(student_no, certificate, practice) VALUES('"+stdNo[i]+"', '"+certificate[i]+"', '"+practice[i]+"') ON DUPLICATE KEY UPDATE certificate='"+certificate[i]+"', practice='"+practice[i]+"'");
			
				df.exSql("INSERT INTO gradresuHist(student_no,note)VALUES('"+stdNo[i]+"','"+u+"編輯畢業資格');");
			}catch(Exception e) {
				msg.setError("已儲存中發現問題:"+e);
				e.printStackTrace();
			}
		}		
		msg.setSuccess("已儲存");
		this.savMessage(msg);
		return edit();
	}
	
	public String print() throws IOException {
		
		Date date=new Date();
		SimpleDateFormat sf=new SimpleDateFormat("yyyy/MM/dd HH:mm");
		xml2ods(response, getRequest(), date);
		
		PrintWriter out=response.getWriter();		
		
		List<Map>stds=df.sqlGet("SELECT c.ClassName, s.student_no as stdNo, s.student_name, g.* "
				+ "FROM stmd s LEFT OUTER JOIN gradresu g ON s.student_no=g.student_no, Class c WHERE "
				+ "c.ClassNo=s.depart_class AND s.depart_class='"+clsNo+"'ORDER BY s.student_no");
		
		
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
		out.println ("  <Created>2019-11-22T00:33:34Z</Created>");
		out.println ("  <LastSaved>2019-11-22T00:33:34Z</LastSaved>");
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
		out.println ("   <Borders>");
		out.println ("    <Border ss:Position='Bottom' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Left' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Right' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Top' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("   </Borders>");
		out.println ("  </Style>");
		out.println ("  <Style ss:ID='s63'>");
		out.println ("   <Borders>");
		out.println ("    <Border ss:Position='Bottom' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Left' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Right' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Top' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("   </Borders>");
		out.println ("   <Font ss:FontName='新細明體' x:CharSet='136' x:Family='Roman' ss:Size='12'");
		out.println ("    ss:Color='#000000' ss:Bold='1'/>");
		out.println ("  </Style>");
		out.println ("  <Style ss:ID='s64'>");
		out.println ("   <Borders>");
		out.println ("    <Border ss:Position='Bottom' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Left' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Right' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Top' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("   </Borders>");
		out.println ("   <Font ss:FontName='新細明體' x:CharSet='136' x:Family='Roman' ss:Size='12'");
		out.println ("    ss:Color='#000000' ss:Bold='1'/>");
		out.println ("   <NumberFormat ss:Format='@'/>");
		out.println ("  </Style>");
		out.println ("  <Style ss:ID='s65'>");
		out.println ("   <Borders>");
		out.println ("    <Border ss:Position='Bottom' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Left' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Right' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Top' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("   </Borders>");
		out.println ("   <NumberFormat ss:Format='@'/>");
		out.println ("  </Style>");
		out.println (" </Styles>");
		out.println (" <Worksheet ss:Name='file'>");
		out.println ("  <Table ss:ExpandedColumnCount='19' ss:ExpandedRowCount='"+(stds.size()+99)+"' x:FullColumns='1'");
		out.println ("   x:FullRows='1' ss:DefaultColumnWidth='54' ss:DefaultRowHeight='16.5'>");
		out.println ("   <Column ss:StyleID='s65' ss:Width='102.75'/>");
		out.println ("   <Column ss:StyleID='s65' ss:Width='70.5'/>");
		out.println ("   <Column ss:StyleID='s62' ss:Width='48'/>");
		out.println ("   <Column ss:StyleID='s62' ss:Width='35.25' ss:Span='15'/>");
		out.println ("   <Row>");
		out.println ("    <Cell ss:StyleID='s64'><Data ss:Type='String'>9班級</Data></Cell>");
		out.println ("    <Cell ss:StyleID='s64'><Data ss:Type='String'>學號</Data></Cell>");
		out.println ("    <Cell ss:StyleID='s63'><Data ss:Type='String'>姓名</Data></Cell>");
		out.println ("    <Cell ss:StyleID='s63'><Data ss:Type='String'>必修</Data></Cell>");
		out.println ("    <Cell ss:StyleID='s63'><Data ss:Type='String'>已修</Data></Cell>");
		out.println ("    <Cell ss:StyleID='s63'><Data ss:Type='String'>未過</Data></Cell>");
		out.println ("    <Cell ss:StyleID='s63'><Data ss:Type='String'>通識</Data></Cell>");
		out.println ("    <Cell ss:StyleID='s63'><Data ss:Type='String'>已修</Data></Cell>");
		out.println ("    <Cell ss:StyleID='s63'><Data ss:Type='String'>未過</Data></Cell>");
		out.println ("    <Cell ss:StyleID='s63'><Data ss:Type='String'>選修</Data></Cell>");
		out.println ("    <Cell ss:StyleID='s63'><Data ss:Type='String'>已修</Data></Cell>");
		out.println ("    <Cell ss:StyleID='s63'><Data ss:Type='String'>未過</Data></Cell>");
		out.println ("    <Cell ss:StyleID='s63'><Data ss:Type='String'>語言</Data></Cell>");
		out.println ("    <Cell ss:StyleID='s63'><Data ss:Type='String'>證照</Data></Cell>");
		out.println ("    <Cell ss:StyleID='s63'><Data ss:Type='String'>實習</Data></Cell>");
		out.println ("    <Cell ss:StyleID='s63'><Data ss:Type='String'>審查</Data></Cell>");
		out.println ("   </Row>");
		for(int i=0; i<stds.size(); i++) {
			
			out.println ("   <Row>");
			out.println ("    <Cell><Data ss:Type='String'>"+stds.get(i).get("ClassName")+"</Data></Cell>");
			out.println ("    <Cell><Data ss:Type='String'>"+stds.get(i).get("stdNo")+"</Data></Cell>");
			out.println ("    <Cell><Data ss:Type='String'>"+stds.get(i).get("student_name")+"</Data></Cell>");
			out.println ("    <Cell ss:Index='5'><Data ss:Type='String'>"+stds.get(i).get("hist_credit1")+"</Data></Cell>");
			out.println ("    <Cell><Data ss:Type='String'>"+stds.get(i).get("curr_credit1")+"</Data></Cell>");
			out.println ("    <Cell ss:Index='8'><Data ss:Type='String'>"+stds.get(i).get("hist_credit2")+"</Data></Cell>");
			out.println ("    <Cell><Data ss:Type='String'>"+stds.get(i).get("curr_credit2")+"</Data></Cell>");
			out.println ("    <Cell ss:Index='11'><Data ss:Type='String'>"+stds.get(i).get("hist_credit3")+"</Data></Cell>");
			out.println ("    <Cell><Data ss:Type='String'>"+stds.get(i).get("curr_credit3")+"</Data></Cell>");
			//out.println ("    <Cell ><Data ss:Type='String'></Data></Cell>");
			out.println ("    <Cell ><Data ss:Type='String'>"+stds.get(i).get("language")+"</Data></Cell>");
			//out.println ("    <Cell ><Data ss:Type='String'></Data></Cell>");
			out.println ("    <Cell ><Data ss:Type='String'>"+stds.get(i).get("certificate")+"</Data></Cell>");
			//out.println ("    <Cell ><Data ss:Type='String'></Data></Cell>");
			out.println ("    <Cell ><Data ss:Type='String'>"+stds.get(i).get("practice")+"</Data></Cell>");
			if(stds.get(i).get("pass")!=null) {
				if(stds.get(i).get("pass").equals("Y")) {
					out.println ("    <Cell><Data ss:Type='String'>Y</Data></Cell>");
				}				
			}else {
				out.println ("    <Cell><Data ss:Type='String'></Data></Cell>");
			}
			
			out.println ("   </Row>");
			
		}
		
		
		
		out.println ("  </Table>");
		out.println ("  <WorksheetOptions xmlns='urn:schemas-microsoft-com:office:excel'>");
		out.println ("   <PageSetup>");
		out.println ("    <Layout x:Orientation='Landscape'/>");
		out.println ("    <Header x:Margin='0.3' x:Data='&amp;C&amp;&quot;標楷體,標準&quot;&amp;24列印畢業資格的審查結果'/>");
		out.println ("    <Footer x:Margin='0.3' x:Data='&amp;L&amp;D&amp;R&amp;P/&amp;N'/>");
		out.println ("    <PageMargins x:Bottom='0.75' x:Left='0.7' x:Right='0.7' x:Top='0.75'/>");
		out.println ("   </PageSetup>");
		out.println ("   <Print>");
		out.println ("    <ValidPrinterInfo/>");
		out.println ("    <PaperSizeIndex>9</PaperSizeIndex>");
		out.println ("    <HorizontalResolution>-1</HorizontalResolution>");
		out.println ("    <VerticalResolution>-1</VerticalResolution>");
		out.println ("   </Print>");
		out.println ("   <Selected/>");
		out.println ("   <Panes>");
		out.println ("    <Pane>");
		out.println ("     <Number>3</Number>");
		out.println ("     <ActiveRow>7</ActiveRow>");
		out.println ("     <ActiveCol>9</ActiveCol>");
		out.println ("    </Pane>");
		out.println ("   </Panes>");
		out.println ("   <ProtectObjects>False</ProtectObjects>");
		out.println ("   <ProtectScenarios>False</ProtectScenarios>");
		out.println ("  </WorksheetOptions>");
		out.println (" </Worksheet>");
		out.println ("</Workbook>");
		out.println ("");
		out.close();
		out.flush();
		
		
		return null;
	}
}

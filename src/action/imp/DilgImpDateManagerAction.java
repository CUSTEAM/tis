package action.imp;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;
import java.util.Map;

import action.BasePrintXmlAction;
import model.Message;

public class DilgImpDateManagerAction extends BasePrintXmlAction{
	
	public String name;
	public String date,begin,end;
	public String cls;
	public String Oid;
	public String impOid[];
	
	public String cno, sno, stno, cono, dno, gno, zno;
	
	public String execute(){
		request.setAttribute("alldate", df.sqlGet("SELECT (SELECT COUNT(*)FROM Dilg_imp_class WHERE Dilg_imp_date_oid=d.Oid)as cnt, d.*, e.cname FROM Dilg_imp_date d LEFT OUTER JOIN empl e ON d.empl_oid=e.Oid"));
		return SUCCESS;
	}
	
	public String create(){
		Message msg=new Message();
		if(begin.trim().equals("")||end.trim().equals("")||name.trim().equals("")||date.trim().equals("")){
			
			msg.setError("請檢查欄位");
			this.savMessage(msg);
			return execute();
		}
		
		df.exSql("INSERT INTO Dilg_imp_date(name,date,empl_oid,cls,begin,end)VALUES('"+name+"','"+date+"','"+df.sqlGetStr("SELECT Oid FROM empl WHERE idno='"+getSession().getAttribute("userid")+"'")+"','"+cls+"','"+begin+"','"+end+"');");
		msg.setSuccess("集會已建立, 請於列表中點選此集會以設定點名範圍");
		this.savMessage(msg);
		return execute();
	}
	
	public String delete(){
		
		Message msg=new Message();
		df.exSql("DELETE FROM Dilg_imp_date WHERE Oid="+Oid);
		df.exSql("DELETE FROM Dilg_imp_class WHERE Dilg_imp_date_oid="+Oid);
		df.exSql("DELETE FROM Dilg_imp WHERE Dilg_imp_date_oid="+Oid);
		msg.setSuccess("集會已刪除, 包含相關設定與點名狀況");
		this.savMessage(msg);
		return execute();
	}
	
	public String edit(){
		
		request.setAttribute("Oid", Oid);
		request.setAttribute("cls", df.sqlGet("SELECT d.edit, d.Oid as impOid, e.cname, c.ClassNo, "
		+ "c.ClassName, (SELECT COUNT(*)FROM stmd WHERE depart_class=c.ClassNo)as cnt FROM "
		+ "Dilg_imp_class d, Class c LEFT OUTER JOIN empl e ON c.tutor=e.idno WHERE "
		+ "d.ClassNo=c.ClassNo AND d.Dilg_imp_date_oid="+Oid));
		
		return "edit";
	}
	
	public String addClass(){
		
		StringBuilder sql=new StringBuilder("INSERT INTO Dilg_imp_class(Dilg_imp_date_oid, ClassNo)SELECT '"+Oid+"',ClassNo FROM Class WHERE CampusNo='"+cno+"'");
		if(!stno.equals(""))sql.append("AND SchoolType='"+stno+"'");
		if(!sno.equals(""))sql.append("AND SchoolNo='"+sno+"'");
		if(!cono.equals(""))sql.append("AND InstNo='"+cono+"'");
		if(!dno.equals(""))sql.append("AND DeptNo='"+dno+"'");
		if(!gno.equals(""))sql.append("AND Grade='"+gno+"'");
		if(!zno.equals(""))sql.append("AND SeqNo='"+zno+"'");
		sql.append("AND Type='P'ON DUPLICATE KEY UPDATE Dilg_imp_date_oid='"+Oid+"';");
		df.exSql(sql.toString());
		
		Message msg=new Message();
		msg.setMsg("已增加班級");
		this.savMessage(msg);
		return edit();
	}
	
	public String delClass(){
		
		for(int i=0; i<impOid.length; i++){
			
			df.exSql("DELETE FROM Dilg_imp_class WHERE Oid="+impOid[i]);
		}
		
		return edit();
	}
	
	/**
	 * 獎懲名單
	 * @return
	 * @throws IOException 
	 */
	public String printNote() throws IOException{
		
		Date date=new Date();
		xml2ods(response, getRequest(), date);		
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
		out.println ("  <LastPrinted>2016-04-11T07:50:36Z</LastPrinted>");
		out.println ("  <Created>2016-04-11T07:39:01Z</Created>");
		out.println ("  <LastSaved>2016-04-11T08:44:09Z</LastSaved>");
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
		out.println ("  <Style ss:ID='m225036094544'>");
		out.println ("   <Alignment ss:Horizontal='Justify' ss:Vertical='Center' ss:WrapText='1'/>");
		out.println ("   <Borders>");
		out.println ("    <Border ss:Position='Bottom' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Left' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Right' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Top' ss:LineStyle='Continuous' ss:Weight='2'/>");
		out.println ("   </Borders>");
		out.println ("   <Font ss:FontName='微軟正黑體' x:CharSet='136' x:Family='Swiss' ss:Size='12'");
		out.println ("    ss:Color='#000000'/>");
		out.println ("  </Style>");
		out.println ("  <Style ss:ID='m225036094584'>");
		out.println ("   <Alignment ss:Horizontal='Justify' ss:Vertical='Center' ss:WrapText='1'/>");
		out.println ("   <Borders>");
		out.println ("    <Border ss:Position='Bottom' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Left' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Right' ss:LineStyle='Continuous' ss:Weight='2'/>");
		out.println ("    <Border ss:Position='Top' ss:LineStyle='Continuous' ss:Weight='2'/>");
		out.println ("   </Borders>");
		out.println ("   <Font ss:FontName='微軟正黑體' x:CharSet='136' x:Family='Swiss' ss:Size='12'");
		out.println ("    ss:Color='#000000'/>");
		out.println ("  </Style>");
		out.println ("  <Style ss:ID='m225038084464'>");
		out.println ("   <Alignment ss:Horizontal='Justify' ss:Vertical='Center' ss:WrapText='1'/>");
		out.println ("   <Borders>");
		out.println ("    <Border ss:Position='Bottom' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Left' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Right' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Top' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("   </Borders>");
		out.println ("   <Font ss:FontName='微軟正黑體' x:CharSet='136' x:Family='Swiss' ss:Size='12'");
		out.println ("    ss:Color='#000000'/>");
		out.println ("  </Style>");
		out.println ("  <Style ss:ID='m225038084484'>");
		out.println ("   <Alignment ss:Horizontal='Justify' ss:Vertical='Center' ss:WrapText='1'/>");
		out.println ("   <Borders>");
		out.println ("    <Border ss:Position='Bottom' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Left' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Right' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Top' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("   </Borders>");
		out.println ("   <Font ss:FontName='微軟正黑體' x:CharSet='136' x:Family='Swiss' ss:Size='12'");
		out.println ("    ss:Color='#000000'/>");
		out.println ("  </Style>");
		out.println ("  <Style ss:ID='m225038084524'>");
		out.println ("   <Alignment ss:Horizontal='Justify' ss:Vertical='Center' ss:WrapText='1'/>");
		out.println ("   <Borders>");
		out.println ("    <Border ss:Position='Bottom' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Left' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Right' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Top' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("   </Borders>");
		out.println ("   <Font ss:FontName='微軟正黑體' x:CharSet='136' x:Family='Swiss' ss:Size='12'");
		out.println ("    ss:Color='#000000'/>");
		out.println ("  </Style>");
		out.println ("  <Style ss:ID='m225038084564'>");
		out.println ("   <Alignment ss:Horizontal='Justify' ss:Vertical='Center' ss:WrapText='1'/>");
		out.println ("   <Borders>");
		out.println ("    <Border ss:Position='Bottom' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Left' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Right' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Top' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("   </Borders>");
		out.println ("   <Font ss:FontName='微軟正黑體' x:CharSet='136' x:Family='Swiss' ss:Size='12'");
		out.println ("    ss:Color='#000000'/>");
		out.println ("  </Style>");
		out.println ("  <Style ss:ID='m225038084604'>");
		out.println ("   <Alignment ss:Horizontal='Justify' ss:Vertical='Center' ss:WrapText='1'/>");
		out.println ("   <Borders>");
		out.println ("    <Border ss:Position='Bottom' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Left' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Right' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Top' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("   </Borders>");
		out.println ("   <Font ss:FontName='微軟正黑體' x:CharSet='136' x:Family='Swiss' ss:Size='12'");
		out.println ("    ss:Color='#000000'/>");
		out.println ("  </Style>");
		out.println ("  <Style ss:ID='m225038093200'>");
		out.println ("   <Alignment ss:Horizontal='Center' ss:Vertical='Center' ss:WrapText='1'/>");
		out.println ("   <Borders>");
		out.println ("    <Border ss:Position='Bottom' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Left' ss:LineStyle='Continuous' ss:Weight='2'/>");
		out.println ("    <Border ss:Position='Right' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Top' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("   </Borders>");
		out.println ("   <Font ss:FontName='微軟正黑體' x:CharSet='136' x:Family='Swiss' ss:Size='14'");
		out.println ("    ss:Color='#000000'/>");
		out.println ("  </Style>");
		out.println ("  <Style ss:ID='m225038093220'>");
		out.println ("   <Alignment ss:Horizontal='Center' ss:Vertical='Center' ss:WrapText='1'/>");
		out.println ("   <Borders>");
		out.println ("    <Border ss:Position='Bottom' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Left' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Right' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Top' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("   </Borders>");
		out.println ("   <Font ss:FontName='微軟正黑體' x:CharSet='136' x:Family='Swiss' ss:Size='14'");
		out.println ("    ss:Color='#000000'/>");
		out.println ("  </Style>");
		out.println ("  <Style ss:ID='m225038093240'>");
		out.println ("   <Alignment ss:Horizontal='Center' ss:Vertical='Center' ss:WrapText='1'/>");
		out.println ("   <Borders>");
		out.println ("    <Border ss:Position='Bottom' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Left' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Right' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Top' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("   </Borders>");
		out.println ("   <Font ss:FontName='微軟正黑體' x:CharSet='136' x:Family='Swiss' ss:Size='14'");
		out.println ("    ss:Color='#000000'/>");
		out.println ("  </Style>");
		out.println ("  <Style ss:ID='m225038093260'>");
		out.println ("   <Alignment ss:Horizontal='Center' ss:Vertical='Center' ss:WrapText='1'/>");
		out.println ("   <Borders>");
		out.println ("    <Border ss:Position='Bottom' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Left' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Right' ss:LineStyle='Continuous' ss:Weight='2'/>");
		out.println ("    <Border ss:Position='Top' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("   </Borders>");
		out.println ("   <Font ss:FontName='微軟正黑體' x:CharSet='136' x:Family='Swiss' ss:Size='14'");
		out.println ("    ss:Color='#000000'/>");
		out.println ("  </Style>");
		out.println ("  <Style ss:ID='m225038093280'>");
		out.println ("   <Alignment ss:Horizontal='Center' ss:Vertical='Center' ss:WrapText='1'/>");
		out.println ("   <Borders>");
		out.println ("    <Border ss:Position='Bottom' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Left' ss:LineStyle='Continuous' ss:Weight='2'/>");
		out.println ("    <Border ss:Position='Right' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Top' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("   </Borders>");
		out.println ("   <Font ss:FontName='微軟正黑體' x:CharSet='136' x:Family='Swiss' ss:Size='14'");
		out.println ("    ss:Color='#000000'/>");
		out.println ("  </Style>");
		out.println ("  <Style ss:ID='m225038093300'>");
		out.println ("   <Alignment ss:Horizontal='Center' ss:Vertical='Center' ss:WrapText='1'/>");
		out.println ("   <Borders>");
		out.println ("    <Border ss:Position='Bottom' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Left' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Right' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Top' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("   </Borders>");
		out.println ("   <Font ss:FontName='微軟正黑體' x:CharSet='136' x:Family='Swiss' ss:Size='14'");
		out.println ("    ss:Color='#000000'/>");
		out.println ("  </Style>");
		out.println ("  <Style ss:ID='m225038093320'>");
		out.println ("   <Alignment ss:Horizontal='Center' ss:Vertical='Center' ss:WrapText='1'/>");
		out.println ("   <Borders>");
		out.println ("    <Border ss:Position='Bottom' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Left' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Right' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Top' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("   </Borders>");
		out.println ("   <Font ss:FontName='微軟正黑體' x:CharSet='136' x:Family='Swiss' ss:Size='14'");
		out.println ("    ss:Color='#000000'/>");
		out.println ("  </Style>");
		out.println ("  <Style ss:ID='m225038093340'>");
		out.println ("   <Alignment ss:Horizontal='Center' ss:Vertical='Center' ss:WrapText='1'/>");
		out.println ("   <Borders>");
		out.println ("    <Border ss:Position='Bottom' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Left' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Right' ss:LineStyle='Continuous' ss:Weight='2'/>");
		out.println ("    <Border ss:Position='Top' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("   </Borders>");
		out.println ("   <Font ss:FontName='微軟正黑體' x:CharSet='136' x:Family='Swiss' ss:Size='14'");
		out.println ("    ss:Color='#000000'/>");
		out.println ("  </Style>");
		out.println ("  <Style ss:ID='m225038083792'>");
		out.println ("   <Alignment ss:Horizontal='Center' ss:Vertical='Center' ss:WrapText='1'/>");
		out.println ("   <Borders>");
		out.println ("    <Border ss:Position='Bottom' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Left' ss:LineStyle='Continuous' ss:Weight='2'/>");
		out.println ("    <Border ss:Position='Right' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Top' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("   </Borders>");
		out.println ("   <Font ss:FontName='微軟正黑體' x:CharSet='136' x:Family='Swiss' ss:Size='14'");
		out.println ("    ss:Color='#000000'/>");
		out.println ("  </Style>");
		out.println ("  <Style ss:ID='m225038083812'>");
		out.println ("   <Alignment ss:Horizontal='Center' ss:Vertical='Center' ss:WrapText='1'/>");
		out.println ("   <Borders>");
		out.println ("    <Border ss:Position='Bottom' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Left' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Right' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Top' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("   </Borders>");
		out.println ("   <Font ss:FontName='微軟正黑體' x:CharSet='136' x:Family='Swiss' ss:Size='14'");
		out.println ("    ss:Color='#000000'/>");
		out.println ("  </Style>");
		out.println ("  <Style ss:ID='m225038083832'>");
		out.println ("   <Alignment ss:Horizontal='Center' ss:Vertical='Center' ss:WrapText='1'/>");
		out.println ("   <Borders>");
		out.println ("    <Border ss:Position='Bottom' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Left' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Right' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Top' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("   </Borders>");
		out.println ("   <Font ss:FontName='微軟正黑體' x:CharSet='136' x:Family='Swiss' ss:Size='14'");
		out.println ("    ss:Color='#000000'/>");
		out.println ("  </Style>");
		out.println ("  <Style ss:ID='m225038083852'>");
		out.println ("   <Alignment ss:Horizontal='Center' ss:Vertical='Center' ss:WrapText='1'/>");
		out.println ("   <Borders>");
		out.println ("    <Border ss:Position='Bottom' ss:LineStyle='Continuous' ss:Weight='2'/>");
		out.println ("    <Border ss:Position='Left' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Right' ss:LineStyle='Continuous' ss:Weight='2'/>");
		out.println ("    <Border ss:Position='Top' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("   </Borders>");
		out.println ("   <Font ss:FontName='微軟正黑體' x:CharSet='136' x:Family='Swiss' ss:Size='14'");
		out.println ("    ss:Color='#000000'/>");
		out.println ("  </Style>");
		out.println ("  <Style ss:ID='m225038083872'>");
		out.println ("   <Alignment ss:Horizontal='Center' ss:Vertical='Center' ss:WrapText='1'/>");
		out.println ("   <Borders>");
		out.println ("    <Border ss:Position='Bottom' ss:LineStyle='Continuous' ss:Weight='2'/>");
		out.println ("    <Border ss:Position='Left' ss:LineStyle='Continuous' ss:Weight='2'/>");
		out.println ("    <Border ss:Position='Right' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Top' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("   </Borders>");
		out.println ("   <Font ss:FontName='微軟正黑體' x:CharSet='136' x:Family='Swiss' ss:Size='14'");
		out.println ("    ss:Color='#000000'/>");
		out.println ("  </Style>");
		out.println ("  <Style ss:ID='m225038083892'>");
		out.println ("   <Alignment ss:Horizontal='Center' ss:Vertical='Center' ss:WrapText='1'/>");
		out.println ("   <Borders>");
		out.println ("    <Border ss:Position='Bottom' ss:LineStyle='Continuous' ss:Weight='2'/>");
		out.println ("    <Border ss:Position='Left' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Right' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Top' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("   </Borders>");
		out.println ("   <Font ss:FontName='微軟正黑體' x:CharSet='136' x:Family='Swiss' ss:Size='14'");
		out.println ("    ss:Color='#000000'/>");
		out.println ("  </Style>");
		out.println ("  <Style ss:ID='m225038083912'>");
		out.println ("   <Alignment ss:Horizontal='Center' ss:Vertical='Center' ss:WrapText='1'/>");
		out.println ("   <Borders>");
		out.println ("    <Border ss:Position='Bottom' ss:LineStyle='Continuous' ss:Weight='2'/>");
		out.println ("    <Border ss:Position='Left' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Right' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Top' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("   </Borders>");
		out.println ("   <Font ss:FontName='微軟正黑體' x:CharSet='136' x:Family='Swiss' ss:Size='14'");
		out.println ("    ss:Color='#000000'/>");
		out.println ("  </Style>");
		out.println ("  <Style ss:ID='s16'>");
		out.println ("   <Alignment ss:Horizontal='Justify' ss:Vertical='Center' ss:WrapText='1'/>");
		out.println ("   <Borders>");
		out.println ("    <Border ss:Position='Bottom' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Left' ss:LineStyle='Continuous' ss:Weight='2'/>");
		out.println ("    <Border ss:Position='Right' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Top' ss:LineStyle='Continuous' ss:Weight='2'/>");
		out.println ("   </Borders>");
		out.println ("   <Font ss:FontName='微軟正黑體' x:CharSet='136' x:Family='Swiss' ss:Size='12'");
		out.println ("    ss:Color='#000000'/>");
		out.println ("  </Style>");
		out.println ("  <Style ss:ID='s17'>");
		out.println ("   <Alignment ss:Horizontal='Justify' ss:Vertical='Center' ss:WrapText='1'/>");
		out.println ("   <Borders>");
		out.println ("    <Border ss:Position='Bottom' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Left' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Right' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Top' ss:LineStyle='Continuous' ss:Weight='2'/>");
		out.println ("   </Borders>");
		out.println ("   <Font ss:FontName='微軟正黑體' x:CharSet='136' x:Family='Swiss' ss:Size='12'");
		out.println ("    ss:Color='#000000'/>");
		out.println ("  </Style>");
		out.println ("  <Style ss:ID='s22'>");
		out.println ("   <Font ss:FontName='微軟正黑體' x:CharSet='136' x:Family='Swiss' ss:Size='12'");
		out.println ("    ss:Color='#000000'/>");
		out.println ("  </Style>");
		out.println ("  <Style ss:ID='s23'>");
		out.println ("   <Alignment ss:Horizontal='Justify' ss:Vertical='Center' ss:WrapText='1'/>");
		out.println ("   <Borders>");
		out.println ("    <Border ss:Position='Bottom' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Left' ss:LineStyle='Continuous' ss:Weight='2'/>");
		out.println ("    <Border ss:Position='Right' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Top' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("   </Borders>");
		out.println ("   <Font ss:FontName='微軟正黑體' x:CharSet='136' x:Family='Swiss' ss:Size='12'");
		out.println ("    ss:Color='#000000'/>");
		out.println ("  </Style>");
		out.println ("  <Style ss:ID='s24'>");
		out.println ("   <Alignment ss:Horizontal='Justify' ss:Vertical='Center' ss:WrapText='1'/>");
		out.println ("   <Borders>");
		out.println ("    <Border ss:Position='Bottom' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Left' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Right' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Top' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("   </Borders>");
		out.println ("   <Font ss:FontName='微軟正黑體' x:CharSet='136' x:Family='Swiss' ss:Size='12'");
		out.println ("    ss:Color='#000000'/>");
		out.println ("  </Style>");
		out.println ("  <Style ss:ID='s28'>");
		out.println ("   <Alignment ss:Horizontal='Justify' ss:Vertical='Center' ss:WrapText='1'/>");
		out.println ("   <Borders>");
		out.println ("    <Border ss:Position='Bottom' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Left' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Right' ss:LineStyle='Continuous' ss:Weight='2'/>");
		out.println ("    <Border ss:Position='Top' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("   </Borders>");
		out.println ("   <Font ss:FontName='微軟正黑體' x:CharSet='136' x:Family='Swiss' ss:Size='12'");
		out.println ("    ss:Color='#000000'/>");
		out.println ("  </Style>");
		out.println ("  <Style ss:ID='s59'>");
		out.println ("   <Alignment ss:Vertical='Center' ss:WrapText='1'/>");
		out.println ("   <Borders>");
		out.println ("    <Border ss:Position='Bottom' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Left' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Right' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Top' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("   </Borders>");
		out.println ("   <Font ss:FontName='微軟正黑體' x:CharSet='136' x:Family='Swiss' ss:Size='12'");
		out.println ("    ss:Color='#000000'/>");
		out.println ("  </Style>");
		out.println (" </Styles>");
		
		
		
		List<Map>dept=df.sqlGet("SELECT d.* FROM CODE_DEPT d,Class c,Dilg_imp_class dic WHERE "
		+ "d.id=c.DeptNo AND dic.ClassNo=c.ClassNo AND "
		+ "dic.Dilg_imp_date_oid="+Oid+" GROUP BY c.DeptNo");
		List<Map>stds;
		int cls;
		for(int i=0; i<dept.size(); i++){
			if(dept.get(i).get("id").equals("0"))continue;
			
			stds=df.sqlGet("SELECT s.student_no, s.student_name, c.ClassName, di.cls FROM Dilg_imp di, stmd s, Class c "
			+ "WHERE di.Dilg_imp_date_oid="+Oid+" AND di.student_no=s.student_no AND s.depart_class=c.ClassNo AND c.DeptNo='"
			+dept.get(i).get("id")+"'ORDER BY c.ClassNo, s.student_no");
			
			out.println (" <Worksheet ss:Name='"+dept.get(i).get("name")+"'>");
			out.println ("  <Names>");
			out.println ("   <NamedRange ss:Name='Print_Titles' ss:RefersTo='="+dept.get(i).get("name")+"!R1'/>");
			out.println ("  </Names>");
			out.println ("  <Table ss:ExpandedColumnCount='9' ss:ExpandedRowCount='"+(stds.size()+999)+"' x:FullColumns='1'");
			out.println ("   x:FullRows='1' ss:StyleID='s22' ss:DefaultColumnWidth='54'");
			out.println ("   ss:DefaultRowHeight='15.75'>");
			out.println ("   <Column ss:StyleID='s22' ss:AutoFitWidth='0' ss:Width='100.5'/>");
			out.println ("   <Column ss:StyleID='s22' ss:AutoFitWidth='0' ss:Width='75.75'/>");
			out.println ("   <Column ss:StyleID='s22' ss:AutoFitWidth='0' ss:Width='48'/>");
			out.println ("   <Row ss:AutoFitHeight='0' ss:Height='16.5'>");
			out.println ("    <Cell ss:StyleID='s16'><Data ss:Type='String'>班級</Data><NamedCell");
			out.println ("      ss:Name='Print_Titles'/></Cell>");
			out.println ("    <Cell ss:StyleID='s17'><Data ss:Type='String'>學號</Data><NamedCell");
			out.println ("      ss:Name='Print_Titles'/></Cell>");
			out.println ("    <Cell ss:StyleID='s17'><Data ss:Type='String'>姓名</Data><NamedCell");
			out.println ("      ss:Name='Print_Titles'/></Cell>");
			out.println ("    <Cell ss:MergeAcross='1' ss:StyleID='m225036094544'><Data ss:Type='String'>獎懲事實</Data><NamedCell");
			out.println ("      ss:Name='Print_Titles'/></Cell>");
			out.println ("    <Cell ss:MergeAcross='1' ss:StyleID='s17'><Data ss:Type='String'>依   據</Data><NamedCell");
			out.println ("      ss:Name='Print_Titles'/></Cell>");
			out.println ("    <Cell ss:MergeAcross='1' ss:StyleID='m225036094584'><Data ss:Type='String'>獎懲種類</Data><NamedCell");
			out.println ("      ss:Name='Print_Titles'/></Cell>");
			out.println ("   </Row>");
			
			
			if(stds.size()>0){
				for(int j=0; j<stds.size(); j++){
					out.println ("   <Row>");
					out.println ("    <Cell ss:StyleID='s23'><Data ss:Type='String'>"+stds.get(j).get("ClassName")+"</Data></Cell>");
					out.println ("    <Cell ss:StyleID='s24'><Data ss:Type='String'>"+stds.get(j).get("student_no")+"</Data></Cell>");
					out.println ("    <Cell ss:StyleID='s24'><Data ss:Type='String'>"+stds.get(j).get("student_name")+"</Data></Cell>");
					out.println ("    <Cell ss:StyleID='s24' ss:MergeAcross='1'><Data ss:Type='String'>重大集會缺席"+stds.get(j).get("cls")+"節</Data></Cell>");
					out.println ("    <Cell ss:MergeAcross='1' ss:StyleID='s59'/>");
					
					cls=Integer.parseInt(stds.get(j).get("cls").toString());
					if(cls<3){
						out.println ("    <Cell ss:StyleID='s24'><Data ss:Type='String'>申戒</Data></Cell>");
						out.println ("    <Cell ss:StyleID='s28'><Data ss:Type='String'>"+cls+"次</Data></Cell>");
					}else{
						out.println ("    <Cell ss:StyleID='s24'><Data ss:Type='String'>小過</Data></Cell>");
						out.println ("    <Cell ss:StyleID='s28'><Data ss:Type='String'>1次</Data></Cell>");
					}
					
					out.println ("   </Row>");
				}
			}else{
				
				out.println ("   <Row>");
				out.println ("    <Cell ss:StyleID='s23'><Data ss:Type='String'>"+dept.get(i).get("name")+"</Data></Cell>");
				out.println ("    <Cell ss:StyleID='s24'><Data ss:Type='String'>無缺席記錄</Data></Cell>");
				out.println ("    <Cell ss:StyleID='s24'><Data ss:Type='String'></Data></Cell>");
				out.println ("    <Cell ss:MergeAcross='1'><Data ss:Type='String'></Data></Cell>");
				out.println ("    <Cell ss:MergeAcross='1' ss:StyleID='s59'/>");
				out.println ("    <Cell ss:StyleID='s24'><Data ss:Type='String'></Data></Cell>");
				out.println ("    <Cell ss:StyleID='s28'><Data ss:Type='String'></Data></Cell>");
				out.println ("   </Row>");
				
				
			}
			
			
			out.println ("   <Row ss:AutoFitHeight='0' ss:Height='18.75'>");
			out.println ("    <Cell ss:MergeAcross='1' ss:StyleID='m225038093200'><Data ss:Type='String'>建議人</Data></Cell>");
			out.println ("    <Cell ss:MergeAcross='1' ss:StyleID='m225038093220'><Data ss:Type='String'>生輔組組長</Data></Cell>");
			out.println ("    <Cell ss:MergeAcross='1' ss:StyleID='m225038093240'><Data ss:Type='String'>輔導教官</Data></Cell>");
			out.println ("    <Cell ss:MergeAcross='2' ss:StyleID='m225038093260'><Data ss:Type='String'>批     示</Data></Cell>");
			out.println ("   </Row>");
			out.println ("   <Row ss:AutoFitHeight='0' ss:Height='19.5'>");
			out.println ("    <Cell ss:MergeAcross='1' ss:StyleID='m225038093280'/>");
			out.println ("    <Cell ss:MergeAcross='1' ss:StyleID='m225038093300'/>");
			out.println ("    <Cell ss:MergeAcross='1' ss:StyleID='m225038093320'/>");
			out.println ("    <Cell ss:MergeAcross='2' ss:StyleID='m225038093340'><Data ss:Type='String'>學務長</Data></Cell>");
			out.println ("   </Row>");
			out.println ("   <Row ss:AutoFitHeight='0' ss:Height='18.75'>");
			out.println ("    <Cell ss:MergeAcross='1' ss:StyleID='m225038083792'/>");
			out.println ("    <Cell ss:MergeAcross='1' ss:StyleID='m225038083812'><Data ss:Type='String'>系主任</Data></Cell>");
			out.println ("    <Cell ss:MergeAcross='1' ss:StyleID='m225038083832'><Data ss:Type='String'>軍訓室主任</Data></Cell>");
			out.println ("    <Cell ss:MergeAcross='2' ss:MergeDown='1' ss:StyleID='m225038083852'/>");
			out.println ("   </Row>");
			out.println ("   <Row ss:Height='19.5'>");
			out.println ("    <Cell ss:MergeAcross='1' ss:StyleID='m225038083872'/>");
			out.println ("    <Cell ss:MergeAcross='1' ss:StyleID='m225038083892'/>");
			out.println ("    <Cell ss:MergeAcross='1' ss:StyleID='m225038083912'/>");
			out.println ("   </Row>");
			//out.println ("   <Row ss:Index='18' ss:AutoFitHeight='0' ss:Span='18'/>");
			out.println ("  </Table>");
			out.println ("  <WorksheetOptions xmlns='urn:schemas-microsoft-com:office:excel'>");
			out.println ("   <PageSetup>");
			out.println ("    <Header x:Margin='0.31496062992125984' x:Data='&amp;C&amp;&quot;標楷體,粗體&quot;&amp;20中華科技大學學生獎懲建議名單'/>");
			out.println ("    <Footer x:Margin='0.31496062992125984'/>");
			out.println ("    <PageMargins x:Bottom='0.74803149606299213' x:Left='0.23622047244094491'");
			out.println ("     x:Right='0.23622047244094491' x:Top='0.74803149606299213'/>");
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
			out.println ("     <ActiveRow>8</ActiveRow>");
			out.println ("     <ActiveCol>6</ActiveCol>");
			out.println ("     <RangeSelection>R9C7:R10C9</RangeSelection>");
			out.println ("    </Pane>");
			out.println ("   </Panes>");
			out.println ("   <ProtectObjects>False</ProtectObjects>");
			out.println ("   <ProtectScenarios>False</ProtectScenarios>");
			out.println ("  </WorksheetOptions>");
			out.println (" </Worksheet>");
			
		}
			
			
			
			out.println ("</Workbook>");
		
		
		
		
		
		
		
		
		out.close();
		out.flush();
		return null;
	}
	
	/**
	 * 各班點名狀態
	 * @return
	 * @throws IOException 
	 */
	public String printStat() throws IOException{
		Date date=new Date();
		xml2ods(response, getRequest(), date);
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
		out.println ("  <LastPrinted>2016-04-26T06:34:18Z</LastPrinted>");
		out.println ("  <Created>2016-04-26T06:21:48Z</Created>");
		out.println ("  <LastSaved>2016-04-26T06:35:45Z</LastSaved>");
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
		out.println ("   <NumberFormat ss:Format='@'/>");
		out.println ("  </Style>");
		out.println ("  <Style ss:ID='s66'>");
		out.println ("   <Borders>");
		out.println ("    <Border ss:Position='Bottom' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Left' ss:LineStyle='Continuous' ss:Weight='2'/>");
		out.println ("    <Border ss:Position='Right' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Top' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("   </Borders>");
		out.println ("   <NumberFormat ss:Format='@'/>");
		out.println ("  </Style>");
		out.println ("  <Style ss:ID='s67'>");
		out.println ("   <Borders>");
		out.println ("    <Border ss:Position='Bottom' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Left' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Right' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Top' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("   </Borders>");
		out.println ("   <NumberFormat ss:Format='@'/>");
		out.println ("  </Style>");
		out.println ("  <Style ss:ID='s68'>");
		out.println ("   <Borders>");
		out.println ("    <Border ss:Position='Bottom' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Left' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Right' ss:LineStyle='Continuous' ss:Weight='2'/>");
		out.println ("    <Border ss:Position='Top' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("   </Borders>");
		out.println ("   <NumberFormat ss:Format='@'/>");
		out.println ("  </Style>");
		out.println ("  <Style ss:ID='s72'>");
		out.println ("   <Borders>");
		out.println ("    <Border ss:Position='Bottom' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Left' ss:LineStyle='Continuous' ss:Weight='2'/>");
		out.println ("    <Border ss:Position='Right' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("   </Borders>");
		out.println ("   <NumberFormat ss:Format='@'/>");
		out.println ("  </Style>");
		out.println ("  <Style ss:ID='s73'>");
		out.println ("   <Borders>");
		out.println ("    <Border ss:Position='Bottom' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Left' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Right' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("   </Borders>");
		out.println ("   <NumberFormat ss:Format='@'/>");
		out.println ("  </Style>");
		out.println ("  <Style ss:ID='s74'>");
		out.println ("   <Borders>");
		out.println ("    <Border ss:Position='Bottom' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Left' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Right' ss:LineStyle='Continuous' ss:Weight='2'/>");
		out.println ("   </Borders>");
		out.println ("   <NumberFormat ss:Format='@'/>");
		out.println ("  </Style>");
		out.println ("  <Style ss:ID='s75'>");
		out.println ("   <Borders>");
		out.println ("    <Border ss:Position='Bottom' ss:LineStyle='Continuous' ss:Weight='2'/>");
		out.println ("    <Border ss:Position='Left' ss:LineStyle='Continuous' ss:Weight='2'/>");
		out.println ("    <Border ss:Position='Right' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Top' ss:LineStyle='Continuous' ss:Weight='2'/>");
		out.println ("   </Borders>");
		out.println ("   <Font ss:FontName='新細明體' x:CharSet='136' x:Family='Roman' ss:Size='12'");
		out.println ("    ss:Color='#000000' ss:Bold='1'/>");
		out.println ("   <NumberFormat ss:Format='@'/>");
		out.println ("  </Style>");
		out.println ("  <Style ss:ID='s76'>");
		out.println ("   <Borders>");
		out.println ("    <Border ss:Position='Bottom' ss:LineStyle='Continuous' ss:Weight='2'/>");
		out.println ("    <Border ss:Position='Left' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Right' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Top' ss:LineStyle='Continuous' ss:Weight='2'/>");
		out.println ("   </Borders>");
		out.println ("   <Font ss:FontName='新細明體' x:CharSet='136' x:Family='Roman' ss:Size='12'");
		out.println ("    ss:Color='#000000' ss:Bold='1'/>");
		out.println ("   <NumberFormat ss:Format='@'/>");
		out.println ("  </Style>");
		out.println ("  <Style ss:ID='s77'>");
		out.println ("   <Borders>");
		out.println ("    <Border ss:Position='Bottom' ss:LineStyle='Continuous' ss:Weight='2'/>");
		out.println ("    <Border ss:Position='Left' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Right' ss:LineStyle='Continuous' ss:Weight='2'/>");
		out.println ("    <Border ss:Position='Top' ss:LineStyle='Continuous' ss:Weight='2'/>");
		out.println ("   </Borders>");
		out.println ("   <Font ss:FontName='新細明體' x:CharSet='136' x:Family='Roman' ss:Size='12'");
		out.println ("    ss:Color='#000000' ss:Bold='1'/>");
		out.println ("   <NumberFormat ss:Format='@'/>");
		out.println ("  </Style>");
		out.println ("  <Style ss:ID='s78'>");
		out.println ("   <Borders>");
		out.println ("    <Border ss:Position='Bottom' ss:LineStyle='Continuous' ss:Weight='2'/>");
		out.println ("    <Border ss:Position='Right' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Top' ss:LineStyle='Continuous' ss:Weight='2'/>");
		out.println ("   </Borders>");
		out.println ("   <Font ss:FontName='新細明體' x:CharSet='136' x:Family='Roman' ss:Size='12'");
		out.println ("    ss:Color='#000000' ss:Bold='1'/>");
		out.println ("   <NumberFormat ss:Format='@'/>");
		out.println ("  </Style>");
		out.println ("  <Style ss:ID='s79'>");
		out.println ("   <Borders>");
		out.println ("    <Border ss:Position='Bottom' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Right' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("   </Borders>");
		out.println ("   <NumberFormat ss:Format='@'/>");
		out.println ("  </Style>");
		out.println ("  <Style ss:ID='s80'>");
		out.println ("   <Borders>");
		out.println ("    <Border ss:Position='Bottom' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Right' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Top' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("   </Borders>");
		out.println ("   <NumberFormat ss:Format='@'/>");
		out.println ("  </Style>");
		out.println ("  <Style ss:ID='s81'>");
		out.println ("   <Borders>");
		out.println ("    <Border ss:Position='Bottom' ss:LineStyle='Continuous' ss:Weight='2'/>");
		out.println ("    <Border ss:Position='Left' ss:LineStyle='Continuous' ss:Weight='2'/>");
		out.println ("    <Border ss:Position='Right' ss:LineStyle='Continuous' ss:Weight='2'/>");
		out.println ("    <Border ss:Position='Top' ss:LineStyle='Continuous' ss:Weight='2'/>");
		out.println ("   </Borders>");
		out.println ("   <Font ss:FontName='新細明體' x:CharSet='136' x:Family='Roman' ss:Size='12'");
		out.println ("    ss:Color='#000000' ss:Bold='1'/>");
		out.println ("   <NumberFormat ss:Format='@'/>");
		out.println ("  </Style>");
		out.println ("  <Style ss:ID='s82'>");
		out.println ("   <Borders>");
		out.println ("    <Border ss:Position='Bottom' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Left' ss:LineStyle='Continuous' ss:Weight='2'/>");
		out.println ("    <Border ss:Position='Right' ss:LineStyle='Continuous' ss:Weight='2'/>");
		out.println ("   </Borders>");
		out.println ("   <NumberFormat ss:Format='@'/>");
		out.println ("  </Style>");
		out.println ("  <Style ss:ID='s83'>");
		out.println ("   <Borders>");
		out.println ("    <Border ss:Position='Bottom' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("    <Border ss:Position='Left' ss:LineStyle='Continuous' ss:Weight='2'/>");
		out.println ("    <Border ss:Position='Right' ss:LineStyle='Continuous' ss:Weight='2'/>");
		out.println ("    <Border ss:Position='Top' ss:LineStyle='Continuous' ss:Weight='1'/>");
		out.println ("   </Borders>");
		out.println ("   <NumberFormat ss:Format='@'/>");
		out.println ("  </Style>");
		out.println (" </Styles>");
		
		
		Map imp=df.sqlGetMap("SELECT name, cls FROM Dilg_imp_date WHERE Oid="+Oid);
		List<Map>cls=df.sqlGet("SELECT dic.edit, c.ClassName, (SELECT COUNT(*)FROM stmd WHERE depart_class=dic.ClassNo)as cnt,"
		+ "did.cls,(SELECT COUNT(*)FROM Dilg_imp WHERE Dilg_imp_date_oid="+Oid+" AND student_no IN(SELECT student_no FROM stmd, Class "
		+ "WHERE stmd.depart_class=Class.ClassNo AND Class.ClassNo=c.ClassNo))as nt,IFNULL(e.cname,'')as cname, IFNULL(e.CellPhone,'')as CellPhone FROM Dilg_imp_date did,"
		+ "Dilg_imp_class dic, Class c LEFT OUTER JOIN empl e ON c.tutor=e.idno WHERE did.Oid=dic.Dilg_imp_date_oid AND "
		+ "c.ClassNo=dic.ClassNo AND dic.Dilg_imp_date_oid="+Oid+" ORDER BY c.DeptNo, c.SchoolNo, c.Grade");
		
		out.println (" <Worksheet ss:Name='工作表1'>");
		out.println ("  <Names>");
		out.println ("   <NamedRange ss:Name='Print_Titles' ss:RefersTo='=工作表1!R1'/>");
		out.println ("  </Names>");
		out.println ("  <Table ss:ExpandedColumnCount='8' ss:ExpandedRowCount='"+(cls.size()+100)+"' x:FullColumns='1'");
		out.println ("   x:FullRows='1' ss:StyleID='s62' ss:DefaultColumnWidth='54'");
		out.println ("   ss:DefaultRowHeight='16.5'>");
		out.println ("   <Column ss:StyleID='s83' ss:AutoFitWidth='0' ss:Width='143.25'/>");
		out.println ("   <Column ss:StyleID='s66' ss:AutoFitWidth='0' ss:Width='60'/>");
		out.println ("   <Column ss:StyleID='s67' ss:AutoFitWidth='0' ss:Width='60' ss:Span='1'/>");
		out.println ("   <Column ss:Index='5' ss:StyleID='s68' ss:AutoFitWidth='0' ss:Width='60'/>");
		out.println ("   <Column ss:StyleID='s83' ss:AutoFitWidth='0'/>");
		out.println ("   <Column ss:StyleID='s80' ss:AutoFitWidth='0'/>");
		out.println ("   <Column ss:StyleID='s68' ss:AutoFitWidth='0' ss:Width='96'/>");
		out.println ("   <Row ss:Height='17.25'>");
		out.println ("    <Cell ss:StyleID='s81'><Data ss:Type='String'>班級名稱</Data><NamedCell");
		out.println ("      ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell ss:StyleID='s75'><Data ss:Type='String'>應到人數</Data><NamedCell");
		out.println ("      ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell ss:StyleID='s76'><Data ss:Type='String'>應到次數</Data><NamedCell");
		out.println ("      ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell ss:StyleID='s76'><Data ss:Type='String'>實到次數</Data><NamedCell");
		out.println ("      ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell ss:StyleID='s77'><Data ss:Type='String'>出席率</Data><NamedCell");
		out.println ("      ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell ss:StyleID='s81'><Data ss:Type='String'>人均</Data><NamedCell");
		out.println ("      ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell ss:StyleID='s78'><Data ss:Type='String'>導師</Data><NamedCell");
		out.println ("      ss:Name='Print_Titles'/></Cell>");
		out.println ("    <Cell ss:StyleID='s77'><Data ss:Type='String'>連絡電話</Data><NamedCell");
		out.println ("      ss:Name='Print_Titles'/></Cell>");
		out.println ("   </Row>");
		
		int cnt, nt, tot, st;
		
		int cs=Integer.parseInt(imp.get("cls").toString());//節次
		float avg;
		for(int i=0; i<cls.size(); i++){
			cnt=Integer.parseInt(cls.get(i).get("cnt").toString());
			nt=Integer.parseInt(cls.get(i).get("nt").toString());
			tot=cnt*cs;
			st=tot-nt;
			out.println ("   <Row>");
			out.println ("    <Cell ss:StyleID='s82'><Data ss:Type='String'>"+cls.get(i).get("ClassName")+"</Data></Cell>");
			out.println ("    <Cell ss:StyleID='s72'><Data ss:Type='String'>"+cnt+"</Data></Cell>");
			out.println ("    <Cell ss:StyleID='s73'><Data ss:Type='String'>"+tot+"</Data></Cell>");//應到			
			if(cls.get(i).get("edit")==null){
				out.println ("    <Cell ss:StyleID='s73'><Data ss:Type='String'>尚未輸入</Data></Cell>");//實到
			}else{
				out.println ("    <Cell ss:StyleID='s73'><Data ss:Type='String'>"+st+"</Data></Cell>");//實到
			}
						
			
			if(nt>0){
				avg = (float) st / tot;
				out.println ("    <Cell ss:StyleID='s74'><Data ss:Type='String'>"+(int)(avg*100)+"%</Data></Cell>");//出席
				out.println ("    <Cell ss:StyleID='s82'><Data ss:Type='String'>"+(float)nt/cnt+"</Data></Cell>");//人均				
			}else{				
				out.println ("    <Cell ss:StyleID='s74'><Data ss:Type='String'>100%</Data></Cell>");//出席
				out.println ("    <Cell ss:StyleID='s82'><Data ss:Type='String'>0</Data></Cell>");				
			}
			out.println ("    <Cell ss:StyleID='s79'><Data ss:Type='String'>"+cls.get(i).get("cname")+"</Data></Cell>");
			out.println ("    <Cell ss:StyleID='s74'><Data ss:Type='String'>"+cls.get(i).get("CellPhone")+"</Data></Cell>");
			
			out.println ("   </Row>");
		}
		
		
		
		
		out.println ("  </Table>");
		out.println ("  <WorksheetOptions xmlns='urn:schemas-microsoft-com:office:excel'>");
		out.println ("   <PageSetup>");
		out.println ("    <Header x:Margin='0.31496062992125984' x:Data='&amp;C&amp;&quot;標楷體,粗體&quot;&amp;20"+imp.get("name")+"點名狀況'/>");
		out.println ("    <Footer x:Margin='0.31496062992125984' x:Data='&amp;C&amp;P/&amp;N&amp;R2016-4-26 14:35'/>");
		out.println ("    <PageMargins x:Bottom='0.74803149606299213' x:Left='0.23622047244094491'");
		out.println ("     x:Right='0.23622047244094491' x:Top='0.74803149606299213'/>");
		out.println ("   </PageSetup>");
		out.println ("   <Print>");
		out.println ("    <ValidPrinterInfo/>");
		out.println ("    <PaperSizeIndex>9</PaperSizeIndex>");
		out.println ("    <HorizontalResolution>600</HorizontalResolution>");
		out.println ("    <VerticalResolution>600</VerticalResolution>");
		out.println ("   </Print>");
		out.println ("   <Selected/>");
		out.println ("   <Panes>");
		out.println ("    <Pane>");
		out.println ("     <Number>3</Number>");
		out.println ("     <ActiveRow>45</ActiveRow>");
		out.println ("     <ActiveCol>9</ActiveCol>");
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

package print;

import java.io.PrintWriter;
import java.util.Date;
import java.util.List;
import java.util.Map;

import action.BasePrintXmlAction;

public class CoanswPrint extends BasePrintXmlAction{

	public String execute()throws Exception {
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
		out.println ("  <Created>2014-05-15T03:48:46Z</Created>");
		out.println ("  <LastSaved>2014-05-15T03:53:44Z</LastSaved>");
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
		out.println ("   <NumberFormat/>");
		out.println ("  </Style>");
		out.println (" </Styles>");
		out.println (" <Worksheet ss:Name='SHEET1'>");
		
		
		
		
		List<Map>labels=df.sqlGet("SELECT * FROM Question WHERE topic='1' ORDER BY sequence");
		String Oid=request.getParameter("Oid");
		
		
		List<Map>list=df.sqlGet("SELECT coansw FROM Seld WHERE Dtime_oid="+Oid+" AND coansw IS NOT NULL");
		
		
		out.println ("  <Table ss:ExpandedColumnCount='"+labels.size()+1+"' ss:ExpandedRowCount='"+(list.size()+100)+"' x:FullColumns='1'");
		out.println ("   x:FullRows='1' ss:StyleID='s62' ss:DefaultColumnWidth='54'");
		out.println ("   ss:DefaultRowHeight='16.5'>");
		out.println ("   <Row>");
		
		
		
		out.println ("    <Cell><Data ss:Type='String'>第1題</Data></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>第2題</Data></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>第3題</Data></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>第4題</Data></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>第5題</Data></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>第6題</Data></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>第7題</Data></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>第8題</Data></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>第9題</Data></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>第10題</Data></Cell>");
		out.println ("    <Cell><Data ss:Type='String'>第11題</Data></Cell>");
		out.println ("   </Row>");
		
		String coansw;
		for(int i=0; i<list.size(); i++){
			coansw=list.get(i).get("coansw").toString();
			out.println ("   <Row>");
			for(int j=0; j<labels.size(); j++){
				out.println ("    <Cell><Data ss:Type='Number'>"+coansw.substring(j, j+1)+"</Data></Cell>");
				
			}
			/*out.println ("    <Cell><Data ss:Type='String'>1</Data></Cell>");
			out.println ("    <Cell><Data ss:Type='String'>1</Data></Cell>");
			out.println ("    <Cell><Data ss:Type='String'>1</Data></Cell>");
			out.println ("    <Cell><Data ss:Type='String'>1</Data></Cell>");
			out.println ("    <Cell><Data ss:Type='String'>1</Data></Cell>");
			out.println ("    <Cell><Data ss:Type='String'>1</Data></Cell>");
			out.println ("    <Cell><Data ss:Type='String'>1</Data></Cell>");
			out.println ("    <Cell><Data ss:Type='String'>1</Data></Cell>");
			out.println ("    <Cell><Data ss:Type='String'>1</Data></Cell>");
			out.println ("    <Cell><Data ss:Type='String'>1</Data></Cell>");
			out.println ("    <Cell><Data ss:Type='String'>1</Data></Cell>");*/
			out.println ("   </Row>");
		}
		
		
		
		
		out.println ("  </Table>");
		out.println ("  <WorksheetOptions xmlns='urn:schemas-microsoft-com:office:excel'>");
		out.println ("   <PageSetup>");
		out.println ("    <Header x:Margin='0.3'/>");
		out.println ("    <Footer x:Margin='0.3'/>");
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
		out.println ("     <ActiveRow>4</ActiveRow>");
		out.println ("     <ActiveCol>11</ActiveCol>");
		out.println ("    </Pane>");
		out.println ("   </Panes>");
		out.println ("   <ProtectObjects>False</ProtectObjects>");
		out.println ("   <ProtectScenarios>False</ProtectScenarios>");
		out.println ("  </WorksheetOptions>");
		out.println (" </Worksheet>");
		out.println ("</Workbook>");
		out.close();	
		return null;
	}

}

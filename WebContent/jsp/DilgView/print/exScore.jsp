<%@ page contentType="application/vnd.ms-excel; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<?xml version="1.0"?>
<?mso-application progid="Excel.Sheet"?>
<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet"
 xmlns:o="urn:schemas-microsoft-com:office:office"
 xmlns:x="urn:schemas-microsoft-com:office:excel"
 xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"
 xmlns:html="http://www.w3.org/TR/REC-html40">
 <DocumentProperties xmlns="urn:schemas-microsoft-com:office:office">
  <Author>shawn</Author>
  <LastAuthor>shawn</LastAuthor>
  <LastPrinted>2015-05-13T08:29:54Z</LastPrinted>
  <Created>2014-12-18T00:47:42Z</Created>
  <LastSaved>2014-12-18T03:07:00Z</LastSaved>
  <Version>15.00</Version>
 </DocumentProperties>
 <OfficeDocumentSettings xmlns="urn:schemas-microsoft-com:office:office">
  <AllowPNG/>
 </OfficeDocumentSettings>
 <ExcelWorkbook xmlns="urn:schemas-microsoft-com:office:excel">
  <WindowHeight>11880</WindowHeight>
  <WindowWidth>28800</WindowWidth>
  <WindowTopX>0</WindowTopX>
  <WindowTopY>0</WindowTopY>
  <ProtectStructure>False</ProtectStructure>
  <ProtectWindows>False</ProtectWindows>
 </ExcelWorkbook>
 <Styles>
  <Style ss:ID="Default" ss:Name="Normal">
   <Alignment ss:Vertical="Center"/>
   <Borders/>
   <Font ss:FontName="新細明體" x:CharSet="136" x:Family="Roman" ss:Size="12"
    ss:Color="#000000"/>
   <Interior/>
   <NumberFormat/>
   <Protection/>
  </Style>
  <Style ss:ID="s62">
   <Font ss:FontName="微軟正黑體 Light" x:CharSet="136" x:Family="Swiss" ss:Size="12"
    ss:Color="#000000"/>
  </Style>
  <Style ss:ID="s63">
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="微軟正黑體 Light" x:CharSet="136" x:Family="Swiss" ss:Size="12"
    ss:Color="#000000"/>
  </Style>
  <Style ss:ID="s64">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="微軟正黑體 Light" x:CharSet="136" x:Family="Swiss" ss:Size="12"
    ss:Color="#000000"/>
  </Style>
  <Style ss:ID="s65">
   <Alignment ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="微軟正黑體 Light" x:CharSet="136" x:Family="Swiss" ss:Size="12"
    ss:Color="#000000"/>
  </Style>
  <Style ss:ID="s100">
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="微軟正黑體" x:CharSet="136" x:Family="Swiss" ss:Size="12"
    ss:Color="#000000" ss:Bold="1"/>
  </Style>
  <Style ss:ID="s101">
   <Alignment ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="微軟正黑體" x:CharSet="136" x:Family="Swiss" ss:Size="12"
    ss:Color="#000000" ss:Bold="1"/>
  </Style>
  <Style ss:ID="s102">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="微軟正黑體" x:CharSet="136" x:Family="Swiss" ss:Size="12"
    ss:Color="#000000" ss:Bold="1"/>
  </Style>
  <Style ss:ID="s103">
   <Font ss:FontName="微軟正黑體" x:CharSet="136" x:Family="Swiss" ss:Size="12"
    ss:Color="#000000" ss:Bold="1"/>
  </Style>
  <Style ss:ID="s104">
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="微軟正黑體" x:CharSet="136" x:Family="Swiss" ss:Size="12"
    ss:Color="#000000"/>
  </Style>
  <Style ss:ID="s105">
   <Font ss:FontName="微軟正黑體" x:CharSet="136" x:Family="Swiss" ss:Size="12"
    ss:Color="#000000"/>
  </Style>
 </Styles>
 <Worksheet ss:Name="班">
  <Names>
   <NamedRange ss:Name="Print_Titles" ss:RefersTo="=班!R1"/>
  </Names>
  <Table ss:ExpandedColumnCount="10" ss:ExpandedRowCount="${fn:length(cls)+1}" x:FullColumns="1"
   x:FullRows="1" ss:StyleID="s105" ss:DefaultColumnWidth="54"
   ss:DefaultRowHeight="15.75">
   <Column ss:StyleID="s104" ss:AutoFitWidth="0" ss:Width="101.25"/>
   <Column ss:StyleID="s104" ss:AutoFitWidth="0" ss:Width="39.75"/>
   <Column ss:StyleID="s104" ss:AutoFitWidth="0" ss:Width="44.25"/>
   <Column ss:StyleID="s104" ss:AutoFitWidth="0" ss:Width="48" ss:Span="1"/>
   <Column ss:Index="6" ss:StyleID="s104" ss:AutoFitWidth="0" ss:Width="60"
    ss:Span="1"/>
   <Column ss:Index="8" ss:StyleID="s104" ss:AutoFitWidth="0" ss:Width="63.75"
    ss:Span="1"/>
   <Column ss:Index="10" ss:StyleID="s104" ss:AutoFitWidth="0" ss:Width="51.75"/>
   <Row ss:AutoFitHeight="0" ss:Height="31.5" ss:StyleID="s103">
    <Cell ss:StyleID="s100"><Data ss:Type="String">名稱</Data><NamedCell ss:Name="Print_Titles"/></Cell>
    <Cell ss:StyleID="s100"><Data ss:Type="String">人數</Data><NamedCell ss:Name="Print_Titles"/></Cell>
    <Cell ss:StyleID="s101"><Data ss:Type="String">零分或無成績</Data><NamedCell ss:Name="Print_Titles"/></Cell>
    <Cell ss:StyleID="s102"><Data ss:Type="String">平均&#10;成績</Data><NamedCell ss:Name="Print_Titles"/></Cell>
    <Cell ss:StyleID="s102"><Data ss:Type="String">平均&#10;缺課</Data><NamedCell ss:Name="Print_Titles"/></Cell>
    <Cell ss:StyleID="s102"><Data ss:Type="String">高缺課&#10;平均成績</Data><NamedCell ss:Name="Print_Titles"/></Cell>
    <Cell ss:StyleID="s102"><Data ss:Type="String">低缺課&#10;平均成績</Data><NamedCell ss:Name="Print_Titles"/></Cell>
    <Cell ss:StyleID="s101"><Data ss:Type="String">高缺課&#10;1/2不及格</Data><NamedCell ss:Name="Print_Titles"/></Cell>
    <Cell ss:StyleID="s101"><Data ss:Type="String">低缺課&#10;1/2不及格</Data><NamedCell ss:Name="Print_Titles"/></Cell>
    <Cell ss:StyleID="s100"><Data ss:Type="String">導師</Data><NamedCell ss:Name="Print_Titles"/></Cell>
   </Row>
   
   <c:forEach items="${cls}" var="c">
   <c:if test="${c.score>0}">
   <Row ss:AutoFitHeight="0">    
    <Cell><Data ss:Type="String">${c.name}</Data></Cell>
    <Cell><Data ss:Type="Number">${c.cnt}</Data></Cell>
    <c:if test="${c.zero>=c.cnt}"><Cell><Data ss:Type="Number">${c.zero%c.cnt}</Data></Cell></c:if>
    <c:if test="${c.zero<c.cnt}"><Cell><Data ss:Type="Number">${c.zero}</Data></Cell></c:if>    
    <Cell><Data ss:Type="Number">${c.score}</Data></Cell>
    <Cell><Data ss:Type="Number">${c.dilg}</Data></Cell>
    <Cell><Data ss:Type="Number">${c.scoreb}</Data></Cell>
    <Cell><Data ss:Type="Number">${c.scoreg}</Data></Cell>
    <Cell><Data ss:Type="Number">${c.b}</Data></Cell>
    <Cell><Data ss:Type="Number">${c.g}</Data></Cell>
    <Cell><Data ss:Type="String">${c.cname}</Data></Cell>
    
   </Row>
   </c:if>
   </c:forEach>
  </Table>
  <WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">
   <PageSetup>
    <Header x:Margin="0.31496062992125984" x:Data="&amp;C&amp;&quot;微軟正黑體,粗體&quot;&amp;20班級缺課與成績關係表"/>
    <Footer x:Margin="0.31496062992125984" x:Data="&amp;L列印時間 &amp;D &amp;T&amp;R&amp;P/&amp;N"/>
    <PageMargins x:Bottom="0.74803149606299213" x:Left="0.23622047244094491"
     x:Right="0.23622047244094491" x:Top="0.74803149606299213"/>
   </PageSetup>
   <Unsynced/>
   <Print>
    <ValidPrinterInfo/>
    <PaperSizeIndex>9</PaperSizeIndex>
    <HorizontalResolution>-1</HorizontalResolution>
    <VerticalResolution>-1</VerticalResolution>
   </Print>
   <PageBreakZoom>60</PageBreakZoom>
   <Selected/>
   <Panes>
    <Pane>
     <Number>3</Number>
     <ActiveRow>10</ActiveRow>
     <ActiveCol>9</ActiveCol>
    </Pane>
   </Panes>
   <ProtectObjects>False</ProtectObjects>
   <ProtectScenarios>False</ProtectScenarios>
  </WorksheetOptions>
 </Worksheet>
 
 
 
 <Worksheet ss:Name="系">
  <Names>
   <NamedRange ss:Name="Print_Titles" ss:RefersTo="=班!R1"/>
  </Names>
  <Table ss:ExpandedColumnCount="10" ss:ExpandedRowCount="${fn:length(dept)+1}" x:FullColumns="1"
   x:FullRows="1" ss:StyleID="s105" ss:DefaultColumnWidth="54"
   ss:DefaultRowHeight="15.75">
   <Column ss:StyleID="s104" ss:AutoFitWidth="0" ss:Width="101.25"/>
   <Column ss:StyleID="s104" ss:AutoFitWidth="0" ss:Width="39.75"/>
   <Column ss:StyleID="s104" ss:AutoFitWidth="0" ss:Width="44.25"/>
   <Column ss:StyleID="s104" ss:AutoFitWidth="0" ss:Width="48" ss:Span="1"/>
   <Column ss:Index="6" ss:StyleID="s104" ss:AutoFitWidth="0" ss:Width="60"
    ss:Span="1"/>
   <Column ss:Index="8" ss:StyleID="s104" ss:AutoFitWidth="0" ss:Width="63.75"
    ss:Span="1"/>
   <Column ss:Index="10" ss:StyleID="s104" ss:AutoFitWidth="0" ss:Width="51.75"/>
   <Row ss:AutoFitHeight="0" ss:Height="31.5" ss:StyleID="s103">
    <Cell ss:StyleID="s100"><Data ss:Type="String">名稱</Data><NamedCell ss:Name="Print_Titles"/></Cell>
    <Cell ss:StyleID="s100"><Data ss:Type="String">人數</Data><NamedCell ss:Name="Print_Titles"/></Cell>
    <Cell ss:StyleID="s101"><Data ss:Type="String">零分或無成績</Data><NamedCell ss:Name="Print_Titles"/></Cell>
    <Cell ss:StyleID="s102"><Data ss:Type="String">平均&#10;成績</Data><NamedCell ss:Name="Print_Titles"/></Cell>
    <Cell ss:StyleID="s102"><Data ss:Type="String">平均&#10;缺課</Data><NamedCell ss:Name="Print_Titles"/></Cell>
    <Cell ss:StyleID="s102"><Data ss:Type="String">高缺課&#10;平均成績</Data><NamedCell ss:Name="Print_Titles"/></Cell>
    <Cell ss:StyleID="s102"><Data ss:Type="String">低缺課&#10;平均成績</Data><NamedCell ss:Name="Print_Titles"/></Cell>
    <Cell ss:StyleID="s101"><Data ss:Type="String">高缺課&#10;1/2不及格</Data><NamedCell ss:Name="Print_Titles"/></Cell>
    <Cell ss:StyleID="s101"><Data ss:Type="String">低缺課&#10;1/2不及格</Data><NamedCell ss:Name="Print_Titles"/></Cell>
    <Cell ss:StyleID="s100"><Data ss:Type="String">導師</Data><NamedCell ss:Name="Print_Titles"/></Cell>
   </Row>
   
   <c:forEach items="${dept}" var="c">
   <c:if test="${c.score>0}">
   <Row ss:AutoFitHeight="0">    
    <Cell><Data ss:Type="String">${c.name}</Data></Cell>
    <Cell><Data ss:Type="Number">${c.cnt}</Data></Cell>
    <c:if test="${c.zero>=c.cnt}"><Cell><Data ss:Type="Number">${c.zero%c.cnt}</Data></Cell></c:if>
    <c:if test="${c.zero<c.cnt}"><Cell><Data ss:Type="Number">${c.zero}</Data></Cell></c:if>    
    <Cell><Data ss:Type="Number">${c.score}</Data></Cell>
    <Cell><Data ss:Type="Number">${c.dilg}</Data></Cell>
    <Cell><Data ss:Type="Number">${c.scoreb}</Data></Cell>
    <Cell><Data ss:Type="Number">${c.scoreg}</Data></Cell>
    <Cell><Data ss:Type="Number">${c.b}</Data></Cell>
    <Cell><Data ss:Type="Number">${c.g}</Data></Cell>
    <Cell><Data ss:Type="String">${c.cname}</Data></Cell>
    
   </Row>
   </c:if>
   </c:forEach>
  </Table>
  <WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">
   <PageSetup>
    <Header x:Margin="0.31496062992125984" x:Data="&amp;C&amp;&quot;微軟正黑體,粗體&quot;&amp;20班級缺課與成績關係表"/>
    <Footer x:Margin="0.31496062992125984" x:Data="&amp;L列印時間 &amp;D &amp;T&amp;R&amp;P/&amp;N"/>
    <PageMargins x:Bottom="0.74803149606299213" x:Left="0.23622047244094491"
     x:Right="0.23622047244094491" x:Top="0.74803149606299213"/>
   </PageSetup>
   <Unsynced/>
   <Print>
    <ValidPrinterInfo/>
    <PaperSizeIndex>9</PaperSizeIndex>
    <HorizontalResolution>-1</HorizontalResolution>
    <VerticalResolution>-1</VerticalResolution>
   </Print>
   <PageBreakZoom>60</PageBreakZoom>
   <Selected/>
   <Panes>
    <Pane>
     <Number>3</Number>
     <ActiveRow>10</ActiveRow>
     <ActiveCol>9</ActiveCol>
    </Pane>
   </Panes>
   <ProtectObjects>False</ProtectObjects>
   <ProtectScenarios>False</ProtectScenarios>
  </WorksheetOptions>
 </Worksheet>
 
 
</Workbook>
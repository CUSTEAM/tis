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
  <LastPrinted>2015-05-15T00:19:24Z</LastPrinted>
  <Created>2015-05-14T07:08:30Z</Created>
  <LastSaved>2015-05-14T07:22:16Z</LastSaved>
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
   <Font ss:FontName="微軟正黑體" x:CharSet="136" x:Family="Swiss" ss:Size="12"
    ss:Color="#000000"/>
  </Style>
  <Style ss:ID="s63">
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="2"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="微軟正黑體" x:CharSet="136" x:Family="Swiss" ss:Size="12"
    ss:Color="#000000"/>
  </Style>
  <Style ss:ID="s64">
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="微軟正黑體" x:CharSet="136" x:Family="Swiss" ss:Size="12"
    ss:Color="#000000"/>
  </Style>
  <Style ss:ID="s65">
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="2"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="微軟正黑體" x:CharSet="136" x:Family="Swiss" ss:Size="12"
    ss:Color="#000000"/>
  </Style>
  <Style ss:ID="s70">
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="微軟正黑體" x:CharSet="136" x:Family="Swiss" ss:Size="12"
    ss:Color="#000000"/>
  </Style>
  <Style ss:ID="s76">
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="微軟正黑體" x:CharSet="136" x:Family="Swiss" ss:Color="#000000"/>
  </Style>
  <Style ss:ID="s78">
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="2"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="2"/>
   </Borders>
   <Font ss:FontName="微軟正黑體" x:CharSet="136" x:Family="Swiss" ss:Size="12"
    ss:Color="#000000" ss:Bold="1"/>
  </Style>
  <Style ss:ID="s79">
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="2"/>
   </Borders>
   <Font ss:FontName="微軟正黑體" x:CharSet="136" x:Family="Swiss" ss:Size="12"
    ss:Color="#000000" ss:Bold="1"/>
  </Style>
  <Style ss:ID="s80">
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="2"/>
   </Borders>
   <Font ss:FontName="微軟正黑體" x:CharSet="136" x:Family="Swiss" ss:Size="12"
    ss:Color="#000000" ss:Bold="1"/>
  </Style>
  <Style ss:ID="s81">
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="2"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="2"/>
   </Borders>
   <Font ss:FontName="微軟正黑體" x:CharSet="136" x:Family="Swiss" ss:Size="12"
    ss:Color="#000000" ss:Bold="1"/>
  </Style>
  <Style ss:ID="s82">
   <Font ss:FontName="微軟正黑體" x:CharSet="136" x:Family="Swiss" ss:Size="12"
    ss:Color="#000000" ss:Bold="1"/>
  </Style>
 </Styles>
 <Worksheet ss:Name="全部">
  <Names>
   <NamedRange ss:Name="Print_Titles" ss:RefersTo="=全部!R1"/>
  </Names>
  <Table ss:ExpandedColumnCount="11" ss:ExpandedRowCount="${cnt+100}" x:FullColumns="1"
   x:FullRows="1" ss:StyleID="s62" ss:DefaultColumnWidth="54"
   ss:DefaultRowHeight="15.75">
   <Column ss:StyleID="s63" ss:AutoFitWidth="0" ss:Width="87.75"/>
   <Column ss:StyleID="s64" ss:AutoFitWidth="0" ss:Width="66"/>
   <Column ss:StyleID="s64" ss:AutoFitWidth="0"/>
   <Column ss:StyleID="s64" ss:AutoFitWidth="0" ss:Width="87.75"/>
   <Column ss:StyleID="s76" ss:AutoFitWidth="0" ss:Width="99.75"/>
   <Column ss:StyleID="s64" ss:AutoFitWidth="0" ss:Width="32.25" ss:Span="2"/>
   <Column ss:Index="9" ss:StyleID="s70" ss:AutoFitWidth="0" ss:Width="32.25"/>
   <Column ss:StyleID="s70" ss:AutoFitWidth="0" ss:Width="39.75"/>
   <Column ss:StyleID="s65" ss:AutoFitWidth="0" ss:Width="32.25"/>
   <Row ss:AutoFitHeight="0" ss:StyleID="s82">
    <Cell ss:StyleID="s78"><Data ss:Type="String">學生班級</Data><NamedCell ss:Name="Print_Titles"/></Cell>
    <Cell ss:StyleID="s79"><Data ss:Type="String">學號</Data><NamedCell ss:Name="Print_Titles"/></Cell>
    <Cell ss:StyleID="s79"><Data ss:Type="String">姓名</Data><NamedCell ss:Name="Print_Titles"/></Cell>
    <Cell ss:StyleID="s79"><Data ss:Type="String">開課班級</Data><NamedCell ss:Name="Print_Titles"/></Cell>
    <Cell ss:StyleID="s79"><Data ss:Type="String">課程名稱</Data><NamedCell ss:Name="Print_Titles"/></Cell>
    <Cell ss:StyleID="s79"><Data ss:Type="String">選別</Data><NamedCell ss:Name="Print_Titles"/></Cell>
    <Cell ss:StyleID="s79"><Data ss:Type="String">時數</Data><NamedCell ss:Name="Print_Titles"/></Cell>
    <Cell ss:StyleID="s79"><Data ss:Type="String">學分</Data><NamedCell ss:Name="Print_Titles"/></Cell>
    <Cell ss:StyleID="s80"><Data ss:Type="String">選課</Data><NamedCell ss:Name="Print_Titles"/></Cell>
    <Cell ss:StyleID="s80"><Data ss:Type="String">無成績</Data><NamedCell ss:Name="Print_Titles"/></Cell>
    <Cell ss:StyleID="s81"><Data ss:Type="String">成績</Data><NamedCell ss:Name="Print_Titles"/></Cell>
   </Row>
   <c:forEach items="${cls}" var="c">
   <c:forEach items="${c.stds}" var="s">
   <c:if test="${s.zero!=s.cnt}">
   <Row ss:AutoFitHeight="0">
    <Cell><Data ss:Type="String">${s.ClassName}</Data></Cell>
    <Cell><Data ss:Type="String">${s.student_no}</Data></Cell>
    <Cell><Data ss:Type="String">${s.student_name}</Data></Cell>
    <Cell><Data ss:Type="String">${s.csClassName}</Data></Cell>
    <Cell><Data ss:Type="String">${s.chi_name}</Data></Cell>
    <Cell><Data ss:Type="String">${s.opt}</Data></Cell>
    <Cell><Data ss:Type="String">${s.thour}</Data></Cell>
    <Cell><Data ss:Type="Number">${s.credit}</Data></Cell>
    <Cell><Data ss:Type="Number">${s.cnt}</Data></Cell>
    <Cell><Data ss:Type="Number">${s.zero}</Data></Cell>
    <Cell><Data ss:Type="String">${s.score2}</Data></Cell>
   </Row>
   </c:if>
   </c:forEach>
   </c:forEach>
  </Table>
  <WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">
   <PageSetup>
    <Header x:Margin="0.31496062992125984"
     x:Data="&amp;C&amp;&quot;微軟正黑體,標準&quot;&amp;18期中考零分與無成績名單&amp;R&amp;&quot;微軟正黑體,標準&quot;第&amp;P頁 共&amp;N頁"/>
    <Footer x:Margin="0.31496062992125984" x:Data="&amp;R&amp;D &amp;T"/>
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
   <Selected/>
   <Panes>
    <Pane>
     <Number>3</Number>
     <ActiveRow>10</ActiveRow>
     <ActiveCol>4</ActiveCol>
    </Pane>
   </Panes>
   <ProtectObjects>False</ProtectObjects>
   <ProtectScenarios>False</ProtectScenarios>
  </WorksheetOptions>
 </Worksheet>
 
 
 
 
 <c:forEach items="${cls}" var="c">
 
 <c:if test="${fn:length(c.stds)>0}">
 <Worksheet ss:Name="${c.ClassName}">
  <Names>
   <NamedRange ss:Name="Print_Titles" ss:RefersTo="=${c.ClassName}!R1"/>
  </Names>
  <Table ss:ExpandedColumnCount="11" ss:ExpandedRowCount="${fn:length(c.stds)+1}" x:FullColumns="1"
   x:FullRows="1" ss:StyleID="s62" ss:DefaultColumnWidth="54"
   ss:DefaultRowHeight="15.75">
   <Column ss:StyleID="s63" ss:AutoFitWidth="0" ss:Width="87.75"/>
   <Column ss:StyleID="s64" ss:AutoFitWidth="0" ss:Width="66"/>
   <Column ss:StyleID="s64" ss:AutoFitWidth="0"/>
   <Column ss:StyleID="s64" ss:AutoFitWidth="0" ss:Width="87.75"/>
   <Column ss:StyleID="s76" ss:AutoFitWidth="0" ss:Width="99.75"/>
   <Column ss:StyleID="s64" ss:AutoFitWidth="0" ss:Width="32.25" ss:Span="2"/>
   <Column ss:Index="9" ss:StyleID="s70" ss:AutoFitWidth="0" ss:Width="32.25"/>
   <Column ss:StyleID="s70" ss:AutoFitWidth="0" ss:Width="39.75"/>
   <Column ss:StyleID="s65" ss:AutoFitWidth="0" ss:Width="32.25"/>
   <Row ss:AutoFitHeight="0" ss:StyleID="s82">
    <Cell ss:StyleID="s78"><Data ss:Type="String">學生班級</Data><NamedCell ss:Name="Print_Titles"/></Cell>
    <Cell ss:StyleID="s79"><Data ss:Type="String">學號</Data><NamedCell ss:Name="Print_Titles"/></Cell>
    <Cell ss:StyleID="s79"><Data ss:Type="String">姓名</Data><NamedCell ss:Name="Print_Titles"/></Cell>
    <Cell ss:StyleID="s79"><Data ss:Type="String">開課班級</Data><NamedCell ss:Name="Print_Titles"/></Cell>
    <Cell ss:StyleID="s79"><Data ss:Type="String">課程名稱</Data><NamedCell ss:Name="Print_Titles"/></Cell>
    <Cell ss:StyleID="s79"><Data ss:Type="String">選別</Data><NamedCell ss:Name="Print_Titles"/></Cell>
    <Cell ss:StyleID="s79"><Data ss:Type="String">時數</Data><NamedCell ss:Name="Print_Titles"/></Cell>
    <Cell ss:StyleID="s79"><Data ss:Type="String">學分</Data><NamedCell ss:Name="Print_Titles"/></Cell>
    <Cell ss:StyleID="s80"><Data ss:Type="String">選課</Data><NamedCell ss:Name="Print_Titles"/></Cell>
    <Cell ss:StyleID="s80"><Data ss:Type="String">無成績</Data><NamedCell ss:Name="Print_Titles"/></Cell>
    <Cell ss:StyleID="s81"><Data ss:Type="String">成績</Data><NamedCell ss:Name="Print_Titles"/></Cell>
   </Row>
   
   <c:forEach items="${c.stds}" var="s">
   <c:if test="${s.zero!=s.cnt}">
   <Row ss:AutoFitHeight="0">
    <Cell><Data ss:Type="String">${s.ClassName}</Data></Cell>
    <Cell><Data ss:Type="String">${s.student_no}</Data></Cell>
    <Cell><Data ss:Type="String">${s.student_name}</Data></Cell>
    <Cell><Data ss:Type="String">${s.csClassName}</Data></Cell>
    <Cell><Data ss:Type="String">${s.chi_name}</Data></Cell>
    <Cell><Data ss:Type="String">${s.opt}</Data></Cell>
    <Cell><Data ss:Type="String">${s.thour}</Data></Cell>
    <Cell><Data ss:Type="Number">${s.credit}</Data></Cell>
    <Cell><Data ss:Type="Number">${s.cnt}</Data></Cell>
    <Cell><Data ss:Type="Number">${s.zero}</Data></Cell>
    <Cell><Data ss:Type="String">${s.score2}</Data></Cell>
   </Row>
   </c:if>
   </c:forEach>
  </Table>
  <WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">
   <PageSetup>
    <Header x:Margin="0.31496062992125984"
     x:Data="&amp;C&amp;&quot;微軟正黑體,標準&quot;&amp;18${c.ClassName}期中考無成績名單&amp;R&amp;&quot;微軟正黑體,標準&quot;導師${c.cname}"/>
    <Footer x:Margin="0.31496062992125984" x:Data="&amp;R&amp;D &amp;T"/>
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
   <Selected/>
   <Panes>
    <Pane>
     <Number>3</Number>
     <ActiveRow>10</ActiveRow>
     <ActiveCol>4</ActiveCol>
    </Pane>
   </Panes>
   <ProtectObjects>False</ProtectObjects>
   <ProtectScenarios>False</ProtectScenarios>
  </WorksheetOptions>
 </Worksheet>
 </c:if>
 </c:forEach>
 
 
 
</Workbook>
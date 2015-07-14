<%@ page contentType="application/vnd.ms-excel; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!--application/vnd.ms-excel-->
<?xml version='1.0'?>
<?mso-application progid='Excel.Sheet'?>
<Workbook xmlns='urn:schemas-microsoft-com:office:spreadsheet'
 xmlns:o='urn:schemas-microsoft-com:office:office'
 xmlns:x='urn:schemas-microsoft-com:office:excel'
 xmlns:ss='urn:schemas-microsoft-com:office:spreadsheet'
 xmlns:html='http://www.w3.org/TR/REC-html40'>
 <DocumentProperties xmlns='urn:schemas-microsoft-com:office:office'>
  <Author>shawn</Author>
  <LastAuthor>shawn</LastAuthor>
  <LastPrinted>2014-12-09T01:21:58Z</LastPrinted>
  <Created>2014-12-08T06:51:31Z</Created>
  <LastSaved>2014-12-09T01:35:01Z</LastSaved>
  <Version>15.00</Version>
 </DocumentProperties>
 <OfficeDocumentSettings xmlns='urn:schemas-microsoft-com:office:office'>
  <AllowPNG/>
 </OfficeDocumentSettings>
 <ExcelWorkbook xmlns='urn:schemas-microsoft-com:office:excel'>
  <WindowHeight>11880</WindowHeight>
  <WindowWidth>28800</WindowWidth>
  <WindowTopX>0</WindowTopX>
  <WindowTopY>0</WindowTopY>
  <ProtectStructure>False</ProtectStructure>
  <ProtectWindows>False</ProtectWindows>
 </ExcelWorkbook>
 <Styles>
  <Style ss:ID='Default' ss:Name='Normal'>
   <Alignment ss:Vertical='Center'/>
   <Borders/>
   <Font ss:FontName='新細明體' x:CharSet='136' x:Family='Roman' ss:Size='12'
    ss:Color='#000000'/>
   <Interior/>
   <NumberFormat/>
   <Protection/>
  </Style>
  <Style ss:ID='s16'>
   <Borders>
    <Border ss:Position='Bottom' ss:LineStyle='Continuous' ss:Weight='1'/>
    <Border ss:Position='Left' ss:LineStyle='Continuous' ss:Weight='1'/>
    <Border ss:Position='Right' ss:LineStyle='Continuous' ss:Weight='1'/>
    <Border ss:Position='Top' ss:LineStyle='Continuous' ss:Weight='1'/>
   </Borders>
  </Style>
  <Style ss:ID='s17'>
   <Borders/>
  </Style>
  <Style ss:ID='s18'>
   <Borders>
    <Border ss:Position='Bottom' ss:LineStyle='Continuous' ss:Weight='1'/>
    <Border ss:Position='Left' ss:LineStyle='Continuous' ss:Weight='1'/>
    <Border ss:Position='Right' ss:LineStyle='Continuous' ss:Weight='1'/>
    <Border ss:Position='Top' ss:LineStyle='Continuous' ss:Weight='1'/>
   </Borders>
   <Interior/>
  </Style>
 </Styles>
 <Worksheet ss:Name='班'>
  <Names>
   <NamedRange ss:Name='Print_Area' ss:RefersTo='=班!C1:C16'/>
   <NamedRange ss:Name='Print_Titles' ss:RefersTo='=班!R1'/>
  </Names>
  <Table ss:ExpandedColumnCount='16' ss:ExpandedRowCount='${fn:length(cls)+1}' x:FullColumns='1'
   x:FullRows='1' ss:StyleID='s17' ss:DefaultColumnWidth='54'
   ss:DefaultRowHeight='16.5'>
   <Column ss:StyleID='s16' ss:AutoFitWidth='0' ss:Width='103.5'/>
   <Column ss:StyleID='s16' ss:AutoFitWidth='0' ss:Width='37.5'/>
   <Column ss:StyleID='s16' ss:AutoFitWidth='0' ss:Width='55.5'/>
   <Column ss:StyleID='s16' ss:AutoFitWidth='0' ss:Width='30.75'/>
   <Column ss:StyleID='s16' ss:AutoFitWidth='0' ss:Width='33' ss:Span='1'/>
   <Column ss:Index='7' ss:StyleID='s16' ss:AutoFitWidth='0' ss:Width='67.5'/>
   <Column ss:StyleID='s16' ss:Width='48' ss:Span='1'/>
   <Column ss:Index='10' ss:StyleID='s16' ss:AutoFitWidth='0' ss:Width='67.5'/>
   <Column ss:StyleID='s16' ss:Width='48' ss:Span='1'/>
   <Column ss:Index='13' ss:StyleID='s16' ss:AutoFitWidth='0' ss:Width='37.5'/>
   <Column ss:StyleID='s16' ss:AutoFitWidth='0' ss:Width='39.75'/>
   <Column ss:StyleID='s16' ss:AutoFitWidth='0' ss:Width='79.5' ss:Span='1'/>
   <Row>
    <Cell><Data ss:Type='String'>名稱</Data><NamedCell ss:Name='Print_Titles'/><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='String'>人數</Data><NamedCell ss:Name='Print_Titles'/><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='String'>平均缺課</Data><NamedCell ss:Name='Print_Titles'/><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='String'>平時</Data><NamedCell ss:Name='Print_Titles'/><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='String'>期中</Data><NamedCell ss:Name='Print_Titles'/><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='String'>學期</Data><NamedCell ss:Name='Print_Titles'/><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='String'>期中不及格</Data><NamedCell ss:Name='Print_Titles'/><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='String'>期中1/2</Data><NamedCell ss:Name='Print_Titles'/><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='String'>期中2/3</Data><NamedCell ss:Name='Print_Titles'/><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='String'>學期不及格</Data><NamedCell ss:Name='Print_Titles'/><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='String'>學期1/2</Data><NamedCell ss:Name='Print_Titles'/><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='String'>學期2/3</Data><NamedCell ss:Name='Print_Titles'/><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='String'>扣考</Data><NamedCell ss:Name='Print_Titles'/><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell ss:StyleID='s18'><Data ss:Type='String'>流失</Data><NamedCell ss:Name='Print_Titles'/><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell ss:StyleID='s18'><Data ss:Type='String'>導師</Data><NamedCell ss:Name='Print_Titles'/><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='String'>系主任</Data><NamedCell ss:Name='Print_Titles'/><NamedCell ss:Name='Print_Area'/></Cell>
   </Row>
   
   <c:forEach items="${cls}" var="c">
   <c:if test="${c.cnt>0}">
   <Row>
    <Cell><Data ss:Type='String'>${c.ClassName}</Data><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='Number'>${c.cnt}</Data><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='Number'><fmt:formatNumber value="${c.dilg/c.cnt}" pattern="0.000"/></Data><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='Number'><fmt:formatNumber value="${c.score1}" pattern="0.000"/></Data><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='Number'><fmt:formatNumber value="${c.score2}" pattern="0.000"/></Data><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='Number'><fmt:formatNumber value="${c.score}" pattern="0.000"/></Data><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='Number'><fmt:formatNumber value="${c.score2d/c.cnt}" pattern="0.000"/></Data><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='Number'><fmt:formatNumber value="${c.m21/c.cnt}" pattern="0.000"/></Data><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='Number'><fmt:formatNumber value="${c.m32/c.cnt}" pattern="0.000"/></Data><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='Number'><fmt:formatNumber value="${c.scored/c.cnt}" pattern="0.000"/></Data><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='Number'><fmt:formatNumber value="${c.e21/c.cnt}" pattern="0.000"/></Data><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='Number'><fmt:formatNumber value="${c.e32/c.cnt}" pattern="0.000"/></Data><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='Number'>${c.block}</Data><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='Number'>${c.gstmd}</Data><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='String'>${c.tutor}</Data><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='String'>${c.director}</Data><NamedCell ss:Name='Print_Area'/></Cell>
   </Row>
   </c:if>
   </c:forEach>
  </Table>
  <WorksheetOptions xmlns='urn:schemas-microsoft-com:office:excel'>
   <PageSetup>
    <Layout x:Orientation='Landscape'/>
    <Header x:Margin='0.31496062992125984' x:Data='&amp;C&amp;&quot;微軟正黑體,粗體&quot;&amp;24班級成績趨勢表'/>
    <Footer x:Margin='0.31496062992125984'/>
    <PageMargins x:Bottom='0.74803149606299213' x:Left='0.23622047244094491'
     x:Right='0.23622047244094491' x:Top='0.74803149606299213'/>
   </PageSetup>
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
     <ActiveCol>14</ActiveCol>
    </Pane>
   </Panes>
   <ProtectObjects>False</ProtectObjects>
   <ProtectScenarios>False</ProtectScenarios>
  </WorksheetOptions>
 </Worksheet>
 
 
 
 <Worksheet ss:Name='系'>
  <Names>
   <NamedRange ss:Name='Print_Area' ss:RefersTo='=系!C1:C16'/>
   <NamedRange ss:Name='Print_Titles' ss:RefersTo='=系!R1'/>
  </Names>
  <Table ss:ExpandedColumnCount='16' ss:ExpandedRowCount='${fn:length(dept)+1}' x:FullColumns='1'
   x:FullRows='1' ss:StyleID='s17' ss:DefaultColumnWidth='54'
   ss:DefaultRowHeight='16.5'>
   <Column ss:StyleID='s16' ss:AutoFitWidth='0' ss:Width='103.5'/>
   <Column ss:StyleID='s16' ss:AutoFitWidth='0' ss:Width='37.5'/>
   <Column ss:StyleID='s16' ss:AutoFitWidth='0' ss:Width='55.5'/>
   <Column ss:StyleID='s16' ss:AutoFitWidth='0' ss:Width='30.75'/>
   <Column ss:StyleID='s16' ss:AutoFitWidth='0' ss:Width='33' ss:Span='1'/>
   <Column ss:Index='7' ss:StyleID='s16' ss:AutoFitWidth='0' ss:Width='67.5'/>
   <Column ss:StyleID='s16' ss:Width='48' ss:Span='1'/>
   <Column ss:Index='10' ss:StyleID='s16' ss:AutoFitWidth='0' ss:Width='67.5'/>
   <Column ss:StyleID='s16' ss:Width='48' ss:Span='1'/>
   <Column ss:Index='13' ss:StyleID='s16' ss:AutoFitWidth='0' ss:Width='37.5'/>
   <Column ss:StyleID='s16' ss:AutoFitWidth='0' ss:Width='39.75'/>
   <Column ss:StyleID='s16' ss:AutoFitWidth='0' ss:Width='79.5' ss:Span='1'/>
   <Row>
    <Cell><Data ss:Type='String'>名稱</Data><NamedCell ss:Name='Print_Titles'/><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='String'>人數</Data><NamedCell ss:Name='Print_Titles'/><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='String'>平均缺課</Data><NamedCell ss:Name='Print_Titles'/><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='String'>平時</Data><NamedCell ss:Name='Print_Titles'/><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='String'>期中</Data><NamedCell ss:Name='Print_Titles'/><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='String'>學期</Data><NamedCell ss:Name='Print_Titles'/><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='String'>期中不及格</Data><NamedCell ss:Name='Print_Titles'/><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='String'>期中1/2</Data><NamedCell ss:Name='Print_Titles'/><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='String'>期中2/3</Data><NamedCell ss:Name='Print_Titles'/><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='String'>學期不及格</Data><NamedCell ss:Name='Print_Titles'/><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='String'>學期1/2</Data><NamedCell ss:Name='Print_Titles'/><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='String'>學期2/3</Data><NamedCell ss:Name='Print_Titles'/><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='String'>扣考</Data><NamedCell ss:Name='Print_Titles'/><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell ss:StyleID='s18'><Data ss:Type='String'>流失</Data><NamedCell ss:Name='Print_Titles'/><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell ss:StyleID='s18'><Data ss:Type='String'>系主任</Data><NamedCell ss:Name='Print_Titles'/><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='String'>院長</Data><NamedCell ss:Name='Print_Titles'/><NamedCell ss:Name='Print_Area'/></Cell>
   </Row>
   
   <c:forEach items="${dept}" var="c">
   <c:if test="${c.cnt>0 && c.dilg>0}">
   <Row>
    <Cell><Data ss:Type='String'>${c.name}</Data><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='Number'>${c.cnt}</Data><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='Number'><fmt:formatNumber value="${c.dilg/c.cnt}" pattern="0.000"/></Data><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='Number'><fmt:formatNumber value="${c.score1/c.total}" pattern="0.000"/></Data><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='Number'><fmt:formatNumber value="${c.score2/c.total}" pattern="0.000"/></Data><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='Number'><fmt:formatNumber value="${c.score/c.total}" pattern="0.000"/></Data><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='Number'><fmt:formatNumber value="${c.score2d/c.cnt}" pattern="0.000"/></Data><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='Number'><fmt:formatNumber value="${c.m21/c.cnt}" pattern="0.000"/></Data><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='Number'><fmt:formatNumber value="${c.m32/c.cnt}" pattern="0.000"/></Data><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='Number'><fmt:formatNumber value="${c.scored/c.cnt}" pattern="0.000"/></Data><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='Number'><fmt:formatNumber value="${c.e21/c.cnt}" pattern="0.000"/></Data><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='Number'><fmt:formatNumber value="${c.e32/c.cnt}" pattern="0.000"/></Data><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='Number'>${c.block}</Data><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='Number'>${c.gstmd}</Data><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='String'>${c.director}</Data><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='String'>${c.leader}</Data><NamedCell ss:Name='Print_Area'/></Cell>
   </Row>
   </c:if>
   </c:forEach>
  </Table>
  <WorksheetOptions xmlns='urn:schemas-microsoft-com:office:excel'>
   <PageSetup>
    <Layout x:Orientation='Landscape'/>
    <Header x:Margin='0.31496062992125984' x:Data='&amp;C&amp;&quot;微軟正黑體,粗體&quot;&amp;24系成績趨勢表'/>
    <Footer x:Margin='0.31496062992125984'/>
    <PageMargins x:Bottom='0.74803149606299213' x:Left='0.23622047244094491' x:Right='0.23622047244094491' x:Top='0.74803149606299213'/>
   </PageSetup>
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
     <ActiveCol>14</ActiveCol>
    </Pane>
   </Panes>
   <ProtectObjects>False</ProtectObjects>
   <ProtectScenarios>False</ProtectScenarios>
  </WorksheetOptions>
 </Worksheet>
 
 
 <Worksheet ss:Name='院'>
  <Names>
   <NamedRange ss:Name='Print_Area' ss:RefersTo='=院!C1:C16'/>
   <NamedRange ss:Name='Print_Titles' ss:RefersTo='=院!R1'/>
  </Names>
  <Table ss:ExpandedColumnCount='16' ss:ExpandedRowCount='${fn:length(col)+1}' x:FullColumns='1'
   x:FullRows='1' ss:StyleID='s17' ss:DefaultColumnWidth='54'
   ss:DefaultRowHeight='16.5'>
   <Column ss:StyleID='s16' ss:AutoFitWidth='0' ss:Width='103.5'/>
   <Column ss:StyleID='s16' ss:AutoFitWidth='0' ss:Width='37.5'/>
   <Column ss:StyleID='s16' ss:AutoFitWidth='0' ss:Width='55.5'/>
   <Column ss:StyleID='s16' ss:AutoFitWidth='0' ss:Width='30.75'/>
   <Column ss:StyleID='s16' ss:AutoFitWidth='0' ss:Width='33' ss:Span='1'/>
   <Column ss:Index='7' ss:StyleID='s16' ss:AutoFitWidth='0' ss:Width='67.5'/>
   <Column ss:StyleID='s16' ss:Width='48' ss:Span='1'/>
   <Column ss:Index='10' ss:StyleID='s16' ss:AutoFitWidth='0' ss:Width='67.5'/>
   <Column ss:StyleID='s16' ss:Width='48' ss:Span='1'/>
   <Column ss:Index='13' ss:StyleID='s16' ss:AutoFitWidth='0' ss:Width='37.5'/>
   <Column ss:StyleID='s16' ss:AutoFitWidth='0' ss:Width='39.75'/>
   <Column ss:StyleID='s16' ss:AutoFitWidth='0' ss:Width='79.5' ss:Span='1'/>
   <Row>
    <Cell><Data ss:Type='String'>名稱</Data><NamedCell ss:Name='Print_Titles'/><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='String'>人數</Data><NamedCell ss:Name='Print_Titles'/><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='String'>平均缺課</Data><NamedCell ss:Name='Print_Titles'/><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='String'>平時</Data><NamedCell ss:Name='Print_Titles'/><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='String'>期中</Data><NamedCell ss:Name='Print_Titles'/><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='String'>學期</Data><NamedCell ss:Name='Print_Titles'/><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='String'>期中不及格</Data><NamedCell ss:Name='Print_Titles'/><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='String'>期中1/2</Data><NamedCell ss:Name='Print_Titles'/><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='String'>期中2/3</Data><NamedCell ss:Name='Print_Titles'/><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='String'>學期不及格</Data><NamedCell ss:Name='Print_Titles'/><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='String'>學期1/2</Data><NamedCell ss:Name='Print_Titles'/><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='String'>學期2/3</Data><NamedCell ss:Name='Print_Titles'/><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='String'>扣考</Data><NamedCell ss:Name='Print_Titles'/><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell ss:StyleID='s18'><Data ss:Type='String'>流失</Data><NamedCell ss:Name='Print_Titles'/><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell ss:StyleID='s18'><Data ss:Type='String'></Data><NamedCell ss:Name='Print_Titles'/><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='String'>院長</Data><NamedCell ss:Name='Print_Titles'/><NamedCell ss:Name='Print_Area'/></Cell>
   </Row>
   
   <c:forEach items="${col}" var="c">
   <c:if test="${c.cnt>0 && c.dilg>0}">
   <Row>
    <Cell><Data ss:Type='String'>${c.name}</Data><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='Number'>${c.cnt}</Data><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='Number'><fmt:formatNumber value="${c.dilg/c.cnt}" pattern="0.000"/></Data><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='Number'><fmt:formatNumber value="${c.score1/c.total}" pattern="0.000"/></Data><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='Number'><fmt:formatNumber value="${c.score2/c.total}" pattern="0.000"/></Data><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='Number'><fmt:formatNumber value="${c.score/c.total}" pattern="0.000"/></Data><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='Number'><fmt:formatNumber value="${c.score2d/c.cnt}" pattern="0.000"/></Data><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='Number'><fmt:formatNumber value="${c.m21/c.cnt}" pattern="0.000"/></Data><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='Number'><fmt:formatNumber value="${c.m32/c.cnt}" pattern="0.000"/></Data><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='Number'><fmt:formatNumber value="${c.scored/c.cnt}" pattern="0.000"/></Data><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='Number'><fmt:formatNumber value="${c.e21/c.cnt}" pattern="0.000"/></Data><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='Number'><fmt:formatNumber value="${c.e32/c.cnt}" pattern="0.000"/></Data><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='Number'>${c.block}</Data><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='Number'>${c.gstmd}</Data><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='String'>${c.director}</Data><NamedCell ss:Name='Print_Area'/></Cell>
    <Cell><Data ss:Type='String'>${c.leader}</Data><NamedCell ss:Name='Print_Area'/></Cell>
   </Row>
   </c:if>
   </c:forEach>
  </Table>
  <WorksheetOptions xmlns='urn:schemas-microsoft-com:office:excel'>
   <PageSetup>
    <Layout x:Orientation='Landscape'/>
    <Header x:Margin='0.31496062992125984' x:Data='&amp;C&amp;&quot;微軟正黑體,粗體&quot;&amp;24院成績趨勢表'/>
    <Footer x:Margin='0.31496062992125984'/>
    <PageMargins x:Bottom='0.74803149606299213' x:Left='0.23622047244094491' x:Right='0.23622047244094491' x:Top='0.74803149606299213'/>
   </PageSetup>
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
     <ActiveCol>14</ActiveCol>
    </Pane>
   </Panes>
   <ProtectObjects>False</ProtectObjects>
   <ProtectScenarios>False</ProtectScenarios>
  </WorksheetOptions>
 </Worksheet>
 
 
</Workbook>
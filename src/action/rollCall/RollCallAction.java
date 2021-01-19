package action.rollCall;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import model.Message;
import action.BaseAction;

public class RollCallAction extends BaseAction{	
	
	Calendar c=Calendar.getInstance();//現在時間
	SimpleDateFormat sf=new SimpleDateFormat("yyyy-MM-dd");		
	//SimpleDateFormat sf1=new SimpleDateFormat("M月d日");	
	
	public String execute() throws Exception {				
		
		Date rollcall_begin=sf.parse((String)getContext().getAttribute("rollcall_begin"));//取得點名開始日期
		Date rollcall_end=sf.parse((String)getContext().getAttribute("rollcall_end"));//取得䵞名結束日期	
		
		if(c.getTimeInMillis()>rollcall_end.getTime()){//若今天>學期結束時間			
			if((c.getTimeInMillis()-1296000000)<rollcall_end.getTime()){//今天扣1星期<學期結束時間
				c.setTime(rollcall_end);
			}
		}
		
		//每周點名模版		
		List<Map>list=df.sqlGet("SELECT d.Oid as dOid, cl.CampusNo,  cl.SchoolNo, " +
		"dc.*, cl.ClassName, cs.chi_name FROM Dtime d, Csno cs, Class cl, Dtime_class dc " +
		"WHERE d.cscode=cs.cscode AND d.depart_class=cl.ClassNo AND d.Oid=dc.Dtime_oid AND " +
		"d.Sterm='"+getContext().getAttribute("school_term")+"' AND d.techid='"+getSession().getAttribute("userid")+"'");
		//1科目多教師		
		list.addAll(df.sqlGet("SELECT d.Oid as dOid, cl.CampusNo,  cl.SchoolNo, dc.*, cl.ClassName, cs.chi_name FROM " +
		"Dtime d, Csno cs, Class cl, Dtime_class dc, Dtime_teacher dt WHERE dt.Dtime_oid=d.Oid AND " +
		"d.cscode=cs.cscode AND d.depart_class=cl.ClassNo AND d.Oid=dc.Dtime_oid AND (d.techid IS NULL OR d.techid='')AND " +
		"d.Sterm='"+getContext().getAttribute("school_term")+"' AND dt.teach_id='"+getSession().getAttribute("userid")+"'"));
		
		//目前8天
		List<Map>callInfo=getCallInfo(rollcall_begin, rollcall_end, list, 8, true);		
		
		//重大集會
		List<Map>tmp=df.sqlGet("SELECT did.Oid, c.ClassNo, c.ClassName, did.name as chi_name,did.date,dic.edit FROM "
		+ "Dilg_imp_date did, Dilg_imp_class dic, Class c WHERE c.ClassNo=dic.ClassNo AND dic.Dilg_imp_date_oid=did.Oid AND "
		+ "c.tutor='"+getSession().getAttribute("userid")+"'AND did.date>='"+sf.format(c.getTime())+"' AND did.date<='"+sf.format(new Date())+"'");
		callInfo=bm.sortListByKey(callInfo, "sdate", true);
		tmp.addAll(callInfo);		
		request.setAttribute("weeks", tmp);
		
		//8天前的130天只可讀
		//if(session.get("oldweeks")==null){
			//課程照理說不會在此當下被課務單位修改
		List<Map>myCs=df.sqlGet("SELECT d.Oid, cs.chi_name, c.ClassName FROM Dtime d, Csno cs, Class c WHERE " +
		"d.cscode=cs.cscode AND d.depart_class=c.ClassNo AND d.techid='"+getSession().getAttribute("userid")+"' AND d.Sterm='"+getContext().getAttribute("school_term")+"'");
		
		myCs.addAll(df.sqlGet("SELECT d.Oid, cs.chi_name, c.ClassName FROM Dtime d, Csno cs, Class c, Dtime_teacher dt WHERE " + 
		"d.Oid=dt.Dtime_oid AND d.cscode=cs.cscode AND d.depart_class=c.ClassNo AND dt.teach_id='"+getSession().getAttribute("userid")+"' AND d.Sterm='"+getContext().getAttribute("school_term")+"'"));
		
		//因此存死課程
		getSession().setAttribute("myCs",myCs );
			
			
			
			
			
			
			
			getSession().setAttribute("oldweeks", bm.sortListByKey(getCallInfo(rollcall_begin, rollcall_end, list, 130, false), "sdate", true));
		//}		
		//圖表
		//request.setAttribute("chart", sam.Dilg_pro_techid((String) getSession().getAttribute("userid"), rollcall_begin, getContext().getAttribute("school_term").toString()));
		
		
		Calendar c=Calendar.getInstance();
		Calendar c1=Calendar.getInstance();
		Calendar c2;
		
		list=df.sqlGet("SELECT ((SELeCT COUNT(*)FROM stmd, Seld WHERE stmd.student_no=Seld.student_no AND Seld.Dtime_oid=d.Oid)*d.thour) as cnt, d.Oid, cl.ClassName, cs.chi_name FROM Dtime d, " +
		"Csno cs, Class cl WHERE d.cscode=cs.cscode AND d.depart_class=cl.ClassNo AND d.techid='"+getSession().getAttribute("userid")+"' AND d.Sterm='"+getContext().getAttribute("school_term")+"'");
		
		//float cnt;
		
		for(int i=0; i<list.size(); i++){
			
			c.setTime(rollcall_begin);
			c1.setTime(rollcall_begin);
			c2=Calendar.getInstance();			
			
			
			list.get(i).put("hist", getWeek(list.get(i), c, c1, c2));
			
		}
		request.setAttribute("chart", list);
		
		
		
		
		
		
		
		return "intro";
	}	
	
	
	private List getWeek(Map cs, Calendar c, Calendar c1, Calendar c2){
		float abs, cnt;
		List tmp=new ArrayList();
		Map m;
		for(int j=1; j<19; j++){
			m=new HashMap();
			c1.add(Calendar.DAY_OF_YEAR, 7);
			c2.setTime(c1.getTime());
			c2.add(Calendar.DAY_OF_YEAR, -1);
			cnt=Float.parseFloat(cs.get("cnt").toString());
			abs=Float.parseFloat(df.sqlGetStr("SELECT COUNT(*)FROM Dilg WHERE date>='" +
			sf.format(c.getTime())+"'AND date<='"+sf.format(c2.getTime())+"' AND Dtime_oid="+cs.get("Oid")));
			
			m.put("abs", abs);
			m.put("par", 100.0f-((abs/cnt)*100));
			tmp.add(m);
			//System.out.println(m);
			c.add(Calendar.DAY_OF_YEAR, 7);
			
		}
		
		
		return tmp;
		
	}
	
	/**
	 * 重大集會點名
	 * @return
	 */
	public String impCall(){
		SimpleDateFormat sf1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");	
		df.exSql("UPDATE Dilg_imp_class SET edit='"+sf1.format(new Date())+"'WHERE ClassNo='"+impClass+"'AND Dilg_imp_date_oid="+impOid);
		List<Map>list=df.sqlGet("SELECT s.student_no, s.student_name, di.cls FROM stmd s LEFT "
		+ "OUTER JOIN Dilg_imp di ON s.student_no=di.student_no AND di.Dilg_imp_date_oid='"+impOid+"'"
		+ "WHERE s.depart_class='"+impClass+"'ORDER BY s.student_no");		
		request.setAttribute("info", df.sqlGetMap("SELECT * FROM Dilg_imp_date WHERE Oid="+impOid));
		request.setAttribute("students", list);
		return "impCall";
	}
	
	
	/**
	 * 依日期節次塞資訊
	 * @param cs
	 * @return
	 */
	private List getCallInfo(Date rollcall_begin, Date rollcall_end, List<Map>list, int day, boolean thisweek){
		Calendar cl=Calendar.getInstance();
		Map map;
		int week;		
		
		String DilgLog_date;
		String Dtime_oid;
		int DilgLog_date_due;		
		
		List myCs=new ArrayList();
		
		List dilguneed=(List) getContext().getAttribute("holiday");//不需
		String nd;
		
		//要執行的天數
		for(int i=1; i<=day; i++){			
			//學期前後日子不點名
			if(c.getTimeInMillis()<rollcall_begin.getTime() || c.getTimeInMillis()>rollcall_end.getTime()){
				continue;
			}
			
			//星期與排課星期同步
			week=c.get(Calendar.DAY_OF_WEEK)-1;
			if(week==0){
				week=7;
			}	
			
			//所有課程中排課星期相同的課程加入點名
			for(int j=0; j<list.size(); j++){				
				if(!sam.Dilg_uneed(dilguneed, sf.format(c.getTime()))){
					continue;
				}
				
				if((int)list.get(j).get("week")==week){
					map=new HashMap();
					map.putAll((Map)list.get(j));					
					DilgLog_date=sf.format(c.getTime());
					Dtime_oid=map.get("dOid").toString();					
					try{
						//當日應到
						DilgLog_date_due=sam.DilgLog_date_due(Dtime_oid, DilgLog_date);				
						
						
					}catch(Exception e){
						DilgLog_date_due=0;
					}					
					map.put("date", sf.format(c.getTime()));
					map.put("showDate", c.getTime());
					map.put("shoWeek", bl.getWeekOfDay4Zh(week, ""));
					map.put("sdate", c.getTimeInMillis());
					
					//當日有點名記錄
					if(DilgLog_date_due>0){
						map.put("select", DilgLog_date_due);
						map.put("info", sam.Dilg_info(Dtime_oid, DilgLog_date));
						map.put("log", true);
					}else{
						map.put("select", sam.Seld_count(Dtime_oid));
						map.put("info", "0人");
						map.put("log", false);
					}
					try{
						map.put("weather", df.sqlGetMap("SELECT w.*, DATE_FORMAT(w.ftime,'%m月%d日%h:%i%p')as ftime FROM WeatherHist w WHERE w.ftime='"+DilgLog_date+" "+(Integer.parseInt(map.get("begin").toString())+8)+":00'"));
						if(thisweek){
							cl.setTime(sf.parse(DilgLog_date));
							cl.add(Calendar.DAY_OF_YEAR, 7);
							map.put("nextw", df.sqlGetMap("SELECT w.*, DATE_FORMAT(w.ftime,'%m月%d日%h:%i%p')as ftime FROM WeatherHist w WHERE w.ftime='"+sf.format(cl.getTime())+" "+(Integer.parseInt(map.get("begin").toString())+8)+":00'"));
						}
					
					}catch(Exception e){
						e.printStackTrace();
					}
					
					myCs.add(map);
					//System.out.println(map);
				}		
								
			}
			//1天完畢下1天
			c.add(Calendar.DAY_OF_YEAR, -1);
		}
		return myCs;
	}
	
	/**
	 * 全班到齊
	 * @return
	 * @throws Exception
	 */
	public String callAll() throws Exception{				
		Message msg=new Message();
		try{	
			df.exSql("INSERT INTO DilgLog(date, Dtime_oid,due)VALUES" +
			"('"+date+"','"+Oid+"',"+df.sqlGetInt("SELECT COUNT(*)FROM Seld WHERE Dtime_oid="+Oid)+")");				
			msg.setSuccess("完成點名");
			savMessage(msg);
		}catch(Exception e){				
			msg.setError("重複記錄");
			savMessage(msg);
		}			
		return execute();		
	}
	
	/**
	 * 單一課程點名
	 * @return
	 * @throws ParseException
	 */
	public String callOne() throws ParseException{
		try{//立即寫入點名計錄
			df.exSql("INSERT INTO DilgLog(date, Dtime_oid,due)VALUES" +
			"('"+date+"','"+Oid+"',"+df.sqlGetInt("SELECT COUNT(*)FROM Seld WHERE Dtime_oid="+Oid)+")");
		}catch(Exception e){
			//重複
		}		
		
		initCall();
		
			
		return "rollCall";
		
	}
	
	private List Dilg_student_date(String Oid, String date, String week){	
		
		List<Map>list=df.sqlGet("SELECT status, st.student_no, st.student_name,(SELECT COUNT(*)FROM Dilg di, Dilg_rules dr WHERE di.abs=dr.id AND " +
		"dr.exam='1'AND di.student_no=st.student_no AND di.Dtime_oid=d.Oid) as dilg_period, s.score1, s.score2, s.score FROM " +
		"Dtime d, stmd st, Seld s WHERE st.student_no=s.student_no AND " +
		"s.Dtime_oid=d.Oid AND d.Oid="+Oid+" AND s.Dtime_teacher=(SELECT Oid FROM Dtime_teacher WHERE " +
		"Dtime_oid="+Oid+" AND teach_id='"+getSession().getAttribute("userid")+"')ORDER BY st.student_no");	
		
		Object dc[]=sam.Dtime_class(Oid, week);		
		List dg;
		Map m;		
		for(int i=0; i<list.size(); i++){
			dg=new ArrayList();
			for(int j=0; j<dc.length; j++){
				m=new HashMap();
				m.put("cls", dc[j]);
				try{
					m.put("abs", df.sqlGetStr("SELECT abs FROM Dilg WHERE student_no='"+list.get(i).get("student_no")+"' AND cls='"+dc[j]+"' AND date='"+date+"'"));
				}catch(Exception e){
					m.put("abs", "");
				}				
				dg.add(m);
			}			
			list.get(i).put("dilgs", dg);			
		}		
		return list;
	}
	
	private void initCall(){
		
		Map map=df.sqlGetMap("SELECT d.Oid, c.ClassName, cs.chi_name FROM " +
		"Dtime d, Class c, Csno cs WHERE cs.cscode=d.cscode AND d.depart_class=c.ClassNo  AND d.Oid="+Oid);
		map.put("week", week);
		map.put("date", date);
		request.setAttribute("info", map);
		
		
		//判斷取全班或取分組
		List stds;
		if(df.sqlGetInt("SELECT COUNT(*) FROM Dtime_teacher dt, Dtime d WHERE dt.Dtime_oid=d.Oid AND (d.techid='' OR d.techid IS NULL)AND " +
		"dt.Dtime_oid="+Oid+" AND dt.teach_id='"+getSession().getAttribute("userid")+"'")>0){
			stds=this.Dilg_student_date(Oid, date, week);//取分組
		}else{
			stds=sam.Dilg_student_date(Oid, date, week);//取全班
			
		}		
		request.setAttribute("students", stds);
		request.setAttribute("dclass", sam.Dtime_class(Oid, week));	
		
	}
	
	public String viewOne(){
		/*Map map=df.sqlGetMap("SELECT d.Oid, c.ClassName, cs.chi_name FROM " +
		"Dtime d, Class c, Csno cs WHERE cs.cscode=d.cscode AND d.depart_class=c.ClassNo  AND d.Oid="+Oid);
		map.put("week", week);
		map.put("date", date);
		request.setAttribute("info", map);		
		request.setAttribute("students", sam.Dilg_student_date(Oid, date, week));		
		request.setAttribute("dclass", sam.Dtime_class(Oid, week));	*/
		initCall();
		return "rollView";
	}
	
	/**
	 * 出席率圖表
	 * @param techid
	 * @param begin
	 * @param term
	 * @return
	 
	private Map Dilg_pro_techid(String techid, Date begin, String term){
		SimpleDateFormat sf=new SimpleDateFormat("yyyy/MM/dd");
		Calendar c=Calendar.getInstance();
		Calendar c1=Calendar.getInstance();
		Calendar c2=Calendar.getInstance();
		c.setTime(begin);
		c1.setTime(begin);
		
		List<Map>list=df.sqlGet("SELECT ((SELeCT COUNT(*)FROM stmd, Seld WHERE stmd.student_no=Seld.student_no AND Seld.Dtime_oid=d.Oid)*d.thour) as cnt, d.Oid, cl.ClassName, cs.chi_name FROM Dtime d, " +
		"Csno cs, Class cl WHERE d.cscode=cs.cscode AND d.depart_class=cl.ClassNo AND d.techid='"+techid+"' AND d.Sterm='"+term+"'");		
		//list.addAll(df.sqlGet("SELECT ((SELeCT COUNT(*)FROM stmd, Seld WHERE stmd.student_no=Seld.student_no AND Seld.Dtime_oid=d.Oid)*d.thour) as cnt,"
				//+ "d.Oid, cl.ClassName, cs.chi_name FROM Dtime d, Dtime_teacher dt, Csno cs, Class cl WHERE "
				//+ "(d.techid IS NULL OR d.techid='')AND d.Oid=dt.Dtime_oid AND d.cscode=cs.cscode AND d.depart_class=cl.ClassNo AND "
				//+ "dt.teach_id='"+techid+"' AND d.Sterm='"+term+"'"));
		
		float cnt;
		float wdilg;
		
		StringBuilder sb=new StringBuilder("['週次',");
		for(int i=0; i<list.size(); i++){
			sb.append("'"+((Map)list.get(i)).get("ClassName")+"-"+((Map)list.get(i)).get("chi_name")+"',");
		}
		sb.delete(sb.length()-1, sb.length());				
		sb.append("],");		
		Map map=new HashMap();		
		map.put("dtimes", sb);		
		String sba[]=new String[19];
		
		
		for(int i=1; i<19; i++){
			c1.add(Calendar.DAY_OF_YEAR, 7);
			c2.setTime(c1.getTime());
			c2.add(Calendar.DAY_OF_YEAR, -1);
			sb=new StringBuilder("['第"+i+"週',");			
			for(int k=0; k<list.size(); k++){
				try{
					cnt=Float.parseFloat(list.get(k).get("cnt").toString());					
					wdilg=Float.parseFloat(df.sqlGetStr("SELECT COUNT(*)FROM Dilg WHERE date>='" +
					sf.format(c.getTime())+"'AND date<='"+sf.format(c2.getTime())+"' AND Dtime_oid="+list.get(k).get("Oid")));					
					sb.append(100-((wdilg/cnt)*100)+",");	
				}catch(Exception e){
					sb.append(100+",");	
				}							
			}
			
			sb.delete(sb.length()-1, sb.length());				
			sb.append("]");
			if(i<18){sb.append(",");}
			sba[i]=sb.toString();
			map.put("dilgs", sba);		
			
			c.add(Calendar.DAY_OF_YEAR, 7);
			
		}	
		return map;
	}*/
	
	public String Oid;	
	public String date;
	public String week;
	
	public String impOid;
	public String impClass;
	public String cls;
}

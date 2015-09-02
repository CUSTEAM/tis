package action;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

public class StayTimeManagerAction extends BaseAction{
	
	public String week[], period[], kind[];
	public String place, contact, remark;
	
	public String execute(){
		
		String year=getContext().getAttribute("school_year").toString();
		String term=getContext().getAttribute("school_term").toString();
		
		String userOid=df.sqlGetStr("SELECT Oid FROM empl WHERE idno='"+getSession().getAttribute("userid")+"'");
		//取留校資訊
		Map rule=df.sqlGetMap("SELECT (SELECT cdate FROM SYS_CALENDAR WHERE name='staytime_end')as over,"
		+ "(SELECT COUNT(*)FROM Empl_stay_hist WHERE idno='"+getSession().getAttribute("userid")+"' AND edate>'"+getContext().getAttribute("staytime_end")+"')as cnt,"
		+ "IFNULL((SELECT COUNT(*) FROM Empl_stay_info WHERE idno=e.idno AND kind='1'AND school_year='"+year+"'AND school_term='"+term+"'),0)as tech_stay,"//課後輔導
		+ "IFNULL((SELECT COUNT(*) FROM Empl_stay_info WHERE idno=e.idno AND kind='2'AND school_year='"+year+"'AND school_term='"+term+"'),0)as tutor_stay,"//生活輔導
		+ "IFNULL((SELECT time_stay FROM Empl_techlimit WHERE idno=e.idno),0)as time_cut,"//扣除額
		+ "IFNULL((SELECT time FROM Empl_techlimit WHERE idno=e.idno),0)as thour "//應留校時間
		//+ "IFNULL((SELECT COUNT(*)FROM Class WHERE tutor=e.idno),0)as tutor "//生活輔導時間
		+ "FROM empl e WHERE e.idno='"+getSession().getAttribute("userid")+"'");
		
		int sum=0;//生活輔導
		List<Map>tmp=df.sqlGet("SELECT IFNULL(IF(COUNT(*)>30, 4, 2),0)as c FROM stmd s,Class c WHERE s.depart_class=c.ClassNo AND c.tutor='"+getSession().getAttribute("userid")+"' GROUP BY c.ClassNo");
		for(int i=0; i<tmp.size(); i++)sum+=Integer.parseInt(tmp.get(i).get("c").toString());
		rule.put("tutor", sum);
			
		//取課程
		List<Map>cs=df.sqlGet("SELECT '0'as kind, d.thour,c.ClassName, cs.chi_name, dc.* FROM Class c, Dtime d, Dtime_class dc, Csno cs WHERE "
		+ "d.depart_class=c.ClassNo AND cs.cscode=d.cscode AND d.Oid=dc.Dtime_oid AND d.Sterm='"+getContext().getAttribute("school_term")+"' AND d.techid='"+getSession().getAttribute("userid")+"'");
		cs.addAll(df.sqlGet("SELECT '0'as kind,d.thour, c.ClassName, cs.chi_name, dc.* FROM Class c, Dtime d,Dtime_teacher dt, Dtime_class dc, Csno cs WHERE d.Oid=dt.Dtime_oid AND "
		+ "d.depart_class=c.ClassNo AND cs.cscode=d.cscode AND d.Oid=dc.Dtime_oid AND d.Sterm='"+getContext().getAttribute("school_term")+"' AND dt.teach_id='"+getSession().getAttribute("userid")+"'"));
		
		//計算時數
		//int thour=0;
		
		/*for(int i=0; i<cs.size(); i++){			
			thour+=Integer.parseInt(cs.get(i).get("thour").toString());
		}*/
		
		
		//rule.put("thour", thour);
		request.setAttribute("rule", rule);		
		request.setAttribute("cs", cs);
		request.setAttribute("st", df.sqlGet("SELECT e.kind, e.week, e.period as begin, e.period as end, c.name as chi_name FROM "
		+ "Empl_stay_info e, CODE_TEACHER_STAY c WHERE c.id=e.kind AND c.school_year='"+year+"' AND c.school_term='"+term+"' e.idno='"+getSession().getAttribute("userid")+"'"));
		request.setAttribute("place", df.sqlGetMap("SELECT * FROM Empl_stay_place WHERE idno='"+getSession().getAttribute("userid")+"'"));
		return SUCCESS;
	}
	
	public String save(){
		String userOid=df.sqlGetStr("SELECT Oid FROM empl WHERE idno='"+getSession().getAttribute("userid")+"'");
		df.exSql("DELETE FROM Empl_stay_info WHERE idno='"+getSession().getAttribute("userid")+"'");
		StringBuilder cnt=new StringBuilder();
		for(int i=0; i<week.length; i++){
			if(!kind[i].equals("")){
				cnt.append(week[i]+","+period[i]+","+kind[i]+";");
				df.exSql("INSERT INTO Empl_stay_info(EmplOid,week,period,kind,idno,school_year,school_term)VALUES("+userOid+",'"+week[i]+"','"+period[i]+"','"+kind[i]+"','"+getSession().getAttribute("userid")+"','"+getContext().getAttribute("school_year")+"','"+getContext().getAttribute("school_term")+"');");
			}
			
		}		
		df.exSql("INSERT INTO Empl_stay_place(place,contact,remark,idno)VALUES('"+place+"','"+contact+"','"+remark+"','"+getSession().getAttribute("userid")+"')ON DUPLICATE KEY UPDATE place='"+place+"', contact='"+contact+"', remark='"+remark+"';");
		df.exSql("INSERT INTO Empl_stay_hist(idno, content)VALUES('"+getSession().getAttribute("userid")+"','"+cnt+"');");
		return execute();
	}

}

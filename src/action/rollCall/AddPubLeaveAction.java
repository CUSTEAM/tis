package action.rollCall;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;
import model.Dilg;
import model.DilgApply;
import model.DilgApplyHist;
import model.Message;
import action.BaseAction;

public class AddPubLeaveAction extends BaseAction{
	
	public String student_no;
	public String beginDate;
	public String endDate;
	public int begin;
	public int end;
	public String reason;
	public String nameno;
	SimpleDateFormat sf=new SimpleDateFormat("yyyy-MM-dd");
	public String execute() throws Exception {
		//17週後禁用
		SimpleDateFormat sf=new SimpleDateFormat("yyyy-MM-dd");
		Calendar c=Calendar.getInstance();
		c.setTime(sf.parse(getContext().getAttribute("school_term_begin").toString()));
		c.add(Calendar.WEEK_OF_YEAR, 17);
		Date today=new Date();
		if(today.getTime()>c.getTimeInMillis()){
			request.setAttribute("exp", true);
		}
		
		//刪除
		if(request.getParameter("dOid")!=null){
			//刪歷程
			df.exSql("DELETE FROM Dilg_apply_hist WHERE Dilg_app_oid="+request.getParameter("dOid"));
			//刪假單
			df.exSql("DELETE FROM Dilg_apply WHERE Oid="+request.getParameter("dOid"));
			//刪缺課			
			df.exSql("DELETE FROM Dilg WHERE Dilg.Dilg_app_oid="+request.getParameter("dOid"));			
		}
		
		List list=df.sqlGet("SELECT e.cname, d.result, c.ClassName, d.Oid, s.student_no, s.student_name, d.reason FROM empl e, Dilg_apply d, stmd s, " +
		"Class c WHERE d.abs='6' AND e.idno=d.auditor AND c.ClassNo=s.depart_class AND d.student_no=s.student_no AND (d.auditor='"+getSession().getAttribute("userid")+"' OR d.Oid IN " +
		"(SELECT Dilg_app_oid FROM Dilg_apply_hist WHERE Dilg_apply_hist.auditor='"+getSession().getAttribute("userid")+"'))ORDER BY d.Oid DESC");
		
		for(int i=0; i<list.size(); i++){			
			((Map)list.get(i)).put("dilgs", df.sqlGet("SELECT d.date, d.cls, c.chi_name FROM Dilg d, Dtime dt, Csno c WHERE d.Dtime_oid=dt.Oid AND " +
			"dt.cscode=c.cscode AND d.Dilg_app_oid="+((Map)list.get(i)).get("Oid")+" ORDER BY d.date, d.cls"));
		}
		
		session.put("myapps", list);
		return "intro";
	}
	
	public String add() throws Exception {		
		
		if(student_no.trim().equals("")||beginDate.trim().equals("")||endDate.trim().equals("")||begin==0||end==0){
			Message m=new Message();
			m.setError("輸入不完整");
			savMessage(m);
			return execute();
		}
		
		if(df.sqlGetStr("SELECT total_score FROM Just WHERE student_no='"+student_no+"'")!=null){
			Message m=new Message();
			m.setError("已結算操行成績");
			savMessage(m);
			return execute();
		}
		
		if(begin>end){
			Message m=new Message();
			m.setError("節次矛盾");
			savMessage(m);
			return execute();
		}
		
		Calendar b=Calendar.getInstance();
		Calendar e=Calendar.getInstance();
		b.setTime(sf.parse(beginDate));
		e.setTime(sf.parse(endDate));
		
		if(b.getTimeInMillis()>e.getTimeInMillis()){
			Message m=new Message();
			m.setError("日期矛盾");
			savMessage(m);
			return execute();
		}
		
		int days=(int)((e.getTimeInMillis()-b.getTimeInMillis())/(1000*3600*24));//天
		
		//建立假單
		DilgApply da=new DilgApply();
		da.setAbs("6");		
		da.setReason(reason+"- 建立人: "+df.sqlGetStr("SELECT cname FROM empl WHERE idno='"+getSession().getAttribute("userid")+"'"));		
		da.setAuditor(df.sqlGetStr("SELECT tutor FROM Class c, stmd s WHERE c.ClassNo=s.depart_class AND s.student_no='"+student_no+"'"));		
		da.setStudent_no(student_no);		
		da.setRealLevel("1");
		da.setDefaultLevel("3");
		da.setCr_date(new Date());
		df.update(da);
		
		List dClass;
		boolean checkEmpty=false;
		for(int i=0; i<=days; i++){	
			int day=(b.get(Calendar.DAY_OF_WEEK)-1);//1~6
			if(day==0) day=7;//日
			//找出學生當天的課
			dClass=df.sqlGet("SELECT dc.* FROM Dtime d,Seld s,Dtime_class dc WHERE d.Sterm='"+getContext().getAttribute("school_term")+"'AND " +
			"d.Oid=s.Dtime_oid AND d.Oid=dc.Dtime_oid AND dc.week='"+day+"'AND((dc.begin>="+begin+" AND dc.begin<="+end+")OR " +
			"(dc.end>="+begin+" AND dc.end<="+end+")) AND s.student_no='"+student_no+"'");
			if(dClass.size()>0){
				checkEmpty=true;
			}
			//建立假
			for(int j=0; j<dClass.size(); j++){
				saveDilg(student_no, (Map)dClass.get(j), b.getTime(), da.getOid());				
			}			
			b.add(Calendar.DAY_OF_YEAR, 1);
		}
		
		if(!checkEmpty){
			Message m=new Message();
			m.setError(beginDate+" 第"+begin+"節至<br>"+endDate+" 第"+end+"節<br>學生無選課記錄");
			df.exSql("DELETE FROM Dilg_apply WHERE Oid="+da.getOid());
			da=null;
			savMessage(m);
		}
		
		return execute();		
	}
	
	public void saveDilg(String student_no, Map dc, Date date, Integer daOid){
		
		int begin=Integer.parseInt(dc.get("begin").toString());
		int end=Integer.parseInt(dc.get("end").toString());
		Dilg d;
		for(int i=begin; i<=end; i++){			
			if(i<this.begin||i>this.end)continue;			
			d=new Dilg();//建立缺課記錄
			d.setAbs("6");
			d.setCls(String.valueOf(i));
			d.setDate(date);
			d.setDtime_oid(Integer.parseInt(dc.get("Dtime_oid").toString()));
			d.setStudent_no(student_no);
			d.setDilg_app_oid(daOid);
			try{
				df.update(d);
			}catch(Exception e){
				e.printStackTrace();
				//只有重複請才會有這種情況!
				String seldOid=df.sqlGetStr("SELECT Oid FROM Seld WHERE student_no='"+student_no+"' AND Dtime_oid="+dc.get("Dtime_oid"));
				df.exSql("UPDATE Seld SET dilg_period=dilg_period-1 WHERE Oid="+seldOid);
				df.exSql("DELETE FROM Dilg WHERE student_no='"+student_no+"' AND date='"+sf.format(date)+"' AND cls='"+i+"'");
				df.update(d);
			}		
			
			//建立假單歷程
			DilgApplyHist dah=new DilgApplyHist();
			dah.setAuditor((String) getSession().getAttribute("userid"));
			dah.setDate(new Date());
			dah.setDilg_app_oid(daOid);
			df.update(dah);
		}
	}

}

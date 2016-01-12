package action;

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
		Map map;
		boolean b=false;
		//get single teacher list
		List<Map>myClass=df.sqlGet("SELECT cl.className, cs.chi_name, d.Oid, cs.cscode, cl.classNo, d.Sterm FROM Dtime d, Csno cs, Class cl "+ 
		"WHERE d.cscode=cs.cscode AND d.depart_class=cl.classNo AND d.Sterm='"+term+"' AND d.techid='"+getSession().getAttribute("userid")+
		"' AND d.cscode!='50000'ORDER BY d.depart_class");
		//get mult-teachers list
		myClass.addAll(df.sqlGet("SELECT cl.className, cs.chi_name, d.Oid, cs.cscode, cl.classNo, d.Sterm FROM "
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
			//圖表			
			map=df.sqlGetMap("SELECT "
			+ "IFNULL(AVG(s.score2),0)as score2, IFNULL(AVG(s.score3),0)score3,IFNULL(AVG(s.score01),0)as score01,IFNULL(AVG(s.score02),0)as score02,"
			+ "IFNULL(AVG(s.score03),0)as score03,IFNULL(AVG(s.score04),0)as score04,IFNULL(AVG(s.score05),0)as score05,"
			+ "IFNULL(AVG(s.score06),0)as score06,IFNULL(AVG(s.score07),0)as score07,IFNULL(AVG(s.score08),0)as score08,"
			+ "IFNULL(AVG(s.score09),0)as score09,IFNULL(AVG(s.score10),0)as score10 FROM Seld s WHERE s.Dtime_oid="+myClass.get(i).get("Oid"));
			
			if(Float.parseFloat(map.get("score01").toString())>0||Float.parseFloat(map.get("score2").toString())>0){
				b=true;
			}
			System.out.println(myClass.get(i).get("Oid")+":"+map);
			myClass.get(i).putAll(map);
			
		}		
		for(int i=0; i<myClass.size(); i++){
			myClass.get(i).put("time", df.sqlGet("SELECT * FROM Dtime_class WHERE Dtime_oid="+myClass.get(i).get("Oid")));			
		}
		
		request.setAttribute("myClass", myClass);		
		request.setAttribute("showChart", b);
		
		
		
		return SUCCESS;
	}
	
	/**
	 * get students
	 * @return
	 */
	public String edit(){
		//判斷取全班或取分組
		List stds;
		if(df.sqlGetInt("SELECT COUNT(*) FROM Dtime_teacher dt, Dtime d WHERE dt.Dtime_oid=d.Oid AND (d.techid='' OR d.techid IS NULL)AND " +
		"dt.Dtime_oid="+Dtime_oid+" AND dt.teach_id='"+getSession().getAttribute("userid")+"'")>0){
			//取分組
			request.setAttribute("students", df.sqlGet("SELECT st.student_name, s.* FROM Dtime d, stmd st, Seld s WHERE st.student_no=s.student_no AND "
			+"s.Dtime_oid=d.Oid AND d.Oid="+Dtime_oid+" AND s.Dtime_teacher=(SELECT Oid FROM Dtime_teacher WHERE "
			+"Dtime_oid="+Dtime_oid+" AND teach_id='"+getSession().getAttribute("userid")+"')ORDER BY st.student_no"));
		}else{
			//取全班
			request.setAttribute("students", df.sqlGet("SELECT st.student_name, s.* FROM Seld s, stmd st WHERE "
			+"s.student_no=st.student_no AND s.Dtime_oid='"+Dtime_oid+"' ORDER BY st.student_no"));
		}
		
		request.setAttribute("csinfo", df.sqlGetMap("SELECT c.ClassName, cs.chi_name FROM Dtime d, Class c, Csno cs WHERE d.depart_class=c.ClassNo AND d.cscode=cs.cscode AND d.Oid="+Dtime_oid));
		request.setAttribute("Dtime_oid", Dtime_oid);
		
		
		//expire date for input percentage of score
		Date now=new Date();
		Date edper,stper;
		try{
			SimpleDateFormat sf=new SimpleDateFormat("yyyy-MM-dd");
			edper=(Date) getContext().getAttribute("date_school_term_begin");				
			Calendar c=Calendar.getInstance();
			c.setTime(edper);
			c.add(Calendar.DAY_OF_YEAR, 14);
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
		request.setAttribute("seldpro", map);
		
		//expiry date for input score
		//expiry mid
		
		edper=(Date)getContext().getAttribute("date_exam_mid");
		if(now.getTime()>edper.getTime()){request.setAttribute("date1", "expiry");}
		//expiry fin		
		if(getContext().getAttribute("school_term").equals("2")){
			//under half
			if(!df.sqlGetStr("SELECT c.graduate FROM Dtime d, Class c WHERE d.depart_class=c.ClassNo AND d.Oid="+Dtime_oid).equals("0")){
				//graduating class
				edper=(Date)getContext().getAttribute("date_exam_grad");
				if(now.getTime()>edper.getTime()){request.setAttribute("date2", "expiry");}
			}else{
				//not graduating class
				edper=(Date)getContext().getAttribute("date_exam_fin");
				if(now.getTime()>edper.getTime()){request.setAttribute("date2", "expiry");}
			}
		}else{
			//upper half
			edper=(Date)getContext().getAttribute("date_exam_fin");
			if(now.getTime()>edper.getTime()){request.setAttribute("date2", getContext().getAttribute("exam_fin"));}
		}
				
		if(getContext().getAttribute("school_term").equals("2")){
			request.setAttribute("sdate3", getContext().getAttribute("exam_grad"));
		}
		request.setAttribute("sdate2", getContext().getAttribute("exam_fin"));	
		
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
	
	public String save(){
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
	 */
	public String editPro(){
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

}

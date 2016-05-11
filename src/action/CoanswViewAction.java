package action;

import java.util.List;
import java.util.Map;

import action.BaseAction;

public class CoanswViewAction extends BaseAction{
	
	String color[]=new String[]{"#51a1c4","#e60008","#fed88f","#546d5a","#f48b52","#676c7f","#907759","#403d50","#4d312b","#747474","#51a1c4","#e60008","#fed88f","#546d5a","#f48b52","#676c7f","#907759","#403d50","#4d312b","#747474"};
	
	public String execute(){
		
		//TODO 遠距???
		List<Map>labels=df.sqlGet("SELECT * FROM Question WHERE topic='1' ORDER BY sequence");
		
		
		List<Map>list=df.sqlGet("SELECT IFNULL(d.coansw,0)as score, d.techid, d.samples, d.effsamples, d.Oid, c.ClassName, cs.chi_name,(SELECT COUNT(*)FROM Seld WHERE Dtime_oid=d.Oid)as "
		+ "stu_select FROM Dtime d, Csno cs, Class c WHERE d.depart_class=c.ClassNo AND "
		+ "d.cscode=cs.cscode AND d.Sterm='"+getContext().getAttribute("school_term")+"' AND d.techid='"+getSession().getAttribute("userid")+"'");
		
		
		List<Map>ans;
		for(int i=0; i<list.size(); i++){			
			list.get(i).put("coansw", countAns(df.sqlGet("SELECT st.student_no, st.student_name, s.coansw FROM Seld s, stmd st WHERE "
					+ "s.coansw IS NOT NULL AND s.student_no=st.student_no AND s.Dtime_oid="+list.get(i).get("Oid")), labels.size()));
			list.get(i).put("color", color[i]);
		}
		
		request.setAttribute("labels", labels);
		request.setAttribute("coansw", list);
		
		//line chart
		List<Map>lineData=df.sqlGet("SELECT cs.chi_name, c.ClassName, "
				+ "IFNULL(ROUND( 50+ ((d.coansw/d.effsamples))*10 ,2),0)as score, IFNULL(ROUND(((d.coansw/d.effsamples))*20 ,2),0)as score1,"
				+ "d.effsamples, d.samples FROM Dtime d, Csno cs, Class c WHERE samples>0 AND d.Sterm='"+getContext().getAttribute("school_term")+
				"' AND d.cscode=cs.cscode AND d.depart_class=c.ClassNo AND d.techid='"+getSession().getAttribute("userid")+"'");
		for(int i=0; i<lineData.size(); i++){
			lineData.get(i).put("color", color[i]);
		}
		request.setAttribute("lineData", lineData);
		
		
		List<Map>pieData=df.sqlGet("SELECT effsamples, samples, (SELECT COUNT(*)FROM Seld WHERE Dtime_oid=d.Oid)as cnt "
		+ "FROM Dtime d WHERE d.Sterm='"+getContext().getAttribute("school_term")+"'AND d.techid='"+getSession().getAttribute("userid")+"'");
		int eff=0, sam=0, cnt=0;
		for(int i=0; i<pieData.size(); i++){
			eff+=Integer.parseInt(pieData.get(i).get("effsamples").toString());
			sam+=Integer.parseInt(pieData.get(i).get("samples").toString());
			cnt+=Integer.parseInt(pieData.get(i).get("cnt").toString());
		}
		
		//e=(eff/cnt)*100;
		//s=((sam-eff)/cnt)*100;
		//c=((cnt-sam)/cnt)*100;
		//System.out.println(e+s+c);
		request.setAttribute("eff", eff);
		request.setAttribute("sam", sam-eff);
		request.setAttribute("cnt",cnt-sam);
		
		
		//歷年
		/*List<Map>years=df.sqlGet("SELECT d.school_year FROM Savedtime d WHERE "
				+ "d.techid='"+getSession().getAttribute("userid")+"' GROUP BY d.school_year ORDER BY d.school_year DESC");
		
		List<Map>savdtime;
		for(int i=0; i<years.size(); i++){
			savdtime=df.sqlGet(
					"SELECT d.school_term, c.ClassName, cs.chi_name, d.samples, d.effsamples, d.avg, d.stu_select " +
					"FROM Savedtime d, Class c, Csno cs WHERE d.depart_class=c.ClassNo AND " +
					"d.cscode=cs.cscode AND d.techid='"+getSession().getAttribute("userid")+"'AND " +
					"d.school_year='"+years.get(i).get("school_year")+"' ORDER BY d.school_term");
			
			if(savdtime.size()>0){
				years.get(i).put("coansw", savdtime);
			}else{
				years.remove(i);
			}
			
			
			
		}
		request.setAttribute("years", years);*/
		
		return SUCCESS;
	}
	
	private String countAns(List<Map>ans, int q){		 
		StringBuilder tmp=new StringBuilder();		
		
		if(ans.size()<1){
			for(int i=0; i<q; i++){
				tmp.append("0,");
			}
			tmp.delete(tmp.length()-1, tmp.length());
			return tmp.toString();
		}
		
		
		int c;
		for(int i=0; i<ans.get(0).get("coansw").toString().length(); i++){			
			c=0;			
			for(int j=0; j<ans.size(); j++){				
				c+=Integer.parseInt(String.valueOf(ans.get(j).get("coansw").toString().charAt(i)));
			}	
			//System.out.println(ans.get(i));
			tmp.append((c/(float)ans.size())+",");
		}
		tmp.delete(tmp.length()-1, tmp.length());
		return tmp.toString();
	}

}

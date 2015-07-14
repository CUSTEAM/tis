package action.rollCall;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import action.BaseAction;

public class OneThirdViewViewAction extends BaseAction{
	
	public String cno, sno, dno, gno, zno;
	public int range;
	
	public String execute(){
		if(range==0)range=2;
		List<Map>cls=df.sqlGet("SELECT ClassNo FROM Class WHERE tutor='"+getSession().getAttribute("userid")+"'");		
		//List<Map>stds=new ArrayList();		
		List<Map>tmp;
		for(int i=0; i<cls.size(); i++){				
			filter(getStds(cls.get(i).get("ClassNo").toString()));				
		}
		
		return SUCCESS;
	}
	
	
	public String search(){
		
		request.setAttribute("myStds", filter(getStds(null)));
		
		return SUCCESS;
	}
	
	public String creatSearch(){
		
		return "creatSearch";
	}
	
	private List getStds(String ClassNo){
		
		StringBuilder sb=new StringBuilder("SELECT IFNULL((SELECT COUNT(*)FROM Dilg WHERE student_no=s.student_no AND "
		+ "Dtime_oid=s.Dtime_oid AND abs IN(SELECT id FROM Dilg_rules WHERE exam='1')),0)as cnt,(d.thour*6)as max,"
		+ "cs.chi_name, c.ClassName, s.student_no, st.student_name,d.thour FROM stmd st, Seld s, Dtime d, "
		+ "Csno cs, Class c WHERE d.Oid=s.Dtime_oid AND cs.cscode=d.cscode AND "
		+ "c.ClassNo=st.depart_class AND st.student_no=s.student_no AND ");
		
		if(ClassNo!=null){
			sb.append("st.depart_class='"+ClassNo+"' ORDER BY st.student_no");
		}else{
			sb.append("c.CampusNo LIKE'"+cno+"%' AND c.SchoolNo LIKE'"+sno+"%'AND c.DeptNo LIKE'"+dno+"%'AND c.Grade LIKE'"+gno+"%'AND c.SeqNo LIKE'"+zno+"%'ORDER BY st.student_no");
		}
		return df.sqlGet(sb.toString());
	}
	
	private List filter(List<Map>stds){
		
		List<Map>tmp=new ArrayList();			
		for(int i=0; i<stds.size(); i++){	
			//System.out.println(stds.get(i).get("max")+"-"+stds.get(i).get("cnt")+"="+(Integer.parseInt(stds.get(i).get("max").toString())-Integer.parseInt(stds.get(i).get("cnt").toString())));
			if((Integer.parseInt(stds.get(i).get("max").toString())-Integer.parseInt(stds.get(i).get("cnt").toString()))<range){
				tmp.add(stds.get(i));
			}
		}	
		
		return tmp;
	}

}

package action;

import java.util.List;
import java.util.Map;



public class CareForStudentsAction extends BaseAction{
	
	
	public String execute(){
		
		//導師班級
		request.setAttribute("tu", df.sqlGet("SELECT ClassNo,ClassName FROM Class WHERE tutor='"+getSession().getAttribute("userid")+"'"));
		//任課班級
		request.setAttribute("cs", df.sqlGet("SELECT c.ClassNo, c.ClassName, d.Oid, cs.chi_name FROM "
		+ "Dtime d, Class c, Csno cs WHERE d.depart_class=c.ClassNo AND d.cscode=cs.cscode AND "
		+ "d.Sterm='"+getContext().getAttribute("school_term")+"' AND d.techid='"+getSession().getAttribute("userid")+"'"));
	
		return SUCCESS;
	}

}

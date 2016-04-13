package action.imp;

import action.BaseAction;
import model.Message;

public class DilgImpDateManagerAction extends BaseAction{
	
	public String name;
	public String date;
	public String cls;
	public String Oid;
	public String impOid[];
	
	public String cno, sno, stno, cono, dno, gno, zno;
	
	public String execute(){
		request.setAttribute("alldate", df.sqlGet("SELECT d.*, e.cname FROM Dilg_imp_date d LEFT OUTER JOIN empl e ON d.empl_oid=e.Oid"));
		return SUCCESS;
	}
	
	public String create(){
		Message msg=new Message();
		if(name.trim().equals("")||date.trim().equals("")){
			
			msg.setError("請檢查欄位");
			this.savMessage(msg);
			return execute();
		}
		
		df.exSql("INSERT INTO Dilg_imp_date(name,date,empl_oid,cls)VALUES('"+name+"','"+date+"','"+df.sqlGetStr("SELECT Oid FROM empl WHERE idno='"+getSession().getAttribute("userid")+"'")+"','"+cls+"');");
		msg.setSuccess("集會已建立, 請於列表中點選此集會以設定點名範圍");
		this.savMessage(msg);
		return execute();
	}
	
	public String delete(){
		
		Message msg=new Message();
		df.exSql("DELETE FROM Dilg_imp_date WHERE Oid="+Oid);
		df.exSql("DELETE FROM Dilg_imp_class WHERE Dilg_imp_date_oid="+Oid);
		df.exSql("DELETE FROM Dilg_imp WHERE Dilg_imp_date_oid="+Oid);
		msg.setSuccess("集會已刪除, 包含相關設定與點名狀況");
		this.savMessage(msg);
		return execute();
	}
	
	public String edit(){
		
		request.setAttribute("Oid", Oid);
		request.setAttribute("cls", df.sqlGet("SELECT d.edit, d.Oid as impOid, e.cname, c.ClassNo, "
		+ "c.ClassName, (SELECT COUNT(*)FROM stmd WHERE depart_class=c.ClassNo)as cnt FROM "
		+ "Dilg_imp_class d, Class c LEFT OUTER JOIN empl e ON c.tutor=e.idno WHERE "
		+ "d.ClassNo=c.ClassNo AND d.Dilg_imp_date_oid="+Oid));
		
		return "edit";
	}
	
	public String addClass(){
		
		StringBuilder sql=new StringBuilder("INSERT INTO Dilg_imp_class(Dilg_imp_date_oid, ClassNo)SELECT '"+Oid+"',ClassNo FROM Class WHERE CampusNo='"+cno+"'");
		if(!stno.equals(""))sql.append("AND SchoolType='"+stno+"'");
		if(!sno.equals(""))sql.append("AND SchoolNo='"+sno+"'");
		if(!cono.equals(""))sql.append("AND InstNo='"+cono+"'");
		if(!dno.equals(""))sql.append("AND DeptNo='"+dno+"'");
		if(!gno.equals(""))sql.append("AND Grade='"+gno+"'");
		if(!zno.equals(""))sql.append("AND SeqNo='"+zno+"'");
		sql.append("AND Type='P'ON DUPLICATE KEY UPDATE Dilg_imp_date_oid='"+Oid+"';");
		df.exSql(sql.toString());
		
		
		
		return edit();
	}
	
	public String delClass(){
		
		for(int i=0; i<impOid.length; i++){
			
			df.exSql("DELETE FROM Dilg_imp_class WHERE Oid="+impOid[i]);
		}
		
		return edit();
	}

}

package action;

import model.Message;

public class ElearinigReserveAction extends BaseAction{
	
	public String Oid[];
	public String chi_name[];
	public String techid[];
	public String year[];
	public String term[];
	public String credit[];
	public String thour[];
	//public String checked[];
	//public String thour_real[];
	
	public String execute(){		
		request.setAttribute("cs", df.sqlGet("SELECT * FROM Elearning_reserve WHERE techid='"+getSession().getAttribute("userid")+"'"));
		return SUCCESS;
	}
	
	public String add(){
		Message msg=new Message();
		
		
		try{		
			df.exSql("INSERT INTO Elearning_reserve(chi_name,techid,school_year,school_term,credit,thour) VALUES('"+chi_name[0]+"','"+getSession().getAttribute("userid")+"','"+year[0]+"','"+term[0]+"',"+credit[0]+","+parse(thour[0])+");");
		}catch(Exception e){
			e.printStackTrace();
			msg.setError("儲存不成功，請檢查欄位");
			this.savMessage(msg);
		}
		this.savMessage(msg);
		return execute();
	}
	
	public String edit(){
		Message msg=new Message();
		for(int i=0; i<Oid.length; i++){
			if(!Oid[i].equals("")){
				try{
					df.exSql("UPDATE Elearning_reserve SET chi_name='"+chi_name[i]+"',school_year='"+year[i]+"',school_term='"+term[i]+"',credit="+credit[i]+",thour="+parse(thour[i])+" WHERE Oid="+Oid[i]);
				}catch(Exception e){					
					msg.setError("儲存不成功，請檢查欄位");
					this.savMessage(msg);
					return execute();
				}
			}
		}
		msg.setSuccess("儲存完成");
		this.savMessage(msg);
		return execute();
	}
	
	public String del(){
		Message msg=new Message();
		for(int i=0; i<Oid.length; i++){
			if(!Oid[i].equals("")){
				try{
					df.exSql("DELETE FROM Elearning_reserve WHERE Oid="+Oid[i]);
				}catch(Exception e){					
					msg.setError("刪除不成功，請檢查欄位");
					this.savMessage(msg);
					return execute();
				}
			}
		}
		msg.setError("刪除完成");
		this.savMessage(msg);
		return execute();
	}
	
	private int parse(String thour){
		
		int h;
		try{
			h=Integer.parseInt(thour.substring(0, 2).toString())*60;
			h+=Integer.parseInt(thour.substring(3, 5).toString());			
			return h;
		}catch(Exception e){
			return 0;
		}
	}

}

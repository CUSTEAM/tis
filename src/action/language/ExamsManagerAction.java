package action.language;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import model.Message;
import model.PubCalendar;
import action.BaseAction;
import action.language.exams.PrintStds;

public class ExamsManagerAction extends BaseAction{
	
	
	public String Oids[];
	public String Oid;	
	public String level;
	public String no;
	public String note;
	public String exam_begin;
	public String exam_end;
	public String grad1;
	public String grad2;
	public String grad3;
	public String grad4;
	public String sign_begin;
	public String sign_end;	
	public File upload;
	
	SimpleDateFormat sf=new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
	private List getExams(){
		
		return df.sqlGet("SELECT (SELECT COUNT(*)FROM LC_exam_regs ls, stmd s, Class c WHERE " +
		"ls.student_no=s.student_no AND c.ClassNo=s.depart_class AND c.Grade='1' AND ls.level=e.level AND ls.no=e.no)as cnt1," +
		"(SELECT COUNT(*)FROM LC_exam_regs ls, stmd s, Class c WHERE ls.student_no=s.student_no AND " +
		"c.ClassNo=s.depart_class AND c.Grade='2' AND ls.level=e.level AND ls.no=e.no)as cnt2,(SELECT COUNT(*)FROM " +
		"LC_exam_regs ls, stmd s, Class c WHERE ls.student_no=s.student_no AND c.ClassNo=s.depart_class AND c.Grade='3' " +
		"AND ls.level=e.level AND ls.no=e.no)as cnt3,(SELECT COUNT(*)FROM LC_exam_regs ls, stmd s, Class c WHERE " +
		"ls.student_no=s.student_no AND c.ClassNo=s.depart_class AND c.Grade='4' AND ls.level=e.level AND ls.no=e.no)as cnt4,e.* " +
		"FROM LC_exam e ORDER BY e.level, e.no");
	}
	
	public String execute(){		
		request.setAttribute("exames", getExams());		
		return SUCCESS;
	}
	
	/**
	 * 建立考試
	 * @return
	 * @throws ParseException 
	 */
	public String create() throws ParseException{
		Message msg=new Message();
		if(
			level.trim().equals("")||
			no.trim().equals("")||
			exam_begin.trim().equals("")||
			exam_end.trim().equals("")||
			grad1.trim().equals("")||
			grad2.trim().equals("")||
			grad3.trim().equals("")||
			grad4.trim().equals("")||
			sign_begin.trim().equals("")||
			sign_end.trim().equals("")){			
			msg.setError("資料不齊全，請完成所有欄位");
			savMessage(msg);
			return execute();
		}
		if((sf.parse(exam_begin).getTime()>=sf.parse(exam_end).getTime())||(sf.parse(sign_begin).getTime()>=sf.parse(sign_end).getTime())){
			msg.setError("時間矛盾");
			savMessage(msg);
			return execute();
		}
		
		try{
			df.exSql("INSERT INTO LC_exam(level,no,note,exam_begin,exam_end,grad1,grad2,grad3,grad4,sign_begin,sign_end)VALUES" +
					"('"+level+"','"+no+"','"+note+"','"+exam_begin+"','"+exam_end+"','"+grad1+"','"+grad2+"','"+grad3+"','"+grad4+
					"','"+sign_begin+"','"+sign_end+"');");
		}catch(Exception e){
			msg.setError("請檢查重複梯次、場次");
			savMessage(msg);
			return execute();
		}
		
		try{
			PubCalendar c=new PubCalendar();
			c.setAccount(getSession().getAttribute("userid").toString());		
			c.setBegin(sf.parse(exam_begin));
			c.setEnd(sf.parse(exam_end));
			c.setName("第 "+level+"梯次第 "+no+"場考試");
			c.setNote("");
			c.setMembers("");
			c.setSender(getSession().getAttribute("userid").toString());
			Date date=new Date();
			c.setNo(String.valueOf(date.getTime()));
			df.update(c);
			
			c=new PubCalendar();
			c.setAccount(getSession().getAttribute("userid").toString());		
			c.setBegin(sf.parse(sign_begin));
			c.setEnd(sf.parse(sign_end));
			c.setName("第 "+level+"梯次第 "+no+"場考試報名");
			c.setSender(getSession().getAttribute("userid").toString());
			c.setNote("");
			c.setMembers("");
			date=new Date();
			c.setNo(String.valueOf(date.getTime()));
			df.update(c);
		}catch(Exception e){
			
		}
		
		msg.setSuccess("建立完成");
		savMessage(msg);
		request.setAttribute("exames", getExams());
		return execute();
	}
	
	/**
	 * 刪除
	 * @return
	 */
	public String delete(){
		
		for(int i=0; i<Oids.length; i++){
			
			if(!Oids[i].equals("")){
				try{
					Map info=df.sqlGetMap("SELECT level, no FROM LC_exam WHERE Oid="+Oids[i]);
					df.exSql("DELETE FROM LC_exam WHERE Oid="+Oids[i]);
					df.exSql("DELETE FROM LC_exam_regs WHERE level='"+info.get("level")+"'AND no='"+info.get("no")+"'");
				}catch(Exception e){
					Message msg=new Message();
					msg.setError("沒有資料可供修改");
					savMessage(msg);
					return execute();
				}
				break;
			}
		}
		
		Message msg=new Message();
		msg.setSuccess("刪除完成");
		savMessage(msg);
		return execute();
	}
	
	/**
	 * 更新名單
	 * @return
	 * @throws IOException 
	 */
	public String updateStds(){			
		df.exSql("DELETE FROM LC_exam_stmds");
		try {
			saveTxtFile();
		} catch (Exception e) {
			Message msg=new Message();
			msg.setError("資料發生問題:"+e);
			this.savMessage(msg);
		}
		return execute();
	}
	
	/**
	 * 追加名單
	 * @return
	 */
	public String addStds(){
		try {
			saveTxtFile();
			Message msg=new Message();
			msg.setSuccess("學生資料已匯入");
			savMessage(msg);
		} catch (Exception e) {
			Message msg=new Message();
			msg.setError("資料發生問題:"+e);
			savMessage(msg);
		}
		return execute();
	}
	
	/**
	 * 儲存文字檔
	 * @throws IOException
	 */
	private void saveTxtFile() throws IOException{
		
		FileInputStream fis = new FileInputStream(upload);
		FileReader fr = new FileReader(fis.getFD());
		BufferedReader br = new BufferedReader(fr);
		String line = br.readLine(); //讀第一行
		df.exSql("INSERT INTO LC_exam_stmds (student_no) VALUES ('"+line+"')ON DUPLICATE KEY UPDATE student_no=VALUES(student_no);");
		StringBuffer sb = new StringBuffer();
		while ((line=br.readLine())!=null){
			df.exSql("INSERT INTO LC_exam_stmds (student_no) VALUES ('"+line+"')ON DUPLICATE KEY UPDATE student_no=VALUES(student_no);");
		}	
		fis.close();
		fr.close();
		br.close();
	}
	
	/**
	 * 選取修改
	 * @return
	 */
	public String edit(){
		Map<String,String>exam;
		for(int i=0; i<Oids.length; i++){
			if(!Oids[i].equals("")){
				exam=df.sqlGetMap("SELECT * FROM LC_exam WHERE Oid="+Oids[i]);
				if(exam!=null){
					request.setAttribute("exam", exam);
					return "edit";
				}
				
			}
		}
		Message msg=new Message();
		msg.setError("沒有資料可供修改");
		savMessage(msg);
		request.setAttribute("exames", getExams());
		return execute();
	}
	
	/**
	 * 儲存修改
	 * @return
	 */
	public String save(){
		Message msg=new Message();
		if(
			level.trim().equals("")||
			no.trim().equals("")||
			exam_begin.trim().equals("")||
			exam_end.trim().equals("")||
			grad1.trim().equals("")||
			grad2.trim().equals("")||
			grad3.trim().equals("")||
			grad4.trim().equals("")||
			sign_begin.trim().equals("")||
			sign_end.trim().equals("")){
			
			msg.setError("欄位不可空白");
			savMessage(msg);
			return SUCCESS;
		}
		
		df.exSql("UPDATE LC_exam SET "+
		"level='"+level+"', "+
		"no='"+no+"', "+
		"note='"+note+"', "+
		"exam_begin='"+exam_begin+"', "+
		"exam_end='"+exam_end+"', "+
		"exam_begin='"+exam_begin+"', "+
		"grad1='"+grad1+"', "+
		"grad2='"+grad2+"', "+
		"grad3='"+grad3+"', "+
		"grad4='"+grad4+"', "+
		"sign_begin='"+sign_begin+"', "+
		"sign_end='"+sign_end+"'WHERE Oid="+Oid);
		msg=new Message();
		msg.setSuccess("修改完成");
		savMessage(msg);
		request.setAttribute("exames", getExams());
		return this.SUCCESS;
	}
	
	public String printStd() throws IOException{
		
		PrintStds p=new PrintStds();
		p.print(response, df.sqlGet("SELECT s.student_no, st.student_name, c.ClassName, st.CellPhone,st.Email FROM LC_exam_stmds s, stmd st, Class c WHERE " +
		"s.student_no=st.student_no AND st.depart_class=c.ClassNo ORDER BY c.DeptNo, s.student_no"), "");
		return null;
	}
	
	public String printExam() throws IOException{		
		for(int i=0; i<Oids.length; i++){			
			if(!Oids[i].equals("")){
				Map info=df.sqlGetMap("SELECT level, no FROM LC_exam WHERE Oid="+Oids[i]);				
				PrintStds p=new PrintStds();				
				p.print(response, df.sqlGet("SELECT s.student_no, st.student_name, c.ClassName, st.CellPhone,st.Email FROM LC_exam_regs r, LC_exam_stmds s, stmd st, Class c WHERE " +
				"r.student_no=s.student_no AND r.level='"+info.get("level")+"' AND r.no='"+info.get("no")+"' AND s.student_no=st.student_no AND st.depart_class=c.ClassNo ORDER BY " +
						"c.DeptNo, s.student_no"), "第 "+info.get("level")+"梯次第  "+info.get("no")+"場");
				break;
			}
		}
		return null;		
	}
}

package action;

public class Logout extends BaseAction{
	
	public String execute() throws Exception {		
		getSession().invalidate();
		response.sendRedirect("/ssos/Logout");//轉送至eis
		return null;
	}
}

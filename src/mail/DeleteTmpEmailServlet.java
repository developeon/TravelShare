package mail;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tmp_user.Tmp_userDAO;

@WebServlet("/DeleteTmpEmailServlet")
public class DeleteTmpEmailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		String userEmail = null;
		if(request.getParameter("userEmail") != null){
			userEmail = request.getParameter("userEmail");
		}
		if(userEmail == null || userEmail.equals("")) {
			response.getWriter().write("-1");
			return;
		}
		
		
	int result= new Tmp_userDAO().delete(userEmail);
	response.getWriter().write(result + "");
	return;
		
	}
	

}

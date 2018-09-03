package mail;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tmp_user.Tmp_userDAO;
import user.UserDAO;
import util.SHA256;

@WebServlet("/TmpUserRegisterServlet")
public class TmpUserRegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		Tmp_userDAO tmp_userDAO = new Tmp_userDAO();
		
		String userEmail = null;
		if(request.getParameter("userEmail") != null){
			userEmail = request.getParameter("userEmail");
		}
		if(userEmail == null || userEmail.equals("")) {
			response.getWriter().write("-1");
			return;
		}
		
		if(tmp_userDAO.registerCheck(userEmail) != 1 || new UserDAO().registerEmailCheck(userEmail) != 1) {
			response.getWriter().write("0"); //TMP_USER나 USER에 이미 존재하면 에러
			return;
		}
		
		int result = tmp_userDAO.join(userEmail, SHA256.getSHA256(userEmail));
		if(result == 1) {
			response.getWriter().write("1");
			return;
		}else {
			response.getWriter().write("-1");
			return;
		}
		
	}

}

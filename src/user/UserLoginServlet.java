package user;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UserLoginServlet")
public class UserLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		String userID = request.getParameter("userID");
		String userPassword = request.getParameter("userPassword");
		
		if(userID == null || userID.equals("") || userPassword == null || userPassword.equals("")) {
			request.getSession().setAttribute("messageType", "오류 메세지");
			request.getSession().setAttribute("messageContent", "모든 내용을 입력하세요.");
			response.sendRedirect("login.jsp");
			return;
		}
		
		if(userID.equals("mirim") && userPassword.equals("mirim")) {
			request.getSession().setAttribute("messageType", "성공 메세지");
			request.getSession().setAttribute("messageContent", "로그인에 성공했습니다.");
			request.getSession().setAttribute("userID", userID);
			response.sendRedirect("admin.jsp");
			return;
		}
		
		int result = new UserDAO().login(userID, userPassword);

		if(result == 0){
			request.getSession().setAttribute("messageType", "오류 메세지");
			request.getSession().setAttribute("messageContent", "아이디 또는 비밀번호를 다시 확인하세요.");
			response.sendRedirect("login.jsp");
			return;
		}
		else if(result == 1) {
			request.getSession().setAttribute("messageType", "성공 메세지");
			request.getSession().setAttribute("messageContent", "로그인에 성공했습니다.");
			request.getSession().setAttribute("userID", userID);
			response.sendRedirect("index.jsp");
			return;
		}
	
		else{
			request.getSession().setAttribute("messageType", "오류 메세지");
			request.getSession().setAttribute("messageContent", "데이터베이스 오류입니다.");
			response.sendRedirect("login.jsp");
			return;
		}
		
	}

}

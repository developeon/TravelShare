package user;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UserRegisterServlet")
public class UserRegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		String userID = request.getParameter("userID").trim();
		String userNickname = request.getParameter("userNickname").trim();
		String userEmail = request.getParameter("userEmail").trim();
		String userPassword1 = request.getParameter("userPassword1").trim();
		String userPassword2 = request.getParameter("userPassword2").trim();
		
		
		if(userID == null || userID.equals("") || userNickname == null || userNickname.equals("") || userEmail == null || userEmail.equals("") ||
				userPassword1 == null || userPassword1.equals("") || userPassword2 == null || userPassword2.equals("")) {
			request.getSession().setAttribute("messageType", "오류 메세지");
			request.getSession().setAttribute("messageContent", "모든 내용을 입력하세요.");
			response.sendRedirect("join.jsp");
			return;
		}
		
		if(!userPassword1.equals(userPassword2)) {
			request.getSession().setAttribute("messageType", "오류 메세지");
			request.getSession().setAttribute("messageContent", "비밀번호가 서로 일치하지 않습니다.");
			response.sendRedirect("join.jsp");
			return;
		}
		int result = new UserDAO().register(userID, userPassword1, userEmail, userNickname, "", "본인에 대해 알려주세요");
		if(result==1) {
			request.getSession().setAttribute("messageType", "성공 메세지");
			request.getSession().setAttribute("messageContent", "회원가입에 성공했습니다.");
			response.sendRedirect("login.jsp");
			return;
		}
		else {
			request.getSession().setAttribute("messageType", "오류 메세지");
			request.getSession().setAttribute("messageContent", "데이터베이스 오류가 발생했습니다.");
			response.sendRedirect("join.jsp");
			return;
		}
	}

}

package likes;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/LikesWriteServlet")
public class LikesWriteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		
		String bno = request.getParameter("bno");
		String userID = request.getParameter("userID");
		
		if(bno == null || bno.equals("") || userID == null || userID.equals("")) {
			request.getSession().setAttribute("messageType", "오류 메세지");
			request.getSession().setAttribute("messageContent", "접근할 수 없습니다.");
			response.sendRedirect("index.jsp");
			return;
		}
		
		LikesDAO likesDAO = new LikesDAO();
		int result = likesDAO.getState(userID, Integer.parseInt(bno));
		if(result == 1) {
			likesDAO.delete(Integer.parseInt(bno), userID);
			return;
		} else if(result == 0){
			likesDAO.insert(Integer.parseInt(bno), userID);
			return;
		} else {
			request.getSession().setAttribute("messageType", "오류 메세지");
			request.getSession().setAttribute("messageContent", "데이터 베이스 오류입니다.");
			response.sendRedirect("index.jsp");
			return;
		}
	}
}

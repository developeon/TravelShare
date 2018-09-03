package comment;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/CommentWriteServlet")
public class CommentWriteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		String writerID = request.getParameter("writerID");
		String comment = request.getParameter("comment");
		String bno = request.getParameter("bno");
		
		if(writerID == null || writerID.equals("") || comment == null || comment.equals("") ||
				bno == null || bno.equals("")) {
			request.getSession().setAttribute("messageType", "오류 메세지");
			request.getSession().setAttribute("messageContent", "접근할 수 없습니다.");
			response.sendRedirect("index.jsp");
			return;
		}
		HttpSession session = request.getSession();
		if(!writerID.equals((String)session.getAttribute("userID"))) {
			request.getSession().setAttribute("messageType", "오류 메세지");
			request.getSession().setAttribute("messageContent", "접근할 수 없습니다.");
			response.sendRedirect("index.jsp");
			return;
		}
		
		int result = new CommentDAO().insertComment(writerID, comment, Integer.parseInt(bno));
		if(result == -1) {
			response.getWriter().write("fail");
			return;
		} else {
			response.getWriter().write("success");
			return;
		}
	}

}

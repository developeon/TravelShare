package board;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import comment.CommentDAO;
import likes.LikesDAO;
import report.ReportDAO;

@WebServlet("/BoardDeleteServlet")
public class BoardDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		
		String bno = request.getParameter("bno");
		if(bno == null || bno.equals("")) {
			request.getSession().setAttribute("messageType", "오류 메세지");
			request.getSession().setAttribute("messageContent", "접근할 수 없습니다.");
			response.sendRedirect("index.jsp");
			return;
		}
		
		int result = new BoardDAO().delete(Integer.parseInt(bno));
		LikesDAO likesDAO = new LikesDAO();
		CommentDAO commentDAO = new CommentDAO();
		commentDAO.deleteAll(Integer.parseInt(bno));
		likesDAO.deleteAll(Integer.parseInt(bno));
		if(result == -1) {
			response.getWriter().write("fail");
			return;
		} else {
			new LikesDAO().deleteAll(Integer.parseInt(bno));
			new CommentDAO().deleteAll(Integer.parseInt(bno));
			response.getWriter().write("success");
			return;
		}
		
	}
}

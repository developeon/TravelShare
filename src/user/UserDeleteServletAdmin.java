package user;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.BoardDAO;
import comment.CommentDAO;
import likes.LikesDAO;
import report.ReportDAO;

@WebServlet("/UserDeleteServletAdmin")
public class UserDeleteServletAdmin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		
		String userID = request.getParameter("userID");
		if(userID == null || userID.equals("")) {
			response.sendRedirect("admin_user.jsp");
			return;
		}
		
		int result = new UserDAO().delete(userID);
		BoardDAO boardDAO = new BoardDAO();
		LikesDAO likesDAO = new LikesDAO();
		CommentDAO commentDAO = new CommentDAO();
		ArrayList<Integer> bnoList = boardDAO.getBnoList(userID);
		if(bnoList.size()>0) {
			for(int i=0; i<bnoList.size(); i++) {
				likesDAO.deleteAll(bnoList.get(i));
				commentDAO.deleteAll(bnoList.get(i));
			}
		}
		boardDAO.delete(userID);
		commentDAO.delete(userID);
		likesDAO.delete(userID);
		new ReportDAO().delete(userID); //유저가 신고한 글 다 삭제
		
		if(result == 1) {
			response.getWriter().write("success");
		} else {
			response.getWriter().write("fail");
			return;
		}
	}
}

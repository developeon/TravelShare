package admin;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.BoardDAO;
import comment.CommentDAO;
import likes.LikesDAO;
import user.UserDAO;

@WebServlet("/ShowInfoServlet")
public class ShowInfoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		
		int userCnt = new UserDAO().getUserCnt("");
		int boardCnt = new BoardDAO().getBoardCnt("", "admin");
		int likesCnt = new LikesDAO().getLikeCnt();
		int commentCnt = new CommentDAO().getCommentCnt();
		
		response.getWriter().write(userCnt + "|" + boardCnt + "|" + likesCnt + "|" + commentCnt);
	}
}

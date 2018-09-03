package user;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.BoardDAO;
import comment.CommentDAO;
import likes.LikesDAO;
import reason.ReasonDAO;
import report.ReportDAO;

@WebServlet("/UserDeleteServlet")
public class UserDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		String userID = request.getParameter("userID");
		HttpSession session = request.getSession();
		if(!userID.equals((String)session.getAttribute("userID"))) {
			request.getSession().setAttribute("messageType", "오류 메세지");
			request.getSession().setAttribute("messageContent", "접근할 수 없습니다.");
			response.sendRedirect("index.jsp");
			return;
		}
		
		String reason = request.getParameter("reason");
		if(reason != null && !reason.equals("")) {
			new ReasonDAO().insertReason(userID, reason);
		}
		
		String savePath = request.getSession().getServletContext().getRealPath("/upload").replaceAll("\\\\", "/");
		String prev = new UserDAO().getUser(userID).getUserProfile();
		
		int result = new UserDAO().delete(userID);
		
		if(result==1) {
			if(prev != null && !prev.equals("")) {
				File prevFile = new File(savePath + "/" + prev);
				if(prevFile.exists()) {
					prevFile.delete();
				}
			}
			
			/*TODO : user가 쓴 댓글, 게시글 지우고 user가 누른 좋아요 지우고 user글에 누른 좋아요 지우고 user글에 달린 댓글,좋아요 지워야함*/
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
			
			request.getSession().invalidate();
			request.getSession().setAttribute("messageType", "성공 메세지");
			request.getSession().setAttribute("messageContent", "탈퇴되었습니다.");
			response.sendRedirect("index.jsp");
			return;
		}
		else {
			request.getSession().setAttribute("messageType", "오류 메세지");
			request.getSession().setAttribute("messageContent", "데이터베이스 오류가 발생했습니다.");
			response.sendRedirect("update.jsp");
			return;
		}
	}
}
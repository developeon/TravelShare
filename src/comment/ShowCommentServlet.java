package comment;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import user.UserDAO;

@WebServlet("/ShowCommentServlet")
public class ShowCommentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		String bno = request.getParameter("bno");
		if(bno == null || bno.equals("")) {
			response.getWriter().write("");
			return;
		}
		
		try {
			response.getWriter().write(getComment(Integer.parseInt(bno)));
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	public String getComment(int bno) {
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\" : [");
		CommentDAO commentDAO = new CommentDAO();
		ArrayList<CommentDTO> commentList = commentDAO.getList(bno);
		if(commentList.size() == 0) return "";
		UserDAO userDAO = new UserDAO();
		for(int i = 0; i < commentList.size(); i++) {
			String writerProfileImage = userDAO.getProfile(commentList.get(i).getWriterID());
			String writerNickname = userDAO.getUserNickName(commentList.get(i).getWriterID());
			result.append("[{\"value\" : \"" + commentList.get(i).getCno() + "\"},");
			result.append("{\"value\" : \"" + commentList.get(i).getWriterID() + "\"},");
			result.append("{\"value\" : \"" + writerProfileImage + "\"},");
			result.append("{\"value\" : \"" + writerNickname + "\"},");
			result.append("{\"value\" : \"" + commentList.get(i).getComment() + "\"},");
			result.append("{\"value\" : \"" + commentList.get(i).getRegDate() + "\"},");
			result.append("{\"value\" : \"" + commentList.get(i).getBno() + "\"},");
			result.append("{\"value\" : \"" + commentDAO.getCommentCnt(commentList.get(i).getBno()) + "\"}]");
			if(i != commentList.size() - 1) result.append(",");
		}
		result.append("]}");
		return result.toString();
	}
}

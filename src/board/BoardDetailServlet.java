package board;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import user.UserDAO;
import user.UserDTO;

@WebServlet("/BoardDetailServlet")
public class BoardDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		String bno = request.getParameter("bno");
		if(bno == null || bno.equals("")) {
			response.getWriter().write("");
			return;
		}
		
		try {
			response.getWriter().write(getBoard(Integer.parseInt(bno)));
		}catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	public String getBoard(int bno) {
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\" : [");
		BoardDAO boardDAO = new BoardDAO();
		BoardDTO boardDTO = boardDAO.getBoard(bno);
		if(boardDTO == null) return "";
		String fileNames = boardDTO.getFileName1()+ "|" +boardDTO.getFileName2() + "|" + boardDTO.getFileName3() +
				"|" + boardDTO.getFileName4() + "|" + boardDTO.getFileName5();
		UserDAO userDAO = new UserDAO();
		UserDTO userDTO = userDAO.getUser(boardDTO.getWriterID());
		String writerProfileImage = userDAO.getProfile(userDTO.getUserID());
		String writerNickname = userDTO.getUserNickname();
		String writerIntro = userDTO.getUserIntro();
			result.append("[{\"value\" : \"" + boardDTO.getBno() + "\"},");
			result.append("{\"value\" : \"" + boardDTO.getWriterID() + "\"},");
			result.append("{\"value\" : \"" + boardDTO.getRegDate() + "\"},");
			result.append("{\"value\" : \"" + boardDTO.getContent().trim() + "\"},");
			result.append("{\"value\" : \"" + fileNames + "\"},");
			result.append("{\"value\" : \"" + writerProfileImage + "\"},");
			result.append("{\"value\" : \"" + writerNickname + "\"},");
			result.append("{\"value\" : \"" + writerIntro + "\"}]");
		result.append("]}");
		return result.toString();
	}
	
}
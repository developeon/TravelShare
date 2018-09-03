package board;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/BoardSearchServlet")
public class BoardSearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		String search = request.getParameter("search");
		response.getWriter().write(getJSON(search));
	}
	
	public String getJSON(String search) {
		if(search==null) search = "";
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\" : [");
		BoardDAO boardDAO = new BoardDAO();
		ArrayList<BoardDTO> boardList = boardDAO.getListAdmin(search);
		if(boardList != null) {
		for(int i =0; i<boardList.size(); i++) {
			result.append("[{\"value\" : \"" + boardList.get(i).getBno() + "\"},");
			result.append("{\"value\" : \"" + boardList.get(i).getWriterID() + "\"},");
			result.append("{\"value\" : \"" + boardList.get(i).getRegDate() + "\"},");
			result.append("{\"value\" : \"" + boardList.get(i).getContent() + "\"},");
			result.append("{\"value\" : \"" + boardList.get(i).getDel_chk() + "\"}]");
			if(i != boardList.size()-1) result.append(",");
		}}
		result.append("]}");
		return result.toString();
	}

}

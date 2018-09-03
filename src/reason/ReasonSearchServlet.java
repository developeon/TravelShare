package reason;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ReasonSearchServlet")
public class ReasonSearchServlet extends HttpServlet {
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
		ReasonDAO ReasonDAO = new ReasonDAO();
		ArrayList<ReasonDTO> reasonList = ReasonDAO.getList(search);
		if(reasonList != null) {
		for(int i =0; i<reasonList.size(); i++) {
			result.append("[{\"value\" : \"" + reasonList.get(i).getUserID() + "\"},");
			result.append("{\"value\" : \"" + reasonList.get(i).getDeleteDate() + "\"},");
			result.append("{\"value\" : \"" + reasonList.get(i).getReason() + "\"}]");
			if(i != reasonList.size()-1) result.append(",");
		}}
		result.append("]}");
		return result.toString();
	}
}

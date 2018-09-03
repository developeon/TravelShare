package likes;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import user.UserDAO;
import user.UserDTO;

@WebServlet("/ShowLikesServlet")
public class ShowLikesServlet extends HttpServlet {
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
		//userDAO.getList(bno);
		LikesDAO likesDAO = new LikesDAO();
		int state = likesDAO.getState(userID, Integer.parseInt(bno));
		int cnt = likesDAO.getLikeCnt(Integer.parseInt(bno));
		response.getWriter().write(getJSON(Integer.parseInt(bno),state,cnt));
	}
	
	public String getJSON(int bno, int state, int cnt) {
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\" : [");
		UserDAO userDAO = new UserDAO();
		ArrayList<UserDTO> userList = userDAO.getList(bno);
		String userProfile = ""; 
		if(userList != null) {
		for(int i =0; i<userList.size(); i++) {
			userProfile = userDAO.getProfile(userList.get(i).getUserID());
			result.append("[{\"value\" : \"" + userList.get(i).getUserID() + "\"},");
			result.append("{\"value\" : \"" + userList.get(i).getUserNickname() + "\"},");
			result.append("{\"value\" : \"" + userProfile + "\"}]");
			if(i != userList.size() - 1) result.append(",");
		}
		result.append("], \"state\" : \"" + state + "\", \"cnt\" : \"" + cnt + "\"}");
		}
		return result.toString();
	}
}

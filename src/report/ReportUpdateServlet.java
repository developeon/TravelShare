package report;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ReportUpdateServlet")
public class ReportUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		
		String rno = request.getParameter("rno");
		String state = request.getParameter("state");
		if(rno == null || rno.equals("") || state == null || state.equals("")) {
			request.getSession().setAttribute("messageType", "오류 메세지");
			request.getSession().setAttribute("messageContent", "접근할 수 없습니다.");
			response.sendRedirect("index.jsp");
			return;
		}
		
		int result = new ReportDAO().update(rno, state);
		if(result == 1){
			response.getWriter().write("success");
			return;
		}
		else{
			response.getWriter().write("fail");
			return;
		}
	}

}

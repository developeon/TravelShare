package report;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ReportWriteServlet")
public class ReportWriteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		
		String bno = request.getParameter("bno");
		String reporter = request.getParameter("reporter");
		String reportNumber = request.getParameter("reportNumber");
		
		if(bno == null || bno.equals("") || reporter == null || reporter.equals("") || reportNumber == null || reportNumber.equals("")){
			request.getSession().setAttribute("messageType", "오류 메세지");
			request.getSession().setAttribute("messageContent", "접근할 수 없습니다.");
			response.sendRedirect("index.jsp");
			return;
		}
		
		int result = new ReportDAO().insert(reporter, Integer.parseInt(bno), Integer.parseInt(reportNumber));
		if(result == -1) {
			response.getWriter().write("fail");
			return;
		} else {
			response.getWriter().write("success");
			return;
		}
		
	}
}

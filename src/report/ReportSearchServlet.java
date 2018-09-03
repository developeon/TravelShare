package report;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ReportSearchServlet")
public class ReportSearchServlet extends HttpServlet {
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
		ReportDAO ReportDAO = new ReportDAO();
		ArrayList<ReportDTO> reportList = ReportDAO.getList(search);
		if(reportList != null) {
		for(int i =0; i<reportList.size(); i++) {
			result.append("[{\"value\" : \"" + reportList.get(i).getRno() + "\"},");
			result.append("{\"value\" : \"" + reportList.get(i).getReporter() + "\"},");
			result.append("{\"value\" : \"" + reportList.get(i).getTargetBno() + "\"},");
			result.append("{\"value\" : \"" + reportList.get(i).getReportType() + "\"},");
			result.append("{\"value\" : \"" + reportList.get(i).getIsCheck() + "\"}]");
			if(i != reportList.size()-1) result.append(",");
		}}
		result.append("]}");
		return result.toString();
	}

}

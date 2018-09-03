package board;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@WebServlet("/BoardWriteServlet")
public class BoardWriteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		MultipartRequest multi = null;
		int maxSize = 1024 * 1024 * 100; //100MB
		String savePath = request.getSession().getServletContext().getRealPath("/upload/board").replaceAll("\\\\", "/");
		try {
			multi = new MultipartRequest(request, savePath, maxSize, "UTF-8", new DefaultFileRenamePolicy());
		}catch (Exception e) {
			e.printStackTrace();
			request.getSession().setAttribute("messageType", "오류 메세지");
			request.getSession().setAttribute("messageContent", "오류가 발생했습니다.");
			response.sendRedirect("index.jsp");
			return;
		}
		
		String userID = multi.getParameter("userID");
		String content =  multi.getParameter("content");
		if(userID == null || userID.equals("")) {
			request.getSession().setAttribute("messageType", "오류 메세지");
			request.getSession().setAttribute("messageContent", "접근할 수 없습니다.");
			response.sendRedirect("index.jsp");
			return;
		}
		HttpSession session = request.getSession();
		if(!userID.equals((String)session.getAttribute("userID"))) {
			request.getSession().setAttribute("messageType", "오류 메세지");
			request.getSession().setAttribute("messageContent", "접근할 수 없습니다.");
			response.sendRedirect("index.jsp");
			return;
		}
		
		Enumeration fileNames = multi.getFileNames();
		String fileName1 = "";
		String fileName2 = "";
		String fileName3 = "";
		String fileName4 = "";
		String fileName5 = "";
		
		int i = 0;
		while (fileNames.hasMoreElements()) {
			i++;
			String parameter = (String) fileNames.nextElement();
			String fileRealName = multi.getFilesystemName(parameter);
			switch (i) {
			case 1:
				fileName5 = fileRealName;
				break;
			case 2:
				fileName4 = fileRealName;
				break;
			case 3:
				fileName3 = fileRealName;
				break;
			case 4:
				fileName2 = fileRealName;
				break;
			case 5:
				fileName1 = fileRealName;
				break;
			}
			if (fileRealName == null)
				continue;
		}
		
		int result = new BoardDAO().write(userID, content, fileName1, fileName2, fileName3, fileName4, fileName5);
		if(result == 1){
			request.getSession().setAttribute("messageType", "성공 메세지");
			request.getSession().setAttribute("messageContent", "등록되었습니다.");
			response.sendRedirect("index.jsp");
		}
		else{
			request.getSession().setAttribute("messageType", "오류 메세지");
			request.getSession().setAttribute("messageContent", "오류가 발생하였습니다.");
			response.sendRedirect("index.jsp");
		}
	}

}

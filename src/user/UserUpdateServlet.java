package user;

import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@WebServlet("/UserUpdateServlet")
public class UserUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		MultipartRequest multi = null;
		int fileMaxSize = 10 * 1024 * 1024;
		String savePath = request.getSession().getServletContext().getRealPath("/upload/profile").replaceAll("\\\\", "/");
		try {
			multi = new MultipartRequest(request, savePath, fileMaxSize, "UTF-8", new DefaultFileRenamePolicy());
		} catch (Exception e) {
			e.printStackTrace();
			request.getSession().setAttribute("messageType", "오류 메세지");
			request.getSession().setAttribute("messageContent", "파일크기는 10MB를 넘을 수 없습니다.");
			response.sendRedirect("update.jsp");
			return;
		}
		
		String userID = multi.getParameter("userID");
		HttpSession session = request.getSession();
		if(!userID.equals((String)session.getAttribute("userID"))) {
			request.getSession().setAttribute("messageType", "오류 메세지");
			request.getSession().setAttribute("messageContent", "접근할 수 없습니다.");
			response.sendRedirect("index.jsp");
			return;
		}
		
		String userNickname = multi.getParameter("userNickname");
		String userPassword1 = multi.getParameter("userPassword1");
		String userPassword2 = multi.getParameter("userPassword2");
		String userIntro = multi.getParameter("userIntro");
		if(userIntro == null || userIntro.equals("")) {
			userIntro = "본인에 대해 알려주세요";
		}
		
		
		if(userID == null || userID.equals("") || userNickname == null || userNickname.equals("") ||
				userPassword1 == null || userPassword1.equals("") || userPassword2 == null || userPassword2.equals("")) {
			request.getSession().setAttribute("messageType", "오류 메세지");
			request.getSession().setAttribute("messageContent", "모든 내용을 입력하세요.");
			response.sendRedirect("update.jsp");
			return;
		}
		if(!userPassword1.equals(userPassword2)) {
			request.getSession().setAttribute("messageType", "오류 메세지");
			request.getSession().setAttribute("messageContent", "비밀번호가 서로 일치하지 않습니다.");
			response.sendRedirect("update.jsp");
			return;
		}
		
		String fileName = "";
		File file = multi.getFile("file");
		if(file != null) {
			String ext = file.getName().substring(file.getName().lastIndexOf(".") + 1);
			if(ext.equals("jpg") || ext.equals("png") || ext.equals("gif")) {
				String prev = new UserDAO().getUser(userID).getUserProfile();
				File prevFile = new File(savePath + "/" + prev);
				if(prevFile.exists()) {
					prevFile.delete();
				}
				fileName = file.getName();
			} else {
				request.getSession().setAttribute("messageType", "오류 메세지");
				request.getSession().setAttribute("messageContent", "이미지 파일만 업로드 가능합니다.");
				response.sendRedirect("update.jsp");
				return;
			}
		}
		
		int result = new UserDAO().update(userID, userPassword1, userNickname, fileName, userIntro);
		if(result==1) {
			request.getSession().setAttribute("messageType", "성공 메세지");
			request.getSession().setAttribute("messageContent", "회원정보 수정에 성공했습니다.");
			response.sendRedirect("update.jsp");
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

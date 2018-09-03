package mail;

import java.io.IOException;
import java.util.Properties;

import javax.mail.Address;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import util.Gmail;
import util.SHA256;

@WebServlet("/EmailSendServlet")
public class EmailSendServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		String userEmail = null;
		if(request.getParameter("userEmail") != null){
			userEmail = request.getParameter("userEmail");
		}
		if(userEmail == null || userEmail.equals("")) {
			response.getWriter().write("-1");
		}
		
		String host = "http://10.96.123.3:8080/TravelShare/";
		String from = "developeon80@gmail.com";
		String to = userEmail;
		String subject = "Travelshare 이메일 인증 메일입니다.";
		String content = "다음 링크에 접속하여 이메일 인증을 진행하세요. " +
			"<a href='"+ host +"emailCheckActionTest.jsp?userEmail=" + userEmail +"&code="+ new SHA256().getSHA256(to) +"'>이메일 인증하기</a>";
			
		Properties p = new Properties();
		p.put("mail.smtp.user", from);
		p.put("mail.smtp.host", "smtp.googlemail.com");
		p.put("mail.smtp.port", 465);
		p.put("mail.smtp.starttls.enable", "true");
		p.put("mail.smtp.auth", "true");
		p.put("mail.smtp.debug", "true");
		p.put("mail.smtp.socketFactory.port", "465");
		p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		p.put("mail.smtp.socketFactory.fallback", "false");
		
		try{
			Authenticator auth = new Gmail();
			Session ses = Session.getInstance(p,auth);
			ses.setDebug(true);
			MimeMessage msg = new MimeMessage(ses);
			msg.setSubject(subject);
			Address fromAddr = new InternetAddress(from);
			msg.setFrom(fromAddr);
			Address toAddr = new InternetAddress(to);
			msg.addRecipient(Message.RecipientType.TO, toAddr);
			msg.setContent(content, "text/html;charset=UTF-8");
			Transport.send(msg);
			
		}catch(Exception e){
			response.getWriter().write("-1");
		}
		response.getWriter().write("1");
	}

}

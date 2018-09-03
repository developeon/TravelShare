<%@page import="tmp_user.Tmp_userDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "user.UserDAO" %>
<%@ page import = "util.SHA256" %>
<%@ page import = "java.io.PrintWriter" %>
<%
	request.setCharacterEncoding("UTF-8");

	String code = null;
	if(request.getParameter("code") != null){
		code = request.getParameter("code");
	}
	if(code == null || code.equals("")){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('잘못된 접근입니다1.');");
		script.println("location.href='index.jsp';");
		script.println("</script>");
		return;
	}
	
	String userEmail = null;
	if(request.getParameter("userEmail") != null){
		userEmail = request.getParameter("userEmail");
	}
	if(userEmail == null || userEmail.equals("")){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('잘못된 접근입니다.2');");
		script.println("location.href='index.jsp';");
		script.println("</script>");
		return;
	}
	
	boolean isRight = (new SHA256().getSHA256(userEmail).equals(code)) ? true :false;
	
	if(isRight ==true){
		new Tmp_userDAO().setUserEmailChecked(userEmail);
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('인증성공. 창을 닫고 회원가입을 진행하세요');");
		script.println("</script>");
		return;
	} else{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 코드입니다.');");
		script.println("location.href='index.jsp';");
		script.println("</script>");
		return;
	}
%>
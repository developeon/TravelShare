<%@ page language="java" contentType="text/html; charset=UTF-8" 
pageEncoding="UTF-8"%>
<% 	
	session.invalidate();
	request.getSession().setAttribute("messageType", "성공 메세지");
	request.getSession().setAttribute("messageContent", "로그아웃되었습니다.");
	response.sendRedirect("index.jsp");
%>
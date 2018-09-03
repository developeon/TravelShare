<%@page import="likes.LikesDAO"%>
<%@page import="board.BoardDAO"%>
<%@page import="board.BoardDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="user.UserDTO"%>
<%@page import="user.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%
		String bno = null;
		if (request.getParameter("bno") != null) {
			bno = request.getParameter("bno");
		}
		if (bno == null) {
			request.getSession().setAttribute("messageType", "오류 메세지");
			request.getSession().setAttribute("messageContent", "대상이 없습니다.");
			response.sendRedirect("index.jsp");
			return;
		}
		
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String)session.getAttribute("userID");
		}
		if (userID == null) {
			request.getSession().setAttribute("messageType", "오류 메세지");
			request.getSession().setAttribute("messageContent", "권한이 없습니다.");
			response.sendRedirect("index.jsp");
			return;
		}
		
		UserDAO userDAO = new UserDAO();
		UserDTO userDTO = userDAO.getUser(userID);
		
		BoardDAO boardDAO = new BoardDAO();
		BoardDTO boardDTO = boardDAO.getBoard(Integer.parseInt(bno));
	%>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="shortcut icon" href="images/favicon.ico" type="image/x-icon" />
	<link rel="stylesheet" href="css/bootstrap.min.css">
	<link rel="stylesheet" href="css/sticky-footer-navbar.css">
	<link rel="stylesheet" href="css/common.css">
	<link rel="stylesheet" href="css/pinterest.css">
	<link rel="stylesheet"
		href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<title></title>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<!-- navbar -->
	<style>
		body, html {
			margin: 0;
			padding: 0;
			background-color: #f7f8f9;
		}
		
		nav {
			box-shadow: 2px 2px 3px #dddddd;
			z-index: 1;
			background-color: #ffffff;
		}
	</style>
	<style>
		textarea{
		    resize: none;
		    border-radius: 30px;
		    width:80%;
	}
	</style>
</head>
<body>
	<!-- Fixed navbar -->
	<nav class="navbar navbar-expand-md fixed-top">
		<div class="container">
			<a class="navbar-brand" href="index.jsp"> <img
				src="images/logo.png" width="35" height="35"
				class="d-inline-block align-top" alt="">
			</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarCollapse" aria-controls="navbarCollapse"
				aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarCollapse">
				<ul class="navbar-nav mr-auto">
					<li class="nav-item active"><a class="nav-link" href="index.jsp" style="color:black;font-weight:bold;">여행
							피드</a></li>
				</ul>
				<div class="col-sm-6 col-md-6">
					<form class="navbar-form" role="search">
						<div class="input-group">
							<input type="text" class="form-control" placeholder="Search"
								name="q">
							<div class="input-group-btn">
								<button class="btn btn-default" type="submit"
									style="border-bottom-left-radius: 0px; border-top-left-radius: 0px;">
									<i class="fa fa-search"></i>
								</button>
							</div>
						</div>
					</form>
				</div>
				<div>
					<div class="dropdown">
					 	<img class ="rounded-circle dropdown-toggle" data-toggle="dropdown"
					 		style="width:40px;height:40px;" src="<%=userDAO.getProfile(userID)%>">
					    <div class="dropdown-menu dropdown-menu-right">
					    	<a class="dropdown-item" href="mypage.jsp?showUserID=<%=userID%>&search=활동">
					  			<img class ="rounded-circle" style="width:24px;height:24px;margin-right:8px;" 
					  				src="<%=userDAO.getProfile(userID)%>"><strong><%=userDTO.getUserNickname()%></strong></a>
					  		<a class="dropdown-item" href="update.jsp">
					    		<img class ="rounded-circle" style="width:24px;height:24px;margin-right:8px;" 
					  				src="images/set.png">설정</a>
					   	    <a class="dropdown-item" href="logout.jsp">
					    		<img class ="rounded-circle" style="width:24px;height:24px;margin-right:8px;" 
					  				src="images/logout.png">로그아웃</a>
					    </div>
					 </div>
				</div>
			</div>
		</div>
	</nav>
	
	<div class="container" style="margin-top:62px;padding-bottom: 62px;margin-bottom: 62px;">
		<div class="row">
    		<div class="col-7">
    			<!-- slider START -->
    			<div id="demo" class="carousel slide" data-ride="carousel" data-interval="false">
			    	<!-- The slideshow -->
					<div class="carousel-inner" id="carousel-inner">
					<%
						ArrayList<String> imageList = new ArrayList<String>();
						if(boardDTO.getFileName1() != null) imageList.add(boardDTO.getFileName1());
						if(boardDTO.getFileName2() != null) imageList.add(boardDTO.getFileName2());
						if(boardDTO.getFileName3() != null) imageList.add(boardDTO.getFileName3());
						if(boardDTO.getFileName4() != null) imageList.add(boardDTO.getFileName4());
						if(boardDTO.getFileName5() != null) imageList.add(boardDTO.getFileName5());
					%>
						<div class="carousel-item active">
							<img src="<%=boardDAO.getfileSrc(imageList.get(0))%>">
		      			</div>
		      		<%
		      			for(int i = 1; i < imageList.size(); i++){
		      		%>
		      			<div class="carousel-item">
							<img src="<%=boardDAO.getfileSrc(imageList.get(i))%>">
		      			</div>
		      		<% 		
		      			}
		      		%>
					</div>
					
					<!-- Left and right controls -->
					<a class="carousel-control-prev" href="#demo" data-slide="prev">
						<span class="carousel-control-prev-icon"></span>
					</a>
					<a class="carousel-control-next" href="#demo" data-slide="next">
						<span class="carousel-control-next-icon"></span>
					</a>
				</div>
				<!-- slider END -->
    		</div>
    		<div class="col-5">
    			<form action ="./boardUpdate" method="post">
    				<input type="hidden" value="<%=bno%>" name="bno">
	    			<div class="form-group">
	    				<textarea class="form-control" name="content" rows="5" placeholder="내용을 입력해주세요"><%=boardDTO.getContent()%></textarea>
	    				<br>
						<input class="btn btn-primary pull-right" type="submit" value="다 했어요"
								style="background-color: #4adaaf; border: 1px solid #4adaaf;">
	    			</div>
	    		</form>
    		</div>
		</div>
	</div>

	<footer class="footer">
		<div class="container text-center">
			<span class="text-muted"><small>&copy;</small>2018 Developeon
				All rights reserved. </span>
		</div>
	</footer>
</body>
</html>
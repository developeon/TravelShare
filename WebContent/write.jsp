<%@page import="user.UserDTO"%>
<%@page import="user.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		if (userID == null) {
			request.getSession().setAttribute("messageType", "오류 메세지");
			request.getSession().setAttribute("messageContent", "현재 로그인이 되어있지 않습니다.");
			response.sendRedirect("index.jsp");
			return;
		}
	
		UserDAO userDAO = new UserDAO();
		UserDTO userDTO = userDAO.getUser(userID);
	%>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="shortcut icon" href="images/favicon.ico" type="image/x-icon" />
	<link rel="stylesheet" href="css/bootstrap.min.css">
	<link rel="stylesheet" href="css/sticky-footer-navbar.css">
	<link rel="stylesheet" href="css/common.css">
	<link rel="stylesheet" href="css/fileUpload.css">
	<link rel="stylesheet"
		href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">
	<link rel="stylesheet"
		href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<title>TravleShare</title>
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
		.well {
			height: 100%;
			background-color: white;
			border: 1px solid #f7f8f9;
			box-shadow: 5px 5px 20px rgba(0, 0, 0, 0.3);
			padding: 10px 30px;
			max-width: 755px;
			margin: 0px auto;
		}
		
		.borderless td, .borderless th {
			border: none;
		}
	</style>
</head>
<body>
	<!-- Fixed navbar -->
	<nav class="navbar navbar-expand-md fixed-top">
		<div class="container">
			<a class="navbar-brand" href="index.jsp"> <img src="images/logo.png"
				width="35" height="35" class="d-inline-block align-top" alt="">
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
					<form class="navbar-form" action="search.jsp" method="get">
						<div class="input-group">
							<input type="text" class="form-control" placeholder="Search"
								name="search" required="required">
							<div class="input-group-btn">
								<button class="btn btn-default" type="submit" style="border-bottom-left-radius: 0px;border-top-left-radius: 0px;">
									<i class="fa fa-search"></i>
								</button>
							</div>
						</div>
					</form>
				</div>
			<div>
				<%if(userID == null) {%>
					<a href="login.jsp">로그인</a> /
					<a href="join.jsp">가입</a>
				<% } else { %>
					 <div class="dropdown">
					 	<img class ="rounded-circle dropdown-toggle" data-toggle="dropdown"
					 		style="width:40px;height:40px;" src="<%=userDAO.getProfile(userID)%>">
					    <div class="dropdown-menu dropdown-menu-right">
					    	<a class="dropdown-item" href="mypage.jsp?showUserID=<%=userID%>">
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
				<% } %>
				</div>
			</div>
		</div>
	</nav>


	<section class="container" style="margin-top: 22px; margin-bottom: 80px;">
		<div class="well">
			<form name="writeForm" action="./boardWrite" method="post" enctype="multipart/form-data">
				<input type="hidden" value="<%=userID%>" name="userID">
				<table class="table borderless">
					<tr> <th><h4>이미지</h4></th> </tr>
					<tr>
						<td>
							<div class="col-ting">
								<div class="control-group file-upload" id="file-upload1">
									<div class="image-box text-center">
										<p>+</p>
										<img id="img1" src="" alt="">
									</div>
									<div class="controls">
										<input type="file" id="contact_image_1" name="contact_image_1"/>
									</div>
								</div>
								<div class="control-group file-upload" id="file-upload2">
									<div class="image-box text-center">
										<p>+</p>
										<img src="" alt="">
									</div>
									<div class="controls">
										<input type="file" id="contact_image_2" name="contact_image_2" />
									</div>
								</div>
								<div class="control-group file-upload" id="file-upload3">
									<div class="image-box text-center">
										<p>+</p>
										<img src="" alt="">
									</div>
									<div class="controls">
										<input type="file" id="contact_image_3" name="contact_image_3" />
									</div>
								</div>
								<div class="control-group file-upload" id="file-upload4">
									<div class="image-box text-center">
										<p>+</p>
										<img src="" alt="">
									</div>
									<div class="controls">
										<input type="file" id="contact_image_4" name="contact_image_4" />
									</div>
								</div>
								<div class="control-group file-upload" id="file-upload5">
									<div class="image-box text-center">
										<p>+</p>
										<img src="" alt="">
									</div>
									<div class="controls">
										<input type="file" id="contact_image_5" name="contact_image_5" />
									</div>
								</div>
							</div>
						</td>
					</tr>
					<tr> <th><h4>설명</h4></th> </tr>
					<tr>
						<td>
							<div class="form-group">
								<textarea class="form-control" name="content" rows="5"
									id="comment" placeholder="내용을 입력해주세요"></textarea>
							</div>
						</td>
					</tr>
					<tr>
						<td><input class="btn btn-primary pull-right" type="button" value="올리기"
							style="background-color: #4adaaf; border: 1px solid #4adaaf;" onclick="checkFunction()"></td>
					<tr>
				</table>
			</form>
		</div>
	</section>

	<footer class="footer">
		<div class="container text-center">
			<span class="text-muted"><small>&copy;</small>2018 Developeon
				All rights reserved. </span>
		</div>
	</footer>

	<script src="js/fileUpload.js"></script>
	<script>
		function checkFunction(){
			if($('#contact_image_1').val() == ""){
				alert("업로드할 사진을 선택해주세요.");
				return;
			}
			document.writeForm.submit();
		}
	</script>
</body>
</html>
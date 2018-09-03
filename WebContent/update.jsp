<%@page import="likes.LikesDAO"%>
<%@page import="board.BoardDAO"%>
<%@page import="board.BoardDTO"%>
<%@page import="user.UserDTO"%>
<%@page import="user.UserDAO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<% 
		String userID = "";
		if (session.getAttribute("userID") != null) {
			userID = (String)session.getAttribute("userID");
		}
		if (userID == "") {
			request.getSession().setAttribute("messageType", "오류 메세지");
			request.getSession().setAttribute("messageContent", "권한이 없습니다.");
			response.sendRedirect("index.jsp");
			return;
		}
		UserDAO userDAO = new UserDAO();
		UserDTO userDTO = userDAO.getUser(userID);
	%>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="shortcut icon" href="images/favicon.ico" type="image/x-icon" />
	<link rel="stylesheet" href="css/sticky-footer-navbar.css">
	<link rel="stylesheet" href="css/common.css">
	<link rel="stylesheet" href="css/pinterest.css">
	<link rel="stylesheet"
		href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel='stylesheet'
		href='https://cdnjs.cloudflare.com/ajax/libs/foundation/5.5.3/css/foundation.min.css'>
	<link rel="stylesheet" href="css/bootstrap.min.css">
	<!-- navbar -->
	<style>
		body,html{
			margin:0;
			padding:0;
			background-color: #f7f8f9;
		}
		nav{
			box-shadow: 2px 2px 3px #dddddd;
			z-index:1;
			background-color:#ffffff;
		}
	</style>
	<style>
		.profile-pic {
			max-width: 100px;
			max-height: 100px;
			display: block;
		}
		
		.file-upload {
			display: none;
		}
		
		.customCircle {
			border-radius: 1000px !important;
			overflow: hidden;
			width: 128px;
			height: 128px;
			border: 8px solid rgba(255, 255, 255, 0.7);
			position: relative;
		}
		
		img {
			max-width: 100%;
			height: auto;
		}
		
		.p-image {
			position: absolute;
			top: 95px;
			right: 30px;
			color: #666666;
			transition: all .3s cubic-bezier(.175, .885, .32, 1.275);
		}
		
		.p-image:hover {
			transition: all .3s cubic-bezier(.175, .885, .32, 1.275);
		}
		
		.upload-button {
			font-size: 1.2em;
		}
		
		.upload-button:hover {
			transition: all .3s cubic-bezier(.175, .885, .32, 1.275);
			color: #999;
		}
	</style>
	<title>TravleShare</title>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js" integrity="sha384-vFJXuSJphROIrBnz7yo7oB41mKfc8JzQZiCq4NCceLEaO4IHwicKwpJf9c9IpFgh" crossorigin="anonymous"></script>
	<script src="js/bootstrap.min.js"></script>
	<script>
		$(document).ready(function() {
	
			var readURL = function(input) {
				if (input.files && input.files[0]) {
					var reader = new FileReader();
	
					reader.onload = function(e) {
						$('.profile-pic').attr('src', e.target.result);
					}
	
					reader.readAsDataURL(input.files[0]);
				}
			}
	
			$(".file-upload").on('change', function() {
				readURL(this);
			});
	
			$(".upload-button").on('click', function() {
				$(".file-upload").click();
			});
		});
	</script>
	<script>
		function passwordCheckFunction() {
			var userPassword1 = $('#userPassword1').val();
			var userPassword2 = $('#userPassword2').val();
	
			if (userPassword1 != userPassword2) {
				$('#passwordCheckMessage').html('비밀번호가 서로 일치하지 않습니다.');
			} else {
				$('#passwordCheckMessage').html('');
			}
		}
	</script>
	
</head>
<body>
	<input type="hidden" id="userID" name="userID" value="<%=userID%>">
	<input type="hidden" id="detailBno" name="detailBno"> 
	
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

	<section class="container" style="margin-top:62px;padding-bottom: 60px;">
		<form method="post" action="./userUpdate" enctype="multipart/form-data">
			<input type="hidden" name="userID" value="<%=userID%>">
			<table class="table table-bordered table-hover"
				style="text-align: center; border: 1px solid #dddddd;background-color: white;">
				<thead>
					<tr>
						<td colspan="2">프로필 수정
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 110px;">아이디</td>
						<td><h5><%=userDTO.getUserID()%></h5></td>
					</tr>
					<tr>
						<td style="width: 110px;">프로필<br>사진</td>
						<td>
							<div class="small-12 medium-2 large-2 columns">
								<div class="customCircle">
									<!-- User Profile Image -->
									<img class="profile-pic" src="<%=userDAO.getProfile(userID)%>">
								</div>
								<div class="p-image">
									<i class="fa fa-camera upload-button"></i> <input
										class="file-upload" type="file" accept="image/*" name="file"/>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td style="width: 110px;">닉네임</td>
						<td><input type="text" class="form-control" id="userNickname"
							name="userNickname" maxLength="20"
							value="<%=userDTO.getUserNickname()%>" placeholder="닉네임"></td>
					</tr>
					<tr>
						<td style="width: 110px;">비밀번호</td>
						<td><input type="password" class="form-control"
							id="userPassword1" name="userPassword1" maxLength="20"
							value="<%=userDTO.getUserPassword()%>" placeholder="비밀번호"></td>
					</tr>
					<tr>
						<td style="width: 110px;">비밀번호<br>확인
						</td>
						<td><input type="password" onkeyup="passwordCheckFunction()"
							class="form-control" id="userPassword2" name="userPassword2"
							maxLength="20" value="<%=userDTO.getUserPassword()%>"
							placeholder="비밀번호 확인"></td>
					</tr>
					<tr>
						<td style="width: 110px;">자기소개</td>
						<td><textarea class="form-control" name="userIntro"
								placeholder="자기소개"><%=userDTO.getUserIntro()%></textarea></td>
					</tr>
					<tr>
						<td colspan="2"><span style="color: red;"
							id="passwordCheckMessage"></span> <input
							class="btn btn-primary pull-right" type="submit" value="다 했어요">
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<input class="btn btn-light pull-right" type="button" value="탈퇴" data-toggle="modal" data-target="#exampleModalCenter">
						</td>
					</tr>
				</tbody>
			</table>
		</form>
	</section>
	
	<!-- 업데이트 요청 실패 결과 모달 -->
	<%
		String messageContent = null;
		if (session.getAttribute("messageContent") != null) {
			messageContent = (String) session.getAttribute("messageContent");
		}
		String messageType = null;
		if (session.getAttribute("messageType") != null) {
			messageType = (String) session.getAttribute("messageType");
		}
		if (messageContent != null) {
	%>
	<div class="modal fade" id="messageModal">
		<div class="modal-dialog modal-md modal-dialog-centered">
			<div class="modal-content">
				<div
					class="modal-header <%if (messageType.equals("오류 메세지"))
					out.println("panel-warning");
				else
					out.println("panel-success");%>">
					<h4 class="modal-title"><%=messageType%></h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<div class="modal-body">
					<%=messageContent%>
				</div>
				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
				</div>
			</div>
		</div>
	</div>
	<script>
		$('#messageModal').modal("show");
	</script>
	<%
		session.removeAttribute("messageContent");
			session.removeAttribute("messageType");
		}
	%>
	
	<!-- 탈퇴 confirm 모달 -->
	<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
	  <div class="modal-dialog modal-md modal-dialog-centered" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLongTitle">정말 떠나시겠어요?</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <form method="post" action="./userDelete">
	      <input type="hidden" value="<%=userID%>" name="userID">
	      <div class="modal-body">
	        Are you sure you don't want to reconsider?<br>
			Could you tell us why you wish to leave TravelShare?<br>
			Your opinion helps us improve StyleShare into a better place for fashionistas from all around the world. We are always listening to our users. Help us improve!
			  <div class="form-group" style="margin-top: 15px;">
			    <label for="reason">Reason</label>
			    <input type="text" class="form-control" id="reason" name="reason" placeholder="Enter reason" maxlength="1024">
			  </div>
			
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
	        <button type="submit" class="btn btn-danger">계정삭제</button>
	      </div>
	      </form>
	    </div>
	  </div>
	</div>

</body>
</html>
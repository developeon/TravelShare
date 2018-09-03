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
		String userID = (String)session.getAttribute("userID"); 
		UserDAO userDAO = new UserDAO();
		UserDTO userDTO = userDAO.getUser(userID);
		
		String sort = "인기순";
		String search = "";
		if (request.getParameter("search") != null) {
			search = request.getParameter("search");
		}
		if (search.trim() == null || search.trim().equals("")) {
			request.getSession().setAttribute("messageType", "오류 메세지");
			request.getSession().setAttribute("messageContent", "검색어가 없습니다.");
			response.sendRedirect("index.jsp");
			return;
		}
		
		BoardDAO boardDAO = new BoardDAO();
		ArrayList<UserDTO> userList = null;
		userList = userDAO.getUserCard(search);
		ArrayList<BoardDTO> boardList = null;
		boardList = boardDAO.getList(sort, search);
		
		LikesDAO likesDAO = new LikesDAO();
		
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
	<title>TravleShare</title>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js" integrity="sha384-vFJXuSJphROIrBnz7yo7oB41mKfc8JzQZiCq4NCceLEaO4IHwicKwpJf9c9IpFgh" crossorigin="anonymous"></script>
	<script src="js/bootstrap.min.js"></script>
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
	<!-- up, write button css-->
	<style>
		.menuBtn {
			position: fixed;
			z-index: 99;
			width: 50px;
			height: 50px;
			font-weight: bold;
			cursor: pointer;
			outline: none;
		}
		/* up button */
		#upBtn {
			display: none;
			bottom: 75px;
			right: 30px;
			background-color: #f7f8f9;
			border: 2px solid #eff2f3;
			border-radius: 50px;
			color: #999999;
		}
	</style>
	<!-- 검색된 사용자의 profile card -->
	<style>
		.customCard {
			box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
  			width: 280px;
  			padding:10px;
  			margin: 10px;
  			background-color: white;
		}
		
		a{
			text-decoration: none;
			color: black;
		}
		a:hover{
			text-decoration: none;
			color: black;
		}
	</style>
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
					<form class="navbar-form" actiㅋon="search.jsp" method="get">
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
		<button class="menuBtn" id="upBtn">↑</button>
		
		<div class="row" style="border-bottom:1px solid #c9cdd2;">
			<h6 ><strong>사용자</strong>&nbsp;<%=userDAO.getUserCnt(search)%></h6>
		</div>
		<div class="row" style="padding: 20px;">
		<%
			if(userList.size() == 0){
				out.println("<font color='red'>" + search + "</font>에 대한 콜렉션 사용자 결과가 없습니다.");
			}
		
			for(int i=0; i<userList.size(); i++){
				UserDTO searchUser = userList.get(i);
		%>
			<div class="customCard">
				<table>
					<tr>
						<td><a href="mypage.jsp?showUserID=<%=searchUser.getUserID()%>"><img class="rounded-circle" src="<%=userDAO.getProfile(searchUser.getUserID())%>" style="width:100px;height:100px;"></a></td>
						<td>
							<a href="mypage.jsp?showUserID=<%=searchUser.getUserID()%>"><strong><%=searchUser.getUserNickname()%></strong></a>&nbsp;<font color="#c9cdd2">@<%=searchUser.getUserID()%></font><br>
							<font size="2px">활동 <strong><%=boardDAO.getBoardCnt(searchUser.getUserID(),"search")%></strong> 좋아요 <strong><%=likesDAO.getLikeCnt(searchUser.getUserID())%></strong></font><br>
							<font size="2px"><%=searchUser.getUserIntro()%></font>
						</td>
					</tr>
				</table>
			</div>
		<% 
			}
		%>
		</div>
		<div class="row" style="border-bottom:1px solid #c9cdd2;">
			<h6><strong>여행</strong>&nbsp;<%=boardDAO.getBoardCnt(search, "update")%></h6>
		</div>
		<div class="row" style="padding: 20px;">
			<% if(boardList.size() == 0){
				out.println("<font color='red'>" + search + "</font>에 대한 여행 검색 결과가 없습니다.");
			} %>
			<div class="card-columns">
			<%
				BoardDTO board = null;
				UserDTO tmpWriteUser = new UserDTO();
				for(int i=0; i<boardList.size(); i++){
					board = boardList.get(i);
					tmpWriteUser = userDAO.getUser(board.getWriterID());
			%>
				<div class="card">
					<img class="card-img-top" src="<%=boardDAO.getfileSrc(board.getFileName1())%>"
						onclick="showDetailFunction(<%=board.getBno()%>)">
					<div class="card-body">
						<table class="table table-borderless pinterest">
							<tr>
								<td rowspan="2" style="width: 64px;">
									<a href="mypage.jsp?showUserID=<%=board.getWriterID()%>">
										<img class ="rounded-circle profileImg" src="<%=userDAO.getProfile(board.getWriterID())%>">
									</a>
								</td>
								<td>
									<a href="mypage.jsp?showUserID=<%=board.getWriterID()%>">
										<%=tmpWriteUser.getUserNickname().trim()%>
									</a>
								</td>
								<td style="width: 80px;">
									<font color="#9ea4b1" size="2px"><%=board.getRegDate()%></font>
								</td>
							</tr>
							<% if(board.getContent() != "") { %>
							<tr>
								<td colspan="2"><%=board.getContent()%></td>
							</tr>
							<% } %>
						</table>
					</div>
				</div>
				<% } %>
			</div>
		</div>
	</section>

	<footer class="footer">
		<div class="container text-center">
			<span class="text-muted"><small>&copy;</small>2018 Developeon All rights reserved. </span>
		</div>
	</footer>
	
	<!-- Servlet 알림 모달 -->
	<%
		String messageContent = null;
		if(session.getAttribute("messageContent") != null){
			messageContent = (String)session.getAttribute("messageContent");
		}
		String messageType = null;
		if(session.getAttribute("messageType") != null){
			messageType = (String)session.getAttribute("messageType");
		}
		if(messageContent != null){
	%>
		<div class="modal fade" id="messageModal">
    		<div class="modal-dialog modal-md modal-dialog-centered">
      			<div class="modal-content">
	        		<div class="modal-header <% if(messageType.equals("오류 메세지")) out.println("panel-warning"); else out.println("panel-success"); %>">
						<h4 class="modal-title"><%= messageType %></h4>
	          			<button type="button" class="close" data-dismiss="modal">&times;</button>
	        		</div>
			        <div class="modal-body">
			          <%= messageContent %>
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
	
	<!-- ajax 알림 modal -->
  	<div class="modal fade" id="resultModal">
    	<div class="modal-dialog modal-md modal-dialog-centered">
    		<div class="modal-content">
	        	<div class="modal-header">
					<h4 class="modal-title" id="resultTitle"></h4>
	          		<button type="button" class="close" data-dismiss="modal">&times;</button>
	        	</div>
			    <div class="modal-body" id="resultBody">
			    </div>
			    <div class="modal-footer">
			    	<button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
			    </div>
     	     </div>
    	</div>
  	</div>
  			
	<!-- detail용 modal -->
	<div class="modal fade" id="detailModal" tabindex="-1" role="dialog" aria-hidden="true">
	    <div class="modal-dialog modal-lg" role="document">
	      <div class="modal-content">
	      	 <div class="modal-body">
	      	 	<div class="container-fluid">
					<div class="row">
	           			<div class="col-md-7 col-example">
	           				<!-- slider START -->
				      	 	<div id="demo" class="carousel slide" data-ride="carousel" data-interval="false">
							  <!-- The slideshow -->
							  <div class="carousel-inner" id="carousel-inner">
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
	           			 <div class="col-md-5 ml-auto col-example">
	           			 	<div class="row box-1">
								<table class="table table-borderless">
									<tr id="detailWriterProfile">
									</tr>
									<tr>
										<td colspan="2"><span id="detailContent"></span></td>
									</tr>
								</table>
	           			 	</div>
	           			 	<div class="row box-2">
	           			 		<!-- 좋아요 기능 -->
	           			 		<div class="col">
									<div class="btn-group" role="group">
									  <button type="button" id="btn-heart" class="btn" <% if(userID != null) out.println("onclick='likesAction()'"); %>><i class="fa fa-heart" aria-hidden="true"></i></button>
									  <button type="button" id="btn-count" class="btn" onclick="showLikesUserList()">0</button>
									</div>
								</div>
								<!-- 게시물 수정,삭제,신고 기능 -->
								<div class="col" id="boardControl">
									<div class="dropdown pull-right">
									  <button type="button" class="btn btn-outline-secondary dropdown-toggle" data-toggle="dropdown"><i class="fa fa-ellipsis-h"></i></button>
									  <div class="dropdown-menu dropdown-menu-right" id="controlDetail"></div>
									</div>
								</div>
	           			 	</div>
	           			 	<div class="row box-3">
	           			 		<span style="font-weight: bold;color: #72787f;">댓글(<span id="commentCnt">0</span>)</span>
	           			 		<%
	           			 			if(userID != null) {
	           			 				out.println("<input type='text' class='form-control' style='margin:7px 0px;' placeholder='댓글을 남기세요...' id='comment' name='comment' maxlength='1024'>");
	           			 			}
	           			 		%>
	           			 		<table class="table table-borderless" id="commentTable">
	           			 		</table>
	           			 	</div>
	           			 </div>
	          		</div>
	          	</div>
       		 </div>
	      </div>
	    </div>
	</div>
	
	<!-- 게시물 삭제 confirm용 modal -->
	<div class="modal fade" id="deleteBoardModal" tabindex="-1" role="dialog" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title">여행 지우기</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	      	여행을 삭제하고 싶다면 삭제를 누르세요.
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
	        <button type="button" class="btn btn-primary" onclick="deleteBoardFunction()">삭제</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<!-- 신고정보 저장용 input -->
	<input type="hidden" id="reportNumber" name="reportNumber">
	
	<!-- 신고용 modal -->
	<div class="modal fade" id="reportModal" tabindex="-1" role="dialog" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title">신고</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	      	<div class="list-group">
			  <button type="button" class="list-group-item list-group-item-action" onclick="reportConfrim(0)">저작권 침해 우려됨</button>
			  <button type="button" class="list-group-item list-group-item-action" onclick="reportConfrim(1)">다른 사진과 중복됨</button>
			  <button type="button" class="list-group-item list-group-item-action" onclick="reportConfrim(2)">혐오스러움</button>
			  <button type="button" class="list-group-item list-group-item-action" onclick="reportConfrim(3)">외설적임</button>
			  <button type="button" class="list-group-item list-group-item-action" onclick="reportConfrim(4)">여행과 무관함</button>
			  <button type="button" class="list-group-item list-group-item-action" onclick="reportConfrim(5)">지나친 광고성 게시물</button>
			</div>
	      </div>
	  	</div>
	  </div>
	</div>
	
	<!-- 신고 confirm용 modal -->
	<div class="modal fade" id="reportConfirmModal" tabindex="-1" role="dialog" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title">신고</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	      	작성자에게 상처가 될 수도 있어요. 계속 할까요?
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
	        <button type="button" class="btn btn-primary" onclick="reportAction()">신고</button>
	      </div>
	  	</div>
	  </div>
	</div>
	
	<!-- 좋아요 누른 유저의 목록 modal -->
	<div class="modal fade" id="likesUserModal" tabindex="-1" role="dialog" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title">좋아요한 사용자</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	      	<div class="list-group" id="likesUser">
			</div>
	      </div>
	  	</div>
	  </div>
	</div>
  		
	<!-- top button, write button script-->
	<script>
		window.onscroll = function() {
			scrollFunction()
		};
		function scrollFunction() {
			if (document.documentElement.scrollTop > 20) {
				$('#upBtn').fadeIn("slow");
			} else {
				$('#upBtn').fadeOut("slow");
			}
		}
		$( "#upBtn" ).click(function() {
			document.documentElement.scrollTop = 0;
		});
	</script>
	
	<script>
		$("#comment").keypress(function(e) { 
			var bno = $('#detailBno').val();
			var comment =  $('#comment').val().trim();
		    if (e.keyCode == 13 && comment.length > 0){
		    	$.ajax({
					type : "POST",
					url : "./CommentWriteServlet",
					data : {
						writerID : '<%=userID%>',
						comment : comment,
						bno : bno
					},
					success : function(data){
						if(data == "fail"){
							alert("ERROR");
						}
						$('#comment').val('');
						showCommentFunction(bno);
					}
				});
		    }    
		});
		
		function showDetailFunction(bno){
			$('#detailBno').val(bno);
			$('#controlDetail').html('');
			$('#comment').html('');
			showBoardDetailFunction(bno);
			showLikesFunction(bno);
			showCommentFunction(bno);
			$('#detailModal').modal("show");
		}
		
		function showBoardDetailFunction(bno){
			$('#carousel-inner').html('');
			$.ajax({
				type : "GET",
				url : "./BoardDetailServlet",
				data : {
					bno : bno
				},
				success : function(data){
					console.log(data);
					if(data == "") return;
					var parsed = JSON.parse(data);
					var result = parsed.result;
					showBoardDetail(result[0][0].value, result[0][1].value, result[0][2].value, result[0][3].value,
							result[0][4].value, result[0][5].value, result[0][6].value, result[0][7].value);
				}
			});
		}
		
		function showBoardDetail(bno, writerID, regDate, content, fileNames, writerProfileImage, writerNickname, writerIntro){
			var isFirst = true;
			var savePath = "http://localhost:8080/TravelShare/upload/board/";
			var fileNamesArray = fileNames.split("|");
			fileNamesArray.forEach(x => { 
				 if(x != "null"){
					 if(isFirst == true){
						 $('#carousel-inner').append('<div class="carousel-item active">' +
			      					'<img src="' + savePath + x + '">' +
			      				    '</div>'); 
						 isFirst = false;
					 }
					 else{
					 $('#carousel-inner').append('<div class="carousel-item">' +
		      					'<img src="' + savePath + x + '">' +
		      				    '</div>');
					 }
				 }
			});
			
			$('#detailWriterProfile').html('<td>' +
										     '<a href="mypage.jsp?showUserID=' + writerID +'">' +
												'<img class ="rounded-circle profileImg" src="' + writerProfileImage +'">' +
											 '</a>' +
										   '</td>' +
										   '<td>' +
										   	 '<a href="mypage.jsp?showUserID=' + writerID + '">' + 
										   			 writerNickname.trim() +
										   	 '</a>' + '<br>' + writerIntro.trim() +
										   '<td>');
			$('#detailContent').html(content.trim());
			
			/* 수정, 삭제, 신고 기능 */
			if($('#userID').val() != "null"){
				if(writerID == $('#userID').val()){
					$('#controlDetail').html("<a class='dropdown-item' href='modify.jsp?bno=" + bno +"'><i class='fa fa-edit'></i>&nbsp;수정</a>" +
						    	"<a class='dropdown-item' onclick='deleteConfirmFunction()'><i class='fa fa-trash-o'></i>&nbsp;삭제</a>");
				}
				$('#controlDetail').append("<a class='dropdown-item' onclick='reportConfirmFunction()'><i class='fa fa-flag'></i>&nbsp;신고</a>");
				$('#boardControl').css("display", "block");
			} else{
				$('#boardControl').css("display", "none");
			}
		}
		
		function showLikesFunction(bno){
			$("#likesUser").html('');
			$.ajax({
				type : "GET",
				url : "./ShowLikesServlet",
				data : {
					bno : bno,
					userID : '<%=userID%>'
				},
				success : function(data){ // yes or no
					if(data == "") return;
					var parsed = JSON.parse(data);
					var result = parsed.result;
					for(var i = 0; i < result.length; i++){
						showLikes(result[i][0].value, result[i][1].value, result[i][2].value);
					}
					var state = Number(parsed.state);
					var cnt = Number(parsed.cnt);
					if(state==1){
						$("#btn-heart").attr('class', 'btn btn-danger');
						$("#btn-count").attr('class', 'btn btn-danger');
					} else{
						// btn btn-defaultn
						$("#btn-heart").attr('class', 'btn btn-default');
						$("#btn-count").attr('class', 'btn btn-default');
					}
					$("#btn-count").html(cnt);
				}
			});
		}
		
		function showLikes(userID, userNickname, userProfile){
			$("#likesUser").append("<a href='mypage.jsp?showUserID=" + userID + "' class='list-group-item list-group-item-action' style='line-height:40px;'>" + userNickname +
					"<img class ='rounded-circle profileImg' style='margin-right:10px;' src='" + userProfile +"'></a>"); 
		}
		
		function showLikesUserList(){
			$('#likesUserModal').modal("show");
		}
		
		function likesAction(){
			var bno = $('#detailBno').val();
			$.ajax({
				type : "GET",
				url : "./LikesWriteServlet",
				data : {
					bno : bno,
					userID : '<%=userID%>'
				},
				success : function(){
					showLikesFunction(bno);
				}
			});
		}
		
		function showCommentFunction(bno){
			$('#commentCnt').html('0');
			$('#commentTable').html('');
			$.ajax({
				type : "GET",
				url : "./ShowCommentServlet",
				data : {
					bno : bno
				},
				success : function(data){
					if(data == "") return;
					var parsed = JSON.parse(data);
					var result = parsed.result;
					for(var i = 0; i < result.length; i++){
						showComment(result[i][0].value,result[i][1].value,result[i][2].value, result[i][3].value,
								result[i][4].value, result[i][5].value, result[i][6].value, result[i][7].value);
					}
				}
			});
		}
		
		function showComment(cno, writerID, writerProfileImage, writerNickname, comment, regDate, bno, commentCnt){
			$('#commentCnt').html(commentCnt);
			
			var appendText = "";
			if(writerID == $('#userID').val()){
				appendText = '<td>' +
						'<button type="button" class="btn btn-transparent" onclick="deleteCommentFunction('+bno+','+cno+')">X</a>' +
						'</td>' +
						'</tr>';
			}
			else{
				appendText = '<td></td>';
			}
			
			$('#commentTable').append('<tr>' +
										'<td><a href="mypage.jsp?showUserID='+ writerID +
										'"><img class ="rounded-circle" style="width:40px;height:40px;" src="'+ 
										writerProfileImage + '"></a></td>' +
										'<td>' + writerNickname + '&nbsp;'+ comment +'<br>' +
										'<font color="#9ea4b1" size="2px">'+ regDate +'</font></td>'+
										appendText +
									  '</tr>');
		}
		
		function deleteConfirmFunction(){
			$('#deleteBoardModal').modal('show');
		}
		
		function reportConfirmFunction(){
			$('#reportModal').modal('show');
		}
		
		function deleteBoardFunction(){
			var bno = $('#detailBno').val();
			 $.ajax({
				type : "GET",
				url : "./BoardDeleteServlet",
				data : {
					bno : bno
				},
				success : function(data){
					if(data == "fail"){
						$('#resultTitle').html("오류 메세지");
						$('#resultBody').html("데이터베이스 오류가 발생했습니다.");
					} else{ 
						$('#resultTitle').html("성공 메세지");
						$('#resultBody').html("게시물이 삭제되었습니다.");
					}
					$('#detailModal').modal('hide');
					$('#deleteBoardModal').modal('hide');
					$('#resultModal').modal('show');
				}
			}); 
		}
		
		function deleteCommentFunction(bno, cno){
			$.ajax({
				type : "GET",
				url : "./CommentDeleteServlet",
				data : {
					cno : cno
				},
				success : function(data){
					if(data == "fail"){
						alert("ERROR");
					}
					showCommentFunction(bno);
				}
			});
		}
		
		function reportConfrim(reportNumber){
			$('#reportNumber').val(reportNumber);
			$('#reportModal').modal('hide');
			$('#reportConfirmModal').modal('show');
		}
		
		function reportAction(){
			var bno = $('#detailBno').val();
			var reportNumber = $('#reportNumber').val();
			$.ajax({
				type : "GET",
				url : "./ReportWriteServlet",
				data : {
					bno : bno,
					reporter : '<%=userID%>',
					reportNumber : reportNumber
				},
				success : function(data){
					if(data == "fail"){
						$('#resultTitle').html("오류 메세지");
						$('#resultBody').html("데이터베이스 오류가 발생했습니다.");
					} else{ 
						$('#resultTitle').html("성공 메세지");
						$('#resultBody').html("신고가 접수되었습니다.");
					}
					$('#reportConfirmModal').modal('hide');
					$('#detailModal').modal('hide');
					$('#resultModal').modal('show');
				}
			});
		}
		
		$('#resultModal').on('hidden.bs.modal', function (e) {
			location.reload();
		});
	</script>
</body>
</html>
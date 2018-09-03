<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="shortcut icon" href="images/favicon.ico" type="image/x-icon" />
	<link rel="stylesheet" href="css/bootstrap.min.css">
	<link rel="stylesheet" href="css/common.css">
	<link rel="stylesheet" href="css/access.css">
	<title>로그인 | TravleShare</title>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
</head>
<body>
	<div class="hero-image">
		<div class="hero-text">
			<h1 style="font-size: 50px"><a href="index.jsp">TravelShare</a></h1>
			<p>로그인</p>
			<form method="post" action="./userLogin">
				<table class="table table-bordered table-hover" style="text-align: center; border: 1px solid #dddddd">
					<tbody>
						<tr>
							<td colspan="2">
								<input type="text" class="form-control" id="userID" name="userID" maxLength="20" placeholder="아이디">
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<input type="password" class="form-control" id="userPassword" name="userPassword" maxLength="20" placeholder="비밀번호">
							</td>
						</tr>
						<tr>
							<td colspan="3">
								<input class="btn btn-primary pull-right" type="submit" value="로그인"></td>
						</tr>
					</tbody>
				</table>
			</form>
			<span>ID가 없으세요?<a href="join.jsp"> 여기서 가입</a></span>
		</div>
	</div>
	
	<!-- 로그인 요청 결과 알림 모달 -->
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
</body>
</html>
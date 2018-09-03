<%@page import="user.UserDAO"%>
<%@page import="user.UserDTO"%>
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
		UserDTO user = new UserDAO().getUser(userID);
	%>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="css/bootstrap.min.css">
	<link rel="stylesheet" href="css/common.css">
	<link rel='stylesheet'
		href='https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css'>
	<link rel='stylesheet'
		href='https://cdnjs.cloudflare.com/ajax/libs/foundation/5.5.3/css/foundation.min.css'>
	<style>
	.profile-pic {
		max-width: 100px;
		max-height: 100px;
		display: block;
	}
	
	.file-upload {
		display: none;
	}
	
	.circle {
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
	<title></title>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
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
	<div class="container">
		<form method="post" action="./userUpdate" enctype="multipart/form-data">
			<input type="hidden" name="userID" value="<%=userID%>">
			<table class="table table-bordered table-hover"
				style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<td colspan="2">프로필 수정
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 110px;">아이디</td>
						<td><h5><%=user.getUserID()%></h5></td>
					</tr>
					<tr>
						<td style="width: 110px;">프로필<br>사진</td>
						<td>
							<div class="small-12 medium-2 large-2 columns">
								<div class="circle">
									<!-- User Profile Image -->
									<img class="profile-pic" src="<%=new UserDAO().getProfile(userID)%>">
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
							value="<%=user.getUserNickname()%>" placeholder="닉네임"></td>
					</tr>
					<tr>
						<td style="width: 110px;">비밀번호</td>
						<td><input type="password" class="form-control"
							id="userPassword1" name="userPassword1" maxLength="20"
							value="<%=user.getUserPassword()%>" placeholder="비밀번호"></td>
					</tr>
					<tr>
						<td style="width: 110px;">비밀번호<br>확인
						</td>
						<td><input type="password" onkeyup="passwordCheckFunction()"
							class="form-control" id="userPassword2" name="userPassword2"
							maxLength="20" value="<%=user.getUserPassword()%>"
							placeholder="비밀번호 확인"></td>
					</tr>
					<tr>
						<td style="width: 110px;">자기소개</td>
						<td><textarea class="form-control" name="userIntro"
								placeholder="자기소개"><%=user.getUserIntro()%></textarea></td>
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
	</div>

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
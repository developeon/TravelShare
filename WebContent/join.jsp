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
	<title>회원가입 | TravleShare</title>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script>
		function registerCheckFunction(){
			var userID = $('#userID').val();
			
			$.ajax({
				type : "POST",
				url : "./UserRegisterCheckServlet",
				data : {userID: userID},
				success : function(result){
					if(result == 1){
						$('#checkMessage').html('사용할 수 있는 아이디입니다.');
						$('#idCheckModal').modal("show");
					}
					else{
						$('#checkMessage').html('사용할 수 없는 아이디입니다.');
						$('#checkModal').modal("show");
					}
				}
				
			});
		}
	
		function passwordCheckFunction(){
			var userPassword1 = $('#userPassword1').val();
			var userPassword2 = $('#userPassword2').val();
			
			if(userPassword1 != userPassword2){
				$('#isPasswordChecked').val('false');
			}
			else{
				$('#isPasswordChecked').val('true');
			}
		}
	</script>
</head>
<body>
	<div class="hero-image">
		<div class="hero-text">
			<h1 style="font-size: 50px"><a href="index.jsp">TravelShare</a></h1>
			<p>회원가입</p>
			<form method="post" action="./userRegister" id="registerForm" name="registerForm">
				<input type="hidden" id="isEmailChecked" name="isEmailChecked" value="false">
				<input type="hidden" id="isIdChecked" name="isIdChecked" value="false">
				<input type="hidden" id="isPasswordChecked" name="isPasswordChecked" value="false">
				<table class="table table-bordered table-hover" style="text-align: center; border: 1px solid #dddddd">
					<tbody>
						<tr>
							<td>
							    <input type="text" class="form-control" id="userID" name="userID" maxLength="20" placeholder="아이디">
							</td>
							<td style="width: 110px;">
								<button type="button" id="checkBtn" class="btn btn-primary" onClick="registerCheckFunction();">중복체크</button>
							</td>
						</tr>
						<tr>
							<td>
								<input type="text" class="form-control" id="userEmail" name="userEmail" maxLength="50" placeholder="이메일" onchange="stopIntervalFunction()">
							</td>
							<td style="width: 110px;">
								<button type="button" class="btn btn-primary" onClick="emailCheckFunction()">이메일인증</button>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<input type="text" class="form-control" id="userNickname" name="userNickname" maxLength="20" placeholder="닉네임">
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<input type="password" onkeyup="passwordCheckFunction()" class="form-control" 
									id="userPassword1" name="userPassword1" maxLength="20" placeholder="비밀번호">
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<input type="password" onkeyup="passwordCheckFunction()" class="form-control" 
									id="userPassword2" name="userPassword2" maxLength="20" placeholder="비밀번호 확인">
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<input class="btn btn-primary pull-right" type="button" value="가입" id="registerBtn">
							</td>
						</tr>
					</tbody>
				</table>
			</form>
			<span>이미 계정을 갖고 계시다구요?<a href="login.jsp"> 여기서 로그인</a></span>
		</div>
	</div>
	
	<!-- 회원가입 요청 결과 모달 -->
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
	
	<!-- 아이디 중복체크 모달  -->
	<div class="modal fade" id="idCheckModal" tabindex="-1" role="dialog" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered">
	    <div class="modal-content">
	      <div class="modal-header panel-info">
	        <h5 class="modal-title">확인메세지</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	        	사용가능한 아이디입니다. 사용하시겠습니까?
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">NO</button>
	        <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="useIdFunction()">YES</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<!-- 각종 결과 모달 -->
	<div class="modal fade" id="checkModal" tabindex="-1" role="dialog" aria-hidden="true">
    	<div class="modal-dialog modal-md modal-dialog-centered">
      		<div class="modal-content">
	        	<div class="modal-header panel-info">
					<h4 class="modal-title">확인 메세지</h4>
	          		<button type="button" class="close" data-dismiss="modal">&times;</button>
	        	</div>
			    <div class="modal-body" id="checkMessage">
			    </div>
			    <div class="modal-footer">
			    	<button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
			    </div>
     	     </div>
    	</div>
  	</div>
  	
  	
  	<!-- 이메일 인증 -->
  	<script>
			var myInterval;
			
			function useIdFunction(){
				$('#userID').prop('readonly', 'true');
				$('#isIdChecked').val("true");
			}
			
			function validateEmail(email) {
				var re = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
				return re.test(email);
			}
			
			function emailCheckFunction(){
				var userEmail = $('#userEmail').val();
				if(userEmail.trim() == "" || validateEmail(userEmail) == false){
					$('#checkMessage').html('이메일의 형식이 올바르지 않습니다.');
					$('#checkModal').modal("show");
					return;
				}
				$('#userEmail').prop('readonly', 'true');
				$.ajax({
					type : "POST",
					url : "./TmpUserRegisterServlet",
					data : {
						userEmail : userEmail
					},
					success : function(data){
						if(data==0){
							$('#checkMessage').html('이메일이 이미 존재합니다.');
							$('#checkModal').modal("show");
							$('#userEmail').removeAttr('readonly');
						} else if(data ==1){
							emailSendFunction();
						} else{
							alert("ERROR");
							location.reload();
						}
					}
				});
			}
			
			function emailSendFunction(){
					var userEmail = $('#userEmail').val();
					$.ajax({
						type : "POST",
						url : "./EmailSendServlet",
						data : {
							userEmail : userEmail
						},
						success : function(data){
							if(data==-1){
								alert("ERROR");
								location.reload();
							} else{
								$('#checkMessage').html('인증 이메일이 발송되었습니다. 입력한 이메일에 접속하여 인증을 해주세요.');
								$('#checkModal').modal("show");
								myInterval = setInterval(getState, 4000);
							}
						}
					});
				}
				
				function getState(){
					var userEmail = $('#userEmail').val();
					$.ajax({
						type : 'POST',
						url : "./GetStateServlet",
						data : {
							userEmail : userEmail
						},
						success : function(result){
							if(result == 1){
								$('#checkMessage').html('인증이 완료되었습니다.');
								$('#checkModal').modal("show");
								$('#isEmailChecked').val("true");
								deleteTmpEmailFunction(userEmail);
								stopIntervalFunction();
							} 
						}
					});
				}
				
				function stopIntervalFunction(){
					clearInterval(myInterval);
				}
				
				function deleteTmpEmailFunction(userEmail){
					$.ajax({
						type : "POST",
						url : "./DeleteTmpEmailServlet",
						data : {
							userEmail : userEmail
						},
						success : function(data){
							if(data==-1){
								alert("잘못된 접근");
								location.href="index.jsp";
							}
						}
					});
				}
				
				$( "#registerBtn" ).click(function() {
					if(registerForm.userID.value == ""){
		    			$('#checkMessage').html('아이디를 입력하세요.');
						$('#checkModal').modal("show");
		    			return 0;
		    		}
					if(registerForm.userEmail.value == ""){
						$('#checkMessage').html('이메일을 입력하세요.');
						$('#checkModal').modal("show");
		    			return 0;
		    		}
					if(registerForm.userNickname.value == ""){
						$('#checkMessage').html('닉네임을 입력하세요.');
						$('#checkModal').modal("show");
		    			return 0;
		    		}
					if(registerForm.userPassword1.value == ""){
						$('#checkMessage').html('비밀번호를 입력하세요.');
						$('#checkModal').modal("show");
		    			return 0;
		    		}
					if(registerForm.userPassword2.value == ""){
						$('#checkMessage').html('비밀번호 확인을 입력하세요.');
						$('#checkModal').modal("show");
		    			return 0;
		    		}
					if($('#isIdChecked').val()== "false"){
						$('#checkMessage').html('아이디 중복체크를 해주세요.');
						$('#checkModal').modal("show");
						return 0;
					}
					if($('#isEmailChecked').val()== "false"){
						$('#checkMessage').html('이메일 인증을 해주세요.');
						$('#checkModal').modal("show");
						return 0;
					}
					if($('#isPasswordChecked').val()== "false"){
						$('#checkMessage').html('비밀번호가 서로 일치하지 않습니다.');
						$('#checkModal').modal("show");
						return 0;
					}
					registerForm.submit();
				});
			</script>

</body>
</html>
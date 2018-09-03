<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="shortcut icon" href="images/favicon.ico" type="image/x-icon" />
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<title>관리자 | TravleShare</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<style>
body {
  color: #808080;
  text-align: center;	
}
.col_half {
	width: 49%;
}

.col_third {
	width: 32%;
}

.col_fourth {
	width: 23.5%;
}

.col_fifth {
	width: 18.4%;
}

.col_sixth {
	width: 15%;
}

.col_three_fourth {
	width: 74.5%;
}

.col_twothird {
	width: 66%;
}

.col_half, .col_third, .col_twothird, .col_fourth, .col_three_fourth,
	.col_fifth {
	position: relative;
	display: inline;
	display: inline-block;
	float: left;
	margin-right: 2%;
	margin-bottom: 20px;
}

.end {
	margin-right: 0 !important;
}
/* Column Grids End */
.wrapper {
	width: 980px;
	margin: 30px auto;
	position: relative;
}

.counter {
	background-color: #f8f9fa;
	padding: 20px 0;
	border-radius: 5px;
}

.count-title {
	font-size: 40px;
	font-weight: normal;
	margin-top: 10px;
	margin-bottom: 0;
	text-align: center;
}

.count-text {
	font-size: 13px;
	font-weight: normal;
	margin-top: 10px;
	margin-bottom: 0;
	text-align: center;
}

.fa-2x {
	margin: 0 auto;
	float: none;
	display: table;
	color: #4ad1e5;
}
</style>
</head>
</head>

<body>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a class="navbar-brand" href="admin.jsp"> <img
			src="images/logo.png" width="35" height="35"
			class="d-inline-block align-top">
		</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item"><a class="nav-link" href="admin_user.jsp">회원관리</a>
				</li>
				<li class="nav-item"><a class="nav-link" href="admin_board.jsp">게시물관리</a>
				</li>
				<li class="nav-item"><a class="nav-link"
					href="admin_report.jsp">신고관리</a></li>
				<li class="nav-item"><a class="nav-link"
					href="admin_reason.jsp">탈퇴관리</a></li>
				<li class="nav-item"><a class="nav-link" href="logout.jsp">나가기</a>
				</li>
			</ul>
		</div>
	</nav>

	<!-- 나가기(세션 아웃), 총 가입자수, 총 게시물 수, 총 좋아요 수 같은거 출력 -->
	<div class="container" style="margin-top:62px;padding-bottom: 60px;">
		<h1>TravelShare</h1>
		<h3>궁금했던 누군가의 여행</h3>

		<div class="wrapper">
			<div class="counter col_fourth">
				<i class="fa fa-user-o fa-2x"></i>
				<h2 class="timer count-title count-number" data-to="300"
					data-speed="1500"></h2>
				<p class="count-text">User</p>
				<h1  id="user">0</h1>
			</div>

			<div class="counter col_fourth">
				<i class="fa fa-pencil fa-2x"></i>
				<h2 class="timer count-title count-number" data-to="1700"
					data-speed="1500"></h2>
				<p class="count-text">Board</p>
				<h1 id="board">0</h1>
			</div>

			<div class="counter col_fourth">
				<i class="fa fa-heart-o fa-2x"></i>
				<h2 class="timer count-title count-number" data-to="11900"
					data-speed="1500"></h2>
				<p class="count-text">Like</p>
				<h1 id="likes">0</h1>
			</div>

			<div class="counter col_fourth end">
				<i class="fa fa-comment-o fa-2x"></i>
				<h2 class="timer count-title count-number" data-to="157"
					data-speed="1500"></h2>
				<p class="count-text">Comment</p>
				<h1 id="comment">0</h1>
			</div>
		</div>
	</div>
	
	<script>
		function showInfoFunction(){
			$.ajax({
				type : "GET",
				url : "./ShowInfoServlet",
				data : {
				},
				success : function(data){
					var data = data;
					var res = data.split("|");
					$('#user').html(res[0]);
					$('#board').html(res[1]);
					$('#likes').html(res[2]);
					$('#comment').html(res[3]);
				}
			});
		}
		
		function getInfiniteInfo(){
			setInterval(function(){
				showInfoFunction();
			}, 4000);
		}
		
		showInfoFunction();
		getInfiniteInfo();
	</script>
</body>

</html>
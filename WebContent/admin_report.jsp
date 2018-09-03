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
	<title>관리자 | TravleShare</title>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
</head>
</head>

<body>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
	     <a class="navbar-brand" href="admin.jsp"> 
	 		<img src="images/logo.png" width="35" height="35" class="d-inline-block align-top">
		</a>
	  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
	    <span class="navbar-toggler-icon"></span>
	  </button>
	
	  <div class="collapse navbar-collapse" id="navbarSupportedContent">
	    <ul class="navbar-nav mr-auto">
	      <li class="nav-item">
	        <a class="nav-link" href="admin_user.jsp">회원관리</a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link" href="admin_board.jsp">게시물관리</a>
	      </li>
	      <li class="nav-item  active">
	        <a class="nav-link" href="admin_report.jsp">신고관리</a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link" href="admin_reason.jsp">탈퇴관리</a>
	      </li>
	       <li class="nav-item">
	        <a class="nav-link" href="logout.jsp">나가기</a>
	      </li>
	    </ul>
	  </div>
	</nav>
	<br>
	<div class="container">
		<div class="form-group row float-right">
			<div class="col-xs-8">
				<input class="form-control"  id="search" name="search" type="text" size="20" onkeyup="searchFunction()" placeholder="Search..">
			</div>
			<div class="col-xs-2">
				<button class="btn btn-primary" type="button" onclick="searchFunction()">검색</button>
			</div>
		</div>
		<table class="table" style="text-align: center;border: 1px solid #dddddd">
			<thead>
				<tr>
					<th style="background-color: #fafafa;text-align: center;">신고 번호</th>
					<th style="background-color: #fafafa;text-align: center;">신고자</th>
					<th style="background-color: #fafafa;text-align: center;">신고게시물</th>
					<th style="background-color: #fafafa;text-align: center;">사유</th>
					<th style="background-color: #fafafa;text-align: center;">처리여부</th>
					<th style="background-color: #fafafa;text-align: center;">비고</th>
				</tr>
			</thead>
			<tbody id="ajaxTable">
			</tbody>
		</table>
	</div>
	
	<script>
		function searchFunction() {
			var search = document.getElementById("search").value;
			$.ajax({
				type : "POST",
				url : "./ReportSearchServlet",
				data : {
					search : search
				},
				success : function(data) {
					searchProcess(data);
				}
			});
		}

		function searchProcess(data) {
			var table = document.getElementById("ajaxTable");
			table.innerHTML = "";
			if (data == "")
				return;
			var parsed = JSON.parse(data);
			var result = parsed.result;
			for (var i = 0; i < result.length; i++) {
				var row = table.insertRow(0);
				for (var j = 0; j < result[i].length; j++) {
					var cell = row.insertCell(j);
					if(j==3){
						switch(result[i][j].value) {
					    case "0":
					    	result[i][j].value = "저작권 침해 우려됨";
					        break;
					    case "1":
					    	result[i][j].value = "다른 사진과 중복됨";
					        break;
					    case "2":
					    	result[i][j].value = "혐오스러움";
					        break;
					    case "3":
					    	result[i][j].value = "외설적임";
					        break;
					    case "4":
					    	result[i][j].value = "여행과 무관함";
					        break;
					    default:
					    	result[i][j].value = "지나친 광고성 게시물";
						}
					}
						
					cell.innerHTML = result[i][j].value;
					if (j == result[i].length - 1) {
						var cell = row.insertCell(j + 1);
						if(result[i][4].value == "미처리"){
							cell.innerHTML = "<select id='state' name='state' onchange='changeState(" + result[i][0].value + ")'>" + 
										   "<option value='미처리' selected>미처리</option>" +
										   "<option value='처리'>처리</option>" +
										 "</select>";
						} else{
							cell.innerHTML = "<select id='state' name='state' onchange='changeState(" + result[i][0].value + ")'>" + 
							   "<option value='미처리' >미처리</option>" +
							   "<option value='처리' selected>처리</option>" +
							 "</select>";
						}
					}
				}
			}
		}
		
		function changeState(rno){
			var state = document.getElementById('state').value;
			$.ajax({
				type : "GET",
				url : "./ReportUpdateServlet",
				data : {
					rno : rno,
					state : state
				},
				success : function(data) {
					if (data == "success") {
						alert("변경되었습니다.");
					} else {
						alert("ERROR");
					}
					searchFunction();
				}
			});
		}
		
		searchFunction();
	</script>
</body>

</html>
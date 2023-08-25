<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.slim.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<title>Insert title here</title>
<style>
div {
	/* 바로 상위 태그인 body를 기준으로 맞춰주게끔 */
	/* position의 absolute라는것이, 설정하게 되면
    바로 직계부모 태그의 영향아래 놓이게 된다는 말이다.
    더불어서 네모를 영역으로 봤을때 왼쪽 상단 꼭지점을
    기준으로 움직이게 된다. */
	position: absolute;
	left: 50%;
	top: 50%;
	transform: translate(-50%, -50%);
	width: 580px;
	height: 400px;
	background: #FFFFFF;
	border: 1px solid #AACDFF;
	box-shadow: 7px 7px 39px rgba(0, 104, 255, 0.25);
	border-radius: 20px;
	/* 이것의 의미는 타겟팅된 영역에 대해 
    지정된 만큼 움직여주는 거라고 한다. */
	/* justify-content: space-evenly;
    align-content: column; */
	margin: 0px;
	padding: 50px;
	box-sizing: border-box;
	display: flex;
	flex-direction: column;
	flex-wrap: nowrap;
}

input {
	padding: 0px;
	border: none;
	border-bottom: 1px solid #CFCFCF;
	width: 466px;
	height: 30px;
}
</style>
</head>
<body>
	<div class="panel-body">
		<h2>로그인</h2>
		<br>
		<form role="form" action="/login" method="post">
			<fieldset>

				아이디 <input type="text" class="form-control" placeholder="ID" />
				비밀번호 <input type="password" class="form-control"placeholder="Password" />
				<br><br>
				<button type="submit" class="btn btn-lg btn-success btn-block">로그인</button>
			</fieldset>
		</form>
	</div>

</body>
</html>
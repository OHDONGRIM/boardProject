<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>게시판 글쓰기</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
function backToList(obj){
    obj.action="${contextPath}/board/list.do";
    obj.submit();
  }
  
function insert(){
	alert("새글이 등록되었습니다.")
	location.href = "/board/list.do";
  }


var cnt=1;
function fn_addFile(){
	$("#d_file").append("<br>"+"<input type='file' name='fileName"+cnt+"' />");
	cnt++;
	}
</script>

<style type="text/css">
.container{
margin-top: 100px;
padding: 30px;
}
</style>
</head>
<body>
	<div class="container" style="border: 1px solid lightgray" align="center">
		<h2>게시판 글쓰기</h2>
		<br><br><br>
		
		<form action='<c:url value='/board/write.do'/>' method="post" enctype="multipart/form-data">


			<table class="table">
				<tr>
					<td><label for="title">글제목</label></td>
					<td><input type="text" class="form-control" id="title" name="title" placeholder="제목을 작성해주세요."></td>
				</tr>
				<tr>
					<td><label for="writer">작성자</label></td>
					<td><input type="text" class="form-control" name="writer" placeholder="이름을 적어주세요."></td>
				</tr>
				<tr>
					<td>글 유형</td>
					<td>
						<div>
							<label class="form-check-label"> 
							<input type="radio" class="form-check-input" name="notice_chk" value="0">공지글
							</label>
						</div> 
						<label class="form-check-label"> 
						<input type="radio" class="form-check-input" name="notice_chk" value="1">일반글
						</label>
					</td>
				</tr>
				<tr>
					<td><label for="comment">내용</label></td>
					<td><textarea class="form-control" rows="5" id="content"name="content" placeholder="내용을 입력하세요."></textarea></td>
				</tr>
				<tr>				
					<td >이미지파일 첨부</td>
					<td align="left"><input type="button" value="파일 추가" onClick="fn_addFile()"/>
					<div id="d_file"></div>
					</td>
			
				</tr>
				<tr>
					<td></td>
					<td>
						<button type="submit" class="btn btn-primary" onClick="insert()">등록</button>		
						<button type="submit" class="btn btn-primary" onClick="backToList(this.form)">글 목록</button>				
					</td>
				</tr>
			</table>
		</form>
		
	</div>

</body>
</html>
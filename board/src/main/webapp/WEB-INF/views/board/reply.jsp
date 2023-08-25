<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- <c:set var="section"  value="${section}"  />
<c:set var="pageNum"  value="${pageNum}"  />
<c:set var="parentNo"  value="${parentNo}"  />   --%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>

<script>
function insert(){
	alert("댓글이 등록되었습니다.")
	
  }
  
function backToList(obj){
    obj.action="${contextPath}/board/read.do";
    obj.submit();
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
		<h2>댓글쓰기</h2>
		<br><br><br>
		<%--  --%>
		<form action="/board/reply.do" method="post">
			<input type="hidden" name="parentNo" value="${parentNo}">
			<input type="hidden" name="section" value="${section}">
			<input type="hidden" name="pageNum" value="${pageNum}">
			<table class="table">
				<tr>
					<td><label for="title">댓글 제목</label></td>
					<td><input type="text" class="form-control" id="title" name="title" placeholder="제목을 작성해주세요."></td><!-- 수정 클릭시 띄어쓰기 처리하여 표시 -->
				</tr>
				<tr>
					<td><label for="writer">댓글 작성자</label></td>
					<td><input type="text" class="form-control" name="writer" placeholder="이름을 적어주세요."></td>
				</tr>
				<tr>
					<td><label for="comment">댓글 내용</label></td>
					<td><textarea class="form-control" rows="5" id="content"name="content" placeholder="내용을 입력하세요."></textarea></td>
				</tr>
				<tr>
					<td></td>
					<td>
						<button type="submit" class="btn btn-primary" onClick="insert();">댓글 달기</button>		
						<button type="button" class="btn btn-primary" onClick="backToList(this.form)">취소</button>					
					</td>
				</tr>
			</table>	
		</form>	
	</div>

</body>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<c:set var="board"  value="${boardMap.board}"  />  
<c:set var="imageFileList"  value="${boardMap.imageFileList}"  />   
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
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>

<script>
function modify(){
	alert("수정되었습니다.")
	location.href = "/board/read.do?bno=${board.bno}&amp;section=${section}&amp;pageNum=${pageNum}";
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
		<h2>게시판 글쓰기</h2>
		<br><br><br>
		
		<%-- <form action='<c:url value='/board/update.do'/>' method="post"> --%>
		<input type="hidden" name="bno" value="${board.bno }">
		
			<table class="table">
				<tr>
					<th>글제목</th>
					<td><input type="text" class="form-control" id="title" name="title" value="${board.title}" style="white-space: pre-wrap;"></td><!-- 수정 클릭시 띄어쓰기 처리하여 표시 -->
					<th>조회수</th>
					<td>${board.hits }</td>
				</tr>
				<tr>
					<th>작성자</th>
					<td>${board.writer }</td>
					<th>작성일</th>
					<td><fmt:formatDate value="${board.writeDate}" pattern="yyyy-MM-dd HH:mm:ss" var="formattedDate" />${formattedDate}</td>
				</tr>
				<tr>
					<th>글 유형</th>			
					<td colspan="3">
						<c:if test="${board.notice_chk eq 0}"><b>공지글 </b></c:if>
						<c:if test="${board.notice_chk eq 1}"><b>일반글 </b></c:if>
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td colspan="3"><textarea class="form-control" rows="5" id="content"name="content" placeholder="내용을 입력하세요.">${board.content }</textarea></td>
				</tr>
				<c:if test="${not empty imageFileList && imageFileList!='null' }">
					<c:forEach var="item" items="${imageFileList }" varStatus="status">
						<tr >
							<th rowspan="2">
							이미지${status.count }
							</th>
							<td colspan="3">
								<input type="hidden" name="originalFileName" value="${item.fileName }"/>
								<img src="/download.do?bno=${board.bno }&fileName=${item.fileName }" id="preview"/>							
							</td>
						</tr>
						<tr>
							<td colspan="3" style="border-top: none;">
								<input type="file" name="fileName" id="i_imageFileName" />								
							</td>
						</tr>
					</c:forEach>
				</c:if>
				
				<tr>
					<td></td>
					<td></td>
					<td>
						<button type="submit" class="btn btn-primary" onClick="modify()">수정</button>		
						<button type="button" class="btn btn-primary" onClick="backToList(this.form)">취소</button>					
					</td>
					<td></td>
				</tr>
			</table>	
<!-- 		</form>	 -->
	</div>

</body>

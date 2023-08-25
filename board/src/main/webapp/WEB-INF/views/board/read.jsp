<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<c:set var="board"  value="${boardMap.board}"  />   
<c:set var="imageFileList"  value="${boardMap.imageFileList}"  />
<c:set var="section"  value="${section}"  />
<c:set var="pageNum"  value="${pageNum}"  />   
<!DOCTYPE html>
<html lang="ko">
<head>
<script>
function confirmDelete(){
		  if (confirm("정말 삭제하시겠습니까?")) {
			location.href = "/board/delete.do?bno=${board.bno}";
			alert("삭제되었습니다.");
		   
		  }else{
			  alert("취소되었습니다.")
		  }
		}
		
function readURL(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function(e) {
            $('#' + previewId).attr('src', e.target.result);
        }
        reader.readAsDataURL(input.files[0]);
    }
}

function fn_enable(obj){
	var fileInputs = document.getElementsByClassName("file-input");
    for (var i = 0; i < fileInputs.length; i++) {
        fileInputs[i].disabled = false;
    }
	document.getElementById("i_title").disabled=false;
	document.getElementById("i_content").disabled=false;
	/*document.getElementById("i_fileName").disabled=false; */
	document.getElementById("tr_btn").style.display = "none";
	document.getElementById("btn_modify").style.display = "inline";
}


function fn_modify(boardForm){	
		  if (confirm("수정하시겠습니까?")) {	
			  // 이미지 파일의 파일 이름을 가져와서 boardForm의 fileName 필드에 설정
		        var fileInputs = document.getElementsByClassName("file-input");
		        for (var i = 0; i < fileInputs.length; i++) {
		            var fileName = fileInputs[i].files[0].name;
		            boardForm.elements["fileName" + (i + 1)].value = fileName;
		     	}
		        
			  
			boardForm.submit();
			alert("수정되었습니다.");
			
			
		  }else{
			  alert("취소되었습니다.")
	  	  }

	}

</script>
<title>게시판 글쓰기</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<style type="text/css">
.container{margin-top: 100px;padding: 30px;}
.comment-box{margin-top: 50px;padding: 30px; width: 1200px; margin: 0 auto;}
#btn_modify {display: none;} 
</style>
</head>
<body>
	<form action="/board/update.do" name="boardForm"  method="post" enctype="multipart/form-data">
		<div class="container" style="border: 1px solid lightgray" align="center">
		<h2>상세보기</h2>
		<br><br><br>
		<input type="hidden" name="bno" value="${board.bno }">
		<input type="hidden" name="section" value="${section}">
		<input type="hidden" name="pageNum" value="${pageNum}">
		
			<table class="table" >	
				<tr>
					<td style="border-top: none;"><c:if test="${board.notice_chk eq 0}"><img src="/resources/images/notice.png" width="50px" /></c:if></td>
				</tr>				
				<tr>
					<th>글제목</th>					
					<td><input type="text" class="form-control" id="i_title" name="title" value="${board.title}" style="white-space: pre-wrap;" disabled></td>
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
					<th>내용</th>
					<td colspan="3"><textarea class="form-control" rows="5" id="i_content" name="content" disabled>${board.content }</textarea></td>
				</tr>
			
				<c:if test="${not empty imageFileList && imageFileList!='null' }">
					<c:forEach var="item" items="${imageFileList }" varStatus="status">
				         <tr>
				                <th rowspan="2">이미지${status.count}</th>
				                <td colspan="3">
				                  	<input type="hidden" name="originalFileName" value="${item.fileName}"/>
				                   <input type="hidden" name="fileNo" value="${item.fileNo}"/>
				    
				                    <img src="/download?bno=${board.bno}&fileName=${item.fileName}" id="preview${status.count}"  />
				                </td>
				            </tr>
				            <tr>
				                <td colspan="3" style="border-top: none;">	              
				                    <input type="file" name="fileName${status.count}" class="file-input" disabled onchange="readURL(this, 'preview${status.count}')" />
				               
				                </td>
				            </tr>
					</c:forEach>
				</c:if>
	<%-- 			<c:otherwise>
					<tr id="tr_file_upload">
						<td rowspan="2" >이미지</td>
						<td>
						<c:forEach var="item" items="${imageFileList}" varStatus="status">
							<input type="hidden" name="fileName${status.count}" value="${item.fileName}" />
						</c:forEach>
						</td> 						
					</tr>
					<tr>
						<td style="border-top: none;">
						<img id="preview"/><br>
						<input type="file" name="fileName" id="i_fileName" disabled onchange="readURL(this)"/>
						</td>	
					</tr>
				</c:otherwise> --%>
			
			</table> <br><br><br>	
			
			
				<button type="submit" class="btn btn-primary" id="btn_modify" onClick="fn_modify(boardForm)">수정반영</button>
				<button type="button" class="btn btn-primary" id="tr_btn" onClick="fn_enable(this.form)">수정</button>				    					
				<button type="button" class="btn btn-primary" onclick="confirmDelete()">삭제</button>	
				<c:if test="${board.notice_chk eq 1}"><button type="button" class="btn btn-primary" onclick="location.href='/board/reply?bno=${board.bno}&amp;parentNo=${board.bno}&amp;section=${section}&amp;pageNum=${pageNum}'">댓글 달기</button></c:if>		
				<button type="button" class="btn btn-primary" onClick="location.href='/board/list.do?section=${section}&amp;pageNum=${pageNum}'">글 목록</button>			
			
		</div>
	</form>
	
	<!-- 공지사항 댓글창 -->
		<c:if test="${board.notice_chk eq 0}">
	            <div class="comment-box" >                   
	   		        <div class="comment-count">댓글 <span id="count">0</span></div>      
		            <div style="margin-bottom: 10px;">작성자:
					    <div style="display: inline-block;">
					        <input type="text" class="form-control" id="com_writer" placeholder="이름" name="com_writer" style="width: 100px;">
					    </div>
					</div>
	                <div class="comment-sbox" style="margin-bottom: 10px;">
	                    <textarea class="form-control" id="com_content" rows="2" name="com_content" ></textarea>
	                </div>
                    <div class="regBtn"><button id="Comment_regist"> 댓글등록</button></div>
             </div>
             
             <div class="comment_Box" style="border:1px solid gray;"> <!-- 댓글이 들어갈 박스 -->

	          </div>
         </c:if>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<c:set var="total"  value="${totalBoard-1}"  />
<c:set var="section"  value="${section}"  />
<c:set var="pageNum"  value="${pageNum}"  />
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>게시판</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<style type="text/css">
.container{
margin-top: 50px;
padding: 30px;
}
a:link {
  color : black;
}
a:visited {
  color : black;
}
a:hover {
  color : gray;
}
.pagination{display: flex;
        justify-content: center;}
li{text-align: center;}

</style>  

</head>
<body>

<div class="container">
  <h2>게시판</h2><br><br>       
  <table class="table">
    <thead>
      <tr align="center">
        <th>글번호</th>
        <th>제목</th>
        <th>작성자</th>
        <th>작성일</th>
        <th>조회수</th>
      </tr>
    </thead>
		<c:choose>
		    <c:when test="${list == null}">
		        <tr height="5">
		            <td colspan="4">
		                <p align="center">
		                    <b><span style="font-size:9pt;">등록된 글이 없습니다.</span></b>
		                </p>
		            </td>  
		        </tr>
		    </c:when>
				   
		    <c:when test="${notice!=null }">
		    <!-- 공지글 상단표시(페이지 바뀌어도 고정) -->
		     	<c:forEach var="notice" items="${notice}" varStatus="noticeNum">		    
					        <tr align="center">
					              <td width="10%"><img src="/resources/images/notice.png" width="50px" /></td>
				                    <td align='left' width="35%">				                       
				                        <a href="/board/read.do?bno=${notice.bno}&amp;section=${section}&amp;pageNum=${pageNum}">${notice.title}</a>
				                    </td>
				                    <td align='center' width="8%">${notice.writer}</td>
				                    <td width="20%">
				                        <fmt:formatDate value="${notice.writeDate}" pattern="yyyy-MM-dd HH:mm:ss" var="formattedDate" />
				                        ${formattedDate}
				                    </td>
				                    <td width="10%">${notice.hits}</td>
					        </tr>	
				</c:forEach>
				
				<c:forEach var="board" items="${list}" varStatus="status">
					    <tr align="center">					     
					        <td width="10%">${totalBoard-((pageNum-1)*10+(status.index))}</td>
					        <td align="left" width="35%">
					            <c:choose>
					                <c:when test="${board.lvl > 1}">
					                    <!-- 답변 게시물 -->
					                    <c:forEach begin="1" end="${board.lvl}" step="1">
					                        <span style="padding-left:20px"></span>
					                    </c:forEach>
					                    <span><img src="/resources/images/re.png" width="28px" /></span>
					                    <a href="/board/read.do?bno=${board.bno}&amp;section=${section}&amp;pageNum=${pageNum}">${board.title}</a>
					                </c:when>
					                <c:otherwise>
					                    <!-- 일반 게시물 -->					                    
					                    <fmt:formatDate value="<%= new java.util.Date() %>" pattern="d" var="today" />
					                    <fmt:formatDate value="${board.writeDate}" pattern="d" var="regDate" />
					                    <a href="/board/read.do?bno=${board.bno}&amp;section=${section}&amp;pageNum=${pageNum}">${board.title}</a>
					                    <c:if test="${today - regDate <= 2}">
					                        <img src="/resources/images/hit.png" width="28px" />
					                    </c:if>
					                </c:otherwise>
					            </c:choose>
					        </td>
					        <td align="center" width="8%">${board.writer}</td>
					        <td width="20%">
					            <fmt:formatDate value="${board.writeDate}" pattern="yyyy-MM-dd HH:mm:ss" var="formattedDate" />
					            ${formattedDate}
					        </td>
					        <td width="10%">${board.hits}</td>
					    </tr>
				</c:forEach>
		    </c:when>		    	
		</c:choose> 
  </table>
  
<div class="pagination">
  <c:if test="${totalBoard != null }">
  						
	<c:set var="totalPage" value="${totalBoard/10 + 1}" /> <!-- 총 페이지 수 계산 -->
	<c:set var="sectionSize" value="10" /> <!-- 섹션 크기 설정 -->

					<c:choose>
					  <c:when test="${totalPage > 0}">
					 
						    <c:set var="startPage" value="${(section-1)*sectionSize + 1}" /> <!-- 섹션의 시작 페이지 계산 -->
						    <c:set var="endPage" value="${startPage + sectionSize - 1}" /> <!-- 섹션의 끝 페이지 계산 -->
						
						    <!-- 이전 -->
						    <c:if test="${section > 1}">
						      <li class="page-item"><a class="page-link" href="${contextPath }/board/list.do?section=${section-1}&pageNum=${startPage - 1}">&nbsp; 이전</a></li>
						    </c:if>
						
							    <!-- 페이지 링크 -->
							    <c:forEach var="page" begin="${startPage}" end="${endPage}" step="1">
							      <c:if test="${page <= totalPage}">
							        <c:if test="${page == pageNum}">
							        	<li class="page-item active"><a class="page-link" href="${contextPath }/board/list.do?section=${section}&pageNu1m=${page}">${page}</a></li>
							        </c:if>
							        <c:if test="${page != pageNum}">
							          <li class="page-item"><a class="page-link" href="${contextPath }/board/list.do?section=${section}&pageNum=${page}">${page}</a></li>
							        </c:if>
							      </c:if>
							    </c:forEach>
						
							    <!-- 다음 -->
							    <c:if test="${section < totalPage/sectionSize}">
							      <li class="page-item"><a class="page-link" href="${contextPath }/board/list.do?section=${section+1}&pageNum=${endPage + 1}">&nbsp; 다음</a></li>
							    </c:if>
						  </c:when>				    
					   </c:choose>
					</c:if> 
	</div>
	<br>		  
   <div class="btn_right mt15">
      <button type="button" class="btn btn-primary" onclick="location.href='write'" >글쓰기</button>
   </div>
	
</div> 
</body>
</html>

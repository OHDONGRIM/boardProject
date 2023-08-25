package com.practice.board.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.practice.board.vo.BoardVO;
import com.practice.board.vo.CommentVO;
import com.practice.board.vo.ImageVO;

public interface BoardDAO {
	//게시글 목록조회(페이징)
	public List<BoardVO> selectBoardList(Map<String, Object> paging) throws Exception;
	//게시글 공지사항 상단 고정 출력
	public List<BoardVO> selectNoticeList() throws Exception;
	//게시글 입력
	public int add(Map<String, Object> boardMap) throws Exception;
	//이미지 파일 업로드
	public void insertImage(Map<String, Object> boardMap) throws DataAccessException;
	//이미지 파일 수정
	public void updateImage(Map<String, Object> imageMap) throws Exception;
	//댓글 입력
	public void addReply(BoardVO boardVO) throws Exception;
	//게시글 상세화면
	public BoardVO boardDetail(int bno) throws Exception;
	//게시글 조회수
	void updateHits(int bno) throws Exception;
	//게시글 수정
	void updateBoard(BoardVO boardVO) throws Exception;
	//게시글 삭제
	void deleteBoard(int bno) throws Exception;
	//게시물 카운트
	int boardCount() throws Exception;
	//이미지 파일 정보 조회
	public List<ImageVO> selectImageFileBoard(int bno) throws Exception;
	
	
	//공지사항 코멘트
	void commentInsert(CommentVO commnetVO); //댓글 등록
	List<CommentVO> commentList(int com_bno); //목록 요청
	int commentTotal(int com_bno); //댓글 개수

	
 }

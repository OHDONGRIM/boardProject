package com.practice.board.service;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.practice.board.vo.BoardVO;
import com.practice.board.vo.CommentVO;
import com.practice.board.vo.ImageVO;

public interface BoardService {
	List<BoardVO> listBoard(Map<String, Object> paging) throws Exception;
	//게시글 공지사항 상단 고정 출력
	public List<BoardVO>  selectNoticeList() throws Exception;
	int add(Map<String, Object> boardMap) throws Exception;	
	public void addReply(BoardVO boardVO) throws Exception;
	public void insertImage(Map<String, Object> imageMap) throws DataAccessException;
	public Map<String, Object> boardDetail(int bno) throws Exception;
	void updateHits(int bno) throws Exception;
	void updateBoard(BoardVO boardVO) throws Exception;
	void deleteBoard(int bno) throws Exception;
	int boardCount() throws Exception;
	public void updateImage(Map<String, Object> imageMap) throws Exception;
	
	//공지사항 코멘트
	void commentInsert(CommentVO commnetVO); //댓글 등록
	List<CommentVO> commentList(int com_bno); //목록 요청
	int commentTotal(int com_bno); //댓글 개수
	
}

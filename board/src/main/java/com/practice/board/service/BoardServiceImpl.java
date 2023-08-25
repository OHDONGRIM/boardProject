package com.practice.board.service;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import com.practice.board.dao.BoardDAO;
import com.practice.board.vo.BoardVO;
import com.practice.board.vo.CommentVO;
import com.practice.board.vo.ImageVO;

@Service
public class BoardServiceImpl implements BoardService{
	@Autowired
	private BoardDAO dao;
	
	@Override
	public int add(Map<String, Object> boardMap) throws Exception {
		int boardBno=dao.add(boardMap);
		boardMap.put("bno", boardBno);
		dao.insertImage(boardMap);
		
		return boardBno;
	}

	@Override
	public List<BoardVO> listBoard(Map<String, Object> paging) throws Exception {
		int section = (int) paging.get("section");
		int pageNum = (int) paging.get("pageNum");
		
		paging.put("section", section);
		paging.put("pageNum", pageNum);
		
		return dao.selectBoardList(paging);		
	}
	
	@Override
	public List<BoardVO> selectNoticeList() throws Exception {		
		return dao.selectNoticeList();
	}

//	@Override
//	public BoardVO boardDetail(int bno) throws Exception {
//		return dao.boardDetail(bno);		
//	}
	
	@Override
	public Map<String, Object> boardDetail(int bno) throws Exception {
		Map<String, Object> boardMap=new HashMap<>();
		
		BoardVO boardVO=dao.boardDetail(bno);	
		List<ImageVO> imageFileList=dao.selectImageFileBoard(bno);

		boardMap.put("board", boardVO);
		boardMap.put("imageFileList", imageFileList);
		
		return boardMap; 		
	}


	@Override
	public void updateHits(int bno) throws Exception {
		dao.updateHits(bno);
	}

	@Override
	public void updateBoard(BoardVO boardVO) throws Exception {
		dao.updateBoard(boardVO);
	}

	@Override
	public void deleteBoard(int bno) throws Exception {
		dao.deleteBoard(bno);
	}

	@Override
	public void addReply(BoardVO boardVO) throws Exception {
		dao.addReply(boardVO);;
	}

	@Override
	public int boardCount() throws Exception {
		return dao.boardCount();
	}

	@Override
	public void updateImage(Map<String, Object> imageMap) throws Exception {		
		dao.updateImage(imageMap);
		System.out.println("이미지 업데이트 service");
	}

	@Override
	public void insertImage(Map<String, Object> imageMap) throws DataAccessException {
		dao.insertImage(imageMap);
	}

	@Override
	public void commentInsert(CommentVO commnetVO) {
		dao.commentInsert(commnetVO);
	}

	@Override
	public List<CommentVO> commentList(int com_bno) {
		return dao.commentList(com_bno);
	}

	@Override
	public int commentTotal(int com_bno) {
		return dao.commentTotal(com_bno);
	}

}

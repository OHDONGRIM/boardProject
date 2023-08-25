package com.practice.board.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.practice.board.vo.BoardVO;
import com.practice.board.vo.CommentVO;
import com.practice.board.vo.ImageVO;

@Repository
public class BoardDAOImpl implements BoardDAO{
	@Autowired 
	private SqlSession sqlSession;
	
	@Override
	public List<BoardVO> selectBoardList(Map<String, Object> paging) throws Exception {
		return sqlSession.selectList("boardMapper.listPaging", paging);				
	}
	
	@Override
	public List<BoardVO> selectNoticeList() throws Exception {
		return sqlSession.selectList("boardMapper.notice");
	}
	
	@Override
	public int add(Map<String, Object> boardMap) throws Exception {
		sqlSession.insert("boardMapper.insert", boardMap);
		int boardBno = Integer.parseInt(String.valueOf(boardMap.get("bno")));
		
		boardMap.put("bno", boardBno);		
		return boardBno;
	}

	@Override
	public void insertImage(Map<String, Object> boardMap) throws DataAccessException {
		List<ImageVO> imageFileList=(List<ImageVO>) boardMap.get("imageFileList");
		
		int boardBno=(Integer)boardMap.get("bno");
		int imageFileNo=selectNewImageFileNo();
		
		for(ImageVO imageVO : imageFileList) {
			imageVO.setFileNo(++imageFileNo);
			imageVO.setBno(boardBno);
		}

		sqlSession.insert("boardMapper.insertImage", imageFileList);
	}
	
	@Override
	public BoardVO boardDetail(int bno) throws Exception{
		return sqlSession.selectOne("boardMapper.boardDetail", bno);
	}

	@Override
	public void updateHits(int bno) throws Exception {
		sqlSession.update("boardMapper.boardHits", bno);
	}

	@Override
	public void updateBoard(BoardVO boardVO) throws Exception {
		sqlSession.update("boardMapper.boardUpdate", boardVO);
	}

	@Override
	public void deleteBoard(int bno) throws Exception {
		sqlSession.delete("boardMapper.boardDelete", bno);
	}

	@Override
	public void addReply(BoardVO boardVO) throws Exception {
		sqlSession.insert("boardMapper.insertReply", boardVO);		
	}

	@Override
	public int boardCount() throws Exception {
		return sqlSession.selectOne("boardMapper.totalBoard");
	}

	private int selectNewImageFileNo() throws DataAccessException{
		return sqlSession.selectOne("boardMapper.selectFileNo");
	}

	@Override
	public List<ImageVO> selectImageFileBoard(int bno) throws Exception {
		return sqlSession.selectList("boardMapper.selectImageFileList", bno);
	}

	@Override 
	public void updateImage(Map<String, Object> imageMap) throws Exception {
		sqlSession.update("boardMapper.updateImageList", imageMap);
		System.out.println("이미지 업데이트 DAO");
	}

	//공지 코멘트
	@Override
	public void commentInsert(CommentVO commnetVO) {
		sqlSession.insert("boardMapper.commentInsert", commnetVO);
	}

	@Override
	public List<CommentVO> commentList(int com_bno) {
		return sqlSession.selectList("boardMapper.commentList", com_bno);
	}

	@Override
	public int commentTotal(int com_bno) {
		return sqlSession.selectOne("boardMapper.commentTotal", com_bno);
	}

}

package com.spring.board.dao.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.board.dao.BoardDao;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.CodeVo;
import com.spring.board.vo.PageVo;
import com.spring.board.vo.UserInfoVo;

@Repository
public class BoardDaoImpl implements BoardDao{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public String selectTest() throws Exception {
		// TODO Auto-generated method stub
		
		String a = sqlSession.selectOne("board.boardList");
		
		return a;
	}
	/**
	 * 
	 * */
	@Override
	public List<BoardVo> selectBoardList(PageVo pageVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("board.boardList",pageVo);
	}
	
	@Override
	public int selectBoardCnt(PageVo pageVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("board.boardTotal", pageVo);
	}

	@Override
	public BoardVo selectBoard(BoardVo boardVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("board.boardView", boardVo);
	}
	
	@Override
	public int boardInsert(BoardVo boardVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.insert("board.boardInsert", boardVo);
	}
	@Override
	public int boardDelete(BoardVo boardVo) throws Exception{
		// TODO Auto-generated method stub
		return sqlSession.delete("board.boardDelete", boardVo);
	}
	@Override
	public int boardUpdate(BoardVo boardVo) throws Exception{
		// TODO Auto-generated method stub
		return sqlSession.update("board.boardUpdate", boardVo);
	}
	@Override
	public List<BoardVo> boardCheck(BoardVo boardVo) throws Exception{
		// TODO Auto-generated method stub
		return sqlSession.selectList("board.boardCheck", boardVo);
	}
	@Override
	public List<BoardVo> boardCheckList(String[] boardType) throws Exception{
		// TODO Auto-generated method stub
		return sqlSession.selectList("board.boardCheckList", boardType);
	}
	@Override
	public int selectBoardCheckCnt(String[] boardType) throws Exception{
		// TODO Auto-generated method stub
		return sqlSession.selectOne("board.boardCheckCnt", boardType);
	}
	
	@Override
	public List<CodeVo> selectBoardTypeList(String codeType) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("board.selectBoardTypeList", codeType);
	}
	
	@Override
	public int insertUserInfo(UserInfoVo userInfo) {
		// TODO Auto-generated method stub
		return sqlSession.insert("board.insertUserInfo", userInfo);
	}
	@Override
	public int selectUserId(String userId) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("board.selectUserId", userId);
	}
	@Override
	public List<CodeVo> selectPhoneNoList() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("board.selectPhoneNoList");
	}
	@Override
	public UserInfoVo selectUserInfo(UserInfoVo userInfo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("board.selectUserInfo", userInfo);
	}
	@Override
	public List<UserInfoVo> selectCreatorName() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("board.selectCreatorName");
	}
	
}

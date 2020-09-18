package com.spring.board.service.impl;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.board.dao.BoardDao;
import com.spring.board.service.boardService;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.CodeVo;
import com.spring.board.vo.PageVo;
import com.spring.board.vo.UserInfoVo;

@Service
public class boardServiceImpl implements boardService{
	
	@Autowired
	BoardDao boardDao;
	
	@Override
	public String selectTest() throws Exception {
		// TODO Auto-generated method stub
		return boardDao.selectTest();
	}
	
	@Override
	public List<BoardVo> SelectBoardList(PageVo pageVo, String boardType) throws Exception {
		// TODO Auto-generated method stub
		if(boardType.equals("all") || boardType.equals("")) {
			String[] checkTypeList = null;
			pageVo.setCheckTypeList(checkTypeList);
			
			return boardDao.selectBoardList(pageVo);
		}
		else {
			String[] checkTypeList = boardType.split(",");
			pageVo.setCheckTypeList(checkTypeList);
			
			return boardDao.selectBoardList(pageVo);
		}
		
	}
	
	@Override
	public int selectBoardCnt(PageVo pageVo, String boardType) throws Exception {
		if(boardType.equals("all") || boardType.equals("")) {
			String[] checkTypeList = null;
			pageVo.setCheckTypeList(checkTypeList);
			
			return boardDao.selectBoardCnt(pageVo);
		}
		else {
			String[] checkTypeList = boardType.split(",");
			pageVo.setCheckTypeList(checkTypeList);
			
			return boardDao.selectBoardCnt(pageVo);
		}
	}
	
	@Override
	public BoardVo selectBoard(String boardType, int boardNum) throws Exception {
		// TODO Auto-generated method stub
		BoardVo boardVo = new BoardVo();
		
		boardVo.setBoardType(boardType);
		boardVo.setBoardNum(boardNum);
		
		return boardDao.selectBoard(boardVo);
	}
	
	@Override
	public int boardInsert(BoardVo boardVo) throws Exception {
		// TODO Auto-generated method stub
		return boardDao.boardInsert(boardVo);
	}

	@Override
	public int boardDelete(BoardVo boardVo) throws Exception {
		// TODO Auto-generated method stub
		return boardDao.boardDelete(boardVo);
	}

	@Override
	public int boardUpdate(BoardVo boardVo) throws Exception{
		// TODO Auto-generated method stub
		return boardDao.boardUpdate(boardVo);
	}

	@Override
	public List<BoardVo> boardCheck(BoardVo boardVo) throws Exception{
		// TODO Auto-generated method stub
		return boardDao.boardCheck(boardVo);
	}

	@Override
	public List<BoardVo> boardCheckList(String boardType1) throws Exception{
		// TODO Auto-generated method stub
		String[] boardType = boardType1.split(",");
		System.out.println(boardType+"====== boardType");
		
		return boardDao.boardCheckList(boardType);
	}

	@Override
	public int selectBoardCheckCnt(String boardType1) throws Exception {
		// TODO Auto-generated method stub
		String[] boardType = boardType1.split(",");
		System.out.println(boardType+"====== boardType");
		return boardDao.selectBoardCheckCnt(boardType);
	}

	@Override
	public List<CodeVo> selectBoardTypeList(String codeType) throws Exception {
		// TODO Auto-generated method stub
		return boardDao.selectBoardTypeList(codeType);
	}

	@Override
	public int insertUserInfo(UserInfoVo userInfo) throws Exception{
			
		return boardDao.insertUserInfo(userInfo);
	}

	@Override
	public int selectUserId(String userId) throws Exception{
		// TODO Auto-generated method stub
		return boardDao.selectUserId(userId);
	}

	@Override
	public List<CodeVo> selectPhoneNoList() throws Exception{
		// TODO Auto-generated method stub
		return boardDao.selectPhoneNoList();
	}

	@Override
	public UserInfoVo selectUserInfo(UserInfoVo userInfo, String userId, String userPw) throws Exception{
		// TODO Auto-generated method stub
		userInfo.setUserId(userId);
		userInfo.setUserPw(userPw);
		return boardDao.selectUserInfo(userInfo);
	}

	@Override
	public List<UserInfoVo> selectCreatorName() throws Exception{
		// TODO Auto-generated method stub
		return boardDao.selectCreatorName();
	}


	
}

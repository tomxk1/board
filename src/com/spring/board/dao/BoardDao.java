package com.spring.board.dao;

import java.util.List;
import java.util.Map;

import com.spring.board.vo.BoardVo;
import com.spring.board.vo.CodeVo;
import com.spring.board.vo.PageVo;
import com.spring.board.vo.UserInfoVo;

public interface BoardDao {

	public String selectTest() throws Exception;

	public List<BoardVo> selectBoardList(PageVo pageVo) throws Exception;

	public BoardVo selectBoard(BoardVo boardVo) throws Exception;

	public int selectBoardCnt(PageVo pageVo) throws Exception ;

	public int boardInsert(BoardVo boardVo) throws Exception;

	public int boardDelete(BoardVo boardVo) throws Exception;

	public int boardUpdate(BoardVo boardVo) throws Exception;

	public List<BoardVo> boardCheck(BoardVo boardVo) throws Exception;

	public List<BoardVo> boardCheckList(String[] boardType) throws Exception;

	public int selectBoardCheckCnt(String[] boardType) throws Exception;

	public List<CodeVo> selectBoardTypeList(String codeType) throws Exception;

	public int insertUserInfo(UserInfoVo userInfo);

	public int selectUserId(String userId);

	public List<CodeVo> selectPhoneNoList();

	public UserInfoVo selectUserInfo(UserInfoVo userInfo);

	public List<UserInfoVo> selectCreatorName();

}

package com.spring.board.service;

import java.util.List;
import java.util.Map;

import com.spring.board.vo.BoardVo;
import com.spring.board.vo.CodeVo;
import com.spring.board.vo.PageVo;
import com.spring.board.vo.UserInfoVo;

public interface boardService {

	public String selectTest() throws Exception;

	public List<BoardVo> SelectBoardList(PageVo pageVo, String boardType) throws Exception;

	public BoardVo selectBoard(String boardType, int boardNum) throws Exception;

	public int selectBoardCnt(PageVo pageVo, String boardType) throws Exception;

	public int boardInsert(BoardVo boardVo) throws Exception;

	public int boardDelete(BoardVo boardVo) throws Exception;

	public int boardUpdate(BoardVo boardVo) throws Exception;

	public List<BoardVo> boardCheck(BoardVo boardVo) throws Exception;

	public List<BoardVo> boardCheckList(String boardType) throws Exception;

	public int selectBoardCheckCnt(String boardType) throws Exception;

	public List<CodeVo> selectBoardTypeList(String codeType) throws Exception;

	public int insertUserInfo(UserInfoVo userInfo) throws Exception;

	public int selectUserId(String userId) throws Exception;

	public List<CodeVo> selectPhoneNoList() throws Exception;

	public UserInfoVo selectUserInfo(UserInfoVo userInfo, String userId, String userPw) throws Exception;

	public List<UserInfoVo> selectCreatorName() throws Exception;

}

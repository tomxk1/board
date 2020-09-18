package com.spring.board.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.board.HomeController;
import com.spring.board.service.boardService;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.CodeVo;
import com.spring.board.vo.PageVo;
import com.spring.board.vo.UserInfoVo;
import com.spring.common.CommonUtil;

@Controller
public class BoardController {
	
	@Autowired
	boardService boardService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value = "/board/boardList.do", method = RequestMethod.GET)
	public String boardList(Locale locale, Model model,
		@RequestParam(value="boardType", required=false, defaultValue="all")String boardType,
		PageVo pageVo, BoardVo boardVo) throws Exception{
		
			String codeType = "menu";
			List<CodeVo> boardTypeList = new ArrayList<CodeVo>();
			boardTypeList = boardService.selectBoardTypeList(codeType);
			model.addAttribute("boardTypeList", boardTypeList);//type List
			
			List<BoardVo> boardList = new ArrayList<BoardVo>();
			
			int page = 1;
			
			
			
		if(pageVo.getPageNo() == 0){
			pageVo.setPageNo(page);
		}
		
		System.out.println("boardType=="+boardType);
		boardList = boardService.SelectBoardList(pageVo, boardType);
		int totalCnt = boardService.selectBoardCnt(pageVo, boardType);
		
		model.addAttribute("boardList", boardList);
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("pageNo", page);
		
		return "board/boardList";
	}
	
    @RequestMapping(value = "/board/boardListAction.do"
    		, produces = "application/json; charset=utf-8", method = RequestMethod.POST)
    @ResponseBody
 	public String boardListAction(Locale locale, BoardVo boardVo,
 			@RequestParam(value="boardType", required=false, defaultValue="all")String boardType,
 			PageVo pageVo)throws Exception {
    	String codeType = "menu";
    	
    	CommonUtil commonUtil = new CommonUtil();
		
    	int page = 1;
		
		if(pageVo.getPageNo() == 0){
			pageVo.setPageNo(page);
		}
		List<CodeVo> boardTypeList = new ArrayList<CodeVo>();
		
    	List<BoardVo> boardList = new ArrayList<BoardVo>();
    	
		boardTypeList = boardService.selectBoardTypeList(codeType);
		
		boardList = boardService.SelectBoardList(pageVo, boardType);
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		int totalCnt = boardService.selectBoardCnt(pageVo, boardType);
		
		result.put("boardList", boardList);
		result.put("totalCntInt", totalCnt);
		result.put("boardTypeList", boardTypeList);
		//json 방식
    	String callbackMsg = commonUtil.getJsonCallBackString(" ", result);
    	
        return callbackMsg;
    }
    
    @RequestMapping(value = "/board/boardListHtml.do", method = RequestMethod.GET)
 	public String boardListActionHtml(Locale locale, BoardVo boardVo, Model model,
 			@RequestParam(value="boardType", required=false, defaultValue="all")String boardType,
 			PageVo pageVo)throws Exception {
    	
    	return "board/boardListHtml";
    	
    }

	@RequestMapping(value = "/board/{boardType}/{boardNum}/boardView.do", method = RequestMethod.GET)
	public String boardView(Locale locale, Model model
			,@PathVariable("boardType")String boardType
			,@PathVariable("boardNum")int boardNum) throws Exception{
		
		BoardVo boardVo = new BoardVo();
		
		boardVo = boardService.selectBoard(boardType,boardNum);
		
		List<UserInfoVo> creatorName = boardService.selectCreatorName();
		
		model.addAttribute("creatorName", creatorName);
		model.addAttribute("boardType", boardType);
		model.addAttribute("boardNum", boardNum);
		model.addAttribute("board", boardVo);
		
		return "board/boardView";
	}
	
	@RequestMapping(value = "/board/boardWrite.do", method = RequestMethod.GET)
	public String boardWrite(Locale locale, Model model) throws Exception{
		List<CodeVo> boardTypeList = new ArrayList<CodeVo>();
		String codeType = "menu";
		boardTypeList = boardService.selectBoardTypeList(codeType);
		List<UserInfoVo> creatorName = boardService.selectCreatorName();
		model.addAttribute("creatorName", creatorName);
		model.addAttribute("boardTypeList", boardTypeList);
		
		return "board/boardWrite";
	}
	
	@RequestMapping(value = "/board/boardWriteAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String boardWriteAction(Locale locale,BoardVo boardVo) throws Exception{
		
		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		
		int resultCnt = boardService.boardInsert(boardVo);
		
		result.put("success", (resultCnt > 0)?"Y":"N");
		String callbackMsg = commonUtil.getJsonCallBackString(" ",result);
		
		System.out.println("callbackMsg::"+callbackMsg);
		
		return callbackMsg;
	}
	
	
	@RequestMapping(value = "/board/boardDeleteAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String boardDelete(Locale locale, BoardVo boardVo) throws Exception{
		
		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		
		int	result1 = boardService.boardDelete(boardVo);
		
		result.put("success", (result1 > 0)?"Y":"N");
		String callbackMsg = commonUtil.getJsonCallBackString(" ",result);
		
		System.out.println("callbackMsg::"+callbackMsg);
		
		return callbackMsg;
	}
	
	
	@RequestMapping(value = "/board/{boardType}/{boardNum}/boardUpdate.do", method = RequestMethod.GET)
	public String boardUpdate( Locale locale, Model model
			,@PathVariable("boardType")String boardType
			,@PathVariable("boardNum")int boardNum
			) throws Exception{
		
		BoardVo boardVo = new BoardVo();
		List<UserInfoVo> creatorName = boardService.selectCreatorName();
		
		boardVo = boardService.selectBoard(boardType, boardNum);
		
		model.addAttribute("creatorName", creatorName);
		model.addAttribute("boardType", boardType);
		model.addAttribute("boardNum", boardNum);
		model.addAttribute("board", boardVo);
		
		return "board/boardUpdate";
	}
	
	@RequestMapping(value = "/board/boardUpdateAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String boardUpdateAction(Locale locale, BoardVo boardVo) throws Exception{
		
		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		
		int resultCnt = boardService.boardUpdate(boardVo);
		
		result.put("success", (resultCnt > 0)?"Y":"N");
		String callbackMsg = commonUtil.getJsonCallBackString(" ",result);
		
		System.out.println("callbackMsg::"+callbackMsg);
		
		return callbackMsg;
	}
	
	
	@RequestMapping(value="/board/join.do", method = RequestMethod.GET)
	public String join(Locale locale,  Model model) throws Exception{
		String codeType = "phone";
		List<CodeVo> phoneNoList = new ArrayList<CodeVo>();
		
		phoneNoList = boardService.selectBoardTypeList(codeType);
		//phone
		model.addAttribute("phoneNoList", phoneNoList);
		return "board/join";
	}
	
	@RequestMapping(value="/board/joinAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String joinAction(Locale locale, UserInfoVo userInfo) throws Exception{
		
		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		
		int resultCnt = boardService.insertUserInfo(userInfo);
		
		result.put("success", (resultCnt > 0)?"Y":"N");
		String callbackMsg = commonUtil.getJsonCallBackString(" ",result);
		
		System.out.println("callbackMsg::"+callbackMsg);
		
		return callbackMsg;
	}
	
	@RequestMapping(value="/board/idAction.do", method = RequestMethod.POST)
	@ResponseBody
	public int idAction(Locale locale,
			@RequestParam(value="userId")String userId) throws Exception{
		
		System.out.println("userId==="+userId);
		int resultStr = boardService.selectUserId(userId);
		System.out.println("resultStr==="+resultStr);
		
		return resultStr;
	}
	
	@RequestMapping(value="/board/login.do", method = RequestMethod.GET)
	public String login(Locale locale,  Model model) throws Exception{
		
		return "board/login";
	}
	
	@RequestMapping(value="/board/loginAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String loginAction(Locale locale, UserInfoVo userInfo
			,@RequestParam(value="userId")String userId
			,@RequestParam(value="userPw")String userPw
			,HttpSession session) throws Exception{
		
		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		UserInfoVo userInfoResult = boardService.selectUserInfo(userInfo, userId, userPw);
		int resultStr = boardService.selectUserId(userId);
		System.out.println(userInfo);
		if(userInfo != null) {
			session.setAttribute("userInfo", userInfoResult);//세션에 저장
			result.put("success", "login");
			System.out.println(userId+"==userId");
			System.out.println(session.getAttribute("userInfo")+"-====session");
		}
		else {
			result.put("fail", "no login");
			if(resultStr == 0) {
				result.put("id", "id fail");
			}
			else {
				result.put("password", "password fail");
			}
		}
		
		String callbackMsg = commonUtil.getJsonCallBackString(" ", result);
		
		return callbackMsg;
	}
	
	@RequestMapping(value="/board/logOut.do", method = RequestMethod.GET)
	public String logOut(HttpSession session) throws Exception{
		
		if(session.getAttribute("userInfo") != null){
			session.removeAttribute("userInfo");
		}
		return "redirect:/board/boardList.do";
	}
	
	@RequestMapping(value="/board/chat.do", method = RequestMethod.GET)
	public String chat(Locale locale)throws Exception{
		
		return "board/chat";
	}
	
	@RequestMapping(value="/board/chatAction.do", method = RequestMethod.POST)
	   @ResponseBody
	public String chatAction(Locale locale,
			@RequestParam(value="chat")String chat
			,@RequestParam(value="userId")String userId) throws Exception{
		
		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		System.out.println("chat="+chat);
		System.out.println("userId="+userId);
		result.put("chat", chat);
		result.put("userId", userId);
		
		String callbackMsg = commonUtil.getJsonCallBackString(" ", result);
		System.out.println("callbackMsg= "+callbackMsg);
		return callbackMsg;
	}
	
}

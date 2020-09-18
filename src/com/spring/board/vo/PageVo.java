package com.spring.board.vo;

public class PageVo {
	
	private int pageNo = 1;
	
	private String[] checkTypeList;
	

	public String[] getCheckTypeList() {
		return checkTypeList;
	}

	public void setCheckTypeList(String[] checkTypeList) {
		this.checkTypeList = checkTypeList;
	}

	public int getPageNo() {
		return pageNo;
	}

	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}



}

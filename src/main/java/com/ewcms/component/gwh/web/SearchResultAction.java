/**
 * Copyright (c)2010-2011 Enterprise Website Content Management System(EWCMS), All rights reserved.
 * EWCMS PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 * http://www.ewcms.com
 */
package com.ewcms.component.gwh.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.ewcms.component.gwh.service.GwhSerivceable;
import com.ewcms.component.gwh.vo.ArticleVO;
import com.opensymphony.xwork2.ActionSupport;

public class SearchResultAction extends ActionSupport {

	private static final long serialVersionUID = 5620904180672350549L;

	private String beginDate;
	private String endDate;
	private String searchChannel;
	private String searchRange;
	private String searchKey;
	private List<ArticleVO> articleList;
	
	@Autowired
	private GwhSerivceable gwhService;
	
	private final static int DEFAULT_ROW = 20;

	protected int pageNumber;
	protected int row = DEFAULT_ROW;
	protected Page page;

	public int getPageNumber() {
		return pageNumber;
	}

	public void setPageNumber(int pageNumber) {
		this.pageNumber = pageNumber;
	}

	public Page getPage() {
		return page;
	}

	public void setPage(Page page) {
		this.page = page;
	}

	public List<ArticleVO> getArticleList() {
		return articleList;
	}

	public void setArticleList(List<ArticleVO> articleList) {
		this.articleList = articleList;
	}

	public String getBeginDate() {
		return beginDate;
	}

	public void setBeginDate(String beginDate) {
		this.beginDate = beginDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getSearchChannel() {
		return searchChannel;
	}

	public void setSearchChannel(String searchChannel) {
		this.searchChannel = searchChannel;
	}

	public String getSearchRange() {
		return searchRange;
	}

	public void setSearchRange(String searchRange) {
		this.searchRange = searchRange;
	}

	public String getSearchKey() {
		return searchKey;
	}

	public void setSearchKey(String searchKey) {
		this.searchKey = searchKey;
	}

	@Override
	public String execute() throws Exception {
		this.setArticleList(gwhService.findGwhArticleList(beginDate, endDate,
				searchChannel, searchRange, searchKey));
		page = new Page.Builder(articleList.size(), pageNumber + 1)
				.setPageSize(row).build();
		return super.execute();
	}
}

/**
 * Copyright (c)2010-2011 Enterprise Website Content Management System(EWCMS), All rights reserved.
 * EWCMS PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 * http://www.ewcms.com
 */
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ewcms.component.query.web;

import com.ewcms.component.online.web.PageAction;
import com.ewcms.component.query.dao.QueryDAOable;
import com.ewcms.component.query.vo.Article;
import com.ewcms.component.util.StringToNumber;
import com.ewcms.component.vo.Page;

import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

/**
 *
 * @author wuzhijun
 */
@Controller("com.ewcms.component.query.web.AdvQueryAction")
public class AdvQueryAction extends PageAction {

	private static final long serialVersionUID = 1432726819498438699L;

	private final static int DEFAULT_ROW = 10;
    protected List<Article> articles = new ArrayList<Article>();
	private String title;
	private Integer channelId;
	private String beginDate;
	private String endDate;
	private Boolean isContent = false; 
    
    @Autowired
    protected QueryDAOable queryDAO;

    public List<Article> getArticles() {
		return articles;
	}

	public void setArticles(List<Article> articles) {
		this.articles = articles;
	}
	
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public Integer getChannelId() {
		return channelId;
	}

	public void setChannelId(Integer channelId) {
		this.channelId = channelId;
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

	public Boolean getIsContent() {
		return isContent;
	}

	public void setIsContent(Boolean isContent) {
		this.isContent = isContent;
	}

	@SuppressWarnings("unchecked")
	@Override
    public String execute() {
		row = DEFAULT_ROW;
		List<Article> articleAlls = queryDAO.findArtilce(title, channelId, beginDate, endDate, isContent);
		Integer iPageNumber = 0;
		try{
			iPageNumber = StringToNumber.ToInteger(pageNumber);
		}catch(Exception e){
		}

		page = new Page.Builder(articleAlls.size(), iPageNumber + 1).setPageSize(row).build();
		articles = pageList(articleAlls, page);
        return SUCCESS;
    }
}

/**
 * Copyright (c)2010-2011 Enterprise Website Content Management System(EWCMS), All rights reserved.
 * EWCMS PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 * http://www.ewcms.com
 */
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ewcms.component.online.web;

import com.ewcms.component.online.service.OnlineService;
import com.ewcms.component.online.vo.Article;
import com.ewcms.component.online.vo.Working;
import com.ewcms.component.util.StringToNumber;
import com.opensymphony.xwork2.ActionSupport;

import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;

/**
 *
 * @author wangwei
 */
public class ArticleAction extends ActionSupport {

	private static final long serialVersionUID = -4584114686737430118L;
	
	private Working working = new Working();
    private String organId;
    private String workingId;
    private String childId;
    private List<Article> articles = new ArrayList<Article>();
    @Autowired
    private OnlineService service;

    public String getChildId() {
        return childId;
    }

    public void setChildId(String childId) {
        this.childId = childId;
    }

    public String getOrganId() {
        return organId;
    }

    public void setOrganId(String organId) {
        this.organId = organId;
    }

    public String getWorkingId() {
        return workingId;
    }

    public void setWorkingId(String workingId) {
        this.workingId = workingId;
    }

    public List<Article> getArticles() {
        return articles;
    }

    public Working getWorking() {
        return working;
    }

    public List<Working> getPosition() {
    	try{
    		Integer iWorkingId = StringToNumber.ToInteger(workingId);
    		return service.getWorkingPosition(iWorkingId);
    	}catch(Exception e){
    		return new ArrayList<Working>();
    	}
    }

    @Override
    public String execute() {
    	try{
    		Integer iChildId = StringToNumber.ToInteger(childId);
    		Integer iWorkingId = StringToNumber.ToInteger(workingId);
    		articles = service.findAtricleByWorkingId(iChildId);
    		working = service.getWorking(iWorkingId);
    	}catch(Exception e){
    	}
        return SUCCESS;
    }
}

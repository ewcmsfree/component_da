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
import com.ewcms.component.online.vo.Advisor;
import com.ewcms.component.online.vo.Working;
import com.ewcms.component.util.StringToNumber;
import com.ewcms.component.vo.Page;

import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

/**
 *
 * @author wangwei
 */
@Controller
public class AdvisorSearchAction extends PageAction {

	private static final long serialVersionUID = 6887179447170182042L;

	private String organId;
    private String workingId;
    private String title;
    private List<Advisor> advisors = new ArrayList<Advisor>();
    @Autowired
    private OnlineService service;

    public String getOrganId() {
        return organId;
    }

    public void setOrganId(String organId) {
        this.organId = organId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public List<Advisor> getAdvisors() {
        return advisors;
    }

    public String getWorkingId() {
        return workingId;
    }

    public void setWorkingId(String workingId) {
        this.workingId = workingId;
    }

    public Working getWorking() {
    	try{
    		Integer iWorkingId = StringToNumber.ToInteger(workingId);
    		return service.getWorking(iWorkingId);
    	}catch(Exception e){
    		return new Working();
    	}
    }

    public List<Working> getPosition() {
    	try{
    		Integer iWorkingId = StringToNumber.ToInteger(workingId);
    		return service.getWorkingPosition(iWorkingId);
    	}catch(Exception e){
    		return new ArrayList<Working>();
    	}
    }

    @SuppressWarnings("unchecked")
	@Override
    public String execute() {
    	try{
    		Integer iWorkingId = StringToNumber.ToInteger(workingId);
	        Integer matterId = service.getMatterId(iWorkingId);
	        if (matterId != null) {
	        	Integer iPageNumber = 0;
	        	try{
	        		iPageNumber = StringToNumber.ToInteger(pageNumber);
	        	}catch(Exception e){
	        	}
	            List<Advisor> all = service.findAdvisorByMatter(matterId, title);
	            page = new Page.Builder(all.size(), iPageNumber + 1).setPageSize(row).build();
	            advisors = pageList(all, page);
	        }
    	}catch(Exception e){}
        return SUCCESS;
    }
}

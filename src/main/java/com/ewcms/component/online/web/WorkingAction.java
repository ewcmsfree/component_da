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
import com.ewcms.component.online.vo.Citizen;
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
public class WorkingAction extends PageAction {

	private static final long serialVersionUID = 5072257413099687428L;

	private static final int DEFAULT_ROW = 12;
    private String workingId;
    private String parentId;
    private Working working = new Working();
    private Working parent = new Working();
    private List<Working> workings = new ArrayList<Working>();
    private List<Working> matters = new ArrayList<Working>();
    private List<Working> parents = new ArrayList<Working>();
    
    @Autowired
    private OnlineService service;

    public Working getParent() {
        return parent;
    }

    public String getParentId() {
        return parentId;
    }

    public void setParentId(String parentId) {
        this.parentId = parentId;
    }

    public String getWorkingId() {
        return workingId;
    }

    public void setWorkingId(String workingId) {
        this.workingId = workingId;
    }

    public Working getWorking() {
        return working;
    }

    public List<Working> getWorkings() {
        return workings;
    }

    public void setOnlineService(OnlineService service) {
        this.service = service;
    }

    public List<Citizen> getCitizens() {
        return service.getCitizenAll();
    }

    public List<Working> getMatters() {
        return this.matters;
    }

    public List<Working> getParents() {
        return parents;
    }
    
    @SuppressWarnings("unchecked")
	@Override
    public String execute() {
        row = DEFAULT_ROW;
        try{
	        Integer iParentId = StringToNumber.ToInteger(parentId);
	        parents = service.getWorkingChilren(null);
	        this.parent = service.getWorking(iParentId);
	        parents.remove(parent);
	        this.workings = service.getWorkingChilren(iParentId);
	        if (workings.isEmpty()) {
	            return SUCCESS;
	        }
        }catch(Exception e){
        }
        
        try{
        	Integer iWorkingId;
        	if (workingId == null){
        		iWorkingId = workings.get(0).getId();
        	}else{
        		iWorkingId = StringToNumber.ToInteger(workingId); 
        	}
        	setWorkingId(String.valueOf(iWorkingId));
	        working = service.getWorking(iWorkingId);
	
	        List<Working> matterAll = service.getMatterChildren(iWorkingId);
	        Integer iPageNumber = 0;
	        try{
	        	iPageNumber = StringToNumber.ToInteger(pageNumber);
	        }catch(Exception e){}
	        page = new Page.Builder(matterAll.size(), iPageNumber + 1).setPageSize(row).build();
	        matters = pageList(matterAll, page);
        }catch(Exception e){
        }
        return SUCCESS;
    }
}

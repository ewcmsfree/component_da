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
import com.ewcms.component.online.vo.Matter;
import com.ewcms.component.online.vo.Working;
import com.ewcms.component.util.StringToNumber;
import com.opensymphony.xwork2.ActionSupport;

import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

/**
 *
 * @author wangwei
 */
@Controller
public class MatterAction extends ActionSupport{

	private static final long serialVersionUID = 2326960346830541551L;

	private Working working = new Working();
    private Matter matter = new Matter();
    private String organId;
    private String workingId;
    private List<Working> workings = new ArrayList<Working>();
    private List<Working> position = new ArrayList<Working>();
    
    @Autowired
    private OnlineService service;

    public Working getWorking() {
        return working;
    }

    public Matter getMatter() {
        return matter;
    }

    public String getWorkingId() {
        return workingId;
    }

    public void setWorkingId(String workingId) {
        this.workingId = workingId;
    }

    public String getOrganId() {
        return organId;
    }

    public void setOrganId(String organId) {
        this.organId = organId;
    }

    public List<Working> getWorkings() {
        return workings;
    }

    public List<Working> getPosition() {
        return position;
    }

    @Override
    public String execute(){
    	try{
    		Integer iWorkingId = StringToNumber.ToInteger(workingId);
	        position = service.getWorkingPosition(iWorkingId);
	        Integer  matterId = service.getMatterId(iWorkingId);
	        if(matterId != null){
	            this.matter = service.getMatter(matterId);
	            this.working = service.getWorking(iWorkingId);
	        }
    	}catch(Exception e){}
        return SUCCESS;
    }
}

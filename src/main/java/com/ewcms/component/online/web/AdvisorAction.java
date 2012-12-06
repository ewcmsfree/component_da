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

import com.ewcms.component.auth.AuthUtil;
import com.ewcms.component.auth.vo.User;
import com.ewcms.component.auth.web.LoginAction;
import com.ewcms.component.online.service.OnlineService;
import com.ewcms.component.online.vo.Advisor;
import com.ewcms.component.online.vo.Working;
import com.ewcms.component.util.StringToNumber;
import com.ewcms.component.util.Struts2Util;

import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

/**
 *
 * @author wangwei
 */
@Controller
public class AdvisorAction extends LoginAction {

	private static final long serialVersionUID = 5026276432881452389L;

	private String workingId;
    private String organId;
    private Advisor advisor = new Advisor();
    @Autowired
    private OnlineService service;

    
    public Advisor getAdvisor() {
        return advisor;
    }

    public void setAdvisor(Advisor advisor){
        this.advisor = advisor;
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

    public boolean isLogin() {
        return AuthUtil.isLogin();
    }

    public User getUser() {
        return AuthUtil.getUser();
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

    @Override
    public String execute() {
        if (isLogin()) {
            if (!this.validateCheckcode()) {
                this.addActionError("验证码错误！");
                super.setCheckcode("");
                return INPUT;
            }
        } else {
            if (!login()) {
                return INPUT;
            }
        }
        try{
        	Integer iWorkingId = StringToNumber.ToInteger(workingId);
        	Integer iOrganId = StringToNumber.ToInteger(organId);
	        int matterId =  this.service.getMatterId(iWorkingId);
	        advisor.setMatterId(matterId);
	        advisor.setOrganId(iOrganId);
	        advisor.setUsername(getUser().getUsername());
	        advisor.setName(getUser().getName());
	        advisor.setIp(Struts2Util.getIp());
	        service.addAdvisor(advisor);
	
	        advisor = new Advisor();
	        super.setCheckcode("");
	        this.addActionMessage("咨询成功，请等待回复。");
        }catch(Exception e){
        	this.addActionMessage("咨询不成功，请重试。");
        }
        return SUCCESS;
    }

    private boolean login() {
        String state = super.execute();
        return state.equals(SUCCESS);
    }
}

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
import com.ewcms.component.online.service.OnlineService;
import com.ewcms.component.online.vo.Advisor;
import com.ewcms.component.util.StringToNumber;
import com.ewcms.component.vo.Page;

import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;

/**
 *
 * @author wangwei
 */
public class UserAction extends PageAction {

	private static final long serialVersionUID = -3873722630471555850L;

	private List<Advisor> advisors = new ArrayList<Advisor>();
    @Autowired
    private OnlineService service;

     public List<Advisor> getAdvisors() {
        return advisors;
    }

    public User getUser() {
        return AuthUtil.getUser();
    }

    @SuppressWarnings("unchecked")
	@Override
    public String execute(){
        User user = getUser();
        List<Advisor> all = service.findAdvisorByUsernam(user.getUsername());
        Integer iPageNumber = 0;
        try{
        	iPageNumber = StringToNumber.ToInteger(pageNumber);
        }catch(Exception e){}
        page = new Page.Builder(all.size(), iPageNumber + 1).setPageSize(row).build();
        advisors = pageList(all, page);

        return SUCCESS;
    }
}

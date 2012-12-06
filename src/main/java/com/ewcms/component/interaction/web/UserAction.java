/**
 * Copyright (c)2010-2011 Enterprise Website Content Management System(EWCMS), All rights reserved.
 * EWCMS PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 * http://www.ewcms.com
 */
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ewcms.component.interaction.web;

import com.ewcms.component.auth.AuthUtil;
import com.ewcms.component.auth.vo.User;
import com.ewcms.component.interaction.service.InteractionServiceable;
import com.ewcms.component.interaction.vo.Interaction;
import com.ewcms.component.util.StringToNumber;
import com.ewcms.component.vo.Page;
import com.ewcms.component.interaction.vo.Speak;
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
public class UserAction extends ActionSupport {

	private static final long serialVersionUID = -399069331003536690L;

	private static final int DEFAULT_ROW = 10;
    private String pageNumber = "0";
    private Page page;
    private List<Interaction> interactions = new ArrayList<Interaction>();
    private int row = DEFAULT_ROW;
    @Autowired
    private InteractionServiceable interactionService;

    public List<Interaction> getInteractions() {
        return interactions;
    }

    public void setInteractionService(InteractionServiceable service) {
        this.interactionService = service;
    }

    public Page getPage() {
        return page;
    }

    public void setPage(Page page) {
        this.page = page;
    }

    public String getPageNumber() {
        return pageNumber;
    }

    public void setPageNumber(String pageNumber) {
        this.pageNumber = pageNumber;
    }

    public User getUser() {
        return AuthUtil.getUser();
    }

    @Override
    public String execute() {
        String username = AuthUtil.getUser().getUsername();
        Integer iPageNumber = 0;
    	try{
    		iPageNumber = StringToNumber.ToInteger(pageNumber);
    	}catch(Exception e){
    	}
        interactions = interactionService.findInteractionByUsername(username, iPageNumber, DEFAULT_ROW);
        int count = interactionService.getInteractionUsernameCount(username);
        for (Interaction inter : interactions) {
            int speakCount = interactionService.getSpeakCount(inter.getId(), username);
            if (speakCount == 0) {
                inter.setSpeakCount(speakCount);
                inter.setSpeaks(new ArrayList<Speak>());
            } else {
                inter.setSpeakCount(speakCount);
            }
        }

        page = new Page.Builder(count, iPageNumber + 1).setPageSize(row).build();

        return SUCCESS;
    }
}

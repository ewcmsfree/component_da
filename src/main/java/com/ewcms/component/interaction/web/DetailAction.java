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
import com.ewcms.component.auth.web.LoginAction;
import com.ewcms.component.interaction.service.InteractionServiceable;
import com.ewcms.component.interaction.vo.Interaction;
import com.ewcms.component.interaction.vo.Organ;
import com.ewcms.component.util.StringToNumber;
import com.ewcms.component.vo.Page;
import com.ewcms.component.interaction.vo.Speak;
import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

/**
 *
 * @author wangwei
 */
@Controller
public class DetailAction extends LoginAction {

	private static final long serialVersionUID = -7399532780425670238L;

	private final static int DEFAULT_ROW = 5;
    private String id;
    private boolean counter = true;
    private Interaction interaction = new Interaction();
    private int pageNumber = 0;
    private int row = DEFAULT_ROW;
    private Page page;
//    private Integer type;
    
    @Autowired
    private InteractionServiceable interactionService;

    public void setId(String id) {
        this.id = id;
    }

    public String getId() {
        return id;
    }

//    public void setCounter(boolean counter) {
//        this.counter = counter;
//    }

    public Interaction getInteraction() {
        return this.interaction;
    }

//    public void setPageNumber(int pageNumber) {
//        this.pageNumber = pageNumber;
//    }

    public Page getPage() {
        return page;
    }

//    public Integer getType() {
//		return type;
//	}
//
//	public void setType(Integer type) {
//		this.type = type;
//	}

	public List<Organ> getBackRatios() {
        return interactionService.findInteractionBackOrder(8, true);
    }

    public List<Organ> getNoBackRatios() {
        return interactionService.findInteractionBackOrder(8, false);
    }

    public List<Interaction> getHots() {
        return interactionService.findHotInteraction(10);
    }

    @Override
    public String execute() {
    	try{
    		Integer iId = StringToNumber.ToInteger(id);
	        if (counter) {
	            this.interactionService.incrementInteractionCounter(iId);
	        }
	
	        interaction = interactionService.getInteraction(iId);
	        if (interaction == null || !interaction.getChecked()) {
	            return ERROR;
	        }
	
	        User user = AuthUtil.getUser();
	        String username = (user == null ? null : user.getUsername());
	        int count = interactionService.getSpeakCount(iId, username);
	        if (count == 0) {
	            interaction.setSpeakCount(count);
	            interaction.setSpeaks(new ArrayList<Speak>());
	        } else {
	            interaction.setSpeakCount(count);
	            interaction.setSpeaks(interactionService.findSpeakByInteractionId(
	            		iId, username, pageNumber, row));
	        }
	
	        page = new Page.Builder(count, pageNumber + 1).setPageSize(row).build();
    	}catch(Exception e){
    	}
        return SUCCESS;
    }
}

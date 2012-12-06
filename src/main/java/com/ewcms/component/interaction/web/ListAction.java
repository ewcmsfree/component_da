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

import com.ewcms.component.interaction.service.InteractionServiceable;
import com.ewcms.component.interaction.vo.Interaction;
import com.ewcms.component.vo.Page;
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
public class ListAction extends ActionSupport {

	private static final long serialVersionUID = -836538972654024229L;

	private final static int DEFAULT_ROW = 13;

    public enum FindType {
        ALL, REPLAY, NOREPLAY;
    }
    
    protected Integer type = 0;
    protected List<Interaction> interactions;
    //3建言献策
    //2投诉监督
    //1在线咨询
    protected int pageNumber;
    protected int row = DEFAULT_ROW;
    protected Page page;
    protected int currentTable;
    
    @Autowired
    protected InteractionServiceable interactionService;

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public void setPageNumber(int pageNumber) {
        this.pageNumber = pageNumber;
    }

	public Page getPage() {
        return this.page;
    }

	public List<Interaction> getInteractions() {
        return interactions;
    }

	public void setInteractionService(InteractionServiceable service) {
        this.interactionService = service;
    }

	public int getCurrentTable() {
		return currentTable;
	}

	public void setCurrentTable(int currentTable) {
		this.currentTable = currentTable;
	}

	@Override
    public String execute() {
        FindType findType = FindType.values()[type];
	    interactions = findInteractions(findType, currentTable);
        page = constractPage(findType, currentTable);
        return SUCCESS;
    }

    private List<Interaction> findInteractions(FindType findType, Integer interType) {
        if (findType == FindType.ALL) {
            return interactionService.findInteraction(pageNumber, row, interType);
        }
        if (findType == FindType.REPLAY) {
            return interactionService.findInteractionByReplay(true, pageNumber, row, interType);
        }
        if (findType == FindType.NOREPLAY) {
            return interactionService.findInteractionByReplay(false, pageNumber, row, interType);
        }
        return new ArrayList<Interaction>();
    }

    private Page constractPage(FindType findType, Integer interType) {
        int count = 0;
        if (findType == FindType.ALL) {
            count = interactionService.getInteractionCount(interType);
        }
        if (findType == FindType.REPLAY) {
            count = interactionService.getInteractionReplayCount(true, interType);
        }
        if (findType == FindType.NOREPLAY) {
            count = interactionService.getInteractionReplayCount(false, interType);
        }

        return new Page.Builder(count, pageNumber + 1).setPageSize(row).build();
    }
}

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
import com.ewcms.component.interaction.vo.Organ;
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
public class IndexAction extends ActionSupport {

	private static final long serialVersionUID = -1880649265523336141L;

	private final static int DEFAULT_ROW = 12;

    public enum FindType {
        ALL, REPLAY, NOREPLAY;
    }
    
    protected Integer type = 0;
    protected List<Interaction> interactions;
    protected List<Interaction> interactionXcs;//3建言献策
    protected List<Interaction> interactionTss;//2投诉监督
    protected List<Interaction> interactionZxs;//1在线咨询
    protected int pageNumber;
    protected int pageNumberXc;
    protected int pageNumberTs;
    protected int pageNumberZx;
    protected int row = DEFAULT_ROW;
    protected Page page;
    protected Page pageXc;
    protected Page pageTs;
    protected Page pageZx;
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

    public void setPageNumberXc(int pageNumberXc) {
		this.pageNumberXc = pageNumberXc;
	}

	public void setPageNumberTs(int pageNumberTs) {
		this.pageNumberTs = pageNumberTs;
	}

	public void setPageNumberZx(int pageNumberZx) {
		this.pageNumberZx = pageNumberZx;
	}

	public Page getPage() {
        return this.page;
    }

    public Page getPageXc() {
		return pageXc;
	}

	public Page getPageTs() {
		return pageTs;
	}

	public Page getPageZx() {
		return pageZx;
	}

	public List<Interaction> getInteractions() {
        return interactions;
    }

    public List<Interaction> getInteractionXcs() {
		return interactionXcs;
	}

	public List<Interaction> getInteractionTss() {
		return interactionTss;
	}

	public List<Interaction> getInteractionZxs() {
		return interactionZxs;
	}

	public void setInteractionService(InteractionServiceable service) {
        this.interactionService = service;
    }

    public List<Organ> getBackRatios() {
        return interactionService.findInteractionBackOrder(7, true);
    }

    public List<Organ> getNoBackRatios() {
        return interactionService.findInteractionBackOrder(7, false);
    }
    
    public List<Organ> getBackCount(){
    	return interactionService.findIteractionBackCount(7);
    }
    public List<Organ> getNoBackCount(){
    	return interactionService.findIteractionNoBackCount(7);
    }
    public List<Interaction> getHots() {
        return interactionService.findHotInteraction(9);
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
        interactions = findInteractions(findType, 0);
        interactionXcs = findInteractionXcs(findType, 3);
        interactionTss = findInteractionTss(findType, 2);
        interactionZxs = findInteractionZxs(findType, 1);
        page = constractPage(findType, 0);
        pageXc = constractPageXc(findType, 3);
        pageTs = constractPageTs(findType, 2);
        pageZx = constractPageZx(findType, 1);
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
    
    private List<Interaction> findInteractionXcs(FindType findType, Integer interType) {
        if (findType == FindType.ALL) {
            return interactionService.findInteraction(pageNumberXc, row, interType);
        }
        if (findType == FindType.REPLAY) {
            return interactionService.findInteractionByReplay(true, pageNumberXc, row, interType);
        }
        if (findType == FindType.NOREPLAY) {
            return interactionService.findInteractionByReplay(false, pageNumberXc, row, interType);
        }
        return new ArrayList<Interaction>();
    }

    private Page constractPageXc(FindType findType, Integer interType) {
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

        return new Page.Builder(count, pageNumberXc + 1).setPageSize(row).build();
    }

    private List<Interaction> findInteractionTss(FindType findType, Integer interType) {
        if (findType == FindType.ALL) {
            return interactionService.findInteraction(pageNumberTs, row, interType);
        }
        if (findType == FindType.REPLAY) {
            return interactionService.findInteractionByReplay(true, pageNumberTs, row, interType);
        }
        if (findType == FindType.NOREPLAY) {
            return interactionService.findInteractionByReplay(false, pageNumberTs, row, interType);
        }
        return new ArrayList<Interaction>();
    }

    private Page constractPageTs(FindType findType, Integer interType) {
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

        return new Page.Builder(count, pageNumberTs + 1).setPageSize(row).build();
    }

    private List<Interaction> findInteractionZxs(FindType findType, Integer interType) {
        if (findType == FindType.ALL) {
            return interactionService.findInteraction(pageNumberZx, row, interType);
        }
        if (findType == FindType.REPLAY) {
            return interactionService.findInteractionByReplay(true, pageNumberZx, row, interType);
        }
        if (findType == FindType.NOREPLAY) {
            return interactionService.findInteractionByReplay(false, pageNumberZx, row, interType);
        }
        return new ArrayList<Interaction>();
    }

    private Page constractPageZx(FindType findType, Integer interType) {
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

        return new Page.Builder(count, pageNumberZx + 1).setPageSize(row).build();
    }
}

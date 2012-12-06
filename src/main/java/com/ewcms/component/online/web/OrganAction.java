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
import com.ewcms.component.online.vo.Organ;
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
@Controller("com.ewcms.component.online.web.OrganAction")
public class OrganAction extends PageAction {

	private static final long serialVersionUID = -4256197746683119957L;

	private static final int DEFAULT_ROW = 12;
    private List<Organ> organs = new ArrayList<Organ>();
    private List<Working> matters = new ArrayList<Working>();
    private Organ organ = new Organ();
    private String organId;
    private List<Working> parents = new ArrayList<Working>();
    @Autowired
    private OnlineService service;

    public List<Working> getMatters() {
        return matters;
    }

    public List<Organ> getOrgans() {
        return organs;
    }

    public Organ getOrgan() {
        return organ;
    }

    public void setOrganId(String organId) {
        this.organId = organId;
    }

    public List<Working> getParents() {
        return parents;
    }

    public List<Citizen> getCitizens() {
        return service.getCitizenAll();
    }

    @SuppressWarnings("unchecked")
	@Override
    public String execute() {
        row = DEFAULT_ROW;
        organs = service.findOrganForWorking();
        Integer iOrganId = null;
        try{
        	iOrganId = StringToNumber.ToInteger(organId);
        }catch(Exception e){
        	iOrganId = null;
        }
        if (iOrganId == null) {
            List<Organ> list = service.findOrganForWorking();
            if (list.isEmpty()) {
                return SUCCESS;
            }
            iOrganId = list.get(0).getId();
        }
        setOrganId(String.valueOf(iOrganId));
        organ = service.getOrgan(iOrganId);
        if (organ == null) {
            matters = new ArrayList<Working>();
            return SUCCESS;
        }
        parents = service.getWorkingChilren(null);
        List<Working> matterAll = service.findWorkingByOrgan(iOrganId);
        Integer iPageNumber = 0;
        try{
        	iPageNumber = StringToNumber.ToInteger(pageNumber);
        }catch(Exception e){}
        page = new Page.Builder(matterAll.size(), iPageNumber + 1).setPageSize(row).build();
        matters = pageList(matterAll, page);

        return SUCCESS;

    }
}

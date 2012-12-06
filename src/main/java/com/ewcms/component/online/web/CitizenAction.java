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
import com.ewcms.component.online.vo.Article;
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
public class CitizenAction extends PageAction {

	private static final long serialVersionUID = 9165624150125156068L;

	private static final int DEFAULT_ROW = 12;
    private String citizenId;
    private List<Working> matters = new ArrayList<Working>();
    private List<Article> articles = new ArrayList<Article>();
    private Citizen citizen = new Citizen();
    @Autowired
    private OnlineService service;

    public List<Article> getArticles() {
        return articles;
    }

    public void setArticles(List<Article> articles) {
        this.articles = articles;
    }

    public String getCitizenId() {
        return citizenId;
    }

    public void setCitizenId(String citizenId) {
        this.citizenId = citizenId;
    }

    public List<Working> getMatters() {
        return matters;
    }

    public void setMatters(List<Working> matters) {
        this.matters = matters;
    }

    public List<Citizen> getCitizens() {
        return constructCitizens();
    }

    private List<Citizen> constructCitizens() {

        List<Citizen> list = service.getCitizenAll();
        if (list.isEmpty()) {
            return list;
        }
        if((list.size() % 6) == 0){
            return list;
        }
        int clean = 6 - (list.size() % 6);
        for (int i = 0; i < clean; i++) {
            list.add(new Citizen());
        }
        return list;
    }

    public Citizen getCitizen() {
        return citizen;
    }

    @SuppressWarnings("unchecked")
	@Override
    public String execute() {
        row = DEFAULT_ROW;
        Integer iCitizenId;
        try{
        	iCitizenId = StringToNumber.ToInteger(citizenId);
        }catch(Exception e){
        	iCitizenId = null;
        }
        if (iCitizenId == null) {
        	iCitizenId = service.getCitizenAll().get(0).getId();
        }
        setCitizenId(String.valueOf(iCitizenId));
        citizen = service.getCitizen(iCitizenId);
        List<Working> matterAll = service.findWorkingByCitizen(iCitizenId);
        Integer iPageNumber = 0;
        try{
        	iPageNumber = StringToNumber.ToInteger(pageNumber);
        }catch(Exception e){}
        page = new Page.Builder(matterAll.size(), iPageNumber + 1).setPageSize(row).build();
        matters = pageList(matterAll, page);

        return SUCCESS;
    }
}

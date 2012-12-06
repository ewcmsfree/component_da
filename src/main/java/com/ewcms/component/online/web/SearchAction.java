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
@Controller("com.ewcms.component.online.web.SearchAction")
public class SearchAction extends PageAction {

	private static final long serialVersionUID = 1836374198039253085L;

	private static final int DEFAULT_ROW = 10;
    private List<Working> workings = new ArrayList<Working>();
    private String key = "" ;
    
    @Autowired
    private OnlineService service;

    public List<Working> getWorkings() {
        return workings;
    }

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public void setOnlineService(OnlineService service) {
        this.service = service;
    }

    public List<Citizen> getCitizens() {
        return service.getCitizenAll();
    }

    @SuppressWarnings("unchecked")
	@Override
    public String execute() {
        row = DEFAULT_ROW;
        List<Working> workingAll;
        if(key == null || key.trim().length()==0){
            workingAll = new ArrayList<Working>();
        }else{
            workingAll = service.findWorkingByName(key);
        }
        Integer iPageNumber = 0;
        try{
        	iPageNumber = StringToNumber.ToInteger(pageNumber);
        }catch(Exception e){}
        page = new Page.Builder(workingAll.size(), iPageNumber + 1).setPageSize(row).build();
        workings = pageList(workingAll, page);
        
        return SUCCESS;
    }
}

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

import com.ewcms.component.online.vo.Organ;
import com.ewcms.component.online.service.OnlineService;
import com.ewcms.component.online.vo.Citizen;
import com.ewcms.component.online.vo.Working;
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
public class OnlineAction extends ActionSupport {

	private static final long serialVersionUID = 6914636421075953659L;

	private List<Working> workings = new ArrayList<Working>();
    private List<Organ> organs = new ArrayList<Organ>();
    @Autowired
    private OnlineService service;

    public List<Working> getWorkings() {
        return this.workings;
    }

    public List<Organ> getOrgans() {
        return organs;
    }

    public List<Citizen> getCitizens() {
        return service.getCitizenAll();
    }

    @Override
    public String execute() {
        workings = constructWorkings();
        organs = constructOrgans();
        return SUCCESS;
    }

    private List<Working> constructWorkings() {

        List<Working> list = service.getWorkingChilren(null);
        for (Working working : list) {
            List<Working> children = service.getWorkingChilren(working.getId());
            if (children.isEmpty()) {
                continue;
            }
            int clean = 6 - (children.size() % 6);
            if (clean < 6) {
                for (int i = 0; i < clean; i++) {
                    children.add(new Working());
                }
            }
            working.setChildren(children);
        }
        return list;
    }

    private List<Organ> constructOrgans() {
        List<Organ> list = service.findOrganForWorking();
        if (list.isEmpty()) {
            return list;
        }
        int clean = 6 - (list.size() % 6);
        for (int i = 0; i < clean; i++) {
            list.add(new Organ());
        }
        return list;
    }
}

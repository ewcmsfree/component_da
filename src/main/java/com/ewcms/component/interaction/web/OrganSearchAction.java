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

import com.ewcms.component.interaction.vo.Interaction;
import com.ewcms.component.interaction.vo.Organ;
import com.ewcms.component.vo.Page;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author wangwei
 */
public class OrganSearchAction extends IndexAction {

	private static final long serialVersionUID = 5108118647149530322L;

	private int id;
    private String name;
    private boolean hasOrgan = true;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public boolean getHasOrgan(){
        return hasOrgan;
    }

    @Override
    public String execute() {
        Organ organ = interactionService.getOrgan(id);
        if (organ == null) {
            name = "";
            hasOrgan = false;
            interactions = new ArrayList<Interaction>();
        } else {
            name = organ.getName();
            List<Interaction> all = interactionService.findInteractionByOrganId(id);
            page = new Page.Builder(all.size(), pageNumber + 1).setPageSize(row).build();
            interactions = showInteraction(all, page);
        }

        return SUCCESS;
    }

    private List<Interaction> showInteraction(final List<Interaction> all,final Page p) {
        int number = p.getPage() -1 ;
        int size = p.getPageSize();
        int from = number * size;
        int allSize = all.size();
        if(from > allSize){
            return new ArrayList<Interaction>();
        }
        int to = (number + 1) * size;
        to = to > allSize ? allSize : to;
        return all.subList(from, to);
    }
}

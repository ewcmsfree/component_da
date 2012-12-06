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
import com.ewcms.component.interaction.vo.Organ;
import com.ewcms.component.util.Struts2Util;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

/**
 *
 * @author wangwei
 */
@Controller
public class OrganAction {

    private static final String ORGAN_JOSON_FORMAT = "{\"key\":%d,\"title\":\"%s\",\"isLazy\":%s,\"isFolder\":%s}";
    private Integer key;

    @Autowired
    private InteractionServiceable interactionService;

    public void setKey(Integer key) {
        this.key = key;
    }

    public void setInteractionService(InteractionServiceable service) {
        this.interactionService = service;
    }

    public void query() {
        List<Organ> children = getChildren();
        String json = builderJson(children);
        Struts2Util.renderJson(json);
    }

    private List<Organ> getChildren() {
        List<Organ> children = interactionService.getOrganChildren(key);
        for(Organ child : children){
            child.setChilder(interactionService.getOrganChildren(child.getId()));
        }
        return children;
    }

    private String builderJson(final List<Organ> organs) {
        StringBuilder builder = new StringBuilder();

        if(organs == null || organs.isEmpty()){
            return "[]";
        }
        
        builder.append("[\n");
        int size = organs.size();
        for (int i = 0 ; i < size ; i++) {
            Organ organ = organs.get(i);
            Integer id = organ.getId();
            String title = organ.getName();
            boolean isLazy = true;
            boolean isFolder = true;
            if (organ.getChilder() == null || organ.getChilder().isEmpty()) {
                isLazy = false;
                isFolder = false;
            }
            String organJson = String.format(ORGAN_JOSON_FORMAT,
                    id, title, String.valueOf(isLazy),String.valueOf(isFolder));
            builder.append(organJson);
            if(i != size -1){
                builder.append(",\n");
            }else{
                builder.append("\n");
            }
        }

        builder.append("]\n");

        return builder.toString();
    }
}

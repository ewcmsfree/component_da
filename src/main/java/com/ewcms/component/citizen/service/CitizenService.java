/**
 * Copyright (c)2010-2011 Enterprise Website Content Management System(EWCMS), All rights reserved.
 * EWCMS PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 * http://www.ewcms.com
 */
package com.ewcms.component.citizen.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ewcms.component.online.dao.CitizenDAO;
import com.ewcms.component.online.vo.Citizen;

/**
 * @author wuzhijun
 */
@Service
public class CitizenService {
    @Autowired
    private CitizenDAO citizenDAO;

    public void setCitizenDAO(CitizenDAO dao) {
        this.citizenDAO = dao;
    }
    
    public List<Citizen> getCitizenAll() {
        return citizenDAO.getAll();
    }
    
    public String mainJSON(){
        List<Citizen> citizens = getCitizenAll();
        if(citizens == null || citizens.isEmpty()){
            return "[]";
        }
        
        StringBuilder builder = new StringBuilder();
        builder.append("[");
        for(Citizen citizen : citizens){
            builder.append("{").append("\"id\":\"").append(citizen.getId()).append("\",");
            builder.append("\"name\":\"").append(citizen.getName()).append("\"},");
        }
        builder.deleteCharAt(builder.length() -1);
        builder.append("]");

        return builder.toString();
    }

}

/**
 * Copyright (c)2010-2011 Enterprise Website Content Management System(EWCMS), All rights reserved.
 * EWCMS PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 * http://www.ewcms.com
 */
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ewcms.component.online.service;

import com.ewcms.component.online.dao.AdvisorDAO;
import com.ewcms.component.online.dao.CitizenDAO;
import com.ewcms.component.online.dao.MatterDAO;
import com.ewcms.component.online.dao.WorkingDAO;
import com.ewcms.component.online.vo.Advisor;
import com.ewcms.component.online.vo.Article;
import com.ewcms.component.online.vo.Citizen;
import com.ewcms.component.online.vo.Matter;
import com.ewcms.component.online.vo.MatterAnnex;
import com.ewcms.component.online.vo.Organ;
import com.ewcms.component.online.vo.Working;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author wangwei
 */
@Service
public class OnlineService {

    @Autowired
    private CitizenDAO citizenDAO;
    @Autowired
    private MatterDAO matterDAO;
    @Autowired
    private WorkingDAO workingDAO;
    @Autowired
    private AdvisorDAO advisorDAO;

    public void setCitizenDAO(CitizenDAO dao) {
        this.citizenDAO = dao;
    }

    public void setMatterDAO(MatterDAO dao) {
        this.matterDAO = dao;
    }

    public void setWorkingDAO(WorkingDAO dao) {
        this.workingDAO = dao;
    }

    public AdvisorDAO getAdvisoryDAO() {
        return advisorDAO;
    }

    public void setAdvisorDAO(AdvisorDAO advisoryDAO) {
        this.advisorDAO = advisoryDAO;
    }

    public int addAdvisor(Advisor vo) {
        return advisorDAO.add(vo);
    }

    public Citizen getCitizen(int citizenId) {
        return citizenDAO.get(citizenId);
    }

    public List<Citizen> getCitizenAll() {
        return citizenDAO.getAll();
    }

    public List<Advisor> findAdvisorByMatter(final Integer matterId, final String title) {
        return advisorDAO.findAdvisorByMatter(matterId, title, 1000);
    }

    public List<Advisor> findAdvisorByUsernam(String username) {
        return advisorDAO.findAdvisorByUsernam(username);
    }

    public List<Working> findWorkingByCitizen(int citizenId) {
        return workingDAO.findWorkingByCitizen(citizenId);
    }

    public Matter getMatter(final int matterId) {
        return matterDAO.get(matterId);
    }

    public List<Working> getWorkingChilren(final Integer parentId) {
        if (parentId == null || parentId == -1) {
            return workingDAO.getRootChildren();
        } else {
            return workingDAO.getChildren(parentId);
        }
    }

    public Working getWorking(final int workingId) {
        return workingDAO.get(workingId);
    }

    public Integer getMatterId(final int workingId) {
        return workingDAO.getMatterId(workingId);
    }

    public List<Working> getMatterChildren(Integer id) {
        return workingDAO.getMatterChildren(id);
    }

    public List<Article> findAtricleByWorkingId(final int id) {
        return workingDAO.findArticle(id);
    }

    public List<Working> getWorkingPosition(Integer id) {
        return workingDAO.getPosition(id);
    }

    public List<Working> findWorkingByName(String name) {
        return workingDAO.findByName(name);
    }
    
    public List<MatterAnnex> findMatterAnnexByName(String name){
    	return workingDAO.findByAnnex(name);
    }

    public List<Organ> findOrganForWorking() {
        return workingDAO.findOrganForWorking();
    }

    public List<Working> findWorkingByOrgan(Integer id) {
        return workingDAO.findWorkingByOrgan(id);
    }

    public Organ getOrgan(Integer id) {
        return workingDAO.getOrgan(id);
    }

    public String mainJSON() {
        List<Working> workings = workingDAO.getRootChildren();
        if (workings.isEmpty()) {
            return "[]";
        }
        workings = workings.size() > 3 ? workings.subList(0, 3) : workings;
        for (Working working : workings) {
            Integer id = working.getId();
            List<Working> children = workingDAO.getChildren(id);
            working.setChildren(children);
        }

        StringBuilder builder = new StringBuilder();
        builder.append("[");
        for (Working working : workings) {
            builder.append("{");
            builder.append("\"id\":").append(working.getId()).append(",");
            builder.append("\"name\":\"").append(working.getName()).append("\",");
            builder.append("\"children\":").append(childrenJSON(working.getChildren()));
            builder.append("},");
        }
        builder.deleteCharAt(builder.length() - 1);
        builder.append("]");

        return builder.toString();
    }

    private String childrenJSON(List<Working> workings) {
        if (workings.isEmpty()) {
            return "[]";
        }

        StringBuilder builder = new StringBuilder();

        builder.append("[");
        for (Working working : workings) {
            builder.append("{");
            builder.append("\"id\":").append(working.getId()).append(",");
            builder.append("\"name\":\"").append(working.getName()).append("\"");
            builder.append("},");
        }
        builder.deleteCharAt(builder.length() - 1);
        builder.append("]");

        return builder.toString();
    }
}

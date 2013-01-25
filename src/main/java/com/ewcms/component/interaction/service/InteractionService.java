/**
 * Copyright (c)2010-2011 Enterprise Website Content Management System(EWCMS), All rights reserved.
 * EWCMS PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 * http://www.ewcms.com
 */
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ewcms.component.interaction.service;

import com.ewcms.component.interaction.dao.InteractionDAOable;
import com.ewcms.component.interaction.vo.Interaction;
import com.ewcms.component.interaction.vo.InteractionState;
import com.ewcms.component.interaction.vo.Organ;
import com.ewcms.component.interaction.vo.Speak;
import java.text.SimpleDateFormat;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author wangwei
 */
@Service("interactionService")
public class InteractionService implements InteractionServiceable {
    private static final SimpleDateFormat format = new SimpleDateFormat("yy.MM.dd");

    @Autowired
    private InteractionDAOable interactionDAO;

    public void setInteractionDAO(InteractionDAOable dao) {
        this.interactionDAO = dao;
    }

    @Override
    public Integer addInteraction(Interaction vo) {
        if (vo.getOrgan() == null) {
            Organ organ = interactionDAO.getOrganRootChildren().get(0);
            vo.setOrgan(organ);
        }
        vo.setState(InteractionState.INIT);
        int id = interactionDAO.addInteraction(vo);
        interactionDAO.interactionBackRatio(vo.getOrgan().getId());
        return id;
    }

    @Override
    public Interaction getInteraction(Integer id) {
        return interactionDAO.getInteraction(id);
    }

    @Override
    public void incrementInteractionCounter(int id) {
        interactionDAO.incrementInteractionCounter(id);
    }

    @Override
    public Organ getOrgan(Integer id) {
        return interactionDAO.getOrgan(id);
    }

    @Override
    public List<Organ> getOrganChildren(Integer id) {
        List<Organ> children;
        if (id == null || id == -1) {
            children = interactionDAO.getOrganRootChildren();
        } else {
            children = interactionDAO.getOrganChildren(id);
        }
        return children;
    }

    @Override
    public List<Interaction> findInteractionByUsername(String username, int page, int row) {
        return interactionDAO.findInteractionByUsername(username, page, row);
    }

    @Override
    public List<Interaction> findInteraction(int page, int row, int interType) {
        return interactionDAO.findInteraction(page, row, interType);
    }

    @Override
    public List<Interaction> findInteractionByReplay(boolean replay, int page, int rows, int interType) {
        return interactionDAO.findInteractionByReplay(replay, page, rows, interType);
    }

    @Override
    public int getInteractionCount(int interType) {
        return interactionDAO.getInteractionCount(interType);
    }

    @Override
    public int getInteractionReplayCount(boolean replay,int interType) {
        return interactionDAO.getInteractionReplayCount(replay, interType);
    }

    @Override
    public int getInteractionUsernameCount(String username) {
        return interactionDAO.getInteractionUsernameCount(username);
    }

    @Override
    public void addSpeak(Speak vo) {
        interactionDAO.addSpeak(vo);
    }

    @Override
    public List<Speak> findSpeakByInteractionId(int interactionId, String username, int page, int row) {
        return interactionDAO.findSpeakByInteractionId(interactionId, username, page, row);
    }

    @Override
    public int getSpeakCount(int interactionId, String username) {
        return interactionDAO.getSpeakCount(interactionId, username);
    }

    @Override
    public List<Interaction> findHotInteraction(int row) {
        return interactionDAO.findHotInteraction(row);
    }

    @Override
    public List<Organ> findInteractionBackOrder(int row, boolean desc) {
        return interactionDAO.findInteractionBackOrder(row, desc);
    }

    @Override
    public List<Interaction> findInteractionByTitle(String[] title, int page, int row) {
        return interactionDAO.findInteractionByTitle(title, page, row);
    }

    @Override
    public List<Interaction> findInteractionByTitleReplay(String[] title, boolean replay, int page, int row) {
        return interactionDAO.findInteractionByTitleReplay(title, replay, page, row);
    }

    @Override
    public int findInteractionByTitleCount(String[] title) {
        return interactionDAO.findInteractionByTitleCount(title);
    }

    @Override
    public int findInteractionByTitleReplayCount(String[] title, boolean replay) {
        return interactionDAO.findInteractionByTitleReplayCount(title, replay);
    }

    @Override
    public List<Interaction> findInteractionByOrganId(int organId) {
        return interactionDAO.findInteractionByOrganId(organId);
    }

    @Override
    public String mainJSON(Integer type){
        StringBuilder builder = new StringBuilder();
        builder.append("{");
        builder.append("\"interactions\":").append(interactionJSON(type)).append(",");
        builder.append("\"ratios\":").append(replayRatioJSON(type));
        builder.append("}");

        return builder.toString();
    }

    private String interactionJSON(Integer type) {
        List<Interaction> list = interactionDAO.findInteraction(0, 9, type);
        if (list == null || list.isEmpty()){
        	return "[]";
        }
        StringBuilder builder = new StringBuilder();
        builder.append("[");
        for(Interaction interaction : list){
            builder.append("{");
            builder.append("\"id\":").append(interaction.getId()).append(",");
            builder.append("\"type\":\"").append(getTypeName(interaction.getType())).append("\",");
            builder.append("\"title\":\"").append(interaction.getTitle()).append("\",");
            builder.append("\"organ\":\"").append(interaction.getOrgan().getName()).append("\",");
            builder.append("\"state\":\"").append(interaction.getState().getTitle()).append("\",");
            builder.append("\"date\":\"").append(format.format(interaction.getDate())).append("\"");
            builder.append("},");
        }
        builder.deleteCharAt(builder.length() -1);
        builder.append("]");

        return builder.toString();
    }

    private String getTypeName(final int type){
        if(type == 1){
            return "在线咨询";
        }
        if(type == 2){
            return "投诉监督";
        }
        return "建言献策";
    }

    private String replayRatioJSON(Integer type) {
        StringBuilder builder = new StringBuilder();
        builder.append("[");
        List<Organ> list = interactionDAO.findInteractionBackOrder(9, true);
        for(Organ organ : list){
            builder.append("{");
            builder.append("\"id\":\"").append(organ.getId()).append("\",");
            builder.append("\"organ\":\"").append(organ.getName()).append("\",");
            builder.append("\"ratio\":").append(organ.getBackRatio()).append(",");
            builder.append("\"type\":").append(0);
            builder.append("},");
        }
        list = interactionDAO.findInteractionBackOrder(9, false);
        for(Organ organ : list){
            builder.append("{");
            builder.append("\"id\":\"").append(organ.getId()).append("\",");
            builder.append("\"organ\":\"").append(organ.getName()).append("\",");
            builder.append("\"ratio\":").append(organ.getNoBackRatio()).append(",");
            builder.append("\"type\":").append(1);
            builder.append("},");
        }
        builder.deleteCharAt(builder.length() -1);
        builder.append("]");

        return builder.toString();
    }

	@Override
	public List<Organ> findIteractionBackCount(int row) {
		return interactionDAO.findIteractionBackCount(row);
	}
}

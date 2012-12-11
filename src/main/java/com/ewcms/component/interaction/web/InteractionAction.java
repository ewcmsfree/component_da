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

import com.ewcms.component.auth.AuthUtil;
import com.ewcms.component.auth.vo.User;
import com.ewcms.component.auth.web.LoginAction;
import com.ewcms.component.interaction.service.InteractionServiceable;
import com.ewcms.component.interaction.vo.Interaction;
import com.ewcms.component.interaction.vo.Organ;
import com.ewcms.component.util.RegexUtil;
import com.ewcms.component.util.Struts2Util;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;

/**
 *
 * @author wangwei
 */
public class InteractionAction extends LoginAction {

	private static final long serialVersionUID = 375273455337685071L;

	private Integer type;
    private String title;
    private Integer organId;
    private String organName;
    private String content;
    private String tel;
    private boolean noOrgan = false;
    private boolean success = false;
    
    @Autowired
    private InteractionServiceable interactionService;

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public boolean isNoOrgan() {
        return noOrgan;
    }

    public void setNoOrgan(boolean noOrgan) {
        this.noOrgan = noOrgan;
    }

    public Integer getOrganId() {
        return organId;
    }

    public void setOrganId(Integer organId) {
        this.organId = organId;
    }

    public String getOrganName() {
        return organName;
    }

    public void setOrganName(String organName) {
        this.organName = organName;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public void setNoOragn(boolean noOrgan) {
        this.noOrgan = noOrgan;
    }

    public void setInteractionService(InteractionServiceable service) {
        this.interactionService = service;
    }

    public boolean isLogin() {
        return AuthUtil.isLogin();
    }

    public User getUser() {
        return AuthUtil.getUser();
    }

    public boolean isSuccess() {
        return success;
    }

    public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public List<Organ> getBackRatios() {
        return interactionService.findInteractionBackOrder(8, true);
    }

    public List<Organ> getNoBackRatios() {
        return interactionService.findInteractionBackOrder(8, false);
    }

    public List<Interaction> getHots() {
        return interactionService.findHotInteraction(10);
    }

    @Override
    public String execute() {
        if (isLogin()) {
            if (!this.validateCheckcode()) {
                this.addActionError("验证码错误！");
                super.setCheckcode("");
                return INPUT;
            }
        } else {
            if (!login()) {
                return INPUT;
            }
        }

        Interaction interaction = new Interaction();
        interaction.setChecked(false);
        interaction.setContent(RegexUtil.FilterScriptAndStyle(content));
        interaction.setTitle(RegexUtil.FilterScriptAndStyle(title));
        if (noOrgan) {
            interaction.setOrgan(null);
        } else {
            interaction.setOrgan(new Organ(organId, organName));
        }
        interaction.setType(type);
        interaction.setIp(Struts2Util.getIp());
        interaction.setUsername(getUser().getUsername());
        interaction.setName(getUser().getName());
        interaction.setChecked(false);
        interaction.setTel(RegexUtil.FilterScriptAndStyle(tel));
        interactionService.addInteraction(interaction);
        empty();

        addActionMessage("谢谢你的来信，在“我的信息件箱”可以查看来信件状态。");
        this.success = true;
        return SUCCESS;
    }

    private void empty() {
        type = 1;
        title = "";
        organId = null;
        organName = null;
        content = "";
        noOrgan = false;
    }

    private boolean login() {
        String state = super.execute();
        return state.equals(SUCCESS);
    }
}

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
import com.ewcms.component.interaction.vo.Speak;
import com.ewcms.component.util.RegexUtil;
import com.ewcms.component.util.StringToNumber;
import com.ewcms.component.util.Struts2Util;
import org.springframework.beans.factory.annotation.Autowired;

/**
 *
 * @author wangwei
 */
public class SpeakAction extends LoginAction {

	private static final long serialVersionUID = 1944810699535509931L;

	private static final String refreshHtml;

    private String interactionId;
    private String content;

    static{
        StringBuilder builder = new StringBuilder();
        builder.append("<html>\n");
        builder.append("<head></head>");
        builder.append("<body>");
        builder.append("<script language=\"JavaScript\" type=\"text/JavaScript\">");
        builder.append("parent.refresh();");
        builder.append("</script>");
        builder.append("</body>");
        builder.append("</html>");

        refreshHtml = builder.toString();
    }

    @Autowired
    private InteractionServiceable interactionService;

    public String getInteractionId() {
        return interactionId;
    }

    public void setInteractionId(String interactionId) {
        this.interactionId = interactionId;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getContent() {
        return this.content;
    }

    public boolean isLogin() {
        return AuthUtil.isLogin();
    }

    public User getUser() {
        return AuthUtil.getUser();
    }

    @Override
    public String execute() {
        if (isLogin()) {
            if (!this.validateCheckcode()) {
                this.addActionError("验证码错误！");
                return INPUT;
            }
        } else {
            if (!login()) {
                return INPUT;
            }
        }
        
        try{
        	Integer iInteractionId = StringToNumber.ToInteger(interactionId);
        	
	        Speak speak = new Speak();
	        speak.setChecked(false);
	        speak.setContent(RegexUtil.FilterScriptAndStyle(content));
	        speak.setInteractionId(iInteractionId);
	        speak.setUsername(getUser().getUsername());
	        speak.setName(getUser().getName());
	        speak.setIp(Struts2Util.getIp());
	
	        interactionService.addSpeak(speak);
	        content = "";
        }catch(Exception e){
        	
        }
        Struts2Util.renderHtml(refreshHtml);
        return NONE;
    }

    private boolean login() {
        String state = super.execute();
        return state.equals(SUCCESS);
    }
}

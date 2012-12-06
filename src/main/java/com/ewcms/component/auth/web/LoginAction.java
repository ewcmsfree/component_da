/**
 * Copyright (c)2010-2011 Enterprise Website Content Management System(EWCMS), All rights reserved.
 * EWCMS PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 * http://www.ewcms.com
 */
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ewcms.component.auth.web;

import com.ewcms.component.auth.AuthUtil;
import com.ewcms.component.auth.filter.AuthorityIntercept;
import com.ewcms.component.auth.service.AuthServiceable;
import com.ewcms.component.auth.vo.User;
import com.octo.captcha.service.CaptchaService;
import com.octo.captcha.service.CaptchaServiceException;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

/**
 *
 * @author wangwei
 */
@Controller
public class LoginAction extends ActionSupport {

	private static final long serialVersionUID = -3059121355544960298L;

	private String username;
    private String password;
    private String checkcode;
    private String goToUrl;
    
    @Autowired
    private CaptchaService captchaService;
    @Autowired
    private AuthServiceable authService;

    public String getCheckcode() {
        return checkcode;
    }

    public void setCheckcode(String checkcode) {
        this.checkcode = checkcode;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setAuthService(AuthServiceable authService) {
        this.authService = authService;
    }

    public void setCaptchaService(CaptchaService captchaService) {
        this.captchaService = captchaService;
    }

    public String getGoToUrl() {
        return goToUrl;
    }

    public void setGoToUrl(String goToUrl) {
        this.goToUrl = goToUrl;
    }

    @Override
    public String execute() {
        if(username == null){
            return INPUT;
        }
        if(!validateCheckcode()){
            this.addActionError("验证码错误！");
            checkcode = "";
            return ERROR;
        }
        boolean login = authService.login(username, password);
        if(login){
            User user = authService.getUser(username);
            AuthUtil.setUser(user);
            checkcode = "";
            String url = getGoUrl();
            if(url == null || url.trim().length() == 0){
                return SUCCESS;
            }else{
                goToUrl = url;
                clearGoUrl();
                return "go";
            }
        }else{
            this.addActionError("用户名或密码错误！");
            checkcode = "";
            return ERROR;
        }
    }

    protected boolean validateCheckcode() {
        String captchaId = ServletActionContext.getRequest().getSession().getId();
        checkcode = (checkcode == null ? "" : checkcode);
        checkcode = checkcode.toUpperCase();
        try {
            return captchaService.validateResponseForID(captchaId, checkcode);
        } catch (CaptchaServiceException e) {
            return false;
        }
    }

    private String getGoUrl(){
        
        String key = AuthorityIntercept.GOING_TO_URL_KEY;
        String goUrl =(String)ServletActionContext.getRequest().getSession().getAttribute(key);

        return goUrl;
    }

     private void clearGoUrl(){
        String key = AuthorityIntercept.GOING_TO_URL_KEY;
        ServletActionContext.getRequest().getSession().removeAttribute(key);
    }
}

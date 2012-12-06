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
import com.ewcms.component.auth.service.AuthServiceable;
import com.ewcms.component.auth.vo.User;
import com.ewcms.component.util.Struts2Util;
import com.octo.captcha.service.CaptchaService;
import com.octo.captcha.service.CaptchaServiceException;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Controller;
import org.springframework.beans.factory.annotation.Autowired;

/**
 *
 * @author wangwei
 */
@Controller
public class RegisterAction extends ActionSupport{

	private static final long serialVersionUID = -5952422332095263724L;

	private static final String JSON_FROMT = "{\"username\":\"%s\",\"success\":%s,\"checkcode\":%s}";
     
    private String username;
    private String password;
    private String passwordAgain;
    private String name;
    private String email;
    private String checkcode;

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

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPasswordAgain() {
        return passwordAgain;
    }

    public void setPasswordAgain(String passwordAgain) {
        this.passwordAgain = passwordAgain;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setCaptchaService(CaptchaService service){
        this.captchaService = service;
    }

    public void setAuthService(AuthServiceable service){
        this.authService = service;
    }

    @Override
    public String execute(){
        if(username == null){
            return INPUT;
        }
        boolean checkcodeOk = validateCheckcode();
        boolean success = false;
        if(checkcodeOk){
            User user = constructUser();
            try{
                authService.addUser(user);
                AuthUtil.setUser(user);
                success = true;
            }catch(Exception e){
                success = false;
            }
        }

        String json = String.format(JSON_FROMT, username,success,checkcodeOk);
        Struts2Util.renderJson(json);
        return NONE;
    }

    public void register(){
        
    }

    private User constructUser(){
        
        User user = new User();
        user.setUsername(username);
        user.setPassword(password);
        user.setName(name);
        user.setEmail(email);

        return user;
    }

    private boolean validateCheckcode(){
        String captchaId = ServletActionContext.getRequest().getSession().getId();
        checkcode = (checkcode == null ? "" : checkcode);
        checkcode = checkcode.toUpperCase();
        try {
            return captchaService.validateResponseForID(captchaId, checkcode);
        } catch (CaptchaServiceException e) {
            return false;
        }
    }
}

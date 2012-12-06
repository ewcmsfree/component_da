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
import com.opensymphony.xwork2.ActionSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
/**
 *
 * @author wangwei
 */
@Controller
public class PasswordAction extends ActionSupport{

	private static final long serialVersionUID = -3772450138816131164L;

	private String password;
    private String newpassword;
    @Autowired
    private AuthServiceable authService;

    public void setAuthService(AuthServiceable service){
        this.authService = service;
    }

    public void setNewpassword(String newpassword) {
        this.newpassword = newpassword;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public User getUser(){
        return AuthUtil.getUser();
    }

    @Override
    public String execute(){
        if(password == null && newpassword == null){
            return INPUT;
        }
        String username = (AuthUtil.getUser() == null ? "" : AuthUtil.getUser().getUsername());
        if(authService.login(username, password)){
            authService.updPassoword(username, newpassword);
            this.addActionMessage("密码修改成功");
        }else{
            this.addActionError("现在密码错误");
        }
        return SUCCESS;
    }
}

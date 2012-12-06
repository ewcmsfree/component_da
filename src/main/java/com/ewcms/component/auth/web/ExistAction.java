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

import com.ewcms.component.auth.service.AuthServiceable;
import com.ewcms.component.util.Struts2Util;
import org.springframework.stereotype.Controller;
import org.springframework.beans.factory.annotation.Autowired;

/**
 *
 * @author wangwei
 */
@Controller
public class ExistAction {

    private static final String JSON_FORMAT = "{\"exist\":%s}";
    private String username;
    @Autowired
    private AuthServiceable authService;

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setAuthService(AuthServiceable service){
        this.authService = service;
    }

    public void exist(){
        boolean isExist = authService.userExists(username.trim());
        String json = String.format(JSON_FORMAT, isExist);
        Struts2Util.renderJson(json);
    }
}

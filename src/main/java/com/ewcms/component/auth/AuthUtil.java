/**
 * Copyright (c)2010-2011 Enterprise Website Content Management System(EWCMS), All rights reserved.
 * EWCMS PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 * http://www.ewcms.com
 */
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ewcms.component.auth;

import com.ewcms.component.auth.vo.User;
import org.apache.struts2.ServletActionContext;

/**
 *
 * @author wangwei
 */
public class AuthUtil {

    public static final String USER_SESSION = "ewcms_user";

    public static boolean isLogin() {
        return getUser() != null;
    }

    public static User getUser() {
        return (User) ServletActionContext.getRequest().getSession().getAttribute(USER_SESSION);
    }

    public static void setUser(User user) {
        ServletActionContext.getRequest().getSession().setAttribute(USER_SESSION, user);
    }

    public static void clearUser(){
         ServletActionContext.getRequest().getSession().removeAttribute(USER_SESSION);
    }
}

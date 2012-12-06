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
import com.ewcms.component.auth.vo.UserInfo;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Calendar;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

/**
 *
 * @author wangwei
 */
@Controller
public class UserInfoAction extends ActionSupport {

	private static final long serialVersionUID = 4958456838084817166L;

	private static final Calendar calendar = Calendar.getInstance();
    private static final int MAX_YEAR = 100;
    private static final int MAX_MONTH = 12;
    private static final int MAX_DAY = 31;
    private static final int[] years;
    private static final int[] months;
    private static final int[] days;
    private boolean edit = false;

    static {
        years = new int[100];
        months = new int[MAX_MONTH];
        for (int i = 0; i < MAX_MONTH; i++) {
            months[i] = i + 1;
        }
        days = new int[MAX_DAY];
        for (int i = 0; i < MAX_DAY; i++) {
            days[i] = i + 1;
        }
    }
    private UserInfo userInfo;
    @Autowired
    private AuthServiceable authService;

    public UserInfo getUserInfo() {
        return this.userInfo;
    }

    public void setUserInfo(UserInfo userInfo) {
        this.userInfo = userInfo;
    }

    public void setAuthService(AuthServiceable service) {
        this.authService = service;
    }

    public int[] getYears() {
        calendar.setTimeInMillis(System.currentTimeMillis());
        int currentYear = calendar.get(Calendar.YEAR);

        for (int i = 0; i < MAX_YEAR; i++) {
            years[i] = currentYear - i;
        }

        return years;
    }

    public int[] getMonths() {
        return months;
    }

    public int[] getDays() {
        return days;
    }

    public void setEdit(boolean edit){
        this.edit = edit;
    }

    public boolean getEdit(){
        return this.edit;
    }

    @Override
    public String execute() {
        if (userInfo != null) {
            authService.updUserInfo(userInfo);
            User user = AuthUtil.getUser();
            user.setName(userInfo.getName());
            AuthUtil.setUser(user);
        }
        String username = getUsername();
        userInfo = authService.getUserInfo(username);
        edit = false;
        if (userInfo == null) {
            return ERROR;
        } else {
            return SUCCESS;
        }
    }

    private String getUsername(){
        User user = AuthUtil.getUser();
        return user == null ? null : user.getUsername();
    }
}

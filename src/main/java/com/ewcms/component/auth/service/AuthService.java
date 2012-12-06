/**
 * Copyright (c)2010-2011 Enterprise Website Content Management System(EWCMS), All rights reserved.
 * EWCMS PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 * http://www.ewcms.com
 */
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ewcms.component.auth.service;

import com.ewcms.component.auth.dao.UserDAOable;
import com.ewcms.component.auth.vo.User;
import com.ewcms.component.auth.vo.UserInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author wangwei
 */
@Service("authService")
public class AuthService implements AuthServiceable {

    @Autowired
    private UserDAOable userDAO;

    public void setUserDAO(UserDAOable dao) {
        userDAO = dao;
    }

    @Override
    public void addUser(User user) {
        userDAO.addUser(user);
    }

    @Override
    public User getUser(String username) {
        return userDAO.getUser(username);
    }

    @Override
    public void updUserInfo(UserInfo userInfo) {
        userDAO.updUserInfo(userInfo);
    }

    @Override
    public UserInfo getUserInfo(String username){
        return userDAO.getUserInfo(username);
    }

    @Override
    public void updPassoword(String username, String password) {
        userDAO.updPassword(username, password);
    }

    @Override
    public void invalidateUser(String username) {
        userDAO.invalidateUser(username);
    }

    @Override
    public boolean userExists(String username) {
        return userDAO.userExist(username);
    }

    @Override
    public boolean login(final String username, final String password) {

        User user = userDAO.getUser(username);

        if (user == null) {
            return false;
        }

        if (!user.isEnabled()) {
            return false;
        }

        if (password == null) {
            return false;
        }

        if (!user.getPassword().equals(password.trim())) {
            return false;
        }

        return true;
    }
}

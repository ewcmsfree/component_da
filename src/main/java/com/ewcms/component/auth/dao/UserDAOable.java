/**
 * Copyright (c)2010-2011 Enterprise Website Content Management System(EWCMS), All rights reserved.
 * EWCMS PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 * http://www.ewcms.com
 */
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.ewcms.component.auth.dao;

import com.ewcms.component.auth.vo.User;
import com.ewcms.component.auth.vo.UserInfo;

/**
 *
 * @author wangwei
 */
public interface UserDAOable {

    public void addUser(User user);

    public User getUser(String username);

    public void updUserInfo(UserInfo userInfo);

    public UserInfo getUserInfo(String username);

    public void updPassword(String username,String password);

    public void invalidateUser(String username);

    public boolean userExist(String username);
}

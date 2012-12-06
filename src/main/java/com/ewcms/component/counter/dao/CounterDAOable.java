/**
 * Copyright (c)2010-2011 Enterprise Website Content Management System(EWCMS), All rights reserved.
 * EWCMS PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 * http://www.ewcms.com
 */
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.ewcms.component.counter.dao;

import com.ewcms.component.counter.vo.Counter;

/**
 *
 * @author wangwei
 */
public interface CounterDAOable {

    public void updCount(int article);

    public Integer getCount(int article);

    public void addCountLog(Counter log);

}

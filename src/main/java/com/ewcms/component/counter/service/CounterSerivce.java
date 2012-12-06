/**
 * Copyright (c)2010-2011 Enterprise Website Content Management System(EWCMS), All rights reserved.
 * EWCMS PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 * http://www.ewcms.com
 */
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.ewcms.component.counter.service;

import com.ewcms.component.counter.dao.CounterDAOable;
import com.ewcms.component.counter.vo.Counter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author wangwei
 */
@Service("counterService")
public class CounterSerivce implements CounterServiceable{

    @Autowired
    private CounterDAOable countDAO;
    public void setCountDAO(CounterDAOable dao){
        countDAO = dao;
    }
    
    @Override
    public Integer writeCountLog(final Counter count) {
        countDAO.addCountLog(count);
        countDAO.updCount(count.getArticleId());
        return countDAO.getCount(count.getArticleId());
    }
}

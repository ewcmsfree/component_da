/**
 * Copyright (c)2010-2011 Enterprise Website Content Management System(EWCMS), All rights reserved.
 * EWCMS PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 * http://www.ewcms.com
 */
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.ewcms.component.rss.service;

import com.ewcms.component.rss.dao.RssDAO;
import com.ewcms.component.rss.vo.Channel;
import com.ewcms.component.rss.vo.Item;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author wangwei
 */
@Service
public class RssService {

    @Autowired
    private RssDAO dao;

     public Channel getChannel(Integer id) {
         return dao.getChannel(id);
     }

     public List<Item> findItemByChannel(Integer id,Integer row){
         return dao.findItemByChannel(id, row);
     }
}

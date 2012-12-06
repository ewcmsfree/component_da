/**
 * Copyright (c)2010-2011 Enterprise Website Content Management System(EWCMS), All rights reserved.
 * EWCMS PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 * http://www.ewcms.com
 */
package com.ewcms.component.gwh.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ewcms.component.gwh.dao.GwhDAO;
import com.ewcms.component.gwh.vo.ArticleVO;
import com.ewcms.component.gwh.vo.ChannelVO;

@Service
public class GwhService implements GwhSerivceable {
	
	@Autowired
	private GwhDAO gwhDAO;
	
	@Override
	public List<ChannelVO> findChannelList() {
		return gwhDAO.findChannelList();
	}
	
	@Override
	public List<ArticleVO> findGwhArticleList(String beginDate, String endDate,
			String searchChannel, String searchRange, String searchKey) {
		return gwhDAO.findGwhArticleList(beginDate, endDate, searchChannel, searchRange, searchKey);
	}
	
}

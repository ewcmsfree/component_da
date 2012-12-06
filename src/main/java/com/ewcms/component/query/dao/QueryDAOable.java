/**
 * Copyright (c)2010-2011 Enterprise Website Content Management System(EWCMS), All rights reserved.
 * EWCMS PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 * http://www.ewcms.com
 */
package com.ewcms.component.query.dao;

import java.util.List;

import com.ewcms.component.query.vo.Article;

public interface QueryDAOable {

	List<Article> findArtilce(String title, Integer channelId, String beginDate, String endDate, Boolean isContent);
}

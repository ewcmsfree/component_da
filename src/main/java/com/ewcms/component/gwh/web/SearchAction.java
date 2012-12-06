/**
 * Copyright (c)2010-2011 Enterprise Website Content Management System(EWCMS), All rights reserved.
 * EWCMS PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 * http://www.ewcms.com
 */
package com.ewcms.component.gwh.web;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import com.ewcms.component.gwh.service.GwhSerivceable;
import com.ewcms.component.gwh.vo.ChannelVO;
import com.opensymphony.xwork2.ActionSupport;

public class SearchAction extends ActionSupport {

	private static final long serialVersionUID = 3021002346457584024L;
	
	@Autowired
	private GwhSerivceable gwhService;
	
	public List<ChannelVO> getGwhChannelList(){
		 return gwhService.findChannelList();
	}
}

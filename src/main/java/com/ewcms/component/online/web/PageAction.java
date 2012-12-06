/**
 * Copyright (c)2010-2011 Enterprise Website Content Management System(EWCMS), All rights reserved.
 * EWCMS PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 * http://www.ewcms.com
 */
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ewcms.component.online.web;

import com.ewcms.component.vo.Page;
import com.opensymphony.xwork2.ActionSupport;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author wangwei
 */
public class PageAction extends ActionSupport {

	private static final long serialVersionUID = -1428739857990085101L;

	protected String pageNumber = "0";
    protected Page page;
    protected int row = 10;

    public void setPageNumber(String pageNumber) {
        this.pageNumber = pageNumber;
    }

    public Page getPage() {
        return this.page;
    }

    @SuppressWarnings("rawtypes")
	protected List pageList(final List all, final Page p) {
        int number = p.getPage() - 1;
        int size = p.getPageSize();
        int from = number * size;
        int allSize = all.size();
        if (from > allSize) {
            return new ArrayList();
        }
        int to = (number + 1) * size;
        to = to > allSize ? allSize : to;
        return all.subList(from, to);
    }
}

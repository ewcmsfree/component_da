/**
 * Copyright (c)2010-2011 Enterprise Website Content Management System(EWCMS), All rights reserved.
 * EWCMS PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 * http://www.ewcms.com
 */
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ewcms.component.auth.filter;

import com.ewcms.component.auth.AuthUtil;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;
import org.springframework.stereotype.Controller;

/**
 *
 * @author wangwei
 */
@Controller
public class AuthorityIntercept extends AbstractInterceptor {

	private static final long serialVersionUID = 3050468747468548800L;
	
	public static final String GOING_TO_URL_KEY = "GOING_TO";
	
    @Override
    public String intercept(ActionInvocation invocation) throws Exception {
        ActionContext ctx = invocation.getInvocationContext();
        Object user = ctx.getSession().get(AuthUtil.USER_SESSION);
        if (user != null) {
            return invocation.invoke();
        }
        setGoingToURL(ctx,invocation);
        return "login";
    }

    private void setGoingToURL(ActionContext ctx, ActionInvocation invocation) {
        String url = "";
        String namespace = invocation.getProxy().getNamespace();
        if (namespace.trim().length() != 0 && !namespace.equals("/")) {
            url = url + namespace;
        }
        String actionName = invocation.getProxy().getActionName();
        if (actionName.trim().length() != 0) {
            url = url + "/" + actionName + ".do";
        }
       
        ctx.getSession().put(GOING_TO_URL_KEY, url);
    }
}

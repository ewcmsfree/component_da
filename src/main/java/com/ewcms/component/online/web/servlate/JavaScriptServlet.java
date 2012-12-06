/**
 * Copyright (c)2010-2011 Enterprise Website Content Management System(EWCMS), All rights reserved.
 * EWCMS PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 * http://www.ewcms.com
 */
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ewcms.component.online.web.servlate;

import com.ewcms.component.online.service.OnlineService;
import java.io.IOException;
import java.io.Writer;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

/**
 *
 * @author wangwei
 */
public class JavaScriptServlet extends HttpServlet {

	private static final long serialVersionUID = -2571397979920003307L;

	private static final String JS_TYPE = "text/javascript";
    private static final String HEADER_ENCODING = "encoding";
    private static final String DEFAULT_ENCODING = "UTF-8";
    private static final String CALLBACK_PARAMETER_NAME = "callback";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String encoding = getParameterValue(request, HEADER_ENCODING);
        encoding = (encoding == null ? DEFAULT_ENCODING : encoding);
         initResponseHeader(response, encoding);

        String callback = getParameterValue(request, CALLBACK_PARAMETER_NAME);
        String value;
        if (callback == null) {
            value = "alert('请设置显示浏览次数回调函数');";
        } else {
            OnlineService service = getOnlineService();
            String json =service.mainJSON();
            value = String.format("%s(%s);", callback, json);
        }
        Writer writer = response.getWriter();
        writer.write(value);
        writer.flush();
    }

    private String getParameterValue(HttpServletRequest request, final String parameter) {
        return request.getParameter(parameter);
    }

    private void initResponseHeader(final HttpServletResponse response, final String encoding) {
        response.setHeader("Content-Language", "zh-CN");
        String fullContentType = JS_TYPE + ";charset=" + encoding;
        response.setContentType(fullContentType);
    }

    private OnlineService getOnlineService() {
        ServletContext application = getServletContext();
        WebApplicationContext wac = WebApplicationContextUtils.getWebApplicationContext(application);
        return (OnlineService) wac.getBean("onlineService");
    }
}

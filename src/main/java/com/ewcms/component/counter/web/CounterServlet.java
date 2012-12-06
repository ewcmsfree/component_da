/**
 * Copyright (c)2010-2011 Enterprise Website Content Management System(EWCMS), All rights reserved.
 * EWCMS PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 * http://www.ewcms.com
 */
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ewcms.component.counter.web;

import com.ewcms.component.counter.service.CounterServiceable;
import com.ewcms.component.counter.vo.Counter;
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
public class CounterServlet extends HttpServlet {

	private static final long serialVersionUID = 6989327982902762679L;

	private static final String JS_TYPE = "text/javascript";
    private static final String HEADER_ENCODING = "encoding";
    private static final String DEFAULT_ENCODING = "UTF-8";
    private static final String HTMLID_PARAMETER_NAME = "article_id";
    private static final String CALLBACK_PARAMETER_NAME = "callback";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Counter log = new Counter();
        log.setArticleId(getArticleId(request));
        String ip = request.getRemoteAddr();
        log.setIp(ip);
        int count = 10;
        if (!isArticleIdEmpty(log.getArticleId())) {
            CounterServiceable service = getCountSerivce();
            count = service.writeCountLog(log);
        }
        String encoding = getParameterValue(request, HEADER_ENCODING);
        encoding = (encoding == null ? DEFAULT_ENCODING : encoding);
        reponseCount(request, response, encoding, count);
    }

    private int getArticleId(HttpServletRequest request) {
        String value = getParameterValue(request, HTMLID_PARAMETER_NAME);
        return intValue(value);

    }

    private String getParameterValue(HttpServletRequest request, final String parameter) {
        return request.getParameter(parameter);
    }

    private int intValue(final String value) {
        if (value == null || value.trim().length() == 0) {
            return -1;
        }
        try {
            return Integer.valueOf(value);
        } catch (NumberFormatException e) {
            return -1;
        }
    }

    private boolean isArticleIdEmpty(final int articleId) {
        return articleId == -1 ? true : false;
    }

    private void reponseCount(HttpServletRequest request, HttpServletResponse response, final String encoding, final int count) throws IOException {
        initResponseHeader(response, encoding);

        String callback = getParameterValue(request, CALLBACK_PARAMETER_NAME);
        String value;
        if (callback == null) {
            value = "alert('请设置显示浏览次数回调函数');";
        } else {
            value = String.format("%s(\"%d\");", callback, count);
        }
        Writer writer = response.getWriter();
        writer.write(value);
        writer.flush();
    }

    private void initResponseHeader(final HttpServletResponse response, final String encoding) {
        response.setHeader("Content-Language", "zh-CN");
        String fullContentType = JS_TYPE + ";charset=" + encoding;
        response.setContentType(fullContentType);
        //set on cache
        ///Http 1.0 header
        response.setDateHeader("Expires", 0);
        response.addHeader("Pragma", "no-cache");
        //Http 1.1 header
        response.setHeader("Cache-Control", "no-cache");
    }

    private CounterServiceable getCountSerivce() {
        ServletContext application = getServletContext();
        WebApplicationContext wac = WebApplicationContextUtils.getWebApplicationContext(application);

        return (CounterServiceable) wac.getBean("counterService");
    }
}

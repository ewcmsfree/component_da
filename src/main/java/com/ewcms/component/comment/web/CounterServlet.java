/**
 * Copyright (c)2010-2011 Enterprise Website Content Management System(EWCMS), All rights reserved.
 * EWCMS PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 * http://www.ewcms.com
 */
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ewcms.component.comment.web;

import com.ewcms.component.comment.service.CommentServiceable;
import com.ewcms.component.comment.vo.CommentCount;
import com.ewcms.component.util.RegexUtil;

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

	private static final long serialVersionUID = -702727997072029888L;

	private static final String JSON_TYPE = "application/json";
    private static final String HEADER_ENCODING = "encoding";
    private static final String DEFAULT_ENCODING = "UTF-8";
    protected static final String ARTICLE_ID_PARAMETER_NAME = "article_id";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CommentCount commentCount;
        int articleId = getArticleId(request);
        if (articleId == -1) {
            commentCount = new CommentCount();
            commentCount.setCommentCounter(0);
            commentCount.setPersonCounter(0);
        } else {
            CommentServiceable service = getCommentService();
            commentCount = service.getCommentCount(articleId);
        }
        String encoding = getParameterValue(request, HEADER_ENCODING);
        encoding = (encoding == null ? DEFAULT_ENCODING : encoding);
        responseJSON(request, response, encoding, commentCount);
    }

    protected String getParameterValue(HttpServletRequest request, final String parameter) {
        return RegexUtil.FilterScriptAndStyle(request.getParameter(parameter));
    }

    protected int getArticleId(HttpServletRequest request) {
        String articleId = getParameterValue(request, ARTICLE_ID_PARAMETER_NAME);
        if (articleId == null || articleId.trim().length() == 0) {
            return -1;
        }
        try {
            return Integer.valueOf(articleId);
        } catch (NumberFormatException e) {
            return -1;
        }
    }

    private void responseJSON(HttpServletRequest request, HttpServletResponse response, final String encoding, final CommentCount count) throws IOException {
        initResponseHeader(response, encoding);
        String callback = request.getParameter("jsoncallback");
        String value = String.format("%s({\"commentCounter\":\"%d\",\"personCounter\":\"%d\"});",
                callback,count.getCommentCounter(), count.getPersonCounter());

        Writer writer = response.getWriter();
        writer.write(value);
        writer.flush();
    }

    private void initResponseHeader(final HttpServletResponse response, final String encoding) {
        response.setHeader("Content-Language", "zh-CN");
        String fullContentType = JSON_TYPE + ";charset=" + encoding;
        response.setContentType(fullContentType);
        //set on cache
        ///Http 1.0 header
        response.setDateHeader("Expires", 0);
        response.addHeader("Pragma", "no-cache");
        //Http 1.1 header
        response.setHeader("Cache-Control", "no-cache");
    }

    protected CommentServiceable getCommentService() {
        ServletContext application = getServletContext();
        WebApplicationContext wac = WebApplicationContextUtils.getWebApplicationContext(application);

        return (CommentServiceable) wac.getBean("commentService");
    }
}

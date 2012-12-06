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
import com.ewcms.component.comment.vo.Comment;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 *
 * @author wangwei
 */
public class InputServlet extends CounterServlet {

	private static final long serialVersionUID = 957219574506649946L;

	private static final String CONTENT_PARAM_NAME = "content";
    private static final String USER_PARAM_NAME = "user";
    
     @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        int articleId = getArticleId(request);
        String conetent = this.getParameterValue(request, CONTENT_PARAM_NAME);
        String user = this.getParameterValue(request, USER_PARAM_NAME);
        String ip = getIP(request);

        Comment comment = new Comment();
        comment.setArticleId(articleId);
        comment.setContent(conetent);
        comment.setUsername(user);
        comment.setIp(ip);

        CommentServiceable service = getCommentService();
        service.addComment(comment);

        super.doPost(request, response);
    }

    private String getIP(HttpServletRequest request){
        return request.getRemoteAddr();
    }
}

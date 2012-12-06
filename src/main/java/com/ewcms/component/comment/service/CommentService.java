/**
 * Copyright (c)2010-2011 Enterprise Website Content Management System(EWCMS), All rights reserved.
 * EWCMS PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 * http://www.ewcms.com
 */
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ewcms.component.comment.service;

import com.ewcms.component.comment.dao.CommentDAOable;
import com.ewcms.component.comment.vo.Comment;
import com.ewcms.component.comment.vo.CommentCount;
import com.ewcms.component.comment.vo.Reply;
import java.util.List;
import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;

/**
 *
 * @author wangwei
 */
@Service("commentService")
public class CommentService implements CommentServiceable {

    @Autowired
    private CommentDAOable commentDAO;

    public void setCommentDAO(CommentDAOable dao) {
        this.commentDAO = dao;
    }

    @Override
    public void addComment(Comment comment) {
        commentDAO.addComment(comment);
    }

    @Override
    public void addReply(Reply reply) {
        commentDAO.addReply(reply);
    }

    @Override
    public List<Comment> findCommentPage(int articleId, int page, int row) {
        return commentDAO.findCommentPage(articleId, page, row);
    }

    @Override
    public CommentCount getCommentCount(int articleId) {
        return commentDAO.getCommentCount(articleId);
    }
}

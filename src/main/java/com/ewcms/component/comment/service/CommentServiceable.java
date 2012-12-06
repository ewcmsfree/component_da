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

import com.ewcms.component.comment.vo.Comment;
import com.ewcms.component.comment.vo.CommentCount;
import com.ewcms.component.comment.vo.Reply;
import java.util.List;

/**
 *
 * @author wangwei
 */
public interface CommentServiceable {

    public void addComment(Comment comment);

    public void addReply(Reply reply);

    public List<Comment> findCommentPage(int articleId,int page,int row);

    public CommentCount getCommentCount(int articleId);

}

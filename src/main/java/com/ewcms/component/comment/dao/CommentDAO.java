/**
 * Copyright (c)2010-2011 Enterprise Website Content Management System(EWCMS), All rights reserved.
 * EWCMS PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 * http://www.ewcms.com
 */
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ewcms.component.comment.dao;

import com.ewcms.component.comment.vo.Comment;
import com.ewcms.component.comment.vo.CommentCount;
import com.ewcms.component.comment.vo.Reply;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import javax.sql.DataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

/**
 *
 * @author wangwei
 */
@Repository
public class CommentDAO implements CommentDAOable {

    private JdbcTemplate jdbcTemplate;

    @Autowired
    public void setDataSource(DataSource dataSource) {
        jdbcTemplate = new JdbcTemplate();
        jdbcTemplate.setDataSource(dataSource);
    }

    @Override
    public void addComment(final Comment comment) {

        String sql = "Insert Into component_comment "
                + "(article_id,username,ip,content,date) "
                + "Values (?,?,?,?,?)";

        jdbcTemplate.update(sql, comment.getArticleId(),
                comment.getUsername(), comment.getIp(),
                comment.getContent(), comment.getDate());

        boolean exist = commentCountExist(comment.getArticleId());
        updateCommentCount(comment.getArticleId(), exist);
    }

    private boolean commentCountExist(final int articleId) {
        String sql = "Select count(article_id) "
                + "From component_comment_counter "
                + "Where article_id=?";

        int count = jdbcTemplate.queryForInt(sql, articleId);
        return count == 0 ? false : true;
    }

    private void updateCommentCount(final int articleId, final boolean exist) {
        if (exist) {
            String sql = "Update component_comment_counter "
                    + "Set person_counter = person_counter + 1 "
                    + "Where article_id = ?";

            jdbcTemplate.update(sql, articleId);
        } else {
            String sql = "Insert Into component_comment_counter "
                    + "(article_id,comment_counter,person_counter) "
                    + "Values (?,?,?)";

            jdbcTemplate.update(sql, articleId, 0, 1);
        }
    }

    @Override
    public void addReply(final Reply reply) {
        String sql = "Insert Into component_comment_reply "
                + "(article_id,comment_id,username,id,content,date) "
                + "Value (?,?,?,?,?,?)";

        jdbcTemplate.update(sql,
                reply.getArticleId(), reply.getCommentId(),
                reply.getUsername(), reply.getIp(),
                reply.getContent(), reply.getDate());

        updateCommentCount(reply.getArticleId(), true);
    }

    @Override
    public List<Comment> findCommentPage(final int articleId, final int page, final int row) {
        String sql = "Select * From component_comment Where article_id = ? Limit ? OffSet ?";
        int offset = page * row;
        Object[] params = {articleId, row, offset};
        return jdbcTemplate.query(sql, params, new RowMapper<Comment>() {

            @Override
            public Comment mapRow(ResultSet rs, int rowNum) throws SQLException {
                Comment comment = new Comment();
                comment.setId(rs.getLong("id"));
                comment.setArticleId(rs.getInt("article_id"));
                comment.setIp(rs.getString("ip"));
                comment.setUsername(rs.getString("username"));
                comment.setDate(rs.getTimestamp("date"));
                comment.setReplies(findReply(comment.getId()));
                return comment;
            }
        });
    }

    private List<Reply> findReply(final Long commentId) {
        String sql = "Select * From component_comment_reply Where comment_id = ?";
        Object[] params = {commentId};
        return jdbcTemplate.query(sql, params, new RowMapper<Reply>() {

            @Override
            public Reply mapRow(ResultSet rs, int rowNum) throws SQLException {
                Reply reply = new Reply();
                reply.setId(rs.getLong("id"));
                reply.setCommentId(commentId);
                reply.setIp(rs.getString("ip"));
                reply.setUsername(rs.getString("username"));
                reply.setDate(rs.getTimestamp("date"));
                return reply;
            }
        });
    }

    @Override
    public CommentCount getCommentCount(final int articleId) {
        String sql = "Select * From component_comment_counter Where article_id=?";

        Object[] params = {articleId};
        List<CommentCount> list = jdbcTemplate.query(sql, params, new RowMapper<CommentCount>() {

            @Override
            public CommentCount mapRow(ResultSet rs, int rowNum) throws SQLException {
                CommentCount count = new CommentCount();
                count.setArticleId(rs.getInt("article_id"));
                count.setCommentCounter(rs.getInt("comment_counter"));
                count.setPersonCounter(rs.getInt("person_counter"));
                return count;
            }
        });
        if (list.isEmpty()) {
            CommentCount count = new CommentCount();
            count.setArticleId(articleId);
            count.setCommentCounter(0);
            count.setPersonCounter(0);

            return count;
        }

        return list.get(0);
    }
}

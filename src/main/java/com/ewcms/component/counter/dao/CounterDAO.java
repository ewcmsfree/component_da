/**
 * Copyright (c)2010-2011 Enterprise Website Content Management System(EWCMS), All rights reserved.
 * EWCMS PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 * http://www.ewcms.com
 */
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ewcms.component.counter.dao;

import com.ewcms.component.counter.vo.Counter;
import javax.sql.DataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

/**
 *
 * @author wangwei
 */
@Repository
public class CounterDAO implements CounterDAOable {

    private JdbcTemplate jdbcTemplate;

    @Autowired
    public void setDataSource(DataSource dataSource) {
        jdbcTemplate = new JdbcTemplate();
        jdbcTemplate.setDataSource(dataSource);
    }

    @Override
    public void updCount(final int articleId) {
        boolean exist = articleCountExist(articleId);
        if (exist) {
            String sql = "Update component_counter Set counter = counter + 1 Where article_id = ?";
            jdbcTemplate.update(sql,articleId);
        } else {
            String sql = "Insert Into component_counter (article_id,counter) values (?,?)";
            jdbcTemplate.update(sql, articleId,new Integer(1));
        }
    }

    private boolean articleCountExist(final int articleId) {
        String sql = "Select Count(article_id) From component_counter Where article_id = ?";
        int count = jdbcTemplate.queryForInt(sql, articleId);
        return count == 0 ? false : true;
    }

    @Override
    public Integer getCount(final int articleId) {
        String sql = "Select counter From component_counter Where article_id = ?";
        int count = jdbcTemplate.queryForInt(sql, articleId);
        return count;
    }

    @Override
    public void addCountLog(final Counter log) {
        String sql = "Insert Into component_counter_log(article_id,ip,date) values (?,?,?)";
        jdbcTemplate.update(sql, log.getArticleId(), log.getIp(), log.getDate());
    }
}

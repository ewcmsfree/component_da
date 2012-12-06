/**
 * Copyright (c)2010-2011 Enterprise Website Content Management System(EWCMS), All rights reserved.
 * EWCMS PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 * http://www.ewcms.com
 */
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.ewcms.component.hot.dao;

import com.ewcms.component.hot.vo.Hot;
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
public class HotDAO {

    private JdbcTemplate jdbcTemplate;

    @Autowired
    public void setDataSource(DataSource dataSource) {
        jdbcTemplate = new JdbcTemplate();
        jdbcTemplate.setDataSource(dataSource);
    }

    public List<Hot> findHot(){
        String sql = "Select t3.title,t3.url From component_counter t1,content_article_main t2,content_article t3 "
                +"Where t1.article_id = t2.article_id And t2.article_id = t3.id "
                +"And t2.reference=false And t3.status='RELEASE' And t3.url is not null"
               //+"And t3.published > (CURRENT_DATE - 30)"
                +"Order by t1.counter Desc Limit 3";

        return jdbcTemplate.query(sql, new RowMapper<Hot>() {
            @Override
            public Hot mapRow(ResultSet rs, int rowNum) throws SQLException {
                Hot hot = new Hot();

                hot.setTitle(rs.getString("title"));
                hot.setUrl(rs.getString("url"));
                return hot;
            }

        });
    }
}

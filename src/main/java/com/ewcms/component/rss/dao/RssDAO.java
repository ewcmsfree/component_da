/**
 * Copyright (c)2010-2011 Enterprise Website Content Management System(EWCMS), All rights reserved.
 * EWCMS PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 * http://www.ewcms.com
 */
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ewcms.component.rss.dao;

import com.ewcms.component.rss.vo.Channel;
import com.ewcms.component.rss.vo.Item;
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
public class RssDAO {

    private JdbcTemplate jdbcTemplate;

    @Autowired
    public void setDataSource(DataSource dataSource) {
        jdbcTemplate = new JdbcTemplate();
        jdbcTemplate.setDataSource(dataSource);
    }

    public Channel getChannel(Integer id) {
        String sql = "Select name , absurl From site_channel Where id=?";

        List<Channel> list = jdbcTemplate.query(sql, new Object[]{id}, new RowMapper<Channel>() {

            @Override
            public Channel mapRow(ResultSet rs, int rowNum) throws SQLException {
                Channel channel = new Channel();
                channel.setTitle(rs.getString(1));
                channel.setUrl(rs.getString(2));

                return channel;
            }
        });

        return list.isEmpty() ? null : list.get(0);
    }

    public List<Item> findItemByChannel(Integer id, Integer row) {
    	String sql = "Select t2.title,t2.url,t2.summary,t2.published From content_article_main t1,content_article t2 "
    			+ " Where t1.article_id = t2.id And t1.channel_id = ? "
    			+ " And t2.published < now() And t2.status='RELEASE' " 
                + " Order By t2.published Desc Limit ? ";

        return jdbcTemplate.query(sql, new Object[]{id, row}, new RowMapper<Item>() {

            @Override
            public Item mapRow(ResultSet rs, int rowNum) throws SQLException {
                Item item = new Item();
                item.setTitle(rs.getString("title"));
                item.setUrl(rs.getString("url"));
                item.setDescription(rs.getString("summary"));
                item.setPublished(rs.getDate("published"));

                return item;
            }
        });
    }
}

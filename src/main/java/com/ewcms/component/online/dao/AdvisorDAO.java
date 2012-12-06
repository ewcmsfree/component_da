/**
 * Copyright (c)2010-2011 Enterprise Website Content Management System(EWCMS), All rights reserved.
 * EWCMS PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 * http://www.ewcms.com
 */
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ewcms.component.online.dao;

import com.ewcms.component.online.vo.Advisor;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import javax.sql.DataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

/**
 *
 * @author wangwei
 */
@Repository
public class AdvisorDAO {

    private JdbcTemplate jdbcTemplate;

    @Autowired
    public void setDataSource(DataSource ds) {
        jdbcTemplate = new JdbcTemplate(ds);
    }

    public int add(final Advisor vo) {
        final String sql = "Insert Into plugin_online_advisory "
                + "(username,name,title,content,organ_id,matter_id,ip) Values "
                + "(?,?,?,?,?,?,?)";

        jdbcTemplate.update(new PreparedStatementCreator() {

            @Override
            public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setString(1, vo.getUsername());
                ps.setString(2, vo.getName());
                ps.setString(3, vo.getTitle());
                ps.setString(4, vo.getContent());
                ps.setInt(5, vo.getOrganId());
                ps.setInt(6, vo.getMatterId());
                ps.setString(7, vo.getIp());

                return ps;
            }
        });
        return jdbcTemplate.queryForInt("select currval('seq_plugin_online_advisory_id')");
    }

    public List<Advisor> findAdvisorByMatter(final Integer matterId, String title, final int limit) {
        String sql = "Select * From plugin_online_advisory "
                + "Where matter_id = ? And title Like ? And checked = true "
                + "Order By date Desc";
        title = (title == null || title.trim().length() == 0) ? "%" : "%" + title + "%";

        return jdbcTemplate.query(sql, new Object[]{matterId, title}, new RowMapper<Advisor>() {

            @Override
            public Advisor mapRow(ResultSet rs, int rowNum) throws SQLException {
                Advisor advisor = new Advisor();
                advisor.setId(rs.getInt("id"));
                advisor.setTitle(rs.getString("title"));
                advisor.setName(rs.getString("name"));
                advisor.setState(rs.getInt("state"));
                advisor.setDate(rs.getDate("date"));
                return advisor;
            }
        });
    }

    public List<Advisor> findAdvisorByUsernam(String username) {
        String sql = "Select t1.id As t1_id,t1.title As t1_title,t1.content As t1_content,"
                + "t1.replay As t1_replay,t1.state As t1_state,t1.date As t1_date,"
                + "t2.id as t2_id,t2.matter_name As t2_name,t3.id As t3_id,t3.name As t3_name "
                + "From plugin_online_advisory t1 "
                + "LEFT JOIN plugin_matter t2 ON t1.matter_id =t2.id "
                + "LEFT JOIN site_organ t3 ON t1.organ_id=t3.id "
                + "Where t1.username = ? "
                + "Order By t1.date Desc";

        return jdbcTemplate.query(sql, new Object[]{username}, new RowMapper<Advisor>() {

            @Override
            public Advisor mapRow(ResultSet rs, int rowNum) throws SQLException {
                Advisor advisor = new Advisor();
                advisor.setId(rs.getInt("t1_id"));
                advisor.setTitle(rs.getString("t1_title"));
                advisor.setState(rs.getInt("t1_state"));
                advisor.setDate(rs.getDate("t1_date"));
                advisor.setContent(rs.getString("t1_content"));
                advisor.setReplay(rs.getString("t1_replay"));
                advisor.setMatterId(rs.getInt("t2_id"));
                advisor.setMatterName(rs.getString("t2_name"));
                advisor.setOrganId(rs.getInt("t3_id"));
                advisor.setOrganName(rs.getString("t3_name"));
                
                return advisor;
            }
        });
    }
}

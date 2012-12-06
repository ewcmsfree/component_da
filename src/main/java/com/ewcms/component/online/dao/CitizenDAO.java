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

import com.ewcms.component.online.vo.Citizen;
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
public class CitizenDAO {

    private JdbcTemplate jdbcTemplate;

    @Autowired
    public void setDataSource(DataSource ds) {
        jdbcTemplate = new JdbcTemplate(ds);
    }

    public Citizen get(int id) {

        String sql = "Select * From content_citizen Where id=?";

        List<Citizen> list = jdbcTemplate.query(sql, new Object[]{id}, new RowMapper<Citizen>() {

            @Override
            public Citizen mapRow(ResultSet rs, int rowNum) throws SQLException {
                return citizenMapRow(rs);
            }
        });

        return list.isEmpty() ? null : list.get(0);
    }

    public List<Citizen> getAll() {
        String sql = "Select * From content_citizen Order By id Asc";

        return jdbcTemplate.query(sql, new RowMapper<Citizen>() {

            @Override
            public Citizen mapRow(ResultSet rs, int rowNum) throws SQLException {
                return citizenMapRow(rs);
            }
        });
    }

    private Citizen citizenMapRow(ResultSet rs) throws SQLException {
        Citizen citizen = new Citizen();
        citizen.setId(rs.getInt("id"));
        citizen.setName(rs.getString("citizen_name"));

        return citizen;
    }
}

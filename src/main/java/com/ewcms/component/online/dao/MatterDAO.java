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

import com.ewcms.component.online.vo.Matter;
import com.ewcms.component.online.vo.MatterAnnex;
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
public class MatterDAO {

    private JdbcTemplate jdbcTemplate;

    @Autowired
    public void setDataSource(DataSource ds) {
        jdbcTemplate = new JdbcTemplate(ds);
    }

    public Matter get(Integer id){
        String sql = "Select * From plugin_matter Where id = ? ";
        
        List<Matter> list = jdbcTemplate.query(sql, new Object[]{id},new RowMapper<Matter>(){

            @Override
            public Matter mapRow(ResultSet rs, int rowNum) throws SQLException {
                Matter matter = new Matter();
                matter.setId(rs.getInt("id"));
                matter.setName(rs.getString("matter_name"));
                matter.setAcceptedCondition(rs.getString("accepted_condition"));
                matter.setAcceptedWay(rs.getString("accepted_way"));
                matter.setConsultingTel(rs.getString("consulting_tel"));
                matter.setContactName(rs.getString("contact_name"));
                matter.setContactTel(rs.getString("contact_tel"));
                matter.setDeadline(rs.getString("deadline"));
                matter.setDepartment(rs.getString("department"));
                matter.setEmail(rs.getString("email"));
                matter.setFees(rs.getString("fees"));
                matter.setFeesBasis(rs.getString("fees_basis"));
                matter.setHandleBasis(rs.getString("handle_basis"));
                matter.setHandleCourse(rs.getString("handle_course"));
                matter.setHandleSite(rs.getString("handle_site"));
                matter.setHandleWay(rs.getString("handle_way"));
                matter.setPetitionMaterial(rs.getString("petition_material"));
                matter.setTimeLimit(rs.getString("time_limit"));

                return matter;
            }
        });
        if(list.isEmpty()){
            return null;
        }
        Matter matter = list.get(0);
        matter.setMatterAnnexs(findMatterAnnex(id));
        return matter;
    }

    private List<MatterAnnex> findMatterAnnex(final int matterId){
        String sql = "Select * From plugin_matter_annex "
                + "Where matter_id = ? "
                + "Order By sort Asc";

        return jdbcTemplate.query(sql, new Object[]{matterId},new RowMapper<MatterAnnex>(){

            @Override
            public MatterAnnex mapRow(ResultSet rs, int rowNum) throws SQLException {
                MatterAnnex annex = new MatterAnnex();

                annex.setId(rs.getInt("id"));
                annex.setName(rs.getString("legend"));
                annex.setUrl(rs.getString("url"));
                
                return annex;
            }
        });
    }
}

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

import com.ewcms.component.online.vo.MatterAnnex;
import com.ewcms.component.online.vo.Organ;
import com.ewcms.component.online.vo.Article;
import com.ewcms.component.online.vo.Working;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.sql.DataSource;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

/**
 *
 * @author wangwei
 */
@Repository
public class WorkingDAO {

    private JdbcTemplate jdbcTemplate;
    @Autowired
    private MatterDAO matterDAO;

    @Autowired
    public void setDataSource(DataSource ds) {
        jdbcTemplate = new JdbcTemplate(ds);
    }

    public List<Working> getPosition(Integer id) {
        List<Working> list = new ArrayList<Working>();
        Working working = get(id);
        for (; working != null && working.getParentId() != null;) {
            list.add(0, working);
            working = get(working.getParentId());
        }
        return list;
    }

    public Working get(Integer id) {
        String sql = "Select id,name,parent_id From plugin_workingbody "
                + "Where id=?";

        List<Working> list = jdbcTemplate.query(sql, new Object[]{id}, new RowMapper<Working>() {

            @Override
            public Working mapRow(ResultSet rs, int rowNum) throws SQLException {
                Working working = new Working();
                working.setId(rs.getInt("id"));
                working.setName(rs.getString("name"));
                working.setParentId(rs.getInt("parent_id"));
                Integer matterId = getMatterId(working.getId());
                if (matterId == null) {
                    working.setMatter(null);
                } else {
                    working.setMatter(matterDAO.get(matterId));
                }
                working.setChildren(getChildren(working.getId()));
                return working;
            }
        });
        if (list.isEmpty()) {
            return null;
        }
        Working working = list.get(0);

        return working;
    }

    public List<Article> findArticle(int id) {

//        String sql = "Select url,title,published From plugin_workingbody_articlemain t1,content_article_main t2,content_article t3 "
//                + "Where t1.articlemain_id = t2.id And t2.article_id = t3.id And t3.status ='RELEASE' And t1.workingbody_id = ? "
//                + "Order By t3.published";
    	String sql = "Select url,title,published From " +
    			"plugin_workingbody_articlemain t1 left join content_article_main t2 on t1.articlemain_id=t2.id " +
    			"left join content_article t3 on t2.article_id=t3.id " +
    			"Where t3.status ='RELEASE' And t1.workingbody_id = ?  Order By t3.published ";
    	
        List<Article> articles = jdbcTemplate.query(sql, new Object[]{id}, new RowMapper<Article>() {
            @Override
            public Article mapRow(ResultSet rs, int rowNum) throws SQLException {
                Article article = new Article();
                article.setUrl(rs.getString("url"));
                article.setTitle(rs.getString("title"));
                article.setPublished(rs.getDate("published"));
                return article;
            }
        });


        return articles;

    }

    public Integer getMatterId(int workingId) {
        String sql = "Select t1.id "
                + "From plugin_matter t1 ,plugin_workingbody_matter t2 "
                + "Where  t1.id = t2.matter_id And t2.workingbody_id = ? ";

        List<Integer> ids = jdbcTemplate.query(sql, new Object[]{workingId}, new RowMapper<Integer>() {

            @Override
            public Integer mapRow(ResultSet rs, int rowNum) throws SQLException {
                return rs.getInt("id");
            }
        });

        return ids.isEmpty() ? null : ids.get(0);
    }

    public List<Working> getChildren(Integer id) {
        String sql = "Select t1.id As t1_id,t1.name As t1_name,t3.id As t3_id,t3.name As t3_name "
                + "From plugin_workingbody t1 "
                + "LEFT JOIN plugin_workingbody_organ t2 ON  t1.id = t2.workingbody_id "
                + "LEFT JOIN site_organ t3 ON  t2.organ_id = t3.id "
                + "Where t1.parent_id=? "
                + "Order By sort Asc";

        return jdbcTemplate.query(sql, new Object[]{id}, new RowMapper<Working>() {

            @Override
            public Working mapRow(ResultSet rs, int rowNum) throws SQLException {
                Working working = new Working();
                working.setId(rs.getInt("t1_id"));
                working.setName(rs.getString("t1_name"));
                working.setOrgan(new Organ(rs.getInt("t3_id"), rs.getString("t3_name")));
                return working;
            }
        });
    }

    public List<Working> findWorkingByCitizen(int citizenId) {
        String sql = "Select DISTINCT t1.id As t1_id,t1.name As t1_name,t3.id As t3_id,t3.name As t3_name "
                + "From plugin_workingbody t1 "
                + "LEFT JOIN plugin_workingbody_organ t2 ON  t1.id = t2.workingbody_id "
                + "LEFT JOIN site_organ t3 ON  t2.organ_id = t3.id "
                + "INNER JOIN plugin_workingbody_matter t4 ON t1.id = t4.workingbody_id "
                + "Where t4.matter_id IN (Select matter_id From plugin_matter_citizen Where citizen_id = ?) "
                + "Order By t1.id Asc";
        return jdbcTemplate.query(sql, new Object[]{citizenId}, new RowMapper<Working>() {

            @Override
            public Working mapRow(ResultSet rs, int rowNum) throws SQLException {

                Working working = new Working();
                working.setId(rs.getInt("t1_id"));
                working.setName(rs.getString("t1_name"));
                working.setOrgan(new Organ(rs.getInt("t3_id"), rs.getString("t3_name")));
                Integer matterId = getMatterId(working.getId());
                if (matterId == null) {
                    working.setMatter(null);
                } else {
                    working.setMatter(matterDAO.get(matterId));
                }
                working.setChildren(getChildren(working.getId()));
                return working;
            }
        });
    }

    public List<Working> getMatterChildren(Integer id) {

        String sql = "Select t1.id As t1_id,t1.name As t1_name,t3.id As t3_id,t3.name As t3_name "
                + "From plugin_workingbody t1 "
                + "LEFT JOIN plugin_workingbody_organ t2 ON  t1.id = t2.workingbody_id "
                + "LEFT JOIN site_organ t3 ON  t2.organ_id = t3.id "
                + "Where t1.parent_id=? "
                + "Order By sort Asc";

        return jdbcTemplate.query(sql, new Object[]{id}, new RowMapper<Working>() {

            @Override
            public Working mapRow(ResultSet rs, int rowNum) throws SQLException {
                Working working = new Working();
                working.setId(rs.getInt("t1_id"));
                working.setName(rs.getString("t1_name"));
                working.setOrgan(new Organ(rs.getInt("t3_id"), rs.getString("t3_name")));
                Integer matterId = getMatterId(working.getId());
                if (matterId == null) {
                    working.setMatter(null);
                } else {
                    working.setMatter(matterDAO.get(matterId));
                }
                working.setChildren(getChildren(working.getId()));
                return working;
            }
        });
    }

    public List<Working> getRootChildren() {
        String sql = "Select id,name From plugin_workingbody "
                + "Where parent_id In "
                + "(Select id From plugin_workingbody Where parent_id is null) "
                + "Order By sort Asc";

        return jdbcTemplate.query(sql, new RowMapper<Working>() {

            @Override
            public Working mapRow(ResultSet rs, int rowNum) throws SQLException {
                Working working = new Working();
                working.setId(rs.getInt("id"));
                working.setName(rs.getString("name"));
                return working;
            }
        });
    }

    public List<Working> findByName(String name) {
        String sql = "Select t1.id As t1_id,t1.name As t1_name,t3.id As t3_id,t3.name As t3_name "
                + "From plugin_workingbody t1 "
                + "LEFT JOIN plugin_workingbody_organ t2 ON  t1.id = t2.workingbody_id "
                + "LEFT JOIN site_organ t3 ON  t2.organ_id = t3.id "
                + "Where " 
//                + "t1.parent_id In "
//                + "(Select id From plugin_workingbody Where parent_id In (Select id From plugin_workingbody Where parent_id = (Select id From plugin_workingbody Where parent_id is null))) "
//                + "And " 
                + "t1.name like ? "
                + "Order By t1.id Asc";

        return jdbcTemplate.query(sql, new Object[]{"%" + name + "%"}, new RowMapper<Working>() {

            @Override
            public Working mapRow(ResultSet rs, int rowNum) throws SQLException {
                Working working = new Working();
                working.setId(rs.getInt("t1_id"));
                working.setName(rs.getString("t1_name"));
                working.setOrgan(new Organ(rs.getInt("t3_id"), rs.getString("t3_name")));
                Integer matterId = getMatterId(working.getId());
                if (matterId == null) {
                    working.setMatter(null);
                } else {
                    working.setMatter(matterDAO.get(matterId));
                }
                working.setChildren(getChildren(working.getId()));
                return working;
            }
        });
    }
    
    public List<MatterAnnex> findByAnnex(String name){
    	String sql = "Select t1.id As t1_id,t1.legend As t1_legend,t1.url As t1_url, t1.matter_id As t1_matter_id "
                + "From plugin_matter_annex t1 "
                + "Where t1.legend like ? "
                + "Order By t1.id Asc";

        return jdbcTemplate.query(sql, new Object[]{"%" + name + "%"}, new RowMapper<MatterAnnex>() {

            @Override
            public MatterAnnex mapRow(ResultSet rs, int rowNum) throws SQLException {
            	MatterAnnex matterAnnex = new MatterAnnex();
                matterAnnex.setId(rs.getInt("t1_id"));
                matterAnnex.setLegend(rs.getString("t1_legend"));
                matterAnnex.setUrl(rs.getString("t1_url"));
                Integer matterId = rs.getInt("t1_matter_id");
                if (matterId == null) {
                    matterAnnex.setMatter(null);
                } else {
                    matterAnnex.setMatter(matterDAO.get(matterId));
                }
                return matterAnnex;
            }
        });
    }

    public List<Organ> findOrganForWorking() {
        String sql = "Select id,name From site_organ Where id In "
                + "(select organ_id From plugin_workingbody_organ Group by organ_id Order by organ_id)";

        return jdbcTemplate.query(sql, new RowMapper<Organ>() {

            @Override
            public Organ mapRow(ResultSet rs, int rowNum) throws SQLException {
                return new Organ(rs.getInt("id"), rs.getString("name"));
            }
        });
    }

    public List<Working> findWorkingByOrgan(Integer id) {
        String sql = "Select t1.id As t1_id,t1.name As t1_name,t3.id As t3_id,t3.name As t3_name "
                + "From plugin_workingbody t1 "
                + "LEFT JOIN plugin_workingbody_organ t2 ON  t1.id = t2.workingbody_id "
                + "LEFT JOIN site_organ t3 ON  t2.organ_id = t3.id "
                + "Where t2.organ_id = ? Order By t1.id Asc";

        return jdbcTemplate.query(sql, new Object[]{id}, new RowMapper<Working>() {

            @Override
            public Working mapRow(ResultSet rs, int rowNum) throws SQLException {
                Working working = new Working();
                working.setId(rs.getInt("t1_id"));
                working.setName(rs.getString("t1_name"));
                working.setOrgan(new Organ(rs.getInt("t3_id"), rs.getString("t3_name")));
                Integer matterId = getMatterId(working.getId());
                if (matterId == null) {
                    working.setMatter(null);
                } else {
                    working.setMatter(matterDAO.get(matterId));
                }
                working.setChildren(getChildren(working.getId()));
                return working;
            }
        });
    }

    public Organ getOrgan(Integer id) {
        String sql = "Select id,name From site_organ Where id = ?";
        List<Organ> organs = jdbcTemplate.query(sql, new Object[]{id}, new RowMapper<Organ>() {

            @Override
            public Organ mapRow(ResultSet rs, int rowNum) throws SQLException {
                return new Organ(rs.getInt("id"), rs.getString("name"));
            }
        });
        return organs.isEmpty() ? null : organs.get(0);
    }
}

/**
 * Copyright (c)2010-2011 Enterprise Website Content Management System(EWCMS), All rights reserved.
 * EWCMS PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 * http://www.ewcms.com
 */
package com.ewcms.component.query.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.ewcms.component.query.vo.Article;

@Repository
public class QueryDAO implements QueryDAOable {
	
	private JdbcTemplate jdbcTemplate;

    @Autowired
    public void setDataSource(DataSource dataSource) {
        jdbcTemplate = new JdbcTemplate(dataSource);
    }
    
	private DateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
	
	@Override
	public List<Article> findArtilce(String title,Integer channelId, String beginDate, String endDate, Boolean isContent) {
		Boolean isIf = false;
		
		String sql = "Select r.id, a.title, a.author, a.published, a.url, s.name From content_article_main As r Left Join site_channel As s On r.channel_id = s.id Left Join content_article As a On r.article_id = a.id Left Join content_content As c On a.id=c.article_id Where @isIf@ And a.status='RELEASE' ";

		List<Object> params = new ArrayList<Object>();
		
		if (title != null && !title.trim().equals("")){
			isIf = true;
			sql += " And a.title Like ? ";
			params.add("%" + title + "%");
		}
		
		if (isContent != null && isContent){
			isIf = true;
			sql += " And c.detail Like ? ";
			params.add("%" + title + "%");
		}
		
		if (channelId != null && channelId.longValue() > 0){
			isIf = true;
			sql += " And s.id=? ";
			params.add(channelId);
		}
		
		if (beginDate != null && !beginDate.trim().equals("")){
			Date _beginDate;
			try {
				_beginDate = DATE_FORMAT.parse(beginDate);
				sql += " And a.published >= ?";
				isIf = true;
				params.add(_beginDate);
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		
		if (endDate != null && !endDate.trim().equals("")){
			try {
				Date _endDate = DATE_FORMAT.parse(endDate);
				sql += " And a.published <= ? ";
				isIf = true;
				params.add(_endDate);
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		
		if (isIf){
			sql = sql.replace("@isIf@", "1=1");
		}else{
			sql = sql.replace("@isIf@", "1<>1");
		}
		
		sql += " Order By a.published Desc";
		
		return jdbcTemplate.query(sql, params.toArray(), new RowMapper<Article>() {
            @Override
            public Article mapRow(ResultSet rs, int rowNum) throws SQLException {
                return articleRowMapper(rs);
            }
        });
	}
	
	 private Article articleRowMapper(ResultSet rs) throws SQLException {
		 Article vo = new Article();
	     vo.setTitle(rs.getString("title"));
	     vo.setAuthor(rs.getString("author"));
	     if (rs.getDate("published") != null){
	    	 vo.setPublished(DATE_FORMAT.format(rs.getDate("published")));
	     }
	     vo.setChannelName(rs.getString("name"));
	     vo.setUrl(rs.getString("url"));
	     return vo;
	 }
}

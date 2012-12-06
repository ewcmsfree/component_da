/**
 * Copyright (c)2010-2011 Enterprise Website Content Management System(EWCMS), All rights reserved.
 * EWCMS PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 * http://www.ewcms.com
 */
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.ewcms.component.auth.dao;

import com.ewcms.component.auth.vo.User;
import com.ewcms.component.auth.vo.UserInfo;
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
public class UserDAO implements UserDAOable{

    private JdbcTemplate jdbcTemplate;

    @Autowired
    public void setDataSource(DataSource dataSource){
        jdbcTemplate = new JdbcTemplate(dataSource);
    }
    @Override
    public void addUser(User user) {
        String sql = "Insert Into component_auth_user "
                + "(username,name,password,email,register_date) "
                + "Values (?,?,?,?,?)";

        jdbcTemplate.update(sql, user.getUsername(),user.getName(),
                user.getPassword(),user.getEmail(),user.getRegisterDate());

        sql = "Insert Into component_auth_userinfo (username,name) "
                + "Values(?,?)";
        jdbcTemplate.update(sql,user.getUsername(),user.getName());
    }

    @Override
    public User getUser(String username) {
        String sql = "Select * From component_auth_user Where username = ?";

        List<User> list =jdbcTemplate.query(sql,new Object[]{username} ,new RowMapper<User>(){

            @Override
            public User mapRow(ResultSet rs, int rowNum) throws SQLException {
                User user = new User();
                user.setUsername(rs.getString("username"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setEnabled(rs.getBoolean("enabled"));
                user.setRegisterDate(rs.getTimestamp("register_date"));

                return user;
            }
        });

        return list.isEmpty() ? null : list.get(0);
    }

    @Override
    public void updPassword(String username, String password) {
        String sql = "Update component_auth_user "
                + "Set password = ?"
                + "Where username = ?";

        jdbcTemplate.update(sql, password,username);
    }

    @Override
    public void invalidateUser(String username) {
        String sql = "Update component_auth_user "
                + "Set enabled = False "
                + "Where username = ?";

        jdbcTemplate.update(sql,username);
    }

    @Override
    public void updUserInfo(UserInfo userInfo) {
        String sql = "Update component_auth_userInfo Set "
                + "name = ? ,realname = ? ,sex = ? ,birth_year = ?,birth_month = ?,"
                + "birth_day = ? , education = ? ,zip = ? ,address = ? ,"
                + "phone = ? ,mphone = ? Where username = ?";

        jdbcTemplate.update(sql, userInfo.getName(),userInfo.getRealname(),
                userInfo.getSex(),userInfo.getBirthYear(),userInfo.getBirthMonth(),
                userInfo.getBirthDay(),userInfo.getEducation(),userInfo.getZip(),
                userInfo.getAddress(),userInfo.getPhone(),userInfo.getMphone(),
                userInfo.getUsername());

        sql = "Update component_auth_userinfo Set name = ? Where username=?";
        jdbcTemplate.update(sql,userInfo.getName(),userInfo.getUsername());
    }

    @Override
    public UserInfo getUserInfo(final String username){
        String sql = "Select * From component_auth_userinfo Where username = ?";
        return jdbcTemplate.queryForObject(sql, new Object[]{username}, new RowMapper<UserInfo>(){
            @Override
            public UserInfo mapRow(ResultSet rs, int rowNum) throws SQLException {
                UserInfo userInfo = new UserInfo();
                userInfo.setUsername(username);
                userInfo.setName(rs.getString("name"));
                userInfo.setRealname(rs.getString("realname"));
                userInfo.setSex(rs.getInt("sex"));
                userInfo.setEducation(rs.getInt("education"));
                userInfo.setBirthYear(rs.getInt("birth_year"));
                userInfo.setBirthMonth(rs.getInt("birth_month"));
                userInfo.setBirthDay(rs.getInt("birth_day"));
                userInfo.setZip(rs.getString("zip"));
                userInfo.setAddress(rs.getString("address"));
                userInfo.setPhone(rs.getString("phone"));
                userInfo.setMphone(rs.getString("mphone"));

                return userInfo;
            }
        });
    }

    @Override
    public boolean userExist(String username) {
        String sql = "Select count(username) From component_auth_user Where username = ?";
        int count = jdbcTemplate.queryForInt(sql,username);

        return count != 0 ? true : false;
    }

}

/**
 * Copyright (c)2010-2011 Enterprise Website Content Management System(EWCMS), All rights reserved.
 * EWCMS PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 * http://www.ewcms.com
 */
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ewcms.component.interaction.dao;

import com.ewcms.component.interaction.vo.Interaction;
import com.ewcms.component.interaction.vo.InteractionState;
import com.ewcms.component.interaction.vo.Organ;
import com.ewcms.component.interaction.vo.Speak;
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
public class InteractionDAO implements InteractionDAOable {

	private JdbcTemplate jdbcTemplate;

	@Autowired
	public void setDataSource(DataSource dataSource) {
		jdbcTemplate = new JdbcTemplate(dataSource);
	}

	@Override
	public Integer addInteraction(final Interaction vo) {
		final String sql = "Insert Into plugin_interaction "
				+ "(username,title,content,replay,type,state,checked,organ_id,ip,name,organ_name) "
				+ "Values (?,?,?,?,?,?,?,?,?,?,?)";
		
		jdbcTemplate.update(new PreparedStatementCreator() {
			@Override
			public PreparedStatement createPreparedStatement(Connection con)
					throws SQLException {
				PreparedStatement ps = con.prepareStatement(sql);
				ps.setString(1, vo.getUsername());
				ps.setString(2, vo.getTitle());
				ps.setString(3, vo.getContent());
				ps.setString(4, vo.getReplay());
				ps.setInt(5, vo.getType());
				ps.setInt(6, vo.getState().ordinal());
				ps.setBoolean(7, vo.getChecked());
				ps.setInt(8, vo.getOrgan().getId());
				ps.setString(9, vo.getIp());
				ps.setString(10, vo.getName());
				ps.setString(11, vo.getOrgan().getName());

				return ps;
			}
		});
		return jdbcTemplate.queryForInt("select currval('seq_plugin_interaction_id')");
	}

	@Override
	public void incrementInteractionCounter(int id) {
		String sql = "Update plugin_interaction Set counter = counter + 1 "
				+ "Where id = ?";
		jdbcTemplate.update(sql, new Object[] { id });
	}

	@Override
	public Interaction getInteraction(Integer id) {
		String sql = "Select * From plugin_interaction Where id = ?";

		List<Interaction> list = jdbcTemplate.query(sql, new Object[] { id },
				new RowMapper<Interaction>() {

					@Override
					public Interaction mapRow(ResultSet rs, int rowNum)
							throws SQLException {
						return interactionRowMapper(rs);
					}
				});

		return list.isEmpty() ? null : list.get(0);
	}

	private Interaction interactionRowMapper(ResultSet rs) throws SQLException {
		Interaction vo = new Interaction();
		vo.setId(rs.getInt("id"));
		vo.setUsername(rs.getString("username"));
		vo.setTitle(rs.getString("title"));
		vo.setContent(rs.getString("content"));
		vo.setReplay(rs.getString("replay"));
		vo.setType(rs.getInt("type"));
		vo.setState(InteractionState.values()[rs.getInt("state")]);
		vo.setIp(rs.getString("ip"));
		vo.setChecked(rs.getBoolean("checked"));
		vo.setDate(rs.getTimestamp("date"));
		vo.setReplayDate(rs.getTimestamp("replay_date"));
		vo.setCounter(rs.getInt("counter"));
		vo.setName(rs.getString("name"));
		Organ organ = new Organ(rs.getInt("organ_id"),
				rs.getString("organ_name"));
		vo.setOrgan(organ);

		return vo;
	}

	@Override
	public Organ getOrgan(Integer id) {
		String sql = "Select id,name From site_organ Where id = ?";
		List<Organ> list = jdbcTemplate.query(sql, new Object[] { id },
				new RowMapper<Organ>() {

					@Override
					public Organ mapRow(ResultSet rs, int rowNum)
							throws SQLException {
						return organRowMapper(rs);
					}
				});
		return list.isEmpty() ? null : list.get(0);
	}

	@Override
	public List<Organ> getOrganChildren(Integer id) {
		String sql = "Select id,name From site_organ Where parent_id = ? Order By id asc";
		return jdbcTemplate.query(sql, new Object[] { id },
				new RowMapper<Organ>() {

					@Override
					public Organ mapRow(ResultSet rs, int rowNum)
							throws SQLException {
						return organRowMapper(rs);
					}
				});
	}

	@Override
	public List<Organ> getOrganRootChildren() {
		String sql = "Select id,name From site_organ "
				+ "Where parent_id In (select id From site_organ Where parent_id Is null) Order By id asc";
		return jdbcTemplate.query(sql, new RowMapper<Organ>() {

			@Override
			public Organ mapRow(ResultSet rs, int rowNum) throws SQLException {
				return organRowMapper(rs);
			}
		});
	}

	private Organ organRowMapper(ResultSet rs) throws SQLException {
		Organ organ = new Organ();
		organ.setId(rs.getInt("id"));
		organ.setName(rs.getString("name"));
		return organ;
	}

	@Override
	public List<Interaction> findInteractionByUsername(String username,
			int page, int row) {
		String sql = "Select * " + "From plugin_interaction "
				+ "Where username = ? " + "Order By date desc Limit ? OffSet ?";
		int offset = page * row;
		Object[] params = new Object[] { username, row, offset };
		List<Interaction> list = jdbcTemplate.query(sql, params,
				new RowMapper<Interaction>() {

					@Override
					public Interaction mapRow(ResultSet rs, int rowNum)
							throws SQLException {
						return interactionRowMapper(rs);
					}
				});

		return list;
	}

	@Override
	public List<Interaction> findInteraction(int page, int row, int interType) {
		int offset = page * row;
		Object[] params = new Object[] { row, offset };
		
		String sql = "Select * " + "From plugin_interaction "
				+ "Where checked = true ";

		if (interType != 0 && interType <= 3 && interType >= 1) {
			sql += " And type = ? ";
			params = new Object[]{ interType, row, offset };
		}

		sql += "Order By date desc Limit ? OffSet ?";

		
		List<Interaction> list = jdbcTemplate.query(sql, params,
				new RowMapper<Interaction>() {

					@Override
					public Interaction mapRow(ResultSet rs, int rowNum)
							throws SQLException {
						return interactionRowMapper(rs);
					}
				});

		return list;
	}

	@Override
	public List<Interaction> findInteractionByReplay(boolean replay, int page,
			int row, int interType) {
		String sql = "Select * " + "From plugin_interaction "
				+ "Where checked = true And state %s%d ";
		int offset = page * row;
		Object[] params = new Object[] { row, offset };
		if (interType != 0 && interType <= 3 && interType >= 1) {
			sql += " And type = ? ";
			params = new Object[] {interType, row, offset };
		}
		sql += "Order By date desc Limit ? OffSet ?";

		if (replay) {
			sql = String.format(sql, "=", InteractionState.BACK.ordinal());
		} else {
			sql = String.format(sql, "!=", InteractionState.BACK.ordinal());
		}


		List<Interaction> list = jdbcTemplate.query(sql, params,
				new RowMapper<Interaction>() {

					@Override
					public Interaction mapRow(ResultSet rs, int rowNum)
							throws SQLException {
						return interactionRowMapper(rs);
					}
				});

		return list;
	}

	@Override
	public int getInteractionCount(int interType) {
		String sql = "Select count(id) From plugin_interaction Where checked = true";
		Object[] params = new Object[] {};		
		if (interType != 0 && interType <= 3 && interType >= 1) {
			sql += " And type = ? ";
			params = new Object[] {interType};
		}

		return (int) jdbcTemplate.queryForLong(sql, params);
	}

	@Override
	public int getInteractionReplayCount(boolean replay, int interType) {
		String sql = "Select count(id) From plugin_interaction Where checked = true And state%s%d";
		Object[] params = new Object[] {};	
		if (interType != 0 && interType <= 3 && interType >= 1) {
			sql += " And type = ? ";
			params = new Object[] {interType};
		}
		if (replay) {
			sql = String.format(sql, "=", InteractionState.BACK.ordinal());
		} else {
			sql = String.format(sql, "!=", InteractionState.BACK.ordinal());
		}
		return (int) jdbcTemplate.queryForLong(sql,params);
	}

	@Override
	public int getInteractionUsernameCount(String username) {
		String sql = "Select count(id) From plugin_interaction "
				+ "Where username = ?";

		return (int) jdbcTemplate.queryForLong(sql, new Object[] { username });
	}

	@Override
	public void addSpeak(final Speak vo) {
		final String sql = "Insert Into plugin_interaction_speak "
				+ "(username,content,checked,interaction_id,ip,name) "
				+ "Values (?,?,?,?,?,?)";

		jdbcTemplate.update(new PreparedStatementCreator() {

			@Override
			public PreparedStatement createPreparedStatement(Connection con)
					throws SQLException {
				PreparedStatement ps = con.prepareStatement(sql);
				ps.setString(1, vo.getUsername());
				ps.setString(2, vo.getContent());
				ps.setBoolean(3, vo.getChecked());
				ps.setInt(4, vo.getInteractionId());
				ps.setString(5, vo.getIp());
				ps.setString(6, vo.getName());

				return ps;
			}
		});
	}

	@Override
	public List<Speak> findSpeakByInteractionId(int interactionId,
			String username, int page, int row) {
		String sql = "Select * From plugin_interaction_speak "
				+ "Where interaction_id = ? And (checked = true Or username=?) "
				+ "Order By date desc Limit ? OffSet ?";
		username = (username == null ? "" : username);
		int offset = page * row;
		List<Speak> list = jdbcTemplate.query(sql, new Object[] {
				interactionId, username, row, offset }, new RowMapper<Speak>() {

			@Override
			public Speak mapRow(ResultSet rs, int rowNum) throws SQLException {
				Speak vo = new Speak();
				vo.setUsername(rs.getString("username"));
				vo.setName(rs.getString("name"));
				vo.setContent(rs.getString("content"));
				vo.setIp(rs.getString("ip"));
				vo.setChecked(rs.getBoolean("checked"));
				vo.setDate(rs.getTimestamp("date"));
				vo.setInteractionId(rs.getInt("interaction_id"));
				vo.setName(rs.getString("name"));

				return vo;
			}
		});

		return list;
	}

	@Override
	public int getSpeakCount(int interactionId, String username) {
		String sql = "Select count(id) From plugin_interaction_speak "
				+ "Where interaction_id = ? And (checked = ? Or username=?)";

		username = (username == null ? "" : username);
		return (int) jdbcTemplate.queryForLong(sql, new Object[] {
				interactionId, true, username });
	}

	@Override
	public List<Interaction> findHotInteraction(int row) {
		String sql = "Select * From plugin_interaction Where checked = true Order By counter Desc Limit ?";
		return jdbcTemplate.query(sql, new Object[] { row },
				new RowMapper<Interaction>() {

					@Override
					public Interaction mapRow(ResultSet rs, int rowNum)
							throws SQLException {
						return interactionRowMapper(rs);
					}
				});
	}

	@Override
	public List<Organ> findInteractionBackOrder(int row, boolean back) {
		String sql = "Select * "
				+ "From plugin_interaction_backratio t1,site_organ t2 "
				+ "Where t1.id = t2.id " + "Order By %s desc Limit ? ";
		String filder = back ? "t1.ratio" : "t1.no_ratio";
		sql = String.format(sql, filder);

		return jdbcTemplate.query(sql, new Object[] { row },
				new RowMapper<Organ>() {

					@Override
					public Organ mapRow(ResultSet rs, int rowNum)
							throws SQLException {
						Organ organ = organRowMapper(rs);
						organ.setBackRatio(rs.getInt("ratio"));
						organ.setNoBackRatio(rs.getInt("no_ratio"));
						return organ;
					}
				});
	}

	@Override
	public void interactionBackRatio(int organId) {
		String sql = "Select count(id) From plugin_interaction Where state = "
				+ String.valueOf(InteractionState.BACK.ordinal());
		int all = jdbcTemplate.queryForInt(sql);
		int ratio = -1;
		if (all != 0) {
			sql = sql + " And organ_id = ? ";
			int back = jdbcTemplate.queryForInt(sql, new Object[] { organId });
			ratio = (back * 100) / all;
		}

		sql = "Select count(id) From plugin_interaction Where checked = true And state = "
				+ String.valueOf(InteractionState.INIT.ordinal());
		all = jdbcTemplate.queryForInt(sql);
		int noRatio = -1;
		if (all != 0) {
			sql = sql + " And organ_id = ? ";
			int noBack = jdbcTemplate
					.queryForInt(sql, new Object[] { organId });
			noRatio = (noBack * 100) / all;
		}

		sql = "Delete From plugin_interaction_backratio Where id = ?";
		jdbcTemplate.update(sql, new Object[] { organId });
		sql = "Insert Into plugin_interaction_backratio (id,ratio,no_ratio) values (?,?,?)";
		jdbcTemplate.update(sql, new Object[] { organId, ratio, noRatio });
	}

	@Override
	public List<Interaction> findInteractionByTitle(String[] titles, int page,
			int row) {

		String sql = "Select * From plugin_interaction "
				+ "Where checked = true And (" + titleConditions(titles) + ") "
				+ "Order By date desc Limit ? OffSet ?";
		int offset = page * row;
		return jdbcTemplate.query(sql, new Object[] { row, offset },
				new RowMapper<Interaction>() {

					@Override
					public Interaction mapRow(ResultSet rs, int rowNum)
							throws SQLException {
						return interactionRowMapper(rs);
					}
				});
	}

	@Override
	public int findInteractionByTitleCount(String[] titles) {

		String sql = "Select count(id) From plugin_interaction "
				+ "Where checked = true And " + "(" + titleConditions(titles)
				+ ")";

		int count = jdbcTemplate.queryForInt(sql);
		return count;
	}

	@Override
	public List<Interaction> findInteractionByTitleReplay(String[] titles,
			boolean replay, int page, int row) {

		String sql = "Select * From plugin_interaction "
				+ "Where checked = true And (" + titleConditions(titles) + ") "
				+ " And " + replayConditions(replay)
				+ " Order By date desc Limit ? OffSet ?";

		int offset = page * row;
		return jdbcTemplate.query(sql, new Object[] { row, offset },
				new RowMapper<Interaction>() {

					@Override
					public Interaction mapRow(ResultSet rs, int rowNum)
							throws SQLException {
						return interactionRowMapper(rs);
					}
				});
	}

	@Override
	public int findInteractionByTitleReplayCount(String[] titles, boolean replay) {
		String sql = "Select count(id) From plugin_interaction "
				+ "Where checked = true And (" + titleConditions(titles) + ") "
				+ " And " + replayConditions(replay);

		return jdbcTemplate.queryForInt(sql);
	}

	private String titleConditions(String[] titles) {

		StringBuilder builder = new StringBuilder();
		for (int i = 0; i < titles.length; i++) {
			String title = titles[i];
			if (title.trim().length() == 0) {
				continue;
			}
			if (i == 0) {
				builder.append(" title Like '%").append(title).append("%' ");
			} else {
				builder.append(" Or title Like '%").append(title).append("%' ");
			}
		}

		return builder.toString();
	}

	private String replayConditions(boolean replay) {

		String conditions = "state ";
		if (replay) {
			conditions = conditions + "="
					+ String.valueOf(InteractionState.BACK.ordinal());
		} else {
			conditions = conditions + "!="
					+ String.valueOf(InteractionState.BACK.ordinal());
		}
		return conditions;
	}

	@Override
	public List<Interaction> findInteractionByOrganId(int organId) {
		String sql = "Select * " + "From plugin_interaction "
				+ "Where checked = true And organ_id = ? Order By date Desc";

		List<Interaction> list = jdbcTemplate.query(sql,
				new Object[] { organId }, new RowMapper<Interaction>() {

					@Override
					public Interaction mapRow(ResultSet rs, int rowNum)
							throws SQLException {
						return interactionRowMapper(rs);
					}
				});

		return list;
	}

	@Override
	public List<Organ> findIteractionBackCount(int row) {
		String sql = "select organ_name, count(organ_id) as count " +
				"from plugin_interaction " +
				"where checked=true and username is not null " +
				"group by organ_name " +
				"order by count desc Limit ?";
		
		return jdbcTemplate.query(sql, new Object[]{row}, new RowMapper<Organ>() {
            @Override
            public Organ mapRow(ResultSet rs, int rowNum) throws SQLException {
                Organ organ = new Organ();
                organ.setName(rs.getString("organ_name"));
                organ.setBackRatio(rs.getInt("count"));
                return organ;
            }
        });
	}

	@Override
	public List<Organ> findIteractionNoBackCount(int row) {
		String sql = "select organ_name, count(organ_id) as count " +
				"from plugin_interaction " +
				"where checked=false and username is not null " +
				"group by organ_name " +
				"order by count desc Limit ?";
		
		return jdbcTemplate.query(sql, new Object[]{row}, new RowMapper<Organ>() {
            @Override
            public Organ mapRow(ResultSet rs, int rowNum) throws SQLException {
                Organ organ = new Organ();
                organ.setName(rs.getString("organ_name"));
                organ.setBackRatio(rs.getInt("count"));
                return organ;
            }
        });
	}
}

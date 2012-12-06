--==============================================================================
--Copyright (c)2006-2007 JiangXi Jict Software Technologies Co., Ltd.
--All right reserved.
--==============================================================================
--==============================================================================
--创建EWCM组件数据库表

--适用数据库
--postgresql 8.0以上

--定义:
--序列后缀使用sqe

--时间:2010-10-12
--维护人:<a hrfe="hhywangwei@gmail.com">王伟</a>
--==============================================================================

--==============================================================================
--component_counter:访问次数
--component_counterlog:访问日志
--component_comment:评论
--component_comment_counter:次数信息
--component_comment_reply:评论回复
--component_auth_user:用户
--component_auth_userinfo:用户信息
--plugin_interaction：政民互动
--plugin_interaction_speak:正民互动评论
--plugin_interaction_backratio:统计信件回帖率（单位）
--plugin_online_advisory:在线咨询

--序列
--seq_component_counter_log_id
--seq_component_comment_id
--seq_component_comment_reply_id
--seq_plugin_interaction_id
--seq_plugin_initeraction_speak_id
--seq_plugin_online_advisory_id
--==============================================================================
--------------------------------------------------------------------------------
--删除存在的表(Drop already exists table and sequence)
--------------------------------------------------------------------------------
DROP TABLE component_counter;
DROP TABLE component_counter_log;
DROP TABLE component_comment_counter;
DROP TABLE component_comment;
DROP TABLE component_comment_reply;
DROP TABLE component_auth_user;
DROP TABLE component_auth_userinfo;
DROP TABLE plugin_interaction;
DROP TABLE plugin_interaction_speak;
DROP TABLE plugin_interaction_backratio;
DROP TABLE plugin_online_advisory;

DROP Sequence seq_component_counter_log_id;
DROP Sequence seq_component_comment_id;
DROP Sequence seq_component_comment_reply_id;
DROP Sequence seq_plugin_interaction_id;
DROP Sequence seq_plugin_interaction_speak_id;
DROP Sequence seq_plugin_online_advisory_id;
--------------------------------------------------------------------------------
--创建序列(create sequence)
--------------------------------------------------------------------------------
CREATE SEQUENCE seq_component_counter_log_id
    START WITH 1
    INCREMENT BY 1
    CACHE 10;

CREATE SEQUENCE seq_component_comment_id
    START WITH 1
    INCREMENT BY 1
    CACHE 10;

CREATE SEQUENCE seq_component_comment_reply_id
    START WITH 1
    INCREMENT BY 1
    CACHE 10;

CREATE SEQUENCE seq_plugin_interaction_id
     START WITH 1
    INCREMENT BY 1
    CACHE 10;

CREATE SEQUENCE seq_plugin_interaction_speak_id
     START WITH 1
    INCREMENT BY 1
    CACHE 10;

CREATE SEQUENCE seq_plugin_online_advisory_id
     START WITH 1
    INCREMENT BY 1
    CACHE 10;

-------------------------------------------------------------------------------
--component_counter:访问次数表

--article_id:文章编号（主键）
--channel_id:频道编号
--count:访问次数
CREATE TABLE component_counter (
    article_id int NOT NULL,
    counter integer NOT NULL,
    CONSTRAINT pk_component_counter PRIMARY KEY (article_id)
);

-------------------------------------------------------------------------------
--component_counter_log:访问日志

--id:日志编号（主键）
--article_id:文章编号
--ip:访问的ip地址
--date:访问时间
CREATE TABLE component_counter_log (
    id bigint NOT NULL default nextval('seq_component_counter_log_id'),
    article_id int NOT NULL,
    ip varchar(25) NOT NULL,
    date timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT pk_component_counter_log PRIMARY KEY (id)
);

-------------------------------------------------------------------------------
--component_comment_counter:评论次数

--article_id:文章编号
--comment_count:评论次数（审核后的次数）
--person_count:评论人次（所有参与人次,包括回复的）
CREATE TABLE component_comment_counter (
    article_id int NOT NULL,
    comment_counter int NOT NULL,
    person_counter int NOT NULL,
    CONSTRAINT pk_component_comment_counter PRIMARY KEY (article_id)
);

-------------------------------------------------------------------------------
--component_comment:评论

--id:评论编号（主键）
--article_id:评论编号
--username:用户名
--ip:用户ip地址
--conent:评论类容
--date:评论时间
CREATE TABLE component_comment (
    id bigint NOT NULL default nextval('seq_component_comment_id'),
    article_id int NOT NULL,
    username varchar(20) NOT NULL,
    ip varchar(25) NOT NULL,
    content text,
    date timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT pk_component_comment PRIMARY KEY (id)
);

-------------------------------------------------------------------------------
--component_comment_reply:评论回复

--id:评论回复编号（主键）
--comment_id:评论文章编号
--username:用户名
--ip:用户ip地址
--conent:评论类容
--date:评论时间
CREATE TABLE component_comment_reply (
    id bigint NOT NULL default nextval('seq_component_comment_reply_id'),
    article_id int NOT NULL,
    comment_id bigint NOT NULL,
    username varchar(20) NOT NULL,
    ip varchar(25) NOT NULL,
    content text,
    date timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT pk_component_comment_reply PRIMARY KEY (id)
);

--------------------------------------------------------------------------------
--component_auth_user:用户

--username:用户名
--name:呢称
--password:密码
--email:电子邮件
--address:家庭地址
--phone:电话
--mphone:手机
--id_card:证号
--register_date:
CREATE TABLE component_auth_user (
    username varchar(20) NOT NULL,
    name varchar(20) NOT NULL,
    password varchar(20) NOT NULL,
    email varchar(100) NOT NULL,
    register_date timestamp without time zone NOT NULL DEFAULT now(),
    enabled boolean DEFAULT true,
    CONSTRAINT pk_component_auth_user PRIMARY KEY (username)
);

--------------------------------------------------------------------------------
--component_auth_userinfo:用户

--username:用户名
--name:呢称
--realname:真实姓名
--sex:性别
--birthday:生日
--education：教育
--zip:邮政编码
--address:家庭地址
--phone:电话
--mphone:手机
CREATE TABLE component_auth_userinfo (
    username varchar(20) NOT NULL,
    name varchar(20) NOT NULL,
    realname varchar(20),
    sex int default 0,
    birth_year int default -1,
    birth_month int default -1,
    birth_day int default -1,
    education int default 0,
    zip varchar(10),
    address varchar(100),
    phone varchar(20),
    mphone varchar(20),
    CONSTRAINT pk_component_auth_userinfo PRIMARY KEY (username)
);
--------------------------------------------------------------------------------
--plugin_interaction:政名互动

--username:用户名
--title:标题
--content:内容
--replay:回复
--type:互动类型(1：咨询，2:投诉，3:建言)
--checked:审核
--state:处理状态
--organ_id:部门编号
--ip:ip地址
--date:日期
CREATE TABLE plugin_interaction (
    id int NOT NULL DEFAULT nextval('seq_plugin_interaction_id'),
    username varchar(20) NOT NULL,
    name varchar(20) NOT NULL,
    title varchar(255) NOT NULL,
    content text NOT NULL,
    replay text,
    type int NOT NULL,
    state int NOT NULL DEFAULT 0,
    checked boolean NOT NULL DEFAULT false,
    organ_id int NOT NULL,
    organ_name varchar(255) NOT NULL,
    ip varchar(20),
    counter integer NOT NULL DEFAULT 0,
    date timestamp without time zone NOT NULL DEFAULT now(),
    replay_date timestamp without time zone,
    tel varchar(255),
    CONSTRAINT pk_plugin_interaction PRIMARY KEY (id)
);

--------------------------------------------------------------------------------
--plugin_interaction_speak:政名互动

--username:用户名
--title:标题
--content:内容
--replay:回复
--type:互动类型(1：咨询，2:投诉，3:建言)
--verify:审核
--organ_id:部门编号

CREATE TABLE plugin_interaction_speak (
    id int NOT NULL DEFAULT nextval('seq_plugin_interaction_speak_id'),
    username varchar(20) NOT NULL,
    name varchar(20) NOT NULL,
    content text NOT NULL,
    interaction_id int NOT NULL,
    checked boolean NOT NULL DEFAULT false,
    ip varchar(20),
    date timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT pk_plugin_interaction_speak PRIMARY KEY (id)
);

--------------------------------------------------------------------------------
--plugin_interaction_backratio:部门回复率

--id:单位编号
--ratio:回帖比率
--no_ratio:未回帖率

CREATE TABLE plugin_interaction_backratio (
    id int NOT NULL,
    ratio int NOT NULL,
    no_ratio int NOT NULL,
    CONSTRAINT pk_plugin_interaction_backratio PRIMARY KEY (id)
);

--component_online_advisory:在线咨询

--username:用户名
--name:用户昵称
--title:标题
--content:内容
--replay:回复
--state:处理状态
--organ_id:部门编号
--matter_id:咨询事项编号
--ip:ip地址
--date:日期
CREATE TABLE plugin_online_advisory(
    id int NOT NULL DEFAULT nextval('seq_plugin_online_advisory_id'),
    username varchar(20) NOT NULL,
    name varchar(20) NOT NULL,
    title varchar(40) NOT NULL,
    content text NOT NULL,
    replay text,
    state int NOT NULL DEFAULT 0,
    organ_id int NOT NULL, 
    matter_id int NOT NULL,
    ip varchar(20),
    date timestamp without time zone NOT NULL DEFAULT now(),
    replay_date timestamp without time zone,
    checked boolean DEFAULT false,
    CONSTRAINT pk_plugin_online_advisory PRIMARY KEY (id)
);
--------------------------------------------------------------------------------
--外键(FK)
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
--索引(Index)
--------------------------------------------------------------------------------
CREATE INDEX index_component_counter_log
  ON component_counter_log
  USING btree
  (article_id);

CREATE INDEX index_component_comment_article_id
  ON component_comment
  USING btree
  (article_id);

CREATE INDEX index_component_comment_reply_comment_id
  ON component_comment_reply
  USING btree
  (comment_id);

CREATE INDEX index_plugin_interaction_username
  ON plugin_interaction
  USING btree
  (username);

CREATE INDEX index_plugin_interaction_organ_id
  ON plugin_interaction
  USING btree
  (organ_id);

CREATE INDEX index_plugin_interaction_speak_interaction_id
  ON plugin_interaction_speak
  USING btree
  (interaction_id);

CREATE INDEX index_plugin_interaction_speak_username
  ON plugin_interaction_speak
  USING btree
  (username);

CREATE INDEX index_plugin_online_advisory_username
  ON plugin_online_advisory
  USING btree
  (username);


select organ_id, count(id) as total from plugin_interaction group by organ_id
select organ_id, count(id) as ratio from plugin_interaction where replay_date is not null group by organ_id order by organ_id 

insert into plugin_interaction_backratio(id, ratio,no_ratio) values(2,100,-1);
insert into plugin_interaction_backratio(id, ratio,no_ratio) values(9,100,-1);
insert into plugin_interaction_backratio(id, ratio,no_ratio) values(11,100,-1);
insert into plugin_interaction_backratio(id, ratio,no_ratio) values(12,100,-1);
insert into plugin_interaction_backratio(id, ratio,no_ratio) values(13,100,-1);
insert into plugin_interaction_backratio(id, ratio,no_ratio) values(14,100,-1);
insert into plugin_interaction_backratio(id, ratio,no_ratio) values(15,100,-1);
insert into plugin_interaction_backratio(id, ratio,no_ratio) values(17,100,-1);
insert into plugin_interaction_backratio(id, ratio,no_ratio) values(20,100,-1);
insert into plugin_interaction_backratio(id, ratio,no_ratio) values(21,100,-1);
insert into plugin_interaction_backratio(id, ratio,no_ratio) values(22,100,-1);
insert into plugin_interaction_backratio(id, ratio,no_ratio) values(25,100,-1);
insert into plugin_interaction_backratio(id, ratio,no_ratio) values(26,100,-1);
insert into plugin_interaction_backratio(id, ratio,no_ratio) values(27,100,-1);
insert into plugin_interaction_backratio(id, ratio,no_ratio) values(29,100,-1);
insert into plugin_interaction_backratio(id, ratio,no_ratio) values(30,100,-1);
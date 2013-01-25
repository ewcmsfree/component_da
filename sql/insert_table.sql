select organ_id, count(id) as total from plugin_interaction group by organ_id
select organ_id, count(id) as ratio from plugin_interaction where replay_date is not null group by organ_id order by organ_id 

insert into plugin_interaction_backratio(id, ratio, no_ratio) select organ_id, count(id),0 from plugin_interaction where replay_date is not null group by organ_id order by organ_id 
SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

DROP TABLE IF EXISTS `cp_modules`;
CREATE TABLE `cp_modules` (
  `modules_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '模块组表主键id',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '模块组名称',
  `comment` varchar(100) NOT NULL DEFAULT '' COMMENT '备注',
  `status` tinyint(3) NOT NULL DEFAULT '0' COMMENT '状态，0：正常，-1：删除',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`modules_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='模块组表';


DROP TABLE IF EXISTS `cp_node`;
CREATE TABLE `cp_node` (
  `node_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '节点信息表主键id',
  `ip` varchar(15) NOT NULL DEFAULT '' COMMENT '节点主机IP',
  `port` int(10) NOT NULL DEFAULT '0' COMMENT '节点主机端口',
  `comment` varchar(30) NOT NULL DEFAULT '' COMMENT '备注',
  `status` tinyint(3) NOT NULL DEFAULT '0' COMMENT '状态，0：正常，-1：删除',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`node_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='节点信息表';


DROP TABLE IF EXISTS `cp_nodes`;
CREATE TABLE `cp_nodes` (
  `nodes_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '节点组表主键id',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '节点组名称',
  `comment` varchar(100) NOT NULL DEFAULT '' COMMENT '备注',
  `status` tinyint(3) NOT NULL DEFAULT '0' COMMENT '状态，0：正常，-1：删除',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`nodes_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='节点组表';


DROP TABLE IF EXISTS `cp_node_module`;
CREATE TABLE `cp_node_module` (
  `node_module_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '节点和模块关系表主键',
  `node_id` int(10) NOT NULL DEFAULT '0' COMMENT '节点ID',
  `module_id` int(10) NOT NULL DEFAULT '0' COMMENT '模块ID',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`node_module_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='节点和模块关系表';


DROP TABLE IF EXISTS `cp_task`;
CREATE TABLE `cp_task` (
  `task_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '发布代码任务主键ID',
  `module_id` int(10) NOT NULL COMMENT '模块ID',
  `sha1_id` varchar(200) NOT NULL DEFAULT '' COMMENT 'git commit ID',
  `comment` text NOT NULL COMMENT '发布备注',
  `user_id` int(10) NOT NULL DEFAULT '0' COMMENT '用户表主键id',
  `is_published` tinyint(3) NOT NULL DEFAULT '0' COMMENT '是否已经发布:0否，1是',
  `publish_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '发布时间',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='发布任务表';


DROP TABLE IF EXISTS `cp_task_log`;
CREATE TABLE `cp_task_log` (
  `task_log_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '发布代码任务日志表主键ID',
  `response` text NOT NULL COMMENT '客户端返回的结果json数据',
  `task_id` int(10) NOT NULL DEFAULT '0' COMMENT '发布代码任务表主键ID',
  `client_id` int(10) NOT NULL DEFAULT '0' COMMENT '客户端表主键ID',
  `is_success` tinyint(3) NOT NULL DEFAULT '0' COMMENT '是否发布成功:1成功，2失败',
  `is_published` tinyint(3) NOT NULL DEFAULT '0' COMMENT '是否发布过：0未发布过，1发布过',
  `user_id` int(10) NOT NULL DEFAULT '0' COMMENT '用户表主键ID',
  `rollback_id` varchar(100) NOT NULL DEFAULT '' COMMENT '回滚用的sha1_id',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`task_log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='任务日志表';


DROP TABLE IF EXISTS `cp_user`;
CREATE TABLE `cp_user` (
  `user_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '用户表主键',
  `username` varchar(50) NOT NULL DEFAULT '' COMMENT '用户名',
  `given_name` varchar(50) NOT NULL DEFAULT '' COMMENT '姓名',
  `password` char(32) NOT NULL DEFAULT '' COMMENT '密码',
  `email` varchar(50) NOT NULL DEFAULT '' COMMENT 'email地址',
  `mobile` char(13) NOT NULL DEFAULT '' COMMENT '手机号',
  `last_ip` varchar(15) NOT NULL DEFAULT '' COMMENT '最后登录ip',
  `last_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '最后登录时间',
  `role` tinyint(2) NOT NULL DEFAULT '0' COMMENT '0,普通用户; 1管理员2超级管理员;',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态，0：正常 -1：删除',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户表';

INSERT INTO `cp_user` (`user_id`, `username`, `given_name`, `password`, `email`, `mobile`, `last_ip`, `last_time`, `role`, `status`, `create_time`, `update_time`) VALUES
(1,	'root',	'root',	'21232f297a57a5a743894a0e4a801fc3',	'',	'',	'',	'0000-00-00 00:00:00',	0,	0,	'2017-12-14 02:26:40',	'0000-00-00 00:00:00');

DROP TABLE IF EXISTS `cp_user_module`;
CREATE TABLE `cp_user_module` (
  `user_module_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '用户和模块关系表主键',
  `user_id` int(10) NOT NULL DEFAULT '0' COMMENT '用户主键id',
  `module_id` int(10) NOT NULL DEFAULT '0' COMMENT '模块主键id',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`user_module_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户和模块关系表';

/*
Navicat MySQL Data Transfer

Date: 2017-12-01 09:20:09
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `job`
-- ----------------------------
DROP TABLE IF EXISTS `job`;
CREATE TABLE `job` (
  `uids` varchar(32) NOT NULL COMMENT '主键',
  `job_name` varchar(450) DEFAULT NULL,
  `job_content` varchar(450) DEFAULT NULL,
  `jobclass_uids` varchar(100) DEFAULT NULL COMMENT 'job_class 表主键',
  `job_state` varchar(1) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `job_type` varchar(10) DEFAULT NULL,
  `create_date` date DEFAULT NULL,
  `to_quartztimes` varchar(255) NOT NULL COMMENT '时间规则表达式',
  PRIMARY KEY (`uids`),
  KEY `FK_JOB_CLASS_UIDS` (`jobclass_uids`),
  CONSTRAINT `FK_JOB_CLASS_UIDS` FOREIGN KEY (`jobclass_uids`) REFERENCES `job_class` (`UIDS`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='调度任务表';

-- ----------------------------
-- Records of job
-- ----------------------------
INSERT INTO `job` VALUES ('ab7fe51ff1474896b37cfd472f4e19ac', '测试单参数值的', '测试单参数值的', 'f7b6b35cf9254ce1bb64a74f3adbbbf5', '1', '10分钟一次测试单参数值的', null, '2017-07-14', '0 0/10 * * * ?');
INSERT INTO `job` VALUES ('fc469c86d0c04cf4a0f47ea825fcb1fd', '20分钟一次', '20分钟一次', '27185d1e4373440cbf2f3cb871f9f62f', '0', '20分钟一次', null, '2017-11-29', '0 0/20 * * * ?');

-- ----------------------------
-- Table structure for `job_class`
-- ----------------------------
DROP TABLE IF EXISTS `job_class`;
CREATE TABLE `job_class` (
  `uids` varchar(32) NOT NULL COMMENT '主键',
  `name` varchar(255) DEFAULT NULL COMMENT '名称',
  `class_all_name` varchar(255) DEFAULT NULL COMMENT 'java类全名称',
  `function_name` varchar(100) DEFAULT NULL COMMENT '方法名称',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`uids`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='任务job执行class';

-- ----------------------------
-- Records of job_class
-- ----------------------------
INSERT INTO `job_class` VALUES ('27185d1e4373440cbf2f3cb871f9f62f', 'hello', 'com.supyuan.job.jobWeb.job.TestJob', 'hello', 'hello');
INSERT INTO `job_class` VALUES ('4f059493cd524fb281e2520966dde85c', 'upd', 'com.supyuan.job.jobWeb.job.TestJob', 'upd', '两参数');
INSERT INTO `job_class` VALUES ('f7b6b35cf9254ce1bb64a74f3adbbbf5', '32', 'com.supyuan.job.jobWeb.job.TestJob', 'add', 'add');

-- ----------------------------
-- Table structure for `job_class_param`
-- ----------------------------
DROP TABLE IF EXISTS `job_class_param`;
CREATE TABLE `job_class_param` (
  `uids` varchar(32) NOT NULL,
  `classparam_name` varchar(50) DEFAULT NULL,
  `classparam_state` varchar(1) DEFAULT NULL,
  `return_type` varchar(30) DEFAULT NULL,
  `classparam_type` varchar(1) DEFAULT NULL,
  `param_type` varchar(30) DEFAULT NULL,
  `jobclass_uids` varchar(32) DEFAULT NULL COMMENT 'job_class  表主键',
  `parentuids` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`uids`),
  KEY `UIDS` (`uids`),
  KEY `FK_JOBCLASS_UIDS` (`parentuids`),
  CONSTRAINT `FK_JOBCLASS_UIDS` FOREIGN KEY (`parentuids`) REFERENCES `job_class` (`uids`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='job执行关联的class的方法和参数';

-- ----------------------------
-- Records of job_class_param
-- ----------------------------
INSERT INTO `job_class_param` VALUES ('08cd66754f4841138d76a403bbbdc22c', 'name', '1', 'java.lang.String', '1', 'java.lang.String', 'aaad7bfa453341d6a2c6afae13bddc98', null);
INSERT INTO `job_class_param` VALUES ('65aab1b2fe554cb986199aabc6aef00f', 'adds', '1', 'java.lang.String', '1', 'java.lang.String', '4f059493cd524fb281e2520966dde85c', null);
INSERT INTO `job_class_param` VALUES ('8d6a6b06b0284ed0a878420b20ce076d', 'emali', '1', 'java.lang.String', '1', 'java.lang.String', 'aaad7bfa453341d6a2c6afae13bddc98', null);
INSERT INTO `job_class_param` VALUES ('b63a8ec08cd9437ebf7da72182206ca9', 'emali', '1', 'java.lang.String', '1', 'java.lang.String', 'f7b6b35cf9254ce1bb64a74f3adbbbf5', null);
INSERT INTO `job_class_param` VALUES ('bbbe6a3a35d64be19f3861d615fc0754', 'name', '1', 'java.lang.String', '1', 'java.lang.String', 'f7b6b35cf9254ce1bb64a74f3adbbbf5', null);
INSERT INTO `job_class_param` VALUES ('deac5364c79148999bc4f7e47539ae12', 'tel', '1', 'java.lang.String', '1', 'java.lang.Integer', '4f059493cd524fb281e2520966dde85c', null);

-- ----------------------------
-- Table structure for `job_log`
-- ----------------------------
DROP TABLE IF EXISTS `job_log`;
CREATE TABLE `job_log` (
  `uids` varchar(32) NOT NULL,
  `begintimes` bigint(13) DEFAULT NULL,
  `endtimes` bigint(13) DEFAULT NULL,
  `content` varchar(200) DEFAULT NULL,
  `type` varchar(1) DEFAULT NULL,
  `state` varchar(1) DEFAULT NULL,
  `job_content` varchar(200) DEFAULT NULL,
  `remark` varchar(3000) DEFAULT NULL,
  `job_classandfunction` varchar(1000) DEFAULT NULL,
  `nextruntime` varchar(40) DEFAULT NULL,
  `jobuids` varchar(32) DEFAULT NULL,
  `run_ip` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`uids`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='job任务执行日志';

-- ----------------------------
-- Records of job_log
-- ----------------------------
INSERT INTO `job_log` VALUES ('bb5e3d6eac9240cfadf0830290164517', '1511598600001', '1511598600001', '测试单参数值的', '0', '1', '测试单参数值的', '[2017-11-25 03:30:00:001]执行\ncom.supyuan.job.jobWeb.job.TestJob类中的\nadd方法;参数值分别为：\n name:55 emali:66@qq.com 执行成功！', '执行com.supyuan.job.jobWeb.job.TestJob类中的add方法;参数值分别为： name:55 emali:66@qq.com', '2017-11-25 03:32:00', 'ab7fe51ff1474896b37cfd472f4e19ac', '127.0.0.1');
INSERT INTO `job_log` VALUES ('fff1d1133a4e4709aad9582615755005', '1510512360000', '1510512360000', '0 0/2 * * * ?', '0', '1', '0 0/2 * * * ?', '[2017-11-12 13:46:00:000]执行\ncom.supyuan.job.jobWeb.job.TestJob类中的\nhello方法;参数值分别为：\n 执行成功！', '执行com.supyuan.job.jobWeb.job.TestJob类中的hello方法;参数值分别为：', '2017-11-12 13:48:00', '2d894750973349d3a53a01625fa31e29', '127.0.0.1');
INSERT INTO `job_log` VALUES ('fffef37af2d54bfa961259019b075656', '1511680440000', '1511680440001', '测试单参数值的', '0', '1', '测试单参数值的', '[2017-11-26 02:14:00:001]执行\ncom.supyuan.job.jobWeb.job.TestJob类中的\nadd方法;参数值分别为：\n name:55 emali:66@qq.com 执行成功！', '执行com.supyuan.job.jobWeb.job.TestJob类中的add方法;参数值分别为： name:55 emali:66@qq.com', '2017-11-26 02:16:00', 'ab7fe51ff1474896b37cfd472f4e19ac', '127.0.0.1');

-- ----------------------------
-- Table structure for `job_param_value`
-- ----------------------------
DROP TABLE IF EXISTS `job_param_value`;
CREATE TABLE `job_param_value` (
  `uids` varchar(32) NOT NULL,
  `paramvalue_value` varchar(500) DEFAULT NULL,
  `state` varchar(1) DEFAULT NULL,
  `paramvalue_name` varchar(50) DEFAULT NULL,
  `remark` varchar(500) DEFAULT NULL,
  `param_uids` varchar(32) DEFAULT NULL COMMENT 'job_class_param  主键',
  `job_uids` varchar(32) DEFAULT NULL COMMENT 'job  表主键',
  PRIMARY KEY (`uids`),
  KEY `fk_jobuids` (`job_uids`),
  KEY `fk_param_uids` (`param_uids`),
  CONSTRAINT `fk_jobuids` FOREIGN KEY (`job_uids`) REFERENCES `job` (`uids`),
  CONSTRAINT `fk_param_uids` FOREIGN KEY (`param_uids`) REFERENCES `job_class_param` (`uids`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='任务关联的执行类对应的参数值表';

-- ----------------------------
-- Records of job_param_value
-- ----------------------------
INSERT INTO `job_param_value` VALUES ('6da1efe52a124e5fa3bbecae6704c84b', '55', '1', 'name', null, 'bbbe6a3a35d64be19f3861d615fc0754', 'ab7fe51ff1474896b37cfd472f4e19ac');
INSERT INTO `job_param_value` VALUES ('d8bd5ba8bdc741fdbaf8d277911c053c', '66@qq.com', '1', 'emali', null, 'b63a8ec08cd9437ebf7da72182206ca9', 'ab7fe51ff1474896b37cfd472f4e19ac');

-- ----------------------------
-- Table structure for `sys_auth`
-- ----------------------------
DROP TABLE IF EXISTS `sys_auth`;
CREATE TABLE `sys_auth` (
  `id` bigint(16) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `webapp_id` bigint(16) NOT NULL COMMENT '站点ID',
  `uri` varchar(128) NOT NULL COMMENT 'uri',
  `descript` varchar(56) DEFAULT NULL,
  `is_halt` varchar(2) NOT NULL DEFAULT 'F' COMMENT '是否停用',
  `create_datetime` bigint(14) DEFAULT NULL COMMENT '创建时间',
  `modify_datetime` bigint(14) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_0` (`webapp_id`,`uri`)
) ENGINE=MyISAM AUTO_INCREMENT=35 DEFAULT CHARSET=utf8 COMMENT='系统权限表';

-- ----------------------------
-- Records of sys_auth
-- ----------------------------
INSERT INTO `sys_auth` VALUES ('1', '99', '/system/sysauth/add', '添加系统权限', 'F', '1511943426581', '1511943829504');

-- ----------------------------
-- Table structure for `sys_auth_user`
-- ----------------------------
DROP TABLE IF EXISTS `sys_auth_user`;
CREATE TABLE `sys_auth_user` (
  `id` bigint(16) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `webapp_id` bigint(16) NOT NULL COMMENT '站点ID',
  `user_id` bigint(16) DEFAULT NULL,
  `cache_string` varchar(256) DEFAULT NULL COMMENT '存权限表id多个逗号分隔 全部*',
  `is_halt` varchar(2) NOT NULL DEFAULT 'F' COMMENT '是否停用',
  `create_datetime` bigint(14) DEFAULT NULL COMMENT '创建时间',
  `modify_datetime` bigint(14) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `index_0` (`webapp_id`,`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='用户权限表';

-- ----------------------------
-- Records of sys_auth_user
-- ----------------------------
INSERT INTO `sys_auth_user` VALUES ('1', '99', '1', '*', 'F', null, null);

-- ----------------------------
-- Table structure for `sys_department`
-- ----------------------------
DROP TABLE IF EXISTS `sys_department`;
CREATE TABLE `sys_department` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT '0' COMMENT '上级机构',
  `name` varchar(32) NOT NULL COMMENT '部门/11111',
  `code` varchar(128) DEFAULT NULL COMMENT '机构编码',
  `sort` int(11) DEFAULT '0' COMMENT '序号',
  `linkman` varchar(64) DEFAULT NULL COMMENT '联系人',
  `linkman_no` varchar(32) DEFAULT NULL COMMENT '联系人电话',
  `remark` varchar(128) DEFAULT NULL COMMENT '机构描述',
  `update_time` varchar(64) DEFAULT NULL COMMENT '更新时间',
  `update_id` int(11) DEFAULT '0' COMMENT '更新者',
  `create_time` varchar(64) DEFAULT NULL COMMENT '创建时间',
  `create_id` int(11) DEFAULT '0' COMMENT '创建者',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8 COMMENT='部门';

-- ----------------------------
-- Records of sys_department
-- ----------------------------
INSERT INTO `sys_department` VALUES ('1', '0', '深山飞雨', null, '99', null, null, null, '2017-11-30 14:45:18', '1', '2016-06-06 06:06:06', '1');
INSERT INTO `sys_department` VALUES ('44', '1', '研发部', null, '10', null, null, null, '2017-11-30 14:39:22', '1', '2017-11-30 14:39:22', '1');
INSERT INTO `sys_department` VALUES ('45', '1', '资源部', null, '20', null, null, null, '2017-11-30 14:41:46', '1', '2017-11-30 14:41:46', '1');
INSERT INTO `sys_department` VALUES ('46', '1', '行政', null, '30', null, null, null, '2017-11-30 14:45:03', '1', '2017-11-30 14:45:03', '1');

-- ----------------------------
-- Table structure for `sys_dict`
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict` (
  `dict_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `dict_name` varchar(256) NOT NULL COMMENT '名称',
  `dict_type` varchar(64) NOT NULL COMMENT '类型',
  `dict_remark` varchar(256) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`),
  UNIQUE KEY `UK_SYS_DICT_TYPE` (`dict_type`)
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8 COMMENT='数据字典主表';

-- ----------------------------
-- Records of sys_dict
-- ----------------------------
INSERT INTO `sys_dict` VALUES ('1', '日志配置', 'systemLog', null);
INSERT INTO `sys_dict` VALUES ('2', '目录类型', 'articleType', null);
INSERT INTO `sys_dict` VALUES ('11', '目录类型', 'folderType', null);
INSERT INTO `sys_dict` VALUES ('100', '系统参数', 'systemParam', null);
INSERT INTO `sys_dict` VALUES ('101', '友情链接类型', 'friendlyLinkType', null);
INSERT INTO `sys_dict` VALUES ('102', '栏目类型', 'materialType', null);
INSERT INTO `sys_dict` VALUES ('103', '1', '1', '1');
INSERT INTO `sys_dict` VALUES ('104', '修改', '修改', '修改');

-- ----------------------------
-- Table structure for `sys_dict_detail`
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_detail`;
CREATE TABLE `sys_dict_detail` (
  `detail_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `dict_type` varchar(64) NOT NULL COMMENT '数据字典类型',
  `detail_name` varchar(256) DEFAULT NULL COMMENT '名称',
  `detail_code` varchar(32) DEFAULT NULL COMMENT '代码',
  `detail_sort` varchar(32) DEFAULT NULL COMMENT '排序号',
  `detail_type` varchar(32) DEFAULT NULL COMMENT '类型',
  `detail_state` varchar(32) DEFAULT NULL COMMENT '状态',
  `detail_content` varchar(256) DEFAULT NULL COMMENT '内容',
  `detail_remark` varchar(256) DEFAULT NULL COMMENT '备注',
  `create_time` varchar(64) DEFAULT NULL COMMENT '创建时间',
  `create_id` int(11) DEFAULT '0' COMMENT '创建者',
  PRIMARY KEY (`detail_id`)
) ENGINE=InnoDB AUTO_INCREMENT=112 DEFAULT CHARSET=utf8 COMMENT='数据字典';

-- ----------------------------
-- Records of sys_dict_detail
-- ----------------------------
INSERT INTO `sys_dict_detail` VALUES ('1', 'folderType', '目录', '1', '1', null, null, null, null, '2015-01-30', '1');
INSERT INTO `sys_dict_detail` VALUES ('3', 'folderType', 'a标签target', '3', '3', null, null, null, null, '2015-01-30', '1');
INSERT INTO `sys_dict_detail` VALUES ('21', 'friendlyLinkType', '友情链接', null, '1', null, null, null, null, '2015-05-06 15:18:59', '1');
INSERT INTO `sys_dict_detail` VALUES ('51', 'systemLog', 'sys_dict', '数据字典主表', '1', null, null, null, null, '2015-01-30', '1');
INSERT INTO `sys_dict_detail` VALUES ('52', 'systemLog', 'sys_dict_detail', '数据字典', '2', null, null, null, null, '2015-01-30', '1');
INSERT INTO `sys_dict_detail` VALUES ('53', 'systemLog', 'sys_menu', '菜单管理', '3', null, null, null, null, '2015-01-30', '1');
INSERT INTO `sys_dict_detail` VALUES ('54', 'systemLog', 'sys_department', '组织机构', '4', null, null, null, null, '2015-01-30', '1');
INSERT INTO `sys_dict_detail` VALUES ('55', 'systemLog', 'sys_user', '用户管理', '5', null, null, null, null, '2015-01-30', '1');
INSERT INTO `sys_dict_detail` VALUES ('56', 'systemLog', 'sys_user_role', '用户角色授权', '6', null, null, null, null, '2015-01-30', '1');
INSERT INTO `sys_dict_detail` VALUES ('57', 'systemLog', 'sys_role', '角色管理', '7', null, null, null, null, '2015-01-30', '1');
INSERT INTO `sys_dict_detail` VALUES ('58', 'systemLog', 'sys_role_folder', '角色目录授权', '8', null, null, null, null, '2015-01-30', '1');
INSERT INTO `sys_dict_detail` VALUES ('59', 'systemLog', 'sys_role_menu', '角色菜单授权', '9', null, null, null, null, '2015-01-30', '1');
INSERT INTO `sys_dict_detail` VALUES ('60', 'systemLog', 'tb_folder', '目录管理', '102', null, null, null, null, '2015-01-30', '1');
INSERT INTO `sys_dict_detail` VALUES ('61', 'systemLog', 'tb_article', '文章管理', '11', null, null, null, null, '2015-01-30', '1');
INSERT INTO `sys_dict_detail` VALUES ('62', 'systemLog', 'tb_articlelike', '喜欢的文章管理', '12', null, null, null, null, '2015-01-30', '1');
INSERT INTO `sys_dict_detail` VALUES ('63', 'systemLog', 'tb_comment', '评论管理', '13', null, null, null, null, '2015-01-30', '1');
INSERT INTO `sys_dict_detail` VALUES ('65', 'systemLog', 'tb_contact', '联系人', '15', null, null, null, null, '2015-01-30', '1');
INSERT INTO `sys_dict_detail` VALUES ('66', 'systemLog', 'tb_error', '错误管理', '16', null, null, null, null, '2015-01-30', '1');
INSERT INTO `sys_dict_detail` VALUES ('68', 'systemLog', 'tb_pageview', '访问量统计', '18', null, null, null, null, '2015-01-30', '1');
INSERT INTO `sys_dict_detail` VALUES ('101', 'systemParam', '门头沟信息网', '1', '1', null, null, null, null, '2015-01-30', '1');
INSERT INTO `sys_dict_detail` VALUES ('102', 'materialType', '文章', '1', '1', null, null, null, null, '2016-03-31 22:35:05', '1');
INSERT INTO `sys_dict_detail` VALUES ('103', 'materialType', '图片', '2', '2', null, null, null, null, '2016-03-31 22:35:17', '1');
INSERT INTO `sys_dict_detail` VALUES ('104', 'materialType', '视频', '3', '3', null, null, null, null, '2016-03-31 22:35:28', '1');
INSERT INTO `sys_dict_detail` VALUES ('105', 'materialType', '其他', '9', '9', null, null, null, null, '2016-03-31 22:35:39', '1');
INSERT INTO `sys_dict_detail` VALUES ('106', 'materialType', '栏目', '6', '6', null, null, null, null, '2016-03-31 23:46:27', '1');
INSERT INTO `sys_dict_detail` VALUES ('107', 'systemLog', 'tb_site', '站点管理', '19', null, null, null, null, '2016-04-14 00:02:45', '1');
INSERT INTO `sys_dict_detail` VALUES ('108', 'friendlyLinkType', null, null, '0', null, null, null, null, '2017-05-17 21:41:11', '1');
INSERT INTO `sys_dict_detail` VALUES ('109', 'systemLog', 'ppp', 'pp', '0', null, null, null, null, '2017-11-08 04:50:55', '1');
INSERT INTO `sys_dict_detail` VALUES ('110', 'articleType', '1', '1', '0', null, null, null, null, '2017-11-12 09:13:13', '1');
INSERT INTO `sys_dict_detail` VALUES ('111', 'systemParam', null, null, '0', null, null, null, null, '2017-11-13 01:26:01', '1');

-- ----------------------------
-- Table structure for `sys_log`
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `log_type` int(11) NOT NULL COMMENT '类型',
  `oper_object` varchar(64) DEFAULT NULL COMMENT '操作对象',
  `oper_table` varchar(64) NOT NULL COMMENT '操作表',
  `oper_id` int(11) DEFAULT '0' COMMENT '操作主键',
  `oper_type` varchar(64) DEFAULT NULL COMMENT '操作类型',
  `oper_remark` varchar(100) DEFAULT NULL COMMENT '操作备注',
  `create_time` varchar(64) NOT NULL COMMENT '创建时间',
  `create_id` int(11) DEFAULT '0' COMMENT '创建者',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2352 DEFAULT CHARSET=utf8 COMMENT='日志';

-- ----------------------------
-- Records of sys_log
-- ----------------------------
INSERT INTO `sys_log` VALUES ('1', '1', '访问量统计', 'tb_pageview', '111', '添加', '', '2017-05-08 14:23:28', '0');
INSERT INTO `sys_log` VALUES ('2348', '2', null, 'sys_user', '18', '登入', '', '2017-11-30 10:12:26', '18');
INSERT INTO `sys_log` VALUES ('2349', '2', null, 'sys_user', '18', '登入', '', '2017-11-30 11:52:13', '18');
INSERT INTO `sys_log` VALUES ('2350', '2', null, 'sys_user', '18', '登入', '', '2017-11-30 12:38:13', '18');
INSERT INTO `sys_log` VALUES ('2351', '2', null, 'sys_user', '18', '登入', '', '2017-11-30 20:09:51', '18');

-- ----------------------------
-- Table structure for `sys_menu`
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `parentid` int(11) NOT NULL DEFAULT '0' COMMENT '父id',
  `name` varchar(200) NOT NULL DEFAULT '' COMMENT '名称/11111',
  `urlkey` varchar(256) DEFAULT NULL COMMENT '菜单key',
  `url` varchar(256) DEFAULT NULL COMMENT '链接地址',
  `status` int(11) DEFAULT '1' COMMENT '状态//radio/2,隐藏,1,显示',
  `type` int(11) DEFAULT '1' COMMENT '类型//select/1,根目录,2,a标签,3,a标签_blank,4,外部url',
  `sort` int(11) DEFAULT '1' COMMENT '排序',
  `level` int(11) DEFAULT '1' COMMENT '级别',
  `create_time` varchar(64) DEFAULT NULL COMMENT '创建时间',
  `create_id` int(11) DEFAULT '0' COMMENT '创建者',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8 COMMENT='菜单';

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES ('1', '0', '系统管理', 'system_root', null, '1', '1', '90', '1', '2015-04-27 17:28:06', '1');
INSERT INTO `sys_menu` VALUES ('2', '1', '组织机构', 'department', 'system/department', '1', '1', '91', '2', '2015-04-27 17:28:25', '1');
INSERT INTO `sys_menu` VALUES ('3', '1', '用户管理', 'user', 'system/user', '1', '1', '92', '2', '2015-04-27 17:28:46', '1');
INSERT INTO `sys_menu` VALUES ('4', '1', '角色管理', 'role', 'system/role', '1', '1', '94', '2', '2015-04-27 17:29:13', '1');
INSERT INTO `sys_menu` VALUES ('5', '1', '菜单管理', 'menu', 'system/menu', '1', '1', '96', '2', '2015-04-27 17:29:43', '1');
INSERT INTO `sys_menu` VALUES ('6', '1', '数据字典', 'dict', 'system/dict', '1', '1', '97', '2', '2015-04-27 17:30:05', '1');
INSERT INTO `sys_menu` VALUES ('14', '1', '日志管理', 'log', 'system/log/list', '1', '1', '98', '2', '2016-01-03 18:09:18', '1');
INSERT INTO `sys_menu` VALUES ('30', '0', '任务管理', 'job', null, '1', '1', '2', '1', '2017-06-01 09:51:36', '1');
INSERT INTO `sys_menu` VALUES ('31', '30', '时间规则', 'job_times', 'quartz/times/list', '2', '1', '3', '2', '2017-06-01 09:53:57', '1');
INSERT INTO `sys_menu` VALUES ('32', '30', '触发器', 'job_tigger', 'quartz/trigger/list', '2', '1', '4', '2', '2017-06-01 09:54:53', '1');
INSERT INTO `sys_menu` VALUES ('33', '30', '执行类', 'job_class', 'quartz/jobclass/list', '1', '1', '5', '2', '2017-06-01 09:55:59', '1');
INSERT INTO `sys_menu` VALUES ('34', '30', 'job任务', 'job_jobs', 'quartz/jobs/list', '1', '1', '6', '2', '2017-06-01 09:57:00', '1');
INSERT INTO `sys_menu` VALUES ('35', '30', '执行日志', 'job_log', 'quartz/log/list', '1', '1', '7', '2', '2017-07-05 10:45:38', '1');
INSERT INTO `sys_menu` VALUES ('36', '0', '一元vpn先到先得', 'vpn', 'http://www.yxyun.win/', '1', '4', '30', '1', '2017-11-06 14:33:21', '1');
INSERT INTO `sys_menu` VALUES ('38', '21', '测试页', 'test_index', '/', '1', '1', '10', '2', '2017-11-24 12:21:08', '1');
INSERT INTO `sys_menu` VALUES ('39', '1', '系统权限', 'auth', 'system/sysauth', '1', '1', '99', '2', '2017-11-29 16:04:17', '1');

-- ----------------------------
-- Table structure for `sys_role`
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(200) NOT NULL DEFAULT '' COMMENT '名称/11111/',
  `status` int(11) DEFAULT '1' COMMENT '状态//radio/2,隐藏,1,显示',
  `sort` int(11) DEFAULT '1' COMMENT '排序',
  `remark` text COMMENT '说明//textarea',
  `create_time` varchar(64) DEFAULT NULL COMMENT '创建时间',
  `create_id` int(11) DEFAULT '0' COMMENT '创建者',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='角色';

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('10', '实习生', '1', '3', null, '2017-11-30 14:50:12', '1');
INSERT INTO `sys_role` VALUES ('11', '见习主管', '1', '2', null, '2017-11-30 14:50:43', '1');
INSERT INTO `sys_role` VALUES ('12', '主管', '1', '1', null, '2017-11-30 14:50:59', '1');

-- ----------------------------
-- Table structure for `sys_role_menu`
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `roleid` int(11) NOT NULL COMMENT '角色id',
  `menuid` int(11) NOT NULL COMMENT '菜单id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=162 DEFAULT CHARSET=utf8 COMMENT='角色和菜单关联';

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES ('133', '12', '30');
INSERT INTO `sys_role_menu` VALUES ('134', '12', '33');
INSERT INTO `sys_role_menu` VALUES ('135', '12', '34');
INSERT INTO `sys_role_menu` VALUES ('136', '12', '35');
INSERT INTO `sys_role_menu` VALUES ('137', '12', '36');
INSERT INTO `sys_role_menu` VALUES ('138', '12', '1');
INSERT INTO `sys_role_menu` VALUES ('139', '12', '2');
INSERT INTO `sys_role_menu` VALUES ('140', '12', '3');
INSERT INTO `sys_role_menu` VALUES ('141', '12', '4');
INSERT INTO `sys_role_menu` VALUES ('142', '12', '5');
INSERT INTO `sys_role_menu` VALUES ('143', '12', '6');
INSERT INTO `sys_role_menu` VALUES ('144', '12', '14');
INSERT INTO `sys_role_menu` VALUES ('145', '12', '39');
INSERT INTO `sys_role_menu` VALUES ('146', '11', '30');
INSERT INTO `sys_role_menu` VALUES ('147', '11', '33');
INSERT INTO `sys_role_menu` VALUES ('148', '11', '34');
INSERT INTO `sys_role_menu` VALUES ('149', '11', '35');
INSERT INTO `sys_role_menu` VALUES ('150', '11', '36');
INSERT INTO `sys_role_menu` VALUES ('151', '11', '1');
INSERT INTO `sys_role_menu` VALUES ('152', '11', '3');
INSERT INTO `sys_role_menu` VALUES ('153', '11', '5');
INSERT INTO `sys_role_menu` VALUES ('154', '11', '14');
INSERT INTO `sys_role_menu` VALUES ('155', '10', '30');
INSERT INTO `sys_role_menu` VALUES ('156', '10', '33');
INSERT INTO `sys_role_menu` VALUES ('157', '10', '34');
INSERT INTO `sys_role_menu` VALUES ('158', '10', '35');
INSERT INTO `sys_role_menu` VALUES ('159', '10', '36');
INSERT INTO `sys_role_menu` VALUES ('160', '10', '1');
INSERT INTO `sys_role_menu` VALUES ('161', '10', '14');

-- ----------------------------
-- Table structure for `sys_user`
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `userid` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `username` varchar(32) NOT NULL COMMENT '用户名/11111',
  `password` varchar(32) NOT NULL COMMENT '密码',
  `realname` varchar(32) DEFAULT NULL COMMENT '真实姓名',
  `departid` int(11) DEFAULT '0' COMMENT '部门/11111/dict',
  `usertype` int(11) DEFAULT '2' COMMENT '类型//select/1,管理员,2,普通用户,3,前台用户,4,第三方用户,5,API用户',
  `state` int(11) DEFAULT '10' COMMENT '状态',
  `thirdid` varchar(200) DEFAULT NULL COMMENT '第三方ID',
  `endtime` varchar(32) DEFAULT NULL COMMENT '结束时间',
  `email` varchar(64) DEFAULT NULL COMMENT 'email',
  `tel` varchar(32) DEFAULT NULL COMMENT '手机号',
  `address` varchar(32) DEFAULT NULL COMMENT '地址',
  `title_url` varchar(200) DEFAULT NULL COMMENT '头像地址',
  `remark` varchar(1000) DEFAULT NULL COMMENT '说明',
  `theme` varchar(64) DEFAULT 'default' COMMENT '主题',
  `back_site_id` int(11) DEFAULT '0' COMMENT '后台选择站点ID',
  `create_site_id` int(11) DEFAULT '1' COMMENT '创建站点ID',
  `create_time` varchar(64) DEFAULT NULL COMMENT '创建时间',
  `create_id` int(11) DEFAULT '0' COMMENT '创建者',
  PRIMARY KEY (`userid`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COMMENT='用户';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('1', 'admin', 'EY3JNDE7nu8=', '系统管理员', '1', '1', '10', null, null, '454979901@qq.com', null, null, null, '时间是最好的老师，但遗憾的是——最后他把所有的学生都弄死了', 'flat', '5', '1', '2016-06-06 06:06:06', '1');
INSERT INTO `sys_user` VALUES ('15', 'demo', 'EY3JNDE7nu8=', 'demo', '44', '2', '10', null, null, null, null, null, null, null, 'flat', '0', '1', '2017-11-30 14:46:24', '1');
INSERT INTO `sys_user` VALUES ('16', 'demo2', 'EY3JNDE7nu8=', 'demo2', '45', '2', '10', null, null, null, null, null, null, null, 'flat', '0', '1', '2017-11-30 14:47:15', '1');
INSERT INTO `sys_user` VALUES ('17', 'demo3', 'EY3JNDE7nu8=', 'demo3', '46', '2', '10', null, null, null, null, null, null, null, 'flat', '0', '1', '2017-11-30 14:47:35', '1');
INSERT INTO `sys_user` VALUES ('18', 'admin2', 'EY3JNDE7nu8=', '管理员', '1', '1', '10', null, null, null, null, null, null, null, 'flat-ui', '0', '1', '2017-11-30 14:48:35', '1');

-- ----------------------------
-- Table structure for `sys_user_role`
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `userid` int(11) NOT NULL COMMENT '用户id',
  `roleid` int(11) NOT NULL COMMENT '角色id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8 COMMENT='用户和角色关联';

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES ('2', '4', '3');
INSERT INTO `sys_user_role` VALUES ('3', '4', '1');
INSERT INTO `sys_user_role` VALUES ('7', '3', '3');
INSERT INTO `sys_user_role` VALUES ('8', '3', '1');
INSERT INTO `sys_user_role` VALUES ('22', '6', '2');
INSERT INTO `sys_user_role` VALUES ('26', '9', '6');
INSERT INTO `sys_user_role` VALUES ('27', '2', '2');
INSERT INTO `sys_user_role` VALUES ('31', '12', '2');
INSERT INTO `sys_user_role` VALUES ('45', '17', '12');
INSERT INTO `sys_user_role` VALUES ('46', '16', '11');
INSERT INTO `sys_user_role` VALUES ('47', '15', '10');

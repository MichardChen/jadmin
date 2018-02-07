/*
Navicat MySQL Data Transfer

Source Server         : 56本地
Source Server Version : 50611
Source Host           : localhost:3306
Source Database       : jfinal_admin

Target Server Type    : MYSQL
Target Server Version : 50611
File Encoding         : 65001

Date: 2018-02-07 14:50:23
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for job
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
  CONSTRAINT `FK_JOB_CLASS_UIDS` FOREIGN KEY (`jobclass_uids`) REFERENCES `job_class` (`uids`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='调度任务表';

-- ----------------------------
-- Records of job
-- ----------------------------
INSERT INTO `job` VALUES ('ab7fe51ff1474896b37cfd472f4e19ac', '测试单参数值的', '测试单参数值的', 'f7b6b35cf9254ce1bb64a74f3adbbbf5', '1', '10分钟一次测试单参数值的', null, '2017-07-14', '0 0/10 * * * ?');
INSERT INTO `job` VALUES ('fc469c86d0c04cf4a0f47ea825fcb1fd', '20分钟一次', '20分钟一次', '27185d1e4373440cbf2f3cb871f9f62f', '0', '20分钟一次', null, '2017-11-29', '0 0/20 * * * ?');

-- ----------------------------
-- Table structure for job_class
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
-- Table structure for job_class_param
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
-- Table structure for job_log
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
INSERT INTO `job_log` VALUES ('26a6d67e4cce495d989cc6f7e352666a', '1517982000004', '1517982000006', '20分钟一次', '0', '1', '20分钟一次', '[2018-02-07 13:40:00:004]执行\ncom.supyuan.job.jobWeb.job.TestJob类中的\nhello方法;参数值分别为：\n 执行成功！', '执行com.supyuan.job.jobWeb.job.TestJob类中的hello方法;参数值分别为：', '2018-02-07 14:00:00', 'fc469c86d0c04cf4a0f47ea825fcb1fd', '192.168.80.1');
INSERT INTO `job_log` VALUES ('2b902cf0ee3245efbd9a214f634c06ac', '1517985600024', '1517985600062', '20分钟一次', '0', '1', '20分钟一次', '[2018-02-07 14:40:00:024]执行\ncom.supyuan.job.jobWeb.job.TestJob类中的\nhello方法;参数值分别为：\n 执行成功！', '执行com.supyuan.job.jobWeb.job.TestJob类中的hello方法;参数值分别为：', '2018-02-07 15:00:00', 'fc469c86d0c04cf4a0f47ea825fcb1fd', '192.168.80.1');
INSERT INTO `job_log` VALUES ('42566a2389734c5cb646794d5750eb6b', '1517973600003', '1517973600004', '20分钟一次', '0', '1', '20分钟一次', '[2018-02-07 11:20:00:003]执行\ncom.supyuan.job.jobWeb.job.TestJob类中的\nhello方法;参数值分别为：\n 执行成功！', '执行com.supyuan.job.jobWeb.job.TestJob类中的hello方法;参数值分别为：', '2018-02-07 11:40:00', 'fc469c86d0c04cf4a0f47ea825fcb1fd', '192.168.80.1');
INSERT INTO `job_log` VALUES ('56e057841be642a5a9e14bf7aae68353', '1517979600002', '1517979600004', '20分钟一次', '0', '1', '20分钟一次', '[2018-02-07 13:00:00:002]执行\ncom.supyuan.job.jobWeb.job.TestJob类中的\nhello方法;参数值分别为：\n 执行成功！', '执行com.supyuan.job.jobWeb.job.TestJob类中的hello方法;参数值分别为：', '2018-02-07 13:20:00', 'fc469c86d0c04cf4a0f47ea825fcb1fd', '192.168.80.1');
INSERT INTO `job_log` VALUES ('5eb16c68219c4d5f8e1cf078d145cef8', '1517971200036', '1517971200078', '20分钟一次', '0', '1', '20分钟一次', '[2018-02-07 10:40:00:037]执行\ncom.supyuan.job.jobWeb.job.TestJob类中的\nhello方法;参数值分别为：\n 执行成功！', '执行com.supyuan.job.jobWeb.job.TestJob类中的hello方法;参数值分别为：', '2018-02-07 11:00:00', 'fc469c86d0c04cf4a0f47ea825fcb1fd', '192.168.80.1');
INSERT INTO `job_log` VALUES ('8aea4d387e1641ba9a4d25c50d1ceea9', '1517984400026', '1517984400080', '20分钟一次', '0', '1', '20分钟一次', '[2018-02-07 14:20:00:028]执行\ncom.supyuan.job.jobWeb.job.TestJob类中的\nhello方法;参数值分别为：\n 执行成功！', '执行com.supyuan.job.jobWeb.job.TestJob类中的hello方法;参数值分别为：', '2018-02-07 14:40:00', 'fc469c86d0c04cf4a0f47ea825fcb1fd', '192.168.80.1');
INSERT INTO `job_log` VALUES ('8cc4a8e8f6f24cb7ade4298bec612cf4', '1517970000025', '1517970000127', '20分钟一次', '0', '1', '20分钟一次', '[2018-02-07 10:20:00:026]执行\ncom.supyuan.job.jobWeb.job.TestJob类中的\nhello方法;参数值分别为：\n 执行成功！', '执行com.supyuan.job.jobWeb.job.TestJob类中的hello方法;参数值分别为：', '2018-02-07 10:40:00', 'fc469c86d0c04cf4a0f47ea825fcb1fd', '192.168.80.1');
INSERT INTO `job_log` VALUES ('94562f92aa334968aaad6dc6fe81cb60', '1517978400006', '1517978400007', '20分钟一次', '0', '1', '20分钟一次', '[2018-02-07 12:40:00:006]执行\ncom.supyuan.job.jobWeb.job.TestJob类中的\nhello方法;参数值分别为：\n 执行成功！', '执行com.supyuan.job.jobWeb.job.TestJob类中的hello方法;参数值分别为：', '2018-02-07 13:00:00', 'fc469c86d0c04cf4a0f47ea825fcb1fd', '192.168.80.1');
INSERT INTO `job_log` VALUES ('bb5e3d6eac9240cfadf0830290164517', '1511598600001', '1511598600001', '测试单参数值的', '0', '1', '测试单参数值的', '[2017-11-25 03:30:00:001]执行\ncom.supyuan.job.jobWeb.job.TestJob类中的\nadd方法;参数值分别为：\n name:55 emali:66@qq.com 执行成功！', '执行com.supyuan.job.jobWeb.job.TestJob类中的add方法;参数值分别为： name:55 emali:66@qq.com', '2017-11-25 03:32:00', 'ab7fe51ff1474896b37cfd472f4e19ac', '127.0.0.1');
INSERT INTO `job_log` VALUES ('cf0ceedb1d01499c99aa4c3c9ba3a123', '1517972400004', '1517972400006', '20分钟一次', '0', '1', '20分钟一次', '[2018-02-07 11:00:00:004]执行\ncom.supyuan.job.jobWeb.job.TestJob类中的\nhello方法;参数值分别为：\n 执行成功！', '执行com.supyuan.job.jobWeb.job.TestJob类中的hello方法;参数值分别为：', '2018-02-07 11:20:00', 'fc469c86d0c04cf4a0f47ea825fcb1fd', '192.168.80.1');
INSERT INTO `job_log` VALUES ('da39b177b9214fdda489304c7a522d36', '1517977200003', '1517977200004', '20分钟一次', '0', '1', '20分钟一次', '[2018-02-07 12:20:00:003]执行\ncom.supyuan.job.jobWeb.job.TestJob类中的\nhello方法;参数值分别为：\n 执行成功！', '执行com.supyuan.job.jobWeb.job.TestJob类中的hello方法;参数值分别为：', '2018-02-07 12:40:00', 'fc469c86d0c04cf4a0f47ea825fcb1fd', '192.168.80.1');
INSERT INTO `job_log` VALUES ('e63b0c3c21414aeb8aaf402efb6bc8c7', '1517976000002', '1517976000003', '20分钟一次', '0', '1', '20分钟一次', '[2018-02-07 12:00:00:002]执行\ncom.supyuan.job.jobWeb.job.TestJob类中的\nhello方法;参数值分别为：\n 执行成功！', '执行com.supyuan.job.jobWeb.job.TestJob类中的hello方法;参数值分别为：', '2018-02-07 12:20:00', 'fc469c86d0c04cf4a0f47ea825fcb1fd', '192.168.80.1');
INSERT INTO `job_log` VALUES ('f6d44d05a726445ba8369ef0b6d44ba9', '1517980800030', '1517980800106', '20分钟一次', '0', '1', '20分钟一次', '[2018-02-07 13:20:00:031]执行\ncom.supyuan.job.jobWeb.job.TestJob类中的\nhello方法;参数值分别为：\n 执行成功！', '执行com.supyuan.job.jobWeb.job.TestJob类中的hello方法;参数值分别为：', '2018-02-07 13:40:00', 'fc469c86d0c04cf4a0f47ea825fcb1fd', '192.168.80.1');
INSERT INTO `job_log` VALUES ('fc98ffee29024e42b90ccd58838d5411', '1517974800002', '1517974800003', '20分钟一次', '0', '1', '20分钟一次', '[2018-02-07 11:40:00:002]执行\ncom.supyuan.job.jobWeb.job.TestJob类中的\nhello方法;参数值分别为：\n 执行成功！', '执行com.supyuan.job.jobWeb.job.TestJob类中的hello方法;参数值分别为：', '2018-02-07 12:00:00', 'fc469c86d0c04cf4a0f47ea825fcb1fd', '192.168.80.1');
INSERT INTO `job_log` VALUES ('fff1d1133a4e4709aad9582615755005', '1510512360000', '1510512360000', '0 0/2 * * * ?', '0', '1', '0 0/2 * * * ?', '[2017-11-12 13:46:00:000]执行\ncom.supyuan.job.jobWeb.job.TestJob类中的\nhello方法;参数值分别为：\n 执行成功！', '执行com.supyuan.job.jobWeb.job.TestJob类中的hello方法;参数值分别为：', '2017-11-12 13:48:00', '2d894750973349d3a53a01625fa31e29', '127.0.0.1');
INSERT INTO `job_log` VALUES ('fffef37af2d54bfa961259019b075656', '1511680440000', '1511680440001', '测试单参数值的', '0', '1', '测试单参数值的', '[2017-11-26 02:14:00:001]执行\ncom.supyuan.job.jobWeb.job.TestJob类中的\nadd方法;参数值分别为：\n name:55 emali:66@qq.com 执行成功！', '执行com.supyuan.job.jobWeb.job.TestJob类中的add方法;参数值分别为： name:55 emali:66@qq.com', '2017-11-26 02:16:00', 'ab7fe51ff1474896b37cfd472f4e19ac', '127.0.0.1');

-- ----------------------------
-- Table structure for job_param_value
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
-- Table structure for sys_auth
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
-- Table structure for sys_auth_user
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
-- Table structure for sys_department
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
-- Table structure for sys_dict
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
-- Table structure for sys_dict_detail
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
-- Table structure for sys_log
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
) ENGINE=InnoDB AUTO_INCREMENT=2361 DEFAULT CHARSET=utf8 COMMENT='日志';

-- ----------------------------
-- Records of sys_log
-- ----------------------------
INSERT INTO `sys_log` VALUES ('1', '1', '访问量统计', 'tb_pageview', '111', '添加', '', '2017-05-08 14:23:28', '0');
INSERT INTO `sys_log` VALUES ('2348', '2', null, 'sys_user', '18', '登入', '', '2017-11-30 10:12:26', '18');
INSERT INTO `sys_log` VALUES ('2349', '2', null, 'sys_user', '18', '登入', '', '2017-11-30 11:52:13', '18');
INSERT INTO `sys_log` VALUES ('2350', '2', null, 'sys_user', '18', '登入', '', '2017-11-30 12:38:13', '18');
INSERT INTO `sys_log` VALUES ('2351', '2', null, 'sys_user', '18', '登入', '', '2017-11-30 20:09:51', '18');
INSERT INTO `sys_log` VALUES ('2352', '2', null, 'sys_user', '18', '登入', '', '2018-02-07 10:14:43', '18');
INSERT INTO `sys_log` VALUES ('2353', '2', null, 'sys_user', '18', '登入', '', '2018-02-07 10:15:36', '18');
INSERT INTO `sys_log` VALUES ('2354', '2', null, 'sys_user', '1', '登入', '', '2018-02-07 10:28:09', '1');
INSERT INTO `sys_log` VALUES ('2355', '2', null, 'sys_user', '1', '登出', '', '2018-02-07 11:36:16', '1');
INSERT INTO `sys_log` VALUES ('2356', '2', null, 'sys_user', '18', '登入', '', '2018-02-07 11:36:31', '18');
INSERT INTO `sys_log` VALUES ('2357', '2', null, 'sys_user', '18', '登入', '', '2018-02-07 12:47:06', '18');
INSERT INTO `sys_log` VALUES ('2358', '1', null, 'sys_menu', '40', '添加', '', '2018-02-07 13:09:27', '0');
INSERT INTO `sys_log` VALUES ('2359', '1', null, 'sys_menu', '40', '更新', '', '2018-02-07 13:09:50', '18');
INSERT INTO `sys_log` VALUES ('2360', '1', null, 'sys_menu', '40', '更新', '', '2018-02-07 13:10:15', '18');

-- ----------------------------
-- Table structure for sys_menu
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
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8 COMMENT='菜单';

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
INSERT INTO `sys_menu` VALUES ('40', '0', '资讯管理', 'news', 'news/index', '1', '1', '8', '1', '2018-02-07 13:09:27', '18');

-- ----------------------------
-- Table structure for sys_role
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
-- Table structure for sys_role_menu
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
-- Table structure for sys_user
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
INSERT INTO `sys_user` VALUES ('18', 'admin2', 'EY3JNDE7nu8=', '管理员', '1', '1', '10', null, null, null, null, null, null, null, 'flat', '0', '1', '2017-11-30 14:48:35', '1');

-- ----------------------------
-- Table structure for sys_user_role
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

-- ----------------------------
-- Table structure for t_news
-- ----------------------------
DROP TABLE IF EXISTS `t_news`;
CREATE TABLE `t_news` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `news_logo` varchar(255) DEFAULT NULL,
  `news_title` varchar(255) DEFAULT NULL,
  `news_type_cd` varchar(255) DEFAULT NULL,
  `hot_flg` int(11) DEFAULT '0',
  `create_user` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  `flg` int(255) DEFAULT '1',
  `content` longtext,
  `content_url` varchar(255) DEFAULT NULL,
  `update_user_id` int(11) DEFAULT NULL,
  `top_flg` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_news
-- ----------------------------
INSERT INTO `t_news` VALUES ('1', 'http://app.tongjichaye.com:88/tea/1cf8e246-7238-41d0-8b8d-766bc0025708.png', '不负杯中茶，不负心中人', '030002', '1', '1', '2017-11-17 06:56:40', '2017-11-20 23:21:54', '1', '<!DOCTYPE html><html><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\"/> <meta charset=\"utf-8\"><title>不负杯中茶，不负心中人</title></head><body></body></html>', 'http://mp.weixin.qq.com/s/TMIrp47H0ufnX-pJcnvyCw', '1', '0');
INSERT INTO `t_news` VALUES ('2', 'http://app.tongjichaye.com:88/tea/c301f8eb-9681-421a-ac2b-f898f81ee2e8.jpg', '三种红茶冲泡方法，最后一种最简单', '030002', '1', '1', '2017-11-17 06:58:01', '2017-11-23 17:17:23', '0', '<!DOCTYPE html><html><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\"/> <meta charset=\"utf-8\"><title>三种红茶冲泡方法，最后一种最简单</title></head><body></body></html>', 'https://mp.weixin.qq.com/s/m3ROtsg4comWY0OAVAvQTw', '1', '2');
INSERT INTO `t_news` VALUES ('3', 'http://app.tongjichaye.com:88/tea/6f187346-6bc3-499f-8b96-848685784413.png', '适宜冬天喝的茶，全在这里！', '030001', '1', '1', '2017-11-17 06:59:26', '2017-11-17 06:59:26', '1', '<!DOCTYPE html><html><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\"/> <meta charset=\"utf-8\"><title>适宜冬天喝的茶，全在这里！</title></head><body></body></html>', 'http://mp.weixin.qq.com/s/IHL9F5vTEpBqwTVV7XPtyg', '1', null);
INSERT INTO `t_news` VALUES ('4', 'http://app.tongjichaye.com:88/tea/828da32e-be8f-4fe9-8484-07cc4047fc06.png', '普洱茶“越陈越香”，为什么不会过期呢？', '030005', '1', '1', '2017-11-17 07:01:51', '2017-11-17 07:01:51', '1', '<!DOCTYPE html><html><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\"/> <meta charset=\"utf-8\"><title>普洱茶“越陈越香”，为什么不会过期呢？</title></head><body></body></html>', 'http://mp.weixin.qq.com/s/m-t_4atGRaexkyS2eKfREw', '1', null);
INSERT INTO `t_news` VALUES ('5', 'http://app.tongjichaye.com:88/tea/11805193-21c8-40b6-bc55-842664296ad0.png', '喝茶，很少人真正知道的事', '030002', '1', '1', '2017-11-17 07:02:36', '2017-11-17 07:04:25', '0', '<!DOCTYPE html><html><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\"/> <meta charset=\"utf-8\"><title>喝茶，很少人真正知道的事</title></head><body></body></html>', 'https://mp.weixin.qq.com/s/Rjeogj0m-MGC5vMCf-A3oQ', '1', null);
INSERT INTO `t_news` VALUES ('6', 'http://app.tongjichaye.com:88/tea/100e2dc5-cc00-45f0-bbec-e373fb0272f0.png', '一杯熟普洱，关爱每一位女性', '030002', '1', '1', '2017-11-17 07:03:14', '2017-11-17 07:03:14', '1', '<!DOCTYPE html><html><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\"/> <meta charset=\"utf-8\"><title>一杯熟普洱，关爱每一位女性</title></head><body></body></html>', 'https://mp.weixin.qq.com/s/s9ChNwvbnRh6Da88jTLbqA', '1', null);
INSERT INTO `t_news` VALUES ('7', 'http://app.tongjichaye.com:88/tea/a9e45312-d199-4dec-9863-662b68918612.png', '普洱茶', '030002', '1', '1', '2017-11-17 07:04:16', '2017-11-17 07:04:16', '1', '<!DOCTYPE html><html><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\"/> <meta charset=\"utf-8\"><title>普洱茶</title></head><body></body></html>', 'http://mp.weixin.qq.com/s/aCZhChvmoLPaQQcHXGDUWQ', '1', null);
INSERT INTO `t_news` VALUES ('8', 'http://app.tongjichaye.com:88/tea/917e1e28-9613-4392-ac10-13e5ad9c5480.png', '原来，茶人的最后一站是普洱', '030002', '1', '1', '2017-11-20 23:21:35', '2017-12-05 10:20:50', '1', '<!DOCTYPE html><html><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\"/> <meta charset=\"utf-8\"><title>原来，茶人的最后一站是普洱</title></head><body></body></html>', 'http://mp.weixin.qq.com/s/5wpf-8S3h83-252ey9j--g', '1', '0');
INSERT INTO `t_news` VALUES ('9', 'http://app.tongjichaye.com:88/tea/69f49a51-294b-479d-add4-07fd90b3b969.jpeg', '冬天喝普洱必须要注意的几点', '030004', '1', '1', '2017-11-24 09:28:26', '2017-12-05 10:20:38', '1', '<!DOCTYPE html><html><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\"/> <meta charset=\"utf-8\"><title>冬天喝普洱必须要注意的几点</title></head><body></body></html>', 'http://mp.weixin.qq.com/s/Fvpye8I2qvAyM7yjdN2yhg', '1', '0');
INSERT INTO `t_news` VALUES ('10', 'http://app.tongjichaye.com:88/tea/1572d54f-738b-4da1-870b-288c9198af38.jpg', '河南电视台到访同记', '030005', '1', '1', '2017-11-27 13:56:21', '2017-11-27 14:24:33', '0', '<!DOCTYPE html><html><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\"/> <meta charset=\"utf-8\"><title>河南电视台到访同记</title></head><body></body></html>', 'http://mp.weixin.qq.com/s?__biz=MzUyNTMzMDEwNg==&mid=2247483760&idx=1&sn=655b8bbfefacac1ea43f58b30b5e9d2d&chksm=fa1ef2a5cd697bb3ba6147fe26147a00e98b3a9722bad2d98407c26605d10127cd3a9159dee3#rd', '1', '5');
INSERT INTO `t_news` VALUES ('11', 'http://app.tongjichaye.com:88/tea/0608feb2-fd72-4a71-ab90-c0c23e26fa92.jpg', '河南电视台到访同记茶厂', '030005', '1', '1', '2017-11-27 14:33:30', '2017-12-13 11:48:30', '1', '<!DOCTYPE html><html><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\"/> <meta charset=\"utf-8\"><title>河南电视台到访同记茶厂</title></head><body></body></html>', 'http://mp.weixin.qq.com/s?__biz=MzUyNTMzMDEwNg==&mid=2247483760&idx=1&sn=655b8bbfefacac1ea43f58b30b5e9d2d&chksm=fa1ef2a5cd697bb3ba6147fe26147a00e98b3a9722bad2d98407c26605d10127cd3a9159dee3#rd', '1', '14');
INSERT INTO `t_news` VALUES ('12', 'http://app.tongjichaye.com:88/tea/626edec8-b33b-4961-ad1b-6128782fe8c6.jpg', '同记那些事', '030003', '1', '1', '2017-11-29 09:11:26', '2017-12-13 13:55:09', '1', '<!DOCTYPE html><html><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\"/> <meta charset=\"utf-8\"><title>同记那些事</title></head><body></body></html>', 'http://mp.weixin.qq.com/s?__biz=MzU1MTM0MDYyMg==&mid=2247484206&idx=1&sn=fa94d5a3de85f040d710173c95e09d9b&chksm=fb939c0fcce41519b29611fd29ebcf5616e76c9594ac79bfe856e52c0874f0c086bb4a8cf8e0#rd', '1', '0');
INSERT INTO `t_news` VALUES ('13', 'http://app.tongjichaye.com:88/tea/91540eb3-decb-4b87-ad73-21d90830eae8.jpg', '这里，才是茶真正的发源地。', '030004', '1', '1', '2017-12-04 11:30:19', '2017-12-04 11:32:26', '0', '<!DOCTYPE html><html><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\"/> <meta charset=\"utf-8\"><title>这里，才是茶真正的发源地。</title></head><body></body></html>', 'https://mp.weixin.qq.com/cgi-bin/appmsg?begin=0&count=10&t=media/appmsg_list&type=10&action=list_card&lang=zh_CN&token=1177980', '1', '8');
INSERT INTO `t_news` VALUES ('14', 'http://app.tongjichaye.com:88/tea/4f04a3da-11ba-4566-b262-a302acc40027.jpg', '这里，才是茶真正的发源地。', '030004', '1', '1', '2017-12-04 11:32:24', '2017-12-04 11:36:35', '0', '<!DOCTYPE html><html><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\"/> <meta charset=\"utf-8\"><title>这里，才是茶真正的发源地。</title></head><body></body></html>', 'https://mp.weixin.qq.com/cgi-bin/appmsg?begin=0&count=10&t=media/appmsg_list&type=10&action=list_card&lang=zh_CN&token=1177980', '1', '9');
INSERT INTO `t_news` VALUES ('15', 'http://app.tongjichaye.com:88/tea/6068c1d6-f8ea-40a3-bcb7-05165ac6bb61.jpg', '这里，才是茶真正的发源地。', '030001', '1', '1', '2017-12-04 11:36:32', '2017-12-04 11:42:16', '0', '<!DOCTYPE html><html><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\"/> <meta charset=\"utf-8\"><title>这里，才是茶真正的发源地。</title></head><body></body></html>', 'https://mp.weixin.qq.com/cgi-bin/appmsg?begin=0&count=10&t=media/appmsg_list&type=10&action=list_card&lang=zh_CN&token=1177980', '1', '10');
INSERT INTO `t_news` VALUES ('16', 'http://app.tongjichaye.com:88/tea/f204dd7e-c4f8-464f-bf94-226755cdc506.jpg', '这里，才是茶真正的发源地。', '030001', '1', '1', '2017-12-04 11:42:14', '2017-12-13 11:48:21', '1', '<!DOCTYPE html><html><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\"/> <meta charset=\"utf-8\"><title>这里，才是茶真正的发源地。</title></head><body></body></html>', 'http://mp.weixin.qq.com/s/zG29SV_1NB8bsFgvBoj3oQ', '1', '0');
INSERT INTO `t_news` VALUES ('17', 'http://app.tongjichaye.com:88/tea/3059a53e-7349-424d-8b44-26e4888b23fa.jpg', '新茶上市了，你不打算了解一下么？', '030002', '1', '1', '2017-12-07 14:52:25', '2017-12-07 14:55:10', '0', '<!DOCTYPE html><html><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\"/> <meta charset=\"utf-8\"><title>新茶上市了，你不打算了解一下么？</title></head><body></body></html>', 'https://mp.weixin.qq.com/cgi-bin/appmsg?begin=0&count=10&t=media/appmsg_list&type=10&action=list_card&lang=zh_CN&token=620231586', '1', '12');
INSERT INTO `t_news` VALUES ('18', 'http://app.tongjichaye.com:88/tea/14a2f37d-c934-4924-88db-fc57c8787970.jpg', '新茶上市了，你不打算了解一下么？', '030002', '1', '1', '2017-12-07 14:55:08', '2017-12-14 15:25:13', '1', '<!DOCTYPE html><html><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\"/> <meta charset=\"utf-8\"><title>新茶上市了，你不打算了解一下么？</title></head><body></body></html>', 'http://mp.weixin.qq.com/s/079dTPZVtbQjyJ8Jz4SFLA', '1', '0');
INSERT INTO `t_news` VALUES ('19', 'http://app.tongjichaye.com:88/tea/adc2de3d-be38-4b02-bc3c-e727153bdf3b.jpg', '同记茶业与国际马拉松达成战略合作', '030003', '1', '1', '2017-12-13 13:54:47', '2017-12-20 09:11:31', '1', '<!DOCTYPE html><html><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\"/> <meta charset=\"utf-8\"><title>同记茶业与国际马拉松达成战略合作</title></head><body></body></html>', 'http://mp.weixin.qq.com/s?__biz=MzUyNTMzMDEwNg==&mid=2247483791&idx=1&sn=448ec2e2af032ac8e606789030027c79&chksm=fa1ef25acd697b4c253b57074a3b63b7bd49457e0685998fe4da836729c13ce28e3763be74ac#rd', '1', '0');
INSERT INTO `t_news` VALUES ('21', 'http://app.tongjichaye.com:88/tea/9b92bfdb-3583-43c1-b69f-276a929094a3.jpg', '奔跑吧兄弟，醉美西双版纳国际马拉松即将开赛~', '030003', '1', '1', '2017-12-15 10:40:36', '2017-12-20 09:14:54', '1', '<!DOCTYPE html><html><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\"/> <meta charset=\"utf-8\"><title>奔跑吧兄弟，醉美西双版纳国际马拉松即将开赛~</title></head><body></body></html>', 'http://mp.weixin.qq.com/s?__biz=MzUyNTMzMDEwNg==&mid=2247483796&idx=1&sn=c57339fce5864cf780d99b0b80a122e1&chksm=fa1ef241cd697b57c39eff428619228a41663bed5079f734c6c5440dd4516df62cdb4525519f#rd', '1', '0');
INSERT INTO `t_news` VALUES ('22', 'http://app.tongjichaye.com:88/tea/7965b2de-683a-406c-bcf7-871da0243ed1.jpg', '醉美西双版纳马拉松圆满结束同记茶业倾力协助', '030003', '1', '1', '2017-12-20 09:11:28', '2017-12-20 09:11:28', '1', '<!DOCTYPE html><html><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\"/> <meta charset=\"utf-8\"><title>醉美西双版纳马拉松圆满结束同记茶业倾力协助</title></head><body></body></html>', 'http://mp.weixin.qq.com/s/YpXNAOEZEBSkr8kBLE5xQA', '1', null);
INSERT INTO `t_news` VALUES ('23', 'http://app.tongjichaye.com:88/tea/985e95e7-78bf-41d4-bfc6-c45398a99ec1.jpg', '醉美西双版纳马拉松圆满结束同记茶业倾力协助', '030003', '1', '1', '2017-12-20 09:13:42', '2018-01-15 09:03:03', '1', '<!DOCTYPE html><html><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\"/> <meta charset=\"utf-8\"><title>醉美西双版纳马拉松圆满结束同记茶业倾力协助</title></head><body></body></html>', 'http://mp.weixin.qq.com/s/YpXNAOEZEBSkr8kBLE5xQA', '1', '21');
INSERT INTO `t_news` VALUES ('24', 'http://app.tongjichaye.com:88/tea/2d42d80b-3f53-4160-b3be-9b3f0afa128d.jpg', '同记茶业与蒙顶山茶交所达成战略合作', '030005', '1', '1', '2017-12-28 09:38:07', '2017-12-28 09:38:22', '1', '<!DOCTYPE html><html><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\"/> <meta charset=\"utf-8\"><title>同记茶业与蒙顶山茶交所达成战略合作</title></head><body></body></html>', 'http://mp.weixin.qq.com/s/W3s8Gwqozf2W-6R2cMjyBg', '1', '20');
INSERT INTO `t_news` VALUES ('25', 'http://app.tongjichaye.com:88/tea/501563d4-4f25-4985-beed-28da65ff5684.jpg', '热烈祝贺同记首款产品，易武发行突破百件', '030001', '1', '1', '2018-01-16 15:54:26', '2018-01-16 15:54:53', '1', '<!DOCTYPE html><html><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\"/> <meta charset=\"utf-8\"><title>热烈祝贺同记首款产品，易武发行突破百件</title></head><body></body></html>', 'http://mp.weixin.qq.com/s/F7PzOIXvYcbs_EfJFJEPIg', '1', '22');

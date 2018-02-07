/*
Date: 2017-07-24 10:11:19
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
  CONSTRAINT `FK_JOB_CLASS_UIDS` FOREIGN KEY (`JOBCLASS_UIDS`) REFERENCES `job_class` (`UIDS`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='调度任务表';

-- ----------------------------
-- Records of job
-- ----------------------------
INSERT INTO `job` VALUES ('2d894750973349d3a53a01625fa31e29', '0 0/2 * * * ?', '0 0/2 * * * ?', '27185d1e4373440cbf2f3cb871f9f62f', '1', '0 0/2 * * * ?', null, '2017-06-02', '0 0/2 * * * ?');
INSERT INTO `job` VALUES ('ab7fe51ff1474896b37cfd472f4e19ac', '测试单参数值的', '测试单参数值的', 'f7b6b35cf9254ce1bb64a74f3adbbbf5', '1', '测试单参数值的', null, '2017-07-14', '0 0/2 * * * ?');

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
  CONSTRAINT `FK_JOBCLASS_UIDS` FOREIGN KEY (`PARENTUIDS`) REFERENCES `job_class` (`uids`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='job执行关联的class的方法和参数';

-- ----------------------------
-- Records of job_class_param
-- ----------------------------
INSERT INTO `job_class_param` VALUES ('08cd66754f4841138d76a403bbbdc22c', 'name', '1', 'java.lang.String', '1', 'java.lang.String', 'aaad7bfa453341d6a2c6afae13bddc98', null);
INSERT INTO `job_class_param` VALUES ('8d6a6b06b0284ed0a878420b20ce076d', 'emali', '1', 'java.lang.String', '1', 'java.lang.String', 'aaad7bfa453341d6a2c6afae13bddc98', null);
INSERT INTO `job_class_param` VALUES ('b63a8ec08cd9437ebf7da72182206ca9', 'emali', '1', 'java.lang.String', '1', 'java.lang.String', 'f7b6b35cf9254ce1bb64a74f3adbbbf5', null);
INSERT INTO `job_class_param` VALUES ('bbbe6a3a35d64be19f3861d615fc0754', 'name', '1', 'java.lang.String', '1', 'java.lang.String', 'f7b6b35cf9254ce1bb64a74f3adbbbf5', null);

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
INSERT INTO `job_log` VALUES ('019add1cddd14a289a345955801fe279', '1500861120003', '1500861120007', '测试单参数值的', '0', '1', '测试单参数值的', '[2017-07-24 09:52:00:005]执行\ncom.supyuan.job.jobWeb.job.TestJob类中的\nadd方法;参数值分别为：\n name:55 emali:66@qq.com 执行成功！', '执行com.supyuan.job.jobWeb.job.TestJob类中的add方法;参数值分别为： name:55 emali:66@qq.com', '2017-07-24 09:54:00', 'ab7fe51ff1474896b37cfd472f4e19ac', '10.5.120.37');
INSERT INTO `job_log` VALUES ('14a7ac8a363f491dbf558fdd1c991bb9', '1500027960003', '1500027960004', '测试单参数值的', '0', '1', '测试单参数值的', '[2017-07-14 18:26:00:004]执行\ncom.supyuan.job.jobWeb.job.TestJob类中的\nadd方法;参数值分别为：\n name:55 emali:66@qq.com 执行成功！', '执行com.supyuan.job.jobWeb.job.TestJob类中的add方法;参数值分别为： name:55 emali:66@qq.com', '2017-07-14 18:28:00', 'ab7fe51ff1474896b37cfd472f4e19ac', '10.5.120.37');
INSERT INTO `job_log` VALUES ('14e102f63e8c40a1afbc0ef826ddc595', '1500861480001', '1500861480003', '测试单参数值的', '0', '1', '测试单参数值的', '[2017-07-24 09:58:00:002]执行\ncom.supyuan.job.jobWeb.job.TestJob类中的\nadd方法;参数值分别为：\n name:55 emali:66@qq.com 执行成功！', '执行com.supyuan.job.jobWeb.job.TestJob类中的add方法;参数值分别为： name:55 emali:66@qq.com', '2017-07-24 10:00:00', 'ab7fe51ff1474896b37cfd472f4e19ac', '10.5.120.37');
INSERT INTO `job_log` VALUES ('1cc28df4b0614908a5ac7ae39ea49669', '1500027120008', '1500027120011', '测试单参数值的', '0', '1', '测试单参数值的', '[2017-07-14 18:12:00:009]执行\ncom.supyuan.job.jobWeb.job.TestJob类中的\nadd方法;参数值分别为：\n name:55 emali:66@qq.com 执行成功！', '执行com.supyuan.job.jobWeb.job.TestJob类中的add方法;参数值分别为： name:55 emali:66@qq.com', '2017-07-14', 'ab7fe51ff1474896b37cfd472f4e19ac', '10.5.120.37');
INSERT INTO `job_log` VALUES ('3961824149084410a3f0c977c3aed8fd', '1500024816791', '1500024816791', '3', '0', '0', '3', '[2017-06-02 11:03:00:028]执行\ncom.supyuan.job.jobWeb.job.TestJob类中的\nadd方法;参数值分别为：\n name:0 emali:0 执行成功！', '执行com.supyuan.job.jobWeb.job.TestJob类中的add方法;参数值分别为： name:0 emali:0', '2017-06-02', '231ba2b06ab84aeea0a1efaf3b02efea', '10.5.120.43');
INSERT INTO `job_log` VALUES ('3c1f252c57864acf9d0de70e3bc4130a', '1500024816793', '1500024816791', '7', '0', '0', '7', '[2017-06-01 18:32:00:002]执行\ncom.supyuan.job.jobWeb.job.TestJob类中的\nadd方法;参数值分别为：\n name:8 emali:9 执行成功！', '执行com.supyuan.job.jobWeb.job.TestJob类中的add方法;参数值分别为： name:8 emali:9', '2017-06-01', '664b69463f254a36904a3d8322563248', '10.5.120.43');
INSERT INTO `job_log` VALUES ('3cb7f8b7d1f74ea6b19e706d7e0319ee', '1500861600003', '1500861600008', '测试单参数值的', '0', '1', '测试单参数值的', '[2017-07-24 10:00:00:007]执行\ncom.supyuan.job.jobWeb.job.TestJob类中的\nadd方法;参数值分别为：\n name:55 emali:66@qq.com 执行成功！', '执行com.supyuan.job.jobWeb.job.TestJob类中的add方法;参数值分别为： name:55 emali:66@qq.com', '2017-07-24 10:02:00', 'ab7fe51ff1474896b37cfd472f4e19ac', '10.5.120.37');
INSERT INTO `job_log` VALUES ('3cd75ae9d1834afcbf732181b8a44009', '1500861000043', '1500861000095', '测试单参数值的', '0', '1', '测试单参数值的', '[2017-07-24 09:50:00:043]执行\ncom.supyuan.job.jobWeb.job.TestJob类中的\nadd方法;参数值分别为：\n name:55 emali:66@qq.com 执行成功！', '执行com.supyuan.job.jobWeb.job.TestJob类中的add方法;参数值分别为： name:55 emali:66@qq.com', '2017-07-24 09:52:00', 'ab7fe51ff1474896b37cfd472f4e19ac', '10.5.120.37');
INSERT INTO `job_log` VALUES ('3f42d5ceb18f465b9ef85a9e3458e8aa', '1500024816791', '1500024816791', '7', '0', '0', '7', '[2017-06-01 18:26:00:052]执行\ncom.supyuan.job.jobWeb.job.TestJob类中的\nadd方法;参数值分别为：\n name:8 emali:9 执行成功！', '执行com.supyuan.job.jobWeb.job.TestJob类中的add方法;参数值分别为： name:8 emali:9', '2017-06-01', '664b69463f254a36904a3d8322563248', '10.5.120.43');
INSERT INTO `job_log` VALUES ('43c74e572ba04d38aae4f30d88645879', '1500024816791', '1500024816791', '7', '0', '0', '7', '[2017-06-02 10:22:00:031]执行\ncom.supyuan.job.jobWeb.job.TestJob类中的\nadd方法;参数值分别为：\n name:800 emali:9 执行成功！', '执行com.supyuan.job.jobWeb.job.TestJob类中的add方法;参数值分别为： name:800 emali:9', '2017-06-02', '664b69463f254a36904a3d8322563248', '10.5.120.43');
INSERT INTO `job_log` VALUES ('4ba396990c1640f5a72537d730521bc2', '1500024816791', '1500024816791', '7', '0', '0', '7', '[2017-06-01 18:30:00:003]执行\ncom.supyuan.job.jobWeb.job.TestJob类中的\nadd方法;参数值分别为：\n name:8 emali:9 执行成功！', '执行com.supyuan.job.jobWeb.job.TestJob类中的add方法;参数值分别为： name:8 emali:9', '2017-06-01', '664b69463f254a36904a3d8322563248', '10.5.120.43');
INSERT INTO `job_log` VALUES ('4c906545bcef4a44b109a35cd5fbbaec', '1500027840001', '1500027840005', '测试单参数值的', '0', '1', '测试单参数值的', '[2017-07-14 18:24:00:001]执行\ncom.supyuan.job.jobWeb.job.TestJob类中的\nadd方法;参数值分别为：\n name:55 emali:66@qq.com 执行成功！', '执行com.supyuan.job.jobWeb.job.TestJob类中的add方法;参数值分别为： name:55 emali:66@qq.com', '2017-07-14 18:26:00', 'ab7fe51ff1474896b37cfd472f4e19ac', '10.5.120.37');
INSERT INTO `job_log` VALUES ('7ac6516fcf9c48ee88d7257d2c82c676', '1500861360002', '1500861360003', '测试单参数值的', '0', '1', '测试单参数值的', '[2017-07-24 09:56:00:002]执行\ncom.supyuan.job.jobWeb.job.TestJob类中的\nadd方法;参数值分别为：\n name:55 emali:66@qq.com 执行成功！', '执行com.supyuan.job.jobWeb.job.TestJob类中的add方法;参数值分别为： name:55 emali:66@qq.com', '2017-07-24 09:58:00', 'ab7fe51ff1474896b37cfd472f4e19ac', '10.5.120.37');
INSERT INTO `job_log` VALUES ('81e84999f6364efe8ecea9a98610e116', '1500024816791', '1500024816791', '7', '0', '0', '7', '[2017-06-01 18:34:00:050]执行\ncom.supyuan.job.jobWeb.job.TestJob类中的\nadd方法;参数值分别为：\n name:8 emali:9 执行成功！', '执行com.supyuan.job.jobWeb.job.TestJob类中的add方法;参数值分别为： name:8 emali:9', '2017-06-01', '664b69463f254a36904a3d8322563248', '10.5.120.43');
INSERT INTO `job_log` VALUES ('91555b3ff3054470b4e9e70f3a281b25', '1500027480002', '1500027480004', '测试单参数值的', '0', '1', '测试单参数值的', '[2017-07-14 18:18:00:002]执行\ncom.supyuan.job.jobWeb.job.TestJob类中的\nadd方法;参数值分别为：\n name:55 emali:66@qq.com 执行成功！', '执行com.supyuan.job.jobWeb.job.TestJob类中的add方法;参数值分别为： name:55 emali:66@qq.com', '2017-07-14 18:20:00', 'ab7fe51ff1474896b37cfd472f4e19ac', '10.5.120.37');
INSERT INTO `job_log` VALUES ('91a6ec140c6a47dbbe4693952342a7f3', '1500024816791', '1500024816791', '7', '0', '0', '7', '[2017-06-01 18:28:00:001]执行\ncom.supyuan.job.jobWeb.job.TestJob类中的\nadd方法;参数值分别为：\n name:8 emali:9 执行成功！', '执行com.supyuan.job.jobWeb.job.TestJob类中的add方法;参数值分别为： name:8 emali:9', '2017-06-01', '664b69463f254a36904a3d8322563248', '10.5.120.43');
INSERT INTO `job_log` VALUES ('9748c65192d642049b01e8e9167d1e01', '1500027000001', '1500027000008', '测试单参数值的', '0', '1', '测试单参数值的', '[2017-07-14 18:10:00:007]执行\ncom.supyuan.job.jobWeb.job.TestJob类中的\nadd方法;参数值分别为：\n name:55 emali:66@qq.com 执行成功！', '执行com.supyuan.job.jobWeb.job.TestJob类中的add方法;参数值分别为： name:55 emali:66@qq.com', '2017-07-14', 'ab7fe51ff1474896b37cfd472f4e19ac', '10.5.120.37');
INSERT INTO `job_log` VALUES ('979bae0c0a3e4c79b45c092e9392d138', '1500861720001', '1500861720002', '测试单参数值的', '0', '1', '测试单参数值的', '[2017-07-24 10:02:00:001]执行\ncom.supyuan.job.jobWeb.job.TestJob类中的\nadd方法;参数值分别为：\n name:55 emali:66@qq.com 执行成功！', '执行com.supyuan.job.jobWeb.job.TestJob类中的add方法;参数值分别为： name:55 emali:66@qq.com', '2017-07-24 10:04:00', 'ab7fe51ff1474896b37cfd472f4e19ac', '10.5.120.37');
INSERT INTO `job_log` VALUES ('9a399e4df3d94571b9bfa397b3b0a9fb', '1500024816791', '1500024816791', '0 0/2 * * * ?', '0', '0', '0 0/2 * * * ?', '[2017-06-02 09:46:00:003]执行\ncom.supyuan.job.jobWeb.job.TestJob类中的\nhello方法;参数值分别为：\n 执行成功！', '执行com.supyuan.job.jobWeb.job.TestJob类中的hello方法;参数值分别为：', '2017-06-02', '2d894750973349d3a53a01625fa31e29', '10.5.120.43');
INSERT INTO `job_log` VALUES ('a4254ea01a104bcb8cb2d1397abc3793', '1500028080001', '1500028080002', '测试单参数值的', '0', '1', '测试单参数值的', '[2017-07-14 18:28:00:001]执行\ncom.supyuan.job.jobWeb.job.TestJob类中的\nadd方法;参数值分别为：\n name:55 emali:66@qq.com 执行成功！', '执行com.supyuan.job.jobWeb.job.TestJob类中的add方法;参数值分别为： name:55 emali:66@qq.com', '2017-07-14 18:30:00', 'ab7fe51ff1474896b37cfd472f4e19ac', '10.5.120.37');
INSERT INTO `job_log` VALUES ('ba66c7deef314038ab11248e054eeec3', '1500027720003', '1500027720005', '测试单参数值的', '0', '1', '测试单参数值的', '[2017-07-14 18:22:00:004]执行\ncom.supyuan.job.jobWeb.job.TestJob类中的\nadd方法;参数值分别为：\n name:55 emali:66@qq.com 执行成功！', '执行com.supyuan.job.jobWeb.job.TestJob类中的add方法;参数值分别为： name:55 emali:66@qq.com', '2017-07-14 18:24:00', 'ab7fe51ff1474896b37cfd472f4e19ac', '10.5.120.37');
INSERT INTO `job_log` VALUES ('c56fb7609960447591e3a1bc95d04d22', '1500027360000', '1500027360001', '测试单参数值的', '0', '1', '测试单参数值的', '[2017-07-14 18:16:00:000]执行\ncom.supyuan.job.jobWeb.job.TestJob类中的\nadd方法;参数值分别为：\n name:55 emali:66@qq.com 执行成功！', '执行com.supyuan.job.jobWeb.job.TestJob类中的add方法;参数值分别为： name:55 emali:66@qq.com', '2017-07-14', 'ab7fe51ff1474896b37cfd472f4e19ac', '10.5.120.37');
INSERT INTO `job_log` VALUES ('c86b3314b29b46d598b85104df7ffdf8', '1500027240002', '1500027240003', '测试单参数值的', '0', '1', '测试单参数值的', '[2017-07-14 18:14:00:002]执行\ncom.supyuan.job.jobWeb.job.TestJob类中的\nadd方法;参数值分别为：\n name:55 emali:66@qq.com 执行成功！', '执行com.supyuan.job.jobWeb.job.TestJob类中的add方法;参数值分别为： name:55 emali:66@qq.com', '2017-07-14', 'ab7fe51ff1474896b37cfd472f4e19ac', '10.5.120.37');
INSERT INTO `job_log` VALUES ('cacdd772608c4a4f8850d590688a146a', '1500861240001', '1500861240002', '测试单参数值的', '0', '1', '测试单参数值的', '[2017-07-24 09:54:00:001]执行\ncom.supyuan.job.jobWeb.job.TestJob类中的\nadd方法;参数值分别为：\n name:55 emali:66@qq.com 执行成功！', '执行com.supyuan.job.jobWeb.job.TestJob类中的add方法;参数值分别为： name:55 emali:66@qq.com', '2017-07-24 09:56:00', 'ab7fe51ff1474896b37cfd472f4e19ac', '10.5.120.37');
INSERT INTO `job_log` VALUES ('ea9721718d4a4cf3b218875df26b1523', '1500027600001', '1500027600002', '测试单参数值的', '0', '1', '测试单参数值的', '[2017-07-14 18:20:00:001]执行\ncom.supyuan.job.jobWeb.job.TestJob类中的\nadd方法;参数值分别为：\n name:55 emali:66@qq.com 执行成功！', '执行com.supyuan.job.jobWeb.job.TestJob类中的add方法;参数值分别为： name:55 emali:66@qq.com', '2017-07-14 18:22:00', 'ab7fe51ff1474896b37cfd472f4e19ac', '10.5.120.37');
INSERT INTO `job_log` VALUES ('f7389e2e4ca04dfdbff80617e2eec1dd', '1500026954269', '1500026954270', '测试单参数值的', '1', '1', '测试单参数值的', '[2017-07-14 18:09:14:269]执行\ncom.supyuan.job.jobWeb.job.TestJob类中的\nadd方法;参数值分别为：\n name:55 emali:66@qq.com 执行成功！', '执行com.supyuan.job.jobWeb.job.TestJob类中的add方法;参数值分别为： name:55 emali:66@qq.com', null, 'ab7fe51ff1474896b37cfd472f4e19ac', '10.5.120.37');
INSERT INTO `job_log` VALUES ('fa3081e5b68045c98815bbea2d9036d0', '1500024816791', '1500024816791', '0 0/2 * * * ?', '1', '0', '0 0/2 * * * ?', '[2017-06-02 09:44:35:953]执行\ncom.supyuan.job.jobWeb.job.TestJob类中的\nhello方法;参数值分别为：\n 执行成功！', '执行com.supyuan.job.jobWeb.job.TestJob类中的hello方法;参数值分别为：', null, '2d894750973349d3a53a01625fa31e29', '10.5.120.43');

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
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8 COMMENT='部门';

-- ----------------------------
-- Records of sys_department
-- ----------------------------
INSERT INTO `sys_department` VALUES ('1', '0', '系统承建单位', null, '99', 'system', '15888888888', null, '2016-06-06 06:06:06', '1', '2016-06-06 06:06:06', '1');
INSERT INTO `sys_department` VALUES ('3', '0', '第三方用户', null, '90', '无人', '15888888888', null, '2017-05-14 10:05:19', '1', '2015-06-01 12:39:41', '1');
INSERT INTO `sys_department` VALUES ('5', '4', '开发部1', 'ABC001', '101', null, null, null, '2017-05-12 05:40:16', '1', '2016-07-31 18:15:29', '1');
INSERT INTO `sys_department` VALUES ('6', '4', '财务部', 'ABC003', '103', null, null, null, '2016-07-31 18:16:06', '1', '2016-07-31 18:16:06', '1');
INSERT INTO `sys_department` VALUES ('8', '3', '测试部', 'ABC0011', '101', null, null, null, '2017-05-14 12:52:15', '1', '2016-07-31 18:16:52', '1');
INSERT INTO `sys_department` VALUES ('15', '0', '111', '1', '11', '1', '1', '1', '2017-05-17 11:09:44', '1', '2017-05-14 01:24:10', '1');
INSERT INTO `sys_department` VALUES ('18', '0', 'aaaaaaaaaaaa', 'aaaaaaaaaaaa', '11', null, null, null, '2017-05-14 21:09:41', '1', '2017-05-14 21:09:41', '1');
INSERT INTO `sys_department` VALUES ('24', '18', 'ccc', 'ccc', '123456', '123456', '123456', '哈哈', '2017-05-15 20:49:34', '1', '2017-05-15 20:49:34', '1');
INSERT INTO `sys_department` VALUES ('25', '18', 'ddd1', '123456', '1234565', '123456', '123456', 'hahaha', '2017-05-17 03:03:17', '1', '2017-05-15 20:50:33', '1');
INSERT INTO `sys_department` VALUES ('26', '8', 'dddddd', 'ddd', '1', 'd', 'd', 'd', '2017-05-17 01:57:33', '1', '2017-05-15 21:20:46', '1');
INSERT INTO `sys_department` VALUES ('27', '26', 'hhhhhhhhhhhh', 'h', '2', 'h', 'h', 'h', '2017-05-15 21:21:23', '1', '2017-05-15 21:21:23', '1');
INSERT INTO `sys_department` VALUES ('29', '26', '胜多负少第三方2', '2323445344', '123', '深蓝色', null, null, '2017-05-18 04:02:21', '1', '2017-05-16 05:43:53', '1');
INSERT INTO `sys_department` VALUES ('30', '3', '盛世嫡妃', 'sdad', '1212', 'dsa', 'dsad', 'sad', '2017-05-16 23:25:45', '1', '2017-05-16 05:44:24', '1');
INSERT INTO `sys_department` VALUES ('31', '29', '是的是的', null, '222', null, null, null, '2017-05-16 05:44:39', '1', '2017-05-16 05:44:39', '1');
INSERT INTO `sys_department` VALUES ('32', '0', '111', '111', '111', '111', '11', '111', '2017-05-16 06:39:29', '1', '2017-05-16 06:39:29', '1');
INSERT INTO `sys_department` VALUES ('34', '29', '我就是不知道', 'nnnciya', '1342', 'liushen', '19876547865', '谁知道这是什么鬼机构', '2017-05-17 03:02:44', '1', '2017-05-17 03:02:44', '1');
INSERT INTO `sys_department` VALUES ('35', '15', 'test113233', '1', '1', '1', '1', '11', '2017-05-17 21:07:35', '1', '2017-05-17 08:29:55', '1');
INSERT INTO `sys_department` VALUES ('36', '0', '中国银行', '00000', '1', null, null, null, '2017-05-17 11:09:34', '1', '2017-05-17 11:09:34', '1');
INSERT INTO `sys_department` VALUES ('38', '36', '北京分行', '01000', '2', null, null, null, '2017-05-17 11:10:33', '1', '2017-05-17 11:10:33', '1');
INSERT INTO `sys_department` VALUES ('39', '36', '上海分行', '02000', '3', null, null, null, '2017-05-17 11:10:47', '1', '2017-05-17 11:10:47', '1');
INSERT INTO `sys_department` VALUES ('40', '36', '山东分行', '04000', '4', null, null, null, '2017-05-17 11:11:07', '1', '2017-05-17 11:11:07', '1');
INSERT INTO `sys_department` VALUES ('41', '38', '北京东城支行', '01001', '1', null, null, null, '2017-05-17 11:11:28', '1', '2017-05-17 11:11:28', '1');
INSERT INTO `sys_department` VALUES ('42', '38', '北京西城支行', '01002', '2', null, null, null, '2017-05-17 11:11:44', '1', '2017-05-17 11:11:44', '1');
INSERT INTO `sys_department` VALUES ('43', '36', '11', '22', '22', '22', '22', '2', '2017-05-18 01:41:31', '1', '2017-05-18 01:41:31', '1');
INSERT INTO `sys_department` VALUES ('44', '27', 'sadd', '12', '21', '123', '4432', '423414', '2017-05-18 11:23:59', '1', '2017-05-18 11:23:59', '1');

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
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=utf8 COMMENT='数据字典主表';

-- ----------------------------
-- Records of sys_dict
-- ----------------------------
INSERT INTO `sys_dict` VALUES ('1', '日志配置', 'systemLog', null);
INSERT INTO `sys_dict` VALUES ('2', '目录类型', 'articleType', null);
INSERT INTO `sys_dict` VALUES ('11', '目录类型', 'folderType', null);
INSERT INTO `sys_dict` VALUES ('100', '系统参数', 'systemParam', null);
INSERT INTO `sys_dict` VALUES ('101', '友情链接类型', 'friendlyLinkType', null);
INSERT INTO `sys_dict` VALUES ('102', '栏目类型', 'materialType', null);

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
) ENGINE=InnoDB AUTO_INCREMENT=109 DEFAULT CHARSET=utf8 COMMENT='数据字典';

-- ----------------------------
-- Records of sys_dict_detail
-- ----------------------------
INSERT INTO `sys_dict_detail` VALUES ('1', 'folderType', '目录', '1', '1', null, null, null, null, '2015-01-30', '1');
INSERT INTO `sys_dict_detail` VALUES ('3', 'folderType', 'a标签target', '3', '3', null, null, null, null, '2015-01-30', '1');
INSERT INTO `sys_dict_detail` VALUES ('4', 'folderType', 'html标签', '4', '4', null, null, null, null, '2015-01-30', '1');
INSERT INTO `sys_dict_detail` VALUES ('11', 'articleType', '正常', '1', '2', null, null, null, null, '2015-01-30', '1');
INSERT INTO `sys_dict_detail` VALUES ('21', 'friendlyLinkType', '友情链接', null, '1', null, null, null, null, '2015-05-06 15:18:59', '1');
INSERT INTO `sys_dict_detail` VALUES ('22', 'friendlyLinkType', '关于我们', null, '2', null, null, null, null, '2015-05-06 15:19:20', '1');
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
INSERT INTO `sys_dict_detail` VALUES ('67', 'systemLog', 'tb_friendlylink', '友情链接', '17', null, null, null, null, '2015-01-30', '1');
INSERT INTO `sys_dict_detail` VALUES ('68', 'systemLog', 'tb_pageview', '访问量统计', '18', null, null, null, null, '2015-01-30', '1');
INSERT INTO `sys_dict_detail` VALUES ('101', 'systemParam', '门头沟信息网', '1', '1', null, null, null, null, '2015-01-30', '1');
INSERT INTO `sys_dict_detail` VALUES ('102', 'materialType', '文章', '1', '1', null, null, null, null, '2016-03-31 22:35:05', '1');
INSERT INTO `sys_dict_detail` VALUES ('103', 'materialType', '图片', '2', '2', null, null, null, null, '2016-03-31 22:35:17', '1');
INSERT INTO `sys_dict_detail` VALUES ('104', 'materialType', '视频', '3', '3', null, null, null, null, '2016-03-31 22:35:28', '1');
INSERT INTO `sys_dict_detail` VALUES ('105', 'materialType', '其他', '9', '9', null, null, null, null, '2016-03-31 22:35:39', '1');
INSERT INTO `sys_dict_detail` VALUES ('106', 'materialType', '栏目', '6', '6', null, null, null, null, '2016-03-31 23:46:27', '1');
INSERT INTO `sys_dict_detail` VALUES ('107', 'systemLog', 'tb_site', '站点管理', '19', null, null, null, null, '2016-04-14 00:02:45', '1');
INSERT INTO `sys_dict_detail` VALUES ('108', 'friendlyLinkType', null, null, '0', null, null, null, null, '2017-05-17 21:41:11', '1');

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
) ENGINE=InnoDB AUTO_INCREMENT=1353 DEFAULT CHARSET=utf8 COMMENT='日志';

-- ----------------------------
-- Records of sys_log
-- ----------------------------
INSERT INTO `sys_log` VALUES ('1', '1', '访问量统计', 'tb_pageview', '111', '添加', '', '2017-05-08 14:23:28', '0');
INSERT INTO `sys_log` VALUES ('2', '2', '用户管理', 'sys_user', '1', '登入', '', '2017-05-08 14:26:43', '1');
INSERT INTO `sys_log` VALUES ('3', '1', null, 'tb_pageview', '112', '添加', '', '2017-05-08 15:47:39', '0');
INSERT INTO `sys_log` VALUES ('4', '1', null, 'tb_pageview', '113', '添加', '', '2017-05-08 15:49:18', '0');
INSERT INTO `sys_log` VALUES ('5', '1', null, 'tb_pageview', '114', '添加', '', '2017-05-08 16:00:51', '0');
INSERT INTO `sys_log` VALUES ('6', '1', null, 'tb_pageview', '115', '添加', '', '2017-05-08 16:23:17', '0');
INSERT INTO `sys_log` VALUES ('7', '1', null, 'tb_pageview', '116', '添加', '', '2017-05-08 16:52:22', '0');
INSERT INTO `sys_log` VALUES ('8', '2', null, 'sys_user', '1', '登入', '', '2017-05-08 17:24:33', '1');
INSERT INTO `sys_log` VALUES ('9', '2', null, 'sys_user', '1', '登入', '', '2017-05-08 17:54:16', '1');
INSERT INTO `sys_log` VALUES ('10', '2', null, 'sys_user', '1', '登入', '', '2017-05-08 17:55:14', '1');
INSERT INTO `sys_log` VALUES ('11', '1', null, 'sys_menu', '21', '更新', '', '2017-05-08 18:08:31', '1');
INSERT INTO `sys_log` VALUES ('12', '2', null, 'sys_user', '1', '登出', '', '2017-05-08 18:08:41', '1');
INSERT INTO `sys_log` VALUES ('13', '2', null, 'sys_user', '1', '登入', '', '2017-05-08 18:08:55', '1');
INSERT INTO `sys_log` VALUES ('14', '1', null, 'sys_menu', '18', '删除', '', '2017-05-08 18:11:35', '1');
INSERT INTO `sys_log` VALUES ('15', '1', null, 'sys_menu', '8', '删除', '', '2017-05-08 18:11:43', '1');
INSERT INTO `sys_log` VALUES ('16', '1', null, 'sys_menu', '16', '删除', '', '2017-05-08 18:11:52', '1');
INSERT INTO `sys_log` VALUES ('17', '1', null, 'sys_menu', '17', '删除', '', '2017-05-08 18:11:56', '1');
INSERT INTO `sys_log` VALUES ('18', '1', null, 'sys_menu', '9', '删除', '', '2017-05-08 18:12:00', '1');
INSERT INTO `sys_log` VALUES ('19', '1', null, 'sys_menu', '29', '删除', '', '2017-05-08 18:12:05', '1');
INSERT INTO `sys_log` VALUES ('20', '1', null, 'sys_menu', '25', '删除', '', '2017-05-08 18:12:09', '1');
INSERT INTO `sys_log` VALUES ('21', '1', null, 'sys_menu', '22', '删除', '', '2017-05-08 18:12:13', '1');
INSERT INTO `sys_log` VALUES ('22', '1', null, 'sys_menu', '24', '删除', '', '2017-05-08 18:12:17', '1');
INSERT INTO `sys_log` VALUES ('23', '1', null, 'sys_menu', '23', '删除', '', '2017-05-08 18:12:21', '1');
INSERT INTO `sys_log` VALUES ('24', '1', null, 'sys_menu', '26', '删除', '', '2017-05-08 18:12:25', '1');
INSERT INTO `sys_log` VALUES ('25', '1', null, 'sys_menu', '27', '删除', '', '2017-05-08 18:12:28', '1');
INSERT INTO `sys_log` VALUES ('26', '1', null, 'sys_menu', '19', '删除', '', '2017-05-08 18:12:32', '1');
INSERT INTO `sys_log` VALUES ('27', '1', null, 'sys_menu', '12', '删除', '', '2017-05-08 18:12:35', '1');
INSERT INTO `sys_log` VALUES ('28', '1', null, 'sys_menu', '15', '删除', '', '2017-05-08 18:12:38', '1');
INSERT INTO `sys_log` VALUES ('29', '1', null, 'sys_menu', '20', '删除', '', '2017-05-08 18:12:42', '1');
INSERT INTO `sys_log` VALUES ('30', '1', null, 'sys_menu', '30', '删除', '', '2017-05-08 18:12:54', '1');
INSERT INTO `sys_log` VALUES ('31', '1', null, 'sys_menu', '13', '删除', '', '2017-05-08 18:12:58', '1');
INSERT INTO `sys_log` VALUES ('32', '1', null, 'sys_menu', '10', '删除', '', '2017-05-08 18:13:01', '1');
INSERT INTO `sys_log` VALUES ('33', '1', null, 'sys_menu', '11', '删除', '', '2017-05-08 18:13:04', '1');
INSERT INTO `sys_log` VALUES ('34', '1', null, 'sys_menu', '7', '删除', '', '2017-05-08 18:13:08', '1');
INSERT INTO `sys_log` VALUES ('35', '1', null, 'sys_menu', '28', '删除', '', '2017-05-08 18:13:16', '1');
INSERT INTO `sys_log` VALUES ('36', '1', null, 'sys_menu', '28', '删除', '', '2017-05-08 18:13:25', '1');
INSERT INTO `sys_log` VALUES ('37', '2', null, 'sys_user', '1', '登出', '', '2017-05-08 18:13:30', '1');
INSERT INTO `sys_log` VALUES ('38', '2', null, 'sys_user', '1', '登入', '', '2017-05-08 18:13:46', '1');
INSERT INTO `sys_log` VALUES ('39', '2', null, 'sys_user', '1', '登出', '', '2017-05-08 18:32:46', '1');
INSERT INTO `sys_log` VALUES ('40', '2', null, 'sys_user', '1', '登入', '', '2017-05-08 18:33:30', '1');
INSERT INTO `sys_log` VALUES ('41', '1', null, 'sys_menu', '31', '删除', '', '2017-05-08 18:39:38', '1');
INSERT INTO `sys_log` VALUES ('42', '2', null, 'sys_user', '1', '登出', '', '2017-05-08 18:39:52', '1');
INSERT INTO `sys_log` VALUES ('43', '2', null, 'sys_user', '1', '登入', '', '2017-05-08 18:40:03', '1');
INSERT INTO `sys_log` VALUES ('44', '2', null, 'sys_user', '1', '登入', '', '2017-05-09 09:28:39', '1');
INSERT INTO `sys_log` VALUES ('45', '2', null, 'sys_user', '1', '登入', '', '2017-05-09 11:26:06', '1');
INSERT INTO `sys_log` VALUES ('46', '2', null, 'sys_user', '1', '登入', '', '2017-05-12 15:01:37', '1');
INSERT INTO `sys_log` VALUES ('47', '2', null, 'sys_user', '1', '登入', '', '2017-05-12 04:19:54', '1');
INSERT INTO `sys_log` VALUES ('48', '2', null, 'sys_user', '1', '登入', '', '2017-05-12 04:30:02', '1');
INSERT INTO `sys_log` VALUES ('49', '2', null, 'sys_user', '1', '登入', '', '2017-05-12 04:33:43', '1');
INSERT INTO `sys_log` VALUES ('50', '2', null, 'sys_user', '1', '登入', '', '2017-05-12 04:36:19', '1');
INSERT INTO `sys_log` VALUES ('51', '2', null, 'sys_user', '1', '登入', '', '2017-05-12 04:46:11', '1');
INSERT INTO `sys_log` VALUES ('52', '2', null, 'sys_user', '1', '登入', '', '2017-05-12 04:46:35', '1');
INSERT INTO `sys_log` VALUES ('53', '2', null, 'sys_user', '1', '登入', '', '2017-05-12 04:47:48', '1');
INSERT INTO `sys_log` VALUES ('54', '2', null, 'sys_user', '1', '登入', '', '2017-05-12 04:48:26', '1');
INSERT INTO `sys_log` VALUES ('55', '2', null, 'sys_user', '1', '登出', '', '2017-05-12 04:48:52', '1');
INSERT INTO `sys_log` VALUES ('56', '2', null, 'sys_user', '1', '登出', '', '2017-05-12 04:50:03', '1');
INSERT INTO `sys_log` VALUES ('57', '2', null, 'sys_user', '1', '登入', '', '2017-05-12 04:52:45', '1');
INSERT INTO `sys_log` VALUES ('58', '2', null, 'sys_user', '1', '登入', '', '2017-05-12 05:06:56', '1');
INSERT INTO `sys_log` VALUES ('59', '2', null, 'sys_user', '1', '登入', '', '2017-05-12 05:22:21', '1');
INSERT INTO `sys_log` VALUES ('60', '2', null, 'sys_user', '1', '登入', '', '2017-05-12 05:23:27', '1');
INSERT INTO `sys_log` VALUES ('61', '2', null, 'sys_user', '1', '登入', '', '2017-05-12 05:24:31', '1');
INSERT INTO `sys_log` VALUES ('62', '2', null, 'sys_user', '1', '登入', '', '2017-05-12 05:33:19', '1');
INSERT INTO `sys_log` VALUES ('63', '2', null, 'sys_user', '1', '登入', '', '2017-05-12 05:36:38', '1');
INSERT INTO `sys_log` VALUES ('64', '1', null, 'sys_role', '2', '添加', '', '2017-05-12 05:38:29', '1');
INSERT INTO `sys_log` VALUES ('65', '1', null, 'sys_role_menu', '1', '添加', '', '2017-05-12 05:38:38', '1');
INSERT INTO `sys_log` VALUES ('66', '1', null, 'sys_role_menu', '2', '添加', '', '2017-05-12 05:38:38', '1');
INSERT INTO `sys_log` VALUES ('67', '1', null, 'sys_menu', '21', '更新', '', '2017-05-12 05:39:02', '1');
INSERT INTO `sys_log` VALUES ('68', '1', null, 'sys_department', '5', '更新', '', '2017-05-12 05:40:16', '1');
INSERT INTO `sys_log` VALUES ('69', '2', null, 'sys_user', '1', '登入', '', '2017-05-12 05:42:00', '1');
INSERT INTO `sys_log` VALUES ('70', '2', null, 'sys_user', '1', '登出', '', '2017-05-12 05:44:02', '1');
INSERT INTO `sys_log` VALUES ('71', '2', null, 'sys_user', '1', '登入', '', '2017-05-12 06:03:23', '1');
INSERT INTO `sys_log` VALUES ('72', '2', null, 'sys_user', '1', '登入', '', '2017-05-12 06:16:45', '1');
INSERT INTO `sys_log` VALUES ('73', '2', null, 'sys_user', '1', '登入', '', '2017-05-12 06:17:11', '1');
INSERT INTO `sys_log` VALUES ('74', '2', null, 'sys_user', '1', '登入', '', '2017-05-12 06:22:46', '1');
INSERT INTO `sys_log` VALUES ('75', '2', null, 'sys_user', '1', '登入', '', '2017-05-12 06:23:02', '1');
INSERT INTO `sys_log` VALUES ('76', '1', null, 'sys_menu', '22', '添加', '', '2017-05-12 06:24:42', '1');
INSERT INTO `sys_log` VALUES ('77', '1', null, 'sys_menu', '22', '删除', '', '2017-05-12 06:25:05', '1');
INSERT INTO `sys_log` VALUES ('78', '2', null, 'sys_user', '1', '登出', '', '2017-05-12 06:26:52', '1');
INSERT INTO `sys_log` VALUES ('79', '2', null, 'sys_user', '1', '登入', '', '2017-05-12 07:11:01', '1');
INSERT INTO `sys_log` VALUES ('80', '2', null, 'sys_user', '1', '登入', '', '2017-05-12 07:40:48', '1');
INSERT INTO `sys_log` VALUES ('81', '2', null, 'sys_user', '1', '登入', '', '2017-05-12 08:48:08', '1');
INSERT INTO `sys_log` VALUES ('82', '1', null, 'sys_department', '2', '删除', '', '2017-05-12 08:49:34', '1');
INSERT INTO `sys_log` VALUES ('83', '2', null, 'sys_user', '1', '登入', '', '2017-05-12 09:26:46', '1');
INSERT INTO `sys_log` VALUES ('84', '2', null, 'sys_user', '1', '登入', '', '2017-05-12 09:50:58', '1');
INSERT INTO `sys_log` VALUES ('85', '2', null, 'sys_user', '1', '登入', '', '2017-05-12 09:54:17', '1');
INSERT INTO `sys_log` VALUES ('86', '2', null, 'sys_user', '1', '登入', '', '2017-05-12 09:56:51', '1');
INSERT INTO `sys_log` VALUES ('87', '2', null, 'sys_user', '1', '登入', '', '2017-05-12 10:04:49', '1');
INSERT INTO `sys_log` VALUES ('88', '2', null, 'sys_user', '1', '登入', '', '2017-05-12 10:33:52', '1');
INSERT INTO `sys_log` VALUES ('89', '1', null, 'sys_department', '9', '添加', '', '2017-05-12 10:35:54', '1');
INSERT INTO `sys_log` VALUES ('90', '2', null, 'sys_user', '1', '登入', '', '2017-05-12 11:11:20', '1');
INSERT INTO `sys_log` VALUES ('91', '2', null, 'sys_user', '1', '登入', '', '2017-05-12 11:19:53', '1');
INSERT INTO `sys_log` VALUES ('92', '2', null, 'sys_user', '1', '登入', '', '2017-05-12 11:35:12', '1');
INSERT INTO `sys_log` VALUES ('93', '2', null, 'sys_user', '1', '登入', '', '2017-05-12 11:46:05', '1');
INSERT INTO `sys_log` VALUES ('94', '2', null, 'sys_user', '1', '登入', '', '2017-05-12 11:53:00', '1');
INSERT INTO `sys_log` VALUES ('95', '2', null, 'sys_user', '1', '登入', '', '2017-05-12 12:23:52', '1');
INSERT INTO `sys_log` VALUES ('96', '2', null, 'sys_user', '1', '登入', '', '2017-05-12 13:30:32', '1');
INSERT INTO `sys_log` VALUES ('97', '2', null, 'sys_user', '1', '登入', '', '2017-05-12 20:00:42', '1');
INSERT INTO `sys_log` VALUES ('98', '2', null, 'sys_user', '1', '登入', '', '2017-05-12 20:37:41', '1');
INSERT INTO `sys_log` VALUES ('99', '2', null, 'sys_user', '1', '登入', '', '2017-05-12 21:52:47', '1');
INSERT INTO `sys_log` VALUES ('100', '2', null, 'sys_user', '1', '登入', '', '2017-05-12 22:04:44', '1');
INSERT INTO `sys_log` VALUES ('101', '2', null, 'sys_user', '1', '登入', '', '2017-05-12 22:09:32', '1');
INSERT INTO `sys_log` VALUES ('102', '2', null, 'sys_user', '1', '登入', '', '2017-05-12 22:20:32', '1');
INSERT INTO `sys_log` VALUES ('103', '2', null, 'sys_user', '1', '登入', '', '2017-05-12 23:04:20', '1');
INSERT INTO `sys_log` VALUES ('104', '2', null, 'sys_user', '1', '登入', '', '2017-05-12 23:46:39', '1');
INSERT INTO `sys_log` VALUES ('105', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 00:40:22', '1');
INSERT INTO `sys_log` VALUES ('106', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 00:47:14', '1');
INSERT INTO `sys_log` VALUES ('107', '1', null, 'sys_department', '9', '删除', '', '2017-05-13 01:10:08', '1');
INSERT INTO `sys_log` VALUES ('108', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 01:31:21', '1');
INSERT INTO `sys_log` VALUES ('109', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 02:36:32', '1');
INSERT INTO `sys_log` VALUES ('110', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 02:44:16', '1');
INSERT INTO `sys_log` VALUES ('111', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 02:44:47', '1');
INSERT INTO `sys_log` VALUES ('112', '1', null, 'sys_department', '7', '删除', '', '2017-05-13 02:46:10', '1');
INSERT INTO `sys_log` VALUES ('113', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 02:46:44', '1');
INSERT INTO `sys_log` VALUES ('114', '1', null, 'sys_department', '10', '添加', '', '2017-05-13 02:47:04', '1');
INSERT INTO `sys_log` VALUES ('115', '1', null, 'sys_department', '11', '添加', '', '2017-05-13 02:47:23', '1');
INSERT INTO `sys_log` VALUES ('116', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 03:34:32', '1');
INSERT INTO `sys_log` VALUES ('117', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 03:45:10', '1');
INSERT INTO `sys_log` VALUES ('118', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 04:02:17', '1');
INSERT INTO `sys_log` VALUES ('119', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 04:10:26', '1');
INSERT INTO `sys_log` VALUES ('120', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 04:10:44', '1');
INSERT INTO `sys_log` VALUES ('121', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 04:13:41', '1');
INSERT INTO `sys_log` VALUES ('122', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 04:24:37', '1');
INSERT INTO `sys_log` VALUES ('123', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 04:35:28', '1');
INSERT INTO `sys_log` VALUES ('124', '2', null, 'sys_user', '1', '登出', '', '2017-05-13 04:35:59', '1');
INSERT INTO `sys_log` VALUES ('125', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 04:40:13', '1');
INSERT INTO `sys_log` VALUES ('126', '2', null, 'sys_user', '1', '登出', '', '2017-05-13 04:41:06', '1');
INSERT INTO `sys_log` VALUES ('127', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 04:50:40', '1');
INSERT INTO `sys_log` VALUES ('128', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 05:00:18', '1');
INSERT INTO `sys_log` VALUES ('129', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 05:30:12', '1');
INSERT INTO `sys_log` VALUES ('130', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 05:49:36', '1');
INSERT INTO `sys_log` VALUES ('131', '2', null, 'sys_user', '1', '登出', '', '2017-05-13 05:50:18', '1');
INSERT INTO `sys_log` VALUES ('132', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 06:17:04', '1');
INSERT INTO `sys_log` VALUES ('133', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 08:48:05', '1');
INSERT INTO `sys_log` VALUES ('134', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 09:06:58', '1');
INSERT INTO `sys_log` VALUES ('135', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 09:18:00', '1');
INSERT INTO `sys_log` VALUES ('136', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 10:02:48', '1');
INSERT INTO `sys_log` VALUES ('137', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 10:27:22', '1');
INSERT INTO `sys_log` VALUES ('138', '2', null, 'sys_user', '1', '登出', '', '2017-05-13 10:30:28', '1');
INSERT INTO `sys_log` VALUES ('139', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 11:07:44', '1');
INSERT INTO `sys_log` VALUES ('140', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 11:30:09', '1');
INSERT INTO `sys_log` VALUES ('141', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 11:32:32', '1');
INSERT INTO `sys_log` VALUES ('142', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 12:03:38', '1');
INSERT INTO `sys_log` VALUES ('143', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 12:11:15', '1');
INSERT INTO `sys_log` VALUES ('144', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 12:21:50', '1');
INSERT INTO `sys_log` VALUES ('145', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 20:18:07', '1');
INSERT INTO `sys_log` VALUES ('146', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 20:47:14', '1');
INSERT INTO `sys_log` VALUES ('147', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 20:49:11', '1');
INSERT INTO `sys_log` VALUES ('148', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 21:06:31', '1');
INSERT INTO `sys_log` VALUES ('149', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 21:07:07', '1');
INSERT INTO `sys_log` VALUES ('150', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 21:10:28', '1');
INSERT INTO `sys_log` VALUES ('151', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 21:18:16', '1');
INSERT INTO `sys_log` VALUES ('152', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 21:21:13', '1');
INSERT INTO `sys_log` VALUES ('153', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 21:29:26', '1');
INSERT INTO `sys_log` VALUES ('154', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 21:32:22', '1');
INSERT INTO `sys_log` VALUES ('155', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 21:33:00', '1');
INSERT INTO `sys_log` VALUES ('156', '1', null, 'sys_department', '3', '更新', '', '2017-05-13 21:33:42', '1');
INSERT INTO `sys_log` VALUES ('157', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 21:35:53', '1');
INSERT INTO `sys_log` VALUES ('158', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 21:36:14', '1');
INSERT INTO `sys_log` VALUES ('159', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 21:36:28', '1');
INSERT INTO `sys_log` VALUES ('160', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 21:36:36', '1');
INSERT INTO `sys_log` VALUES ('161', '1', null, 'sys_dict_detail', '64', '删除', '', '2017-05-13 21:36:45', '1');
INSERT INTO `sys_log` VALUES ('162', '1', null, 'sys_dict_detail', '2', '删除', '', '2017-05-13 21:36:52', '1');
INSERT INTO `sys_log` VALUES ('163', '1', null, 'sys_dict_detail', '13', '删除', '', '2017-05-13 21:36:58', '1');
INSERT INTO `sys_log` VALUES ('164', '1', null, 'sys_dict_detail', '12', '删除', '', '2017-05-13 21:37:02', '1');
INSERT INTO `sys_log` VALUES ('165', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 21:37:09', '1');
INSERT INTO `sys_log` VALUES ('166', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 21:52:01', '1');
INSERT INTO `sys_log` VALUES ('167', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 21:55:03', '1');
INSERT INTO `sys_log` VALUES ('168', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 21:58:14', '1');
INSERT INTO `sys_log` VALUES ('169', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 22:00:53', '1');
INSERT INTO `sys_log` VALUES ('170', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 22:04:16', '1');
INSERT INTO `sys_log` VALUES ('171', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 22:04:23', '1');
INSERT INTO `sys_log` VALUES ('172', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 22:11:40', '1');
INSERT INTO `sys_log` VALUES ('173', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 22:15:00', '1');
INSERT INTO `sys_log` VALUES ('174', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 22:22:50', '1');
INSERT INTO `sys_log` VALUES ('175', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 22:34:54', '1');
INSERT INTO `sys_log` VALUES ('176', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 22:35:04', '1');
INSERT INTO `sys_log` VALUES ('177', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 22:35:36', '1');
INSERT INTO `sys_log` VALUES ('178', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 22:46:30', '1');
INSERT INTO `sys_log` VALUES ('179', '1', null, 'sys_department', '12', '添加', '', '2017-05-13 22:48:14', '1');
INSERT INTO `sys_log` VALUES ('180', '1', null, 'sys_department', '12', '更新', '', '2017-05-13 22:48:22', '1');
INSERT INTO `sys_log` VALUES ('181', '1', null, 'sys_department', '13', '添加', '', '2017-05-13 22:49:08', '1');
INSERT INTO `sys_log` VALUES ('182', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 22:49:19', '1');
INSERT INTO `sys_log` VALUES ('183', '1', null, 'sys_department', '12', '删除', '', '2017-05-13 22:49:23', '1');
INSERT INTO `sys_log` VALUES ('184', '1', null, 'sys_department', '14', '添加', '', '2017-05-13 22:49:51', '1');
INSERT INTO `sys_log` VALUES ('185', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 22:51:24', '1');
INSERT INTO `sys_log` VALUES ('186', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 22:54:54', '1');
INSERT INTO `sys_log` VALUES ('187', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 23:01:59', '1');
INSERT INTO `sys_log` VALUES ('188', '1', null, 'sys_role', '3', '添加', '', '2017-05-13 23:04:10', '1');
INSERT INTO `sys_log` VALUES ('189', '1', null, 'sys_role_menu', '3', '添加', '', '2017-05-13 23:04:24', '1');
INSERT INTO `sys_log` VALUES ('190', '1', null, 'sys_role_menu', '4', '添加', '', '2017-05-13 23:04:24', '1');
INSERT INTO `sys_log` VALUES ('191', '1', null, 'sys_role_menu', '5', '添加', '', '2017-05-13 23:04:24', '1');
INSERT INTO `sys_log` VALUES ('192', '1', null, 'sys_role_menu', '6', '添加', '', '2017-05-13 23:04:24', '1');
INSERT INTO `sys_log` VALUES ('193', '1', null, 'sys_role_menu', '7', '添加', '', '2017-05-13 23:04:24', '1');
INSERT INTO `sys_log` VALUES ('194', '1', null, 'sys_menu', '23', '添加', '', '2017-05-13 23:05:33', '1');
INSERT INTO `sys_log` VALUES ('195', '1', null, 'sys_menu', '24', '添加', '', '2017-05-13 23:06:09', '1');
INSERT INTO `sys_log` VALUES ('196', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 23:08:24', '1');
INSERT INTO `sys_log` VALUES ('197', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 23:08:26', '1');
INSERT INTO `sys_log` VALUES ('198', '1', null, 'sys_user_role', '1', '添加', '', '2017-05-13 23:19:13', '1');
INSERT INTO `sys_log` VALUES ('199', '1', null, 'sys_user_role', '2', '添加', '', '2017-05-13 23:19:21', '1');
INSERT INTO `sys_log` VALUES ('200', '1', null, 'sys_user_role', '3', '添加', '', '2017-05-13 23:19:21', '1');
INSERT INTO `sys_log` VALUES ('201', '1', null, 'sys_department', '14', '删除', '', '2017-05-13 23:19:57', '1');
INSERT INTO `sys_log` VALUES ('202', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 23:20:47', '1');
INSERT INTO `sys_log` VALUES ('203', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 23:21:18', '1');
INSERT INTO `sys_log` VALUES ('204', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 23:23:48', '1');
INSERT INTO `sys_log` VALUES ('205', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 23:26:03', '1');
INSERT INTO `sys_log` VALUES ('206', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 23:27:58', '1');
INSERT INTO `sys_log` VALUES ('207', '2', null, 'sys_user', '1', '登出', '', '2017-05-13 23:30:00', '1');
INSERT INTO `sys_log` VALUES ('208', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 23:32:18', '1');
INSERT INTO `sys_log` VALUES ('209', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 23:39:21', '1');
INSERT INTO `sys_log` VALUES ('210', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 23:40:04', '1');
INSERT INTO `sys_log` VALUES ('211', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 23:41:35', '1');
INSERT INTO `sys_log` VALUES ('212', '2', null, 'sys_user', '1', '登出', '', '2017-05-13 23:44:45', '1');
INSERT INTO `sys_log` VALUES ('213', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 23:47:39', '1');
INSERT INTO `sys_log` VALUES ('214', '2', null, 'sys_user', '1', '登入', '', '2017-05-13 23:47:56', '1');
INSERT INTO `sys_log` VALUES ('215', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 00:04:16', '1');
INSERT INTO `sys_log` VALUES ('216', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 00:06:43', '1');
INSERT INTO `sys_log` VALUES ('217', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 00:19:15', '1');
INSERT INTO `sys_log` VALUES ('218', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 00:21:03', '1');
INSERT INTO `sys_log` VALUES ('219', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 00:23:18', '1');
INSERT INTO `sys_log` VALUES ('220', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 00:24:43', '1');
INSERT INTO `sys_log` VALUES ('221', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 00:25:08', '1');
INSERT INTO `sys_log` VALUES ('222', '2', null, 'sys_user', '1', '登出', '', '2017-05-14 00:25:51', '1');
INSERT INTO `sys_log` VALUES ('223', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 00:44:56', '1');
INSERT INTO `sys_log` VALUES ('224', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 00:58:17', '1');
INSERT INTO `sys_log` VALUES ('225', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 01:04:14', '1');
INSERT INTO `sys_log` VALUES ('226', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 01:05:56', '1');
INSERT INTO `sys_log` VALUES ('227', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 01:11:09', '1');
INSERT INTO `sys_log` VALUES ('228', '2', null, 'sys_user', '1', '登出', '', '2017-05-14 01:12:01', '1');
INSERT INTO `sys_log` VALUES ('229', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 01:12:02', '1');
INSERT INTO `sys_log` VALUES ('230', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 01:18:46', '1');
INSERT INTO `sys_log` VALUES ('231', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 01:22:11', '1');
INSERT INTO `sys_log` VALUES ('232', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 01:24:00', '1');
INSERT INTO `sys_log` VALUES ('233', '1', null, 'sys_department', '15', '添加', '', '2017-05-14 01:24:10', '1');
INSERT INTO `sys_log` VALUES ('234', '1', null, 'sys_department', '16', '添加', '', '2017-05-14 01:24:19', '1');
INSERT INTO `sys_log` VALUES ('235', '1', null, 'sys_department', '16', '更新', '', '2017-05-14 01:24:36', '1');
INSERT INTO `sys_log` VALUES ('236', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 01:24:50', '1');
INSERT INTO `sys_log` VALUES ('237', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 01:25:42', '1');
INSERT INTO `sys_log` VALUES ('238', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 01:27:28', '1');
INSERT INTO `sys_log` VALUES ('239', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 01:29:21', '1');
INSERT INTO `sys_log` VALUES ('240', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 01:44:18', '1');
INSERT INTO `sys_log` VALUES ('241', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 02:00:02', '1');
INSERT INTO `sys_log` VALUES ('242', '2', null, 'sys_user', '1', '登出', '', '2017-05-14 02:00:52', '1');
INSERT INTO `sys_log` VALUES ('243', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 02:01:59', '1');
INSERT INTO `sys_log` VALUES ('244', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 02:15:31', '1');
INSERT INTO `sys_log` VALUES ('245', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 02:27:38', '1');
INSERT INTO `sys_log` VALUES ('246', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 02:36:54', '1');
INSERT INTO `sys_log` VALUES ('247', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 02:44:42', '1');
INSERT INTO `sys_log` VALUES ('248', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 02:44:51', '1');
INSERT INTO `sys_log` VALUES ('249', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 02:56:09', '1');
INSERT INTO `sys_log` VALUES ('250', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 02:59:40', '1');
INSERT INTO `sys_log` VALUES ('251', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 03:03:08', '1');
INSERT INTO `sys_log` VALUES ('252', '2', null, 'sys_user', '1', '登出', '', '2017-05-14 03:04:22', '1');
INSERT INTO `sys_log` VALUES ('253', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 03:06:16', '1');
INSERT INTO `sys_log` VALUES ('254', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 03:08:18', '1');
INSERT INTO `sys_log` VALUES ('255', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 03:12:45', '1');
INSERT INTO `sys_log` VALUES ('256', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 03:17:08', '1');
INSERT INTO `sys_log` VALUES ('257', '1', null, 'sys_user_role', '4', '添加', '', '2017-05-14 03:20:23', '1');
INSERT INTO `sys_log` VALUES ('258', '1', null, 'sys_user_role', '5', '添加', '', '2017-05-14 03:20:23', '1');
INSERT INTO `sys_log` VALUES ('259', '1', null, 'sys_user_role', '6', '添加', '', '2017-05-14 03:20:23', '1');
INSERT INTO `sys_log` VALUES ('260', '2', null, 'sys_user', '1', '登出', '', '2017-05-14 03:20:49', '1');
INSERT INTO `sys_log` VALUES ('261', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 03:26:36', '1');
INSERT INTO `sys_log` VALUES ('262', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 03:29:49', '1');
INSERT INTO `sys_log` VALUES ('263', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 03:43:43', '1');
INSERT INTO `sys_log` VALUES ('264', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 03:52:08', '1');
INSERT INTO `sys_log` VALUES ('265', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 03:54:08', '1');
INSERT INTO `sys_log` VALUES ('266', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 04:01:29', '1');
INSERT INTO `sys_log` VALUES ('267', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 04:06:00', '1');
INSERT INTO `sys_log` VALUES ('268', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 04:15:40', '1');
INSERT INTO `sys_log` VALUES ('269', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 04:33:42', '1');
INSERT INTO `sys_log` VALUES ('270', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 04:39:49', '1');
INSERT INTO `sys_log` VALUES ('271', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 04:43:42', '1');
INSERT INTO `sys_log` VALUES ('272', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 04:54:10', '1');
INSERT INTO `sys_log` VALUES ('273', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 04:56:21', '1');
INSERT INTO `sys_log` VALUES ('274', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 04:57:51', '1');
INSERT INTO `sys_log` VALUES ('275', '1', null, 'sys_menu', '25', '添加', '', '2017-05-14 05:00:42', '1');
INSERT INTO `sys_log` VALUES ('276', '2', null, 'sys_user', '1', '登出', '', '2017-05-14 05:01:44', '1');
INSERT INTO `sys_log` VALUES ('277', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 05:27:56', '1');
INSERT INTO `sys_log` VALUES ('278', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 05:31:40', '1');
INSERT INTO `sys_log` VALUES ('279', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 05:33:34', '1');
INSERT INTO `sys_log` VALUES ('280', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 05:39:33', '1');
INSERT INTO `sys_log` VALUES ('281', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 05:46:52', '1');
INSERT INTO `sys_log` VALUES ('282', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 05:47:32', '1');
INSERT INTO `sys_log` VALUES ('283', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 06:08:53', '1');
INSERT INTO `sys_log` VALUES ('284', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 06:15:21', '1');
INSERT INTO `sys_log` VALUES ('285', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 06:16:17', '1');
INSERT INTO `sys_log` VALUES ('286', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 06:28:12', '1');
INSERT INTO `sys_log` VALUES ('287', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 06:32:06', '1');
INSERT INTO `sys_log` VALUES ('288', '2', null, 'sys_user', '1', '登出', '', '2017-05-14 06:32:32', '1');
INSERT INTO `sys_log` VALUES ('289', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 06:32:52', '1');
INSERT INTO `sys_log` VALUES ('290', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 06:38:05', '1');
INSERT INTO `sys_log` VALUES ('291', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 06:53:48', '1');
INSERT INTO `sys_log` VALUES ('292', '2', null, 'sys_user', '1', '登出', '', '2017-05-14 06:54:10', '1');
INSERT INTO `sys_log` VALUES ('293', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 06:54:43', '1');
INSERT INTO `sys_log` VALUES ('294', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 07:14:22', '1');
INSERT INTO `sys_log` VALUES ('295', '1', null, 'sys_department', '4', '删除', '', '2017-05-14 07:15:29', '1');
INSERT INTO `sys_log` VALUES ('296', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 07:15:32', '1');
INSERT INTO `sys_log` VALUES ('297', '1', null, 'sys_department', '10', '删除', '', '2017-05-14 07:15:36', '1');
INSERT INTO `sys_log` VALUES ('298', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 07:16:22', '1');
INSERT INTO `sys_log` VALUES ('299', '2', null, 'sys_user', '1', '登出', '', '2017-05-14 07:17:11', '1');
INSERT INTO `sys_log` VALUES ('300', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 07:19:18', '1');
INSERT INTO `sys_log` VALUES ('301', '2', null, 'sys_user', '1', '登出', '', '2017-05-14 07:22:11', '1');
INSERT INTO `sys_log` VALUES ('302', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 07:29:56', '1');
INSERT INTO `sys_log` VALUES ('303', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 07:30:34', '1');
INSERT INTO `sys_log` VALUES ('304', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 07:32:14', '1');
INSERT INTO `sys_log` VALUES ('305', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 07:51:40', '1');
INSERT INTO `sys_log` VALUES ('306', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 07:53:25', '1');
INSERT INTO `sys_log` VALUES ('307', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 07:54:50', '1');
INSERT INTO `sys_log` VALUES ('308', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 08:01:53', '1');
INSERT INTO `sys_log` VALUES ('309', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 08:04:32', '1');
INSERT INTO `sys_log` VALUES ('310', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 08:12:15', '1');
INSERT INTO `sys_log` VALUES ('311', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 08:12:31', '1');
INSERT INTO `sys_log` VALUES ('312', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 08:19:23', '1');
INSERT INTO `sys_log` VALUES ('313', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 08:19:50', '1');
INSERT INTO `sys_log` VALUES ('314', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 08:28:59', '1');
INSERT INTO `sys_log` VALUES ('315', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 08:39:11', '1');
INSERT INTO `sys_log` VALUES ('316', '2', null, 'sys_user', '1', '登出', '', '2017-05-14 08:41:31', '1');
INSERT INTO `sys_log` VALUES ('317', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 08:41:52', '1');
INSERT INTO `sys_log` VALUES ('318', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 08:46:25', '1');
INSERT INTO `sys_log` VALUES ('319', '2', null, 'sys_user', '1', '登出', '', '2017-05-14 08:47:37', '1');
INSERT INTO `sys_log` VALUES ('320', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 08:49:46', '1');
INSERT INTO `sys_log` VALUES ('321', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 08:51:24', '1');
INSERT INTO `sys_log` VALUES ('322', '1', null, 'sys_department', '17', '添加', '', '2017-05-14 08:52:08', '1');
INSERT INTO `sys_log` VALUES ('323', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 08:58:26', '1');
INSERT INTO `sys_log` VALUES ('324', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 08:58:46', '1');
INSERT INTO `sys_log` VALUES ('325', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 08:58:57', '1');
INSERT INTO `sys_log` VALUES ('326', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 09:08:00', '1');
INSERT INTO `sys_log` VALUES ('327', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 09:12:55', '1');
INSERT INTO `sys_log` VALUES ('328', '2', null, 'sys_user', '1', '登出', '', '2017-05-14 09:14:20', '1');
INSERT INTO `sys_log` VALUES ('329', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 09:15:43', '1');
INSERT INTO `sys_log` VALUES ('330', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 09:17:41', '1');
INSERT INTO `sys_log` VALUES ('331', '2', null, 'sys_user', '1', '登出', '', '2017-05-14 09:19:37', '1');
INSERT INTO `sys_log` VALUES ('332', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 09:22:57', '1');
INSERT INTO `sys_log` VALUES ('333', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 09:27:52', '1');
INSERT INTO `sys_log` VALUES ('334', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 09:28:34', '1');
INSERT INTO `sys_log` VALUES ('335', '2', null, 'sys_user', '1', '登出', '', '2017-05-14 09:30:23', '1');
INSERT INTO `sys_log` VALUES ('336', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 09:30:27', '1');
INSERT INTO `sys_log` VALUES ('337', '2', null, 'sys_user', '1', '登出', '', '2017-05-14 09:31:14', '1');
INSERT INTO `sys_log` VALUES ('338', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 09:38:44', '1');
INSERT INTO `sys_log` VALUES ('339', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 09:41:46', '1');
INSERT INTO `sys_log` VALUES ('340', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 09:42:36', '1');
INSERT INTO `sys_log` VALUES ('341', '2', null, 'sys_user', '1', '登出', '', '2017-05-14 09:46:09', '1');
INSERT INTO `sys_log` VALUES ('342', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 09:47:34', '1');
INSERT INTO `sys_log` VALUES ('343', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 09:47:47', '1');
INSERT INTO `sys_log` VALUES ('344', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 09:49:28', '1');
INSERT INTO `sys_log` VALUES ('345', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 09:49:31', '1');
INSERT INTO `sys_log` VALUES ('346', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 09:49:39', '1');
INSERT INTO `sys_log` VALUES ('347', '2', null, 'sys_user', '1', '登出', '', '2017-05-14 09:50:28', '1');
INSERT INTO `sys_log` VALUES ('348', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 09:53:45', '1');
INSERT INTO `sys_log` VALUES ('349', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 09:54:07', '1');
INSERT INTO `sys_log` VALUES ('350', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 09:56:31', '1');
INSERT INTO `sys_log` VALUES ('351', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 09:56:57', '1');
INSERT INTO `sys_log` VALUES ('352', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 10:03:54', '1');
INSERT INTO `sys_log` VALUES ('353', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 10:03:59', '1');
INSERT INTO `sys_log` VALUES ('354', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 10:04:14', '1');
INSERT INTO `sys_log` VALUES ('355', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 10:04:53', '1');
INSERT INTO `sys_log` VALUES ('356', '1', null, 'sys_department', '3', '更新', '', '2017-05-14 10:05:19', '1');
INSERT INTO `sys_log` VALUES ('357', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 10:12:27', '1');
INSERT INTO `sys_log` VALUES ('358', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 10:13:19', '1');
INSERT INTO `sys_log` VALUES ('359', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 10:17:28', '1');
INSERT INTO `sys_log` VALUES ('360', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 10:26:40', '1');
INSERT INTO `sys_log` VALUES ('361', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 10:29:31', '1');
INSERT INTO `sys_log` VALUES ('362', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 10:30:16', '1');
INSERT INTO `sys_log` VALUES ('363', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 10:31:51', '1');
INSERT INTO `sys_log` VALUES ('364', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 10:40:17', '1');
INSERT INTO `sys_log` VALUES ('365', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 10:44:56', '1');
INSERT INTO `sys_log` VALUES ('366', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 10:46:06', '1');
INSERT INTO `sys_log` VALUES ('367', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 10:52:51', '1');
INSERT INTO `sys_log` VALUES ('368', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 10:56:57', '1');
INSERT INTO `sys_log` VALUES ('369', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 10:58:07', '1');
INSERT INTO `sys_log` VALUES ('370', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 11:19:57', '1');
INSERT INTO `sys_log` VALUES ('371', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 11:22:50', '1');
INSERT INTO `sys_log` VALUES ('372', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 11:26:38', '1');
INSERT INTO `sys_log` VALUES ('373', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 11:28:28', '1');
INSERT INTO `sys_log` VALUES ('374', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 11:33:48', '1');
INSERT INTO `sys_log` VALUES ('375', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 11:40:32', '1');
INSERT INTO `sys_log` VALUES ('376', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 11:46:59', '1');
INSERT INTO `sys_log` VALUES ('377', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 11:52:27', '1');
INSERT INTO `sys_log` VALUES ('378', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 12:03:43', '1');
INSERT INTO `sys_log` VALUES ('379', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 12:12:42', '1');
INSERT INTO `sys_log` VALUES ('380', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 12:17:42', '1');
INSERT INTO `sys_log` VALUES ('381', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 12:18:02', '1');
INSERT INTO `sys_log` VALUES ('382', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 12:30:27', '1');
INSERT INTO `sys_log` VALUES ('383', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 12:31:08', '1');
INSERT INTO `sys_log` VALUES ('384', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 12:50:23', '1');
INSERT INTO `sys_log` VALUES ('385', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 12:51:44', '1');
INSERT INTO `sys_log` VALUES ('386', '1', null, 'sys_department', '8', '更新', '', '2017-05-14 12:52:15', '1');
INSERT INTO `sys_log` VALUES ('387', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 14:11:51', '1');
INSERT INTO `sys_log` VALUES ('388', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 15:38:15', '1');
INSERT INTO `sys_log` VALUES ('389', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 17:34:42', '1');
INSERT INTO `sys_log` VALUES ('390', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 17:46:19', '1');
INSERT INTO `sys_log` VALUES ('391', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 18:22:44', '1');
INSERT INTO `sys_log` VALUES ('392', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 18:32:30', '1');
INSERT INTO `sys_log` VALUES ('393', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 19:02:25', '1');
INSERT INTO `sys_log` VALUES ('394', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 19:35:04', '1');
INSERT INTO `sys_log` VALUES ('395', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 19:45:48', '1');
INSERT INTO `sys_log` VALUES ('396', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 19:47:21', '1');
INSERT INTO `sys_log` VALUES ('397', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 19:48:10', '1');
INSERT INTO `sys_log` VALUES ('398', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 19:51:23', '1');
INSERT INTO `sys_log` VALUES ('399', '2', null, 'sys_user', '1', '登出', '', '2017-05-14 19:53:42', '1');
INSERT INTO `sys_log` VALUES ('400', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 19:55:21', '1');
INSERT INTO `sys_log` VALUES ('401', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 19:56:47', '1');
INSERT INTO `sys_log` VALUES ('402', '2', null, 'sys_user', '1', '登出', '', '2017-05-14 19:59:23', '1');
INSERT INTO `sys_log` VALUES ('403', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 20:10:59', '1');
INSERT INTO `sys_log` VALUES ('404', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 20:15:50', '1');
INSERT INTO `sys_log` VALUES ('405', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 20:19:18', '1');
INSERT INTO `sys_log` VALUES ('406', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 20:21:14', '1');
INSERT INTO `sys_log` VALUES ('407', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 20:24:29', '1');
INSERT INTO `sys_log` VALUES ('408', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 20:34:09', '1');
INSERT INTO `sys_log` VALUES ('409', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 20:49:49', '1');
INSERT INTO `sys_log` VALUES ('410', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 20:50:29', '1');
INSERT INTO `sys_log` VALUES ('411', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 20:51:57', '1');
INSERT INTO `sys_log` VALUES ('412', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 20:53:08', '1');
INSERT INTO `sys_log` VALUES ('413', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 20:53:54', '1');
INSERT INTO `sys_log` VALUES ('414', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 20:56:18', '1');
INSERT INTO `sys_log` VALUES ('415', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 20:56:37', '1');
INSERT INTO `sys_log` VALUES ('416', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 20:58:10', '1');
INSERT INTO `sys_log` VALUES ('417', '1', null, 'sys_user_role', '7', '添加', '', '2017-05-14 20:58:25', '1');
INSERT INTO `sys_log` VALUES ('418', '1', null, 'sys_user_role', '8', '添加', '', '2017-05-14 20:58:25', '1');
INSERT INTO `sys_log` VALUES ('419', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 21:00:31', '1');
INSERT INTO `sys_log` VALUES ('420', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 21:02:46', '1');
INSERT INTO `sys_log` VALUES ('421', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 21:03:32', '1');
INSERT INTO `sys_log` VALUES ('422', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 21:04:37', '1');
INSERT INTO `sys_log` VALUES ('423', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 21:04:50', '1');
INSERT INTO `sys_log` VALUES ('424', '2', null, 'sys_user', '1', '登出', '', '2017-05-14 21:05:47', '1');
INSERT INTO `sys_log` VALUES ('425', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 21:06:12', '1');
INSERT INTO `sys_log` VALUES ('426', '2', null, 'sys_user', '1', '登出', '', '2017-05-14 21:06:32', '1');
INSERT INTO `sys_log` VALUES ('427', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 21:06:48', '1');
INSERT INTO `sys_log` VALUES ('428', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 21:07:43', '1');
INSERT INTO `sys_log` VALUES ('429', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 21:08:17', '1');
INSERT INTO `sys_log` VALUES ('430', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 21:08:39', '1');
INSERT INTO `sys_log` VALUES ('431', '1', null, 'sys_department', '18', '添加', '', '2017-05-14 21:09:41', '1');
INSERT INTO `sys_log` VALUES ('432', '1', null, 'sys_department', '19', '添加', '', '2017-05-14 21:10:01', '1');
INSERT INTO `sys_log` VALUES ('433', '1', null, 'sys_role', '4', '添加', '', '2017-05-14 21:10:17', '1');
INSERT INTO `sys_log` VALUES ('434', '1', null, 'sys_role_menu', '8', '添加', '', '2017-05-14 21:11:34', '1');
INSERT INTO `sys_log` VALUES ('435', '1', null, 'sys_role_menu', '9', '添加', '', '2017-05-14 21:11:34', '1');
INSERT INTO `sys_log` VALUES ('436', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 21:11:42', '1');
INSERT INTO `sys_log` VALUES ('437', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 21:13:39', '1');
INSERT INTO `sys_log` VALUES ('438', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 21:14:38', '1');
INSERT INTO `sys_log` VALUES ('439', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 21:15:10', '1');
INSERT INTO `sys_log` VALUES ('440', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 21:15:13', '1');
INSERT INTO `sys_log` VALUES ('441', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 21:16:09', '1');
INSERT INTO `sys_log` VALUES ('442', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 21:17:39', '1');
INSERT INTO `sys_log` VALUES ('443', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 21:21:04', '1');
INSERT INTO `sys_log` VALUES ('444', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 21:21:05', '1');
INSERT INTO `sys_log` VALUES ('445', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 21:21:19', '1');
INSERT INTO `sys_log` VALUES ('446', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 21:22:01', '1');
INSERT INTO `sys_log` VALUES ('447', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 21:22:53', '1');
INSERT INTO `sys_log` VALUES ('448', '2', null, 'sys_user', '1', '登出', '', '2017-05-14 21:24:45', '1');
INSERT INTO `sys_log` VALUES ('449', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 21:25:35', '1');
INSERT INTO `sys_log` VALUES ('450', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 21:25:44', '1');
INSERT INTO `sys_log` VALUES ('451', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 21:29:20', '1');
INSERT INTO `sys_log` VALUES ('452', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 21:31:33', '1');
INSERT INTO `sys_log` VALUES ('453', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 21:32:45', '1');
INSERT INTO `sys_log` VALUES ('454', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 21:33:22', '1');
INSERT INTO `sys_log` VALUES ('455', '2', null, 'sys_user', '1', '登出', '', '2017-05-14 21:34:52', '1');
INSERT INTO `sys_log` VALUES ('456', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 21:40:23', '1');
INSERT INTO `sys_log` VALUES ('457', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 21:42:28', '1');
INSERT INTO `sys_log` VALUES ('458', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 21:44:52', '1');
INSERT INTO `sys_log` VALUES ('459', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 21:44:53', '1');
INSERT INTO `sys_log` VALUES ('460', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 21:45:44', '1');
INSERT INTO `sys_log` VALUES ('461', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 21:54:44', '1');
INSERT INTO `sys_log` VALUES ('462', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 21:56:37', '1');
INSERT INTO `sys_log` VALUES ('463', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 21:57:03', '1');
INSERT INTO `sys_log` VALUES ('464', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 21:57:13', '1');
INSERT INTO `sys_log` VALUES ('465', '2', null, 'sys_user', '1', '登出', '', '2017-05-14 21:57:16', '1');
INSERT INTO `sys_log` VALUES ('466', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 21:58:08', '1');
INSERT INTO `sys_log` VALUES ('467', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 21:58:52', '1');
INSERT INTO `sys_log` VALUES ('468', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 21:59:10', '1');
INSERT INTO `sys_log` VALUES ('469', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 22:01:30', '1');
INSERT INTO `sys_log` VALUES ('470', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 22:05:47', '1');
INSERT INTO `sys_log` VALUES ('471', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 22:06:23', '1');
INSERT INTO `sys_log` VALUES ('472', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 22:06:24', '1');
INSERT INTO `sys_log` VALUES ('473', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 22:07:04', '1');
INSERT INTO `sys_log` VALUES ('474', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 22:07:23', '1');
INSERT INTO `sys_log` VALUES ('475', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 22:08:19', '1');
INSERT INTO `sys_log` VALUES ('476', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 22:11:30', '1');
INSERT INTO `sys_log` VALUES ('477', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 22:12:14', '1');
INSERT INTO `sys_log` VALUES ('478', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 22:12:51', '1');
INSERT INTO `sys_log` VALUES ('479', '1', null, 'sys_role', '4', '删除', '', '2017-05-14 22:13:28', '1');
INSERT INTO `sys_log` VALUES ('480', '2', null, 'sys_user', '1', '登出', '', '2017-05-14 22:22:27', '1');
INSERT INTO `sys_log` VALUES ('481', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 22:22:47', '1');
INSERT INTO `sys_log` VALUES ('482', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 22:24:12', '1');
INSERT INTO `sys_log` VALUES ('483', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 22:25:46', '1');
INSERT INTO `sys_log` VALUES ('484', '1', null, 'sys_department', '20', '添加', '', '2017-05-14 22:28:24', '1');
INSERT INTO `sys_log` VALUES ('485', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 22:28:34', '1');
INSERT INTO `sys_log` VALUES ('486', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 22:37:46', '1');
INSERT INTO `sys_log` VALUES ('487', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 22:38:29', '1');
INSERT INTO `sys_log` VALUES ('488', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 22:41:51', '1');
INSERT INTO `sys_log` VALUES ('489', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 22:42:41', '1');
INSERT INTO `sys_log` VALUES ('490', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 22:42:55', '1');
INSERT INTO `sys_log` VALUES ('491', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 22:44:30', '1');
INSERT INTO `sys_log` VALUES ('492', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 22:47:14', '1');
INSERT INTO `sys_log` VALUES ('493', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 22:47:50', '1');
INSERT INTO `sys_log` VALUES ('494', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 22:52:26', '1');
INSERT INTO `sys_log` VALUES ('495', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 22:53:43', '1');
INSERT INTO `sys_log` VALUES ('496', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 22:54:37', '1');
INSERT INTO `sys_log` VALUES ('497', '2', null, 'sys_user', '1', '登出', '', '2017-05-14 22:55:38', '1');
INSERT INTO `sys_log` VALUES ('498', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 22:56:17', '1');
INSERT INTO `sys_log` VALUES ('499', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 23:06:00', '1');
INSERT INTO `sys_log` VALUES ('500', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 23:06:05', '1');
INSERT INTO `sys_log` VALUES ('501', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 23:06:20', '1');
INSERT INTO `sys_log` VALUES ('502', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 23:08:26', '1');
INSERT INTO `sys_log` VALUES ('503', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 23:09:01', '1');
INSERT INTO `sys_log` VALUES ('504', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 23:12:53', '1');
INSERT INTO `sys_log` VALUES ('505', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 23:13:53', '1');
INSERT INTO `sys_log` VALUES ('506', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 23:14:06', '1');
INSERT INTO `sys_log` VALUES ('507', '2', null, 'sys_user', '1', '登出', '', '2017-05-14 23:15:00', '1');
INSERT INTO `sys_log` VALUES ('508', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 23:18:13', '1');
INSERT INTO `sys_log` VALUES ('509', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 23:18:28', '1');
INSERT INTO `sys_log` VALUES ('510', '2', null, 'sys_user', '1', '登出', '', '2017-05-14 23:20:58', '1');
INSERT INTO `sys_log` VALUES ('511', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 23:22:01', '1');
INSERT INTO `sys_log` VALUES ('512', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 23:22:27', '1');
INSERT INTO `sys_log` VALUES ('513', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 23:22:33', '1');
INSERT INTO `sys_log` VALUES ('514', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 23:23:53', '1');
INSERT INTO `sys_log` VALUES ('515', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 23:25:30', '1');
INSERT INTO `sys_log` VALUES ('516', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 23:25:51', '1');
INSERT INTO `sys_log` VALUES ('517', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 23:28:32', '1');
INSERT INTO `sys_log` VALUES ('518', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 23:29:03', '1');
INSERT INTO `sys_log` VALUES ('519', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 23:29:24', '1');
INSERT INTO `sys_log` VALUES ('520', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 23:30:22', '1');
INSERT INTO `sys_log` VALUES ('521', '2', null, 'sys_user', '1', '登出', '', '2017-05-14 23:33:45', '1');
INSERT INTO `sys_log` VALUES ('522', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 23:33:52', '1');
INSERT INTO `sys_log` VALUES ('523', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 23:34:00', '1');
INSERT INTO `sys_log` VALUES ('524', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 23:34:42', '1');
INSERT INTO `sys_log` VALUES ('525', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 23:35:20', '1');
INSERT INTO `sys_log` VALUES ('526', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 23:36:15', '1');
INSERT INTO `sys_log` VALUES ('527', '2', null, 'sys_user', '1', '登出', '', '2017-05-14 23:36:53', '1');
INSERT INTO `sys_log` VALUES ('528', '1', null, 'sys_department', '11', '删除', '', '2017-05-14 23:37:09', '1');
INSERT INTO `sys_log` VALUES ('529', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 23:37:12', '1');
INSERT INTO `sys_log` VALUES ('530', '1', null, 'sys_department', '17', '删除', '', '2017-05-14 23:37:13', '1');
INSERT INTO `sys_log` VALUES ('531', '2', null, 'sys_user', '1', '登出', '', '2017-05-14 23:37:28', '1');
INSERT INTO `sys_log` VALUES ('532', '2', null, 'sys_user', '1', '登出', '', '2017-05-14 23:37:49', '1');
INSERT INTO `sys_log` VALUES ('533', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 23:46:43', '1');
INSERT INTO `sys_log` VALUES ('534', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 23:46:58', '1');
INSERT INTO `sys_log` VALUES ('535', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 23:51:20', '1');
INSERT INTO `sys_log` VALUES ('536', '2', null, 'sys_user', '1', '登入', '', '2017-05-14 23:52:46', '1');
INSERT INTO `sys_log` VALUES ('537', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 00:06:50', '1');
INSERT INTO `sys_log` VALUES ('538', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 00:11:42', '1');
INSERT INTO `sys_log` VALUES ('539', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 00:17:34', '1');
INSERT INTO `sys_log` VALUES ('540', '2', null, 'sys_user', '1', '登出', '', '2017-05-15 00:18:59', '1');
INSERT INTO `sys_log` VALUES ('541', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 00:19:21', '1');
INSERT INTO `sys_log` VALUES ('542', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 00:47:12', '1');
INSERT INTO `sys_log` VALUES ('543', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 00:47:50', '1');
INSERT INTO `sys_log` VALUES ('544', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 01:03:01', '1');
INSERT INTO `sys_log` VALUES ('545', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 01:04:18', '1');
INSERT INTO `sys_log` VALUES ('546', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 01:17:59', '1');
INSERT INTO `sys_log` VALUES ('547', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 01:30:07', '1');
INSERT INTO `sys_log` VALUES ('548', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 01:32:11', '1');
INSERT INTO `sys_log` VALUES ('549', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 01:33:27', '1');
INSERT INTO `sys_log` VALUES ('550', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 01:36:49', '1');
INSERT INTO `sys_log` VALUES ('551', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 01:37:50', '1');
INSERT INTO `sys_log` VALUES ('552', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 01:38:50', '1');
INSERT INTO `sys_log` VALUES ('553', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 01:39:37', '1');
INSERT INTO `sys_log` VALUES ('554', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 01:40:06', '1');
INSERT INTO `sys_log` VALUES ('555', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 01:45:12', '1');
INSERT INTO `sys_log` VALUES ('556', '1', null, 'sys_menu', '21', '更新', '', '2017-05-15 01:47:39', '1');
INSERT INTO `sys_log` VALUES ('557', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 01:51:13', '1');
INSERT INTO `sys_log` VALUES ('558', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 01:55:55', '1');
INSERT INTO `sys_log` VALUES ('559', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 01:59:02', '1');
INSERT INTO `sys_log` VALUES ('560', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 02:01:17', '1');
INSERT INTO `sys_log` VALUES ('561', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 02:07:58', '1');
INSERT INTO `sys_log` VALUES ('562', '1', null, 'sys_role_menu', '10', '添加', '', '2017-05-15 02:10:46', '1');
INSERT INTO `sys_log` VALUES ('563', '1', null, 'sys_role_menu', '11', '添加', '', '2017-05-15 02:10:46', '1');
INSERT INTO `sys_log` VALUES ('564', '1', null, 'sys_role_menu', '12', '添加', '', '2017-05-15 02:10:46', '1');
INSERT INTO `sys_log` VALUES ('565', '1', null, 'sys_role_menu', '13', '添加', '', '2017-05-15 02:10:46', '1');
INSERT INTO `sys_log` VALUES ('566', '2', null, 'sys_user', '1', '登出', '', '2017-05-15 02:11:46', '1');
INSERT INTO `sys_log` VALUES ('567', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 02:13:47', '1');
INSERT INTO `sys_log` VALUES ('568', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 02:15:46', '1');
INSERT INTO `sys_log` VALUES ('569', '2', null, 'sys_user', '1', '登出', '', '2017-05-15 02:24:03', '1');
INSERT INTO `sys_log` VALUES ('570', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 02:25:01', '1');
INSERT INTO `sys_log` VALUES ('571', '2', null, 'sys_user', '1', '登出', '', '2017-05-15 02:32:17', '1');
INSERT INTO `sys_log` VALUES ('572', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 02:41:51', '1');
INSERT INTO `sys_log` VALUES ('573', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 02:49:13', '1');
INSERT INTO `sys_log` VALUES ('574', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 03:01:00', '1');
INSERT INTO `sys_log` VALUES ('575', '2', null, 'sys_user', '1', '登出', '', '2017-05-15 03:02:07', '1');
INSERT INTO `sys_log` VALUES ('576', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 03:08:52', '1');
INSERT INTO `sys_log` VALUES ('577', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 03:13:28', '1');
INSERT INTO `sys_log` VALUES ('578', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 03:14:17', '1');
INSERT INTO `sys_log` VALUES ('579', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 03:19:25', '1');
INSERT INTO `sys_log` VALUES ('580', '1', null, 'sys_user_role', '9', '添加', '', '2017-05-15 03:20:52', '1');
INSERT INTO `sys_log` VALUES ('581', '2', null, 'sys_user', '1', '登出', '', '2017-05-15 03:21:07', '1');
INSERT INTO `sys_log` VALUES ('582', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 03:22:46', '1');
INSERT INTO `sys_log` VALUES ('583', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 03:29:08', '1');
INSERT INTO `sys_log` VALUES ('584', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 03:30:38', '1');
INSERT INTO `sys_log` VALUES ('585', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 03:31:05', '1');
INSERT INTO `sys_log` VALUES ('586', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 03:35:24', '1');
INSERT INTO `sys_log` VALUES ('587', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 03:36:18', '1');
INSERT INTO `sys_log` VALUES ('588', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 03:43:22', '1');
INSERT INTO `sys_log` VALUES ('589', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 03:53:53', '1');
INSERT INTO `sys_log` VALUES ('590', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 04:04:06', '1');
INSERT INTO `sys_log` VALUES ('591', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 04:04:08', '1');
INSERT INTO `sys_log` VALUES ('592', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 04:04:13', '1');
INSERT INTO `sys_log` VALUES ('593', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 04:07:52', '1');
INSERT INTO `sys_log` VALUES ('594', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 04:12:48', '1');
INSERT INTO `sys_log` VALUES ('595', '1', null, 'sys_department', '16', '删除', '', '2017-05-15 04:14:36', '1');
INSERT INTO `sys_log` VALUES ('596', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 04:30:18', '1');
INSERT INTO `sys_log` VALUES ('597', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 04:36:14', '1');
INSERT INTO `sys_log` VALUES ('598', '2', null, 'sys_user', '1', '登出', '', '2017-05-15 04:37:18', '1');
INSERT INTO `sys_log` VALUES ('599', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 04:45:11', '1');
INSERT INTO `sys_log` VALUES ('600', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 04:50:55', '1');
INSERT INTO `sys_log` VALUES ('601', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 04:51:13', '1');
INSERT INTO `sys_log` VALUES ('602', '1', null, 'sys_role', '5', '添加', '', '2017-05-15 04:51:34', '1');
INSERT INTO `sys_log` VALUES ('603', '1', null, 'sys_role_menu', '14', '添加', '', '2017-05-15 04:51:50', '1');
INSERT INTO `sys_log` VALUES ('604', '1', null, 'sys_role_menu', '15', '添加', '', '2017-05-15 04:51:50', '1');
INSERT INTO `sys_log` VALUES ('605', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 04:56:56', '1');
INSERT INTO `sys_log` VALUES ('606', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 05:00:50', '1');
INSERT INTO `sys_log` VALUES ('607', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 05:01:41', '1');
INSERT INTO `sys_log` VALUES ('608', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 17:06:56', '1');
INSERT INTO `sys_log` VALUES ('609', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 05:10:01', '1');
INSERT INTO `sys_log` VALUES ('610', '1', null, 'sys_department', '20', '删除', '', '2017-05-15 17:19:38', '1');
INSERT INTO `sys_log` VALUES ('611', '1', null, 'sys_department', '20', '删除', '', '2017-05-15 17:20:11', '1');
INSERT INTO `sys_log` VALUES ('612', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 05:21:10', '1');
INSERT INTO `sys_log` VALUES ('613', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 05:22:05', '1');
INSERT INTO `sys_log` VALUES ('614', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 05:26:57', '1');
INSERT INTO `sys_log` VALUES ('615', '1', null, 'sys_department', '13', '删除', '', '2017-05-15 17:27:20', '1');
INSERT INTO `sys_log` VALUES ('616', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 05:30:28', '1');
INSERT INTO `sys_log` VALUES ('617', '2', null, 'sys_user', '1', '登出', '', '2017-05-15 05:32:12', '1');
INSERT INTO `sys_log` VALUES ('618', '1', null, 'sys_department', '21', '添加', '', '2017-05-15 17:32:36', '1');
INSERT INTO `sys_log` VALUES ('619', '1', null, 'sys_department', '21', '删除', '', '2017-05-15 17:32:44', '1');
INSERT INTO `sys_log` VALUES ('620', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 05:33:52', '1');
INSERT INTO `sys_log` VALUES ('621', '1', null, 'sys_department', '19', '删除', '', '2017-05-15 17:35:36', '1');
INSERT INTO `sys_log` VALUES ('622', '1', null, 'sys_department', '22', '添加', '', '2017-05-15 17:35:53', '1');
INSERT INTO `sys_log` VALUES ('623', '2', null, 'sys_user', '1', '登出', '', '2017-05-15 05:43:42', '1');
INSERT INTO `sys_log` VALUES ('624', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 05:43:54', '1');
INSERT INTO `sys_log` VALUES ('625', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 05:44:14', '1');
INSERT INTO `sys_log` VALUES ('626', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 05:44:35', '1');
INSERT INTO `sys_log` VALUES ('627', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 05:45:05', '1');
INSERT INTO `sys_log` VALUES ('628', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 05:47:21', '1');
INSERT INTO `sys_log` VALUES ('629', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 05:54:10', '1');
INSERT INTO `sys_log` VALUES ('630', '1', null, 'sys_role_menu', '1', '添加', '', '2017-05-15 17:54:43', '1');
INSERT INTO `sys_log` VALUES ('631', '1', null, 'sys_role_menu', '2', '添加', '', '2017-05-15 17:54:43', '1');
INSERT INTO `sys_log` VALUES ('632', '1', null, 'sys_role_menu', '3', '添加', '', '2017-05-15 18:27:37', '1');
INSERT INTO `sys_log` VALUES ('633', '1', null, 'sys_role_menu', '4', '添加', '', '2017-05-15 18:27:37', '1');
INSERT INTO `sys_log` VALUES ('634', '1', null, 'sys_role_menu', '5', '添加', '', '2017-05-15 18:27:37', '1');
INSERT INTO `sys_log` VALUES ('635', '1', null, 'sys_role_menu', '6', '添加', '', '2017-05-15 18:27:56', '1');
INSERT INTO `sys_log` VALUES ('636', '1', null, 'sys_role_menu', '7', '添加', '', '2017-05-15 18:27:57', '1');
INSERT INTO `sys_log` VALUES ('637', '1', null, 'sys_role_menu', '8', '添加', '', '2017-05-15 18:27:57', '1');
INSERT INTO `sys_log` VALUES ('638', '1', null, 'sys_role_menu', '9', '添加', '', '2017-05-15 18:27:57', '1');
INSERT INTO `sys_log` VALUES ('639', '1', null, 'sys_role_menu', '10', '添加', '', '2017-05-15 18:28:09', '1');
INSERT INTO `sys_log` VALUES ('640', '1', null, 'sys_role_menu', '11', '添加', '', '2017-05-15 18:28:09', '1');
INSERT INTO `sys_log` VALUES ('641', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 06:28:27', '1');
INSERT INTO `sys_log` VALUES ('642', '1', null, 'sys_user_role', '10', '添加', '', '2017-05-15 18:28:57', '1');
INSERT INTO `sys_log` VALUES ('643', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 06:33:00', '1');
INSERT INTO `sys_log` VALUES ('644', '1', null, 'sys_user_role', '11', '添加', '', '2017-05-15 18:34:00', '1');
INSERT INTO `sys_log` VALUES ('645', '1', null, 'sys_user_role', '12', '添加', '', '2017-05-15 18:34:00', '1');
INSERT INTO `sys_log` VALUES ('646', '1', null, 'sys_user_role', '13', '添加', '', '2017-05-15 18:34:29', '1');
INSERT INTO `sys_log` VALUES ('647', '1', null, 'sys_user_role', '14', '添加', '', '2017-05-15 18:34:30', '1');
INSERT INTO `sys_log` VALUES ('648', '1', null, 'sys_user_role', '15', '添加', '', '2017-05-15 18:34:30', '1');
INSERT INTO `sys_log` VALUES ('649', '1', null, 'sys_user_role', '16', '添加', '', '2017-05-15 18:34:31', '1');
INSERT INTO `sys_log` VALUES ('650', '1', null, 'sys_user_role', '17', '添加', '', '2017-05-15 18:34:40', '1');
INSERT INTO `sys_log` VALUES ('651', '1', null, 'sys_user_role', '18', '添加', '', '2017-05-15 18:34:40', '1');
INSERT INTO `sys_log` VALUES ('652', '1', null, 'sys_user_role', '19', '添加', '', '2017-05-15 18:34:40', '1');
INSERT INTO `sys_log` VALUES ('653', '1', null, 'sys_user_role', '20', '添加', '', '2017-05-15 18:34:41', '1');
INSERT INTO `sys_log` VALUES ('654', '2', null, 'sys_user', '1', '登出', '', '2017-05-15 18:42:56', '1');
INSERT INTO `sys_log` VALUES ('655', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 18:43:11', '1');
INSERT INTO `sys_log` VALUES ('656', '1', null, 'sys_role_menu', '12', '添加', '', '2017-05-15 18:44:50', '1');
INSERT INTO `sys_log` VALUES ('657', '1', null, 'sys_role_menu', '13', '添加', '', '2017-05-15 18:44:51', '1');
INSERT INTO `sys_log` VALUES ('658', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 06:46:47', '1');
INSERT INTO `sys_log` VALUES ('659', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 06:51:19', '1');
INSERT INTO `sys_log` VALUES ('660', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 06:53:44', '1');
INSERT INTO `sys_log` VALUES ('661', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 07:04:20', '1');
INSERT INTO `sys_log` VALUES ('662', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 07:05:34', '1');
INSERT INTO `sys_log` VALUES ('663', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 07:14:36', '1');
INSERT INTO `sys_log` VALUES ('664', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 07:32:10', '1');
INSERT INTO `sys_log` VALUES ('665', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 07:46:34', '1');
INSERT INTO `sys_log` VALUES ('666', '1', null, 'sys_role', '1', '删除', '', '2017-05-15 07:47:06', '1');
INSERT INTO `sys_log` VALUES ('667', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 20:07:09', '1');
INSERT INTO `sys_log` VALUES ('668', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 08:22:37', '1');
INSERT INTO `sys_log` VALUES ('669', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 08:39:54', '1');
INSERT INTO `sys_log` VALUES ('670', '2', null, 'sys_user', '1', '登出', '', '2017-05-15 08:40:48', '1');
INSERT INTO `sys_log` VALUES ('671', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 08:45:19', '1');
INSERT INTO `sys_log` VALUES ('672', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 08:45:50', '1');
INSERT INTO `sys_log` VALUES ('673', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 08:46:09', '1');
INSERT INTO `sys_log` VALUES ('674', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 09:01:47', '1');
INSERT INTO `sys_log` VALUES ('675', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 09:16:28', '1');
INSERT INTO `sys_log` VALUES ('676', '1', null, 'sys_department', '23', '添加', '', '2017-05-15 09:17:16', '1');
INSERT INTO `sys_log` VALUES ('677', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 09:22:11', '1');
INSERT INTO `sys_log` VALUES ('678', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 09:22:28', '1');
INSERT INTO `sys_log` VALUES ('679', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 09:58:44', '1');
INSERT INTO `sys_log` VALUES ('680', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 10:13:29', '1');
INSERT INTO `sys_log` VALUES ('681', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 10:30:06', '1');
INSERT INTO `sys_log` VALUES ('682', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 10:35:10', '1');
INSERT INTO `sys_log` VALUES ('683', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 10:57:52', '1');
INSERT INTO `sys_log` VALUES ('684', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 11:00:34', '1');
INSERT INTO `sys_log` VALUES ('685', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 11:06:32', '1');
INSERT INTO `sys_log` VALUES ('686', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 11:29:09', '1');
INSERT INTO `sys_log` VALUES ('687', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 11:47:56', '1');
INSERT INTO `sys_log` VALUES ('688', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 11:50:06', '1');
INSERT INTO `sys_log` VALUES ('689', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 12:00:08', '1');
INSERT INTO `sys_log` VALUES ('690', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 12:07:34', '1');
INSERT INTO `sys_log` VALUES ('691', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 12:22:16', '1');
INSERT INTO `sys_log` VALUES ('692', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 12:30:23', '1');
INSERT INTO `sys_log` VALUES ('693', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 13:20:36', '1');
INSERT INTO `sys_log` VALUES ('694', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 18:49:15', '1');
INSERT INTO `sys_log` VALUES ('695', '2', null, 'sys_user', '1', '登出', '', '2017-05-15 18:50:50', '1');
INSERT INTO `sys_log` VALUES ('696', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 19:38:20', '1');
INSERT INTO `sys_log` VALUES ('697', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 20:11:42', '1');
INSERT INTO `sys_log` VALUES ('698', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 20:28:17', '1');
INSERT INTO `sys_log` VALUES ('699', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 20:28:35', '1');
INSERT INTO `sys_log` VALUES ('700', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 20:33:07', '1');
INSERT INTO `sys_log` VALUES ('701', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 20:40:57', '1');
INSERT INTO `sys_log` VALUES ('702', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 20:46:29', '1');
INSERT INTO `sys_log` VALUES ('703', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 20:47:39', '1');
INSERT INTO `sys_log` VALUES ('704', '1', null, 'sys_department', '24', '添加', '', '2017-05-15 20:49:34', '1');
INSERT INTO `sys_log` VALUES ('705', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 20:49:45', '1');
INSERT INTO `sys_log` VALUES ('706', '1', null, 'sys_department', '25', '添加', '', '2017-05-15 20:50:33', '1');
INSERT INTO `sys_log` VALUES ('707', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 21:11:58', '1');
INSERT INTO `sys_log` VALUES ('708', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 21:19:11', '1');
INSERT INTO `sys_log` VALUES ('709', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 21:20:21', '1');
INSERT INTO `sys_log` VALUES ('710', '1', null, 'sys_department', '26', '添加', '', '2017-05-15 21:20:46', '1');
INSERT INTO `sys_log` VALUES ('711', '1', null, 'sys_department', '27', '添加', '', '2017-05-15 21:21:23', '1');
INSERT INTO `sys_log` VALUES ('712', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 21:22:43', '1');
INSERT INTO `sys_log` VALUES ('713', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 21:23:29', '1');
INSERT INTO `sys_log` VALUES ('714', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 21:26:52', '1');
INSERT INTO `sys_log` VALUES ('715', '2', null, 'sys_user', '1', '登出', '', '2017-05-15 21:28:08', '1');
INSERT INTO `sys_log` VALUES ('716', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 21:35:29', '1');
INSERT INTO `sys_log` VALUES ('717', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 21:37:43', '1');
INSERT INTO `sys_log` VALUES ('718', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 21:38:54', '1');
INSERT INTO `sys_log` VALUES ('719', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 21:40:31', '1');
INSERT INTO `sys_log` VALUES ('720', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 21:45:40', '1');
INSERT INTO `sys_log` VALUES ('721', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 21:46:41', '1');
INSERT INTO `sys_log` VALUES ('722', '2', null, 'sys_user', '1', '登出', '', '2017-05-15 21:47:59', '1');
INSERT INTO `sys_log` VALUES ('723', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 21:48:03', '1');
INSERT INTO `sys_log` VALUES ('724', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 21:50:24', '1');
INSERT INTO `sys_log` VALUES ('725', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 21:54:40', '1');
INSERT INTO `sys_log` VALUES ('726', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 21:58:23', '1');
INSERT INTO `sys_log` VALUES ('727', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 22:03:03', '1');
INSERT INTO `sys_log` VALUES ('728', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 22:20:10', '1');
INSERT INTO `sys_log` VALUES ('729', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 22:27:54', '1');
INSERT INTO `sys_log` VALUES ('730', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 22:33:31', '1');
INSERT INTO `sys_log` VALUES ('731', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 22:37:45', '1');
INSERT INTO `sys_log` VALUES ('732', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 23:20:21', '1');
INSERT INTO `sys_log` VALUES ('733', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 23:24:01', '1');
INSERT INTO `sys_log` VALUES ('734', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 23:24:55', '1');
INSERT INTO `sys_log` VALUES ('735', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 23:28:05', '1');
INSERT INTO `sys_log` VALUES ('736', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 23:51:08', '1');
INSERT INTO `sys_log` VALUES ('737', '2', null, 'sys_user', '1', '登入', '', '2017-05-15 23:54:43', '1');
INSERT INTO `sys_log` VALUES ('738', '1', null, 'sys_department', '22', '更新', '', '2017-05-15 23:55:13', '1');
INSERT INTO `sys_log` VALUES ('739', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 00:39:08', '1');
INSERT INTO `sys_log` VALUES ('740', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 01:19:25', '1');
INSERT INTO `sys_log` VALUES ('741', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 01:25:00', '1');
INSERT INTO `sys_log` VALUES ('742', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 01:33:43', '1');
INSERT INTO `sys_log` VALUES ('743', '1', null, 'sys_user_role', '21', '添加', '', '2017-05-16 01:35:11', '1');
INSERT INTO `sys_log` VALUES ('744', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 01:38:37', '1');
INSERT INTO `sys_log` VALUES ('745', '2', null, 'sys_user', '1', '登出', '', '2017-05-16 01:40:26', '1');
INSERT INTO `sys_log` VALUES ('746', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 01:42:42', '1');
INSERT INTO `sys_log` VALUES ('747', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 01:44:44', '1');
INSERT INTO `sys_log` VALUES ('748', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 02:32:31', '1');
INSERT INTO `sys_log` VALUES ('749', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 02:34:57', '1');
INSERT INTO `sys_log` VALUES ('750', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 02:39:34', '1');
INSERT INTO `sys_log` VALUES ('751', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 02:39:51', '1');
INSERT INTO `sys_log` VALUES ('752', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 02:45:32', '1');
INSERT INTO `sys_log` VALUES ('753', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 02:51:52', '1');
INSERT INTO `sys_log` VALUES ('754', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 02:54:21', '1');
INSERT INTO `sys_log` VALUES ('755', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 02:56:22', '1');
INSERT INTO `sys_log` VALUES ('756', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 02:59:47', '1');
INSERT INTO `sys_log` VALUES ('757', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 03:10:03', '1');
INSERT INTO `sys_log` VALUES ('758', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 03:10:50', '1');
INSERT INTO `sys_log` VALUES ('759', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 03:11:16', '1');
INSERT INTO `sys_log` VALUES ('760', '1', null, 'sys_menu', '25', '更新', '', '2017-05-16 03:14:08', '1');
INSERT INTO `sys_log` VALUES ('761', '2', null, 'sys_user', '1', '登出', '', '2017-05-16 03:14:25', '1');
INSERT INTO `sys_log` VALUES ('762', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 03:18:25', '1');
INSERT INTO `sys_log` VALUES ('763', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 03:22:41', '1');
INSERT INTO `sys_log` VALUES ('764', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 03:22:45', '1');
INSERT INTO `sys_log` VALUES ('765', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 03:24:21', '1');
INSERT INTO `sys_log` VALUES ('766', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 03:30:32', '1');
INSERT INTO `sys_log` VALUES ('767', '1', null, 'sys_department', '15', '更新', '', '2017-05-16 03:31:42', '1');
INSERT INTO `sys_log` VALUES ('768', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 03:37:20', '1');
INSERT INTO `sys_log` VALUES ('769', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 03:39:11', '1');
INSERT INTO `sys_log` VALUES ('770', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 03:40:15', '1');
INSERT INTO `sys_log` VALUES ('771', '1', null, 'sys_menu', '26', '添加', '', '2017-05-16 03:45:18', '0');
INSERT INTO `sys_log` VALUES ('772', '1', null, 'sys_menu', '27', '添加', '', '2017-05-16 03:47:11', '0');
INSERT INTO `sys_log` VALUES ('773', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 03:52:14', '1');
INSERT INTO `sys_log` VALUES ('774', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 03:52:31', '1');
INSERT INTO `sys_log` VALUES ('775', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 03:53:06', '1');
INSERT INTO `sys_log` VALUES ('776', '1', null, 'sys_department', '22', '更新', '', '2017-05-16 03:53:15', '1');
INSERT INTO `sys_log` VALUES ('777', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 04:04:23', '1');
INSERT INTO `sys_log` VALUES ('778', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 04:10:37', '1');
INSERT INTO `sys_log` VALUES ('779', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 04:12:53', '1');
INSERT INTO `sys_log` VALUES ('780', '1', null, 'sys_user_role', '22', '添加', '', '2017-05-16 04:17:44', '1');
INSERT INTO `sys_log` VALUES ('781', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 04:18:19', '1');
INSERT INTO `sys_log` VALUES ('782', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 04:44:02', '1');
INSERT INTO `sys_log` VALUES ('783', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 04:53:57', '1');
INSERT INTO `sys_log` VALUES ('784', '2', null, 'sys_user', '1', '登出', '', '2017-05-16 04:57:09', '1');
INSERT INTO `sys_log` VALUES ('785', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 05:07:33', '1');
INSERT INTO `sys_log` VALUES ('786', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 05:14:42', '1');
INSERT INTO `sys_log` VALUES ('787', '1', null, 'sys_department', '28', '添加', '', '2017-05-16 05:15:17', '1');
INSERT INTO `sys_log` VALUES ('788', '2', null, 'sys_user', '1', '登出', '', '2017-05-16 05:17:01', '1');
INSERT INTO `sys_log` VALUES ('789', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 05:21:49', '1');
INSERT INTO `sys_log` VALUES ('790', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 05:23:17', '1');
INSERT INTO `sys_log` VALUES ('791', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 05:24:24', '1');
INSERT INTO `sys_log` VALUES ('792', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 05:41:56', '1');
INSERT INTO `sys_log` VALUES ('793', '1', null, 'sys_department', '22', '更新', '', '2017-05-16 05:43:32', '1');
INSERT INTO `sys_log` VALUES ('794', '1', null, 'sys_department', '22', '删除', '', '2017-05-16 05:43:38', '1');
INSERT INTO `sys_log` VALUES ('795', '1', null, 'sys_department', '29', '添加', '', '2017-05-16 05:43:53', '1');
INSERT INTO `sys_log` VALUES ('796', '1', null, 'sys_department', '29', '更新', '', '2017-05-16 05:44:07', '1');
INSERT INTO `sys_log` VALUES ('797', '1', null, 'sys_department', '30', '添加', '', '2017-05-16 05:44:24', '1');
INSERT INTO `sys_log` VALUES ('798', '1', null, 'sys_department', '31', '添加', '', '2017-05-16 05:44:39', '1');
INSERT INTO `sys_log` VALUES ('799', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 05:45:23', '1');
INSERT INTO `sys_log` VALUES ('800', '1', null, 'sys_user_role', '23', '添加', '', '2017-05-16 05:45:44', '1');
INSERT INTO `sys_log` VALUES ('801', '1', null, 'sys_user_role', '24', '添加', '', '2017-05-16 05:45:44', '1');
INSERT INTO `sys_log` VALUES ('802', '1', null, 'sys_user_role', '25', '添加', '', '2017-05-16 05:45:44', '1');
INSERT INTO `sys_log` VALUES ('803', '1', null, 'sys_role', '6', '添加', '', '2017-05-16 05:46:28', '1');
INSERT INTO `sys_log` VALUES ('804', '1', null, 'sys_role_menu', '14', '添加', '', '2017-05-16 05:46:39', '1');
INSERT INTO `sys_log` VALUES ('805', '1', null, 'sys_role_menu', '15', '添加', '', '2017-05-16 05:46:39', '1');
INSERT INTO `sys_log` VALUES ('806', '1', null, 'sys_role_menu', '16', '添加', '', '2017-05-16 05:46:39', '1');
INSERT INTO `sys_log` VALUES ('807', '1', null, 'sys_role_menu', '17', '添加', '', '2017-05-16 05:46:39', '1');
INSERT INTO `sys_log` VALUES ('808', '1', null, 'sys_role_menu', '18', '添加', '', '2017-05-16 05:46:39', '1');
INSERT INTO `sys_log` VALUES ('809', '1', null, 'sys_role_menu', '19', '添加', '', '2017-05-16 05:46:39', '1');
INSERT INTO `sys_log` VALUES ('810', '1', null, 'sys_role_menu', '20', '添加', '', '2017-05-16 05:46:39', '1');
INSERT INTO `sys_log` VALUES ('811', '1', null, 'sys_role_menu', '21', '添加', '', '2017-05-16 05:46:39', '1');
INSERT INTO `sys_log` VALUES ('812', '1', null, 'sys_role_menu', '22', '添加', '', '2017-05-16 05:46:39', '1');
INSERT INTO `sys_log` VALUES ('813', '1', null, 'sys_role_menu', '23', '添加', '', '2017-05-16 05:46:39', '1');
INSERT INTO `sys_log` VALUES ('814', '1', null, 'sys_role_menu', '24', '添加', '', '2017-05-16 05:46:39', '1');
INSERT INTO `sys_log` VALUES ('815', '1', null, 'sys_role_menu', '25', '添加', '', '2017-05-16 05:46:39', '1');
INSERT INTO `sys_log` VALUES ('816', '1', null, 'sys_role_menu', '26', '添加', '', '2017-05-16 05:46:39', '1');
INSERT INTO `sys_log` VALUES ('817', '1', null, 'sys_user_role', '26', '添加', '', '2017-05-16 05:47:43', '1');
INSERT INTO `sys_log` VALUES ('818', '2', null, 'sys_user', '1', '登出', '', '2017-05-16 05:48:17', '1');
INSERT INTO `sys_log` VALUES ('819', '2', null, 'sys_user', '9', '登入', '', '2017-05-16 05:48:35', '9');
INSERT INTO `sys_log` VALUES ('820', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 06:01:39', '1');
INSERT INTO `sys_log` VALUES ('821', '2', null, 'sys_user', '1', '登出', '', '2017-05-16 06:03:24', '1');
INSERT INTO `sys_log` VALUES ('822', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 06:06:50', '1');
INSERT INTO `sys_log` VALUES ('823', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 06:36:36', '1');
INSERT INTO `sys_log` VALUES ('824', '1', null, 'sys_department', '32', '添加', '', '2017-05-16 06:39:29', '1');
INSERT INTO `sys_log` VALUES ('825', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 06:45:04', '1');
INSERT INTO `sys_log` VALUES ('826', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 06:47:26', '1');
INSERT INTO `sys_log` VALUES ('827', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 07:37:58', '1');
INSERT INTO `sys_log` VALUES ('828', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 07:46:22', '1');
INSERT INTO `sys_log` VALUES ('829', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 07:48:04', '1');
INSERT INTO `sys_log` VALUES ('830', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 09:24:25', '1');
INSERT INTO `sys_log` VALUES ('831', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 09:29:39', '1');
INSERT INTO `sys_log` VALUES ('832', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 09:43:44', '1');
INSERT INTO `sys_log` VALUES ('833', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 09:47:07', '1');
INSERT INTO `sys_log` VALUES ('834', '2', null, 'sys_user', '1', '登出', '', '2017-05-16 09:47:39', '1');
INSERT INTO `sys_log` VALUES ('835', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 09:51:01', '1');
INSERT INTO `sys_log` VALUES ('836', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 10:01:50', '1');
INSERT INTO `sys_log` VALUES ('837', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 10:46:27', '1');
INSERT INTO `sys_log` VALUES ('838', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 10:49:25', '1');
INSERT INTO `sys_log` VALUES ('839', '1', null, 'sys_menu', '24', '删除', '', '2017-05-16 10:56:46', '1');
INSERT INTO `sys_log` VALUES ('840', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 10:57:38', '1');
INSERT INTO `sys_log` VALUES ('841', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 10:58:47', '1');
INSERT INTO `sys_log` VALUES ('842', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 11:03:07', '1');
INSERT INTO `sys_log` VALUES ('843', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 11:06:59', '1');
INSERT INTO `sys_log` VALUES ('844', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 11:08:39', '1');
INSERT INTO `sys_log` VALUES ('845', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 11:10:36', '1');
INSERT INTO `sys_log` VALUES ('846', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 11:13:07', '1');
INSERT INTO `sys_log` VALUES ('847', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 11:18:29', '1');
INSERT INTO `sys_log` VALUES ('848', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 11:19:27', '1');
INSERT INTO `sys_log` VALUES ('849', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 11:20:19', '1');
INSERT INTO `sys_log` VALUES ('850', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 11:22:08', '1');
INSERT INTO `sys_log` VALUES ('851', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 11:23:59', '1');
INSERT INTO `sys_log` VALUES ('852', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 11:24:31', '1');
INSERT INTO `sys_log` VALUES ('853', '1', null, 'sys_department', '28', '更新', '', '2017-05-16 11:24:58', '1');
INSERT INTO `sys_log` VALUES ('854', '2', null, 'sys_user', '1', '登出', '', '2017-05-16 11:25:16', '1');
INSERT INTO `sys_log` VALUES ('855', '1', null, 'sys_department', '33', '添加', '', '2017-05-16 11:25:32', '1');
INSERT INTO `sys_log` VALUES ('856', '1', null, 'sys_department', '33', '删除', '', '2017-05-16 11:25:39', '1');
INSERT INTO `sys_log` VALUES ('857', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 11:29:42', '1');
INSERT INTO `sys_log` VALUES ('858', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 11:30:42', '1');
INSERT INTO `sys_log` VALUES ('859', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 11:55:01', '1');
INSERT INTO `sys_log` VALUES ('860', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 12:04:48', '1');
INSERT INTO `sys_log` VALUES ('861', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 12:39:45', '1');
INSERT INTO `sys_log` VALUES ('862', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 18:59:29', '1');
INSERT INTO `sys_log` VALUES ('863', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 19:17:20', '1');
INSERT INTO `sys_log` VALUES ('864', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 19:34:49', '1');
INSERT INTO `sys_log` VALUES ('865', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 19:51:52', '1');
INSERT INTO `sys_log` VALUES ('866', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 19:52:12', '1');
INSERT INTO `sys_log` VALUES ('867', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 19:58:50', '1');
INSERT INTO `sys_log` VALUES ('868', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 20:00:49', '1');
INSERT INTO `sys_log` VALUES ('869', '2', null, 'sys_user', '1', '登出', '', '2017-05-16 20:01:44', '1');
INSERT INTO `sys_log` VALUES ('870', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 20:01:59', '1');
INSERT INTO `sys_log` VALUES ('871', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 20:12:27', '1');
INSERT INTO `sys_log` VALUES ('872', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 20:17:13', '1');
INSERT INTO `sys_log` VALUES ('873', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 20:23:00', '1');
INSERT INTO `sys_log` VALUES ('874', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 20:30:14', '1');
INSERT INTO `sys_log` VALUES ('875', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 20:33:42', '1');
INSERT INTO `sys_log` VALUES ('876', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 20:36:10', '1');
INSERT INTO `sys_log` VALUES ('877', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 20:37:21', '1');
INSERT INTO `sys_log` VALUES ('878', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 20:40:54', '1');
INSERT INTO `sys_log` VALUES ('879', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 20:41:59', '1');
INSERT INTO `sys_log` VALUES ('880', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 20:42:33', '1');
INSERT INTO `sys_log` VALUES ('881', '2', null, 'sys_user', '1', '登出', '', '2017-05-16 20:43:33', '1');
INSERT INTO `sys_log` VALUES ('882', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 20:48:08', '1');
INSERT INTO `sys_log` VALUES ('883', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 20:51:23', '1');
INSERT INTO `sys_log` VALUES ('884', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 20:51:45', '1');
INSERT INTO `sys_log` VALUES ('885', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 20:52:33', '1');
INSERT INTO `sys_log` VALUES ('886', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 20:52:39', '1');
INSERT INTO `sys_log` VALUES ('887', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 20:54:12', '1');
INSERT INTO `sys_log` VALUES ('888', '2', null, 'sys_user', '1', '登出', '', '2017-05-16 20:54:15', '1');
INSERT INTO `sys_log` VALUES ('889', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 21:00:47', '1');
INSERT INTO `sys_log` VALUES ('890', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 21:02:24', '1');
INSERT INTO `sys_log` VALUES ('891', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 21:03:11', '1');
INSERT INTO `sys_log` VALUES ('892', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 21:03:52', '1');
INSERT INTO `sys_log` VALUES ('893', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 21:06:04', '1');
INSERT INTO `sys_log` VALUES ('894', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 21:06:55', '1');
INSERT INTO `sys_log` VALUES ('895', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 21:07:23', '1');
INSERT INTO `sys_log` VALUES ('896', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 21:09:34', '1');
INSERT INTO `sys_log` VALUES ('897', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 21:10:35', '1');
INSERT INTO `sys_log` VALUES ('898', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 21:11:13', '1');
INSERT INTO `sys_log` VALUES ('899', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 21:12:07', '1');
INSERT INTO `sys_log` VALUES ('900', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 21:12:28', '1');
INSERT INTO `sys_log` VALUES ('901', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 21:13:22', '1');
INSERT INTO `sys_log` VALUES ('902', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 21:17:42', '1');
INSERT INTO `sys_log` VALUES ('903', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 21:22:37', '1');
INSERT INTO `sys_log` VALUES ('904', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 21:22:59', '1');
INSERT INTO `sys_log` VALUES ('905', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 21:25:42', '1');
INSERT INTO `sys_log` VALUES ('906', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 21:27:51', '1');
INSERT INTO `sys_log` VALUES ('907', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 21:28:20', '1');
INSERT INTO `sys_log` VALUES ('908', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 21:29:07', '1');
INSERT INTO `sys_log` VALUES ('909', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 21:29:57', '1');
INSERT INTO `sys_log` VALUES ('910', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 21:30:18', '1');
INSERT INTO `sys_log` VALUES ('911', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 21:30:34', '1');
INSERT INTO `sys_log` VALUES ('912', '1', null, 'sys_role', '2', '更新', '', '2017-05-16 21:30:57', '1');
INSERT INTO `sys_log` VALUES ('913', '1', null, 'sys_role', '7', '添加', '', '2017-05-16 21:31:30', '1');
INSERT INTO `sys_log` VALUES ('914', '1', null, 'sys_role_menu', '27', '添加', '', '2017-05-16 21:31:50', '1');
INSERT INTO `sys_log` VALUES ('915', '1', null, 'sys_role_menu', '28', '添加', '', '2017-05-16 21:31:50', '1');
INSERT INTO `sys_log` VALUES ('916', '1', null, 'sys_role_menu', '29', '添加', '', '2017-05-16 21:31:50', '1');
INSERT INTO `sys_log` VALUES ('917', '1', null, 'sys_role_menu', '30', '添加', '', '2017-05-16 21:31:50', '1');
INSERT INTO `sys_log` VALUES ('918', '1', null, 'sys_role_menu', '31', '添加', '', '2017-05-16 21:31:50', '1');
INSERT INTO `sys_log` VALUES ('919', '1', null, 'sys_role_menu', '32', '添加', '', '2017-05-16 21:31:50', '1');
INSERT INTO `sys_log` VALUES ('920', '1', null, 'sys_role_menu', '33', '添加', '', '2017-05-16 21:31:50', '1');
INSERT INTO `sys_log` VALUES ('921', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 21:32:34', '1');
INSERT INTO `sys_log` VALUES ('922', '2', null, 'sys_user', '1', '登出', '', '2017-05-16 21:32:48', '1');
INSERT INTO `sys_log` VALUES ('923', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 21:34:05', '1');
INSERT INTO `sys_log` VALUES ('924', '1', null, 'sys_department', '28', '更新', '', '2017-05-16 21:34:48', '1');
INSERT INTO `sys_log` VALUES ('925', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 21:35:21', '1');
INSERT INTO `sys_log` VALUES ('926', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 21:35:25', '1');
INSERT INTO `sys_log` VALUES ('927', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 21:36:26', '1');
INSERT INTO `sys_log` VALUES ('928', '2', null, 'sys_user', '1', '登出', '', '2017-05-16 21:37:21', '1');
INSERT INTO `sys_log` VALUES ('929', '2', null, 'sys_user', '1', '登出', '', '2017-05-16 21:38:18', '1');
INSERT INTO `sys_log` VALUES ('930', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 21:45:52', '1');
INSERT INTO `sys_log` VALUES ('931', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 21:47:21', '1');
INSERT INTO `sys_log` VALUES ('932', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 21:49:12', '1');
INSERT INTO `sys_log` VALUES ('933', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 21:50:28', '1');
INSERT INTO `sys_log` VALUES ('934', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 21:52:31', '1');
INSERT INTO `sys_log` VALUES ('935', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 21:54:31', '1');
INSERT INTO `sys_log` VALUES ('936', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 22:02:44', '1');
INSERT INTO `sys_log` VALUES ('937', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 22:02:49', '1');
INSERT INTO `sys_log` VALUES ('938', '1', null, 'sys_department', '26', '更新', '', '2017-05-16 22:03:35', '1');
INSERT INTO `sys_log` VALUES ('939', '2', null, 'sys_user', '1', '登出', '', '2017-05-16 22:04:18', '1');
INSERT INTO `sys_log` VALUES ('940', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 22:07:46', '1');
INSERT INTO `sys_log` VALUES ('941', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 22:14:49', '1');
INSERT INTO `sys_log` VALUES ('942', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 22:14:53', '1');
INSERT INTO `sys_log` VALUES ('943', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 22:18:25', '1');
INSERT INTO `sys_log` VALUES ('944', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 22:20:18', '1');
INSERT INTO `sys_log` VALUES ('945', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 22:21:41', '1');
INSERT INTO `sys_log` VALUES ('946', '1', null, 'sys_department', '28', '删除', '', '2017-05-16 22:22:55', '1');
INSERT INTO `sys_log` VALUES ('947', '1', null, 'sys_department', '23', '删除', '', '2017-05-16 22:23:08', '1');
INSERT INTO `sys_log` VALUES ('948', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 22:24:15', '1');
INSERT INTO `sys_log` VALUES ('949', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 22:25:56', '1');
INSERT INTO `sys_log` VALUES ('950', '1', null, 'sys_menu', '27', '更新', '', '2017-05-16 22:27:38', '1');
INSERT INTO `sys_log` VALUES ('951', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 22:27:55', '1');
INSERT INTO `sys_log` VALUES ('952', '1', null, 'sys_menu', '21', '更新', '', '2017-05-16 22:27:55', '1');
INSERT INTO `sys_log` VALUES ('953', '2', null, 'sys_user', '1', '登出', '', '2017-05-16 22:28:06', '1');
INSERT INTO `sys_log` VALUES ('954', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 22:28:17', '1');
INSERT INTO `sys_log` VALUES ('955', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 22:28:59', '1');
INSERT INTO `sys_log` VALUES ('956', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 22:29:38', '1');
INSERT INTO `sys_log` VALUES ('957', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 22:31:00', '1');
INSERT INTO `sys_log` VALUES ('958', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 22:36:20', '1');
INSERT INTO `sys_log` VALUES ('959', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 22:37:34', '1');
INSERT INTO `sys_log` VALUES ('960', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 22:42:10', '1');
INSERT INTO `sys_log` VALUES ('961', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 22:44:28', '1');
INSERT INTO `sys_log` VALUES ('962', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 22:50:31', '1');
INSERT INTO `sys_log` VALUES ('963', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 22:53:38', '1');
INSERT INTO `sys_log` VALUES ('964', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 22:55:41', '1');
INSERT INTO `sys_log` VALUES ('965', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 22:59:19', '1');
INSERT INTO `sys_log` VALUES ('966', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 23:00:15', '1');
INSERT INTO `sys_log` VALUES ('967', '2', null, 'sys_user', '1', '登出', '', '2017-05-16 23:01:44', '1');
INSERT INTO `sys_log` VALUES ('968', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 23:09:16', '1');
INSERT INTO `sys_log` VALUES ('969', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 23:16:38', '1');
INSERT INTO `sys_log` VALUES ('970', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 23:23:54', '1');
INSERT INTO `sys_log` VALUES ('971', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 23:24:30', '1');
INSERT INTO `sys_log` VALUES ('972', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 23:24:50', '1');
INSERT INTO `sys_log` VALUES ('973', '1', null, 'sys_department', '30', '更新', '', '2017-05-16 23:25:45', '1');
INSERT INTO `sys_log` VALUES ('974', '1', null, 'sys_role', '8', '添加', '', '2017-05-16 23:27:15', '1');
INSERT INTO `sys_log` VALUES ('975', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 23:47:00', '1');
INSERT INTO `sys_log` VALUES ('976', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 23:49:31', '1');
INSERT INTO `sys_log` VALUES ('977', '2', null, 'sys_user', '1', '登入', '', '2017-05-16 23:52:06', '1');
INSERT INTO `sys_log` VALUES ('978', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 00:01:35', '1');
INSERT INTO `sys_log` VALUES ('979', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 00:02:11', '1');
INSERT INTO `sys_log` VALUES ('980', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 00:02:44', '1');
INSERT INTO `sys_log` VALUES ('981', '1', null, 'sys_menu', '26', '更新', '', '2017-05-17 00:04:02', '1');
INSERT INTO `sys_log` VALUES ('982', '1', null, 'sys_menu', '26', '更新', '', '2017-05-17 00:05:16', '1');
INSERT INTO `sys_log` VALUES ('983', '1', null, 'sys_menu', '26', '更新', '', '2017-05-17 00:05:43', '1');
INSERT INTO `sys_log` VALUES ('984', '1', null, 'sys_menu', '26', '更新', '', '2017-05-17 00:05:55', '1');
INSERT INTO `sys_log` VALUES ('985', '2', null, 'sys_user', '1', '登出', '', '2017-05-17 00:06:18', '1');
INSERT INTO `sys_log` VALUES ('986', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 00:08:45', '1');
INSERT INTO `sys_log` VALUES ('987', '1', null, 'sys_role', '6', '删除', '', '2017-05-17 00:09:30', '1');
INSERT INTO `sys_log` VALUES ('988', '1', null, 'sys_role', '5', '删除', '', '2017-05-17 00:09:41', '1');
INSERT INTO `sys_log` VALUES ('989', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 00:18:23', '1');
INSERT INTO `sys_log` VALUES ('990', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 00:21:57', '1');
INSERT INTO `sys_log` VALUES ('991', '2', null, 'sys_user', '1', '登出', '', '2017-05-17 00:24:27', '1');
INSERT INTO `sys_log` VALUES ('992', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 00:24:36', '1');
INSERT INTO `sys_log` VALUES ('993', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 00:30:41', '1');
INSERT INTO `sys_log` VALUES ('994', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 00:31:24', '1');
INSERT INTO `sys_log` VALUES ('995', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 00:34:38', '1');
INSERT INTO `sys_log` VALUES ('996', '2', null, 'sys_user', '1', '登出', '', '2017-05-17 00:37:00', '1');
INSERT INTO `sys_log` VALUES ('997', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 00:41:54', '1');
INSERT INTO `sys_log` VALUES ('998', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 00:48:10', '1');
INSERT INTO `sys_log` VALUES ('999', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 00:58:02', '1');
INSERT INTO `sys_log` VALUES ('1000', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 01:05:35', '1');
INSERT INTO `sys_log` VALUES ('1001', '2', null, 'sys_user', '1', '登出', '', '2017-05-17 01:07:05', '1');
INSERT INTO `sys_log` VALUES ('1002', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 01:31:46', '1');
INSERT INTO `sys_log` VALUES ('1003', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 01:37:30', '1');
INSERT INTO `sys_log` VALUES ('1004', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 01:39:34', '1');
INSERT INTO `sys_log` VALUES ('1005', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 01:44:31', '1');
INSERT INTO `sys_log` VALUES ('1006', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 01:48:34', '1');
INSERT INTO `sys_log` VALUES ('1007', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 01:56:47', '1');
INSERT INTO `sys_log` VALUES ('1008', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 01:56:49', '1');
INSERT INTO `sys_log` VALUES ('1009', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 01:57:11', '1');
INSERT INTO `sys_log` VALUES ('1010', '1', null, 'sys_department', '26', '更新', '', '2017-05-17 01:57:33', '1');
INSERT INTO `sys_log` VALUES ('1011', '1', null, 'sys_role', '3', '更新', '', '2017-05-17 01:57:51', '1');
INSERT INTO `sys_log` VALUES ('1012', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 01:57:53', '1');
INSERT INTO `sys_log` VALUES ('1013', '2', null, 'sys_user', '1', '登出', '', '2017-05-17 01:58:41', '1');
INSERT INTO `sys_log` VALUES ('1014', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 02:02:19', '1');
INSERT INTO `sys_log` VALUES ('1015', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 02:04:46', '1');
INSERT INTO `sys_log` VALUES ('1016', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 02:06:00', '1');
INSERT INTO `sys_log` VALUES ('1017', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 02:11:24', '1');
INSERT INTO `sys_log` VALUES ('1018', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 02:12:22', '1');
INSERT INTO `sys_log` VALUES ('1019', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 02:15:39', '1');
INSERT INTO `sys_log` VALUES ('1020', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 02:22:40', '1');
INSERT INTO `sys_log` VALUES ('1021', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 02:22:40', '1');
INSERT INTO `sys_log` VALUES ('1022', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 02:27:12', '1');
INSERT INTO `sys_log` VALUES ('1023', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 02:28:35', '1');
INSERT INTO `sys_log` VALUES ('1024', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 02:33:31', '1');
INSERT INTO `sys_log` VALUES ('1025', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 02:38:52', '1');
INSERT INTO `sys_log` VALUES ('1026', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 02:39:13', '1');
INSERT INTO `sys_log` VALUES ('1027', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 02:42:57', '1');
INSERT INTO `sys_log` VALUES ('1028', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 02:43:08', '1');
INSERT INTO `sys_log` VALUES ('1029', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 02:49:02', '1');
INSERT INTO `sys_log` VALUES ('1030', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 02:49:55', '1');
INSERT INTO `sys_log` VALUES ('1031', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 02:50:08', '1');
INSERT INTO `sys_log` VALUES ('1032', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 02:58:50', '1');
INSERT INTO `sys_log` VALUES ('1033', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 03:00:14', '1');
INSERT INTO `sys_log` VALUES ('1034', '1', null, 'sys_department', '34', '添加', '', '2017-05-17 03:02:44', '1');
INSERT INTO `sys_log` VALUES ('1035', '1', null, 'sys_department', '25', '更新', '', '2017-05-17 03:03:17', '1');
INSERT INTO `sys_log` VALUES ('1036', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 03:04:21', '1');
INSERT INTO `sys_log` VALUES ('1037', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 03:09:53', '1');
INSERT INTO `sys_log` VALUES ('1038', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 03:10:19', '1');
INSERT INTO `sys_log` VALUES ('1039', '2', null, 'sys_user', '1', '登出', '', '2017-05-17 03:11:09', '1');
INSERT INTO `sys_log` VALUES ('1040', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 03:18:09', '1');
INSERT INTO `sys_log` VALUES ('1041', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 03:19:39', '1');
INSERT INTO `sys_log` VALUES ('1042', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 03:20:40', '1');
INSERT INTO `sys_log` VALUES ('1043', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 03:22:02', '1');
INSERT INTO `sys_log` VALUES ('1044', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 03:26:12', '1');
INSERT INTO `sys_log` VALUES ('1045', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 03:44:24', '1');
INSERT INTO `sys_log` VALUES ('1046', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 03:46:56', '1');
INSERT INTO `sys_log` VALUES ('1047', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 03:49:25', '1');
INSERT INTO `sys_log` VALUES ('1048', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 04:02:49', '1');
INSERT INTO `sys_log` VALUES ('1049', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 04:11:23', '1');
INSERT INTO `sys_log` VALUES ('1050', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 04:13:42', '1');
INSERT INTO `sys_log` VALUES ('1051', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 04:18:00', '1');
INSERT INTO `sys_log` VALUES ('1052', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 04:25:00', '1');
INSERT INTO `sys_log` VALUES ('1053', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 04:26:55', '1');
INSERT INTO `sys_log` VALUES ('1054', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 04:33:45', '1');
INSERT INTO `sys_log` VALUES ('1055', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 04:41:29', '1');
INSERT INTO `sys_log` VALUES ('1056', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 04:41:41', '1');
INSERT INTO `sys_log` VALUES ('1057', '1', null, 'sys_user_role', '27', '添加', '', '2017-05-17 04:42:01', '1');
INSERT INTO `sys_log` VALUES ('1058', '1', null, 'sys_user_role', '28', '添加', '', '2017-05-17 04:42:01', '1');
INSERT INTO `sys_log` VALUES ('1059', '1', null, 'sys_user_role', '29', '添加', '', '2017-05-17 04:42:01', '1');
INSERT INTO `sys_log` VALUES ('1060', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 04:46:35', '1');
INSERT INTO `sys_log` VALUES ('1061', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 04:48:22', '1');
INSERT INTO `sys_log` VALUES ('1062', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 04:59:23', '1');
INSERT INTO `sys_log` VALUES ('1063', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 05:03:17', '1');
INSERT INTO `sys_log` VALUES ('1064', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 05:05:45', '1');
INSERT INTO `sys_log` VALUES ('1065', '1', null, 'sys_user_role', '30', '添加', '', '2017-05-17 05:06:34', '1');
INSERT INTO `sys_log` VALUES ('1066', '2', null, 'sys_user', '1', '登出', '', '2017-05-17 05:06:50', '1');
INSERT INTO `sys_log` VALUES ('1067', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 05:08:19', '1');
INSERT INTO `sys_log` VALUES ('1068', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 05:10:38', '1');
INSERT INTO `sys_log` VALUES ('1069', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 05:22:23', '1');
INSERT INTO `sys_log` VALUES ('1070', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 05:24:22', '1');
INSERT INTO `sys_log` VALUES ('1071', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 05:25:34', '1');
INSERT INTO `sys_log` VALUES ('1072', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 05:31:12', '1');
INSERT INTO `sys_log` VALUES ('1073', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 05:44:34', '1');
INSERT INTO `sys_log` VALUES ('1074', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 05:44:56', '1');
INSERT INTO `sys_log` VALUES ('1075', '1', null, 'sys_menu', '28', '添加', '', '2017-05-17 05:47:11', '0');
INSERT INTO `sys_log` VALUES ('1076', '1', null, 'sys_user_role', '31', '添加', '', '2017-05-17 05:47:20', '1');
INSERT INTO `sys_log` VALUES ('1077', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 05:47:38', '1');
INSERT INTO `sys_log` VALUES ('1078', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 05:54:08', '1');
INSERT INTO `sys_log` VALUES ('1079', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 06:02:27', '1');
INSERT INTO `sys_log` VALUES ('1080', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 06:22:35', '1');
INSERT INTO `sys_log` VALUES ('1081', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 06:23:40', '1');
INSERT INTO `sys_log` VALUES ('1082', '2', null, 'sys_user', '1', '登出', '', '2017-05-17 06:30:52', '1');
INSERT INTO `sys_log` VALUES ('1083', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 06:31:06', '1');
INSERT INTO `sys_log` VALUES ('1084', '2', null, 'sys_user', '1', '登出', '', '2017-05-17 06:36:02', '1');
INSERT INTO `sys_log` VALUES ('1085', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 06:48:17', '1');
INSERT INTO `sys_log` VALUES ('1086', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 07:02:13', '1');
INSERT INTO `sys_log` VALUES ('1087', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 07:37:23', '1');
INSERT INTO `sys_log` VALUES ('1088', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 07:52:44', '1');
INSERT INTO `sys_log` VALUES ('1089', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 07:59:14', '1');
INSERT INTO `sys_log` VALUES ('1090', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 08:08:08', '1');
INSERT INTO `sys_log` VALUES ('1091', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 08:15:01', '1');
INSERT INTO `sys_log` VALUES ('1092', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 08:27:23', '1');
INSERT INTO `sys_log` VALUES ('1093', '1', null, 'sys_department', '35', '添加', '', '2017-05-17 08:29:55', '1');
INSERT INTO `sys_log` VALUES ('1094', '1', null, 'sys_department', '35', '更新', '', '2017-05-17 08:30:54', '1');
INSERT INTO `sys_log` VALUES ('1095', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 08:36:31', '1');
INSERT INTO `sys_log` VALUES ('1096', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 09:06:29', '1');
INSERT INTO `sys_log` VALUES ('1097', '2', null, 'sys_user', '1', '登出', '', '2017-05-17 09:07:17', '1');
INSERT INTO `sys_log` VALUES ('1098', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 09:08:09', '1');
INSERT INTO `sys_log` VALUES ('1099', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 09:26:09', '1');
INSERT INTO `sys_log` VALUES ('1100', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 09:42:23', '1');
INSERT INTO `sys_log` VALUES ('1101', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 09:56:55', '1');
INSERT INTO `sys_log` VALUES ('1102', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 10:05:44', '1');
INSERT INTO `sys_log` VALUES ('1103', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 10:06:42', '1');
INSERT INTO `sys_log` VALUES ('1104', '1', null, 'sys_department', '35', '更新', '', '2017-05-17 10:08:14', '1');
INSERT INTO `sys_log` VALUES ('1105', '1', null, 'sys_department', '35', '更新', '', '2017-05-17 10:09:32', '1');
INSERT INTO `sys_log` VALUES ('1106', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 10:11:48', '1');
INSERT INTO `sys_log` VALUES ('1107', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 10:25:44', '1');
INSERT INTO `sys_log` VALUES ('1108', '1', null, 'sys_role', '9', '添加', '', '2017-05-17 10:26:58', '1');
INSERT INTO `sys_log` VALUES ('1109', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 10:28:25', '1');
INSERT INTO `sys_log` VALUES ('1110', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 10:28:29', '1');
INSERT INTO `sys_log` VALUES ('1111', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 10:29:39', '1');
INSERT INTO `sys_log` VALUES ('1112', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 10:30:10', '1');
INSERT INTO `sys_log` VALUES ('1113', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 10:30:25', '1');
INSERT INTO `sys_log` VALUES ('1114', '2', null, 'sys_user', '1', '登出', '', '2017-05-17 10:32:30', '1');
INSERT INTO `sys_log` VALUES ('1115', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 10:33:11', '1');
INSERT INTO `sys_log` VALUES ('1116', '1', null, 'sys_menu', '28', '更新', '', '2017-05-17 10:33:39', '1');
INSERT INTO `sys_log` VALUES ('1117', '2', null, 'sys_user', '1', '登出', '', '2017-05-17 10:33:57', '1');
INSERT INTO `sys_log` VALUES ('1118', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 10:34:16', '1');
INSERT INTO `sys_log` VALUES ('1119', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 10:45:10', '1');
INSERT INTO `sys_log` VALUES ('1120', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 10:48:45', '1');
INSERT INTO `sys_log` VALUES ('1121', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 10:49:44', '1');
INSERT INTO `sys_log` VALUES ('1122', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 11:08:32', '1');
INSERT INTO `sys_log` VALUES ('1123', '1', null, 'sys_department', '36', '添加', '', '2017-05-17 11:09:34', '1');
INSERT INTO `sys_log` VALUES ('1124', '1', null, 'sys_department', '15', '更新', '', '2017-05-17 11:09:44', '1');
INSERT INTO `sys_log` VALUES ('1125', '1', null, 'sys_department', '37', '添加', '', '2017-05-17 11:10:08', '1');
INSERT INTO `sys_log` VALUES ('1126', '1', null, 'sys_department', '38', '添加', '', '2017-05-17 11:10:33', '1');
INSERT INTO `sys_log` VALUES ('1127', '1', null, 'sys_department', '39', '添加', '', '2017-05-17 11:10:47', '1');
INSERT INTO `sys_log` VALUES ('1128', '1', null, 'sys_department', '40', '添加', '', '2017-05-17 11:11:07', '1');
INSERT INTO `sys_log` VALUES ('1129', '1', null, 'sys_department', '41', '添加', '', '2017-05-17 11:11:28', '1');
INSERT INTO `sys_log` VALUES ('1130', '1', null, 'sys_department', '42', '添加', '', '2017-05-17 11:11:44', '1');
INSERT INTO `sys_log` VALUES ('1131', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 11:27:47', '1');
INSERT INTO `sys_log` VALUES ('1132', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 11:39:28', '1');
INSERT INTO `sys_log` VALUES ('1133', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 11:51:18', '1');
INSERT INTO `sys_log` VALUES ('1134', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 11:55:48', '1');
INSERT INTO `sys_log` VALUES ('1135', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 12:17:24', '1');
INSERT INTO `sys_log` VALUES ('1136', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 17:04:49', '1');
INSERT INTO `sys_log` VALUES ('1137', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 19:23:49', '1');
INSERT INTO `sys_log` VALUES ('1138', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 19:39:22', '1');
INSERT INTO `sys_log` VALUES ('1139', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 20:23:30', '1');
INSERT INTO `sys_log` VALUES ('1140', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 20:24:34', '1');
INSERT INTO `sys_log` VALUES ('1141', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 20:27:37', '1');
INSERT INTO `sys_log` VALUES ('1142', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 20:36:39', '1');
INSERT INTO `sys_log` VALUES ('1143', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 20:38:40', '1');
INSERT INTO `sys_log` VALUES ('1144', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 20:40:10', '1');
INSERT INTO `sys_log` VALUES ('1145', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 20:40:17', '1');
INSERT INTO `sys_log` VALUES ('1146', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 20:40:55', '1');
INSERT INTO `sys_log` VALUES ('1147', '1', null, 'sys_department', '35', '更新', '', '2017-05-17 20:42:52', '1');
INSERT INTO `sys_log` VALUES ('1148', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 21:03:59', '1');
INSERT INTO `sys_log` VALUES ('1149', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 21:04:38', '1');
INSERT INTO `sys_log` VALUES ('1150', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 21:06:35', '1');
INSERT INTO `sys_log` VALUES ('1151', '2', null, 'sys_user', '1', '登出', '', '2017-05-17 21:07:30', '1');
INSERT INTO `sys_log` VALUES ('1152', '1', null, 'sys_department', '35', '更新', '', '2017-05-17 21:07:35', '1');
INSERT INTO `sys_log` VALUES ('1153', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 21:08:59', '1');
INSERT INTO `sys_log` VALUES ('1154', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 21:15:00', '1');
INSERT INTO `sys_log` VALUES ('1155', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 21:28:06', '1');
INSERT INTO `sys_log` VALUES ('1156', '2', null, 'sys_user', '1', '登出', '', '2017-05-17 21:28:35', '1');
INSERT INTO `sys_log` VALUES ('1157', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 21:37:51', '1');
INSERT INTO `sys_log` VALUES ('1158', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 21:38:13', '1');
INSERT INTO `sys_log` VALUES ('1159', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 21:39:47', '1');
INSERT INTO `sys_log` VALUES ('1160', '1', null, 'sys_dict_detail', '11', '更新', '', '2017-05-17 21:40:58', '1');
INSERT INTO `sys_log` VALUES ('1161', '1', null, 'sys_dict_detail', '108', '添加', '', '2017-05-17 21:41:11', '1');
INSERT INTO `sys_log` VALUES ('1162', '2', null, 'sys_user', '1', '登出', '', '2017-05-17 21:41:55', '1');
INSERT INTO `sys_log` VALUES ('1163', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 21:42:05', '1');
INSERT INTO `sys_log` VALUES ('1164', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 21:47:59', '1');
INSERT INTO `sys_log` VALUES ('1165', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 21:49:06', '1');
INSERT INTO `sys_log` VALUES ('1166', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 21:50:35', '1');
INSERT INTO `sys_log` VALUES ('1167', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 21:59:09', '1');
INSERT INTO `sys_log` VALUES ('1168', '1', null, 'sys_role', '9', '删除', '', '2017-05-17 21:59:14', '1');
INSERT INTO `sys_log` VALUES ('1169', '2', null, 'sys_user', '1', '登入', '', '2017-05-18 09:59:42', '1');
INSERT INTO `sys_log` VALUES ('1170', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 22:01:41', '1');
INSERT INTO `sys_log` VALUES ('1171', '2', null, 'sys_user', '1', '登出', '', '2017-05-17 22:10:35', '1');
INSERT INTO `sys_log` VALUES ('1172', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 22:10:53', '1');
INSERT INTO `sys_log` VALUES ('1173', '1', null, 'sys_menu', '28', '更新', '', '2017-05-17 22:13:58', '1');
INSERT INTO `sys_log` VALUES ('1174', '2', null, 'sys_user', '1', '登出', '', '2017-05-18 10:16:16', '1');
INSERT INTO `sys_log` VALUES ('1175', '2', null, 'sys_user', '1', '登入', '', '2017-05-18 10:16:49', '1');
INSERT INTO `sys_log` VALUES ('1176', '2', null, 'sys_user', '1', '登出', '', '2017-05-17 22:17:09', '1');
INSERT INTO `sys_log` VALUES ('1177', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 22:17:24', '1');
INSERT INTO `sys_log` VALUES ('1178', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 22:19:00', '1');
INSERT INTO `sys_log` VALUES ('1179', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 22:20:07', '1');
INSERT INTO `sys_log` VALUES ('1180', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 22:22:53', '1');
INSERT INTO `sys_log` VALUES ('1181', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 22:27:18', '1');
INSERT INTO `sys_log` VALUES ('1182', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 22:31:57', '1');
INSERT INTO `sys_log` VALUES ('1183', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 22:32:34', '1');
INSERT INTO `sys_log` VALUES ('1184', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 22:33:31', '1');
INSERT INTO `sys_log` VALUES ('1185', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 22:38:21', '1');
INSERT INTO `sys_log` VALUES ('1186', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 22:40:09', '1');
INSERT INTO `sys_log` VALUES ('1187', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 22:41:06', '1');
INSERT INTO `sys_log` VALUES ('1188', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 22:45:30', '1');
INSERT INTO `sys_log` VALUES ('1189', '1', null, 'sys_dict_detail', '108', '更新', '', '2017-05-17 22:48:05', '1');
INSERT INTO `sys_log` VALUES ('1190', '1', null, 'sys_dict_detail', '60', '更新', '', '2017-05-17 22:48:24', '1');
INSERT INTO `sys_log` VALUES ('1191', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 22:51:25', '1');
INSERT INTO `sys_log` VALUES ('1192', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 22:55:44', '1');
INSERT INTO `sys_log` VALUES ('1193', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 23:03:53', '1');
INSERT INTO `sys_log` VALUES ('1194', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 23:24:37', '1');
INSERT INTO `sys_log` VALUES ('1195', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 23:34:07', '1');
INSERT INTO `sys_log` VALUES ('1196', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 23:34:39', '1');
INSERT INTO `sys_log` VALUES ('1197', '1', null, 'sys_role_menu', '34', '添加', '', '2017-05-17 23:35:25', '1');
INSERT INTO `sys_log` VALUES ('1198', '1', null, 'sys_role_menu', '35', '添加', '', '2017-05-17 23:35:25', '1');
INSERT INTO `sys_log` VALUES ('1199', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 23:38:44', '1');
INSERT INTO `sys_log` VALUES ('1200', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 23:39:56', '1');
INSERT INTO `sys_log` VALUES ('1201', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 23:40:24', '1');
INSERT INTO `sys_log` VALUES ('1202', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 23:40:45', '1');
INSERT INTO `sys_log` VALUES ('1203', '2', null, 'sys_user', '1', '登入', '', '2017-05-17 23:54:30', '1');
INSERT INTO `sys_log` VALUES ('1204', '2', null, 'sys_user', '1', '登入', '', '2017-05-18 00:00:39', '1');
INSERT INTO `sys_log` VALUES ('1205', '2', null, 'sys_user', '1', '登入', '', '2017-05-18 00:52:46', '1');
INSERT INTO `sys_log` VALUES ('1206', '2', null, 'sys_user', '1', '登入', '', '2017-05-18 01:05:27', '1');
INSERT INTO `sys_log` VALUES ('1207', '2', null, 'sys_user', '1', '登入', '', '2017-05-18 01:25:55', '1');
INSERT INTO `sys_log` VALUES ('1208', '2', null, 'sys_user', '1', '登入', '', '2017-05-18 01:40:41', '1');
INSERT INTO `sys_log` VALUES ('1209', '2', null, 'sys_user', '1', '登入', '', '2017-05-18 01:40:50', '1');
INSERT INTO `sys_log` VALUES ('1210', '1', null, 'sys_department', '43', '添加', '', '2017-05-18 01:41:31', '1');
INSERT INTO `sys_log` VALUES ('1211', '1', null, 'sys_user_role', '32', '添加', '', '2017-05-18 01:41:46', '1');
INSERT INTO `sys_log` VALUES ('1212', '2', null, 'sys_user', '1', '登入', '', '2017-05-18 01:50:54', '1');
INSERT INTO `sys_log` VALUES ('1213', '2', null, 'sys_user', '1', '登入', '', '2017-05-18 02:14:15', '1');
INSERT INTO `sys_log` VALUES ('1214', '1', null, 'sys_role', '2', '删除', '', '2017-05-18 02:15:07', '1');
INSERT INTO `sys_log` VALUES ('1215', '2', null, 'sys_user', '1', '登入', '', '2017-05-18 02:44:45', '1');
INSERT INTO `sys_log` VALUES ('1216', '2', null, 'sys_user', '1', '登入', '', '2017-05-18 02:49:16', '1');
INSERT INTO `sys_log` VALUES ('1217', '2', null, 'sys_user', '1', '登入', '', '2017-05-18 02:51:02', '1');
INSERT INTO `sys_log` VALUES ('1218', '2', null, 'sys_user', '1', '登入', '', '2017-05-18 02:53:18', '1');
INSERT INTO `sys_log` VALUES ('1219', '2', null, 'sys_user', '1', '登入', '', '2017-05-18 02:55:47', '1');
INSERT INTO `sys_log` VALUES ('1220', '2', null, 'sys_user', '1', '登入', '', '2017-05-18 02:58:56', '1');
INSERT INTO `sys_log` VALUES ('1221', '2', null, 'sys_user', '1', '登入', '', '2017-05-18 03:07:45', '1');
INSERT INTO `sys_log` VALUES ('1222', '2', null, 'sys_user', '1', '登入', '', '2017-05-18 03:41:02', '1');
INSERT INTO `sys_log` VALUES ('1223', '2', null, 'sys_user', '1', '登入', '', '2017-05-18 03:45:01', '1');
INSERT INTO `sys_log` VALUES ('1224', '2', null, 'sys_user', '1', '登入', '', '2017-05-18 03:51:23', '1');
INSERT INTO `sys_log` VALUES ('1225', '2', null, 'sys_user', '1', '登入', '', '2017-05-18 04:01:48', '1');
INSERT INTO `sys_log` VALUES ('1226', '1', null, 'sys_department', '29', '更新', '', '2017-05-18 04:02:21', '1');
INSERT INTO `sys_log` VALUES ('1227', '2', null, 'sys_user', '1', '登入', '', '2017-05-18 04:03:53', '1');
INSERT INTO `sys_log` VALUES ('1228', '2', null, 'sys_user', '1', '登入', '', '2017-05-18 04:04:55', '1');
INSERT INTO `sys_log` VALUES ('1229', '2', null, 'sys_user', '1', '登入', '', '2017-05-18 04:06:03', '1');
INSERT INTO `sys_log` VALUES ('1230', '2', null, 'sys_user', '1', '登入', '', '2017-05-18 04:30:06', '1');
INSERT INTO `sys_log` VALUES ('1231', '2', null, 'sys_user', '1', '登入', '', '2017-05-18 04:33:54', '1');
INSERT INTO `sys_log` VALUES ('1232', '2', null, 'sys_user', '1', '登出', '', '2017-05-18 04:37:09', '1');
INSERT INTO `sys_log` VALUES ('1233', '2', null, 'sys_user', '1', '登入', '', '2017-05-18 04:37:59', '1');
INSERT INTO `sys_log` VALUES ('1234', '2', null, 'sys_user', '1', '登入', '', '2017-05-18 04:50:23', '1');
INSERT INTO `sys_log` VALUES ('1235', '2', null, 'sys_user', '1', '登入', '', '2017-05-18 04:52:34', '1');
INSERT INTO `sys_log` VALUES ('1236', '2', null, 'sys_user', '1', '登入', '', '2017-05-18 04:54:50', '1');
INSERT INTO `sys_log` VALUES ('1237', '2', null, 'sys_user', '1', '登入', '', '2017-05-18 05:12:27', '1');
INSERT INTO `sys_log` VALUES ('1238', '2', null, 'sys_user', '1', '登入', '', '2017-05-18 05:19:17', '1');
INSERT INTO `sys_log` VALUES ('1239', '2', null, 'sys_user', '1', '登入', '', '2017-05-18 05:39:08', '1');
INSERT INTO `sys_log` VALUES ('1240', '2', null, 'sys_user', '1', '登出', '', '2017-05-18 05:42:33', '1');
INSERT INTO `sys_log` VALUES ('1241', '2', null, 'sys_user', '1', '登入', '', '2017-05-18 05:42:43', '1');
INSERT INTO `sys_log` VALUES ('1242', '2', null, 'sys_user', '1', '登入', '', '2017-05-18 05:42:47', '1');
INSERT INTO `sys_log` VALUES ('1243', '2', null, 'sys_user', '1', '登出', '', '2017-05-18 05:45:30', '1');
INSERT INTO `sys_log` VALUES ('1244', '2', null, 'sys_user', '1', '登入', '', '2017-05-18 06:26:07', '1');
INSERT INTO `sys_log` VALUES ('1245', '2', null, 'sys_user', '1', '登入', '', '2017-05-18 06:43:10', '1');
INSERT INTO `sys_log` VALUES ('1246', '2', null, 'sys_user', '1', '登入', '', '2017-05-18 06:44:27', '1');
INSERT INTO `sys_log` VALUES ('1247', '1', null, 'sys_menu', '29', '添加', '', '2017-05-18 06:49:24', '0');
INSERT INTO `sys_log` VALUES ('1248', '2', null, 'sys_user', '1', '登出', '', '2017-05-18 06:49:48', '1');
INSERT INTO `sys_log` VALUES ('1249', '2', null, 'sys_user', '1', '登入', '', '2017-05-18 06:49:56', '1');
INSERT INTO `sys_log` VALUES ('1250', '1', null, 'sys_menu', '29', '更新', '', '2017-05-18 06:50:44', '1');
INSERT INTO `sys_log` VALUES ('1251', '2', null, 'sys_user', '1', '登出', '', '2017-05-18 06:50:56', '1');
INSERT INTO `sys_log` VALUES ('1252', '2', null, 'sys_user', '1', '登入', '', '2017-05-18 06:51:03', '1');
INSERT INTO `sys_log` VALUES ('1253', '2', null, 'sys_user', '1', '登入', '', '2017-05-18 06:58:38', '1');
INSERT INTO `sys_log` VALUES ('1254', '2', null, 'sys_user', '1', '登入', '', '2017-05-18 07:01:21', '1');
INSERT INTO `sys_log` VALUES ('1255', '2', null, 'sys_user', '1', '登入', '', '2017-05-18 07:20:29', '1');
INSERT INTO `sys_log` VALUES ('1256', '2', null, 'sys_user', '1', '登入', '', '2017-05-18 09:07:53', '1');
INSERT INTO `sys_log` VALUES ('1257', '2', null, 'sys_user', '1', '登入', '', '2017-05-18 09:17:35', '1');
INSERT INTO `sys_log` VALUES ('1258', '2', null, 'sys_user', '1', '登入', '', '2017-05-18 09:19:13', '1');
INSERT INTO `sys_log` VALUES ('1259', '2', null, 'sys_user', '1', '登入', '', '2017-05-18 09:46:45', '1');
INSERT INTO `sys_log` VALUES ('1260', '1', null, 'sys_role_menu', '36', '添加', '', '2017-05-18 09:47:59', '1');
INSERT INTO `sys_log` VALUES ('1261', '1', null, 'sys_role_menu', '37', '添加', '', '2017-05-18 09:47:59', '1');
INSERT INTO `sys_log` VALUES ('1262', '1', null, 'sys_role_menu', '38', '添加', '', '2017-05-18 09:47:59', '1');
INSERT INTO `sys_log` VALUES ('1263', '1', null, 'sys_role_menu', '39', '添加', '', '2017-05-18 09:47:59', '1');
INSERT INTO `sys_log` VALUES ('1264', '1', null, 'sys_role_menu', '40', '添加', '', '2017-05-18 09:47:59', '1');
INSERT INTO `sys_log` VALUES ('1265', '1', null, 'sys_role_menu', '41', '添加', '', '2017-05-18 09:47:59', '1');
INSERT INTO `sys_log` VALUES ('1266', '1', null, 'sys_role_menu', '42', '添加', '', '2017-05-18 09:47:59', '1');
INSERT INTO `sys_log` VALUES ('1267', '1', null, 'sys_role_menu', '43', '添加', '', '2017-05-18 09:47:59', '1');
INSERT INTO `sys_log` VALUES ('1268', '1', null, 'sys_role_menu', '44', '添加', '', '2017-05-18 09:47:59', '1');
INSERT INTO `sys_log` VALUES ('1269', '1', null, 'sys_role_menu', '45', '添加', '', '2017-05-18 09:47:59', '1');
INSERT INTO `sys_log` VALUES ('1270', '1', null, 'sys_role_menu', '46', '添加', '', '2017-05-18 09:47:59', '1');
INSERT INTO `sys_log` VALUES ('1271', '2', null, 'sys_user', '1', '登入', '', '2017-05-18 09:54:04', '1');
INSERT INTO `sys_log` VALUES ('1272', '2', null, 'sys_user', '1', '登入', '', '2017-05-18 10:10:14', '1');
INSERT INTO `sys_log` VALUES ('1273', '2', null, 'sys_user', '1', '登入', '', '2017-05-18 10:45:35', '1');
INSERT INTO `sys_log` VALUES ('1274', '2', null, 'sys_user', '1', '登入', '', '2017-05-18 11:22:59', '1');
INSERT INTO `sys_log` VALUES ('1275', '1', null, 'sys_department', '44', '添加', '', '2017-05-18 11:23:59', '1');
INSERT INTO `sys_log` VALUES ('1276', '2', null, 'sys_user', '1', '登入', '', '2017-05-18 12:30:05', '1');
INSERT INTO `sys_log` VALUES ('1277', '2', null, 'sys_user', '1', '登入', '', '2017-05-18 12:56:11', '1');
INSERT INTO `sys_log` VALUES ('1278', '2', null, 'sys_user', '1', '登入', '', '2017-05-18 13:55:35', '1');
INSERT INTO `sys_log` VALUES ('1279', '2', null, 'sys_user', '1', '登入', '', '2017-05-18 20:44:38', '1');
INSERT INTO `sys_log` VALUES ('1280', '2', null, 'sys_user', '1', '登入', '', '2017-05-22 10:42:06', '1');
INSERT INTO `sys_log` VALUES ('1281', '1', null, 'sys_department', '37', '删除', '', '2017-05-22 14:10:02', '1');
INSERT INTO `sys_log` VALUES ('1282', '2', null, 'sys_user', '1', '登出', '', '2017-05-22 14:11:23', '1');
INSERT INTO `sys_log` VALUES ('1283', '2', null, 'sys_user', '1', '登入', '', '2017-05-22 14:12:08', '1');
INSERT INTO `sys_log` VALUES ('1284', '1', null, 'sys_user_role', '33', '添加', '', '2017-05-22 14:12:57', '1');
INSERT INTO `sys_log` VALUES ('1285', '1', null, 'sys_role_menu', '47', '添加', '', '2017-05-22 14:13:18', '1');
INSERT INTO `sys_log` VALUES ('1286', '1', null, 'sys_role_menu', '48', '添加', '', '2017-05-22 14:13:19', '1');
INSERT INTO `sys_log` VALUES ('1287', '1', null, 'sys_role_menu', '49', '添加', '', '2017-05-22 14:13:20', '1');
INSERT INTO `sys_log` VALUES ('1288', '1', null, 'sys_role_menu', '50', '添加', '', '2017-05-22 14:13:21', '1');
INSERT INTO `sys_log` VALUES ('1289', '1', null, 'sys_role_menu', '51', '添加', '', '2017-05-22 14:13:22', '1');
INSERT INTO `sys_log` VALUES ('1290', '1', null, 'sys_role_menu', '52', '添加', '', '2017-05-22 14:13:23', '1');
INSERT INTO `sys_log` VALUES ('1291', '1', null, 'sys_role_menu', '53', '添加', '', '2017-05-22 14:13:24', '1');
INSERT INTO `sys_log` VALUES ('1292', '1', null, 'sys_role_menu', '54', '添加', '', '2017-05-22 14:13:24', '1');
INSERT INTO `sys_log` VALUES ('1293', '1', null, 'sys_role_menu', '55', '添加', '', '2017-05-22 14:13:25', '1');
INSERT INTO `sys_log` VALUES ('1294', '1', null, 'sys_role_menu', '56', '添加', '', '2017-05-22 14:13:25', '1');
INSERT INTO `sys_log` VALUES ('1295', '1', null, 'sys_role_menu', '57', '添加', '', '2017-05-22 14:13:26', '1');
INSERT INTO `sys_log` VALUES ('1296', '1', null, 'sys_role_menu', '58', '添加', '', '2017-05-22 14:13:27', '1');
INSERT INTO `sys_log` VALUES ('1297', '2', null, 'sys_user', '1', '登出', '', '2017-05-22 14:13:33', '1');
INSERT INTO `sys_log` VALUES ('1298', '2', null, 'sys_user', '14', '登入', '', '2017-05-22 14:13:47', '14');
INSERT INTO `sys_log` VALUES ('1299', '2', null, 'sys_user', '14', '登出', '', '2017-05-22 15:21:27', '14');
INSERT INTO `sys_log` VALUES ('1300', '2', null, 'sys_user', '1', '登入', '', '2017-05-22 15:22:31', '1');
INSERT INTO `sys_log` VALUES ('1301', '2', null, 'sys_user', '1', '登出', '', '2017-05-22 15:55:34', '1');
INSERT INTO `sys_log` VALUES ('1302', '2', null, 'sys_user', '14', '登入', '', '2017-05-22 15:56:31', '14');
INSERT INTO `sys_log` VALUES ('1303', '2', null, 'sys_user', '14', '登出', '', '2017-05-22 15:58:22', '14');
INSERT INTO `sys_log` VALUES ('1304', '2', null, 'sys_user', '1', '登入', '', '2017-05-22 15:58:33', '1');
INSERT INTO `sys_log` VALUES ('1305', '1', null, 'sys_user_role', '34', '添加', '', '2017-05-22 15:58:57', '1');
INSERT INTO `sys_log` VALUES ('1306', '1', null, 'sys_user_role', '35', '添加', '', '2017-05-22 16:02:21', '1');
INSERT INTO `sys_log` VALUES ('1307', '1', null, 'sys_user_role', '36', '添加', '', '2017-05-22 16:02:22', '1');
INSERT INTO `sys_log` VALUES ('1308', '1', null, 'sys_user_role', '37', '添加', '', '2017-05-22 16:26:25', '1');
INSERT INTO `sys_log` VALUES ('1309', '1', null, 'sys_role_menu', '59', '添加', '', '2017-05-22 16:27:00', '1');
INSERT INTO `sys_log` VALUES ('1310', '1', null, 'sys_role_menu', '60', '添加', '', '2017-05-22 16:27:00', '1');
INSERT INTO `sys_log` VALUES ('1311', '1', null, 'sys_role_menu', '61', '添加', '', '2017-05-22 16:27:00', '1');
INSERT INTO `sys_log` VALUES ('1312', '1', null, 'sys_role_menu', '62', '添加', '', '2017-05-22 16:27:01', '1');
INSERT INTO `sys_log` VALUES ('1313', '1', null, 'sys_role_menu', '63', '添加', '', '2017-05-22 16:27:01', '1');
INSERT INTO `sys_log` VALUES ('1314', '1', null, 'sys_role_menu', '64', '添加', '', '2017-05-22 16:27:02', '1');
INSERT INTO `sys_log` VALUES ('1315', '1', null, 'sys_role_menu', '65', '添加', '', '2017-05-22 16:27:03', '1');
INSERT INTO `sys_log` VALUES ('1316', '2', null, 'sys_user', '1', '登出', '', '2017-05-22 16:34:01', '1');
INSERT INTO `sys_log` VALUES ('1317', '2', null, 'sys_user', '14', '登入', '', '2017-05-22 16:34:50', '14');
INSERT INTO `sys_log` VALUES ('1318', '2', null, 'sys_user', '14', '登出', '', '2017-05-22 16:35:41', '14');
INSERT INTO `sys_log` VALUES ('1319', '2', null, 'sys_user', '1', '登入', '', '2017-05-22 16:35:56', '1');
INSERT INTO `sys_log` VALUES ('1320', '1', null, 'sys_role_menu', '66', '添加', '', '2017-05-22 16:36:48', '1');
INSERT INTO `sys_log` VALUES ('1321', '1', null, 'sys_role_menu', '67', '添加', '', '2017-05-22 16:36:49', '1');
INSERT INTO `sys_log` VALUES ('1322', '1', null, 'sys_role_menu', '68', '添加', '', '2017-05-22 16:36:49', '1');
INSERT INTO `sys_log` VALUES ('1323', '1', null, 'sys_role_menu', '69', '添加', '', '2017-05-22 16:36:50', '1');
INSERT INTO `sys_log` VALUES ('1324', '1', null, 'sys_role_menu', '70', '添加', '', '2017-05-22 16:36:50', '1');
INSERT INTO `sys_log` VALUES ('1325', '2', null, 'sys_user', '1', '登出', '', '2017-05-22 16:36:54', '1');
INSERT INTO `sys_log` VALUES ('1326', '2', null, 'sys_user', '14', '登入', '', '2017-05-22 16:37:17', '14');
INSERT INTO `sys_log` VALUES ('1327', '2', null, 'sys_user', '1', '登入', '', '2017-06-01 09:47:53', '1');
INSERT INTO `sys_log` VALUES ('1328', '1', null, 'sys_menu', '28', '删除', '', '2017-06-01 09:48:35', '1');
INSERT INTO `sys_log` VALUES ('1329', '1', null, 'sys_menu', '25', '删除', '', '2017-06-01 09:48:45', '1');
INSERT INTO `sys_log` VALUES ('1330', '1', null, 'sys_menu', '26', '删除', '', '2017-06-01 09:49:02', '1');
INSERT INTO `sys_log` VALUES ('1331', '1', null, 'sys_menu', '29', '删除', '', '2017-06-01 09:49:31', '1');
INSERT INTO `sys_log` VALUES ('1332', '1', null, 'sys_menu', '27', '删除', '', '2017-06-01 09:49:49', '1');
INSERT INTO `sys_log` VALUES ('1333', '1', null, 'sys_menu', '23', '删除', '', '2017-06-01 09:49:55', '1');
INSERT INTO `sys_log` VALUES ('1334', '1', null, 'sys_menu', '30', '添加', '', '2017-06-01 09:51:36', '0');
INSERT INTO `sys_log` VALUES ('1335', '1', null, 'sys_menu', '31', '添加', '', '2017-06-01 09:53:58', '0');
INSERT INTO `sys_log` VALUES ('1336', '1', null, 'sys_menu', '32', '添加', '', '2017-06-01 09:54:53', '0');
INSERT INTO `sys_log` VALUES ('1337', '1', null, 'sys_menu', '32', '更新', '', '2017-06-01 09:55:14', '1');
INSERT INTO `sys_log` VALUES ('1338', '1', null, 'sys_menu', '33', '添加', '', '2017-06-01 09:55:59', '0');
INSERT INTO `sys_log` VALUES ('1339', '1', null, 'sys_menu', '34', '添加', '', '2017-06-01 09:57:01', '0');
INSERT INTO `sys_log` VALUES ('1340', '2', null, 'sys_user', '1', '登出', '', '2017-06-01 09:57:09', '1');
INSERT INTO `sys_log` VALUES ('1341', '2', null, 'sys_user', '1', '登入', '', '2017-06-01 09:57:29', '1');
INSERT INTO `sys_log` VALUES ('1342', '2', null, 'sys_user', '1', '登入', '', '2017-06-01 10:45:57', '1');
INSERT INTO `sys_log` VALUES ('1343', '2', null, 'sys_user', '1', '登入', '', '2017-07-05 10:43:58', '1');
INSERT INTO `sys_log` VALUES ('1344', '1', null, 'sys_menu', '35', '添加', '', '2017-07-05 10:45:38', '0');
INSERT INTO `sys_log` VALUES ('1345', '2', null, 'sys_user', '1', '登出', '', '2017-07-05 10:45:41', '1');
INSERT INTO `sys_log` VALUES ('1346', '2', null, 'sys_user', '1', '登入', '', '2017-07-05 10:45:57', '1');
INSERT INTO `sys_log` VALUES ('1347', '1', null, 'sys_menu', '35', '更新', '', '2017-07-05 10:46:07', '1');
INSERT INTO `sys_log` VALUES ('1348', '1', null, 'sys_menu', '35', '更新', '', '2017-07-05 10:46:54', '1');
INSERT INTO `sys_log` VALUES ('1349', '2', null, 'sys_user', '1', '登出', '', '2017-07-05 10:46:58', '1');
INSERT INTO `sys_log` VALUES ('1350', '2', null, 'sys_user', '1', '登入', '', '2017-07-05 10:47:38', '1');
INSERT INTO `sys_log` VALUES ('1351', '2', null, 'sys_user', '1', '登入', '', '2017-07-14 17:30:53', '1');
INSERT INTO `sys_log` VALUES ('1352', '2', null, 'sys_user', '1', '登入', '', '2017-07-24 10:02:21', '1');

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
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8 COMMENT='菜单';

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
INSERT INTO `sys_menu` VALUES ('21', '0', '首页', 'home', 'home', '1', '1', '1', '1', '2015-04-27 17:28:06', '1');
INSERT INTO `sys_menu` VALUES ('30', '0', '任务管理', 'job', null, '1', '1', '2', '1', '2017-06-01 09:51:36', '1');
INSERT INTO `sys_menu` VALUES ('31', '30', '时间规则', 'job_times', 'quartz/times/list', '1', '1', '3', '2', '2017-06-01 09:53:57', '1');
INSERT INTO `sys_menu` VALUES ('32', '30', '触发器', 'job_tigger', 'quartz/trigger/list', '1', '1', '4', '2', '2017-06-01 09:54:53', '1');
INSERT INTO `sys_menu` VALUES ('33', '30', '执行类', 'job_class', 'quartz/jobclass/list', '1', '1', '5', '2', '2017-06-01 09:55:59', '1');
INSERT INTO `sys_menu` VALUES ('34', '30', 'job任务', 'job_jobs', 'quartz/jobs/list', '1', '1', '6', '2', '2017-06-01 09:57:00', '1');
INSERT INTO `sys_menu` VALUES ('35', '30', '执行日志', 'job_log', 'quartz/log/list', '1', '1', '7', '2', '2017-07-05 10:45:38', '1');

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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='角色';

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('3', 'test1', '2', null, null, '2017-05-13 23:04:10', '1');
INSERT INTO `sys_role` VALUES ('7', 'tewdsa', '1', '2', null, '2017-05-16 21:31:30', '1');
INSERT INTO `sys_role` VALUES ('8', 'jflasda', '1', '12121', 'dsfasdf', '2017-05-16 23:27:15', '1');

-- ----------------------------
-- Table structure for `sys_role_menu`
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `roleid` int(11) NOT NULL COMMENT '角色id',
  `menuid` int(11) NOT NULL COMMENT '菜单id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8 COMMENT='角色和菜单关联';

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES ('34', '3', '1');
INSERT INTO `sys_role_menu` VALUES ('35', '3', '2');
INSERT INTO `sys_role_menu` VALUES ('68', '7', '21');
INSERT INTO `sys_role_menu` VALUES ('69', '7', '1');
INSERT INTO `sys_role_menu` VALUES ('70', '7', '3');

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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='用户';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('1', 'admin', 'EY3JNDE7nu8=', '系统管理员', '1', '1', '10', null, null, 'zcool321@sina.com', '123', null, null, '时间是最好的老师，但遗憾的是——最后他把所有的学生都弄死了', 'flat', '5', '1', '2016-06-06 06:06:06', '1');
INSERT INTO `sys_user` VALUES ('2', 'testapi', 'EY3JNDE7nu8=', 'api测试', '1', '5', '10', null, null, null, null, null, null, null, 'default', '0', '1', '2017-03-19 20:41:25', '1');
INSERT INTO `sys_user` VALUES ('3', 'test2', 'EY3JNDE7nu8=', '测试', '2', '2', '10', null, null, null, null, null, null, null, 'flat', '0', '1', '2017-05-08 18:10:16', '1');
INSERT INTO `sys_user` VALUES ('4', 'test', 'EY3JNDE7nu8=', 'test', '18', '2', '10', null, null, 'test', 'test', 'test', null, null, 'flat', '0', '1', '2017-05-13 23:00:06', '1');
INSERT INTO `sys_user` VALUES ('6', 'aaaa', 'EY3JNDE7nu8=', 'bbbb', '15', '1', '10', null, null, '1@2.com', '1234', 'fdafdsa', 'fdafdsa', null, 'flat', '0', '1', '2017-05-15 00:12:59', '1');
INSERT INTO `sys_user` VALUES ('7', 'admint', 'EY3JNDE7nu8=', '1', '8', '1', '10', null, null, null, null, null, null, null, 'flat', '0', '1', '2017-05-15 05:43:20', '1');
INSERT INTO `sys_user` VALUES ('8', 'syz', 'EY3JNDE7nu8=', 'sunwukong', '26', '1', '10', null, null, null, null, null, null, null, 'flat', '0', '1', '2017-05-16 05:45:27', '1');
INSERT INTO `sys_user` VALUES ('9', 'nobody', 'EY3JNDE7nu8=', 'nobody', '18', '1', '10', null, null, null, null, null, null, null, 'flat', '0', '1', '2017-05-16 05:47:30', '1');
INSERT INTO `sys_user` VALUES ('11', 'sss', 'EY3JNDE7nu8=', 'ss', '27', '2', '10', null, null, 'ss@ss', null, null, null, null, 'flat', '0', '1', '2017-05-16 22:37:28', '1');
INSERT INTO `sys_user` VALUES ('12', 'asdf', 'EY3JNDE7nu8=', 'assad', '31', '5', '10', null, null, '231@54.com', '13703064221', '123123', '12313', '123123', 'flat', '0', '1', '2017-05-16 22:44:02', '1');
INSERT INTO `sys_user` VALUES ('13', '123', 'EY3JNDE7nu8=', '123', '15', '9', '10', null, null, '123', '1232222', '123', '123', null, 'flat', '0', '1', '2017-05-17 10:32:25', '1');
INSERT INTO `sys_user` VALUES ('14', 'a', 'EY3JNDE7nu8=', 'a', '36', '2', '10', null, null, null, null, null, null, null, 'flat', '0', '1', '2017-05-22 14:12:41', '1');

-- ----------------------------
-- Table structure for `sys_user_role`
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `userid` int(11) NOT NULL COMMENT '用户id',
  `roleid` int(11) NOT NULL COMMENT '角色id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8 COMMENT='用户和角色关联';

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES ('2', '4', '3');
INSERT INTO `sys_user_role` VALUES ('3', '4', '1');
INSERT INTO `sys_user_role` VALUES ('7', '3', '3');
INSERT INTO `sys_user_role` VALUES ('8', '3', '1');
INSERT INTO `sys_user_role` VALUES ('17', '7', '3');
INSERT INTO `sys_user_role` VALUES ('18', '7', '5');
INSERT INTO `sys_user_role` VALUES ('19', '7', '1');
INSERT INTO `sys_user_role` VALUES ('20', '7', '2');
INSERT INTO `sys_user_role` VALUES ('22', '6', '2');
INSERT INTO `sys_user_role` VALUES ('23', '8', '3');
INSERT INTO `sys_user_role` VALUES ('24', '8', '5');
INSERT INTO `sys_user_role` VALUES ('25', '8', '2');
INSERT INTO `sys_user_role` VALUES ('26', '9', '6');
INSERT INTO `sys_user_role` VALUES ('27', '2', '2');
INSERT INTO `sys_user_role` VALUES ('28', '2', '7');
INSERT INTO `sys_user_role` VALUES ('29', '2', '8');
INSERT INTO `sys_user_role` VALUES ('31', '12', '2');
INSERT INTO `sys_user_role` VALUES ('32', '13', '7');
INSERT INTO `sys_user_role` VALUES ('37', '14', '7');

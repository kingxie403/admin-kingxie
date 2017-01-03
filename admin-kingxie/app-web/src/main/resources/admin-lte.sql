-- --------------------------------------------------------
-- 主机:                           127.0.0.1
-- 服务器版本:                        5.7.13 - MySQL Community Server (GPL)
-- 服务器操作系统:                      Win64
-- HeidiSQL 版本:                  9.3.0.4984
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- 导出 db_lte 的数据库结构
CREATE DATABASE IF NOT EXISTS `db_lte` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `db_lte`;


-- 导出  表 db_lte.sys_dic_item 结构
CREATE TABLE IF NOT EXISTS `sys_dic_item` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `SORT` int(11) DEFAULT NULL COMMENT '序号',
  `TEXT` varchar(20) DEFAULT NULL COMMENT '字典内容',
  `VALUE` int(11) DEFAULT NULL COMMENT '值',
  `TYPE_ID` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

-- 正在导出表  db_lte.sys_dic_item 的数据：~4 rows (大约)
/*!40000 ALTER TABLE `sys_dic_item` DISABLE KEYS */;
REPLACE INTO `sys_dic_item` (`ID`, `SORT`, `TEXT`, `VALUE`, `TYPE_ID`) VALUES
	(15, 1, 'MENU', 1, 1),
	(16, 2, 'FILE', 2, 1),
	(17, 3, 'PAGE', 3, 1),
	(18, 4, 'OPERATE', 4, 1);
/*!40000 ALTER TABLE `sys_dic_item` ENABLE KEYS */;


-- 导出  表 db_lte.sys_dic_type 结构
CREATE TABLE IF NOT EXISTS `sys_dic_type` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `DIC_CODE` varchar(20) DEFAULT NULL COMMENT '编码',
  `STATUS` int(11) DEFAULT NULL COMMENT '状态',
  `DIC_NAME` varchar(20) DEFAULT NULL COMMENT '字典类型名称',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- 正在导出表  db_lte.sys_dic_type 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `sys_dic_type` DISABLE KEYS */;
REPLACE INTO `sys_dic_type` (`ID`, `DIC_CODE`, `STATUS`, `DIC_NAME`) VALUES
	(1, 'PRI_TYPE', 1, '权限类型');
/*!40000 ALTER TABLE `sys_dic_type` ENABLE KEYS */;


-- 导出  表 db_lte.sys_menu 结构
CREATE TABLE IF NOT EXISTS `sys_menu` (
  `MENU_ID` int(11) NOT NULL AUTO_INCREMENT,
  `MENU_NAME` varchar(20) DEFAULT NULL,
  `MENU_URL` varchar(50) DEFAULT NULL,
  `MENU_PARENT` int(11) DEFAULT NULL COMMENT '父菜单ID',
  PRIMARY KEY (`MENU_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- 正在导出表  db_lte.sys_menu 的数据：~6 rows (大约)
/*!40000 ALTER TABLE `sys_menu` DISABLE KEYS */;
REPLACE INTO `sys_menu` (`MENU_ID`, `MENU_NAME`, `MENU_URL`, `MENU_PARENT`) VALUES
	(1, '系统管理', '', 0),
	(2, '用户管理', '${ctx}/user/manager', 1),
	(3, '角色管理', '${ctx}/role/manager', 1),
	(4, '角色管理', '${ctx}/privilege/manager', 1),
	(5, '数据字典管理', '${ctx}/dicType/manager', 1),
	(6, '数据字典管理', '${ctx}/menu/manager', 1);
/*!40000 ALTER TABLE `sys_menu` ENABLE KEYS */;


-- 导出  表 db_lte.sys_privilege 结构
CREATE TABLE IF NOT EXISTS `sys_privilege` (
  `PRI_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '权限ID',
  `PRI_NAME` varchar(255) DEFAULT NULL COMMENT '权限名称',
  `PRI_TYPE` varchar(255) DEFAULT NULL COMMENT '权限类型',
  PRIMARY KEY (`PRI_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- 正在导出表  db_lte.sys_privilege 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `sys_privilege` DISABLE KEYS */;
REPLACE INTO `sys_privilege` (`PRI_ID`, `PRI_NAME`, `PRI_TYPE`) VALUES
	(1, '菜单权限', 'MENU'),
	(2, '管理员菜单', 'MENU');
/*!40000 ALTER TABLE `sys_privilege` ENABLE KEYS */;


-- 导出  表 db_lte.sys_pri_ref_menu 结构
CREATE TABLE IF NOT EXISTS `sys_pri_ref_menu` (
  `PRI_ID` int(10) DEFAULT NULL,
  `MENU_ID` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  db_lte.sys_pri_ref_menu 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `sys_pri_ref_menu` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_pri_ref_menu` ENABLE KEYS */;


-- 导出  表 db_lte.sys_role 结构
CREATE TABLE IF NOT EXISTS `sys_role` (
  `ROLE_ID` int(11) NOT NULL AUTO_INCREMENT,
  `ROLE_NAME` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`ROLE_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- 正在导出表  db_lte.sys_role 的数据：~12 rows (大约)
/*!40000 ALTER TABLE `sys_role` DISABLE KEYS */;
REPLACE INTO `sys_role` (`ROLE_ID`, `ROLE_NAME`) VALUES
	(1, '管理员'),
	(3, '集团董事长'),
	(4, '秘书'),
	(5, '项目总监'),
	(6, '项目经理'),
	(7, 'java开发工程师'),
	(8, 'C#开发工程师'),
	(9, 'C++开发工程师'),
	(10, 'java测试工程师'),
	(11, 'C#测试工程师'),
	(12, 'C++测试工程师');
/*!40000 ALTER TABLE `sys_role` ENABLE KEYS */;


-- 导出  表 db_lte.sys_user 结构
CREATE TABLE IF NOT EXISTS `sys_user` (
  `user_id` int(10) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(20) DEFAULT NULL,
  `password` varchar(60) DEFAULT NULL,
  `email` varchar(60) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8;

-- 正在导出表  db_lte.sys_user 的数据：~59 rows (大约)
/*!40000 ALTER TABLE `sys_user` DISABLE KEYS */;
REPLACE INTO `sys_user` (`user_id`, `user_name`, `password`, `email`, `create_date`, `update_date`) VALUES
	(1, '管理员', 'd785c99d298a4e9e6e13fe99e602ef42', '9876656755@qq.com', '2016-11-07 13:37:35', '2016-11-07 13:37:35'),
	(2, 'zhangsan', '437599f1ea3514f8969f161a6606ce18', '1234565@qq.com', '2016-11-09 14:02:22', '2016-11-09 14:02:22'),
	(4, 'zhangsan', '437599f1ea3514f8969f161a6606ce18', '1234565@qq.com', '2016-11-09 14:02:41', '2016-11-09 14:02:41'),
	(6, 'zhangsan', '437599f1ea3514f8969f161a6606ce18', '1234565@qq.com', '2016-11-09 14:02:48', '2016-11-09 14:02:48'),
	(7, 'zhangsan', '437599f1ea3514f8969f161a6606ce18', '1234565@qq.com', '2016-11-09 14:02:50', '2016-11-09 14:02:50'),
	(8, 'zhangsan', '437599f1ea3514f8969f161a6606ce18', '1234565@qq.com', '2016-11-09 14:02:51', '2016-11-09 14:02:51'),
	(9, 'zhangsan', '437599f1ea3514f8969f161a6606ce18', '1234565@qq.com', '2016-11-09 14:02:53', '2016-11-09 14:02:53'),
	(10, 'zhangsan', '437599f1ea3514f8969f161a6606ce18', '1234565@qq.com', '2016-11-09 14:02:54', '2016-11-09 14:02:54'),
	(11, 'zhangsan', '437599f1ea3514f8969f161a6606ce18', '1234565@qq.com', '2016-11-09 14:02:56', '2016-11-09 14:02:56'),
	(13, 'zhangsan', '437599f1ea3514f8969f161a6606ce18', '1234565@qq.com', '2016-11-09 14:02:58', '2016-11-09 14:02:58'),
	(14, 'zhangsan', '437599f1ea3514f8969f161a6606ce18', '1234565@qq.com', '2016-11-09 14:03:00', '2016-11-09 14:03:00'),
	(15, 'zhangsan', '437599f1ea3514f8969f161a6606ce18', '1234565@qq.com', '2016-11-09 14:03:02', '2016-11-09 14:03:02'),
	(16, 'zhangsan', '437599f1ea3514f8969f161a6606ce18', '1234565@qq.com', '2016-11-09 14:03:03', '2016-11-09 14:03:03'),
	(17, 'zhangsan', '437599f1ea3514f8969f161a6606ce18', '1234565@qq.com', '2016-11-09 14:03:04', '2016-11-09 14:03:04'),
	(18, 'zhangsan', '437599f1ea3514f8969f161a6606ce18', '1234565@qq.com', '2016-11-09 14:03:06', '2016-11-09 14:03:06'),
	(19, 'zhangsan', '437599f1ea3514f8969f161a6606ce18', '1234565@qq.com', '2016-11-09 14:03:08', '2016-11-09 14:03:08'),
	(20, 'zhangsan', '437599f1ea3514f8969f161a6606ce18', '1234565@qq.com', '2016-11-09 14:03:08', '2016-11-09 14:03:08'),
	(21, 'zhangsan', '437599f1ea3514f8969f161a6606ce18', '1234565@qq.com', '2016-11-09 14:03:10', '2016-11-09 14:03:10'),
	(22, 'zhangsan', '437599f1ea3514f8969f161a6606ce18', '1234565@qq.com', '2016-11-09 14:03:11', '2016-11-09 14:03:11'),
	(23, 'zhangsan', '437599f1ea3514f8969f161a6606ce18', '1234565@qq.com', '2016-11-09 14:03:12', '2016-11-09 14:03:12'),
	(24, 'zhangsan', '437599f1ea3514f8969f161a6606ce18', '1234565@qq.com', '2016-11-09 14:03:13', '2016-11-09 14:03:13'),
	(25, 'zhangsan', '437599f1ea3514f8969f161a6606ce18', '1234565@qq.com', '2016-11-09 14:03:14', '2016-11-09 14:03:14'),
	(26, 'zhangsan', '437599f1ea3514f8969f161a6606ce18', '1234565@qq.com', '2016-11-09 14:03:14', '2016-11-09 14:03:14'),
	(27, 'zhangsan', '437599f1ea3514f8969f161a6606ce18', '1234565@qq.com', '2016-11-09 14:03:15', '2016-11-09 14:03:15'),
	(28, 'zhangsan', '437599f1ea3514f8969f161a6606ce18', '1234565@qq.com', '2016-11-09 14:03:16', '2016-11-09 14:03:16'),
	(29, 'zhangsan', '437599f1ea3514f8969f161a6606ce18', '1234565@qq.com', '2016-11-09 14:03:16', '2016-11-09 14:03:16'),
	(30, 'zhangsan', '437599f1ea3514f8969f161a6606ce18', '1234565@qq.com', '2016-11-09 14:03:17', '2016-11-09 14:03:17'),
	(31, 'zhangsan', '437599f1ea3514f8969f161a6606ce18', '1234565@qq.com', '2016-11-09 14:03:17', '2016-11-09 14:03:17'),
	(32, 'zhangsan', '437599f1ea3514f8969f161a6606ce18', '1234565@qq.com', '2016-11-09 14:03:18', '2016-11-09 14:03:18'),
	(33, 'zhangsan', '437599f1ea3514f8969f161a6606ce18', '1234565@qq.com', '2016-11-09 14:03:18', '2016-11-09 14:03:18'),
	(34, 'zhangsan', '437599f1ea3514f8969f161a6606ce18', '1234565@qq.com', '2016-11-09 14:03:19', '2016-11-09 14:03:19'),
	(35, 'zhangsan', '437599f1ea3514f8969f161a6606ce18', '1234565@qq.com', '2016-11-09 14:03:19', '2016-11-09 14:03:19'),
	(36, 'zhangsan', '437599f1ea3514f8969f161a6606ce18', '1234565@qq.com', '2016-11-09 14:03:20', '2016-11-09 14:03:20'),
	(37, 'zhangsan', '437599f1ea3514f8969f161a6606ce18', '1234565@qq.com', '2016-11-09 14:03:20', '2016-11-09 14:03:20'),
	(38, 'zhangsan', '437599f1ea3514f8969f161a6606ce18', '1234565@qq.com', '2016-11-09 14:03:21', '2016-11-09 14:03:21'),
	(39, 'zhangsan', '437599f1ea3514f8969f161a6606ce18', '1234565@qq.com', '2016-11-09 14:03:21', '2016-11-09 14:03:21'),
	(40, 'zhangsan', '437599f1ea3514f8969f161a6606ce18', '1234565@qq.com', '2016-11-09 14:03:22', '2016-11-09 14:03:22'),
	(41, 'zhangsan', '437599f1ea3514f8969f161a6606ce18', '1234565@qq.com', '2016-11-09 14:03:22', '2016-11-09 14:03:22'),
	(42, 'zhangsan', '437599f1ea3514f8969f161a6606ce18', '1234565@qq.com', '2016-11-09 14:03:23', '2016-11-09 14:03:23'),
	(43, 'zhangsan', '437599f1ea3514f8969f161a6606ce18', '1234565@qq.com', '2016-11-09 14:03:23', '2016-11-09 14:03:23'),
	(44, 'zhangsan', '437599f1ea3514f8969f161a6606ce18', '1234565@qq.com', '2016-11-09 14:03:24', '2016-11-09 14:03:24'),
	(45, 'zhangsan', '437599f1ea3514f8969f161a6606ce18', '1234565@qq.com', '2016-11-09 14:03:24', '2016-11-09 14:03:24'),
	(46, 'zhangsan', '437599f1ea3514f8969f161a6606ce18', '1234565@qq.com', '2016-11-09 14:03:25', '2016-11-09 14:03:25'),
	(47, 'zhangsan', '437599f1ea3514f8969f161a6606ce18', '1234565@qq.com', '2016-11-09 14:03:26', '2016-11-09 14:03:26'),
	(48, 'zhangsan', '437599f1ea3514f8969f161a6606ce18', '1234565@qq.com', '2016-11-09 14:03:26', '2016-11-09 14:03:26'),
	(49, 'zhangsan', '437599f1ea3514f8969f161a6606ce18', '1234565@qq.com', '2016-11-09 14:03:26', '2016-11-09 14:03:26'),
	(50, 'zhangsan', '437599f1ea3514f8969f161a6606ce18', '1234565@qq.com', '2016-11-09 14:03:27', '2016-11-09 14:03:27'),
	(51, 'zhangsan', '437599f1ea3514f8969f161a6606ce18', '1234565@qq.com', '2016-11-09 14:03:27', '2016-11-09 14:03:27'),
	(52, 'zhangsan', '437599f1ea3514f8969f161a6606ce18', '1234565@qq.com', '2016-11-09 14:03:28', '2016-11-09 14:03:28'),
	(53, 'zhangsan', '437599f1ea3514f8969f161a6606ce18', '1234565@qq.com', '2016-11-09 14:03:28', '2016-11-09 14:03:28'),
	(54, 'zhangsan', '437599f1ea3514f8969f161a6606ce18', '1234565@qq.com', '2016-11-09 14:03:29', '2016-11-09 14:03:29'),
	(55, 'zhangsan', '437599f1ea3514f8969f161a6606ce18', '1234565@qq.com', '2016-11-09 14:03:29', '2016-11-09 14:03:29'),
	(56, 'zhangsan', '437599f1ea3514f8969f161a6606ce18', '1234565@qq.com', '2016-11-09 14:03:30', '2016-11-09 14:03:30'),
	(57, 'zhangsan', '437599f1ea3514f8969f161a6606ce18', '1234565@qq.com', '2016-11-09 14:03:31', '2016-11-09 14:03:31'),
	(58, 'zhangsan', '437599f1ea3514f8969f161a6606ce18', '1234565@qq.com', '2016-11-09 14:03:31', '2016-11-09 14:03:31'),
	(59, 'zhangsan', '437599f1ea3514f8969f161a6606ce18', '1234565@qq.com', '2016-11-09 14:03:32', '2016-11-09 14:03:32');
/*!40000 ALTER TABLE `sys_user` ENABLE KEYS */;


-- 导出  表 db_lte.sys_user_ref_role 结构
CREATE TABLE IF NOT EXISTS `sys_user_ref_role` (
  `user_id` int(11) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  db_lte.sys_user_ref_role 的数据：~9 rows (大约)
/*!40000 ALTER TABLE `sys_user_ref_role` DISABLE KEYS */;
REPLACE INTO `sys_user_ref_role` (`user_id`, `role_id`) VALUES
	(4, 3),
	(4, 9),
	(7, 7),
	(7, 8),
	(2, 7),
	(2, 10),
	(1, 1),
	(8, 6),
	(8, 7);
/*!40000 ALTER TABLE `sys_user_ref_role` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;

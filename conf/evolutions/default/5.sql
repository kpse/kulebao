-- phpMyAdmin SQL Dump
-- http://www.phpmyadmin.net
--
-- 生成日期: 2013 年 12 月 12 日 22:29

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- 数据库: `mosqDPLlSRIHqYPlBsPy`
--

-- --------------------------------------------------------

--
-- 表的结构 `accountinfo`
--

CREATE TABLE IF NOT EXISTS `accountinfo` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `accountid` varchar(16) COLLATE utf8_bin NOT NULL,
  `password` varchar(32) COLLATE utf8_bin NOT NULL,
  `pushid` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '',
  `active` tinyint(4) NOT NULL DEFAULT '0',
  `pwd_change_time` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `accountid` (`accountid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=4 ;

--
-- 转存表中的数据 `accountinfo`
--

INSERT INTO `accountinfo` (`uid`, `accountid`, `password`, `pushid`, `active`, `pwd_change_time`) VALUES
(1, '13402815317', '3FDE6BB0541387E4EBDADF7C2FF31123', '952021056346783736', 1, 1386425935574),
(2, '13880498549', '', '', 0, 0),
(3, '13408654680', '96E79218965EB72C92A549DD5A330112', '1144914350790965629', 1, 1386849160798);

-- --------------------------------------------------------

--
-- 表的结构 `appinfo`
--

CREATE TABLE IF NOT EXISTS `appinfo` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `version_code` int(11) NOT NULL,
  `version_name` varchar(20) COLLATE utf8_bin NOT NULL,
  `url` varchar(128) COLLATE utf8_bin NOT NULL,
  `summary` varchar(256) COLLATE utf8_bin NOT NULL,
  `file_size` bigint(20) NOT NULL,
  `release_time` datetime NOT NULL,
  PRIMARY KEY (`uid`),
  UNIQUE KEY `version_code` (`version_code`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=13 ;

--
-- 转存表中的数据 `appinfo`
--

INSERT INTO `appinfo` (`uid`, `version_code`, `version_name`, `url`, `summary`, `file_size`, `release_time`) VALUES
(1, 4, 'V1.1', '/version/LoginTest_4.apk', '1.修正错误', 12344, '2013-10-22 00:00:00'),
(9, 7, 'v1.2', '/version/LoginTest_7.apk', '1.新增功能\\n2.该版本号是7', 22345, '2013-10-23 00:00:00'),
(10, 11, 'v2.0', '/version/release-11.apk', '1.新增园内通知功能\\n2.该版本号为11', 324709, '2013-12-07 14:00:00'),
(12, 12, 'v2.1', '/version/release-12.apk', '1.新增学习内容和每日育情\\n2.该版本号为12', 324877, '2013-12-08 14:00:00');

-- --------------------------------------------------------

--
-- 表的结构 `cardinfo`
--

CREATE TABLE IF NOT EXISTS `cardinfo` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `cardnum` varchar(20) COLLATE utf8_bin NOT NULL,
  `userid` varchar(40) COLLATE utf8_bin NOT NULL,
  `expiredate` date NOT NULL DEFAULT '2200-01-01',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `cardnum` (`cardnum`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=8 ;

--
-- 转存表中的数据 `cardinfo`
--

INSERT INTO `cardinfo` (`uid`, `cardnum`, `userid`, `expiredate`) VALUES
(1, '0001234567', '2_93740362_123', '2200-01-01'),
(2, '0001234568', '2_93740362_456', '2200-01-01'),
(3, '0001234569', '2_93740362_789', '2200-01-01'),
(4, '0001234560', '2_93740362_792', '2200-01-01'),
(5, '0002234567', '3_93740362_1122', '2200-01-01'),
(6, '0003234567', '3_93740362_3344', '2200-01-01'),
(7, '0004234567', '3_93740362_9977', '2200-01-01');

-- --------------------------------------------------------

--
-- 表的结构 `childinfo`
--

CREATE TABLE IF NOT EXISTS `childinfo` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) COLLATE utf8_bin NOT NULL,
  `child_id` varchar(40) COLLATE utf8_bin NOT NULL,
  `student_id` varchar(20) COLLATE utf8_bin NOT NULL,
  `gender` tinyint(4) NOT NULL DEFAULT '2',
  `classname` varchar(40) COLLATE utf8_bin NOT NULL DEFAULT '',
  `picurl` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '',
  `birthday` date NOT NULL DEFAULT '1800-01-01',
  `indate` date NOT NULL DEFAULT '1800-01-01',
  `school_id` varchar(20) COLLATE utf8_bin NOT NULL,
  `address` varchar(200) COLLATE utf8_bin NOT NULL DEFAULT '',
  `stu_type` tinyint(4) NOT NULL DEFAULT '2',
  `hukou` tinyint(4) NOT NULL DEFAULT '2',
  `social_id` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `child_id` (`child_id`),
  KEY `birthday` (`birthday`),
  KEY `school_id` (`school_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=5 ;

--
-- 转存表中的数据 `childinfo`
--

INSERT INTO `childinfo` (`uid`, `name`, `child_id`, `student_id`, `gender`, `classname`, `picurl`, `birthday`, `indate`, `school_id`, `address`, `stu_type`, `hukou`, `social_id`) VALUES
(1, '张光', '1_93740362_374', '0032', 1, '苹果班', '', '2007-06-04', '2011-05-08', '93740362', '', 1, 1, '510107123416547856'),
(2, '李小华', '1_93740362_456', '0021', 0, '香蕉班', '', '2008-09-09', '2012-06-06', '93740362', '', 1, 1, '510107123416511111'),
(3, '王大侠', '1_93740362_9982', '322', 1, '香蕉班', '', '2007-01-01', '2011-09-03', '93740362', '', 0, 2, '510107123416523456'),
(4, '王大锤', '1_93740362_778', '323', 1, '梨儿班', '', '2007-01-01', '2011-09-03', '93740362', '', 0, 2, '510107123416523459');

-- --------------------------------------------------------

--
-- 表的结构 `employeeinfo`
--

CREATE TABLE IF NOT EXISTS `employeeinfo` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) COLLATE utf8_bin NOT NULL,
  `employee_id` varchar(40) COLLATE utf8_bin NOT NULL,
  `phone` varchar(16) COLLATE utf8_bin NOT NULL,
  `gender` tinyint(4) NOT NULL DEFAULT '2',
  `workgroup` varchar(40) COLLATE utf8_bin NOT NULL DEFAULT '',
  `workduty` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '',
  `picurl` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '',
  `birthday` date NOT NULL DEFAULT '1800-01-01',
  `school_id` varchar(20) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`uid`),
  UNIQUE KEY `phone` (`phone`),
  UNIQUE KEY `employee_id` (`employee_id`),
  KEY `birthday` (`birthday`),
  KEY `school_id` (`school_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=4 ;

--
-- 转存表中的数据 `employeeinfo`
--

INSERT INTO `employeeinfo` (`uid`, `name`, `employee_id`, `phone`, `gender`, `workgroup`, `workduty`, `picurl`, `birthday`, `school_id`) VALUES
(1, '王豫', '3_93740362_1122', '13258249821', 0, '教师组', '教师', '', '1986-06-04', '93740362'),
(2, '何忍', '3_93740362_3344', '13708089040', 0, '教师组', '教师', '', '1987-06-04', '93740362'),
(3, '富贵', '3_93740362_9977', '13060003702', 1, '保安组', '员工', '', '1982-06-04', '93740362');

-- --------------------------------------------------------

--
-- 表的结构 `parentinfo`
--

CREATE TABLE IF NOT EXISTS `parentinfo` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) COLLATE utf8_bin NOT NULL,
  `parent_id` varchar(40) COLLATE utf8_bin NOT NULL,
  `relationship` varchar(20) COLLATE utf8_bin NOT NULL,
  `phone` varchar(16) COLLATE utf8_bin NOT NULL,
  `gender` tinyint(4) NOT NULL DEFAULT '2',
  `company` varchar(200) COLLATE utf8_bin NOT NULL DEFAULT '',
  `picurl` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '',
  `birthday` date NOT NULL DEFAULT '1800-01-01',
  `school_id` varchar(20) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`uid`),
  UNIQUE KEY `parent_id` (`parent_id`),
  KEY `school_id` (`school_id`),
  KEY `phone` (`phone`),
  KEY `birthday` (`birthday`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=5 ;

--
-- 转存表中的数据 `parentinfo`
--

INSERT INTO `parentinfo` (`uid`, `name`, `parent_id`, `relationship`, `phone`, `gender`, `company`, `picurl`, `birthday`, `school_id`) VALUES
(1, '李毅', '2_93740362_123', '爸爸', '13402815317', 1, 'abcdef', '', '1800-01-01', '93740362'),
(2, '林玄', '2_93740362_456', '爸爸', '13880498549', 1, '4455hhyh', '', '1800-01-01', '93740362'),
(3, '袋鼠', '2_93740362_789', '妈妈', '13408654680', 0, '门口偶', '', '1800-01-01', '93740362'),
(4, '袋鼠', '2_93740362_792', '妈妈', '13408654680', 0, '门口偶', '', '1800-01-01', '93740362');

-- --------------------------------------------------------

--
-- 表的结构 `relationmap`
--

CREATE TABLE IF NOT EXISTS `relationmap` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `child_id` varchar(40) COLLATE utf8_bin NOT NULL,
  `parent_id` varchar(40) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`uid`),
  UNIQUE KEY `parent_id` (`parent_id`),
  KEY `child_id` (`child_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=5 ;

--
-- 转存表中的数据 `relationmap`
--

INSERT INTO `relationmap` (`uid`, `child_id`, `parent_id`) VALUES
(1, '1_93740362_374', '2_93740362_123'),
(2, '1_93740362_456', '2_93740362_456'),
(3, '1_93740362_9982', '2_93740362_789'),
(4, '1_93740362_778', '2_93740362_792');

-- --------------------------------------------------------

--
-- 表的结构 `schoolinfo`
--

CREATE TABLE IF NOT EXISTS `schoolinfo` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `school_id` varchar(20) COLLATE utf8_bin NOT NULL,
  `province` varchar(20) COLLATE utf8_bin NOT NULL,
  `city` varchar(20) COLLATE utf8_bin NOT NULL,
  `name` varchar(20) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`uid`),
  UNIQUE KEY `school_id` (`school_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=2 ;

--
-- 转存表中的数据 `schoolinfo`
--

INSERT INTO `schoolinfo` (`uid`, `school_id`, `province`, `city`, `name`) VALUES
(1, '93740362', '四川省', '成都', '成都市第三军区幼儿园');

-- --------------------------------------------------------

--
-- 表的结构 `test`
--

CREATE TABLE IF NOT EXISTS `test` (
  `id` varchar(16) DEFAULT NULL,
  `name` varchar(16) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `test`
--

INSERT INTO `test` (`id`, `name`) VALUES
('0', 'djctest');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

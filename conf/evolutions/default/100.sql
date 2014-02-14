-- phpMyAdmin SQL Dump
-- http://www.phpmyadmin.net
--
-- 生成日期: 2013 年 12 月 12 日 22:29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT = @@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS = @@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION = @@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- 数据库: `mosqDPLlSRIHqYPlBsPy`
--

-- --------------------------------------------------------

--
-- 表的结构 `accountinfo`
--

CREATE TABLE IF NOT EXISTS `accountinfo` (
  `uid`             INT(11)          NOT NULL AUTO_INCREMENT,
  `accountid`       VARCHAR(16)
                    COLLATE utf8_bin NOT NULL,
  `password`        VARCHAR(32)
                    COLLATE utf8_bin NOT NULL,
  `pushid`          VARCHAR(20)
                    COLLATE utf8_bin NOT NULL DEFAULT '',
  `active`          TINYINT(4)       NOT NULL DEFAULT '0',
  `pwd_change_time` BIGINT(20)       NOT NULL DEFAULT '0',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `accountid` (`accountid`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8
  COLLATE =utf8_bin
  AUTO_INCREMENT =4;

--
-- 转存表中的数据 `accountinfo`
--

INSERT INTO `accountinfo` (`uid`, `accountid`, `password`, `pushid`, `active`, `pwd_change_time`) VALUES
  (1, '13402815317', '3FDE6BB0541387E4EBDADF7C2FF31123', '952021056346783736', 1, 1386425935574),
  (2, '13880498549', '', '', 0, 0),
  (3, '13408654680', '96E79218965EB72C92A549DD5A330112', '1144914350790965629', 1, 1386849160798),
  (4, 'username', '5f4dcc3b5aa765d61d8327deb882cf99', '1144914350790965629', 1, 1386849160798);

-- --------------------------------------------------------

--
-- 表的结构 `appinfo`
--

CREATE TABLE IF NOT EXISTS `appinfo` (
  `uid`          INT(11)          NOT NULL AUTO_INCREMENT,
  `version_code` INT(11)          NOT NULL,
  `version_name` VARCHAR(20)
                 COLLATE utf8_bin NOT NULL,
  `url`          VARCHAR(128)
                 COLLATE utf8_bin NOT NULL,
  `summary`      VARCHAR(256)
                 COLLATE utf8_bin NOT NULL,
  `file_size`    BIGINT(20)       NOT NULL,
  `release_time` BIGINT(20)         NOT NULL,
  PRIMARY KEY (`uid`),
  UNIQUE KEY `version_code` (`version_code`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8
  COLLATE =utf8_bin
  AUTO_INCREMENT =13;

--
-- 转存表中的数据 `appinfo`
--

INSERT INTO `appinfo` (`uid`, `version_code`, `version_name`, `url`, `summary`, `file_size`, `release_time`) VALUES
  (1, 4, 'V1.1', '/version/LoginTest_4.apk', '1.修正错误', 12344, 1387649057933),
  (9, 7, 'v1.2', '/version/LoginTest_7.apk', '1.新增功能\\n2.该版本号是7', 22345, 1387649057933),
  (10, 11, 'v2.0', '/version/release-11.apk', '1.新增园内通知功能\\n2.该版本号为11', 324709, 1387649057933),
  (12, 12, 'v2.1', '/version/release-12.apk', '1.新增学习内容和每日育情\\n2.该版本号为12', 324877, 1387649057933);

-- --------------------------------------------------------

--
-- 表的结构 `cardinfo`
--

CREATE TABLE IF NOT EXISTS `cardinfo` (
  `uid`        INT(11)          NOT NULL AUTO_INCREMENT,
  `cardnum`    VARCHAR(20)
               COLLATE utf8_bin NOT NULL,
  `userid`     VARCHAR(40)
               COLLATE utf8_bin NOT NULL,
  `expiredate` DATE             NOT NULL DEFAULT '2200-01-01',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `cardnum` (`cardnum`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8
  COLLATE =utf8_bin
  AUTO_INCREMENT =8;

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
  `uid`        INT(11)          NOT NULL AUTO_INCREMENT,
  `name`       VARCHAR(20)
               COLLATE utf8_bin NOT NULL,
  `child_id`   VARCHAR(40)
               COLLATE utf8_bin NOT NULL,
  `student_id` VARCHAR(20)
               COLLATE utf8_bin NOT NULL,
  `gender`     TINYINT(4)       NOT NULL DEFAULT '2',
  `class_id`   INT(11)          NOT NULL,
  `classname`  VARCHAR(40)
               COLLATE utf8_bin NOT NULL DEFAULT '',
  `picurl`     VARCHAR(128)
               COLLATE utf8_bin NOT NULL DEFAULT '',
  `birthday`   DATE             NOT NULL DEFAULT '1800-01-01',
  `indate`     DATE             NOT NULL DEFAULT '1800-01-01',
  `school_id`  VARCHAR(20)
               COLLATE utf8_bin NOT NULL,
  `address`    VARCHAR(200)
               COLLATE utf8_bin NOT NULL DEFAULT '',
  `stu_type`   TINYINT(4)       NOT NULL DEFAULT '2',
  `hukou`      TINYINT(4)       NOT NULL DEFAULT '2',
  `social_id`  VARCHAR(20)
               COLLATE utf8_bin NOT NULL DEFAULT '',
  `nick`       VARCHAR(20)      NOT NULL DEFAULT '',
  `status`     TINYINT          NOT NULL DEFAULT 1,
  `update_at`  BIGINT           NOT NULL DEFAULT 0,
  PRIMARY KEY (`uid`),
  UNIQUE KEY `child_id` (`child_id`),
  KEY `birthday` (`birthday`),
  KEY `school_id` (`school_id`),
  KEY `nick` (`nick`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8
  COLLATE =utf8_bin
  AUTO_INCREMENT =5;

--
-- 转存表中的数据 `childinfo`
--

INSERT INTO `childinfo` (uid, name, child_id, student_id, gender, class_id, classname, picurl, birthday, indate, school_id, address, stu_type, hukou, social_id, nick, update_at)
VALUES
  (1, '张光', '1_93740362_374', '0032', 1, 777888,'苹果班', 'http://www.qqw21.com/article/uploadpic/2013-1/201311101516591.jpg',
   '2007-06-04', '2011-05-08', '93740362', '', 1, 1, '510107123416547856', '大苹果', 1387360036),
  (2, '李小华', '1_93740362_456', '0021', 0, 777999, '香蕉班', '', '2008-09-09', '2012-06-06', '93740362', '', 1, 1,
   '510107123416511111', '小苹果', 1387360036),
  (3, '王大侠', '1_93740362_9982', '322', 1, 777999, '香蕉班', 'http://img.zwbk.org/baike/spic/2010/12/01/2010120110214141_3528.jpg',
   '2007-01-01', '2011-09-03', '93740362', '', 0, 2, '510107123416523456', '小香蕉', 1387360036),
  (4, '王大锤', '1_93740362_778', '323', 1, 777666, '梨儿班', '', '2007-01-01', '2011-09-03', '93740362', '', 0, 2,
   '510107123416523459', '绿葡萄', 1387360036);

-- --------------------------------------------------------

--
-- 表的结构 `employeeinfo`
--

CREATE TABLE IF NOT EXISTS `employeeinfo` (
  `uid`         INT(11)          NOT NULL AUTO_INCREMENT,
  `name`        VARCHAR(20)
                COLLATE utf8_bin NOT NULL,
  `employee_id` VARCHAR(40)
                COLLATE utf8_bin NOT NULL,
  `phone`       VARCHAR(16)
                COLLATE utf8_bin NOT NULL,
  `gender`      TINYINT(4)       NOT NULL DEFAULT '2',
  `workgroup`   VARCHAR(40)
                COLLATE utf8_bin NOT NULL DEFAULT '',
  `workduty`    VARCHAR(20)
                COLLATE utf8_bin NOT NULL DEFAULT '',
  `picurl`      VARCHAR(128)
                COLLATE utf8_bin NOT NULL DEFAULT '',
  `birthday`    DATE             NOT NULL DEFAULT '1800-01-01',
  `school_id`   VARCHAR(20)
                COLLATE utf8_bin NOT NULL,
  `status`      TINYINT          NOT NULL DEFAULT 1,
  PRIMARY KEY (`uid`),
  UNIQUE KEY `phone` (`phone`),
  UNIQUE KEY `employee_id` (`employee_id`),
  KEY `birthday` (`birthday`),
  KEY `school_id` (`school_id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8
  COLLATE =utf8_bin
  AUTO_INCREMENT =4;

--
-- 转存表中的数据 `employeeinfo`
--

INSERT INTO `employeeinfo` (`uid`, `name`, `employee_id`, `phone`, `gender`, `workgroup`, `workduty`, `picurl`, `birthday`, `school_id`)
VALUES
  (1, '王豫', '3_93740362_1122', '13258249821', 0, '教师组', '教师', '', '1986-06-04', '93740362'),
  (2, '何忍', '3_93740362_3344', '13708089040', 0, '教师组', '教师', '', '1987-06-04', '93740362'),
  (3, '富贵', '3_93740362_9977', '13060003702', 1, '保安组', '员工', '', '1982-06-04', '93740362');

-- --------------------------------------------------------

--
-- 表的结构 `parentinfo`
--

CREATE TABLE IF NOT EXISTS `parentinfo` (
  `uid`          INT(11)          NOT NULL AUTO_INCREMENT,
  `name`         VARCHAR(20)
                 COLLATE utf8_bin NOT NULL,
  `parent_id`    VARCHAR(40)
                 COLLATE utf8_bin NOT NULL,
  `relationship` VARCHAR(20)
                 COLLATE utf8_bin NOT NULL,
  `phone`        VARCHAR(16)
                 COLLATE utf8_bin NOT NULL,
  `gender`       TINYINT(4)       NOT NULL DEFAULT '2',
  `company`      VARCHAR(200)
                 COLLATE utf8_bin NOT NULL DEFAULT '',
  `picurl`       VARCHAR(128)
                 COLLATE utf8_bin NOT NULL DEFAULT '',
  `birthday`     DATE             NOT NULL DEFAULT '1800-01-01',
  `school_id`    VARCHAR(20)
                 COLLATE utf8_bin NOT NULL,
  `status`       TINYINT          NOT NULL DEFAULT 1,
  `update_at`    BIGINT           NOT NULL DEFAULT 0,
  PRIMARY KEY (`uid`),
  UNIQUE KEY `parent_id` (`parent_id`),
  KEY `school_id` (`school_id`),
  KEY `phone` (`phone`),
  KEY `birthday` (`birthday`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8
  COLLATE =utf8_bin
  AUTO_INCREMENT =5;

--
-- 转存表中的数据 `parentinfo`
--

INSERT INTO parentinfo (uid, name, parent_id, relationship, phone, gender, company, picurl, birthday, school_id) VALUES
  (1, '李毅', '2_93740362_123', '爸爸', '13402815317', 1, 'abcdef', '', '1800-01-01', '93740362'),
  (2, '林玄', '2_93740362_456', '爸爸', '13880498549', 1, '4455hhyh', '', '1800-01-01', '93740362'),
  (3, '袋鼠', '2_93740362_789', '妈妈', '13408654680', 0, '门口偶', '', '1800-01-01', '93740362'),
  (6, '袋鼠', '2_93740362_790', '妈妈', '13408654680', 0, '门口偶', '', '1800-01-01', '93740362'),
  (4, '大象', '2_93740362_792', '妈妈', '13408654681', 0, '门口偶', '', '1800-01-01', '93740362'),
  (5, '测试', '2_93740362_999', '妈妈', '13333333333', 0, '门口偶', '', '1800-01-01', '93740362');

-- --------------------------------------------------------

--
-- 表的结构 `relationmap`
--

CREATE TABLE IF NOT EXISTS `relationmap` (
  `uid`       INT(11)          NOT NULL AUTO_INCREMENT,
  `child_id`  VARCHAR(40)
              COLLATE utf8_bin NOT NULL,
  `parent_id` VARCHAR(40)
              COLLATE utf8_bin NOT NULL,
  `card_num` VARCHAR(20)  NOT NULL,
  PRIMARY KEY (`uid`),
  UNIQUE KEY `parent_id` (`parent_id`),
  KEY `child_id` (`child_id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8
  COLLATE =utf8_bin
  AUTO_INCREMENT =5;

--
-- 转存表中的数据 `relationmap`
--

INSERT INTO `relationmap` (`uid`, `child_id`, `parent_id`) VALUES
  (1, '1_93740362_374', '2_93740362_789', '0001234567'),
  (2, '1_93740362_456', '2_93740362_456', '0001234568'),
  (3, '1_93740362_9982', '2_93740362_790', '0001234569'),
  (4, '1_93740362_778', '2_93740362_792', '0001234570');

-- --------------------------------------------------------

--
-- 表的结构 `schoolinfo`
--

CREATE TABLE IF NOT EXISTS `schoolinfo` (
  `uid`       INT(11)          NOT NULL AUTO_INCREMENT,
  `school_id` VARCHAR(20)
              COLLATE utf8_bin NOT NULL,
  `province`  VARCHAR(20)
              COLLATE utf8_bin NOT NULL,
  `city`      VARCHAR(20)
              COLLATE utf8_bin NOT NULL,
  `name`      VARCHAR(20)
              COLLATE utf8_bin NOT NULL,
  description TEXT,
  phone       VARCHAR(16)      NOT NULL,
  status      TINYINT          NOT NULL DEFAULT 1,
  logo_url    VARCHAR(256),
  update_at   BIGINT           NOT NULL,
  PRIMARY KEY (`uid`),
  UNIQUE KEY `school_id` (`school_id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8
  COLLATE =utf8_bin
  AUTO_INCREMENT =2;

--
-- 转存表中的数据 `schoolinfo`
--

INSERT INTO schoolinfo (uid, school_id, province, city, name, description, logo_url, phone, update_at) VALUES
  (1, '93740362', '四川省', '成都', '成都市第三军区幼儿园',
   '\n李刚牌土豪幼儿园，成立时间超过100年，其特点有：\n1.价格超贵\n2.硬件超好\n3.教师超屌\n4.绝不打折\n5.入园超难\n6.......\n.......\n.......\n.......\n.......\n\n',
   'http://www.jslfgz.com.cn/UploadFiles/xxgl/2013/4/201342395834.jpg',
   '13991855476', 1387353635),
  (2, '93740562', '陕西省', '西安', '西安市高新一幼',
   '\n苦逼幼儿园，成立时间超过100年，其特点有：\n1.价格超贵\n2.硬件超好\n3.教师超屌\n4.绝不打折\n5.入园超难\n6.......\n.......\n.......\n.......\n.......\n\n',
   'http://www.houstonisd.org/cms/lib2/TX01001591/Centricity/Domain/16137/crestgif.gif', '13291855476', 1387353635);

-- --------------------------------------------------------

--
-- 表的结构 `test`
--

CREATE TABLE IF NOT EXISTS `test` (
  `id`   VARCHAR(16) DEFAULT NULL,
  `name` VARCHAR(16) DEFAULT NULL
)
  ENGINE =MyISAM
  DEFAULT CHARSET =utf8;

--
-- 转存表中的数据 `test`
--

INSERT INTO `test` (`id`, `name`) VALUES
  ('0', 'djctest');

CREATE TABLE news (
  uid       INT(11)          NOT NULL AUTO_INCREMENT,
  school_id VARCHAR(20)      NOT NULL,
  title     VARCHAR(255)
            COLLATE utf8_bin NOT NULL,
  content   TEXT
            COLLATE utf8_bin,
  update_at BIGINT           NOT NULL DEFAULT 0,
  published INT              NOT NULL DEFAULT 0,
  status    TINYINT          NOT NULL DEFAULT 1,
  PRIMARY KEY (uid)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8
  COLLATE =utf8_bin
  AUTO_INCREMENT =2;

INSERT INTO news (school_id, title, content, update_at, published) VALUES
  ('93740362', '通知1',
   '缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知',
   1387353635, 1),
  ('93740362', '通知2',
   '学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电',
   1387353636, 1),
  ('93740362', '通知3',
   '恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击',
   1387353637, 0);

CREATE TABLE newsread (
  uid       INT(11)     NOT NULL AUTO_INCREMENT,
  school_id VARCHAR(20) NOT NULL,
  parent_id VARCHAR(40) NOT NULL,
  news_id   INT(11)     NOT NULL,
  readTime  INT(11)     NOT NULL DEFAULT 0,
  PRIMARY KEY (uid)
);


CREATE TABLE classinfo (
  uid        INT(11)          NOT NULL AUTO_INCREMENT,
  school_id    VARCHAR(20)      NOT NULL,
  class_id    INT(11)  NOT NULL,
  class_name     VARCHAR(40) COLLATE utf8_bin NOT NULL,
  update_at BIGINT(20)             NOT NULL DEFAULT 0,
  PRIMARY KEY (uid)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8
  COLLATE =utf8_bin
  AUTO_INCREMENT =2;

--
-- 转存表中的数据 classinfo
--

INSERT INTO classinfo (school_id, class_id, class_name) VALUES
  ('93740362', 777888, '苹果班'),
  ('93740362', 777999, '香蕉班'),
  ('93740362', 777666, '梨儿班');


-- --------------------------------------------------------

--
-- 表的结构 cookbookinfo
--

CREATE TABLE cookbookinfo (
  uid        INT(11)          NOT NULL AUTO_INCREMENT,
  school_id    VARCHAR(20)  NOT NULL,
  cookbook_id    INT(11)  NOT NULL,
  mon_breakfast    VARCHAR(40) COLLATE utf8_bin DEFAULT '',
  tue_breakfast    VARCHAR(40) COLLATE utf8_bin DEFAULT '',
  wed_breakfast    VARCHAR(40) COLLATE utf8_bin DEFAULT '',
  thu_breakfast    VARCHAR(40) COLLATE utf8_bin DEFAULT '',
  fri_breakfast    VARCHAR(40) COLLATE utf8_bin DEFAULT '',
  mon_lunch    VARCHAR(40) COLLATE utf8_bin DEFAULT '',
  tue_lunch    VARCHAR(40) COLLATE utf8_bin DEFAULT '',
  wed_lunch    VARCHAR(40) COLLATE utf8_bin DEFAULT '',
  thu_lunch    VARCHAR(40) COLLATE utf8_bin DEFAULT '',
  fri_lunch    VARCHAR(40) COLLATE utf8_bin DEFAULT '',
  mon_dinner    VARCHAR(40) COLLATE utf8_bin DEFAULT '',
  tue_dinner    VARCHAR(40) COLLATE utf8_bin DEFAULT '',
  wed_dinner    VARCHAR(40) COLLATE utf8_bin DEFAULT '',
  thu_dinner    VARCHAR(40) COLLATE utf8_bin DEFAULT '',
  fri_dinner    VARCHAR(40) COLLATE utf8_bin DEFAULT '',
  mon_extra    VARCHAR(40) COLLATE utf8_bin DEFAULT '',
  tue_extra    VARCHAR(40) COLLATE utf8_bin DEFAULT '',
  wed_extra    VARCHAR(40) COLLATE utf8_bin DEFAULT '',
  thu_extra    VARCHAR(40) COLLATE utf8_bin DEFAULT '',
  fri_extra    VARCHAR(40) COLLATE utf8_bin DEFAULT '',
  extra_tip     TEXT COLLATE utf8_bin NOT NULL,
  status     INT default 0,
  timestamp BIGINT(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (uid)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8
  COLLATE =utf8_bin
  AUTO_INCREMENT =2;

--
-- 转存表中的数据 cookbookinfo
--

INSERT INTO cookbookinfo (school_id, cookbook_id, extra_tip, mon_breakfast,
                          tue_breakfast, wed_breakfast, thu_breakfast, fri_breakfast, mon_lunch, tue_lunch
  , wed_lunch, thu_lunch, fri_lunch, mon_dinner, tue_dinner, wed_dinner, thu_dinner,
                          fri_dinner, mon_extra, tue_extra, wed_extra, thu_extra, fri_extra) VALUES
  ('93740362', 123, '陷好皮薄',
   '荷包蛋，鹌鹑蛋，牛肉饼', '啤酒，鹌鹑蛋，牛肉饼', '咖啡，鹌鹑蛋，牛肉饼', '臭豆腐，鹌鹑蛋，牛肉饼', '二锅头，鹌鹑蛋，牛肉饼',
   '兰州拉面，京酱肉丝', '兰州拉面，京酱肉丝', '兰州拉面，京酱肉丝', '兰州拉面，京酱肉丝', '兰州拉面，京酱肉丝',
   '土豆西红柿，野菜炖蘑菇', '啤酒，鹌鹑蛋，牛肉饼', '兰州拉面，京酱肉丝', '土豆西红柿，野菜炖蘑菇', '土豆西红柿，野菜炖蘑菇',
   '兰州烧饼', '兰州烧饼', '兰州烧饼', '兰州烧饼', '兰州烧饼');

CREATE TABLE scheduleinfo (
  uid        INT(11)          NOT NULL AUTO_INCREMENT,
  school_id    VARCHAR(20)  NOT NULL,
  class_id    INT(11)  NOT NULL,
  schedule_id    INT(11)  NOT NULL,
  mon_am    VARCHAR(40) COLLATE utf8_bin DEFAULT '',
  tue_am    VARCHAR(40) COLLATE utf8_bin DEFAULT '',
  wed_am    VARCHAR(40) COLLATE utf8_bin DEFAULT '',
  thu_am    VARCHAR(40) COLLATE utf8_bin DEFAULT '',
  fri_am    VARCHAR(40) COLLATE utf8_bin DEFAULT '',
  mon_pm    VARCHAR(40) COLLATE utf8_bin DEFAULT '',
  tue_pm    VARCHAR(40) COLLATE utf8_bin DEFAULT '',
  wed_pm    VARCHAR(40) COLLATE utf8_bin DEFAULT '',
  thu_pm    VARCHAR(40) COLLATE utf8_bin DEFAULT '',
  fri_pm    VARCHAR(40) COLLATE utf8_bin DEFAULT '',
  status     INT default 1,
  timestamp BIGINT(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (uid)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8
  COLLATE =utf8_bin
  AUTO_INCREMENT =2;

INSERT INTO scheduleinfo (school_id, class_id, schedule_id, mon_am,
                          tue_am, wed_am, thu_am, fri_am, mon_pm, tue_pm
  , wed_pm, thu_pm, fri_pm, status) VALUES
  ('93740362', 777666, 121,
   '手工水蜜桃', '木工', '电工', '钳工', '车工',
   '语文', '数学', '化学', '政治', '历史', 1),
  ('93740362', 777888,123,
   '手工大闸蟹', '木工', '电工', '钳工', '车工',
   '语文', '数学', '化学', '政治', '历史', 1),
  ('93740362', 777999,125,
   '手工西瓜', '木工', '电工', '钳工', '车工',
   '语文', '数学', '化学', '政治', '历史', 1);

CREATE TABLE feedback (
  uid         INT(11)          NOT NULL AUTO_INCREMENT,
  phone       VARCHAR(16) NOT NULL,
  content     TEXT COLLATE utf8_bin,
  comment     TEXT COLLATE utf8_bin,
  status     TINYINT          NOT NULL DEFAULT 1,
  update_at   BIGINT(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (uid)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8
  COLLATE =utf8_bin
  AUTO_INCREMENT =2;


CREATE TABLE dailylog (
  uid         INT(11)          NOT NULL AUTO_INCREMENT,
  school_id   VARCHAR(20) NOT NULL,
  child_id varchar(40) NOT NULL,
  pushid   varchar(20) NOT NULL,
  record_url TEXT DEFAULT '',
  card_no varchar(20) NOT NULL,
  card_type INT DEFAULT 0,
  notice_type INT DEFAULT 0,
  check_at   BIGINT(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (uid),
  KEY `check_at` (`check_at`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8
  COLLATE =utf8_bin
  AUTO_INCREMENT =2;


/*!40101 SET CHARACTER_SET_CLIENT = @OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS = @OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION = @OLD_COLLATION_CONNECTION */;

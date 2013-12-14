# --- !Ups

CREATE TABLE childinfo (
  uid int(11) NOT NULL AUTO_INCREMENT,
  name varchar(20) NOT NULL,
  child_id varchar(40) NOT NULL,
  student_id varchar(20) NOT NULL,
  gender tinyint(4) NOT NULL DEFAULT '2',
  classname varchar(40) NOT NULL DEFAULT '',
  picurl varchar(128) NOT NULL DEFAULT '',
  birthday date NOT NULL DEFAULT '1800-01-01',
  indate date NOT NULL DEFAULT '1800-01-01',
  school_id varchar(20) NOT NULL,
  address varchar(200) NOT NULL DEFAULT '',
  stu_type tinyint(4) NOT NULL DEFAULT '2',
  hukou tinyint(4) NOT NULL DEFAULT '2',
  social_id varchar(20) NOT NULL DEFAULT ''  ,
  PRIMARY KEY (uid)
);

--
-- 转存表中的数据 childinfo
--

INSERT INTO childinfo (uid, name, child_id, student_id, gender, classname, picurl, birthday, indate, school_id, address, stu_type, hukou, social_id) VALUES
(1, '张光', '1_93740362_374', '0032', 1, '苹果班', '', '2007-06-04', '2011-05-08', '93740362', '', 1, 1, '510107123416547856'),
(2, '李小华', '1_93740362_456', '0021', 0, '香蕉班', '', '2008-09-09', '2012-06-06', '93740362', '', 1, 1, '510107123416511111'),
(3, '王大侠', '1_93740362_9982', '322', 1, '香蕉班', '', '2007-01-01', '2011-09-03', '93740362', '', 0, 2, '510107123416523456'),
(4, '王大锤', '1_93740362_778', '323', 1, '梨儿班', '', '2007-01-01', '2011-09-03', '93740362', '', 0, 2, '510107123416523459');

# --- !Downs

DROP TABLE IF EXISTS childinfo;

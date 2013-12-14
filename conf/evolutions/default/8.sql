# --- !Ups

CREATE TABLE parentinfo (
  uid          INT(11)      NOT NULL AUTO_INCREMENT,
  name         VARCHAR(20)  NOT NULL,
  parent_id    VARCHAR(40)  NOT NULL,
  relationship VARCHAR(20)  NOT NULL,
  phone        VARCHAR(16)  NOT NULL,
  gender       TINYINT(4)   NOT NULL DEFAULT '2',
  company      VARCHAR(200) NOT NULL DEFAULT '',
  picurl       VARCHAR(128) NOT NULL DEFAULT '',
  birthday     DATE         NOT NULL DEFAULT '1800-01-01',
  school_id    VARCHAR(20)  NOT NULL,
  PRIMARY KEY (uid)
);

--
-- 转存表中的数据 parentinfo
--

INSERT INTO parentinfo (uid, name, parent_id, relationship, phone, gender, company, picurl, birthday, school_id) VALUES
  (1, '李毅', '2_93740362_123', '爸爸', '13402815317', 1, 'abcdef', '', '1800-01-01', '93740362'),
  (2, '林玄', '2_93740362_456', '爸爸', '13880498549', 1, '4455hhyh', '', '1800-01-01', '93740362'),
  (3, '袋鼠', '2_93740362_789', '妈妈', '13408654680', 0, '门口偶', '', '1800-01-01', '93740362'),
  (4, '袋鼠', '2_93740362_792', '妈妈', '13408654680', 0, '门口偶', '', '1800-01-01', '93740362'),
  (5, '测试', '2_93740362_999', '妈妈', 'username', 0, '门口偶', '', '1800-01-01', '93740362');

# --- !Downs

DROP TABLE IF EXISTS parentinfo;
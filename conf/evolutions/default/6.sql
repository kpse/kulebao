# --- !Ups

CREATE TABLE parentinfo (
  uid          INT(11)      NOT NULL AUTO_INCREMENT,
  name         VARCHAR(20)  NOT NULL,
  parent_id    VARCHAR(40)  NOT NULL,
  relationship VARCHAR(20)  NOT NULL,
  phone        VARCHAR(16)  NOT NULL,
  gender       INT   NOT NULL DEFAULT 2,
  company      VARCHAR(200) NOT NULL DEFAULT '',
  picurl       VARCHAR(128) NOT NULL DEFAULT '',
  birthday     DATE         NOT NULL DEFAULT '1800-01-01',
  school_id    VARCHAR(20)  NOT NULL,
  status       TINYINT      NOT NULL DEFAULT 1,
  update_at       BIGINT      NOT NULL DEFAULT 0,
  PRIMARY KEY (uid)
);

--
-- 转存表中的数据 parentinfo
--

INSERT INTO parentinfo (uid, name, parent_id, relationship, phone, gender, company, picurl, birthday, school_id) VALUES
  (1, '李毅', '2_93740362_123', '', '13402815317', 1, 'abcdef', '', '1800-01-01', '93740362'),
  (2, '林玄', '2_93740362_456', '', '13880498549', 1, '4455hhyh', '', '1800-01-01', '93740362'),
  (3, '袋鼠', '2_93740362_789', '', '13408654680', 0, '门口偶', '', '1800-01-01', '93740362'),
  (6, '老虎', '2_93740362_790', '', '13408654683', 0, '门口偶', '', '1800-01-01', '93740362'),
  (4, '大象', '2_93740362_792', '', '13408654681', 0, '门口偶', '', '1800-01-01', '93740362'),
  (7, '洁师', '2_93740362_888', '', '13279491366', 0, '门口偶', '', '1800-01-01', '93740362'),
  (5, '测试', '2_93740362_999', '', '13333333333', 0, '门口偶', '', '1800-01-01', '93740362');

# --- !Downs

DROP TABLE IF EXISTS parentinfo;
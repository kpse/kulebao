# --- !Ups
-- --------------------------------------------------------

--
-- 表的结构 cardinfo
--

CREATE TABLE cardinfo (
  uid        INT(11)          NOT NULL AUTO_INCREMENT,
  cardnum    VARCHAR(20)  NOT NULL,
  userid     VARCHAR(40) NOT NULL,
  expiredate DATE             NOT NULL DEFAULT '2200-01-01',
  PRIMARY KEY (uid)
);

--
-- 转存表中的数据 cardinfo
--

INSERT INTO cardinfo (uid, cardnum, userid, expiredate) VALUES
  (1, '0001234567', '2_93740362_123', '2200-01-01'),
  (2, '0001234568', '2_93740362_456', '2200-01-01'),
  (3, '0001234569', '2_93740362_789', '2200-01-01'),
  (4, '0001234560', '2_93740362_792', '2200-01-01'),
  (5, '0002234567', '3_93740362_1122', '2200-01-01'),
  (6, '0003234567', '3_93740362_3344', '2200-01-01'),
  (7, '0004234567', '3_93740362_9977', '2200-01-01');

# --- !Downs

DROP TABLE IF EXISTS cardinfo;
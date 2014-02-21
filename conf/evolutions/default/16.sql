# --- !Ups
-- --------------------------------------------------------

--
-- 表的结构 conversation
--

CREATE TABLE conversation (
  uid         INT(11)          NOT NULL AUTO_INCREMENT,
  school_id   VARCHAR(20) NOT NULL,
  phone        VARCHAR(16)  NOT NULL,
  content   TEXT NOT NULL,
  image TEXT DEFAULT '',
  sender VARCHAR(20) NOT NULL DEFAULT '',
  timestamp BIGINT(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (uid)
);

INSERT INTO conversation (school_id, phone, content, image, sender, timestamp)
VALUES
('93740362', '13408654680', '老师你好。', 'http://suoqin-test.u.qiniudn.com/FgPmIcRG6BGocpV1B9QMCaaBQ9LK', '', 12312313123),
('93740362', '13408654680', '家长你好。', 'http://suoqin-test.u.qiniudn.com/Fget0Tx492DJofAy-ZeUg1SANJ4X', '老师A', 12313313123),
('93740362', '13408654680', '老师再见。', 'http://suoqin-test.u.qiniudn.com/FgPmIcRG6BGocpV1B9QMCaaBQ9LK', '', 12314313123);


# --- !Downs

DROP TABLE IF EXISTS conversation;
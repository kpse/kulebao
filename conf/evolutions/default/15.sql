# --- !Ups
-- --------------------------------------------------------

--
-- 表的结构 dailylog
--

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
  PRIMARY KEY (uid)
);

# --- !Downs

DROP TABLE IF EXISTS dailylog;
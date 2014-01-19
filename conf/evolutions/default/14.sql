# --- !Ups
-- --------------------------------------------------------

--
-- 表的结构 feedback
--

CREATE TABLE feedback (
  uid         INT(11)          NOT NULL AUTO_INCREMENT,
  phone       VARCHAR(16) NOT NULL,
  content     TEXT,
  update_at   BIGINT(20),
  PRIMARY KEY (uid)
);

# --- !Downs

DROP TABLE IF EXISTS feedback;
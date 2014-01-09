# --- !Ups
-- --------------------------------------------------------

--
-- 表的结构 classinfo
--

CREATE TABLE classinfo (
  uid        INT(11)          NOT NULL AUTO_INCREMENT,
  school_id    VARCHAR(20)  NOT NULL,
  class_id    INT(11)  NOT NULL,
  class_name     VARCHAR(40) NOT NULL,
  update_at BIGINT(20)             NOT NULL DEFAULT 0,
  PRIMARY KEY (uid)
);

--
-- 转存表中的数据 classinfo
--

INSERT INTO classinfo (school_id, class_id, class_name) VALUES
  ('93740362', 777888, '苹果班'),
  ('93740362', 777999, '香蕉班'),
  ('93740362', 777666, '梨儿班');

# --- !Downs

DROP TABLE IF EXISTS classinfo;
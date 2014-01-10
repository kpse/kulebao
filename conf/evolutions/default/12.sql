# --- !Ups
-- --------------------------------------------------------

--
-- 表的结构 scheduleinfo
--

CREATE TABLE scheduleinfo (
  uid        INT(11)          NOT NULL AUTO_INCREMENT,
  school_id    VARCHAR(20)  NOT NULL,
  class_id    INT(11)  NOT NULL,
  schedule_id    INT(11)  NOT NULL,
  mon_am    VARCHAR(40) DEFAULT '',
  tue_am    VARCHAR(40) DEFAULT '',
  wed_am    VARCHAR(40) DEFAULT '',
  thu_am    VARCHAR(40) DEFAULT '',
  fri_am    VARCHAR(40) DEFAULT '',
  mon_pm    VARCHAR(40) DEFAULT '',
  tue_pm    VARCHAR(40) DEFAULT '',
  wed_pm    VARCHAR(40) DEFAULT '',
  thu_pm    VARCHAR(40) DEFAULT '',
  fri_pm    VARCHAR(40) DEFAULT '',
  status     INT default 1,
  timestamp BIGINT(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (uid)
);

--
-- 转存表中的数据 scheduleinfo
--

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

# --- !Downs

DROP TABLE IF EXISTS scheduleinfo;
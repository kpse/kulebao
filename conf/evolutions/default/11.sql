# --- !Ups
-- --------------------------------------------------------

--
-- 表的结构 cookbookinfo
--

CREATE TABLE cookbookinfo (
  uid        INT(11)          NOT NULL AUTO_INCREMENT,
  school_id    VARCHAR(20)  NOT NULL,
  cookbook_id    INT(11)  NOT NULL,
  mon_breakfast    VARCHAR(40) DEFAULT '',
  tue_breakfast    VARCHAR(40) DEFAULT '',
  wed_breakfast    VARCHAR(40) DEFAULT '',
  thu_breakfast    VARCHAR(40) DEFAULT '',
  fri_breakfast    VARCHAR(40) DEFAULT '',
  mon_lunch    VARCHAR(40) DEFAULT '',
  tue_lunch    VARCHAR(40) DEFAULT '',
  wed_lunch    VARCHAR(40) DEFAULT '',
  thu_lunch    VARCHAR(40) DEFAULT '',
  fri_lunch    VARCHAR(40) DEFAULT '',
  mon_dinner    VARCHAR(40) DEFAULT '',
  tue_dinner    VARCHAR(40) DEFAULT '',
  wed_dinner    VARCHAR(40) DEFAULT '',
  thu_dinner    VARCHAR(40) DEFAULT '',
  fri_dinner    VARCHAR(40) DEFAULT '',
  mon_extra    VARCHAR(40) DEFAULT '',
  tue_extra    VARCHAR(40) DEFAULT '',
  wed_extra    VARCHAR(40) DEFAULT '',
  thu_extra    VARCHAR(40) DEFAULT '',
  fri_extra    VARCHAR(40) DEFAULT '',
  extra_tip     TEXT NOT NULL,
  status     INT default 1,
  timestamp BIGINT(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (uid)
);

--
-- 转存表中的数据 cookbookinfo
--

INSERT INTO cookbookinfo (school_id, cookbook_id, extra_tip, mon_breakfast,
tue_breakfast, wed_breakfast, thu_breakfast, fri_breakfast, mon_lunch, tue_lunch
, wed_lunch, thu_lunch, fri_lunch, mon_dinner, tue_dinner, wed_dinner, thu_dinner,
fri_dinner, mon_extra, tue_extra, wed_extra, thu_extra, fri_extra, status) VALUES
  ('93740362', 121, '陷好皮薄',
  '三聚氰胺', '二噁英', '炭疽', '霉菌', '要你命三千',
  '兰州拉面，京酱肉丝', '兰州拉面，京酱肉丝', '兰州拉面，京酱肉丝', '兰州拉面，京酱肉丝', '兰州拉面，京酱肉丝',
  '土豆西红柿，野菜炖蘑菇', '啤酒，鹌鹑蛋，牛肉饼', '兰州拉面，京酱肉丝', '土豆西红柿，野菜炖蘑菇', '土豆西红柿，野菜炖蘑菇',
  '兰州烧饼', '兰州烧饼', '兰州烧饼', '兰州烧饼', '兰州烧饼', 0),
  ('93740362', 123, '陷好皮薄',
  '荷包蛋，鹌鹑蛋，牛肉饼', '啤酒，鹌鹑蛋，牛肉饼', '咖啡，鹌鹑蛋，牛肉饼', '臭豆腐，鹌鹑蛋，牛肉饼', '二锅头，鹌鹑蛋，牛肉饼',
  '兰州拉面，京酱肉丝', '兰州拉面，京酱肉丝', '兰州拉面，京酱肉丝', '兰州拉面，京酱肉丝', '兰州拉面，京酱肉丝',
  '土豆西红柿，野菜炖蘑菇', '啤酒，鹌鹑蛋，牛肉饼', '兰州拉面，京酱肉丝', '土豆西红柿，野菜炖蘑菇', '土豆西红柿，野菜炖蘑菇',
  '兰州烧饼', '兰州烧饼', '兰州烧饼', '兰州烧饼', '兰州烧饼', 1);

# --- !Downs

DROP TABLE IF EXISTS cookbookinfo;
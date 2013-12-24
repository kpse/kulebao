# --- !Ups
--
-- 表的结构 appinfo
--

CREATE TABLE appinfo (
  uid          INT(11)          NOT NULL AUTO_INCREMENT,
  version_code INT(11)          NOT NULL,
  version_name VARCHAR(20) NOT NULL,
  url          VARCHAR(128) NOT NULL,
  summary      VARCHAR(256) NOT NULL,
  file_size    BIGINT(20)       NOT NULL,
  release_time  BIGINT(20)        NOT NULL,
  PRIMARY KEY (uid)
);

--
-- 转存表中的数据 appinfo
--

INSERT INTO appinfo (uid, version_code, version_name, url, summary, file_size, release_time) VALUES
  (1, 4, 'V1.1', '/version/LoginTest_4.apk', '1.修正错误', 12344, 1387649057933),
  (9, 7, 'v1.2', '/version/LoginTest_7.apk', '1.新增功能\\n2.该版本号是7', 22345, 1387649057933),
  (10, 11, 'v2.0', '/version/release-11.apk', '1.新增园内通知功能\\n2.该版本号为11', 324709, 1387649057933),
  (12, 12, 'v2.1', '/version/release-12.apk', '1.新增学习内容和每日育情\\n2.该版本号为12', 324877, 1387649057933);


# --- !Downs

DROP TABLE IF EXISTS appinfo;
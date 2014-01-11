# --- !Ups
-- --------------------------------------------------------

--
-- 表的结构 scheduleinfo
--

CREATE TABLE employeeinfo (
  uid         INT(11)          NOT NULL AUTO_INCREMENT,
  name        VARCHAR(20) NOT NULL,
  employee_id VARCHAR(40) NOT NULL,
  phone       VARCHAR(16) NOT NULL,
  gender      INT       NOT NULL DEFAULT 2,
  workgroup   VARCHAR(40) NOT NULL DEFAULT '',
  workduty    VARCHAR(20) NOT NULL DEFAULT '',
  picurl      VARCHAR(128) NOT NULL DEFAULT '',
  birthday    DATE             NOT NULL DEFAULT '1800-01-01',
  school_id   VARCHAR(20) NOT NULL,
  status      TINYINT          NOT NULL DEFAULT 1,
  PRIMARY KEY (uid),
  UNIQUE KEY phone (phone)
);

--
-- 转存表中的数据 employeeinfo
--

INSERT INTO employeeinfo (uid, name, employee_id, phone, gender, workgroup, workduty, picurl, birthday, school_id)
VALUES
  (1, '王豫', '3_93740362_1122', '13258249821', 0, '教师组', '教师', '', '1986-06-04', '93740362'),
  (2, '何忍', '3_93740362_3344', '13708089040', 0, '教师组', '教师', '', '1987-06-04', '93740362'),
  (3, '富贵', '3_93740362_9977', '13060003702', 1, '保安组', '员工', '', '1982-06-04', '93740362');

# --- !Downs

DROP TABLE IF EXISTS employeeinfo;
--
-- 表的结构 relationmap
--
# --- !Ups

CREATE TABLE relationmap (
  uid int(11) NOT NULL AUTO_INCREMENT,
  child_id varchar(40) NOT NULL,
  parent_id varchar(40) NOT NULL,
  card_num VARCHAR(20)  NOT NULL,
  PRIMARY KEY (uid)
);

--
-- 转存表中的数据 relationmap
--

INSERT INTO relationmap (uid, child_id, parent_id, card_num) VALUES
(1, '1_93740362_374', '2_93740362_789', '0001234567'),
(2, '1_93740362_456', '2_93740362_456', '0001234568'),
(3, '1_93740362_9982', '2_93740362_790', '0001234569'),
(4, '1_93740362_778', '2_93740362_792', '0001234570');


# --- !Downs

DROP TABLE IF EXISTS relationmap;
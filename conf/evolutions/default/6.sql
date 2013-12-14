# --- !Ups

CREATE TABLE schoolinfo (
  uid int(11) NOT NULL AUTO_INCREMENT,
  school_id varchar(20) NOT NULL,
  province varchar(20) NOT NULL,
  city varchar(20) NOT NULL,
  name varchar(20) NOT NULL,
  PRIMARY KEY (uid)
);

INSERT INTO schoolinfo (uid, school_id, province, city, name) VALUES
(1, '93740362', '四川省', '成都', '成都市第三军区幼儿园');

# --- !Downs

DROP TABLE IF EXISTS schoolinfo;

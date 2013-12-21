# --- !Ups

CREATE TABLE newsread (
  uid       INT(11)     NOT NULL AUTO_INCREMENT,
  school_id VARCHAR(20) NOT NULL,
  parent_id VARCHAR(40) NOT NULL,
  news_id   INT(11)     NOT NULL,
  readTime  BIGINT        NOT NULL DEFAULT 0,
  PRIMARY KEY (uid)
);

# --- !Downs

DROP TABLE IF EXISTS newsread;
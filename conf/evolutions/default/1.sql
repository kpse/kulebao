# --- !Ups

CREATE TABLE kindergarten (
  id   SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  title VARCHAR(255) NOT NULL
);

INSERT INTO kindergarten (name, title) values ('school23', '成都市第二十三幼儿园');
INSERT INTO kindergarten (name, title) values ('school1', '西安电子科技大学');
INSERT INTO kindergarten (name, title) values ('school2', '清华池');
# --- !Downs

DROP TABLE IF EXISTS kindergarten;
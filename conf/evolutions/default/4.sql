# --- !Ups

CREATE TABLE newsRead (
  id   SERIAL PRIMARY KEY,
  k_id   INT NOT NULL,
  parent_id   INT NOT NULL,
  news_id   INT,
  readTime DATE         NOT NULL
);

INSERT INTO newsRead (k_id, parent_id, news_id, readTime) values (1, 1, 1, '1998-10-10');
INSERT INTO newsRead (k_id, parent_id, news_id, readTime) values (1, 1, 2, '1998-10-10');
INSERT INTO newsRead (k_id, parent_id, news_id, readTime) values (1, 3, 1, '1998-10-10');

# --- !Downs

DROP TABLE IF EXISTS newsRead;
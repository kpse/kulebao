# --- !Ups

CREATE TABLE newsRead (
  id   SERIAL PRIMARY KEY,
  k_id   INT NOT NULL,
  parent_id   INT NOT NULL,
  news_id   INT
);

INSERT INTO newsRead (k_id, parent_id, news_id) values (1, 1, 1);
INSERT INTO newsRead (k_id, parent_id, news_id) values (1, 1, 2);
INSERT INTO newsRead (k_id, parent_id, news_id) values (1, 3, 1);

# --- !Downs

DROP TABLE IF EXISTS newsRead;
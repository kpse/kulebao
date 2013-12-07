# --- !Ups

CREATE TABLE newsRead (
  id   SERIAL PRIMARY KEY,
  k_id   INT NOT NULL,
  parent_id   INT NOT NULL,
  news_id   INT,
  readTime DATE         NOT NULL
);

# --- !Downs

DROP TABLE IF EXISTS newsRead;
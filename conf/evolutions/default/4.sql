# --- !Ups

CREATE TABLE newsRead (
  id        SERIAL PRIMARY KEY,
  k_id      LONG NOT NULL,
  parent_id LONG NOT NULL,
  news_id   LONG,
  readTime  DATE NOT NULL
);

# --- !Downs

DROP TABLE IF EXISTS newsRead;
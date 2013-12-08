# --- !Ups

CREATE TABLE parent (
  id       SERIAL PRIMARY KEY,
  k_id     LONG         NOT NULL,
  child_id INT          NOT NULL,
  name     VARCHAR(255) NOT NULL,
  desc     VARCHAR(255) NOT NULL
);

INSERT INTO parent (k_id, child_id, name, desc) VALUES (1, 1, '你爸', '圆圆家长');
INSERT INTO parent (k_id, child_id, name, desc) VALUES (1, 2, '尼玛', '土豆家长');
INSERT INTO parent (k_id, child_id, name, desc) VALUES (1, 3, '你妹', '地瓜家长');

# --- !Downs

DROP TABLE IF EXISTS parent;
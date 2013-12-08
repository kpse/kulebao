# --- !Ups

CREATE TABLE news (
  id        SERIAL PRIMARY KEY,
  k_id      INT          NOT NULL,
  title     VARCHAR(255) NOT NULL,
  content   TEXT         NOT NULL,
  issueDate DATE         NOT NULL
);

INSERT INTO news (k_id, title, content, issueDate) VALUES (1, '通知1',
                                                           '缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知缴费通知',
                                                           '2013-10-01');
INSERT INTO news (k_id, title, content, issueDate) VALUES (1, '通知2',
                                                           '学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电学校停电',
                                                           '2013-1-01');
INSERT INTO news (k_id, title, content, issueDate) VALUES (1, '通知3',
                                                           '恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击恐怖分子袭击',
                                                           '2012-10-01');

# --- !Downs

DROP TABLE IF EXISTS news;
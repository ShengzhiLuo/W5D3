PRAGMA foreign_keys
= ON;

CREATE TABLE users
(
  id INTEGER PRIMARY KEY,
  fname TEXT NOT NULL,
  lname TEXT NOT NULL
);

CREATE TABLE questions
(
  question_id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  author TEXT NOT NULL,
  FOREIGN KEY (author) REFERENCES users(id)
);

CREATE TABLE question_follows
(
  follows_id INTEGER PRIMARY KEY,
  question_id INTEGER,
  users_id INTEGER,

  FOREIGN KEY (question_id) REFERENCES questions(question_id)
  FOREIGN KEY
  (users_id) REFERENCES users
  (id)
);

  CREATE TABLE replies
  (
    reply_id INTEGER PRIMARY KEY,
    subject_question INTEGER NOT NULL,
    parent_reply INTEGER,
    user_reply INTEGER,
    body TEXT,

    FOREIGN KEY(subject_question) REFERENCES questions(question_id)
    FOREIGN KEY
    (parent_reply) REFERENCES replies
    (reply_id)
  FOREIGN KEY
    (user_reply) REFERENCES users
    (id)
);

    CREATE TABLE question_likes
    (
      like_id INTEGER PRIMARY KEY,
      like_user INTEGER,
      like_question INTEGER,
      like_val BOOLEAN,

      FOREIGN KEY (like_user) REFERENCES users(id)
      FOREIGN KEY
      (like_question) REFERENCES questions
      (question_id)
);

      INSERT INTO
  users
        (fname, lname)
      VALUES
        ('Tara', 'O'),
        ('Shengzhi', 'Luo');

      INSERT INTO
  questions
        (title, body, author)
      VALUES
        ('Lunch', 'When is lunch?', (SELECT id
          FROM users
          WHERE fname = 'Tara' AND lname = 'O')),
        ('Dinner', 'What for dinner?', (SELECT id
          FROM users
          WHERE fname = 'Shengzhi' AND lname = 'Luo'));

      INSERT INTO
    replies
        (subject_question, parent_reply, user_reply, body)
      VALUES
        ((SELECT question_id
          FROM questions
          WHERE title = 'Lunch'), NULL, (SELECT id
          FROM users
          WHERE fname = 'Tara' AND lname = 'O'), 'Lunch as always starts at 12:15pm'),
        ((SELECT question_id
          FROM questions
          WHERE title = 'Dinner') , NULL, (SELECT id
          FROM users
          WHERE fname = 'Shengzhi' AND lname = 'Luo'), 'Noodles');

      INSERT INTO
  question_likes
        (like_user, like_question, like_val)
      VALUES
        ((SELECT id
          FROM users
          WHERE fname = 'Tara' AND lname = 'O'), (SELECT question_id
          FROM questions
          WHERE title = 'Lunch'), TRUE),
        ((SELECT id
          FROM users
          WHERE fname = 'Shengzhi' AND lname = 'Luo'), (SELECT question_id
          FROM questions
          WHERE title = 'Dinner'), FALSE);




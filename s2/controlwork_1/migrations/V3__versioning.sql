CREATE TABLE exam_mvcc_items (
                                 id BIGSERIAL PRIMARY KEY,
                                 title TEXT NOT NULL,
                                 qty INTEGER NOT NULL
);

INSERT INTO exam_mvcc_items (title, qty) VALUES
                                             ('Keyboard', 10),
                                             ('Mouse', 20),
                                             ('Monitor', 5);

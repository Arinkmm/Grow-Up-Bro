CREATE TABLE exam_lock_items (
                                 id BIGSERIAL PRIMARY KEY,
                                 title TEXT NOT NULL,
                                 qty INTEGER NOT NULL
);

INSERT INTO exam_lock_items (title, qty) VALUES
                                             ('SSD', 7),
                                             ('RAM', 15);
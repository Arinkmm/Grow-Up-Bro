CREATE TABLE exam_events (
                             id BIGSERIAL PRIMARY KEY,
                             user_id INTEGER NOT NULL,
                             status TEXT NOT NULL,
                             amount NUMERIC(10,2) NOT NULL,
                             created_at TIMESTAMP NOT NULL,
                             payload TEXT
);

INSERT INTO exam_events (user_id, status, amount, created_at, payload)
SELECT
    ((g * 37) % 5000) + 1,
    CASE
    WHEN g % 10 = 0 THEN 'cancelled'
    WHEN g % 3 = 0 THEN 'paid'
    ELSE 'new'
END,
    ((g * 19) % 100000) / 100.0,
    TIMESTAMP '2025-01-01 00:00:00'
        + ((g % 90) || ' days')::interval
        + (((g * 17) % 86400) || ' seconds')::interval,
    'event-' || g
FROM generate_series(1, 60000) AS g;

INSERT INTO exam_events (user_id, status, amount, created_at, payload) VALUES
                                                                           (4242, 'paid', 199.90, '2025-03-10 08:15:00', 'target-1'),
                                                                           (4242, 'paid', 299.50, '2025-03-10 12:40:00', 'target-2'),
                                                                           (4242, 'new',  89.00, '2025-03-10 18:05:00', 'target-3'),
                                                                           (4242, 'paid', 120.00, '2025-03-15 09:00:00', 'outside-range');

CREATE INDEX idx_exam_events_status ON exam_events (status);
CREATE INDEX idx_exam_events_amount_hash ON exam_events USING hash (amount);
CREATE TABLE exam_users (
                            id BIGSERIAL PRIMARY KEY,
                            name TEXT NOT NULL,
                            country TEXT NOT NULL,
                            segment TEXT NOT NULL
);

CREATE TABLE exam_orders (
                             id BIGSERIAL PRIMARY KEY,
                             user_id BIGINT NOT NULL,
                             amount NUMERIC(10,2) NOT NULL,
                             status TEXT NOT NULL,
                             created_at TIMESTAMP NOT NULL
);

INSERT INTO exam_users (name, country, segment)
SELECT
    'User ' || g,
    CASE
        WHEN g % 20 = 0 THEN 'JP'
        WHEN g % 7 = 0 THEN 'DE'
        WHEN g % 5 = 0 THEN 'US'
        ELSE 'NL'
        END,
    CASE
        WHEN g % 10 = 0 THEN 'enterprise'
        WHEN g % 3 = 0 THEN 'pro'
        ELSE 'basic'
        END
FROM generate_series(1, 20000) AS g;

INSERT INTO exam_orders (user_id, amount, status, created_at)
SELECT
    ((g * 13) % 20000) + 1,
    ((g * 29) % 200000) / 100.0,
    CASE
    WHEN g % 9 = 0 THEN 'cancelled'
    WHEN g % 4 = 0 THEN 'paid'
    ELSE 'new'
END,
    TIMESTAMP '2025-01-01 00:00:00'
        + ((g % 120) || ' days')::interval
        + (((g * 31) % 86400) || ' seconds')::interval
FROM generate_series(1, 120000) AS g;

CREATE INDEX idx_exam_orders_created_at ON exam_orders (created_at);
CREATE INDEX idx_exam_users_name ON exam_users (name);
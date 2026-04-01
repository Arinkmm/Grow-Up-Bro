CREATE TABLE exam_measurements_src (
                                       city_id INTEGER NOT NULL,
                                       log_date DATE NOT NULL,
                                       peaktemp INTEGER,
                                       unitsales INTEGER
);

INSERT INTO exam_measurements_src (city_id, log_date, peaktemp, unitsales)
SELECT
    (g % 50) + 1,
    DATE '2025-01-01' + (g % 31),
    (g % 25) - 5,
    50 + (g % 300)
FROM generate_series(1, 1200) AS g;

INSERT INTO exam_measurements_src (city_id, log_date, peaktemp, unitsales)
SELECT
    (g % 50) + 1,
    DATE '2025-02-01' + (g % 28),
    (g % 25),
    70 + (g % 320)
FROM generate_series(1, 1200) AS g;

INSERT INTO exam_measurements_src (city_id, log_date, peaktemp, unitsales)
SELECT
    (g % 50) + 1,
    DATE '2025-03-01' + (g % 31),
    5 + (g % 20),
    90 + (g % 350)
FROM generate_series(1, 1200) AS g;

INSERT INTO exam_measurements_src (city_id, log_date, peaktemp, unitsales)
SELECT
    (g % 50) + 1,
    DATE '2025-04-01' + (g % 10),
    10 + (g % 15),
    100 + (g % 200)
FROM generate_series(1, 100) AS g;
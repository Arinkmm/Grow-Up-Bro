INSERT INTO olap.dim_date
SELECT
    datum AS date_actual,
    EXTRACT(epoch FROM datum) AS epoch,
    TO_CHAR(datum, 'FM99th') AS day_suffix,
    EXTRACT(isodow FROM datum) AS day_of_week,
    EXTRACT(day FROM datum) AS day_of_month,
    EXTRACT(doy FROM datum) AS day_of_year,
    EXTRACT(week FROM datum) AS week_of_year,
    EXTRACT(month FROM datum) AS month_actual,
    TO_CHAR(datum, 'TMMonth') AS month_name,
    TO_CHAR(datum, 'Mon') AS month_name_short,
    EXTRACT(quarter FROM datum) AS quarter_actual,
    EXTRACT(year FROM datum) AS year_actual,
    CASE WHEN EXTRACT(isodow FROM datum) IN (6, 7) THEN TRUE ELSE FALSE END AS is_weekend
FROM generate_series('2026-01-01'::DATE, '2027-12-31'::DATE, '1 day'::INTERVAL) datum
    ON CONFLICT DO NOTHING;
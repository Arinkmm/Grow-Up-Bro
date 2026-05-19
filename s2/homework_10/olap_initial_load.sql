INSERT INTO main.plant_care_event (plant_id, event_type, created_at)
SELECT
    floor(random() * 250000 + 1)::int,
    (ARRAY['Полив', 'Подкормка', 'Обрезка', 'Пересадка'])[floor(random() * 4 + 1)],
    NOW() - (random() * INTERVAL '60 days')
FROM generate_series(1, 500000);

INSERT INTO olap.dim_plant (plant_id, plant_name, sunlight_type, watering_type, difficulty_type, size_type)
SELECT
    p.id,
    p.name,
    s.type,
    w.type,
    d.type,
    sz.type
FROM main.plant p
         LEFT JOIN refs.sunlight s ON p.sunlight_id = s.id
         LEFT JOIN refs.watering w ON p.watering_id = w.id
         LEFT JOIN refs.difficulty d ON p.difficulty_id = d.id
         LEFT JOIN refs.size sz ON p.size_id = sz.id
    ON CONFLICT (plant_id) DO UPDATE SET
    plant_name = EXCLUDED.plant_name,
    sunlight_type = EXCLUDED.sunlight_type,
    watering_type = EXCLUDED.watering_type,
    difficulty_type = EXCLUDED.difficulty_type,
    size_type = EXCLUDED.size_type;

INSERT INTO olap.dim_event_type (event_type_name)
SELECT DISTINCT event_type FROM main.plant_care_event
    ON CONFLICT DO NOTHING;

INSERT INTO olap.fact_care_events (date_key, plant_key, event_type_key, created_at, oltp_event_id)
SELECT
    src.created_at::DATE,
    src.plant_id,
    et.event_type_id,
    src.created_at,
    src.id
FROM main.plant_care_event src
         JOIN olap.dim_event_type et ON src.event_type = et.event_type_name
WHERE NOT EXISTS (
    SELECT 1 FROM olap.fact_care_events f WHERE f.oltp_event_id = src.id
);
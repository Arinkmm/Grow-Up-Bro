INSERT INTO refs.sunlight (type) VALUES ('Тень'), ('Полутень'), ('Рассеянный свет'), ('Прямой свет'), ('Экстремальный свет');
INSERT INTO refs.watering (type) VALUES ('Без полива'), ('Редкий'), ('Умеренный'), ('Частый'), ('Водная среда');
INSERT INTO refs.temperature (type) VALUES ('Мороз'), ('Холод'), ('Тепло'), ('Жара'), ('Пекло');
INSERT INTO refs.safety (type) VALUES ('Безопасно'), ('Осторожно'), ('Ядовито'), ('Смертельно');
INSERT INTO refs.difficulty (type) VALUES ('Для новичков'), ('Средне'), ('Сложно'), ('Для экспертов');
INSERT INTO refs.size (type) VALUES ('Мини'), ('Маленькое'), ('Среднее'), ('Большое'), ('Огромное');

INSERT INTO main.fertilizer (name, usage, type, brand)
SELECT
    'Удобрение №' || i,
    'Инструкция по применению для партии ' || i,
    (ARRAY['Органическое', 'Минеральное'])[floor(random()*2+1)],
    (ARRAY['GreenWorld', 'BioGarden', 'AgroX'])[floor(random()*3+1)]
FROM generate_series(1, 10000) i;

INSERT INTO main.plant (
    name, description, sunlight_id, watering_id, temperature_id,
    safety_id, difficulty_id, size_id, fertilizer_id,
    specs, planting_season, origin_location
)
SELECT
    'Растение Тип-' || i,
    'Описание растения номер ' || i || '. Полная подробная информация о растении для поиска',
    CASE WHEN random() < 0.7 THEN 1 ELSE floor(random()*4+2) END,
    floor(random()*5+1),
    floor(random()*5+1),
    floor(random()*4+1),
    floor(random()*4+1),
    floor(random()*5+1),
    CASE WHEN random() < 0.2 THEN NULL ELSE floor(random()*10000+1) END,
    jsonb_build_object('цвет', 'зеленый', 'id_инфо', i, 'устойчивость', 'высокая'),
    daterange('2026-04-01', '2026-08-01'),
    point(i, floor(random()*100))
FROM generate_series(1, 250000) i;


INSERT INTO main.advice (tip_text, author, rating, is_verified)
SELECT
    'Полезный совет №' || i || ': Регулярно проверяйте состояние почвы',
    'Садовод №' || floor(random()*100+1),
    floor(random()*5+1),
    (random() > 0.3)
FROM generate_series(1, 300000) i;

INSERT INTO links.plant_tip (plant_id, tip_id)
SELECT
    (random()*249999 + 1)::int,
    (random()*299999 + 1)::int
FROM generate_series(1, 500000)
    ON CONFLICT DO NOTHING;
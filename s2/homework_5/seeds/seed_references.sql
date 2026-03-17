-- 1.
INSERT INTO refs.sunlight (type)
VALUES
    ('Тень'),
    ('Полутень'),
    ('Рассеянный свет'),
    ('Прямой свет'),
    ('Экстремальный свет')
ON CONFLICT (type) DO NOTHING;

-- 2.
INSERT INTO refs.watering (type)
VALUES
    ('Без полива'),
    ('Редкий'),
    ('Умеренный'),
    ('Частый'),
    ('Водная среда')
    ON CONFLICT (type) DO NOTHING;
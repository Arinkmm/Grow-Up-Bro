-- 3.
INSERT INTO main.fertilizer (name, usage, type, brand)
VALUES
    ('BioGrow Premium', '2 мл на 1 л воды раз в неделю', 'Органическое', 'BioGarden'),
    ('Mineral Max', '5 гр на 10 л при поливе', 'Минеральное', 'AgroX')
    ON CONFLICT (name)
DO UPDATE SET
           usage = EXCLUDED.usage,
           brand = EXCLUDED.brand,
           type = EXCLUDED.type;
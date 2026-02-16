ALTER TABLE main.plant ADD COLUMN specs JSONB;

ALTER TABLE main.plant ADD COLUMN planting_season DATERANGE;

ALTER TABLE main.plant ADD COLUMN origin_location POINT;

ALTER TABLE main.plant ADD COLUMN description_ts tsvector;
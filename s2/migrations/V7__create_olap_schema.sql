CREATE TABLE olap.dim_date (
    date_actual DATE PRIMARY KEY,
    epoch BIGINT NOT NULL,
    day_suffix VARCHAR(4) NOT NULL,
    day_of_week INT NOT NULL,
    day_of_month INT NOT NULL,
    day_of_year INT NOT NULL,
    week_of_year INT NOT NULL,
    month_actual INT NOT NULL,
    month_name VARCHAR(9) NOT NULL,
    month_name_short CHAR(3) NOT NULL,
    quarter_actual INT NOT NULL,
    year_actual INT NOT NULL,
    is_weekend BOOLEAN NOT NULL
);

CREATE TABLE olap.dim_plant (
    plant_id INT PRIMARY KEY,
    plant_name VARCHAR(255) NOT NULL,
    sunlight_type VARCHAR(255),
    watering_type VARCHAR(255),
    difficulty_type VARCHAR(255),
    size_type VARCHAR(255)
);

CREATE TABLE olap.dim_event_type (
    event_type_id SERIAL PRIMARY KEY,
    event_type_name TEXT UNIQUE NOT NULL
);

CREATE TABLE olap.fact_care_events (
     fact_id BIGSERIAL PRIMARY KEY,
     date_key DATE NOT NULL REFERENCES olap.dim_date(date_actual),
     plant_key INT NOT NULL REFERENCES olap.dim_plant(plant_id),
     event_type_key INT NOT NULL REFERENCES olap.dim_event_type(event_type_id),
     created_at TIMESTAMPTZ NOT NULL,
     oltp_event_id BIGINT NOT NULL
);

CREATE INDEX idx_fact_date ON olap.fact_care_events(date_key);
CREATE INDEX idx_fact_plant ON olap.fact_care_events(plant_key);
CREATE INDEX idx_fact_event_type ON olap.fact_care_events(event_type_key);
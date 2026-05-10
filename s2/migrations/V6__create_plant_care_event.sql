CREATE TABLE main.plant_care_event (
    id BIGSERIAL PRIMARY KEY,
    plant_id INT REFERENCES main.plant(id),
    event_type TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
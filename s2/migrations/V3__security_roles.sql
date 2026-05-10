CREATE ROLE botanist LOGIN PASSWORD 'botanist_pass';
GRANT USAGE ON SCHEMA main, refs, links TO botanist;
GRANT SELECT ON ALL TABLES IN SCHEMA refs TO botanist;
GRANT SELECT ON main.plant, main.advice TO botanist;

CREATE ROLE content_manager LOGIN PASSWORD 'manager_pass';
GRANT USAGE ON SCHEMA main, refs, links TO content_manager;
GRANT SELECT, INSERT, UPDATE ON ALL TABLES IN SCHEMA main, links TO content_manager;
GRANT SELECT ON ALL TABLES IN SCHEMA refs TO content_manager;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA main, links TO content_manager;

CREATE ROLE agronomist LOGIN PASSWORD 'agro_pass';
GRANT USAGE ON SCHEMA main, refs, links TO agronomist;
GRANT SELECT ON main.plant TO agronomist;
GRANT ALL PRIVILEGES ON refs.feature TO agronomist;
GRANT USAGE, SELECT ON SEQUENCE refs.feature_id_seq TO agronomist;
CREATE DATABASE olap;

CREATE TABLE olap.src_dim_plant (
    plant_id Int32,
    plant_name String,
    difficulty_id Int32,
    size_id Int32
) ENGINE = ReplacingMergeTree()
ORDER BY plant_id;

CREATE TABLE olap.src_plant_care_events (
    id Int64,
    plant_id Int32,
    event_type LowCardinality(String),
    created_at DateTime
) ENGINE = ReplacingMergeTree()
ORDER BY (event_type, created_at, id);

CREATE TABLE olap.src_advice (
    id Int32,
    tip_text String,
    author String,
    rating Int8,
    is_verified UInt8
) ENGINE = ReplacingMergeTree()
ORDER BY id;

CREATE TABLE olap.mart_dashboard_analytics (
   log_date Date,
   plant_id Int32,
   event_type String,
   author String,
   total_operations UInt64,
   weekend_operations UInt64,
   total_author_rating Int64
) ENGINE = SummingMergeTree()
    ORDER BY (log_date, plant_id, event_type, author);

CREATE MATERIALIZED VIEW olap.mv_dashboard_analytics_pipeline
TO olap.mart_dashboard_analytics AS
SELECT
    toDate(e.created_at) AS log_date,
    e.plant_id,
    e.event_type,
    a.author,
    count(e.id) AS total_operations,
    sum(toDayOfWeek(e.created_at) IN (6, 7)) AS weekend_operations,
    sum(a.rating) AS total_author_rating
FROM olap.src_plant_care_events AS e
         LEFT JOIN olap.src_advice AS a ON e.plant_id = a.id
GROUP BY log_date, e.plant_id, e.event_type, a.author;
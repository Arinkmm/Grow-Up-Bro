CREATE TABLE queue.tasks (
    id BIGSERIAL PRIMARY KEY,
    task_type TEXT NOT NULL,
    payload JSONB NOT NULL DEFAULT '{}'::jsonb,
    priority INT NOT NULL DEFAULT 0,
    status TEXT NOT NULL DEFAULT 'Ready',
    attempts INT NOT NULL DEFAULT 0,
    max_attempts INT NOT NULL DEFAULT 5,
    scheduled_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    started_at TIMESTAMPTZ,
    completed_at TIMESTAMPTZ,
    worker_name TEXT,
    error TEXT
    );

CREATE INDEX IF NOT EXISTS idx_tasks_ready ON queue.tasks (priority DESC, scheduled_at ASC, created_at ASC) WHERE status = 'Ready';

CREATE INDEX IF NOT EXISTS idx_tasks_completed_at ON queue.tasks (completed_at) WHERE status IN ('Completed', 'Failed');

ALTER TABLE queue.tasks SET (
    autovacuum_vacuum_scale_factor = 0.01,
    autovacuum_analyze_scale_factor = 0.005,
    autovacuum_vacuum_threshold = 50,
    autovacuum_analyze_threshold = 50
);
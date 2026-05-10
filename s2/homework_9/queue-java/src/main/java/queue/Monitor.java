package queue;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import java.time.Duration;
import java.util.Map;

@Component
class Monitor {
    private final JdbcTemplate jdbc;

    Monitor(JdbcTemplate jdbc) {
        this.jdbc = jdbc;
    }

    public void run() throws InterruptedException {
        while (true) {
            Map<String, Object> row = jdbc.queryForMap("""
                    SELECT
                    count(*) FILTER (WHERE status = 'Ready') AS ready,
                    count(*) FILTER (WHERE status = 'Running') AS running,
                    count(*) FILTER (WHERE status = 'Completed') AS completed,
                    count(*) FILTER (WHERE status = 'Failed') AS failed,
                    coalesce(extract(epoch FROM now() - min(created_at) FILTER (WHERE status = 'Ready')), 0)::int AS lag_seconds,
                    count(*) FILTER (
                        WHERE status IN ('Completed', 'Failed')
                          AND completed_at >= now() - interval '10 seconds'
                    ) / 10.0 AS throughput_per_sec,
                    coalesce(avg(extract(epoch FROM started_at - created_at)) FILTER (WHERE priority = 100 AND started_at IS NOT NULL), 0)::numeric(10,2) AS avg_wait_priority_100,
                    coalesce(avg(extract(epoch FROM started_at - created_at)) FILTER (WHERE priority = 0 AND started_at IS NOT NULL), 0)::numeric(10,2) AS avg_wait_priority_0
                                    FROM queue.tasks
                """);

            System.out.printf(
                    "ready=%s running=%s completed=%s failed=%s lag=%ss throughput=%s/s avg_wait_p100=%ss avg_wait_p0=%ss%n",
                    row.get("ready"), row.get("running"), row.get("completed"), row.get("failed"),
                    row.get("lag_seconds"), row.get("throughput_per_sec"),
                    row.get("avg_wait_priority_100"), row.get("avg_wait_priority_0")
            );
            Thread.sleep(Duration.ofSeconds(5));
        }
    }
}
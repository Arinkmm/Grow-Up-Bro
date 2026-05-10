package queue;

import org.postgresql.PGConnection;
import org.postgresql.PGNotification;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.Statement;
import java.util.Optional;
import java.util.Random;

@Component
public class Consumer {
    private final JdbcTemplate jdbc;
    private final DataSource dataSource;
    private final Random random = new Random();
    private final String workerName;
    private final double failProbability;
    private final int sleepMs;

    public Consumer(JdbcTemplate jdbc,
                    DataSource dataSource,
                    @Value("${app.consumer.name}") String workerName,
                    @Value("${app.consumer.fail-probability}") double failProbability,
                    @Value("${app.consumer.sleep-ms}") int sleepMs) {
        this.jdbc = jdbc;
        this.dataSource = dataSource;
        this.workerName = workerName;
        this.failProbability = failProbability;
        this.sleepMs = sleepMs;
    }

    public void run() throws Exception {
        try (Connection connection = dataSource.getConnection();
             Statement statement = connection.createStatement()) {

            statement.execute("LISTEN plant_tasks");
            PGConnection pgConnection = connection.unwrap(PGConnection.class);

            while (true) {
                Optional<Task> task = takeTask();

                if (task.isPresent()) {
                    process(task.get());
                    continue;
                }

                pgConnection.getNotifications(1000);
            }
        }
    }

    private void process(Task task) throws InterruptedException {
        Thread.sleep(sleepMs);

        if (random.nextDouble() < failProbability) {
            failTask(task.id(), "Random processing error");
        } else {
            completeTask(task.id());
        }
    }

    @Transactional
    public Optional<Task> takeTask() {
        return jdbc.query("""
            WITH picked AS (
                SELECT id
                FROM queue.tasks
                WHERE status = 'Ready'
                  AND scheduled_at <= now()
                ORDER BY priority DESC, created_at ASC
                LIMIT 1
                FOR UPDATE SKIP LOCKED
            )
            UPDATE queue.tasks t
            SET status = 'Running', started_at = now(), worker_name = ?
            FROM picked
            WHERE t.id = picked.id
            RETURNING t.id, t.priority
            """, rs -> {
            if (!rs.next()) return Optional.empty();
            return Optional.of(new Task(rs.getLong("id"), rs.getInt("priority")));
        }, workerName);
    }

    @Transactional
    public void completeTask(long taskId) {
        jdbc.update("""
            UPDATE queue.tasks
            SET status = 'Completed', completed_at = now()
            WHERE id = ?
            """, taskId);

        System.out.println(workerName + " completed task " + taskId);
    }

    @Transactional
    public void failTask(long taskId, String error) {
        jdbc.update("""
            UPDATE queue.tasks
            SET attempts = attempts + 1,
                status = CASE WHEN attempts + 1 >= max_attempts THEN 'Failed' ELSE 'Ready' END,
                scheduled_at = CASE
                    WHEN attempts + 1 >= max_attempts THEN scheduled_at
                    ELSE now() + ((power(2, attempts) * interval '5 minutes'))
                END,
                completed_at = CASE WHEN attempts + 1 >= max_attempts THEN now() ELSE NULL END,
                error = ?
            WHERE id = ?
            """, error, taskId);

        System.out.println(workerName + " failed task " + taskId + ", retry later");
    }

    record Task(long id, int priority) {}
}
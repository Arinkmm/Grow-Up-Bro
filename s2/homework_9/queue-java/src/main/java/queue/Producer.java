package queue;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.Random;

@Component
public class Producer {
    private final JdbcTemplate jdbc;
    private final Random random = new Random();
    private final int ratePerSecond;
    private final int maxAttempts;

    public Producer(JdbcTemplate jdbc,
             @Value("${app.producer.rate-per-second}") int ratePerSecond,
             @Value("${app.max-attempts}") int maxAttempts) {
        this.jdbc = jdbc;
        this.ratePerSecond = ratePerSecond;
        this.maxAttempts = maxAttempts;
    }

    public void run() throws InterruptedException {
        long delayMs = Math.max(1, 1000 / ratePerSecond);

        while (true) {
            createBusinessEventAndTask();
            Thread.sleep(delayMs);
        }
    }

    @Transactional
    public void createBusinessEventAndTask() {
        int plantId = random.nextInt(250_000) + 1;
        boolean critical = random.nextDouble() < 0.20;
        int priority = critical ? 100 : 0;
        String taskType = critical ? "CRITICAL_PLANT_CHECK" : "NORMAL_PLANT_CHECK";

        Long eventId = jdbc.queryForObject("""
            INSERT INTO main.plant_care_event(plant_id, event_type)
            VALUES (?, ?)
            RETURNING id
            """, Long.class, plantId, taskType);

        jdbc.update("""
            INSERT INTO queue.tasks(task_type, payload, priority, max_attempts)
            VALUES (?, jsonb_build_object('plant_id', ?, 'event_id', ?), ?, ?)
            """, taskType, plantId, eventId, priority, maxAttempts);

        jdbc.execute("NOTIFY plant_tasks, 'new_task'");
    }
}
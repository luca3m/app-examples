package hello;

import java.util.Random;

import io.prometheus.client.Counter;
import io.prometheus.client.Gauge;
import io.prometheus.client.Histogram;
import io.prometheus.client.Summary;
import io.prometheus.client.spring.boot.EnablePrometheusEndpoint;
import io.prometheus.client.spring.web.EnablePrometheusTiming;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.core.task.SimpleAsyncTaskExecutor;
import org.springframework.core.task.TaskExecutor;

@SpringBootApplication
@EnablePrometheusEndpoint
@EnablePrometheusTiming
public class Application {

    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }

    @Bean
    public TaskExecutor taskExecutor() {
        return new SimpleAsyncTaskExecutor(); // Or use another one of your liking
    }

    @Bean
    public CommandLineRunner getPrometheusMetrics(TaskExecutor executor) {
        final Histogram randomMetric = Histogram.build()
                .name("random").help("Random sleep").register();
        final Summary randomMetricSummary = Summary.build()
                .name("randomSummary").help("random sleep but as summary")
                .quantile(0.50, 0.05)
                .quantile(0.95, 0.05)
                .quantile(0.99, 0.05)
                .register();
        final Gauge totalMemory = Gauge.build().name("total_memory").help("Memory usage of java process").register();
        final Counter iterations = Counter.build().name("iterations").help("numbers of iterations").register();

        final Random r = new Random();
        return args -> executor.execute(() -> {
            while(true) {
                final Histogram.Timer timer = randomMetric.startTimer();
                final Summary.Timer timerSummary = randomMetricSummary.startTimer();
                try {
                    Thread.sleep(r.nextInt(1000));
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
                timer.observeDuration();
                timerSummary.observeDuration();
                totalMemory.set(Runtime.getRuntime().totalMemory());
                iterations.inc();
            }
        });
    }
}

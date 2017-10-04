package hello;

import java.util.Random;

import io.prometheus.client.Histogram;
import io.prometheus.client.spring.boot.EnablePrometheusEndpoint;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.core.task.SimpleAsyncTaskExecutor;
import org.springframework.core.task.TaskExecutor;

@SpringBootApplication
@EnablePrometheusEndpoint
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
        final Histogram requestLatency = Histogram.build()
                .name("summary_metric").help("Fake summary metric.").register();
        final Random r = new Random();
        return args -> {
            executor.execute(() -> {
                while(true) {
                    final Histogram.Timer timer = requestLatency.startTimer();
                    try {
                        Thread.sleep(r.nextInt(1000));
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                    timer.observeDuration();
                }
            });
        };
    }
}

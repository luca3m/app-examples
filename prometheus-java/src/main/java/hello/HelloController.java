package hello;

import io.prometheus.client.spring.web.PrometheusTimeMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestMapping;

@RestController
public class HelloController {

    @RequestMapping("/")
    @PrometheusTimeMethod(name = "index", help = "My index code")
    public String index() {
        return "Greetings from Spring Boot!";
    }
    
}

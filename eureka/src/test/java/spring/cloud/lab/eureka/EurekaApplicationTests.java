package spring.cloud.lab.eureka;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest(properties = "spring.cloud.config.enabled=false")
class EurekaApplicationTests {

    @Test
    void contextLoads() {
    }

}

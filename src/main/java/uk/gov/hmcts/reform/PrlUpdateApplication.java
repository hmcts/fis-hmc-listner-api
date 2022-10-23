package uk.gov.hmcts.reform;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@SuppressWarnings("HideUtilityClassConstructor") // Spring needs a constructor, its not a utility class
public class PrlUpdateApplication {

    public static void main(final String[] args) {
        SpringApplication.run(PrlUpdateApplication.class, args);
    }
}

package kr.co.ubcn.multivm;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.web.servlet.MultipartAutoConfiguration;

@SpringBootApplication(exclude={MultipartAutoConfiguration.class})
public class MultivmApplication {

	public static void main(String[] args) {
		SpringApplication.run(MultivmApplication.class, args);
	}

}

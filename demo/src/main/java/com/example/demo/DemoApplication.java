package com.example.demo;

import com.zaxxer.hikari.HikariDataSource;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@SpringBootApplication
@Configuration
public class DemoApplication implements CommandLineRunner {

	public static void main(String[] args) {
		SpringApplication.run(DemoApplication.class, args);
	}
	@Autowired
	HikariDataSource dataSource;
	@Bean
	public ModelMapper modelMapper() {
		return new ModelMapper();
	}


	///
	/// Here, increase the number of threads in order to serve more users.
	// This is one of the expansion methods, or we can create a duplicate of the data base
	@Override
	public void run(String... args) throws Exception {
		System.err.println("+++++++++++++++++++++++++++++++++++++++++++++++++");
		System.err.println(dataSource.getMaximumPoolSize());
	}
}


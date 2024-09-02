package com.freethebeans.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.freethebeans.server.controller.DBConnection;

@Configuration
public class AppConfig {
    @Bean
    public DBConnection dbConnection() {
        // Create and configure your DBConnection bean
        return new DBConnection(); // You may need to adjust this based on your DBConnection implementation
    }
}

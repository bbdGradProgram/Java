package com.freethebeans;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class JavaBeanServer {

    public static void main(String[] args) {
        // dbConnection.getDummyRecord();
        SpringApplication.run(JavaBeanServer.class, args);
        printStartBanner();
    }

    private static void printStartBanner() {
        System.out.println("===============================================");
        System.out.println("|        The server has started successfully!   |");
        System.out.println("|            Let the journey begin!             |");
        System.out.println("===============================================");
    }
}

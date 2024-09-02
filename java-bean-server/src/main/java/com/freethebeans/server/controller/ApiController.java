package com.freethebeans.server.controller;

import com.freethebeans.server.model.ApiResponse;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api")
public class ApiController {
    final DBConnection dbConnection;

    ApiController(DBConnection dbConnection) {
        this.dbConnection = dbConnection;
    }

    @GetMapping("/hello")
    public ApiResponse hello() {
        return new ApiResponse("Hello, client! This is a stateless Spring REST API.");
    }

    @GetMapping("/ping")
    public ApiResponse ping() {
        System.out.println("Playing ping pong with a client...");
        return new ApiResponse("pong");
    }

    @GetMapping("/dummy")
    public ApiResponse dummy() {
        return new ApiResponse(dbConnection.queryDB("SELECT * FROM states WHERE state_id = 'dummyState'").toString());
    }

    @GetMapping("/state/{stateName}")
    public ApiResponse getStateInformation(@PathVariable String stateName) {
        String stateInformation = dbConnection.fetchStateInformationFromDB(stateName).toString();
        return new ApiResponse(stateInformation);
    }

    @GetMapping("/last_state/{playerEmail}")
    public ApiResponse getSavedState(@PathVariable String playerEmail) {
        String lastState = dbConnection.PLAYER_START_STATE;
        try {
            lastState = dbConnection.fetchUserSavedStateFromDB(playerEmail);
        } catch (Exception e) {
            System.err.println("Failed to get users last saved state. Returning default value.");
        }
        return new ApiResponse(lastState);
    }
}

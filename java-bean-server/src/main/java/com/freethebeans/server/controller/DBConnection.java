package com.freethebeans.server.controller;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import com.amazonaws.secretsmanager.caching.SecretCache;

import org.json.JSONArray;
import org.json.JSONObject;

public class DBConnection {
    final String PLAYER_START_STATE = "startState";

    String secretID = "dev/database/credentials";

    String username = "";
    String password = "";
    String host = "";
    int port = 0;

    Connection connection = null;
    Statement statement = null;
    ResultSet resultSet = null;

    public DBConnection() {
        JSONObject dbSecret = getDBCredentials(secretID);
        username = dbSecret.getString("username");
        password = dbSecret.getString("password");
        host = dbSecret.getString("host");
        port = dbSecret.getInt("port");

        host = String.format("jdbc:postgresql://%s:%d/dev", host, port);
    }

    public JSONObject getDBCredentials(String secretName) {
        try (SecretCache cache = new SecretCache()) {
            JSONObject dbSecret = new JSONObject(cache.getSecretString(secretID));
            String expectedFields[] = { "username", "password", "host", "port" };
            for (String key : expectedFields) {
                if (!dbSecret.has(key)) {
                    System.err.println("Error: expected DB credentials not found.");
                    throw new Exception("Error: expected DB credentials not found.");
                }
            }
            return dbSecret;
        } catch (Exception e) {
            System.err.println("Error: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    public void getDummyRecord() {
        try {
            Class.forName("org.postgresql.Driver");
            connection = DriverManager.getConnection(host, username, password);
            statement = connection.createStatement();
            resultSet = statement.executeQuery("SELECT * FROM players");

            while (resultSet.next()) {
                int column1Data = resultSet.getInt("player_id");
                String column2Data = resultSet.getString("username");
                System.out.println("User ID: " + column1Data + ", Username: " + column2Data);
            }
        } catch (ClassNotFoundException e) {
            System.err.println("Could not find the PostgreSQL JDBC driver. Include it in your library path.");
            e.printStackTrace();
        } catch (SQLException e) {
            System.err.println("Error connecting to the database.");
            e.printStackTrace();
        } finally {
            try {
                if (resultSet != null)
                    resultSet.close();
                if (statement != null)
                    statement.close();
                if (connection != null)
                    connection.close();
            } catch (SQLException e) {
                System.err.println("Error closing resources.");
                e.printStackTrace();
            }
        }
    }

    public JSONObject queryDB(String query) {
        JSONObject result = null;
        try {
            Class.forName("org.postgresql.Driver");
            connection = DriverManager.getConnection(host, username, password);
            statement = connection.createStatement();
            resultSet = statement.executeQuery(query);

            String stringResult = "{ results: [";
            ResultSetMetaData metaData = resultSet.getMetaData();
            int columnCount = metaData.getColumnCount();

            while (resultSet.next()) {
                stringResult += "{";
                for (int i = 1; i <= columnCount; i++) {
                    String columnName = metaData.getColumnName(i);
                    Object columnValue = resultSet.getObject(i);
                    stringResult += String.format("%s: %s,", columnName, columnValue);
                }
                if (stringResult.endsWith(",")) {
                    stringResult = stringResult.substring(0, stringResult.length() - 1);
                }
                stringResult += "},";
            }
            if (stringResult.endsWith(",")) {
                stringResult = stringResult.substring(0, stringResult.length() - 1);
            }
            stringResult += "]}";
            result = new JSONObject(stringResult);
        } catch (ClassNotFoundException e) {
            System.err.println("Could not find the PostgreSQL JDBC driver. Include it in your library path.");
            e.printStackTrace();
        } catch (SQLException e) {
            System.err.println("Error connecting to the database.");
            e.printStackTrace();
        } finally {
            try {
                if (resultSet != null)
                    resultSet.close();
                if (statement != null)
                    statement.close();
                if (connection != null)
                    connection.close();
            } catch (SQLException e) {
                System.err.println("Error closing resources.");
                e.printStackTrace();
            }
        }
        return result;
    }

    private void addPlayerToDB(String playerEmailString) {
        try {
            Class.forName("org.postgresql.Driver");
            connection = DriverManager.getConnection(host, username, password);
            statement = connection.createStatement();

            String contextQuery = "INSERT INTO players (username, email) VALUES (?, ?)";
            PreparedStatement contextStatement = connection.prepareStatement(contextQuery);
            String username = "BeanDoe";

            String[] parts = playerEmailString.split("@");

            if (parts.length == 2) {
                username = parts[0];
            } else {
                System.err.println("Invalid email format");
            }
            contextStatement.setString(1, username);
            contextStatement.setString(2, playerEmailString);
            contextStatement.executeUpdate();
        } catch (ClassNotFoundException e) {
            System.err.println("Could not find the PostgreSQL JDBC driver. Include it in your library path.");
            e.printStackTrace();
        } catch (SQLException e) {
            System.err.println("Error connecting to the database.");
            e.printStackTrace();
        } finally {
            try {
                if (resultSet != null)
                    resultSet.close();
                if (statement != null)
                    statement.close();
                if (connection != null)
                    connection.close();
            } catch (SQLException e) {
                System.err.println("Error closing resources.");
                e.printStackTrace();
            }
        }
    }

    public JSONObject fetchStateInformationFromDB(String state_id) {
        JSONObject stateInformation = new JSONObject();
        try {
            Class.forName("org.postgresql.Driver");
            connection = DriverManager.getConnection(host, username, password);
            statement = connection.createStatement();

            String contextQuery = "SELECT context FROM states WHERE state_id = ?";
            PreparedStatement contextStatement = connection.prepareStatement(contextQuery);
            contextStatement.setString(1, state_id);
            resultSet = contextStatement.executeQuery();
            String stateContext = "--- context is missing ---";
            if (resultSet.next()) {
                stateContext = resultSet.getString(1);
            }

            String optionsQuery = "SELECT option_text, next_state_id FROM state_options WHERE state_id = ?";
            PreparedStatement optionsStatement = connection.prepareStatement(optionsQuery);
            optionsStatement.setString(1, state_id);
            resultSet = optionsStatement.executeQuery();

            JSONArray optionsArray = new JSONArray();
            JSONArray transitionsArray = new JSONArray();

            while (resultSet.next()) {
                String stateOption = resultSet.getString(1);
                String stateTransition = resultSet.getString(2);

                optionsArray.put(stateOption);
                transitionsArray.put(stateTransition);
            }

            stateInformation.put("context", stateContext);
            stateInformation.put("options", optionsArray);
            stateInformation.put("transitions", transitionsArray);
        } catch (ClassNotFoundException e) {
            System.err.println("Could not find the PostgreSQL JDBC driver. Include it in your library path.");
            e.printStackTrace();
        } catch (SQLException e) {
            System.err.println("Error connecting to the database.");
            e.printStackTrace();
        } finally {
            try {
                if (resultSet != null)
                    resultSet.close();
                if (statement != null)
                    statement.close();
                if (connection != null)
                    connection.close();
            } catch (SQLException e) {
                System.err.println("Error closing resources.");
                e.printStackTrace();
            }
        }
        return stateInformation;
    }

    public String fetchUserSavedStateFromDB(String userEmailString) {
        String savedState = PLAYER_START_STATE;
        try {
            Class.forName("org.postgresql.Driver");
            connection = DriverManager.getConnection(host, username, password);
            statement = connection.createStatement();

            String contextQuery = "SELECT last_game_state FROM players WHERE email = ?";
            PreparedStatement contextStatement = connection.prepareStatement(contextQuery);
            contextStatement.setString(1, userEmailString);
            resultSet = contextStatement.executeQuery();

            if (resultSet.next()) {
                // player exists
                savedState = resultSet.getString(1);
            } else {
                // player does not exist
                addPlayerToDB(userEmailString);
            }
        } catch (ClassNotFoundException e) {
            System.err.println("Could not find the PostgreSQL JDBC driver. Include it in your library path.");
            e.printStackTrace();
        } catch (SQLException e) {
            System.err.println("Error connecting to the database.");
            e.printStackTrace();
        } finally {
            try {
                if (resultSet != null)
                    resultSet.close();
                if (statement != null)
                    statement.close();
                if (connection != null)
                    connection.close();
            } catch (SQLException e) {
                System.err.println("Error closing resources.");
                e.printStackTrace();
            }
        }
        return savedState;
    }
}
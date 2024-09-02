package resources;

import static org.mockito.ArgumentMatchers.anyString;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;
import org.json.JSONException;
import org.json.JSONObject;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.test.web.servlet.MockMvc;

import com.freethebeans.JavaBeanServer;
import com.freethebeans.server.controller.DBConnection;

@SpringBootTest(classes = JavaBeanServer.class)
@AutoConfigureMockMvc
class ApiControllerTest {

	@Autowired
	private MockMvc mockMvc;

	@MockBean
	DBConnection dbConnection;

	@BeforeEach
	void setUp() throws JSONException {
		JSONObject mockDbSecret = new JSONObject();
		mockDbSecret.put("username", "mockUsername");
		mockDbSecret.put("password", "mockPassword");
		mockDbSecret.put("host", "mockHost");
		mockDbSecret.put("port", 1234);

		Mockito.when(dbConnection.getDBCredentials(anyString())).thenReturn(mockDbSecret);
	}

	@Test
	void testHello() throws Exception {

		mockMvc.perform(get("/api/hello"))
				.andExpect(status().isOk())
				.andExpect(content().json("{\"message\":\"Hello, client! This is a stateless Spring REST API.\"}"));
	}

	// Test for the ping method
	@Test
	void testPing() throws Exception {
		mockMvc.perform(get("/api/ping"))
				.andExpect(status().isOk())
				.andExpect(content().json("{\"message\":\"pong\"}"));
	}

	// Test for wrong method on hello
	@Test
	void testHelloWrongMethod() throws Exception {
		mockMvc.perform(post("/api/hello"))
				.andExpect(status().isMethodNotAllowed());
	}

	// Test for wrong method on ping
	@Test
	void testPingWrongMethod() throws Exception {
		mockMvc.perform(post("/api/ping"))
				.andExpect(status().isMethodNotAllowed());
	}

	// Test for the dummy method
	@Test
	void testDummyMethod() throws Exception {
		// return new ApiResponse(dbConnection.queryDB("SELECT * FROM
		// states").toString());
		Mockito.when(dbConnection.queryDB(anyString())).thenReturn(new JSONObject().put("message", "dummy"));
		mockMvc.perform(get("/api/dummy"))
				.andExpect(status().isOk())
				.andExpect(content().string("{\"message\":\"{\\\"message\\\":\\\"dummy\\\"}\"}"));
	}

	// Test for the state method
	@Test
	void testStateMethod() throws Exception {
		// return new
		// ApiResponse(dbConnection.fetchStateInformationFromDB(stateName).toString());
		Mockito.when(dbConnection.fetchStateInformationFromDB(anyString()))
				.thenReturn(new JSONObject().put("message", "state"));
		mockMvc.perform(get("/api/state/Alabama"))
				.andExpect(status().isOk())
				.andExpect(content().string("{\"message\":\"{\\\"message\\\":\\\"state\\\"}\"}"));
	}

	// Test for wrong method on dummy
	@Test
	void testDummyMethodWrongMethod() throws Exception {
		mockMvc.perform(post("/api/dummy"))
				.andExpect(status().isMethodNotAllowed());
	}

	// Test for wrong method on state
	@Test
	void testStateMethodWrongMethod() throws Exception {
		mockMvc.perform(post("/api/state/Alabama"))
				.andExpect(status().isMethodNotAllowed());
	}
}
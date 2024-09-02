import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.when;
import org.springframework.web.client.*;

import java.io.ByteArrayOutputStream;
import java.io.PrintStream;
import java.util.Arrays;
import java.util.List;
import java.util.Scanner;
import org.json.JSONObject;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import com.freethebeans.GameManager;
import com.freethebeans.GameState;

import net.minidev.json.JSONArray;

public class GameManagerTest {

	@InjectMocks
	GameManager gameManager;

	@Mock
	Scanner scanner;

	@Mock
	RestTemplate restTemplate;

	@BeforeEach
	public void testSetup() {
		scanner = new Scanner(System.in);
		restTemplate = Mockito.mock(RestTemplate.class);
		gameManager = new GameManager(scanner, restTemplate);
	}

	@Test
	void pingPongTest() throws Exception {
		ByteArrayOutputStream outContent = new ByteArrayOutputStream();
		PrintStream originalOut = System.out;
		System.setOut(new PrintStream(outContent));

		JSONObject jsonObject = new JSONObject();
		jsonObject.put("message", "pong");
		String jsonString = jsonObject.toString();
		when(restTemplate.getForObject(anyString(), eq(String.class))).thenReturn(jsonString);

		gameManager.pingPong();
		System.setOut(originalOut);

		// Assert that the message was printed
		assertTrue(outContent.toString().contains(" connected!\n"));
		assertFalse(outContent.toString().contains("Ping did not recieve a pong. Ping is lonely"));

	}

	@Test
	void getGameStateTest() throws Exception{
		String inputState = "dummy";


		String jsonString = "{\"context\":\"This is a dummy state context for testing.\",\"options\":[\"Go to dummyState2.\",\"Go to dummyState3.\"],\"transitions\":[\"dummyState2\",\"dummyState3\"]}";

		JSONObject fullResponse = new JSONObject();
		fullResponse.put("message", jsonString);
		

		when(restTemplate.getForObject(anyString(), eq(String.class))).thenReturn(fullResponse.toString());
		GameState result = gameManager.getGameState(inputState);

		assertEquals("This is a dummy state context for testing.", result.getContext());
		assertEquals(2, result.getOptions().size());
		assertEquals(2, result.getTransitions().size());


	}

}

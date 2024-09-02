package com.freethebeans;

import java.util.List;

public class GameState {
    private String context;
    private List<String> options;
    private List<String> transitions;

    public GameState(String context, List<String> options, List<String> transitions) {
        this.context = context;
        this.options = options;
        this.transitions = transitions;
    }

    public String getContext() {
        return context;
    }

    public List<String> getOptions() {
        return options;
    }

    public List<String> getTransitions() {
        return transitions;
    }
}

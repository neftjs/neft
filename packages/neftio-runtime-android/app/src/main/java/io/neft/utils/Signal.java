package io.neft.utils;

import java.util.ArrayList;
import java.util.List;

public final class Signal {
    private List<Runnable> listeners = new ArrayList<>();

    public void connect(Runnable listener) {
        listeners.add(listener);
    }

    public void disconnect(Runnable listener) {
        listeners.remove(listener);
    }

    public void emit() {
        for (Runnable listener : listeners) {
            listener.run();
        }
    }
}

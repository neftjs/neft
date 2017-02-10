package io.neft;

import java.util.Timer;
import java.util.TimerTask;

class Timers extends Timer {
    private int lastId = 0;

    Timers() {
        Native.timers_init(this);
    }

    public int shot(final int delay) {
        final int id = lastId;
        TimerTask task = new TimerTask(){
            public void run() {
                Native.timers_callback(id);
            }
        };
        schedule(task, delay);
        return lastId++;
    }
}

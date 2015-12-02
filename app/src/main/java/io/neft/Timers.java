package io.neft;

import java.util.Timer;
import java.util.TimerTask;

public class Timers extends Timer {
    public int immediateTimers = 0;
    private int lastId = 0;

    public Timers() {
        Native.timers_init(this);
    }

    public int shot(final int delay) {
        if (delay < 4){
            immediateTimers++;
        }

        final int id = lastId;
        TimerTask task = new TimerTask(){
            public void run() {
                if (delay < 4){
                    immediateTimers--;
                }
                Native.timers_callback(id);
            }
        };
        schedule(task, delay);
        return lastId++;
    }
}

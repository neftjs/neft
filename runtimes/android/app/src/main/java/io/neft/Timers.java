package io.neft;

import java.util.Timer;
import java.util.TimerTask;

class Timers extends Timer {
    private int lastId = 0;

    Timers() {
        Native.Bridge.initTimers(this);
    }

    public int shot(final int delay) {
        final int id = lastId++;
        TimerTask task = new TimerTask(){
            public void run() {
                App.getInstance().getActivity().runOnUiThread(new Runnable() {
                    @Override
                    public void run() {
                        Native.Bridge.callbackTimer(id);
                    }
                });
            }
        };
        schedule(task, delay);
        return id;
    }
}

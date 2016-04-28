package io.neft;

import io.neft.Client.Client;

public class Native extends Thread {
    static {
        System.loadLibrary("neft");
    }

    public static native void init(String js);

    public static native void timers_init(Timers timers);
    public static native void timers_callback(int id);

    public static native void http_init(Http http);
    public static native void http_onResponse(int id, String err, int code, String resp, String cookies);

    public static native void client_init(Client client);
    public static native void client_sendData(byte[] actions, int actionsLength,
                                              boolean[] booleans, int booleansLength,
                                              int[] integers, int integersLength,
                                              float[] floats, int floatsLength,
                                              String[] strings, int stringsLength);

    public static native void renderer_callAnimationFrame();
}

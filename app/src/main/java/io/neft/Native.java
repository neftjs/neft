package io.neft;

import io.neft.Renderer.Renderer;

public class Native {
    static {
        System.loadLibrary("neft");
    }

    static native void init(String js);

    static native void timers_init(Timers timers);
    static native void timers_callback(int id);

    static native void http_init(Http http);
    static native void http_onResponse(int id, String err, int code, String resp, String cookies);

    public static native void renderer_init(Renderer renderer);
    public static native void renderer_callAnimationFrame();
    public static native void renderer_updateView(byte[] actions, int actionsLength,
                                                  boolean[] booleans, int booleansLength,
                                                  int[] integers, int integersLength,
                                                  float[] floats, int floatsLength,
                                                  String[] strings, int stringsLength);
}

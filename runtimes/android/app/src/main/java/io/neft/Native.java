package io.neft;

import android.os.Looper;

import io.neft.client.Client;

public final class Native {
    private static native void init(String js);

    private static native void timers_init(Timers timers);
    private static native void timers_callback(int id);

    private static native void http_init(Http http);
    private static native void http_onResponse(int id, String err, int code, String resp, String cookies);

    private static native void client_init(Client client);
    private static native void client_sendData(byte[] actions, int actionsLength,
                                              boolean[] booleans, int booleansLength,
                                              int[] integers, int integersLength,
                                              float[] floats, int floatsLength,
                                              String[] strings, int stringsLength);

    private static native void renderer_callAnimationFrame();

    public static final class Bridge {
        private static void ensureMainThread() {
            if (Looper.myLooper() != Looper.getMainLooper()) {
                throw new RuntimeException("Native method needs to be called from the main thread");
            }
        }

        public static void init(String js) {
            ensureMainThread();
            Native.init(js);
        }

        public static void initTimers(Timers timers) {
            ensureMainThread();
            Native.timers_init(timers);
        }

        public static void callbackTimer(int id) {
            ensureMainThread();
            Native.timers_callback(id);
        }

        public static void initHttp(Http http) {
            ensureMainThread();
            Native.http_init(http);
        }

        public static void onHttpResponse(int id, String err, int code, String resp, String cookies) {
            ensureMainThread();
            Native.http_onResponse(id, err, code, resp, cookies);
        }

        public static void initClient(Client client) {
            ensureMainThread();
            Native.client_init(client);
        }

        public static void sendClientData(byte[] actions, int actionsLength,
                                          boolean[] booleans, int booleansLength,
                                          int[] integers, int integersLength,
                                          float[] floats, int floatsLength,
                                          String[] strings, int stringsLength) {
            ensureMainThread();
            Native.client_sendData(
                    actions, actionsLength,
                    booleans, booleansLength,
                    integers, integersLength,
                    floats, floatsLength,
                    strings, stringsLength
            );
        }

        public static void callRendererAnimationFrame() {
            ensureMainThread();
            Native.renderer_callAnimationFrame();
        }
    }
}

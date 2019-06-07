package io.neft.extensions.eventsource_extension;

import android.util.SparseArray;

import com.tylerjroach.eventsource.EventSource;

import io.neft.App;
import io.neft.utils.Consumer;

public final class EventSourceExtension {
    private static App APP = App.getInstance();
    static String CONNECT = "NeftEventSource/connect";
    static String CLOSE = "NeftEventSource/close";
    static String ON_CONNECTED = "NeftEventSource/connected";
    static String ON_MESSAGE = "NeftEventSource/message";
    static String ON_ERROR = "NeftEventSource/error";
    static String ON_CLOSED = "NeftEventSource/closed";

    public static void register() {
        final SparseArray<EventSource> instances = new SparseArray<>();

        APP.getClient().addCustomFunction(CONNECT, new Consumer<Object[]>() {
            @Override
            public void accept(Object[] var) {
                Integer uid = ((Number) var[0]).intValue();
                String url = ((String) var[1]);
                EventSource eventSource = new EventSource.Builder(url)
                        .eventHandler(new SSEHandler(uid))
                        .build();
                instances.put(uid, eventSource);
                eventSource.connect();
            }
        });

        APP.getClient().addCustomFunction(CLOSE, new Consumer<Object[]>() {
            @Override
            public void accept(Object[] var) {
                Integer uid = ((Number) var[0]).intValue();
                EventSource eventSource = instances.get(uid);
                if (eventSource == null) return;
                eventSource.close();
            }
        });
    }
}

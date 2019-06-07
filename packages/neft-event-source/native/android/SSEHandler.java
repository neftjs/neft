package io.neft.extensions.eventsource_extension;

import com.tylerjroach.eventsource.EventSourceHandler;
import com.tylerjroach.eventsource.MessageEvent;

import io.neft.App;

class SSEHandler implements EventSourceHandler {
    private static App APP = App.getInstance();
    private Integer uid;

    SSEHandler(Integer uid) {
        this.uid = uid;
    }

    @Override
    public void onConnect() throws Exception {
        APP.getClient().pushEvent(EventSourceExtension.ON_CONNECTED, this.uid);
    }

    @Override
    public void onMessage(String event, MessageEvent message) throws Exception {
        APP.getClient().pushEvent(EventSourceExtension.ON_MESSAGE, this.uid, message.lastEventId, message.data);
    }

    @Override
    public void onComment(String comment) throws Exception {
        // NOP
    }

    @Override
    public void onError(Throwable t) {
        APP.getClient().pushEvent(EventSourceExtension.ON_ERROR, this.uid, t.getMessage());
    }

    @Override
    public void onClosed(boolean willReconnect) {
        APP.getClient().pushEvent(EventSourceExtension.ON_CLOSED, this.uid, willReconnect);
    }
}

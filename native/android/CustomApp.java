package io.neft.customapp;

import io.neft.App;
import io.neft.utils.Consumer;

public class CustomApp {
    public CustomApp() {
        final App app = App.getInstance();
        app.getClient().addCustomFunction("testRequestEventName", new Consumer<Object[]>() {
            @Override
            public void accept(Object[] args) {
                boolean bool = (Boolean) args[0];
                float number = (Float) args[1];
                String string = (String) args[2];
                app.getClient().pushEvent(
                        "testResponseEventName",
                        !bool, number * 2, string.toUpperCase(), args[3]
                );
            }
        });
    }
}

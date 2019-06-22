package io.neft.client;

import android.support.annotation.NonNull;

import io.neft.App;
import io.neft.utils.Consumer;

public class NativeBinding {
    private final static App APP = App.getInstance();
    private final String module;

    public NativeBinding(@NonNull String module) {
        this.module = module;
    }

    private String getFullName(String name) {
        return module + "/" + name;
    }

    public NativeBinding onCall(@NonNull String name, @NonNull Consumer<Object[]> handler) {
        APP.getClient().addCustomFunction(getFullName(name), handler);
        return this;
    }

    public void pushEvent(@NonNull final String name, final Object... args) {
        APP.getActivity().runOnUiThread(new Runnable() {
            @Override
            public void run() {
                APP.getClient().pushEvent(name, args);
            }
        });
    }
}

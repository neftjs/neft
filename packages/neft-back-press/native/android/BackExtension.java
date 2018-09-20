package io.neft.extensions.back_extension;

import io.neft.App;
import io.neft.utils.Consumer;

public final class BackExtension {
    private final static App APP = App.getInstance();

    public static void register() {
        APP.getActivity().onBackPress.connect(new Runnable() {
            @Override
            public void run() {
                APP.getClient().pushEvent("extensionBackOnBackPress");
            }
        });

        APP.getClient().addCustomFunction("extensionBackKillApp", new Consumer<Object[]>() {
            @Override
            public void accept(Object[] var) {
                APP.getActivity().finish();
            }
        });
    }
}

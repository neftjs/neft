package io.neft.extensions.deeplinking_extension;

import io.neft.App;
import io.neft.utils.Consumer;

public final class DeepLinkingExtension {
    private final static App APP = App.getInstance();
    private final static String GET_OPEN_URL = "NeftDeepLinking/getOpenUrl";
    private final static String OPEN_URL_CHANGE = "NeftDeepLinking/openUrlChange";

    public static void register() {
        APP.getClient().addCustomFunction(GET_OPEN_URL, new Consumer<Object[]>() {
            @Override
            public void accept(Object[] var) {
                pushOpenUrlChange();
            }
        });

        APP.onIntentDataChange.connect(new Runnable() {
            @Override
            public void run() {
                pushOpenUrlChange();
            }
        });
    }

    private static void pushOpenUrlChange() {
        APP.getClient().pushEvent(OPEN_URL_CHANGE, APP.getIntentData());
    }
}

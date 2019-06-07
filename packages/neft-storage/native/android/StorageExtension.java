package io.neft.extensions.storage_extension;

import io.neft.App;
import io.neft.utils.Consumer;

public final class StorageExtension {
    private static App APP = App.getInstance();
    static String GET = "NeftStorage/get";
    static String SET = "NeftStorage/set";
    static String REMOVE = "NeftStorage/remove";
    static String ON_RESPONSE = "NeftStorage/response";

    private static FileStorage.Callback createCallback(final String uid) {
        return new FileStorage.Callback() {
            @Override
            void handle(Exception error, String result) {
                String errMsg = error == null ? null : error.getMessage();
                APP.getClient().pushEvent(ON_RESPONSE, uid, errMsg, result);
            }
        };
    }

    public static void register() {
        final FileStorage fileStorage = new FileStorage();

        APP.getClient().addCustomFunction(GET, new Consumer<Object[]>() {
            @Override
            public void accept(Object[] var) {
                String uid = (String) var[0];
                String key = (String) var[1];
                fileStorage.get(key, createCallback(uid));
            }
        });

        APP.getClient().addCustomFunction(SET, new Consumer<Object[]>() {
            @Override
            public void accept(Object[] var) {
                String uid = (String) var[0];
                String key = (String) var[1];
                String value = (String) var[2];
                fileStorage.set(key, value, createCallback(uid));
            }
        });

        APP.getClient().addCustomFunction(REMOVE, new Consumer<Object[]>() {
            @Override
            public void accept(Object[] var) {
                String uid = (String) var[0];
                String key = (String) var[1];
                fileStorage.remove(key, createCallback(uid));
            }
        });
    }
}

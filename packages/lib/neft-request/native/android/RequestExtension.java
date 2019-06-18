package io.neft.extensions.request_extension;

import org.json.JSONException;
import org.json.JSONObject;

import io.neft.App;
import io.neft.utils.Consumer;

public final class RequestExtension {
    private static App APP = App.getInstance();
    static String REQUEST = "NeftRequest/request";
    static String ON_RESPONSE = "NeftRequest/response";

    public static void register() {
        APP.getClient().addCustomFunction(REQUEST, new Consumer<Object[]>() {
            @Override
            public void accept(Object[] var) {
                String uid = (String) var[0];
                String uri = (String) var[1];
                String method = (String) var[2];
                JSONObject headers = null;
                try {
                    headers = new JSONObject((String) var[3]);
                } catch (JSONException e) {
                    // NOP
                }
                String body = (String) var[4];
                Integer timeout = ((Number) var[5]).intValue();
                new HttpRequest(uid, uri, method, headers, body, timeout).resolveAsync();
            }
        });
    }
}

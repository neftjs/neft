package io.neft.extensions.request_extension;

import android.text.TextUtils;
import android.util.Log;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.ByteArrayOutputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import io.neft.App;

class HttpRequest {
    private static App APP = App.getInstance();

    private String uid;
    private String uri;
    private String method;
    private JSONObject headers;
    private String body;
    private Integer timeout;

    HttpRequest(String uid, String uri, String method, JSONObject headers, String body, Integer timeout) {
        this.uid = uid;
        this.uri = uri;
        this.method = method;
        this.headers = headers;
        this.body = body;
        this.timeout = timeout;
    }

    private static class Response {
        final String error;
        final int code;
        final String data;
        final String headers;

        Response(String error, int code, String data, String headers) {
            this.error = error;
            this.code = code;
            this.data = data;
            this.headers = headers;
        }
    }

    static String getStringFromInputStream(InputStream stream) throws IOException {
        ByteArrayOutputStream byteStream = new ByteArrayOutputStream(stream.available());

        int count;
        byte[] buffer = new byte[1024];
        while ((count = stream.read(buffer)) > 0) {
            byteStream.write(buffer, 0, count);
        }

        return byteStream.toString();
    }

    Response resolve() {
        try {
            URL url = new URL(uri);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setUseCaches(false);
            conn.setConnectTimeout(timeout);
            conn.setReadTimeout(timeout);

            // set method
            conn.setRequestMethod(method.toUpperCase());

            // set headers
            if (headers != null) {
                Iterator<String> keys = headers.keys();
                while (keys.hasNext()) {
                    String header = keys.next();
                    String value;
                    try {
                        value = headers.getString(header);
                    } catch (JSONException e) {
                        value = "";
                    }
                    conn.setRequestProperty(header, value);
                }
            }

            try {
                // set data
                if (!method.equals("GET")) {
                    conn.setDoOutput(true);
                    DataOutputStream out = new DataOutputStream(conn.getOutputStream());
                    out.write(body.getBytes());
                }

                // get data code
                int respCode = conn.getResponseCode();

                // read data
                boolean isError = conn.getResponseCode() >= 400;
                String resp = getStringFromInputStream(isError ? conn.getErrorStream() : conn.getInputStream());

                // get headers
                Map<String, String> headers = new HashMap<>();
                Map<String, List<String>> respHeaders = conn.getHeaderFields();
                for (String header : respHeaders.keySet()) {
                    List<String> values = respHeaders.get(header);
                    if (header == null || values == null) continue;
                    headers.put(header, TextUtils.join(";", values));
                }

                return new Response("", respCode, resp, new JSONObject(headers).toString());
            } finally {
                conn.disconnect();
            }
        } catch (IOException error) {
            String respError;
            Log.e("NEFT", "Cannot do http request", error);
            try {
                JSONObject json = new JSONObject();
                json.put("name", "NativeError");
                json.put("type", error.getClass().getSimpleName());
                json.put("message", error.getMessage());
                respError = json.toString();
            } catch (JSONException error2) {
                Log.e("NEFT", "Cannot parse error", error2);
                respError = "InternalError";
            }
            return new Response(respError, 0, "", "{}");
        }
    }

    void sendResponse(final Response response) {
        APP.getActivity().runOnUiThread(new Runnable() {
            @Override
            public void run() {
                APP.getClient().pushEvent(RequestExtension.ON_RESPONSE, uid, response.error, response.code, response.data, response.headers);
            }
        });
    }

    void resolveAsync() {
        Thread thread = new Thread(new Runnable() {
            @Override
            public void run() {
                sendResponse(resolve());
            }
        });

        thread.setName("Http request " + this.uid);
        thread.start();
    }
}

package io.neft;

import android.util.Log;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.ByteArrayOutputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;

class Http {
    private int lastId = 0;

    Http() {
        Native.Bridge.initHttp(this);
    }

    private static class Response {
        final String error;
        final int code;
        final String data;
        final String cookies;

        Response(String error, int code, String data, String cookies) {
            this.error = error;
            this.code = code;
            this.data = data;
            this.cookies = cookies;
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

    private Response doRequestSync(String path, String method, String[] headers, String data) {
        try {
            URL url = new URL(path);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setUseCaches(false);

            // set method
            conn.setRequestMethod(method.toUpperCase());

            // set headers
            for (int i = 0; i < headers.length; i+=2){
                conn.setRequestProperty(headers[i], headers[i+1]);
            }

            try {
                // set data
                if (!method.equals("get")) {
                    conn.setDoOutput(true);
                    DataOutputStream out = new DataOutputStream(conn.getOutputStream());
                    out.write(data.getBytes());
                }

                // get data code
                int respCode = conn.getResponseCode();

                // read data
                boolean isError = conn.getResponseCode() >= 400;
                String resp = getStringFromInputStream(isError ? conn.getErrorStream() : conn.getInputStream());

                // get cookies
                String cookies = conn.getHeaderField("x-cookies");
                if (cookies == null){
                    cookies = "";
                }

                return new Response("", respCode, resp, cookies);
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
            return new Response(respError, 0, "", "");
        }
    }

    private void sendResponse(int id, Response response) {
        Native.Bridge.onHttpResponse(id, response.error, response.code, response.data, response.cookies);
    }

    public int request(final String path, final String method, final String[] headers, final String data) {
        final int id = lastId++;

        Thread thread = new Thread(new Runnable() {
            public void run() {
                final Response response = doRequestSync(path, method, headers, data);
                App.getInstance().getActivity().runOnUiThread(new Runnable() {
                    @Override
                    public void run() {
                        sendResponse(id, response);
                    }
                });
            }
        });

        thread.setName("Http request " + id);
        thread.start();

        return id;
    }
}

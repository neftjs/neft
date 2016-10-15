package io.neft;

import java.io.ByteArrayOutputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;

public class Http {
    private int lastId = 0;

    public Http() {
        Native.http_init(this);
    }

    public static String getStringFromInputStream(InputStream stream) throws IOException {
        ByteArrayOutputStream byteStream = new ByteArrayOutputStream(stream.available());

        int count;
        byte[] buffer = new byte[1024];
        while ((count = stream.read(buffer)) > 0) {
            byteStream.write(buffer, 0, count);
        }

        return byteStream.toString();
    }

    public int request(final String path, final String method, final String[] headers, final String data) {
        final int id = lastId++;

        final Thread t1 = new Thread(new Runnable() {
            public void run() {
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

                        // get response code
                        int respCode = conn.getResponseCode();

                        // end of wrong response code
                        if (respCode >= 400 && respCode < 500){
                            Native.http_onResponse(id, "", respCode, "", "");
                            return;
                        }

                        // read response
                        String resp = getStringFromInputStream(conn.getInputStream());

                        // get cookies
                        String cookies = conn.getHeaderField("x-cookies");
                        if (cookies == null){
                            cookies = "";
                        }

                        Native.http_onResponse(id, "", respCode, resp, cookies);
                    } finally {
                        conn.disconnect();
                    }
                } catch (IOException e) {
                    Native.http_onResponse(id, e.toString(), 0, "", "");
                }
            }
        });

        t1.start();

        return id;
    }
}
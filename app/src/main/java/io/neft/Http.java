package io.neft;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.ProtocolException;
import java.net.URL;

public class Http {
    private int lastId = 0;

    public Http() {
        Native.http_init(this);
    }

    public int request(final String path, final String method, final String[] headers, final String data) {
        final int id = lastId++;

        final Thread t1 = new Thread(new Runnable() {
            public void run() {
                try {
                    URL url = new URL(path);
                    HttpURLConnection conn = (HttpURLConnection) url.openConnection();

                    // set method
                    conn.setRequestMethod(method.toUpperCase());

                    // set headers
                    for (int i = 0; i < headers.length; i+=2){
                        conn.setRequestProperty(headers[i], headers[i+1]);
                    }

                    try {
                        // set data
                        if (!method.equals("get")) {
                            OutputStream out = new BufferedOutputStream(conn.getOutputStream());
                            out.write(data.getBytes());
                        }

                        // read response
                        InputStream in = new BufferedInputStream(conn.getInputStream());
                        InputStreamReader is = new InputStreamReader(in);
                        BufferedReader br = new BufferedReader(is);
                        StringBuilder resp = new StringBuilder();
                        String s = null;
                        while ((s = br.readLine()) != null) {
                            resp.append(s);
                        }

                        // get cookies
                        String cookies = conn.getHeaderField("x-cookies");
                        if (cookies == null){
                            cookies = "";
                        }

                        Native.http_onResponse(id, "", conn.getResponseCode(), resp + "", cookies);
                    } finally {
                        conn.disconnect();
                    }
                } catch (MalformedURLException e) {
                    Native.http_onResponse(id, e.toString(), 0, "", "");
                } catch (ProtocolException e) {
                    Native.http_onResponse(id, e.toString(), 0, "", "");
                } catch (IOException e) {
                    Native.http_onResponse(id, e.toString(), 0, "", "");
                }
            }
        });

        t1.start();

        return id;
    }
}
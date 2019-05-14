package io.neft.extensions.storage_extension;

import android.content.Context;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStreamWriter;

import io.neft.App;

class FileStorage {
    private static App APP = App.getInstance();

    static abstract class Callback {
        abstract void handle(Exception error, String result);
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

    String encodeKey(String key) {
        return "neft_storage_" + key;
    }

    void get(final String key, final Callback callback) {
        new Thread(new Runnable() {
            @Override
            public void run() {
                try {
                    Context context = APP.getActivity().getApplicationContext();
                    InputStream inputStream = context.openFileInput(encodeKey(key));
                    String result = getStringFromInputStream(inputStream);
                    callback.handle(null, result);
                } catch (IOException error) {
                    callback.handle(error, null);
                }
            }
        }).start();
    }

    void set(final String key, final String value, final Callback callback) {
        new Thread(new Runnable() {
            @Override
            public void run() {
                try {
                    Context context = APP.getActivity().getApplicationContext();
                    OutputStreamWriter stream = new OutputStreamWriter(
                            context.openFileOutput(encodeKey(key), Context.MODE_PRIVATE)
                    );
                    stream.write(value);
                    stream.close();
                    callback.handle(null, null);
                } catch (IOException error) {
                    callback.handle(error, null);
                }
            }
        }).start();
    }

    void remove(final String key, final Callback callback) {
        new Thread(new Runnable() {
            @Override
            public void run() {
                Context context = APP.getActivity().getApplicationContext();
                if (context.deleteFile(encodeKey(key))) {
                    callback.handle(null, null);
                } else {
                    callback.handle(new Exception("Cannot remove file"), null);
                }
            }
        }).start();
    }
}

package io.neft;

import android.content.Context;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStreamWriter;

import io.neft.client.Client;
import io.neft.utils.Consumer;

public final class Db {
    private static final App APP = App.getInstance();
    private static final String RESPONSE = "__neftDbResponse";

    private static abstract class Resolver {
        abstract String resolve(Context context) throws IOException;
    }

    public static void register() {
        final Client client = APP.getClient();

        client.addCustomFunction("__neftDbGet", new Consumer<Object[]>() {
            @Override
            public void accept(Object[] args) {
                final String key = encodeKey((String) args[0]);
                float id = (float) args[1];

                resolve(id, new Resolver() {
                    @Override
                    String resolve(Context context) throws IOException {
                        InputStream inputStream = context.openFileInput(key);
                        return Http.getStringFromInputStream(inputStream);
                    }
                });
            }
        });

        client.addCustomFunction("__neftDbSet", new Consumer<Object[]>() {
            @Override
            public void accept(Object[] args) {
                final String key = encodeKey((String) args[0]);
                final String value = (String) args[1];
                float id = (float) args[2];

                resolve(id, new Resolver() {
                    @Override
                    String resolve(Context context) throws IOException {
                        OutputStreamWriter stream = new OutputStreamWriter(
                                context.openFileOutput(key, Context.MODE_PRIVATE)
                        );
                        stream.write(value);
                        stream.close();
                        return null;
                    }
                });
            }
        });

        client.addCustomFunction("__neftDbRemove", new Consumer<Object[]>() {
            @Override
            public void accept(Object[] args) {
                final String key = encodeKey((String) args[0]);
                float id = (float) args[1];

                resolve(id, new Resolver() {
                    @Override
                    String resolve(Context context) throws IOException {
                        context.deleteFile(key);
                        return null;
                    }
                });
            }
        });
    }

    private static String encodeKey(String key) {
        return "__neftDb_" + key;
    }

    private static void resolve(final float id, final Resolver resolver) {
        new Thread(new Runnable() {
            @Override
            public void run() {
                Context context = APP.getActivity().getApplicationContext();
                String result;
                try {
                    result = resolver.resolve(context);
                } catch (IOException error) {
                    APP.getClient().pushEvent(RESPONSE, id, error.getMessage(), null);
                    return;
                }
                APP.getClient().pushEvent(RESPONSE, id, null, result);
            }
        }).start();
    }

    private Db() {}
}

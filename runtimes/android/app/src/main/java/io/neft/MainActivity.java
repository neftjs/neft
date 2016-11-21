package io.neft;

import android.os.Handler;
import android.support.annotation.NonNull;
import android.support.v4.app.FragmentActivity;
import android.util.Log;
import android.view.MotionEvent;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;

import io.neft.client.Client;
import io.neft.customapp.CustomApp;
import io.neft.client.annotation.Parser;
import io.neft.renderer.Image;
import io.neft.renderer.Item;
import io.neft.renderer.NativeItem;
import io.neft.renderer.Rectangle;
import io.neft.renderer.Renderer;
import io.neft.renderer.Text;
import io.neft.renderer.WindowView;

public class MainActivity extends FragmentActivity {
    public abstract class UrlResponse implements Runnable {
        public abstract void run(String response);
        public void run() {}
    }

    private static final String TAG = "Neft";

    public WindowView view;
    public CustomApp customApp;
    public Http http;
    public Timers timers;
    public Client client;
    public Renderer renderer;

    protected void initExtensions() {}

    protected void init(final String code) {
        App.app = this;
        customApp = new CustomApp();
        http = new Http();
        timers = new Timers();
        client = new Client();
        renderer = new Renderer();
        renderer.app = this;
        view.renderer = renderer;

        Parser.registerHandlers(WindowView.class);
        Parser.registerHandlers(Item.class);
        Parser.registerHandlers(Rectangle.class);
        Parser.registerHandlers(Image.class);
        Parser.registerHandlers(Text.class);
        Parser.registerHandlers(NativeItem.class);
        renderer.init(this);

        initExtensions();

        Native.init(code);
    }

    protected void restart() {
        throw new UnsupportedOperationException();
    }

    @NonNull
    protected String getAssetFile(String path) {
        try {
            return Http.getStringFromInputStream(this.getAssets().open(path));
        } catch (IOException error) {
            Log.d(TAG, "IO ERROR!");
            Log.d(TAG, error.toString());
        }
        return "";
    }

    protected void getUrlData(final String path, final UrlResponse onResponse) {
        Thread thread = new Thread(new Runnable() {
            @Override
            public void run() {
                String resp = null;
                try {
                    URL url = new URL(path);
                    HttpURLConnection conn = (HttpURLConnection) url.openConnection();
                    conn.setUseCaches(false);
                    resp = Http.getStringFromInputStream(conn.getInputStream());
                } catch (IOException err) {
                    Log.w(TAG, "Watch mode does not work; cannot connect to " + path);
                }
                final String finalResp = resp;
                runOnUiThread(new Runnable() {
                    @Override
                    public void run() {
                        onResponse.run(finalResp);
                    }
                });
            }
        });

        thread.start();
    }

    protected void watchOnBundleChange(final String path) {
        getUrlData(path, new UrlResponse() {
            @Override
            public void run(String response) {
                if (response != null) {
                    restart();
                    return;
                }
                new Handler().postDelayed(new Runnable() {
                    @Override
                    public void run() {
                        watchOnBundleChange(path);
                    }
                }, 30000);
            }
        });
    }

    @Override
    public boolean dispatchTouchEvent(MotionEvent event) {
        renderer.device.onTouchEvent(event);
        return super.dispatchTouchEvent(event);
    }

}

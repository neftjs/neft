package io.neft;

import android.os.Handler;
import android.util.Log;
import android.view.Choreographer;
import android.view.KeyEvent;
import android.view.MotionEvent;
import android.view.ViewTreeObserver;
import io.neft.client.Client;
import io.neft.customapp.CustomApp;
import io.neft.renderer.*;
import lombok.Getter;
import lombok.NonNull;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

public class App {
    private abstract class UrlResponse implements Runnable {
        public abstract void run(String response);
        public void run() {}
    }

    private class FullKeyEvent {
        final int keyCode;
        final KeyEvent keyEvent;

        FullKeyEvent(int keyCode, KeyEvent keyEvent) {
            this.keyCode = keyCode;
            this.keyEvent = keyEvent;
        }
    }

    private static final String TAG = "Neft";
    private static final String ASSET_FILE_PATH = "javascript/neft.js";
    private static final App INSTANCE = new App();
    private static final Choreographer CHOREOGRAPHER = Choreographer.getInstance();
    @Getter private MainActivity activity;
    @Getter private WindowView windowView;
    private CustomApp customApp;
    @Getter private Client client;
    @Getter private Renderer renderer;
    private final UiThreadFrame uiThreadFrame;
    private final FrameCallback frameCallback;
    private final List<MotionEvent> touchEvents = new ArrayList<>();
    private final List<FullKeyEvent> keyEvents = new ArrayList<>();

    public static App getInstance() {
        return INSTANCE;
    }

    private class UiThreadFrame implements Runnable {
        @Override
        public void run() {
            CHOREOGRAPHER.postFrameCallback(frameCallback);
            onAnimationFrame();
        }
    }

    private class FrameCallback implements Choreographer.FrameCallback {
        @Override
        public void doFrame(long frameTimeNanos) {
            uiThreadFrame.run();
        }
    }

    private App() {
        uiThreadFrame = new UiThreadFrame();
        frameCallback = new FrameCallback();
    }

    private void onAnimationFrame() {
        synchronized (touchEvents) {
            while (!touchEvents.isEmpty()) {
                MotionEvent event = touchEvents.remove(0);
                renderer.getDevice().onTouchEvent(event);
                event.recycle();
            }
        }
        synchronized (keyEvents) {
            while (!keyEvents.isEmpty()) {
                FullKeyEvent fullKeyEvent = keyEvents.remove(0);
                renderer.getDevice().onKeyEvent(fullKeyEvent.keyCode, fullKeyEvent.keyEvent);
            }
        }
        client.sendData();
        Native.Bridge.callRendererAnimationFrame();
        windowView.windowItem.measure();
        Item.onAnimationFrame();
    }

    public WindowView getWindowView() {
        return windowView;
    }

    public void run() {
        System.loadLibrary("neft");

        new Http();
        new Timers();
        client = new Client();
        renderer = new Renderer();
        Db.register();

        Device.register();
        WindowView.register();
        Item.register();
        Rectangle.register();
        Image.register();
        Text.register();
        NativeItem.register();

        renderer.init();
        AppConfig.initExtensions();

        customApp = new CustomApp();
        loadCode();

        activity.runOnUiThread(uiThreadFrame);
    }

    public void attach(@NonNull MainActivity activity) {
        boolean isFirstAttach = this.activity == null;

        this.activity = activity;

        if (isFirstAttach) {
            windowView = new WindowView(activity.getApplicationContext());
            startWhenReady();
        }
    }

    public void processTouchEvent(@NonNull MotionEvent event) {
        // call press events synchronously to know which native items should handle further events
        if (event.getAction() == MotionEvent.ACTION_DOWN) {
            renderer.getDevice().onTouchEvent(event);
            client.sendData();
            return;
        }

        MotionEvent eventToProcess = MotionEvent.obtain(event);
        synchronized (touchEvents) {
            int lastIndex = touchEvents.size() - 1;
            MotionEvent lastEvent = lastIndex >= 0 ? touchEvents.get(lastIndex) : null;
            if (lastEvent != null && lastEvent.getAction() == eventToProcess.getAction()) {
                lastEvent.recycle();
                touchEvents.set(lastIndex, eventToProcess);
            } else {
                touchEvents.add(eventToProcess);
            }
        }
    }

    public void processKeyEvent(int keyCode, @NonNull KeyEvent event) {
        synchronized (keyEvents) {
            keyEvents.add(new FullKeyEvent(keyCode, event));
        }
    }

    private void startWhenReady() {
        windowView.getViewTreeObserver().addOnGlobalLayoutListener(new ViewTreeObserver.OnGlobalLayoutListener() {
            @Override
            public void onGlobalLayout() {
                windowView.getViewTreeObserver().removeOnGlobalLayoutListener(this);
                run();
            }
        });
    }

    private void loadCode() {
        if (AppConfig.CODE_WATCH_CHANGES_URL == null) {
            String code = getAssetFile(ASSET_FILE_PATH);
            Native.Bridge.init(code);
        } else {
            loadRemoteCode();
        }
    }

    private void loadRemoteCode() {
        final String[] codeArray = {null};
        Thread reqThread = getUrlDataAsync(AppConfig.CODE_WATCH_CHANGES_URL + "/bundle/android", new UrlResponse() {
            @Override
            public void run(String response) {
                codeArray[0] = response;
            }
        });
        try {
            reqThread.join();
        } catch (InterruptedException error) {
            error.printStackTrace();
        }
        String code = codeArray[0];
        if (code == null) {
            code = getAssetFile(ASSET_FILE_PATH);
        }
        Native.Bridge.init(code);
        watchOnBundleChange(AppConfig.CODE_WATCH_CHANGES_URL + "/onNewBundle/android");
    }

    private String getAssetFile(String path) {
        try {
            return Http.getStringFromInputStream(activity.getAssets().open(path));
        } catch (IOException error) {
            Log.d(TAG, "IO ERROR!");
            Log.d(TAG, error.toString());
        }
        return "";
    }

    private Thread getUrlDataAsync(final String path, final UrlResponse onResponse) {
        Thread thread = new Thread(new Runnable() {
            @Override
            public void run() {
                String resp = null;
                try {
                    URL url = new URL(path);
                    HttpURLConnection conn = (HttpURLConnection) url.openConnection();
                    conn.setUseCaches(false);
                    conn.setConnectTimeout(1000);
                    resp = Http.getStringFromInputStream(conn.getInputStream());
                } catch (IOException err) {
                    Log.w(TAG, "Watch mode does not work; cannot connect to " + path);
                }
                onResponse.run(resp);
            }
        });

        thread.start();

        return thread;
    }

    private void watchOnBundleChange(final String path) {
        getUrlDataAsync(path, new UrlResponse() {
            @Override
            public void run(final String response) {
                activity.runOnUiThread(new Runnable() {
                    @Override
                    public void run() {
                        if (response == null) {
                            new Handler().postDelayed(new Runnable() {
                                @Override
                                public void run() {
                                    watchOnBundleChange(path);
                                }
                            }, 30000);
                            return;
                        }
                        if (response.isEmpty()) {
                            AppConfig.restart();
                            return;
                        }
                        client.pushEvent("__neftHotReload", response);
                        watchOnBundleChange(path);
                    }
                });
            }
        });
    }
}

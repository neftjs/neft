package io.neft;

import android.os.Handler;
import android.util.Log;
import android.view.Choreographer;
import android.view.KeyEvent;
import android.view.MotionEvent;
import android.view.ViewTreeObserver;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.ThreadFactory;

import io.neft.client.Client;
import io.neft.client.annotation.Parser;
import io.neft.customapp.CustomApp;
import io.neft.renderer.Image;
import io.neft.renderer.Item;
import io.neft.renderer.NativeItem;
import io.neft.renderer.Rectangle;
import io.neft.renderer.Renderer;
import io.neft.renderer.Text;
import lombok.Getter;
import lombok.NonNull;

public class App extends Thread {
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
    @Getter private MainActivity activity;
    @Getter private WindowView windowView;
    private String codeWatchChangesUrl;
    private CustomApp customApp;
    @Getter private Client client;
    @Getter private Renderer renderer;
    private final Choreographer.FrameCallback frameCallback;
    private final ExecutorService threadExecutor = Executors.newSingleThreadExecutor(
            new ThreadFactory() {
                @Override
                public Thread newThread(Runnable runnable) {
                    return new Thread(runnable, "javascript");
                }
            }
    );
    private Runnable initExtensions;
    private Runnable restart;
    private boolean framePending;
    private final Runnable animationFrameRunnable;
    private final List<MotionEvent> touchEvents = new ArrayList<>();
    private final List<FullKeyEvent> keyEvents = new ArrayList<>();

    public static App getInstance() {
        return INSTANCE;
    }

    private App() {
        setName("APP");
        frameCallback = new Choreographer.FrameCallback() {
            @Override
            public void doFrame(long frameTimeNanos) {
                onFrame();
            }
        };
        animationFrameRunnable = new Runnable() {
            @Override
            public void run() {
                onAnimationFrame();
            }
        };
    }

    // PoolThread
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
        Native.renderer_callAnimationFrame();
        framePending = false;
    }

    // UiThread
    private void onFrame() {
        Choreographer.getInstance().postFrameCallback(frameCallback);
        if (!framePending) {
            framePending = true;
            threadExecutor.submit(animationFrameRunnable);
        }
    }

    @Override
    public void run() {
        System.loadLibrary("neft");

        new Http();
        new Timers();
        client = new Client();
        renderer = new Renderer();
        Db.register();

        Parser.registerHandlers(WindowView.class);
        Parser.registerHandlers(Item.class);
        Parser.registerHandlers(Rectangle.class);
        Parser.registerHandlers(Image.class);
        Parser.registerHandlers(Text.class);
        Parser.registerHandlers(NativeItem.class);

        renderer.init();
        if (initExtensions != null) {
            initExtensions.run();
        }

        customApp = new CustomApp();
        loadCode();

        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                onFrame();
            }
        });
    }

    public void attach(
            @NonNull MainActivity activity,
            String codeWatchChangesUrl,
            Runnable initExtensions,
            Runnable restart
    ) {
        if (isAlive()) {
            throw new IllegalStateException("Attach needs to be called before starting APP thread");
        }
        if (this.activity != null) {
            throw new IllegalStateException("App thread cannot be attached multiple times");
        }
        this.activity = activity;
        this.windowView = activity.view;
        this.codeWatchChangesUrl = codeWatchChangesUrl;
        this.initExtensions = initExtensions;
        this.restart = restart;

        startWhenReady();
    }

    public void processTouchEvent(@NonNull MotionEvent event) {
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
                start();
            }
        });
    }

    private void loadCode() {
        if (codeWatchChangesUrl == null) {
            String code = getAssetFile(ASSET_FILE_PATH);
            Native.init(code);
        } else {
            String code = getUrlData(codeWatchChangesUrl + "/bundle/android");
            if (code == null) {
                code = getAssetFile(ASSET_FILE_PATH);
            }
            Native.init(code);
            watchOnBundleChange(codeWatchChangesUrl + "/onNewBundle/android");
        }
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

    private String getUrlData(String path) {
        String resp = null;
        try {
            URL url = new URL(path);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setUseCaches(false);
            resp = Http.getStringFromInputStream(conn.getInputStream());
        } catch (IOException err) {
            Log.w(TAG, "Watch mode does not work; cannot connect to " + path);
        }
        return resp;
    }

    private void getUrlDataAsync(final String path, final UrlResponse onResponse) {
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
                activity.runOnUiThread(new Runnable() {
                    @Override
                    public void run() {
                        onResponse.run(finalResp);
                    }
                });
            }
        });

        thread.start();
    }

    private void watchOnBundleChange(final String path) {
        getUrlDataAsync(path, new UrlResponse() {
            @Override
            public void run(String response) {
                if (response != null) {
                    restart.run();
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
}

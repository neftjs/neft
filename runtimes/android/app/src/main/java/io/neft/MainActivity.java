package io.neft;

import android.content.res.AssetManager;
import android.os.Bundle;
import android.support.v4.app.FragmentActivity;
import android.util.Log;
import android.view.MotionEvent;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

import io.neft.Client.Client;
import io.neft.CustomApp.CustomApp;
import io.neft.Renderer.Renderer;
import io.neft.Renderer.WindowView;

public class MainActivity extends FragmentActivity {

    private static final String TAG = "Neft";

    public WindowView view;
    public CustomApp customApp;
    final public Http http = new Http();
    final public Timers timers = new Timers();
    final public Client client = new Client();
    final public Renderer renderer = new Renderer();

    protected void init(){
        // get javascript file
        String neft = getAssetFile("javascript/neft.js");

        // initialize
        this.customApp = new CustomApp(this);
        renderer.app = this;
        view.renderer = renderer;
        renderer.init(this);

        Native.init(neft);
        renderer.onAnimationFrame();
    }

    private String getAssetFile(String path) {
        try {
            AssetManager assets = this.getAssets();
            InputStream inputStream = assets.open(path);
            BufferedReader r = new BufferedReader(new InputStreamReader(inputStream));
            StringBuilder total = new StringBuilder();
            String line;
            while ((line = r.readLine()) != null) {
                total.append(line);
                total.append("\n");
            }
            return total.toString();
        } catch (IOException error) {
            Log.d(TAG, "IO ERROR!");
            Log.d(TAG, error.toString());
        }
        return "";
    }

    @Override
    public boolean onTouchEvent(MotionEvent event) {
        return renderer.device.onTouchEvent(event);
    }

}
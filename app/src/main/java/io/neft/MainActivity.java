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

import io.neft.Renderer.Renderer;
import io.neft.Renderer.WindowView;

public class MainActivity extends FragmentActivity {

    private static final String TAG = "Neft";

    public WindowView view;
    public Timers timers;
    public Renderer renderer;

    protected void init(){
        // get javascript file
        String neft = getAssetFile("javascript/neft.js");

        // initialize
        new Http();
        this.timers = new Timers();
        this.renderer = new Renderer(this);

        Native.init(neft);
        renderer.run();
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

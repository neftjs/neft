package io.neft;

import android.app.Activity;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.view.KeyEvent;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;

public class MainActivity extends Activity {
    private static final App APP = App.getInstance();
    protected WindowView view;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        APP.attach(this);

        super.onCreate(savedInstanceState);

        // transparent status bar
        getWindow().getDecorView().setSystemUiVisibility(
                View.SYSTEM_UI_FLAG_LAYOUT_STABLE | View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN
        );

        APP.load();
        view = APP.getWindowView();

        if (view.getParent() != null) {
            ViewGroup parent = (ViewGroup) this.view.getParent();
            parent.removeView(view);
        }

        setContentView(view);

        Intent intent = getIntent();
        APP.intentData = intent.getDataString();
        APP.onIntentDataChange.emit();
    }

    @Override
    public void onBackPressed() {
        APP.onBackPress.emit();
    }

    @Override
    public boolean dispatchTouchEvent(MotionEvent event) {
        App.getInstance().processTouchEvent(event);
        return super.dispatchTouchEvent(event);
    }

    private void onKeyEvent(int keyCode, KeyEvent event) {
        APP.processKeyEvent(keyCode, event);
    }

    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event){
        onKeyEvent(keyCode, event);
        return super.onKeyDown(keyCode, event);
    }

    @Override
    public boolean onKeyUp(int keyCode, KeyEvent event){
        onKeyEvent(keyCode, event);
        return super.onKeyUp(keyCode, event);
    }

    @Override
    public boolean onKeyMultiple(int keyCode, int repeatCount, KeyEvent event){
        onKeyEvent(keyCode, event);
        return super.onKeyMultiple(keyCode, repeatCount, event);
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        boolean granted = grantResults.length > 0 && grantResults[0] == PackageManager.PERMISSION_GRANTED;
        APP.getPermissions().handleRequestPermissionsResult(requestCode, granted);
    }
}

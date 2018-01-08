package io.neft;

import android.app.Activity;
import android.os.Bundle;
import android.view.MotionEvent;
import android.view.ViewGroup;
import android.view.WindowManager;

public class MainActivity extends Activity {
    private static final App APP = App.getInstance();
    protected WindowView view;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        APP.attach(this);

        view = APP.getWindowView();
        setContentView(view);

        // transparent status bar
        getWindow().setFlags(WindowManager.LayoutParams.FLAG_LAYOUT_NO_LIMITS,
                WindowManager.LayoutParams.FLAG_LAYOUT_NO_LIMITS);
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();

        ViewGroup parent = (ViewGroup) this.view.getParent();
        parent.removeView(view);
        this.view = null;
    }

    @Override
    public boolean dispatchTouchEvent(MotionEvent event) {
        App.getInstance().processTouchEvent(event);
        return super.dispatchTouchEvent(event);
    }
}

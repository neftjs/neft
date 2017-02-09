package io.neft;

import android.app.Activity;
import android.view.MotionEvent;

public class MainActivity extends Activity {
    protected WindowView view;

    @Override
    public boolean dispatchTouchEvent(MotionEvent event) {
        App.getInstance().processTouchEvent(event);
        return super.dispatchTouchEvent(event);
    }
}

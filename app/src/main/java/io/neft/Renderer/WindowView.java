package io.neft.Renderer;

import android.content.Context;
import android.graphics.Canvas;
import android.text.InputType;
import android.util.AttributeSet;
import android.util.Log;
import android.view.KeyEvent;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.view.inputmethod.BaseInputConnection;
import android.view.inputmethod.EditorInfo;
import android.view.inputmethod.InputConnection;
import android.widget.RelativeLayout;

public class WindowView extends ViewGroup {
    public Item windowItem;
    public Renderer renderer;

    static void register(Renderer renderer){
        renderer.actions.put(Renderer.InAction.SET_WINDOW, new Action() {
            @Override
            void work(Reader reader) {
                reader.renderer.window.windowItem = reader.getItem();
            }
        });
    }

    public WindowView(Context context, AttributeSet attrs){
        super(context, attrs);
        this.setWillNotDraw(false);
        this.requestFocus();
    }

    @Override
    protected void onLayout(boolean changed, int l, int t, int r, int b){
    }

    @Override
    protected void onDraw(Canvas canvas){
        if (windowItem != null){
            windowItem.draw(canvas, 255);
        }
    }

    @Override
    public boolean onTouchEvent(MotionEvent event){
        return renderer.device.onTouchEvent(event);
    }

    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event){
        return renderer.device.onKey(keyCode, event);
    }

    @Override
    public boolean onKeyUp(int keyCode, KeyEvent event){
        return renderer.device.onKey(keyCode, event);
    }

    @Override
    public boolean onKeyMultiple(int keyCode, int repeatCount, KeyEvent event){
        return renderer.device.onKey(keyCode, event);
    }

    @Override
    public boolean onKeyPreIme(int keyCode, KeyEvent event){
        return renderer.device.onKey(keyCode, event);
    }
}

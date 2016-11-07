package io.neft.renderer;

import android.content.Context;
import android.util.AttributeSet;
import android.view.KeyEvent;
import android.view.MotionEvent;
import android.widget.RelativeLayout;

import io.neft.App;
import io.neft.client.InAction;
import io.neft.client.Reader;
import io.neft.MainActivity;
import io.neft.client.annotation.OnAction;

public class WindowView extends RelativeLayout {
    public Item windowItem;
    public Renderer renderer;

    @OnAction(InAction.SET_WINDOW)
    public static void setWindow(Reader reader) {
        Item item = App.getApp().renderer.getItemFromReader(reader);
        App.getApp().view.addView(item.view);
    }

    static void register(final MainActivity app){
    }

    public WindowView(Context context, AttributeSet attrs){
        super(context, attrs);

        this.requestFocus();
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

package io.neft;

import android.content.Context;
import android.util.AttributeSet;
import android.view.KeyEvent;
import android.widget.RelativeLayout;

import io.neft.client.InAction;
import io.neft.client.Reader;
import io.neft.client.annotation.OnAction;
import io.neft.renderer.Item;

public class WindowView extends RelativeLayout {
    private static final App APP = App.getInstance();

    @OnAction(InAction.SET_WINDOW)
    public static void setWindow(Reader reader) {
        Item item = APP.getRenderer().getItemFromReader(reader);
        APP.getWindowView().addView(item.view);
    }

    public WindowView(Context context, AttributeSet attrs){
        super(context, attrs);

        this.requestFocus();
    }

    private boolean onKeyEvent(int keyCode, KeyEvent event) {
        APP.processKeyEvent(keyCode, event);
        return keyCode == KeyEvent.KEYCODE_BACK;
    }

    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event){
        return onKeyEvent(keyCode, event);
    }

    @Override
    public boolean onKeyUp(int keyCode, KeyEvent event){
        return onKeyEvent(keyCode, event);
    }

    @Override
    public boolean onKeyMultiple(int keyCode, int repeatCount, KeyEvent event){
        return onKeyEvent(keyCode, event);
    }

    @Override
    public boolean onKeyPreIme(int keyCode, KeyEvent event){
        return onKeyEvent(keyCode, event);
    }
}

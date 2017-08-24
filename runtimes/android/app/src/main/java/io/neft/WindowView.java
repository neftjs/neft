package io.neft;

import android.content.Context;
import android.graphics.Color;
import android.util.AttributeSet;
import android.view.KeyEvent;
import android.view.View;
import android.widget.RelativeLayout;

import io.neft.client.InAction;
import io.neft.client.Reader;
import io.neft.client.handlers.ReaderActionHandler;
import io.neft.renderer.Item;
import io.neft.renderer.ItemView;
import io.neft.renderer.Rectangle;
import io.neft.utils.ColorValue;

public class WindowView extends ItemView {
    private static final App APP = App.getInstance();
    Item windowItem;

    public static void register() {
        APP.getClient().onAction(InAction.SET_WINDOW, new ReaderActionHandler() {
            @Override
            public void accept(Reader reader) {
                setWindow(APP.getRenderer().getItemFromReader(reader));
            }
        });
    }

    public static void setWindow(Item item) {
        WindowView windowView = APP.getWindowView();
        windowView.windowItem = item;
        windowView.addView(item.view);
    }

    public WindowView(Context context){
        super(context);
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

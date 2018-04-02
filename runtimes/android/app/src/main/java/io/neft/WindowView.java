package io.neft;

import android.content.Context;
import android.graphics.Color;
import android.view.KeyEvent;
import io.neft.client.InAction;
import io.neft.client.OutAction;
import io.neft.client.Reader;
import io.neft.client.handlers.ReaderActionHandler;
import io.neft.renderer.Item;
import io.neft.renderer.ItemView;
import io.neft.renderer.Renderer;

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
        requestFocus();
        setBackgroundColor(Color.WHITE);
    }

    @Override
    protected void onSizeChanged(int width, int height, int oldw, int oldh) {
        super.onSizeChanged(width, height, oldw, oldh);

        Renderer renderer = APP.getRenderer();
        if (renderer == null) {
            return;
        }
        float dpWidth = renderer.pxToDp(width);
        float dpHeight = renderer.pxToDp(height);
        System.out.println("RESIZE TO " + dpWidth + "x" + dpHeight);
        APP.getClient().pushAction(OutAction.WINDOW_RESIZE, dpWidth, dpHeight);
    }
}

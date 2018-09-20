package io.neft.renderer;

import android.content.res.Resources;
import android.graphics.RectF;
import android.os.Build;
import android.view.View;
import io.neft.App;
import io.neft.client.InAction;
import io.neft.client.OutAction;
import io.neft.client.handlers.StringActionHandler;

final public class Screen {
    private static final App APP = App.getInstance();
    private float width;
    private float height;
    private RectF rect;

    public static void register() {
        APP.getClient().onAction(InAction.SET_SCREEN_STATUSBAR_COLOR, new StringActionHandler() {
            @Override
            public void accept(String value) {
                setStatusBarColor(value);
            }
        });

        setStatusBarColor("Dark");
    }

    static void setStatusBarColor(String value) {
        View decorView = APP.getActivity().getWindow().getDecorView();
        int flags = decorView.getSystemUiVisibility();
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            if ("Light".equals(value)) {
                flags &= ~View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR;
                decorView.setSystemUiVisibility(flags);
            } else {
                decorView.setSystemUiVisibility(flags | View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);
            }
        }
    }

    static void init(Screen screen) {
        Resources resources = APP.getActivity().getResources();

        // SCREEN_SIZE
        View windowView = APP.getWindowView();
        final float pixelRatio = APP.getRenderer().getDevice().getPixelRatio();
        screen.width = windowView.getWidth() / pixelRatio;
        screen.height = windowView.getHeight() / pixelRatio;
        screen.rect = new RectF(0, 0, windowView.getWidth(), windowView.getHeight());
        APP.getClient().pushAction(OutAction.SCREEN_SIZE, screen.width, screen.height);

        // SCREEN_STATUSBAR_HEIGHT
        float statusBarHeight = 0;
        int resourceId = resources.getIdentifier("status_bar_height", "dimen", "android");
        if (resourceId > 0) {
            statusBarHeight = APP.getRenderer().pxToDp(resources.getDimensionPixelSize(resourceId));
        }
        APP.getClient().pushAction(OutAction.SCREEN_STATUSBAR_HEIGHT, statusBarHeight);
    }
}

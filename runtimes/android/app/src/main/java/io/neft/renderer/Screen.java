package io.neft.renderer;

import android.graphics.RectF;
import android.view.View;

import io.neft.App;
import io.neft.client.OutAction;

final class Screen {
    private static final App APP = App.getInstance();
    private float width;
    private float height;
    private RectF rect;

    static void init(Screen screen) {
        // SCREEN_SIZE
        View windowView = APP.getWindowView();
        final float pixelRatio = APP.getRenderer().getDevice().getPixelRatio();
        screen.width = windowView.getWidth() / pixelRatio;
        screen.height = windowView.getHeight() / pixelRatio;
        screen.rect = new RectF(0, 0, windowView.getWidth(), windowView.getHeight());

        APP.getClient().pushAction(OutAction.SCREEN_SIZE, screen.width, screen.height);
    }
}

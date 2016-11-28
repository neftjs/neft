package io.neft.renderer;

import android.graphics.RectF;
import android.util.DisplayMetrics;
import android.view.View;

import io.neft.client.OutAction;
import io.neft.MainActivity;

public class Screen {

    public float width;
    public float height;
    public RectF rect;

    static void init(Screen screen, MainActivity app) {
        View windowView = app.view;

        // SCREEN_SIZE
        final float pixelRatio = app.renderer.device.pixelRatio;
        screen.width = windowView.getWidth() / pixelRatio;
        screen.height = windowView.getHeight() / pixelRatio;
        screen.rect = new RectF(0, 0, windowView.getWidth(), windowView.getHeight());

        app.client.pushAction(OutAction.SCREEN_SIZE);
        app.client.pushFloat(screen.width);
        app.client.pushFloat(screen.height);
    }

    static void register(MainActivity app) {}

}

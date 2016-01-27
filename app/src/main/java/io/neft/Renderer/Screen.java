package io.neft.Renderer;

import android.graphics.RectF;
import android.util.DisplayMetrics;

import io.neft.Client.OutAction;
import io.neft.MainActivity;

public class Screen {

    public float width;
    public float height;
    public RectF rect;

    static void init(Screen screen, MainActivity app) {
        DisplayMetrics metrics = app.getResources().getDisplayMetrics();

        // SCREEN_SIZE
        final float pixelRatio = app.renderer.device.pixelRatio;
        screen.width = metrics.widthPixels / pixelRatio;
        screen.height = metrics.heightPixels / pixelRatio;
        screen.rect = new RectF(0, 0, metrics.widthPixels, metrics.heightPixels);

        app.client.pushAction(OutAction.SCREEN_SIZE);
        app.client.pushFloat(screen.width);
        app.client.pushFloat(screen.height);
    }

    static void register(MainActivity app) {}

}

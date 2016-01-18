package io.neft.Renderer;

import android.graphics.RectF;
import android.view.Display;

import io.neft.Client.OutAction;
import io.neft.MainActivity;

public class Screen {

    public float width;
    public float height;
    public RectF rect;

    static void init(Screen screen, MainActivity app) {
        Display display = app.getWindowManager().getDefaultDisplay();

        // SCREEN_SIZE
        final float pixelRatio = app.renderer.device.pixelRatio;
        screen.width = display.getWidth() / pixelRatio;
        screen.height = display.getHeight() / pixelRatio;
        screen.rect = new RectF(0, 0, display.getWidth(), display.getHeight());

        app.client.pushAction(OutAction.SCREEN_SIZE);
        app.client.pushFloat(screen.width);
        app.client.pushFloat(screen.height);
    }

    static void register(MainActivity app) {}

}

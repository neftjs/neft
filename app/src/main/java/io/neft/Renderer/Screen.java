package io.neft.Renderer;

import android.graphics.RectF;
import android.view.Display;

public class Screen {

    public final float width;
    public final float height;
    public final RectF rect;

    static void register(Renderer renderer){}

    public Screen(Renderer renderer) {
        Display display = renderer.mainActivity.getWindowManager().getDefaultDisplay();

        // SCREEN_SIZE
        final float pixelRatio = renderer.device.pixelRatio;
        this.width = display.getWidth() / pixelRatio;
        this.height = display.getHeight() / pixelRatio;
        this.rect = new RectF(0, 0, display.getWidth(), display.getHeight());

        renderer.pushAction(Renderer.OutAction.SCREEN_SIZE);
        renderer.pushFloat(width);
        renderer.pushFloat(height);
    }

}

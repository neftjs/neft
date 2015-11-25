package io.neft.Renderer;

import android.graphics.Point;
import android.util.DisplayMetrics;
import android.util.Log;
import android.view.Display;

public class Screen {

    public final float width;
    public final float height;

    static void register(Renderer renderer){}

    public Screen(Renderer renderer) {
        Display display = renderer.mainActivity.getWindowManager().getDefaultDisplay();

        // screen size
        final float pixelRatio = renderer.device.pixelRatio;
        this.width = display.getWidth() / pixelRatio;// + (pixelRatio % 1 > 0 ? 1 : 0);
        this.height = display.getHeight() / pixelRatio;// + (pixelRatio % 1 > 0 ? 1 : 0);

        renderer.pushAction(Renderer.OutAction.SCREEN_SIZE);
        renderer.pushFloat(width);
        renderer.pushFloat(height);
    }

}

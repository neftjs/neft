package io.neft.Renderer;

import android.content.res.Configuration;
import android.util.DisplayMetrics;

public class Device {

    public final float pixelRatio;
    public final boolean isPhone;

    static void register(Renderer renderer){}

    public Device(Renderer renderer){
        DisplayMetrics metrics = renderer.mainActivity.getResources().getDisplayMetrics();

        // DEVICE_PIXEL_RATIO
        this.pixelRatio = metrics.density;
        renderer.pushAction(Renderer.OutAction.DEVICE_PIXEL_RATIO);
        renderer.pushFloat(pixelRatio);

        // DEVICE_IS_PHONE
        this.isPhone = (renderer.mainActivity.getResources().getConfiguration().screenLayout
                & Configuration.SCREENLAYOUT_SIZE_MASK)
                >= Configuration.SCREENLAYOUT_SIZE_LARGE;
        renderer.pushAction(Renderer.OutAction.DEVICE_IS_PHONE);
        renderer.pushBoolean(isPhone);
    }

}

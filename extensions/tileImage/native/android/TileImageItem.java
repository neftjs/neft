package io.neft.extensions.tileimage;

import android.graphics.Bitmap;
import android.graphics.Shader;
import android.graphics.drawable.BitmapDrawable;
import android.view.View;

import io.neft.renderer.Image;
import io.neft.renderer.NativeItem;
import io.neft.renderer.annotation.OnCreate;
import io.neft.renderer.annotation.OnSet;
import io.neft.utils.Consumer;
import io.neft.utils.StringUtils;

import static java.lang.Math.round;

public class TileImageItem extends NativeItem {
    private String source;
    private float resolution;

    @OnCreate("TileImage")
    public TileImageItem() {
        super(new View(APP.getActivity().getApplicationContext()));
    }

    @OnSet("source")
    public void setSource(final String val) {
        source = val;
        Image.getImageFromSource(val, new Consumer<Bitmap>() {
            @Override
            public void accept(Bitmap bitmap) {
                if (StringUtils.equals(source, val)) {
                    setBitmap(bitmap);
                }
            }
        });
    }

    private void setBitmap(Bitmap bitmap) {
        float pixelRatio = APP.getRenderer().getDevice().getPixelRatio();
        if (resolution != pixelRatio) {
            float width = bitmap.getWidth() / resolution * pixelRatio;
            float height = bitmap.getHeight() / resolution * pixelRatio;
            bitmap = Bitmap.createScaledBitmap(bitmap, round(width), round(height), false);
        }
        BitmapDrawable drawable = new BitmapDrawable(APP.getActivity().getResources(), bitmap);
        drawable.setTileModeXY(Shader.TileMode.REPEAT, Shader.TileMode.REPEAT);
        itemView.setBackground(drawable);
    }

    @OnSet("resolution")
    public void setResolution(float val) {
        this.resolution = val;
    }
}

package io.neft.extensions.tileimage_extension;

import android.graphics.Bitmap;
import android.graphics.Shader;
import android.graphics.drawable.BitmapDrawable;
import android.view.View;

import io.neft.nimage.NImage;
import io.neft.nimage.NImageHolder;
import io.neft.renderer.NativeItem;
import io.neft.renderer.annotation.OnCreate;
import io.neft.renderer.annotation.OnSet;

import static java.lang.Math.round;

public class TileImageItem extends NativeItem {
    private final NImageHolder<Bitmap> imageHolder;
    private String source;
    private float resolution;

    @OnCreate("TileImage")
    public TileImageItem() {
        super(new View(APP.getActivity().getApplicationContext()));

        imageHolder = new NImageHolder<Bitmap>() {
            @Override
            public void draw(Bitmap resource) {
                setBitmap(resource);
            }

            @Override
            public void onLoad(Bitmap resource) {
                // NOP
            }

            @Override
            public void onError() {
                // NOP
            }
        };
    }

    @OnSet("source")
    public void setSource(final String val) {
        source = val;
        NImage.loadBitmap(imageHolder, val);
    }

    private void setBitmap(Bitmap bitmap) {
        if (bitmap == null) {
            itemView.setBackground(null);
            return;
        }

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

    @Override
    protected void onAttached() {
        super.onAttached();
        setSource(source);
    }

    @Override
    protected void onDetached() {
        super.onDetached();
        NImage.clear(imageHolder);
    }
}

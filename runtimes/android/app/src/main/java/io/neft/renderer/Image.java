package io.neft.renderer;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Canvas;
import android.graphics.ColorFilter;
import android.graphics.Paint;
import android.graphics.Rect;
import android.graphics.drawable.Drawable;
import android.graphics.drawable.PictureDrawable;
import android.os.Build;
import android.util.Log;
import android.view.View;
import android.view.ViewGroup;
import android.widget.FrameLayout;

import com.caverock.androidsvg.SVG;
import com.caverock.androidsvg.SVGParseException;

import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;

import io.neft.App;
import io.neft.client.InAction;
import io.neft.client.OutAction;
import io.neft.client.annotation.OnAction;

public class Image extends Item {
    private static class ImageDrawable extends Drawable {
        static final Paint PAINT = new Paint(Paint.ANTI_ALIAS_FLAG | Paint.FILTER_BITMAP_FLAG);
        private int alpha = 255;
        private Bitmap bitmap;
        private final Rect srcRect = new Rect();

        public void setBitmap(Bitmap bitmap) {
            this.bitmap = bitmap;
            if (bitmap != null) {
                srcRect.right = bitmap.getWidth();
                srcRect.bottom = bitmap.getHeight();
            }
            invalidateSelf();
        }

        @Override
        public void draw(Canvas canvas) {
            if (bitmap != null) {
                PAINT.setAlpha(alpha);
                canvas.drawBitmap(bitmap, srcRect, getBounds(), PAINT);
            }
        }

        @Override
        public void setAlpha(int alpha) {
            this.alpha = alpha;
            invalidateSelf();
        }

        @Override
        public void setColorFilter(ColorFilter colorFilter) {}

        @Override
        public int getOpacity() {
            return 0;
        }
    }

    abstract class LoadHandler {
        void work(String source, Bitmap bitmap) { throw new UnsupportedOperationException(); }
    }

    static int MAX_WIDTH = 1280;
    static int MAX_HEIGHT = 960;

    static final HashMap<String, Bitmap> cache = new HashMap<>();
    static final HashMap<String, ArrayList<LoadHandler>> loading = new HashMap<>();

    protected View imageView;
    public String source;

    @OnAction(InAction.CREATE_IMAGE)
    public static void create() {
        new Image();
    }

    protected ImageDrawable shape = new ImageDrawable();

    public Image() {
        super();
        imageView = new View(App.getApp().view.getContext());
        imageView.setLayoutParams(new FrameLayout.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT,
                ViewGroup.LayoutParams.MATCH_PARENT
        ));
        view.addView(imageView);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN) {
            imageView.setBackground(shape);
        } else {
            imageView.setBackgroundDrawable(shape);
        }
    }

    private void onLoad() {
        float width = pxToDp(shape.bitmap.getWidth());
        float height = pxToDp(shape.bitmap.getHeight());
        pushAction(OutAction.IMAGE_SIZE, source, true, width, height);
    }

    private void onError() {
        pushAction(OutAction.IMAGE_SIZE, source, false, 0f, 0f);
    }

    static private Bitmap getBitmapFromSVG(SVG svg) {
        Drawable drawable = new PictureDrawable(svg.renderToPicture());
        Bitmap bitmap = Bitmap.createBitmap(drawable.getIntrinsicWidth(), drawable.getIntrinsicHeight(), Bitmap.Config.ARGB_8888);
        Canvas canvas = new Canvas(bitmap);
        drawable.setBounds(0, 0, canvas.getWidth(), canvas.getHeight());
        drawable.draw(canvas);
        return bitmap;
    }

    static private Bitmap getBitmapFromSVG(InputStream in) {
        SVG svg;
        try {
            svg = SVG.getFromInputStream(in);
        } catch(SVGParseException err) {
            return null;
        }
        return getBitmapFromSVG(svg);
    }

    static private Bitmap loadResourceSource(String val) {
        try {
            // get file
            InputStream in = App.getApp().getAssets().open(val.substring(1));
            if (in == null) {
                return null;
            }
            if (val.endsWith(".svg")) {
                return getBitmapFromSVG(in);
            }
            return BitmapFactory.decodeStream(in);
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }

    static private Bitmap loadUrlSource(String val) {
        try {
            InputStream in = new URL(val).openStream();
            if (val.endsWith(".svg")) {
                return getBitmapFromSVG(in);
            }
            return BitmapFactory.decodeStream(in);
        } catch (Exception e) {
            Log.e("Neft", "Can't load image from url '"+val+"'");
            e.printStackTrace();
            return null;
        }
    }

    static private Bitmap validateBitmap(Bitmap bitmap) {
        // resize too large bitmaps
        int width = bitmap.getWidth();
        int height = bitmap.getHeight();
        if (width > MAX_WIDTH && height > MAX_HEIGHT) {
            if (width > height) {
                height = height * MAX_WIDTH / width;
                width = MAX_WIDTH;
            } else {
                width = width * MAX_HEIGHT / height;
                height = MAX_HEIGHT;
            }

            return Bitmap.createScaledBitmap(bitmap, width, height, false);
        }

        return bitmap;
    }

    @OnAction(InAction.SET_IMAGE_SOURCE)
    public void setSource(final String val) {
        source = val;

        // remove source
        if (val.equals("")) {
            shape.setBitmap(null);
            return;
        }

        // get bitmap from cache if exists
        Bitmap fromCache = cache.get(val);
        if (fromCache != null) {
            shape.setBitmap(fromCache);
            onLoad();
            return;
        }

        // get load end handler
        final Image self = this;
        final LoadHandler onLoad = new LoadHandler() {
            @Override
            void work(String source, Bitmap bitmap) {
                if (self.source != source) {
                    return;
                }
                shape.setBitmap(bitmap);
                if (bitmap != null) {
                    self.onLoad();
                } else {
                    self.onError();
                }
            }
        };

        // wait for load if already loading exists
        ArrayList<LoadHandler> loadingArray = loading.get(val);
        if (loadingArray != null) {
            loadingArray.add(onLoad);
            return;
        }

        // save in loading
        loadingArray = new ArrayList<>();
        loading.put(val, loadingArray);
        loadingArray.add(onLoad);

        // load source
        final Thread thread = new Thread(new Runnable() {
            @Override
            public void run() {
                Bitmap bitmap;
                if (val.startsWith("/static")) {
                    bitmap = loadResourceSource(val);
                } else {
                    bitmap = loadUrlSource(val);
                }

                // validate bitmap
                if (bitmap != null) {
                    bitmap = validateBitmap(bitmap);
                }

                // save to cache
                if (bitmap != null && !val.startsWith("data:")) {
                    cache.put(val, bitmap);
                }

                // call handlers
                final Bitmap finalBitmap = bitmap;
                App.getApp().runOnUiThread(new Runnable() {
                    @Override
                    public void run() {
                        final ArrayList<LoadHandler> loadingArray = loading.get(val);
                        for (final LoadHandler handler : loadingArray) {
                            handler.work(val, finalBitmap);
                        }
                        loading.remove(val);
                    }
                });
            }
        });
        thread.start();
    }
}

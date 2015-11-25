package io.neft.Renderer;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.drawable.Drawable;
import android.graphics.drawable.PictureDrawable;
import android.util.Log;
import android.view.View;
import android.view.ViewGroup;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.RelativeLayout;

import com.caverock.androidsvg.SVG;
import com.caverock.androidsvg.SVGParseException;

import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import io.neft.Renderer.Renderer;

public class Image extends Item {

    static int MAX_WIDTH = 1280;
    static int MAX_HEIGHT = 960;
    static final Paint paint = new Paint(Paint.ANTI_ALIAS_FLAG);

    public String source;
    public Bitmap bitmap;

    static void register(Renderer renderer){
        renderer.actions.put(Renderer.InAction.CREATE_IMAGE, new Action() {
            @Override
            void work(Reader reader) {
                new Image(reader.renderer);
            }
        });

        renderer.actions.put(Renderer.InAction.SET_IMAGE_SOURCE, new Action() {
            @Override
            void work(Reader reader) {
                ((Image) reader.getItem()).setSource(reader.getString());
            }
        });
    }

    public Image(Renderer renderer){
        super(renderer);
    }

    @Override
    protected void drawShape(Canvas canvas, int alpha){
        if (bitmap != null) {
            paint.setAlpha(alpha);
            canvas.drawBitmap(bitmap, 0, 0, paint);
        }
    }

    private void pushSize(){
        renderer.pushAction(Renderer.OutAction.IMAGE_SIZE);
        renderer.pushFloat(bitmap.getWidth() / renderer.device.pixelRatio);
        renderer.pushFloat(bitmap.getHeight() / renderer.device.pixelRatio);
    }

    private void setUrlSource(final String val){
//        final Thread thread = new Thread(new Runnable() {
//            @Override
//            public void run() {
//                try {
//                    InputStream in = new URL(val).openStream();
//                    if (source == val) {
//                        bitmap = BitmapFactory.decodeStream(in);
//                        pushSize();
//                    }
//                } catch (Exception e){
//                    e.printStackTrace();
//                }
//            }
//        });
//
//        thread.start();
    }

    private void setResourceSource(String val){
//        try {
//            InputStream in = renderer.mainActivity.getAssets().open(val.substring(1));
//            if (in == null){
//                return;
//            }
//
////                if (val.endsWith(".svg")){
////                    SVG svg = SVG.getFromInputStream(in);
////                    Drawable drawable = new PictureDrawable(svg.renderToPicture());
////                }
//
//            bitmap = BitmapFactory.decodeStream(in);
//            if (bitmap == null){
//                return;
//            }
//
//            // resize too large bitmaps
//            int width = bitmap.getWidth();
//            int height = bitmap.getHeight();
//            if (width > MAX_WIDTH && height > MAX_HEIGHT){
//                if (width > height){
//                    height = height * MAX_WIDTH / width;
//                    width = MAX_WIDTH;
//                } else {
//                    width = width * MAX_HEIGHT / height;
//                    height = MAX_HEIGHT;
//                }
//
//                bitmap = Bitmap.createScaledBitmap(bitmap, width, height, false);
//            }
//
//            pushSize();
//            return;
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
    }

    private void setDataUriSource(String val){
//        Pattern svgDataUri = Pattern.compile("^data:image/svg(?:.*);(?:.*)?,(.*)$");
//        Matcher svgDataUriMatch = svgDataUri.matcher(val);
//
//        if (svgDataUriMatch.matches()){
//            try {
//                SVG svg = SVG.getFromString(svgDataUriMatch.group(1));
//                Drawable drawable = new PictureDrawable(svg.renderToPicture());
//                try {
//                    item.setLayerType(View.LAYER_TYPE_SOFTWARE, null);
//                } finally {}
//                item.setImageDrawable(drawable);
//            } catch (SVGParseException e) {
//                Log.e("Neft", "Can't parse SVG data uri '"+val+"'\n" + e.getMessage());
//                return;
//            }
//        } else {
//            item.setImageResource(R.mipmap.ic_launcher);
//        }
    }

    public void setSource(String val){
        source = val;

        // remove source
        if (val == null){
            bitmap = null;
            return;
        }

        // set asset file
        if (val.startsWith("/static")) {
            setResourceSource(val);
        } else if (val.startsWith("data:")) {
            setDataUriSource(val);
        } else {
            setUrlSource(val);
        }
    }

    public void setSourceWidth(float val){}

    public void setSourceHeight(float val){}

    public void setFillMode(String val){}

    public void setOffsetX(float val){}

    public void setOffsetY(float val){}
}

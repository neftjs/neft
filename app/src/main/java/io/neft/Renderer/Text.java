package io.neft.Renderer;

import android.content.res.AssetManager;
import android.graphics.BitmapFactory;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.Typeface;
import android.util.Log;
import android.util.TypedValue;
import android.view.View;
import android.view.ViewGroup;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import android.widget.TextView;

import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import io.neft.Renderer.Renderer;

public class Text extends Item {
    public String text = "";
    public int color = Color.BLACK;
    public float lineHeight = 1;
    public float wordSpacing = 0;
    public float letterSpacing = 0;
    public String fontFamily = "";
    public float fontPixelSize = 14;

    static final Paint paint = new Paint(Paint.ANTI_ALIAS_FLAG);
    static final HashMap<String, Typeface> fonts = new HashMap<>();

    static void register(Renderer renderer){
        renderer.actions.put(Renderer.InAction.CREATE_TEXT, new Action() {
            @Override
            void work(Reader reader) {
                new Text(reader.renderer);
            }
        });

        renderer.actions.put(Renderer.InAction.SET_TEXT, new Action() {
            @Override
            void work(Reader reader) {
                ((Text) reader.getItem()).setText(reader.getString());
            }
        });

        renderer.actions.put(Renderer.InAction.SET_TEXT_COLOR, new Action() {
            @Override
            void work(Reader reader) {
                ((Text) reader.getItem()).setColor(reader.getString());
            }
        });

        renderer.actions.put(Renderer.InAction.SET_TEXT_LINE_HEIGHT, new Action() {
            @Override
            void work(Reader reader) {
                ((Text) reader.getItem()).setLineHeight(reader.getFloat());
            }
        });

        renderer.actions.put(Renderer.InAction.SET_TEXT_FONT_FAMILY, new Action() {
            @Override
            void work(Reader reader) {
                ((Text) reader.getItem()).setFontFamily(reader.getString());
            }
        });

        renderer.actions.put(Renderer.InAction.SET_TEXT_FONT_PIXEL_SIZE, new Action() {
            @Override
            void work(Reader reader) {
                ((Text) reader.getItem()).setFontPixelSize(reader.getFloat());
            }
        });

        renderer.actions.put(Renderer.InAction.SET_TEXT_FONT_WORD_SPACING, new Action() {
            @Override
            void work(Reader reader) {
                ((Text) reader.getItem()).setFontWordSpacing(reader.getFloat());
            }
        });

        renderer.actions.put(Renderer.InAction.SET_TEXT_FONT_LETTER_SPACING, new Action() {
            @Override
            void work(Reader reader) {
                ((Text) reader.getItem()).setFontLetterSpacing(reader.getFloat());
            }
        });

        renderer.actions.put(Renderer.InAction.SET_TEXT_ALIGNMENT_HORIZONTAL, new Action() {
            @Override
            void work(Reader reader) {
                ((Text) reader.getItem()).setAlignmentHorizontal(reader.getString());
            }
        });

        renderer.actions.put(Renderer.InAction.SET_TEXT_ALIGNMENT_VERTICAL, new Action() {
            @Override
            void work(Reader reader) {
                ((Text) reader.getItem()).setAlignmentVertical(reader.getString());
            }
        });

        renderer.actions.put(Renderer.InAction.LOAD_FONT, new Action() {
            @Override
            void work(Reader reader) {
                Text.loadFont(reader.getString(), reader.getString(), reader.renderer);
            }
        });
    }

    public static void loadFont(final String source, final String name, final Renderer renderer){
        final Thread thread = new Thread(new Runnable() {
            @Override
            public void run() {
                if (source.startsWith("/static")){
                    fonts.put(name, Typeface.createFromAsset(renderer.mainActivity.getAssets(), source.substring(1)));
                    renderer.pushAction(Renderer.OutAction.FONT_LOAD);
                    renderer.pushString(name);
                } else {
                    Log.e("JAVA", "Loading font's by URL is not currently supported");
                }
            }
        });

        thread.start();
    }

    public Text(Renderer renderer){
        super(renderer);
    }

    public void setText(String val){
        text = val;
        updateSize();
    }

    public void setColor(String val){
        color = Item.colorFromString(val);
    }

    public void setLineHeight(float val){
        lineHeight = val;
        updateSize();
    }

    public void setFontFamily(String val){
        fontFamily = val;
        updateSize();
    }

    public void setFontPixelSize(float val){
        fontPixelSize = val * renderer.device.pixelRatio;
        updateSize();
    }

    public void setFontWordSpacing(float val){
        wordSpacing = val * renderer.device.pixelRatio;
        updateSize();
    }

    public void setFontLetterSpacing(float val){
        letterSpacing = val * renderer.device.pixelRatio;
        updateSize();
    }

    public void setAlignmentHorizontal(String val){}

    public void setAlignmentVertical(String val){}

    protected void updatePaint(){
        Typeface font = fonts.get(fontFamily);
        if (font != null) {
            paint.setTypeface(font);
        } else {
            paint.setTypeface(Typeface.create(Typeface.SANS_SERIF, Typeface.NORMAL));
        }

        paint.setColor(color);
        paint.setTextSize(fontPixelSize);
    }

    protected void updateSize(){
        updatePaint();
        final float height = lineHeight * fontPixelSize;

        renderer.pushAction(Renderer.OutAction.TEXT_SIZE);
        renderer.pushItem(this);
        renderer.pushFloat(paint.measureText(text) / renderer.device.pixelRatio);
        renderer.pushFloat(height / renderer.device.pixelRatio);
    }

    @Override
    protected void drawShape(Canvas canvas, int alpha){
        paint.setAlpha(alpha);
        updatePaint();

        final float height = lineHeight * fontPixelSize;

        canvas.drawText(text, 0, height, paint);
    }
}

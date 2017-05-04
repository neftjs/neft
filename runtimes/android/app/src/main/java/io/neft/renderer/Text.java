package io.neft.renderer;

import android.graphics.Color;
import android.graphics.Typeface;
import android.util.Log;
import android.view.Gravity;
import android.view.View;
import android.view.ViewGroup;
import android.widget.FrameLayout;
import android.widget.TextView;

import java.util.HashMap;

import io.neft.client.InAction;
import io.neft.client.OutAction;
import io.neft.client.Reader;
import io.neft.client.annotation.OnAction;
import io.neft.utils.ColorValue;

public class Text extends Item {
    private static final int DEFAULT_FONT_PIXEL_SIZE = 14;
    private static final int DEFAULT_COLOR = Color.BLACK;
    private static final HashMap<String, Typeface> FONTS = new HashMap<>();

    @OnAction(InAction.CREATE_TEXT)
    public static void create() {
        new Text();
    }

    @OnAction(InAction.LOAD_FONT)
    public static void loadFont(Reader reader) {
        final String name = reader.getString();
        final String source = reader.getString();
        final Thread thread = new Thread(new Runnable() {
            @Override
            public void run() {
                boolean success;
                if (source.startsWith("/static")) {
                    FONTS.put(name, Typeface.createFromAsset(APP.getActivity().getAssets(), source.substring(1)));
                    success = true;
                } else {
                    Log.e("NEFT", "Loading font's by URL is not currently supported; '" + source + "' given");
                    success = false;
                }
                APP.getClient().pushAction(OutAction.FONT_LOAD, name, success);
            }
        });

        thread.start();
    }

    private final TextView textView = new TextView(APP.getActivity().getApplicationContext());
    private boolean wrap = false;

    private Text() {
        super();
        textView.setLayoutParams(new FrameLayout.LayoutParams(
                ViewGroup.LayoutParams.WRAP_CONTENT,
                ViewGroup.LayoutParams.WRAP_CONTENT
        ));
        view.addView(textView);
        textView.setTextSize(DEFAULT_FONT_PIXEL_SIZE);
        textView.setTextColor(DEFAULT_COLOR);
    }

    private void updateMaxWidth() {
        textView.setMaxWidth(view.getLayoutParams().width);
    }

    @Override
    public void setWidth(float val) {
        super.setWidth(val);
        if (wrap) {
            updateMaxWidth();
        }
    }

    @OnAction(InAction.SET_TEXT)
    public void setText(String val) {
        textView.setText(val);
    }

    @OnAction(InAction.SET_TEXT_WRAP)
    public void setWrap(boolean val) {
        wrap = val;
        if (wrap) {
            updateMaxWidth();
        } else {
            textView.setMaxWidth(-1);
        }
    }

    @OnAction(InAction.SET_TEXT_COLOR)
    public void setColor(ColorValue val) {
        textView.setTextColor(val.getColor());
    }

    @OnAction(InAction.SET_TEXT_LINE_HEIGHT)
    public void setLineHeight(float val) {
        textView.setLineSpacing(0, val);
    }

    @OnAction(InAction.SET_TEXT_FONT_FAMILY)
    public void setFontFamily(String val) {
        textView.setTypeface(FONTS.get(val));
    }

    @OnAction(InAction.SET_TEXT_FONT_PIXEL_SIZE)
    public void setFontPixelSize(float val) {
        textView.setTextSize(val);
    }

    @OnAction(InAction.SET_TEXT_FONT_WORD_SPACING)
    public void setFontWordSpacing(float val) {
        // TODO
    }

    @OnAction(InAction.SET_TEXT_FONT_LETTER_SPACING)
    public void setFontLetterSpacing(float val) {
        // TODO
    }

    @OnAction(InAction.SET_TEXT_ALIGNMENT_HORIZONTAL)
    public void setAlignmentHorizontal(String val) {
        int gravity;
        switch (val) {
            case "right":
                gravity = Gravity.END;
                break;
            case "center":
                gravity = Gravity.CENTER;
                break;
            default:
                gravity = Gravity.START;
        }
        textView.setGravity(gravity);
    }

    @OnAction(InAction.SET_TEXT_ALIGNMENT_VERTICAL)
    public void setAlignmentVertical(String val) {
        // TODO
    }

    @OnAction(InAction.UPDATE_TEXT_CONTENT_SIZE)
    public void updateContentSize() {
        textView.measure(View.MeasureSpec.UNSPECIFIED, View.MeasureSpec.UNSPECIFIED);
        float width = pxToDp(textView.getMeasuredWidth());
        float height = pxToDp(textView.getMeasuredHeight());
        pushAction(OutAction.TEXT_SIZE, width, height);
    }
}

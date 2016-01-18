package io.neft.Renderer;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Matrix;
import android.graphics.RectF;
import android.graphics.Typeface;
import android.text.InputType;
import android.util.TypedValue;
import android.view.MotionEvent;
import android.view.ViewGroup;
import android.widget.EditText;
import android.widget.RelativeLayout;

import java.util.ArrayList;

import io.neft.Client.Action;
import io.neft.Client.InAction;
import io.neft.Client.Reader;
import io.neft.MainActivity;
import io.neft.Utils.ColorUtils;

public class TextInput extends Item {
    static void register(final MainActivity app) {
        app.client.actions.put(InAction.CREATE_TEXT_INPUT, new Action() {
            @Override
            public void work(Reader reader) {
                new TextInput(app);
            }
        });

        app.client.actions.put(InAction.SET_TEXT_INPUT_TEXT, new Action() {
            @Override
            public void work(Reader reader) {
                ((TextInput) app.renderer.getItemFromReader(reader)).setText(reader.getString());
            }
        });

        app.client.actions.put(InAction.SET_TEXT_INPUT_COLOR, new Action() {
            @Override
            public void work(Reader reader) {
                ((TextInput) app.renderer.getItemFromReader(reader)).setColor(reader.getInteger());
            }
        });

        app.client.actions.put(InAction.SET_TEXT_INPUT_LINE_HEIGHT, new Action() {
            @Override
            public void work(Reader reader) {
                ((TextInput) app.renderer.getItemFromReader(reader)).setLineHeight(reader.getFloat());
            }
        });

        app.client.actions.put(InAction.SET_TEXT_INPUT_MULTI_LINE, new Action() {
            @Override
            public void work(Reader reader) {
                ((TextInput) app.renderer.getItemFromReader(reader)).setMultiLine(reader.getBoolean());
            }
        });

        app.client.actions.put(InAction.SET_TEXT_INPUT_ECHO_MODE, new Action() {
            @Override
            public void work(Reader reader) {
                ((TextInput) app.renderer.getItemFromReader(reader)).setEchoMode(reader.getString());
            }
        });

        app.client.actions.put(InAction.SET_TEXT_INPUT_FONT_FAMILY, new Action() {
            @Override
            public void work(Reader reader) {
                ((TextInput) app.renderer.getItemFromReader(reader)).setFontFamily(reader.getString());
            }
        });

        app.client.actions.put(InAction.SET_TEXT_FONT_INPUT_PIXEL_SIZE, new Action() {
            @Override
            public void work(Reader reader) {
                ((TextInput) app.renderer.getItemFromReader(reader)).setFontPixelSize(reader.getFloat());
            }
        });

        app.client.actions.put(InAction.SET_TEXT_FONT_INPUT_WORD_SPACING, new Action() {
            @Override
            public void work(Reader reader) {
                ((TextInput) app.renderer.getItemFromReader(reader)).setWordSpacing(reader.getFloat());
            }
        });

        app.client.actions.put(InAction.SET_TEXT_FONT_INPUT_LETTER_SPACING, new Action() {
            @Override
            public void work(Reader reader) {
                ((TextInput) app.renderer.getItemFromReader(reader)).setLetterSpacing(reader.getFloat());
            }
        });

        app.client.actions.put(InAction.SET_TEXT_INPUT_ALIGNMENT_HORIZONTAL, new Action() {
            @Override
            public void work(Reader reader) {
                ((TextInput) app.renderer.getItemFromReader(reader)).setAlignmentHorizontal(reader.getString());
            }
        });

        app.client.actions.put(InAction.SET_TEXT_INPUT_ALIGNMENT_VERTICAL, new Action() {
            @Override
            public void work(Reader reader) {
                ((TextInput) app.renderer.getItemFromReader(reader)).setAlignmentVertical(reader.getString());
            }
        });
    }

    private class InputView extends EditText {
        public boolean active = false;

        public InputView(Context context) {
            super(context);
        }

        @Override
        public boolean onTouchEvent(MotionEvent event){
            return active;
        }

        @Override
        public void draw(Canvas canvas) {

        }

        public void drawOnItem(Canvas canvas) {
            super.draw(canvas);
        }
    }

    public final InputView view;
    public boolean focus = false;
    public int color = Color.BLACK;

    public TextInput(MainActivity app){
        super(app);
        Context context = app.getApplicationContext();
        ViewGroup container = new RelativeLayout(context);
        container.layout(0, 0, (int) app.renderer.screen.width, (int) app.renderer.screen.height);
        this.view = new InputView(context);
        view.setBackgroundColor(Color.TRANSPARENT);
        view.setPadding(0, 0, 0, 0);
        container.addView(view);
        app.view.addView(container);

        // default config
        setWidth(100);
        setHeight(50);
        setMultiLine(false);
        setEchoMode("");
    }

    private void updateViewLayout() {
        int l = Math.round(globalBounds.left);
        int t = Math.round(globalBounds.top) + 70;
        int r = l + Math.round(width);
        int b = t + Math.round(height);
        view.layout(l, t, r, b);
    }

    @Override
    public void setWidth(float val) {
        super.setWidth(val);
        updateViewLayout();
    }

    @Override
    public void setHeight(float val) {
        super.setHeight(val);
        updateViewLayout();
    }

    public void setText(String val) {
        view.setText(val);
    }

    public void setColor(int val) {
        color = ColorUtils.RGBAtoARGB(val);
    }

    public void setLineHeight(float val) {
        // TODO
    }

    public void setMultiLine(boolean val) {
        view.setSingleLine(!val);
    }

    public void setEchoMode(String val) {
        switch (val) {
            case "password":
                view.setInputType(InputType.TYPE_CLASS_TEXT | InputType.TYPE_TEXT_VARIATION_PASSWORD);
                break;
            default:
                view.setInputType(InputType.TYPE_TEXT_FLAG_MULTI_LINE);
        }
    }

    public void setFontFamily(String val) {
        Typeface font = Text.fonts.get(val);
        if (font == null) {
            font = Typeface.create(Typeface.SANS_SERIF, Typeface.NORMAL);
        }
        view.setTypeface(font);
    }

    public void setFontPixelSize(float val) {
        view.setTextSize(TypedValue.COMPLEX_UNIT_PX, app.renderer.dpToPx(val));
    }

    public void setWordSpacing(float val) {
        // TODO
    }

    public void setLetterSpacing(float val) {
        // TODO
    }

    public void setAlignmentHorizontal(String val) {
        // TODO
    }

    public void setAlignmentVertical(String val) {
        // TODO
    }

    @Override
    protected void measure(final Matrix globalMatrix, RectF viewRect, final ArrayList<RectF> dirtyRects, final boolean forceUpdateBounds) {
        final boolean dirtyPosition = forceUpdateBounds || dirtyMatrix;

        super.measure(globalMatrix, viewRect, dirtyRects, forceUpdateBounds);

        if (dirtyPosition) {
            updateViewLayout();
        }
        if (focus) {
            invalidate();
        }
    }

    @Override
    public void setKeysFocus(boolean val) {
        super.setKeysFocus(val);
        focus = val;
        view.active = val;
        if (val) {
            app.renderer.device.showKeyboard();
            view.requestFocus();
        } else {
            view.clearFocus();
            app.renderer.device.hideKeyboard();
        }
        invalidate();
    }

    @Override
    protected void drawShape(final Canvas canvas, final int alpha) {
        view.setTextColor(ColorUtils.byAlpha(color, alpha));
        view.drawOnItem(canvas);
    }
}

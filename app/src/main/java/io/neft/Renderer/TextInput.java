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

import io.neft.Utils.ColorUtils;

public class TextInput extends Item {
    static void register(Renderer renderer) {
        renderer.actions.put(Renderer.InAction.CREATE_TEXT_INPUT, new Action() {
            @Override
            void work(Reader reader) {
                new TextInput(reader.renderer);
            }
        });

        renderer.actions.put(Renderer.InAction.SET_TEXT_INPUT_TEXT, new Action() {
            @Override
            void work(Reader reader) {
                ((TextInput) reader.getItem()).setText(reader.getString());
            }
        });

        renderer.actions.put(Renderer.InAction.SET_TEXT_INPUT_COLOR, new Action() {
            @Override
            void work(Reader reader) {
                ((TextInput) reader.getItem()).setColor(reader.getInteger());
            }
        });

        renderer.actions.put(Renderer.InAction.SET_TEXT_INPUT_LINE_HEIGHT, new Action() {
            @Override
            void work(Reader reader) {
                ((TextInput) reader.getItem()).setLineHeight(reader.getFloat());
            }
        });

        renderer.actions.put(Renderer.InAction.SET_TEXT_INPUT_MULTI_LINE, new Action() {
            @Override
            void work(Reader reader) {
                ((TextInput) reader.getItem()).setMultiLine(reader.getBoolean());
            }
        });

        renderer.actions.put(Renderer.InAction.SET_TEXT_INPUT_ECHO_MODE, new Action() {
            @Override
            void work(Reader reader) {
                ((TextInput) reader.getItem()).setEchoMode(reader.getString());
            }
        });

        renderer.actions.put(Renderer.InAction.SET_TEXT_INPUT_FONT_FAMILY, new Action() {
            @Override
            void work(Reader reader) {
                ((TextInput) reader.getItem()).setFontFamily(reader.getString());
            }
        });

        renderer.actions.put(Renderer.InAction.SET_TEXT_FONT_INPUT_PIXEL_SIZE, new Action() {
            @Override
            void work(Reader reader) {
                ((TextInput) reader.getItem()).setFontPixelSize(reader.getFloat());
            }
        });

        renderer.actions.put(Renderer.InAction.SET_TEXT_FONT_INPUT_WORD_SPACING, new Action() {
            @Override
            void work(Reader reader) {
                ((TextInput) reader.getItem()).setWordSpacing(reader.getFloat());
            }
        });

        renderer.actions.put(Renderer.InAction.SET_TEXT_FONT_INPUT_LETTER_SPACING, new Action() {
            @Override
            void work(Reader reader) {
                ((TextInput) reader.getItem()).setLetterSpacing(reader.getFloat());
            }
        });

        renderer.actions.put(Renderer.InAction.SET_TEXT_INPUT_ALIGNMENT_HORIZONTAL, new Action() {
            @Override
            void work(Reader reader) {
                ((TextInput) reader.getItem()).setAlignmentHorizontal(reader.getString());
            }
        });

        renderer.actions.put(Renderer.InAction.SET_TEXT_INPUT_ALIGNMENT_VERTICAL, new Action() {
            @Override
            void work(Reader reader) {
                ((TextInput) reader.getItem()).setAlignmentVertical(reader.getString());
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

    public TextInput(Renderer renderer){
        super(renderer);
        Context context = renderer.mainActivity.getApplicationContext();
        ViewGroup container = new RelativeLayout(context);
        container.layout(0, 0, (int) renderer.screen.width, (int) renderer.screen.height);
        this.view = new InputView(context);
        view.setBackgroundColor(Color.TRANSPARENT);
        view.setPadding(0, 0, 0, 0);
        container.addView(view);
        renderer.mainActivity.view.addView(container);

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
        view.setTextSize(TypedValue.COMPLEX_UNIT_PX, renderer.dpToPx(val));
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
            renderer.device.showKeyboard();
            view.requestFocus();
        } else {
            view.clearFocus();
            renderer.device.hideKeyboard();
        }
        invalidate();
    }

    @Override
    protected void drawShape(final Canvas canvas, final int alpha) {
        view.setTextColor(ColorUtils.byAlpha(color, alpha));
        view.drawOnItem(canvas);
    }
}

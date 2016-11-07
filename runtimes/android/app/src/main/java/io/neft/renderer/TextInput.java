package io.neft.renderer;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Color;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.MotionEvent;
import android.widget.EditText;

import io.neft.client.Action;
import io.neft.client.InAction;
import io.neft.client.Reader;
import io.neft.MainActivity;
import io.neft.utils.ColorValue;

public class TextInput extends Item {
    static void register(final MainActivity app) {
        app.client.actions.put(InAction.CREATE_TEXT_INPUT, new Action() {
            @Override
            public void work(Reader reader) {
                new TextInput();
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

        public InputView(Context context, final TextInput textInput) {
            super(context);

            this.addTextChangedListener(new TextWatcher() {
                public void afterTextChanged(Editable s) {
                }

                public void beforeTextChanged(CharSequence s, int start, int count, int after) {
                }

                public void onTextChanged(CharSequence s, int start, int before, int count) {
                }
            });
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

    public boolean focus = false;
    public int color = Color.BLACK;

    public TextInput(){
        super();
    }

    private void updateViewLayout() {
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
    }

    public void setColor(int val) {
        color = ColorValue.RGBAtoARGB(val);
    }

    public void setLineHeight(float val) {
        // TODO
    }

    public void setMultiLine(boolean val) {
    }

    public void setEchoMode(String val) {
    }

    public void setFontFamily(String val) {
    }

    public void setFontPixelSize(float val) {
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
    public void setKeysFocus(boolean val) {
    }
}

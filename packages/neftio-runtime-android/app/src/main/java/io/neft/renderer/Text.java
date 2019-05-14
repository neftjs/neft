package io.neft.renderer;

import android.graphics.*;
import android.graphics.drawable.Drawable;
import android.util.Log;
import android.view.ViewGroup;
import io.neft.client.InAction;
import io.neft.client.OutAction;
import io.neft.client.Reader;
import io.neft.client.handlers.NoArgsActionHandler;
import io.neft.client.handlers.ReaderActionHandler;
import io.neft.renderer.handlers.*;
import io.neft.utils.ColorValue;
import io.neft.utils.ViewUtils;
import lombok.ToString;

import java.util.ArrayList;
import java.util.HashMap;

public class Text extends Item {
    private static final String DEFAULT_FONT_FAMILY = "";
    private static final int DEFAULT_FONT_PIXEL_SIZE = 14;
    private static final int DEFAULT_COLOR = Color.BLACK;
    private static final String SPACE = " ";
    private static final String NEW_LINE = "\n";
    private static final HashMap<String, Typeface> FONTS = new HashMap<>();
    private static final Paint.FontMetrics FONT_METRICS = new Paint.FontMetrics();
    private static final HashMap<String, Float> ALIGNMENT;

    static {
        ALIGNMENT = new HashMap<>();
        ALIGNMENT.put("top", 0f);
        ALIGNMENT.put("center", 0.5f);
        ALIGNMENT.put("bottom", 1f);
        ALIGNMENT.put("left", 0f);
        ALIGNMENT.put("right", 1f);
    };

    public static void register() {
        onAction(InAction.CREATE_TEXT, new NoArgsActionHandler() {
            @Override
            public void accept() {
                new Text();
            }
        });

        onAction(InAction.LOAD_FONT, new ReaderActionHandler() {
            @Override
            public void accept(Reader reader) {
                loadFont(reader);
            }
        });

        onAction(InAction.SET_TEXT, new StringItemActionHandler<Text>() {
            @Override
            public void accept(Text item, String value) {
                item.setText(value);
            }
        });

        onAction(InAction.SET_TEXT_WRAP, new BooleanItemActionHandler<Text>() {
            @Override
            public void accept(Text item, boolean value) {
                item.setWrap(value);
            }
        });

        onAction(InAction.SET_TEXT_COLOR, new ColorItemActionHandler<Text>() {
            @Override
            public void accept(Text item, ColorValue value) {
                item.setColor(value);
            }
        });

        onAction(InAction.SET_TEXT_LINE_HEIGHT, new FloatItemActionHandler<Text>() {
            @Override
            public void accept(Text item, float value) {
                item.setLineHeight(value);
            }
        });

        onAction(InAction.SET_TEXT_FONT_FAMILY, new StringItemActionHandler<Text>() {
            @Override
            public void accept(Text item, String value) {
                item.setFontFamily(value);
            }
        });

        onAction(InAction.SET_TEXT_FONT_PIXEL_SIZE, new FloatItemActionHandler<Text>() {
            @Override
            public void accept(Text item, float value) {
                item.setFontPixelSize(value);
            }
        });

        onAction(InAction.SET_TEXT_FONT_WORD_SPACING, new FloatItemActionHandler<Text>() {
            @Override
            public void accept(Text item, float value) {
                item.setFontWordSpacing(value);
            }
        });

        onAction(InAction.SET_TEXT_FONT_LETTER_SPACING, new FloatItemActionHandler<Text>() {
            @Override
            public void accept(Text item, float value) {
                item.setFontLetterSpacing(value);
            }
        });

        onAction(InAction.SET_TEXT_ALIGNMENT_HORIZONTAL, new StringItemActionHandler<Text>() {
            @Override
            public void accept(Text item, String value) {
                item.setAlignmentHorizontal(value);
            }
        });

        onAction(InAction.SET_TEXT_ALIGNMENT_VERTICAL, new StringItemActionHandler<Text>() {
            @Override
            public void accept(Text item, String value) {
                item.setAlignmentVertical(value);
            }
        });

        onAction(InAction.UPDATE_TEXT_CONTENT_SIZE, new NoArgsItemActionHandler<Text>() {
            @Override
            public void accept(Text item) {
                item.updateContentSize();
            }
        });
    }

    public static void loadFont(Reader reader) {
        final String name = reader.getString();
        final String source = reader.getString();
        Thread thread = new Thread(new Runnable() {
            @Override
            public void run() {
                boolean success;
                if (source.startsWith("/static")) {
                    FONTS.put(name, Typeface.createFromAsset(APP.getActivity().getAssets(), source.substring(1)));
                    success = true;
                } else {
                    Log.e("Neftio", "Loading font's by URL is not currently supported; '" + source + "' given");
                    success = false;
                }
                APP.getClient().pushAction(OutAction.FONT_LOAD, name, success);
            }
        });

        thread.start();
    }

    @ToString
    private static class Line {
        private int textStart;
        private int textEnd;
        private float width;
        private float y;
    }

    private class TextDrawable extends Drawable {

        @Override
        public void draw(Canvas canvas) {
            if (contentWidth <= 0 || contentHeight <= 0) {
                return;
            }

            ViewGroup.LayoutParams layoutParams = view.getLayoutParams();
            float shiftY = (layoutParams.height - contentHeight) * alignmentVertical;

            for (int i = 0; i < linesLength; i++) {
                Line line = lines.get(i);

                canvas.drawText(
                        linesText,
                        line.textStart, line.textEnd,
                        (layoutParams.width - line.width) * alignmentHorizontal, line.y + shiftY,
                        paint
                );
            }
        }

        @Override
        public void setAlpha(int i) {
            paint.setAlpha(i);
        }

        @Override
        public void setColorFilter(ColorFilter colorFilter) {
            paint.setColorFilter(colorFilter);
        }

        @Override
        public int getOpacity() {
            return PixelFormat.TRANSLUCENT;
        }
    }

    private final TextDrawable shape = new TextDrawable();
    private Paint paint = new Paint(Paint.ANTI_ALIAS_FLAG);

    private float fontPixelSize;
    private boolean wrap = false;
    private float lineHeight = 1;
    private float alignmentHorizontal = ALIGNMENT.get("left");
    private float alignmentVertical = ALIGNMENT.get("top");
    private float contentWidth = 0;
    private float contentHeight = 0;

    private String text;
    private String linesText = "";
    private ArrayList<Line> lines = new ArrayList<>();
    private int linesLength;

    private Text() {
        super();
        ViewUtils.setBackground(view, shape);
        paint.setColor(DEFAULT_COLOR);
        setFontFamily(DEFAULT_FONT_FAMILY);
        setFontPixelSize(DEFAULT_FONT_PIXEL_SIZE);
    }

    public void setText(String val) {
        text = val;
    }

    public void setWrap(boolean val) {
        wrap = val;
    }

    public void setColor(ColorValue val) {
        paint.setColor(val.getColor());
    }

    public void setLineHeight(float val) {
        lineHeight = val;
    }

    public void setFontFamily(String val) {
        Typeface font = FONTS.get(val);
        if (font != null) {
            paint.setTypeface(font);
        } else {
            paint.setTypeface(Typeface.create(Typeface.SANS_SERIF, Typeface.NORMAL));
        }
    }

    public void setFontPixelSize(float val) {
        float pxVal = dpToPx(val);
        fontPixelSize = pxVal;
        paint.setTextSize(pxVal);
    }

    public void setFontWordSpacing(float val) {
        // TODO
    }

    public void setFontLetterSpacing(float val) {
        // TODO
    }

    public void setAlignmentHorizontal(String val) {
        alignmentHorizontal = ALIGNMENT.get(val);
    }

    public void setAlignmentVertical(String val) {
        alignmentVertical = ALIGNMENT.get(val);
    }

    private String[][] splitText() {
        String[] lines = text.split(NEW_LINE, -1);
        String[][] result = new String[lines.length][];
        for (int i = 0; i < lines.length; i++) {
            result[i] = lines[i].split(SPACE, -1);
        }
        return result;
    }

    public void updateContentSize() {
        linesLength = 0;
        linesText = text;

        if (text == null || text.isEmpty()) {
            contentWidth = contentHeight = 0;
        } else {
            paint.getFontMetrics(FONT_METRICS);

            String[][] textLines = splitText();
            int textLinesLength = textLines.length;
            int linesArrayLength = lines.size();
            int width = view.getLayoutParams().width;
            float lineHeightPx = lineHeight * fontPixelSize;
            float spaceWidth = paint.measureText(" ");
            float fontTop = lineHeightPx;
            float x = 0, textWidth = 0, textHeight = 0;
            int textPointer = 0, lineStart = 0, lineLength = 0;

            for (int i = 0; i < textLinesLength; i++) {
                String[] words = textLines[i];
                int wordsLength = words.length;

                for (int j = 0; j <= wordsLength; j++) {
                    String word = j < wordsLength ? words[j] : null;
                    int wordLength = word != null ? word.length() : 0;
                    float wordWidth = word != null ? paint.measureText(word) : 0;

                    if (j > 0 && (j == wordsLength || (wrap && x + wordWidth > width))) {
                        // get line object
                        Line line;
                        if (linesArrayLength <= linesLength) {
                            line = new Line();
                            lines.add(line);
                        } else {
                            line = lines.get(linesLength);
                        }
                        linesLength++;

                        // fill line
                        line.textStart = lineStart;
                        line.textEnd = lineStart + lineLength - 1;
                        line.width = x - spaceWidth;
                        line.y = textHeight + fontTop;

                        // clear
                        lineStart = textPointer;
                        lineLength = 0;
                        x = 0;

                        // next line
                        textHeight += lineHeightPx;
                    }

                    if (word != null) {
                        x += wordWidth;
                        textPointer += wordLength + 1;
                        lineLength += wordLength + 1;
                    }

                    if (x > textWidth) {
                        textWidth = x;
                    }

                    x += spaceWidth;
                }
            }

            if (textHeight > 0) {
                textHeight += FONT_METRICS.descent;
            }

            contentWidth = textWidth;
            contentHeight = textHeight;
        }

        shape.invalidateSelf();

        pushAction(OutAction.TEXT_SIZE, pxToDp(contentWidth), pxToDp(contentHeight));
    }
}

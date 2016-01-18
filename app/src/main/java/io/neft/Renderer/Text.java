package io.neft.Renderer;

import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.Paint.FontMetrics;
import android.graphics.Typeface;
import android.util.Log;

import java.util.ArrayList;
import java.util.HashMap;

import io.neft.Client.Action;
import io.neft.Client.InAction;
import io.neft.Client.OutAction;
import io.neft.Client.Reader;
import io.neft.MainActivity;
import io.neft.Utils.ColorUtils;

public class Text extends Item {
    static void register(final MainActivity app){
        app.client.actions.put(InAction.CREATE_TEXT, new Action() {
            @Override
            public void work(Reader reader) {
                new Text(app);
            }
        });

        app.client.actions.put(InAction.SET_TEXT, new Action() {
            @Override
            public void work(Reader reader) {
                ((Text) app.renderer.getItemFromReader(reader)).setText(reader.getString());
            }
        });

        app.client.actions.put(InAction.SET_TEXT_WRAP, new Action() {
            @Override
            public void work(Reader reader) {
                ((Text) app.renderer.getItemFromReader(reader)).setWrap(reader.getBoolean());
            }
        });

        app.client.actions.put(InAction.UPDATE_TEXT_CONTENT_SIZE, new Action() {
            @Override
            public void work(Reader reader) {
                ((Text) app.renderer.getItemFromReader(reader)).updateContentSize();
            }
        });

        app.client.actions.put(InAction.SET_TEXT_COLOR, new Action() {
            @Override
            public void work(Reader reader) {
                ((Text) app.renderer.getItemFromReader(reader)).setColor(reader.getInteger());
            }
        });

        app.client.actions.put(InAction.SET_TEXT_LINE_HEIGHT, new Action() {
            @Override
            public void work(Reader reader) {
                ((Text) app.renderer.getItemFromReader(reader)).setLineHeight(reader.getFloat());
            }
        });

        app.client.actions.put(InAction.SET_TEXT_FONT_FAMILY, new Action() {
            @Override
            public void work(Reader reader) {
                ((Text) app.renderer.getItemFromReader(reader)).setFontFamily(reader.getString());
            }
        });

        app.client.actions.put(InAction.SET_TEXT_FONT_PIXEL_SIZE, new Action() {
            @Override
            public void work(Reader reader) {
                ((Text) app.renderer.getItemFromReader(reader)).setFontPixelSize(reader.getFloat());
            }
        });

        app.client.actions.put(InAction.SET_TEXT_FONT_WORD_SPACING, new Action() {
            @Override
            public void work(Reader reader) {
                ((Text) app.renderer.getItemFromReader(reader)).setFontWordSpacing(reader.getFloat());
            }
        });

        app.client.actions.put(InAction.SET_TEXT_FONT_LETTER_SPACING, new Action() {
            @Override
            public void work(Reader reader) {
                ((Text) app.renderer.getItemFromReader(reader)).setFontLetterSpacing(reader.getFloat());
            }
        });

        app.client.actions.put(InAction.SET_TEXT_ALIGNMENT_HORIZONTAL, new Action() {
            @Override
            public void work(Reader reader) {
                ((Text) app.renderer.getItemFromReader(reader)).setAlignmentHorizontal(reader.getString());
            }
        });

        app.client.actions.put(InAction.SET_TEXT_ALIGNMENT_VERTICAL, new Action() {
            @Override
            public void work(Reader reader) {
                ((Text) app.renderer.getItemFromReader(reader)).setAlignmentVertical(reader.getString());
            }
        });

        app.client.actions.put(InAction.LOAD_FONT, new Action() {
            @Override
            public void work(Reader reader) {
                Text.loadFont(reader.getString(), reader.getString(), app);
            }
        });
    }

    private class Line {
        public int textStart;
        public int textEnd;
        public float width;
        public float y;
    }

    private static final FontMetrics fontMetrics = new FontMetrics();

    private static final HashMap<String, Float> alignment;
    static {
        alignment = new HashMap<>();
        alignment.put("top", 0f);
        alignment.put("center", 0.5f);
        alignment.put("bottom", 1f);
        alignment.put("left", 0f);
        alignment.put("right", 1f);
    };

    static final Paint paint = new Paint(Paint.ANTI_ALIAS_FLAG);
    static final HashMap<String, Typeface> fonts = new HashMap<>();

    public String text = "";
    public int color = Color.BLACK;
    public boolean wrap = false;
    public float lineHeight = 1;
    public String fontFamily = "";
    public float fontPixelSize;
    public float contentWidth = 0;
    public float contentHeight = 0;
    public float alignmentHorizontal = alignment.get("left");
    public float alignmentVertical = alignment.get("top");

    protected String linesText = "";
    protected ArrayList<Line> lines;
    protected int linesLength;
    protected String[] words;

    public static void loadFont(final String name, final String source, final MainActivity app){
        final Thread thread = new Thread(new Runnable() {
            @Override
            public void run() {
                if (source.startsWith("/static")){
                    fonts.put(name, Typeface.createFromAsset(app.getAssets(), source.substring(1)));
                    app.client.pushAction(OutAction.FONT_LOAD);
                    app.client.pushString(name);
                    app.client.pushBoolean(true);
                } else {
                    Log.e("JAVA", "Loading font's by URL is not currently supported");
                    app.client.pushAction(OutAction.FONT_LOAD);
                    app.client.pushString(name);
                    app.client.pushBoolean(false);
                }
            }
        });

        thread.start();
    }

    public Text(MainActivity app){
        super(app);
        this.lines = new ArrayList<>();
        this.fontPixelSize = app.renderer.dpToPx(14);
    }

    public void setText(String val){
        text = val;
        words = text.split(" ");
    }

    public void setWrap(boolean val){
        wrap = val;
    }

    public void setColor(int val){
        color = ColorUtils.RGBAtoARGB(val);
        invalidate();
    }

    public void setLineHeight(float val){
        lineHeight = val;
    }

    public void setFontFamily(String val){
        fontFamily = val;
    }

    public void setFontPixelSize(float val){
        fontPixelSize = app.renderer.dpToPx(val);
    }

    // TODO
    public void setFontWordSpacing(float val){

    }

    // TODO
    public void setFontLetterSpacing(float val){

    }

    public void setAlignmentHorizontal(String val){
        alignmentHorizontal = alignment.get(val);
        invalidate();
    }

    public void setAlignmentVertical(String val){
        alignmentVertical = alignment.get(val);
        invalidate();
    }

    public void updateContentSize(){
        linesLength = 0;
        linesText = text;

        if (words != null){
            updatePaint();
            paint.getFontMetrics(fontMetrics);

            final int linesArrayLength = lines.size();
            final int wordsLength = words.length;
            final float lineHeightPx = lineHeight * fontPixelSize;
            final float maxWidth = this.width;
            final float spaceWidth = paint.measureText(" ");
            final float fontTop = lineHeightPx - fontMetrics.descent;
            float x = 0, width = 0;
            float height = 0;
            int textPointer = 0, lineStart = 0, lineLength = 0;

            for (int i = 0; i <= wordsLength; i++){
                final String word = i < wordsLength ? words[i] : null;
                final int wordLength = word != null ? word.length() : 0;
                final float wordWidth = word != null ? paint.measureText(word) : 0;

                if (i > 0 && (i == wordsLength || (wrap && x + wordWidth > maxWidth))){
                    // get line object
                    final Line line;
                    if (linesArrayLength <= linesLength){
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
                    line.y = height + fontTop;

                    // clear
                    lineStart = textPointer;
                    lineLength = 0;
                    x = 0;

                    // next line
                    height += lineHeightPx;
                }

                x += wordWidth + spaceWidth;
                textPointer += wordLength + 1;
                lineLength += wordLength + 1;

                if (x > width){
                    width = x;
                }
            }

            contentWidth = width;
            contentHeight = height;
        } else {
            contentWidth = contentHeight = 0;
        }

        invalidate();

        // push data
        app.client.pushAction(OutAction.TEXT_SIZE);
        app.renderer.pushItem(this);
        app.client.pushFloat(app.renderer.pxToDp(contentWidth));
        app.client.pushFloat(app.renderer.pxToDp(contentHeight));
    }

    protected void updatePaint(){
        final Typeface font = fonts.get(fontFamily);
        if (font != null) {
            paint.setTypeface(font);
        } else {
            paint.setTypeface(Typeface.create(Typeface.SANS_SERIF, Typeface.NORMAL));
        }

        paint.setTextSize(fontPixelSize);
    }

    @Override
    protected void drawShape(final Canvas canvas, final int alpha){
        if (contentWidth <= 0 || contentHeight <= 0){
            return;
        }

        updatePaint();
        paint.setColor(color);
        paint.setAlpha(alpha);

        final float shiftY = (this.height - this.contentHeight) * alignmentVertical;

        for (int i = 0; i < linesLength; i++){
            final Line line = lines.get(i);

            canvas.drawText(linesText,
                    line.textStart, line.textEnd,
                    (this.width - line.width) * alignmentHorizontal, line.y + shiftY,
                    paint);
        }
    }
}

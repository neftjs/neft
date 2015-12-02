package io.neft.Renderer;

import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.Paint.FontMetrics;
import android.graphics.Typeface;
import android.util.Log;

import java.util.ArrayList;
import java.util.HashMap;

public class Text extends Item {
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

    public String text = "";
    public int color = Color.BLACK;
    public boolean wrap = false;
    public float lineHeight = 1;
    public float wordSpacing = 0;
    public float letterSpacing = 0;
    public String fontFamily = "";
    public float fontPixelSize;
    public float contentWidth = 0;
    public float contentHeight = 0;
    public float alignmentHorizontal = alignment.get("top");
    public float alignmentVertical = alignment.get("left");

    protected ArrayList<Line> lines;
    protected int linesLength;
    protected String[] words;

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

        renderer.actions.put(Renderer.InAction.SET_TEXT_WRAP, new Action() {
            @Override
            void work(Reader reader) {
                ((Text) reader.getItem()).setWrap(reader.getBoolean());
            }
        });

        renderer.actions.put(Renderer.InAction.UPDATE_TEXT_CONTENT_SIZE, new Action() {
            @Override
            void work(Reader reader) {
                ((Text) reader.getItem()).updateContentSize();
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

    public static void loadFont(final String name, final String source, final Renderer renderer){
        final Thread thread = new Thread(new Runnable() {
            @Override
            public void run() {
                if (source.startsWith("/static")){
                    fonts.put(name, Typeface.createFromAsset(renderer.mainActivity.getAssets(), source.substring(1)));
                    renderer.dirty = true;
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
        this.lines = new ArrayList<>();
        this.fontPixelSize = renderer.dpToPx(14);
    }

    public void setText(String val){
        text = val;
        words = text.split(" ");
    }

    public void setWrap(boolean val){
        wrap = val;
    }

    public void setColor(String val){
        color = Item.parseRGBA(val);
    }

    public void setLineHeight(float val){
        lineHeight = val;
    }

    public void setFontFamily(String val){
        fontFamily = val;
    }

    public void setFontPixelSize(float val){
        fontPixelSize = renderer.dpToPx(val);
    }

    // TODO
    public void setFontWordSpacing(float val){
//        wordSpacing = renderer.dpToPx(val);
    }

    // TODO
    public void setFontLetterSpacing(float val){
//        letterSpacing = renderer.dpToPx(val);
    }

    public void setAlignmentHorizontal(String val){
        alignmentHorizontal = alignment.get(val);
    }

    public void setAlignmentVertical(String val){
        alignmentVertical = alignment.get(val);
    }

    public void updateContentSize(){
        linesLength = 0;

        if (words != null){
            updatePaint();
            paint.getFontMetrics(fontMetrics);

            final int linesArrayLength = lines.size();
            final int wordsLength = words.length;
            final float lineHeightPx = lineHeight * fontPixelSize;
            final float maxWidth = this.width;
            final float spaceWidth = paint.measureText(" ");
            final float fontTop = -fontMetrics.ascent - fontMetrics.descent/3;
            float x = 0, width = 0;
            float height = fontTop;
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
                    line.y = height;

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
            contentHeight = height - fontTop;
        } else {
            contentWidth = contentHeight = 0;
        }

        // push data
        renderer.pushAction(Renderer.OutAction.TEXT_SIZE);
        renderer.pushItem(this);
        renderer.pushFloat(renderer.pxToDp(contentWidth));
        renderer.pushFloat(renderer.pxToDp(contentHeight));
    }

    protected void updatePaint(){
        Typeface font = fonts.get(fontFamily);
        if (font != null) {
            paint.setTypeface(font);
        } else {
            paint.setTypeface(Typeface.create(Typeface.SANS_SERIF, Typeface.NORMAL));
        }

        paint.setTextSize(fontPixelSize);
    }

    @Override
    protected void drawShape(Canvas canvas, int alpha){
        if (contentWidth <= 0 || contentHeight <= 0){
            return;
        }

        updatePaint();
        paint.setColor(color);
        paint.setAlpha(alpha);

        final float shiftY = (this.height - this.contentHeight) * alignmentVertical;

        for (int i = 0; i < linesLength; i++){
            final Line line = lines.get(i);

            canvas.drawText(text,
                    line.textStart, line.textEnd,
                    (this.width - line.width) * alignmentHorizontal, line.y + shiftY,
                    paint);
        }
    }
}

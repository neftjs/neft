package io.neft.Renderer;

import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.Path;

import io.neft.Client.Action;
import io.neft.Client.InAction;
import io.neft.Client.Reader;
import io.neft.MainActivity;
import io.neft.Utils.ColorUtils;

public class Rectangle extends Item {
    static void register(final MainActivity app) {
        app.client.actions.put(InAction.CREATE_RECTANGLE, new Action() {
            @Override
            public void work(Reader reader) {
                new Rectangle(app);
            }
        });

        app.client.actions.put(InAction.SET_RECTANGLE_COLOR, new Action() {
            @Override
            public void work(Reader reader) {
                ((Rectangle) app.renderer.getItemFromReader(reader)).setColor(reader.getInteger());
            }
        });

        app.client.actions.put(InAction.SET_RECTANGLE_RADIUS, new Action() {
            @Override
            public void work(Reader reader) {
                ((Rectangle) app.renderer.getItemFromReader(reader)).setRadius(reader.getFloat());
            }
        });

        app.client.actions.put(InAction.SET_RECTANGLE_BORDER_COLOR, new Action() {
            @Override
            public void work(Reader reader) {
                ((Rectangle) app.renderer.getItemFromReader(reader)).setBorderColor(reader.getInteger());
            }
        });

        app.client.actions.put(InAction.SET_RECTANGLE_BORDER_WIDTH, new Action() {
            @Override
            public void work(Reader reader) {
                ((Rectangle) app.renderer.getItemFromReader(reader)).setBorderWidth(reader.getFloat());
            }
        });
    }

    static final Paint paint = new Paint(Paint.ANTI_ALIAS_FLAG);

    public final Path path = new Path();
    public int color = Color.TRANSPARENT;
    public float radius = 0;
    public int borderColor = Color.TRANSPARENT;
    public float borderWidth = 0;

    public Rectangle(MainActivity app) {
        super(app);
    }

    protected void updatePath() {
        path.rewind();
        path.moveTo(radius, 0);
        path.lineTo(width - radius, 0);
        path.quadTo(width, 0, width, radius);
        path.lineTo(width, height - radius);
        path.quadTo(width, height, width - radius, height);
        path.lineTo(radius, height);
        path.quadTo(0, height, 0, height - radius);
        path.lineTo(0, radius);
        path.quadTo(0, 0, radius, 0);
    }

    @Override
    public void setWidth(float val) {
        super.setWidth(val);
        updatePath();
    }

    @Override
    public void setHeight(float val) {
        super.setHeight(val);
        updatePath();
    }

    public void setColor(int val) {
        color = ColorUtils.RGBAtoARGB(val);
        invalidate();
    }

    public void setRadius(float val) {
        radius = app.renderer.dpToPx(val);
        updatePath();
        invalidate();
    }

    public void setBorderColor(int val) {
        borderColor = ColorUtils.RGBAtoARGB(val);
        invalidate();
    }

    public void setBorderWidth(float val) {
        borderWidth = app.renderer.dpToPx(val);
        invalidate();
    }

    @Override
    protected void drawShape(final Canvas canvas, final int alpha) {
        paint.setAlpha(alpha);

        // fill
        paint.setStyle(Paint.Style.FILL);
        paint.setColor(color);
        canvas.drawPath(path, paint);

        // stroke
        if (borderWidth > 0) {
            paint.setStyle(Paint.Style.STROKE);
            paint.setColor(borderColor);
            paint.setStrokeWidth(borderWidth);
            canvas.drawPath(path, paint);
        }
    }
}

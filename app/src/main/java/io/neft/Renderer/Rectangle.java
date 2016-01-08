package io.neft.Renderer;

import android.annotation.TargetApi;
import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.Path;
import android.graphics.Typeface;
import android.os.Build;
import android.util.Log;
import android.util.TypedValue;
import android.view.View;
import android.view.ViewGroup;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import android.widget.TextView;

import io.neft.Renderer.Item;

public class Rectangle extends Item {
    static void register(Renderer renderer) {
        renderer.actions.put(Renderer.InAction.CREATE_RECTANGLE, new Action() {
            @Override
            void work(Reader reader) {
                new Rectangle(reader.renderer);
            }
        });

        renderer.actions.put(Renderer.InAction.SET_RECTANGLE_COLOR, new Action() {
            @Override
            void work(Reader reader) {
                ((Rectangle) reader.getItem()).setColor(reader.getInteger());
            }
        });

        renderer.actions.put(Renderer.InAction.SET_RECTANGLE_RADIUS, new Action() {
            @Override
            void work(Reader reader) {
                ((Rectangle) reader.getItem()).setRadius(reader.getFloat());
            }
        });

        renderer.actions.put(Renderer.InAction.SET_RECTANGLE_BORDER_COLOR, new Action() {
            @Override
            void work(Reader reader) {
                ((Rectangle) reader.getItem()).setBorderColor(reader.getInteger());
            }
        });

        renderer.actions.put(Renderer.InAction.SET_RECTANGLE_BORDER_WIDTH, new Action() {
            @Override
            void work(Reader reader) {
                ((Rectangle) reader.getItem()).setBorderWidth(reader.getFloat());
            }
        });
    }

    static final Paint paint = new Paint(Paint.ANTI_ALIAS_FLAG);

    public final Path path = new Path();
    public int color = Color.TRANSPARENT;
    public float radius = 0;
    public int borderColor = Color.TRANSPARENT;
    public float borderWidth = 0;

    public Rectangle(Renderer renderer) {
        super(renderer);
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
        color = Item.parseRGBA(val);
        invalidate();
    }

    public void setRadius(float val) {
        radius = renderer.dpToPx(val);
        updatePath();
        invalidate();
    }

    public void setBorderColor(int val) {
        borderColor = Item.parseRGBA(val);
        invalidate();
    }

    public void setBorderWidth(float val) {
        borderWidth = renderer.dpToPx(val);
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

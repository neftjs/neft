package io.neft.renderer;

import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.ColorFilter;
import android.graphics.Paint;
import android.graphics.Path;
import android.graphics.PixelFormat;
import android.graphics.Rect;
import android.graphics.drawable.Drawable;
import android.os.Build;
import android.view.View;

import io.neft.client.InAction;
import io.neft.client.annotation.OnAction;
import io.neft.utils.ColorValue;

import static android.graphics.Paint.Cap.SQUARE;

public class Rectangle extends Item {
    private static class RectDrawable extends Drawable {
        static final Paint PAINT = new Paint(Paint.ANTI_ALIAS_FLAG);

        static {
            PAINT.setStrokeCap(SQUARE);
        }

        private int alpha = 255;
        private final Path path = new Path();
        private int color = Color.TRANSPARENT;
        private float radius = 0;
        private int borderColor = Color.TRANSPARENT;
        private float borderWidth = 0;

        @Override
        protected void onBoundsChange(Rect bounds) {
            super.onBoundsChange(bounds);
            int width = bounds.width();
            int height = bounds.height();
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
        public void draw(Canvas canvas) {
            // fill
            PAINT.setStyle(Paint.Style.FILL);
            PAINT.setColor(color);
            PAINT.setColor(ColorValue.byAlpha(color, alpha));
            canvas.drawPath(path, PAINT);

            // stroke
            if (borderWidth > 0) {
                PAINT.setStyle(Paint.Style.STROKE);
                PAINT.setColor(ColorValue.byAlpha(borderColor, alpha));
                PAINT.setStrokeWidth(borderWidth);
                canvas.drawPath(path, PAINT);
            }
        }

        @Override
        public void setAlpha(int alpha) {
            this.alpha = alpha;
            invalidateSelf();
        }

        void setColor(int color) {
            this.color = color;
            invalidateSelf();
        }

        void setRadius(float radius) {
            this.radius = radius;
            invalidateSelf();
        }

        void setBorderColor(int color) {
            this.borderColor = color;
            invalidateSelf();
        }

        void setBorderWidth(float borderWidth) {
            this.borderWidth = borderWidth;
            invalidateSelf();
        }

        @Override
        public void setColorFilter(ColorFilter colorFilter) {}

        @Override
        public int getOpacity() {
            if (alpha == 255) {
                return PixelFormat.OPAQUE;
            }
            if (alpha == 0) {
                return PixelFormat.TRANSPARENT;
            }
            return PixelFormat.TRANSLUCENT;
        }
    }

    private final RectDrawable shape = new RectDrawable();

    @OnAction(InAction.CREATE_RECTANGLE)
    public static void create() {
        new Rectangle();
    }

    private Rectangle() {
        super();
        View rectangleView = new View(APP.getActivity().getApplicationContext());
        view.addView(rectangleView);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN) {
            rectangleView.setBackground(shape);
        } else {
            rectangleView.setBackgroundDrawable(shape);
        }
    }

    @OnAction(InAction.SET_RECTANGLE_COLOR)
    public void setColor(ColorValue val) {
        shape.setColor(val.getColor());
    }

    @OnAction(InAction.SET_RECTANGLE_RADIUS)
    public void setRadius(float val) {
        shape.setRadius(dpToPx(val));
    }

    @OnAction(InAction.SET_RECTANGLE_BORDER_COLOR)
    public void setBorderColor(ColorValue val) {
        shape.setBorderColor(val.getColor());
    }

    @OnAction(InAction.SET_RECTANGLE_BORDER_WIDTH)
    public void setBorderWidth(float val) {
        shape.setBorderWidth(dpToPx(val));
    }
}

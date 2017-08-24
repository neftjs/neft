package io.neft.renderer;

import android.graphics.Canvas;
import android.graphics.ColorFilter;
import android.graphics.Paint;
import android.graphics.Path;
import android.graphics.PixelFormat;
import android.graphics.Rect;
import android.graphics.drawable.Drawable;

import io.neft.client.InAction;
import io.neft.client.handlers.NoArgsActionHandler;
import io.neft.renderer.handlers.ColorItemActionHandler;
import io.neft.renderer.handlers.FloatItemActionHandler;
import io.neft.utils.ColorValue;
import io.neft.utils.ViewUtils;

import static android.graphics.Paint.Cap.SQUARE;

public class Rectangle extends Item {
    private static class RectDrawable extends Drawable {
        private final Paint fillPaint = new Paint(Paint.ANTI_ALIAS_FLAG);
        private final Paint strokePaint = new Paint(Paint.ANTI_ALIAS_FLAG);
        private final Path path = new Path();
        private float radius = 0;

        private RectDrawable() {
            super();

            fillPaint.setStyle(Paint.Style.FILL);
            fillPaint.setStrokeCap(SQUARE);

            strokePaint.setStyle(Paint.Style.STROKE);
            strokePaint.setStrokeCap(SQUARE);
        }

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
            canvas.drawPath(path, fillPaint);

            if (strokePaint.getStrokeWidth() > 0) {
                canvas.drawPath(path, strokePaint);
            }
        }

        @Override
        public void setAlpha(int alpha) {
        }

        @Override
        public void setColorFilter(ColorFilter colorFilter) {
            fillPaint.setColorFilter(colorFilter);
            strokePaint.setColorFilter(colorFilter);
        }

        @Override
        public int getOpacity() {
            return PixelFormat.OPAQUE;
        }
    }

    public static void register() {
        onAction(InAction.CREATE_RECTANGLE, new NoArgsActionHandler() {
            @Override
            public void accept() {
                new Rectangle();
            }
        });

        onAction(InAction.SET_RECTANGLE_COLOR, new ColorItemActionHandler<Rectangle>() {
            @Override
            public void accept(Rectangle item, ColorValue value) {
                item.setColor(value);
            }
        });

        onAction(InAction.SET_RECTANGLE_RADIUS, new FloatItemActionHandler<Rectangle>() {
            @Override
            public void accept(Rectangle item, float value) {
                item.setRadius(value);
            }
        });

        onAction(InAction.SET_RECTANGLE_BORDER_COLOR, new ColorItemActionHandler<Rectangle>() {
            @Override
            public void accept(Rectangle item, ColorValue value) {
                item.setBorderColor(value);
            }
        });

        onAction(InAction.SET_RECTANGLE_BORDER_WIDTH, new FloatItemActionHandler<Rectangle>() {
            @Override
            public void accept(Rectangle item, float value) {
                item.setBorderWidth(value);
            }
        });
    }

    private final RectDrawable shape = new RectDrawable();

    public Rectangle() {
        super();
        ViewUtils.setBackground(view, shape);
    }

    public void setColor(ColorValue val) {
        shape.fillPaint.setColor(val.getColor());
        shape.invalidateSelf();
    }

    public void setRadius(float val) {
        shape.radius = dpToPx(val);
        shape.invalidateSelf();
    }

    public void setBorderColor(ColorValue val) {
        shape.strokePaint.setColor(val.getColor());
        shape.invalidateSelf();
    }

    public void setBorderWidth(float val) {
        shape.strokePaint.setStrokeWidth(dpToPx(val));
        shape.invalidateSelf();
    }
}

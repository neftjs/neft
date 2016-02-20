package io.neft.Renderer;

import android.graphics.Canvas;
import android.graphics.Matrix;
import android.graphics.RectF;
import android.os.SystemClock;
import android.util.Log;
import android.view.MotionEvent;
import android.view.View;

import java.util.ArrayList;
import java.util.HashMap;

import io.neft.Client.Action;
import io.neft.Client.InAction;
import io.neft.Client.OutAction;
import io.neft.Client.Reader;
import io.neft.MainActivity;

public class NativeItem extends Item {
    abstract public static class NativeType {
        abstract public Item work(MainActivity app);
    }

    public static HashMap<String, NativeType> types = new HashMap<>();

    static void register(final MainActivity app) {
        app.client.actions.put(InAction.CREATE_NATIVE_ITEM, new Action() {
            @Override
            public void work(Reader reader) {
                final String ctor = reader.getString();
                final NativeType type = types.get(ctor);
                if (type == null) {
                    Log.w("Neft", "Native Item '" + ctor + "' type not found");
                    new NativeItem(app);
                } else {
                    type.work(app);
                }
            }
        });

        app.client.actions.put(InAction.ON_NATIVE_ITEM_POINTER_PRESS, new Action() {
            @Override
            public void work(Reader reader) {
                ((NativeItem) app.renderer.getItemFromReader(reader)).onPointerPress(reader.getFloat(), reader.getFloat());
            }
        });

        app.client.actions.put(InAction.ON_NATIVE_ITEM_POINTER_RELEASE, new Action() {
            @Override
            public void work(Reader reader) {
                ((NativeItem) app.renderer.getItemFromReader(reader)).onPointerRelease(reader.getFloat(), reader.getFloat());
            }
        });

        app.client.actions.put(InAction.ON_NATIVE_ITEM_POINTER_MOVE, new Action() {
            @Override
            public void work(Reader reader) {
                ((NativeItem) app.renderer.getItemFromReader(reader)).onPointerMove(reader.getFloat(), reader.getFloat());
            }
        });
    }

    public boolean autoWidth = true;
    public boolean autoHeight = true;
    protected View view;
    protected long invalidateDuration = 0;
    protected long onPointerPressInvalidateDuration = 0;
    protected long onPointerReleaseInvalidateDuration = 0;
    protected long onPointerMoveInvalidateDuration = 0;

    public NativeItem(MainActivity app) {
        super(app);
    }

    @Override
    public void setWidth(float val) {
        super.setWidth(val);
        this.autoWidth = val == 0;
        this.updateSize();
    }

    @Override
    public void setHeight(float val) {
        super.setHeight(val);
        this.autoHeight = val == 0;
        this.updateSize();
    }

    protected void updateSize() {
        if (view != null) {
            view.measure(app.view.getWidth(), app.view.getHeight());
            int width = autoWidth ? view.getMeasuredWidth() : Math.round(this.width);
            int height = autoHeight ? view.getMeasuredHeight() : Math.round(this.height);
            view.layout(0, 0, width, height);
            pushWidth(width);
            pushHeight(height);
        }
    }

    protected void pushWidth(float val) {
        if (autoWidth && this.width != val) {
            super.setWidth(val);
            app.client.pushAction(OutAction.NATIVE_ITEM_WIDTH);
            app.client.pushInteger(id);
            app.client.pushFloat(app.renderer.pxToDp(val));
        }
    }

    protected void pushHeight(float val) {
        if (autoHeight && this.height != val) {
            super.setHeight(val);
            app.client.pushAction(OutAction.NATIVE_ITEM_HEIGHT);
            app.client.pushInteger(id);
            app.client.pushFloat(app.renderer.pxToDp(val));
        }
    }

    protected void callTouchEventOnView(int type, float x, float y) {
        if (view != null) {
            MotionEvent event = MotionEvent.obtain(
                    SystemClock.uptimeMillis(),
                    SystemClock.uptimeMillis(),
                    type,
                    x,
                    y,
                    0
            );
            view.onTouchEvent(event);
        }
    }

    public void onPointerPress(float x, float y) {
        callTouchEventOnView(MotionEvent.ACTION_DOWN, x, y);
        if (onPointerPressInvalidateDuration > 0) {
            this.invalidateDuration = onPointerPressInvalidateDuration;
            invalidate();
        }
    }

    public void onPointerRelease(float x, float y) {
        callTouchEventOnView(MotionEvent.ACTION_UP, x, y);
        if (onPointerReleaseInvalidateDuration > 0) {
            this.invalidateDuration = onPointerReleaseInvalidateDuration;
            invalidate();
        }
    }

    public void onPointerMove(float x, float y) {
        callTouchEventOnView(MotionEvent.ACTION_MOVE, x, y);
        if (onPointerMoveInvalidateDuration > 0) {
            this.invalidateDuration = onPointerMoveInvalidateDuration;
            invalidate();
        }
    }

    @Override
    protected void measure(final Matrix globalMatrix, RectF viewRect, final ArrayList<RectF> dirtyRects, final boolean forceUpdateBounds) {
        super.measure(globalMatrix, viewRect, dirtyRects, forceUpdateBounds);
        if (invalidateDuration > 0) {
            this.invalidateDuration -= app.view.frameDelay;
            invalidate();
        }
    }

    @Override
    protected void drawShape(final Canvas canvas, final int alpha) {
        if (view != null) {
            view.draw(canvas);
        }
    }
}

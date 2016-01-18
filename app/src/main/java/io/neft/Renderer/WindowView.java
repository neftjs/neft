package io.neft.Renderer;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.Rect;
import android.graphics.RectF;
import android.util.AttributeSet;
import android.view.KeyEvent;
import android.view.MotionEvent;
import android.view.ViewGroup;

import io.neft.Client.Action;
import io.neft.Client.InAction;
import io.neft.Client.Reader;
import io.neft.MainActivity;

public class WindowView extends ViewGroup {
    public Item windowItem;
    public Renderer renderer;
    public final Rect canvasDirtyRect = new Rect();
    public final RectF dirtyRect = new RectF();

    static void register(final MainActivity app){
        app.client.actions.put(InAction.SET_WINDOW, new Action() {
            @Override
            public void work(Reader reader) {
                app.view.windowItem = app.renderer.getItemFromReader(reader);
            }
        });
    }

    public WindowView(Context context, AttributeSet attrs){
        super(context, attrs);

        this.setWillNotDraw(false);
        this.requestFocus();
    }

    @Override
    protected void onLayout(boolean changed, int l, int t, int r, int b){

    }

    @Override
    protected void onDraw(Canvas canvas){
        if (windowItem != null){
            canvas.getClipBounds(canvasDirtyRect);
            dirtyRect.set(canvasDirtyRect);
            windowItem.draw(canvas, 255, dirtyRect);

            // DEBUG
//            final Paint paint = new Paint();
//            paint.setStyle(Paint.Style.FILL);
//            paint.setColor(Color.argb(100, (int) (Math.random() * 100) + 155, (int) (Math.random() * 100), (int) (Math.random() * 100)));
//            canvas.drawRect(canvasDirtyRect, paint);
//            for (final RectF dirtyRect : renderer.dirtyRects) {
//                paint.setColor(Color.argb(100, (int) (Math.random() * 255), (int) (Math.random() * 255), (int) (Math.random() * 255)));
//                canvas.drawRect(dirtyRect, paint);
//            }
        }
    }

    @Override
    public boolean onTouchEvent(MotionEvent event){
        return renderer.device.onTouchEvent(event);
    }

    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event){
        return renderer.device.onKey(keyCode, event);
    }

    @Override
    public boolean onKeyUp(int keyCode, KeyEvent event){
        return renderer.device.onKey(keyCode, event);
    }

    @Override
    public boolean onKeyMultiple(int keyCode, int repeatCount, KeyEvent event){
        return renderer.device.onKey(keyCode, event);
    }

    @Override
    public boolean onKeyPreIme(int keyCode, KeyEvent event){
        return renderer.device.onKey(keyCode, event);
    }
}

package io.neft.Renderer;

import android.content.Context;
import android.graphics.Canvas;
import android.util.AttributeSet;
import android.util.Log;
import android.view.MotionEvent;
import android.view.View;

public class WindowView extends View {
    public Item windowItem;
    public Renderer renderer;

    static void register(Renderer renderer){
        renderer.actions.put(Renderer.InAction.SET_WINDOW, new Action() {
            @Override
            void work(Reader reader) {
                reader.renderer.window.windowItem = reader.getItem();
            }
        });
    }

    public WindowView(Context context, AttributeSet attrs){
        super(context, attrs);
    }

    @Override
    protected void onDraw(Canvas canvas){
        if (windowItem != null){
            windowItem.draw(canvas, 255);
        }
    }

    @Override
    public boolean onTouchEvent(MotionEvent event){
        final float pixelRatio = renderer.device.pixelRatio;

        switch (event.getAction()){
            case MotionEvent.ACTION_DOWN:
                renderer.pushAction(Renderer.OutAction.POINTER_PRESS);
                break;
            case MotionEvent.ACTION_UP:
                renderer.pushAction(Renderer.OutAction.POINTER_RELEASE);
                break;
            case MotionEvent.ACTION_MOVE:
                renderer.pushAction(Renderer.OutAction.POINTER_MOVE);
                break;
            default:
                return true;
        }

        renderer.pushFloat(event.getX() / pixelRatio);
        renderer.pushFloat(event.getY() / pixelRatio);

        return true;
    }
}

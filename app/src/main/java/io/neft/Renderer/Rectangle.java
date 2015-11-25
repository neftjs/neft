package io.neft.Renderer;

import android.annotation.TargetApi;
import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
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
    public int color = Color.TRANSPARENT;
    public float radius = 0;
    public int borderColor = Color.TRANSPARENT;
    public float borderWidth = 0;

    static final Paint paint = new Paint(Paint.ANTI_ALIAS_FLAG);

    static void register(Renderer renderer){
        renderer.actions.put(Renderer.InAction.CREATE_RECTANGLE, new Action() {
            @Override
            void work(Reader reader) {
                new Rectangle(reader.renderer);
            }
        });

        renderer.actions.put(Renderer.InAction.SET_RECTANGLE_COLOR, new Action() {
            @Override
            void work(Reader reader) {
                ((Rectangle) reader.getItem()).color = Item.colorFromString(reader.getString());
            }
        });

        renderer.actions.put(Renderer.InAction.SET_RECTANGLE_RADIUS, new Action() {
            @Override
            void work(Reader reader) {
                ((Rectangle) reader.getItem()).radius = reader.getFloat() * reader.renderer.device.pixelRatio;
            }
        });

        renderer.actions.put(Renderer.InAction.SET_RECTANGLE_BORDER_COLOR, new Action() {
            @Override
            void work(Reader reader) {
                ((Rectangle) reader.getItem()).borderColor = Item.colorFromString(reader.getString());
            }
        });

        renderer.actions.put(Renderer.InAction.SET_RECTANGLE_BORDER_WIDTH, new Action() {
            @Override
            void work(Reader reader) {
                ((Rectangle) reader.getItem()).borderWidth = reader.getFloat() * reader.renderer.device.pixelRatio;
            }
        });
    }

    public Rectangle(Renderer renderer){
        super(renderer);
    }

    @TargetApi(Build.VERSION_CODES.LOLLIPOP) // TODO
    @Override
    protected void drawShape(Canvas canvas, int alpha){
        paint.setAlpha(alpha);

        // fill
        paint.setStyle(Paint.Style.FILL);
        paint.setColor(color);
        canvas.drawRoundRect(0, 0, width, height, radius, radius, paint);

        // stroke
        paint.setStyle(Paint.Style.STROKE);
        paint.setColor(borderColor);
        paint.setStrokeWidth(borderWidth);
        canvas.drawRoundRect(0, 0, width, height, radius, radius, paint);
    }
}

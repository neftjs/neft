package io.neft.renderer;

import android.graphics.Rect;
import android.view.View;
import android.view.ViewGroup;
import android.widget.FrameLayout;

import io.neft.App;
import io.neft.client.InAction;
import io.neft.client.OutAction;
import io.neft.client.annotation.OnAction;

public class Item {
    @OnAction(InAction.CREATE_ITEM)
    public static void create() {
        new Item();
    }

    public final int id;
    protected Item background;
    private Rect clipRect;

    public ViewGroup view = new FrameLayout(App.getApp().view.getContext());

    public Item() {
        view.setLayoutParams(new FrameLayout.LayoutParams(0, 0));
        view.setClipChildren(false);
        this.id = App.getApp().renderer.items.size();
        App.getApp().renderer.items.add(this);
    }

    protected float dpToPx(float dp) {
        return App.getApp().renderer.dpToPx(dp);
    }

    protected float pxToDp(float px) {
        return App.getApp().renderer.pxToDp(px);
    }

    protected void pushAction(OutAction action, Object... args) {
        Object[] localArgs = new Object[args.length + 1];
        System.arraycopy(args, 0, localArgs, 1, args.length);
        localArgs[0] = id;
        App.getApp().client.pushAction(action, localArgs);
    }

    public void removeFromParent() {
        ViewGroup parent = (ViewGroup) view.getParent();
        if (parent != null) {
            parent.removeView(view);
        }
    }

    @OnAction(InAction.SET_ITEM_PARENT)
    public void setParent(Item val) {
        removeFromParent();
        if (val != null) {
            val.view.addView(view);
        }
    }

    @OnAction(InAction.INSERT_ITEM_BEFORE)
    public void insertBefore(Item val) {
        removeFromParent();
        ViewGroup parent = (ViewGroup) val.view.getParent();
        int index = parent.indexOfChild(val.view);
        parent.addView(view, index);
    }

    @OnAction(InAction.SET_ITEM_VISIBLE)
    public void setVisible(boolean val) {
        view.setVisibility(val ? View.VISIBLE : View.INVISIBLE);
    }

    @OnAction(InAction.SET_ITEM_CLIP)
    public void setClip(boolean val) {
        clipRect = val ? new Rect() : null;
        reloadClipBounds();
    }

    private void reloadClipBounds() {
        if (clipRect != null) {
            ViewGroup.LayoutParams params = view.getLayoutParams();
            clipRect.right = params.width;
            clipRect.bottom = params.height;
        }
        view.setClipBounds(clipRect);
    }

    @OnAction(InAction.SET_ITEM_WIDTH)
    public void setWidth(float val) {
        ViewGroup.LayoutParams params = view.getLayoutParams();
        params.width = Math.round(dpToPx(val));
        view.setLayoutParams(params);
        reloadClipBounds();
    }

    @OnAction(InAction.SET_ITEM_HEIGHT)
    public void setHeight(float val) {
        ViewGroup.LayoutParams params = view.getLayoutParams();
        params.height = Math.round(dpToPx(val));
        view.setLayoutParams(params);
        reloadClipBounds();
    }

    @OnAction(InAction.SET_ITEM_X)
    public void setX(float val) {
        view.setTranslationX(dpToPx(val));
    }

    @OnAction(InAction.SET_ITEM_Y)
    public void setY(float val) {
        view.setTranslationY(dpToPx(val));
    }

    @OnAction(InAction.SET_ITEM_SCALE)
    public void setScale(float val) {
        view.setScaleX(val);
        view.setScaleY(val);
    }

    @OnAction(InAction.SET_ITEM_ROTATION)
    public void setRotation(float val) {
        view.setRotation((float) Math.toDegrees(val));
    }

    @OnAction(InAction.SET_ITEM_OPACITY)
    public void setOpacity(int val) {
        view.setAlpha(val / 255f);
    }

    @OnAction(InAction.SET_ITEM_BACKGROUND)
    public void setBackground(Item val) {
        if (background != null) {
            background.removeFromParent();
            background = null;
        }
        if (val != null) {
            background = val;
            view.addView(val.view, 0);
        }
    }

    @OnAction(InAction.SET_ITEM_KEYS_FOCUS)
    public void setKeysFocus(boolean val) {

    }
}

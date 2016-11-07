package io.neft.renderer;

import android.content.Context;
import android.graphics.Color;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.widget.HorizontalScrollView;
import android.widget.RelativeLayout;
import android.widget.ScrollView;

import io.neft.App;
import io.neft.client.InAction;
import io.neft.client.annotation.OnAction;

public class Scrollable extends Item {
    private static class ScrollableView extends ScrollView {
        private HorizontalScrollView hScroll;

        public ScrollableView(Context context) {
            super(context);

            setLayoutParams(new LayoutParams(
                    ViewGroup.LayoutParams.MATCH_PARENT,
                    ViewGroup.LayoutParams.MATCH_PARENT
            ));

            hScroll = new HorizontalScrollView(context);
            hScroll.setLayoutParams(new LayoutParams(
                    ViewGroup.LayoutParams.MATCH_PARENT,
                    ViewGroup.LayoutParams.WRAP_CONTENT
            ));
            addView(hScroll);
        }

        @Override
        public boolean onTouchEvent(MotionEvent event) {
            super.onTouchEvent(event);
            hScroll.dispatchTouchEvent(event);
            return true;
        }

        @Override
        public boolean onInterceptTouchEvent(MotionEvent event) {
            super.onInterceptTouchEvent(event);
            hScroll.onInterceptTouchEvent(event);
            return true;
        }

        void addContentView(View view) {
            hScroll.addView(view);
        }
    }

    @OnAction(InAction.CREATE_SCROLLABLE)
    public static void create() {
        new Scrollable();
    }

    public Item contentItem;
    private ScrollableView scrollableView = new ScrollableView(App.getApp().getApplicationContext());

    public Scrollable() {
        super();
        view.addView(scrollableView);
        view.setLayerType(View.LAYER_TYPE_HARDWARE, null);
    }

    @OnAction(InAction.SET_SCROLLABLE_CONTENT_ITEM)
    public void setContentItem(Item item) {
        if (contentItem != null) {
            contentItem.removeFromParent();
            contentItem = null;
        }
        if (item != null) {
            scrollableView.addContentView(item.view);
        }
    }

    @OnAction(InAction.SET_SCROLLABLE_CONTENT_X)
    public void setContentX(float val) {
    }

    @OnAction(InAction.SET_SCROLLABLE_CONTENT_Y)
    public void setContentY(float val) {
    }

    @OnAction(InAction.ACTIVATE_SCROLLABLE)
    public void activate() {
    }
}

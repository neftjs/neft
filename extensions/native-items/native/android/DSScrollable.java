package io.neft.extensions.nativeitems;

import android.content.Context;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.view.ViewTreeObserver;
import android.widget.HorizontalScrollView;
import android.widget.ScrollView;

import io.neft.App;
import io.neft.renderer.Item;
import io.neft.renderer.NativeItem;
import io.neft.renderer.annotation.OnCreate;
import io.neft.renderer.annotation.OnSet;

public class DSScrollable extends NativeItem {
    private static class ScrollableView extends ScrollView {
        private DSScrollable scrollable;
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

            getViewTreeObserver().addOnScrollChangedListener(new ViewTreeObserver.OnScrollChangedListener() {
                @Override
                public void onScrollChanged() {
                    float scrollY = scrollable.pxToDp(getScrollY());
                    scrollable.pushEvent("contentYChange", scrollY);
                }
            });

            hScroll.getViewTreeObserver().addOnScrollChangedListener(new ViewTreeObserver.OnScrollChangedListener() {
                @Override
                public void onScrollChanged() {
                    float scrollX = scrollable.pxToDp(getScrollX());
                    scrollable.pushEvent("contentXChange", scrollX);
                }
            });
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

    public Item contentItem;

    @OnCreate("DSScrollable")
    public DSScrollable() {
        super(new ScrollableView(App.getApp().getApplicationContext()));
        getItemView().scrollable = this;
    }

    private ScrollableView getItemView() {
        return (ScrollableView) itemView;
    }

    @OnSet("contentItem")
    public void setContentItem(Item val) {
        if (contentItem != null) {
            contentItem.removeFromParent();
            contentItem = null;
        }
        if (val != null) {
            getItemView().addContentView(val.view);
        }
    }

    @OnSet("contentX")
    public void setContentX(int val) {
        getItemView().hScroll.scrollTo(val, 0);
    }

    @OnSet("contentY")
    public void setContentY(int val) {
        getItemView().scrollTo(0, val);
    }
}
